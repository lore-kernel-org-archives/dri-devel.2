Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5E0C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAACA10EE7B;
	Tue, 22 Sep 2026 21:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bsU1qxTU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D3610EE7B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:04:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E0E743BB5;
 Tue, 22 Sep 2026 21:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEEE1F000FF;
 Tue, 22 Sep 2026 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111092;
 bh=OaeneyI6sfV1XGsKcM94D0nABN9D+XoT6Jio61cPAAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bsU1qxTUnH7Tcj6mOvvQtN1MMkFD+Du4CuRkBoB9iYIhXHSXlzje9SH7caJHCcm9X
 1jmWo3HwEXFE29H0W9cv8Ym22HX/OjbkwlG4qgKyU43J5xi80Eq5dYbPTuLWFPYtdC
 bI9MPahw5cnR/FDCaUGfgVWH3rfl1QwwgWBG0yfeGyAJ2T8uBzEt7HiJyUHFLO3b4q
 unmaiFwYeuuhRH39Q4aCzQOdHLZAgQuRDKjBprOfAeK7mbIKCPf1rc8MciujyQgvr5
 joJ8wHWJvR36fBEu8Pq2DNlHeasSP2JsYpTYqm3cc8paPOFPKH+ilHgvpaKhAPo3eY
 yjI7HT+heRWpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/27] drm/panthor: Route arbitration events
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-18-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-18-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:04:51 +0000
Message-Id: <20260922210452.1CEEE1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/panthor: UAF in arbitration IRQ handlers due to devres ordering
--

commit 35b5829f1e7e37f44df0de386a8d626358959c51
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Route arbitration events

This commit wires the resource-group, scheduler, and partition-control bloc=
ks
together. It routes resource-group messages and partition reset events to t=
he
scheduler, and adds callbacks for granting, yielding, and closing partition
windows.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.=
c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> index 2d0c8d95f1abd..723cf605e16a3 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> @@ -95,20 +95,42 @@ static int panthor_arbitration_runtime_resume(struct =
device *dev)
>  	return 0;
>  }
> =20
> +/* AW to Arbiter events */
> +int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 =
aw_id)
> +{
> +	/* TODO: AW to PC assignment */
> +	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
> +}

[Severity: High]
Does this introduce a use-after-free risk during driver teardown if a
pending interrupt fires?

In panthor_arbitration_probe(), the driver registers rg_irq_raw_handler and=
=20
partition_irq_raw_handler using devm_request_irq() inside=20
panthor_resource_group_init() before the sched structures are allocated usi=
ng
devm_kzalloc() in panthor_arbitration_sched_init().

Because devres releases resources in LIFO order on probe failure or driver=
=20
removal, the scheduler memory is freed before the IRQs are unregistered.=20

If an interrupt fires or is pending during this teardown window, the active=
=20
handler can route the event to panthor_arbitration_on_request(), which will=
=20
dereference the already-freed adev->sched[0] pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D17
