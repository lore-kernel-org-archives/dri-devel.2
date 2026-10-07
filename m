Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D3CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DAC910F62D;
	Wed,  7 Oct 2026 14:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="kVa9KBSY";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C3D10F62D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:22:05 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=lO7k2qeUlKTPLz1K+tJL8g8IOK76pGpsgZGLgAJJ/r4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791382923; v=1; x=1791987723;
 b=kVa9KBSYpsncK6Fj8ndljO+BriFdsB1lJcsqMI3aEy0Dg0tZfJvZDjS2pt+GLK9vtDwoqOcR
 rA1J5JVMRQtavtaoCsO/LxCKt7h6x0ytm+Xi5yQA4kGTjViKUpCj41E3jswJUHfikdtX2QNJtlT
 fpbyc7WFdrfzxlKTIYlvmsOA=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta11.migadu.com with ESMTPS id 605dfb51341d1243;
 Wed, 07 Oct 2026 14:21:01 +0000
X-Mizu-Trace-ID: 605dfb51341d1243
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] drm/appletbdrm: Add suspend and resume support
Date: Wed, 7 Oct 2026 19:50:38 +0530
Message-Id: <E1AEF567-3705-4AE7-B409-6E6D70C505AC@linux.dev>
References: <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
To: vasilij.kernel@tototo.si, Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
X-Mailer: iPad Mail (24A446)
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



> On 4 Oct 2026, at 5:36=E2=80=AFPM, Aditya Garg <aditya.garg@linux.dev> wro=
te:
>=20
> =EF=BB=BFFrom: Vasilij Markin <vasilij.kernel@tototo.si>
>=20
> The driver has no USB power management callbacks, so the USB core
> unbinds it before system suspend and binds it again on resume. The DRM
> device is unregistered and registered again on every suspend and resume
> cycle, userspace driving the Touch Bar through it (such as tiny-dfr)
> loses its device, and the Touch Bar stays dark after resume.
>=20
> Implement suspend and resume with drm_mode_config_helper_suspend() and
> drm_mode_config_helper_resume(), so the device stays registered and the
> last committed state is restored on resume. If the device was reset
> while suspended, repeat the probe-time handshake first.
>=20
> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Mac=
s")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Vasilij Markin <vasilij.kernel@tototo.si>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Could anyone please merge it if they are ok with it? Thanks.
> ---
> v2: Remove reset_resume
>=20
> drivers/gpu/drm/tiny/appletbdrm.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appl=
etbdrm.c
> index ef71b9957..c94ed1068 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -30,6 +30,7 @@
> #include <drm/drm_gem_atomic_helper.h>
> #include <drm/drm_gem_framebuffer_helper.h>
> #include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_modeset_helper.h>
> #include <drm/drm_plane.h>
> #include <drm/drm_print.h>
> #include <drm/drm_probe_helper.h>
> @@ -821,6 +822,20 @@ static void appletbdrm_shutdown(struct usb_interface *=
intf)
>    drm_atomic_helper_shutdown(&adev->drm);
> }
>=20
> +static int appletbdrm_suspend(struct usb_interface *intf, pm_message_t me=
ssage)
> +{
> +    struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +
> +    return drm_mode_config_helper_suspend(&adev->drm);
> +}
> +
> +static int appletbdrm_resume(struct usb_interface *intf)
> +{
> +    struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +
> +    return drm_mode_config_helper_resume(&adev->drm);
> +}
> +
> static const struct usb_device_id appletbdrm_usb_id_table[] =3D {
>    { USB_DEVICE_INTERFACE_CLASS(0x05ac, 0x8302, USB_CLASS_AUDIO_VIDEO) },
>    {}
> @@ -832,6 +847,8 @@ static struct usb_driver appletbdrm_usb_driver =3D {
>    .probe        =3D appletbdrm_probe,
>    .disconnect    =3D appletbdrm_disconnect,
>    .shutdown    =3D appletbdrm_shutdown,
> +    .suspend    =3D appletbdrm_suspend,
> +    .resume        =3D appletbdrm_resume,
>    .id_table    =3D appletbdrm_usb_id_table,
> };
> module_usb_driver(appletbdrm_usb_driver);
> --
> 2.53.0
