Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54611CD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA9710E70B;
	Mon, 15 Jun 2026 20:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ir17i+uW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6512D10E70B
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0FCC60137;
 Mon, 15 Jun 2026 20:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C6E1F000E9;
 Mon, 15 Jun 2026 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781556113;
 bh=oBrIL6dLRZR5+rSnZGF/lNBopruvX9pj8rnd5vHKThk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ir17i+uWtdwhHqxBfqu4lBcsDCxg0SB8AIVF6upAQOZBpe733t3P5oTlPcISDuswE
 pY/nP5Mp9xO4qo3h2NtMD/NBD3PQm7Uj/YPbT9ZGfwholsSu81QkNcURe/Aw+/4EYZ
 uGkbVeXyL249P8bxqbnPtp3FpjMBeYtI3TzD11vDg35mIbiBqQra0zJhXcUbzgdtrI
 cAC9Tb8P8mc11CfhxTr/c37c1+roWgg+/PToh/lDwdyEeFBiVZRNxZVNKW0acSmroy
 jnV5RxEQrOQvjqYJUUsox4LaqForKSC25j3JtREUMEJBsgPa48Caxjsvdd3pJotPQ4
 W6u3eVl1RWyqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/27] drm/xe/display: Prefer not to allocate a
 framebuffers in stolen memory
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-28-dev@lankhorst.se>
References: <20260615201846.307297-28-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:41:52 +0000
Message-Id: <20260615204153.59C6E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete PREEMPT_RT restriction and misleading diagnostic log =
for stolen framebuffers.
- [Low] The `IS_DGFX(xe)` check within `xe_display_bo_fbdev_prefer_stolen()=
` is dead code.
--

commit a0d8e97afbc7423ba7650eec1d396883f1234659
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/xe/display: Prefer not to allocate a framebuffers in stolen memory

For the same reasons as using stolen memory for DPT, it's also a bad
idea for framebuffers. Allocate new framebuffers always in system memory
when we don't inherit them, and prohibit inheriting stolen framebuffers
when CONFIG_PREEMPT_RT is enabled.

> diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm=
/xe/display/xe_display_bo.c
> index 7fbac223b0977..5b54d247cb212 100644
> --- a/drivers/gpu/drm/xe/display/xe_display_bo.c
> +++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
> @@ -127,7 +127,7 @@ bool xe_display_bo_fbdev_prefer_stolen(struct xe_devi=
ce *xe, unsigned int size)
>  	if (!stolen)
>  		return false;
> =20
> -	if (IS_DGFX(xe))
> +	if (IS_DGFX(xe) || IS_ENABLED(CONFIG_PREEMPT_RT))

[Severity: Medium]
Will this RT restriction be bypassed if fbcon or fbdev emulation are disabl=
ed?

Looking at the only caller, initial_plane_bo() in
drivers/gpu/drm/xe/display/xe_initial_plane.c:

    if (IS_ENABLED(CONFIG_FRAMEBUFFER_CONSOLE) &&
        IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
        !xe_display_bo_fbdev_prefer_stolen(xe, plane_config->size)) {
            drm_info(&xe->drm, "Initial FB size exceeds half of stolen, dis=
carding\n");
            return NULL;
    }

If a PREEMPT_RT kernel is built without fbcon or fbdev emulation, the
condition short-circuits, the RT check is skipped, and it appears the
driver would incorrectly proceed to inherit the stolen framebuffer.

Additionally, if the RT restriction does trigger, it will unconditionally
print "Initial FB size exceeds half of stolen, discarding". Is this
misleading when the rejection is actually due to RT constraints?

[Severity: Low]
Is the IS_DGFX(xe) check now dead code?

The patch removes the usage of xe_display_bo_fbdev_prefer_stolen() from
xe_display_bo_fbdev_create(), leaving initial_plane_bo() as its only
caller. Since initial_plane_bo() already guards against discrete graphics
before making the function call:

    if (IS_DGFX(xe)) {
        ...
    } else {
        ...
        if (IS_ENABLED(CONFIG_FRAMEBUFFER_CONSOLE) &&
            IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
            !xe_display_bo_fbdev_prefer_stolen(xe, plane_config->size)) {

IS_DGFX(xe) appears to be guaranteed false whenever
xe_display_bo_fbdev_prefer_stolen() is executed.

>  		return false;
> =20
>  	if (XE_DEVICE_WA(xe, 22019338487_display))

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D27
