Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FEC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E762110EA8F;
	Mon, 28 Sep 2026 13:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LqziNhYl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B2A10EA8F
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:57:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0559433B3;
 Mon, 28 Sep 2026 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C921F000FF;
 Mon, 28 Sep 2026 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603826;
 bh=X1zXfVX6V1jqaKjIDcNUEzl/ZYHkZ662gVxj4geiVYo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LqziNhYlPwQzIR+u6FFhDUZ/dMED8JFOmwFxW9ExZLKfyVcLvq/OZQ2DwbW4+nVG5
 nsPkJLEzt0UwOJdU+L4ZnJEmj78qaoa+VHVojcZngEQqPPSUWQ1GpLco5eycYEamjZ
 GXRh0QudjBzhzrS80hxAUXNHGmJzCT+BUKen6yv0a89GCxgHU5Cpr6NRa/4/EECNAo
 JbAgpAEH8/FOPHIN9BQJknjHO/bxEFw9dZrQ3nDqFOP7zCWk2CWkY1vmRicgjBywo2
 uxHD8+QDHdIASD/9z2GXaW4OFnDd8R5Q6z/lEXxabjiaZpFdD5u/k2WoOC/qELvaKJ
 pQk7bEeG35mhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: drain GEM timer and work on teardown
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260928134100.420-1-getshell@seu.edu.cn>
References: <20260928134100.420-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:57:06 +0000
Message-Id: <20260928135706.A2C921F000FF@smtp.kernel.org>
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
- [Medium] drm/vc4: memory leak of vc4_exec_info due to unhandled job_done_=
list
--

commit 789f23627b59e9b2f1e7e763001ed796ee2df14b
Author: Hongyan Xu <getshell@seu.edu.cn>

drm/vc4: drain GEM timer and work on teardown

This commit updates vc4_gem_destroy() to shut down the hangcheck timer and
cancel both the hangcheck reset work and the job done work before destroying
the GEM state. This prevents asynchronous callbacks from executing after
the device structure has been released.

> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -1202,6 +1202,10 @@ static void vc4_gem_destroy(struct drm_device *dev=
, void *unused)
>  {
>  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> =20
> +	timer_shutdown_sync(&vc4->hangcheck.timer);
> +	cancel_work_sync(&vc4->hangcheck.reset_work);
> +	cancel_work_sync(&vc4->job_done_work);

[Severity: Medium]
In drivers/gpu/drm/vc4/vc4_gem.c:vc4_gem_destroy(), if there are completed
jobs waiting in vc4->job_done_list when this executes, does cancelling the
work here strand those jobs?

Since the scheduled cleanup work is cancelled and will not run, and
vc4_gem_destroy() does not manually flush or process job_done_list
afterwards, it seems any vc4_exec_info objects left in the list and their
associated GEM objects will be permanently leaked.

> +
>  	/* Waiting for exec to finish would need to be done before
>  	 * unregistering V3D.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928134100.420-=
1-getshell@seu.edu.cn?part=3D1
