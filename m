Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257FECC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816311124E7;
	Thu, 15 Oct 2026 21:57:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF271124E7
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:57:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B45BF60A57;
 Thu, 15 Oct 2026 21:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A251F000C5;
 Thu, 15 Oct 2026 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792101421;
 bh=NbZTgO0lwioKg8lD1Vh+Hx9u9CbjA7w1QO0aGHqLj7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DP3QU+YrnIBlnKl0GEr7BBbMZt9DeEy8/4sta0dxmgjlTHJQky78Mf6BtP04Rc2jg
 /JcpSSoNnzQ5WwFBwefuivTNlQVrXI3xND7MTEzq7Zrji5WpE1k2q8fQ2jc72MOhZe
 5xeXW+8f6MTMmD24/Mq4baIFJP0YQabHyoKwxxpii2LwENEtR6g4qRt4A+gA1WDvJg
 WEe+pWTQ0lSw/COeRW7GOHi55JdKTAiX/eLkVRT/SFtvxAz3WYpVavRJ42TbuHbC62
 TyWQ5R5a3yxImGkpfU8FnV8TQL/qiSdxy4o1bNdUR3K5/M78Nz/THWnjCm/LtuP4Yj
 FY38fHR4y6L9g==
Message-ID: <sashiko-outbox-173438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/appletbdrm: Add suspend and resume support
To: "Vasilij Markin" <vasilij.kernel@tototo.si>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-appletbdrm-pm-v3-1-47377176619a@tototo.si>
References: <20261015-appletbdrm-pm-v3-1-47377176619a@tototo.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 21:57:00 +0000
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
- [Medium] drm/tiny/appletbdrm: memory leak of info buffer on appletbdrm_se=
nd_msg error
- [Medium] drm/appletbdrm: coordinate underflow on resume if device dimensi=
ons shrink
--

commit e4d6246ec3eb92963562077b451503c3ef907475
Author: Vasilij Markin <vasilij.kernel@tototo.si>
Subject: drm/appletbdrm: Add suspend and resume support

The driver has no USB power management callbacks, so the USB core unbinds
it before system suspend and binds it again on resume. This commit
implements suspend and resume with drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume() so the device stays registered and the
last committed state is restored on resume.

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index 4297d9c1125e4..350dc598c9e7c 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
[ ... ]
> @@ -821,6 +822,48 @@ static void appletbdrm_shutdown(struct usb_interface=
 *intf)
>  	drm_atomic_helper_shutdown(&adev->drm);
>  }
> =20
[ ... ]
> +static int appletbdrm_reset_resume(struct usb_interface *intf)
> +{
> +	struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +	struct drm_device *drm =3D &adev->drm;
> +	int ret, resume_ret;
> +
> +	/*
> +	 * A reset puts the device back into its initial state, where it
> +	 * expects the same handshake as during probe. Resume the DRM side
> +	 * even if the handshake fails, so that the state saved on suspend
> +	 * is released.
> +	 */
> +	ret =3D appletbdrm_get_information(adev);

[Severity: Medium]
This problem wasn't introduced by this patch, but calling
appletbdrm_get_information() here on every system resume can trigger a memo=
ry
leak if the USB device fails to handshake correctly:

drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_get_information() {
	...
	info =3D kzalloc_obj(*info);
	if (!info)
		return -ENOMEM;

	ret =3D appletbdrm_send_msg(adev, APPLETBDRM_MSG_GET_INFORMATION);
	if (ret)
		return ret; /* Leaks info */
	...
}

Can this cause repeated memory leaks if the device frequently fails to wake?

[Severity: Medium]
If a buggy or malicious USB device returns smaller display dimensions during
this handshake, appletbdrm_get_information() updates the device dimensions:

drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_get_information() {
	...
	adev->width =3D get_unaligned_le32(&info->width);
	adev->height =3D get_unaligned_le32(&info->height);
	...
}

When the DRM core subsequently commits the suspended atomic state, it uses =
the
old damage rectangles which are clamped to the pre-suspend mode bounds. This
can cause an integer underflow in appletbdrm_flush_damage():

drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_flush_damage() {
	...
	frame->begin_y =3D cpu_to_le16(adev->height - damage.x2);
	...
}

Because damage.x2 can now be larger than the newly updated adev->height, th=
is
could underflow and send huge out-of-bounds coordinates to the USB device.
Should the new dimensions be validated against the existing mode bounds bef=
ore
applying them?

> +	if (ret) {
> +		drm_err(drm, "Failed to get display information\n");
> +		goto resume;
> +	}
> +
> +	ret =3D appletbdrm_signal_readiness(adev);
> +	if (ret)
> +		drm_err(drm, "Failed to signal readiness\n");
> +
> +resume:
> +	resume_ret =3D drm_mode_config_helper_resume(drm);
> +
> +	return ret ? ret : resume_ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-appletbdrm=
-pm-v3-1-47377176619a@tototo.si?part=3D1
