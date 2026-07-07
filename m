Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6D4C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA3610ED95;
	Tue,  7 Jul 2026 14:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mo8ZO5NG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299E510ED93
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:18:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD64443AED;
 Tue,  7 Jul 2026 14:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866F91F00A3D;
 Tue,  7 Jul 2026 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433924;
 bh=OSMxNNQrll/h/VipFog0YCHXyPOlUPODlWL38UWL5Yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mo8ZO5NGEymSpcmEiEqid3IfzVSr6dI1O7wDKTwxEueh3ogQp2dmv7Q3DP4rdy7F1
 4IworN7YYU7oNbz640ei0SV+CxRKp8r4gUWVPOJW4LrVg6jQPnGPzLhLbfAWSfV29z
 fmzv6vvgfaZDo5M4qo5vFJ9yIJ4V2ROLsB05Uid4tVtfHXEgsGVeZI2kFnYDmzUHH4
 EH+1q0PHntkRXfWvObYUzsrkFHqUHGBhHsB+6mKfXk7s9YkdCuq/EyKUytIiIkEDgJ
 TpOvj8WK5yFGK1iRnTkjdwLrcMZhuUKZbaIAkxeDuL8Xn52hWobTSZzDwBFxE710U1
 YoF0SvOy3ZxTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] drm/nouveau: Implement
 vga_switcheroo_client_ops.pre_switch
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707135724.247562-8-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:18:44 +0000
Message-Id: <20260707141844.866F91F00A3D@smtp.kernel.org>
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

New issues:
- [High] New AB-BA deadlock introduced between vgasr_mutex and clientlist_m=
utex.

Pre-existing issues:
- [High] Preexisting AB-BA deadlock between vgasr_mutex and console_lock.
--

--- Patch [7]: [PATCH 07/10] drm/nouveau: Implement vga_switcheroo_client_o=
ps.pre_switch ---
commit a0ca13a7165f71c977582a84acf58b2f2681a805
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch

This patch implements the vga_switcheroo_client_ops.pre_switch callback in
the nouveau driver. It calls drm_client_dev_acquire_outputs() from the
pre_switch callback to push fbcon updates from vga_switcheroo into DRM's
fbdev emulation.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouv=
eau/nouveau_vga.c
> index a6c375a241542..2d2d08be8fbe2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -76,11 +76,20 @@ nouveau_switcheroo_can_switch(struct pci_dev *pdev)
>  	return atomic_read(&drm->dev->open_count) =3D=3D 0;
>  }
> =20
> +static void
> +nouveau_switcheroo_pre_switch(struct pci_dev *pdev)
> +{
> +	struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
> +
> +	drm_client_dev_acquire_outputs(drm->dev);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this introduce an AB-BA deadlock between vgasr_mutex and
clientlist_mutex?

When drm_client_dev_hotplug() is called, it acquires dev->clientlist_mutex
and eventually calls register_framebuffer(). This takes the console_lock()
and then calls vga_switcheroo_client_fb_set(), taking vgasr_mutex. This
establishes the lock order:
clientlist_mutex -> console_lock -> vgasr_mutex

However, vga_switcheroo_debugfs_write() acquires vgasr_mutex and calls
vga_switchto_stage2(), which invokes this new pre_switch callback.
Calling drm_client_dev_acquire_outputs() here attempts to acquire
dev->clientlist_mutex, establishing the reverse lock order:
vgasr_mutex -> clientlist_mutex

[Severity: High]
This is a pre-existing issue, but does this path also trigger a deadlock
between vgasr_mutex and console_lock?

When register_framebuffer() is called (e.g., during driver probe or
hotplug), it calls fbcon_fb_registered(), which acquires console_lock()
and then calls vga_switcheroo_client_fb_set(), taking vgasr_mutex.

Conversely, vga_switcheroo_debugfs_write() acquires vgasr_mutex and calls
vga_switchto_stage2(). This invokes pre_switch(), which leads to
drm_client_dev_acquire_outputs() and then fb_switch_outputs(), attempting
to acquire console_lock(). This creates an exact inversion:
vgasr_mutex -> console_lock

> +}
> +
>  static const struct vga_switcheroo_client_ops
>  nouveau_switcheroo_ops =3D {
>  	.set_gpu_state =3D nouveau_switcheroo_set_state,
>  	.reprobe =3D nouveau_switcheroo_reprobe,
>  	.can_switch =3D nouveau_switcheroo_can_switch,
> +	.pre_switch =3D nouveau_switcheroo_pre_switch,
>  };
> =20
>  void

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135724.2475=
62-1-tzimmermann@suse.de?part=3D7
