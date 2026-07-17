Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D032EC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A07F10E48C;
	Fri, 17 Jul 2026 14:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WI0ltmdL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D1810E48C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:43:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0904260A59
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922591F00A3A;
 Fri, 17 Jul 2026 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299432;
 bh=Nc02zz+yEkWR9vzpJYBHA7+8LKOx7YR6rQbfN7UhYFQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WI0ltmdLvHY7qqMAvKRAkDImoC/8dImgY6g8/urqsOCTPFIq1nTzfdECJFtSN/IH7
 lniO0t/CqWdwU//Dhbf/UPIuqAALW5YbuzQq9ArzGsNh4oH3Evh2Gdi9y6kfmRJ9Ri
 sH4toFNFB/s5XRrdi4bOYC1IGXrDKno35gRlTQSU9IWYWB3WyeuV5Bk3PcPTHTPCT1
 Vgrp2h3LlITtoi0YKyKPin3DLkjnfJbep8PiKL/4FAeTVZlI0fTSnceRqTlsgDfezr
 fe4oTUjXcMAouH7PT0aZDNbjMiKrqZ3ROtesVWKj5DsJwDCndUYPoenSTohwNq4fTh
 6EsQGOp7RVK6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe
 failure
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717143119.1815106-2-johan@kernel.org>
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:43:52 +0000
Message-Id: <20260717144352.922591F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The device can be left permanently powered on if the driver is unb=
ound while an asynchronous autosuspend is pending.
--

--- Patch [1]: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe =
failure ---
commit 471fbc83c1856bd9eec16a225d0ec84f3032c113
Author: Johan Hovold <johan@kernel.org>

drm/panel-edp: fix i2c adapter leak on probe failure

This commit fixes a reference leak on an i2c adapter during probe failure
or driver unbind. It introduces a devres action to automatically drop the
adapter reference, streamlining the cleanup path and removing manual puts.

Link: https://lore.kernel.org/r/CAD=3DFV=3DVZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0O=
uNL79wNZPxRg@mail.gmail.com

> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index f66474d3ef65e..775bd6af31ae7 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c

[ ... ]

> @@ -983,8 +992,6 @@ static void panel_edp_remove(struct device *dev)
> =20
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);

[Severity: High]
This is a pre-existing issue, but does this sequence leave the device
permanently powered on if unbound while an autosuspend is pending?

During probe, pm_runtime_get_sync() is followed by
pm_runtime_put_autosuspend() (e.g., in generic_edp_panel_probe()), leaving
the device in RPM_ACTIVE for 1000ms. If the driver is unbound before this
timer fires, pm_runtime_disable() cancels the pending autosuspend work
without suspending the device.

This can leave the panel regulators and GPIOs permanently enabled, and
trigger a kernel WARN_ON from devres during regulator_put() due to an
unbalanced enable count. Should there be a synchronous suspend call prior
to disabling runtime PM in the removal path?

> -	if (panel->ddc && (!panel->aux || panel->ddc !=3D &panel->aux->ddc))
> -		put_device(&panel->ddc->dev);
> =20
>  	drm_edid_free(panel->drm_edid);
>  	panel->drm_edid =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717143119.1815=
106-1-johan@kernel.org?part=3D1
