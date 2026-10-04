Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0998CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2154C10E0CF;
	Sun,  4 Oct 2026 12:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eFZgM842";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942AA10E0CF
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 12:19:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1683041805;
 Sun,  4 Oct 2026 12:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A41F00893;
 Sun,  4 Oct 2026 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791116352;
 bh=uH+iohQG5RvyjWKpd0GYgx+xVnXKDKzoFMGOOTgn6rk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eFZgM842jdJcvWp7v7GWtzAPt/Z5594+uLYX3mWaFN9t/Jq18+L2MiMWmcmge9DCB
 O4EQxL1Btw0Qkx1O8HHl7o+ww+yjCdRVqXNTAH0X5ekqDy+dseVq8+6JJg0xB3byYZ
 pTMDMAqa0fcXhjiGqJxsCkaH2h6HVXW+JO0KsJ1DT36oF0NQ4pokvhfotbASyu6qjl
 YQwPaD+l4tnPC1bA0SrQdU8JsRUJ9UX7Hhr9BvP7rFZ0EvPo8fNV8nPCK/GnyM15VE
 bNIojdK1iFq2z3ZwOp6GwbjRnbByFlA5HLGJYQsxmmh/alxQfSsLtm5C/YnRWM25Vz
 jnHSY8BNZVHug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/appletbdrm: Add suspend and resume support
To: "Aditya Garg" <aditya.garg@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
References: <20260924-appletbdrm-pm-v1-1-0e5432132161@tototo.si>
 <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:19:11 +0000
Message-Id: <20261004121911.CE6A41F00893@smtp.kernel.org>
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
- [Medium] drm/appletbdrm: memory leak of suspend_state on unbind
- [Medium] drm/appletbdrm: missing reset_resume handler breaks reset recove=
ry
--

commit c3fac1e92efd5498a32a50fb4e9a862ae7b24e77
Author: Vasilij Markin <vasilij.kernel@tototo.si>

drm/appletbdrm: Add suspend and resume support

The driver has no USB power management callbacks, so the USB core
unbinds it before system suspend and binds it again on resume. The DRM
device is unregistered and registered again on every suspend and resume
cycle, userspace driving the Touch Bar through it (such as tiny-dfr)
loses its device, and the Touch Bar stays dark after resume.

> Implement suspend and resume with drm_mode_config_helper_suspend() and
> drm_mode_config_helper_resume(), so the device stays registered and the
> last committed state is restored on resume. If the device was reset
> while suspended, repeat the probe-time handshake first.

[Severity: Medium]
Will the device actually stay registered if it is reset while suspended?

According to the Linux USB core logic, if a device is reset during suspend
and the driver lacks a .reset_resume callback, the USB core sets
needs_binding =3D 1, which forcefully unbinds and rebinds the driver.
This fallback unbinds the DRM device, destroying the userspace connection
and defeating the stated goal for the reset scenario.

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index 4297d9c1125e4..919ca14181af3 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
[ ... ]
> @@ -821,6 +822,20 @@ static void appletbdrm_shutdown(struct usb_interface=
 *intf)
>  	drm_atomic_helper_shutdown(&adev->drm);
>  }
> =20
> +static int appletbdrm_suspend(struct usb_interface *intf, pm_message_t m=
essage)
> +{
> +	struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +
> +	return drm_mode_config_helper_suspend(&adev->drm);

[Severity: Medium]
Does this code leak adev->drm.mode_config.suspend_state if the device is
unbound while suspended?

drm_mode_config_helper_suspend() allocates an atomic state and stores it in
adev->drm.mode_config.suspend_state.=20

If the device is reset during suspend, the USB core forcefully unbinds the
driver because it lacks a reset_resume handler. The unbind path calls
appletbdrm_disconnect() and tears down the DRM device.

Neither appletbdrm_disconnect() nor the DRM core cleanup routines free
suspend_state. Does this cause a memory leak of the atomic commit object
and all its duplicated plane/CRTC states on every suspend/reset cycle?

> +}
> +
> +static int appletbdrm_resume(struct usb_interface *intf)
[ ... ]
> @@ -832,6 +847,8 @@ static struct usb_driver appletbdrm_usb_driver =3D {
>  	.probe		=3D appletbdrm_probe,
>  	.disconnect	=3D appletbdrm_disconnect,
>  	.shutdown	=3D appletbdrm_shutdown,
> +	.suspend	=3D appletbdrm_suspend,
> +	.resume		=3D appletbdrm_resume,
>  	.id_table	=3D appletbdrm_usb_id_table,
>  };

[Severity: Medium]
Is the .reset_resume callback missing here?

The commit message states: "If the device was reset while suspended, repeat
the probe-time handshake first" to ensure the device stays registered.

However, intentionally omitting the .reset_resume callback causes the USB
core to unbind the driver on reset instead of restoring the DRM state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/586d0b39-40c8-4f3d-=
a786-c1085f87b858@linux.dev?part=3D1
