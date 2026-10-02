Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CA3CA5FF7
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22EB10EB06;
	Sun,  4 Oct 2026 17:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nahida.im header.i=@nahida.im header.b="u8uOx6uv";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DDE10E6E2
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 23:04:09 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-9105d241693so3734106d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790982248; cv=none;
 d=google.com; s=arc-20260327;
 b=b5mzn19hoGu1qjuQT1ojbIlxdRm2OXuvCSXH9+yzW7mRdYRPeD5/5P9h6Nf4l3ao4H
 4W9+Q+5u/2OqznBHKOpXYlWzWALAiJFE3o1JrvD9+VcBTi3MgRKOSEchpRjXXZmx7X4P
 K4EzyyI5zZW1oCwCRwr8q0inOx4s2d6Hrlly2ljRGT/M8fTLpg4EfF42SQ3mAYwY/RLH
 ZTZXKvPeoocNGhgMZhQeKm7QFE1n7mTbHIcBbNWvn1Jg9b7/yzyXrDiVW68BtYRbG/Pn
 V9m8YmEqlj9nitTirXpehGJta/5OOiQxTUNmsgxCI8Q+4iUwDUt0j+GeN6IGow+JbaP8
 Ml2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NQtubQ2NhGnt/Pb37kg635DUUt17Ujk2Lk2dRGVHaKs=;
 fh=rXnImgWO5++GuoyfjSAHAMmzZBzsQp7RDM5dD1KWebo=;
 b=N/8XLoIaF1x+zg+B4OEoPROFuu1wnwurZSkL+5gXUWxRTatknPQoViRYo/pXWPOMWE
 Ue7gNRP8nNhdHpgAXZn661rKAw0MtykkN8Q5q4Llw/tQS+1CiemYTmK80RjkXpZW//X1
 jI/9OKI7Tn81sfo3ccU2Vi4b0oIB9SYxHuJrFALFa6JAsA0Zrg4QGYOA6gxART/KzLdT
 WlmUz90KSOM2MfyHLAKdnGjqaaGQozzDyyPEklm77lZS4rtvp44HpLwaAbIx+G9vLACU
 uMc2OxKm1+F1Bzo7UAjOGDk9dNwQZk+oMNmBzFBdFysKjNorGP0+5XnaMn7ZmBEIpqS3
 Hc0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nahida.im; s=nahida; t=1790982248; x=1791587048; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NQtubQ2NhGnt/Pb37kg635DUUt17Ujk2Lk2dRGVHaKs=;
 b=u8uOx6uva3AvxIkvY/s6brC2+GBGJDtXy6FgaPpHAA5rVEDXWRygMHtFEI0v6dUR6R
 Zhmq1TM9VaTv3TFdGOuK+XKIILBOX2WrHT4o2kGcLDIoG8Stws3lX6Sw+1oSI/jy0QNs
 tvZ+DRjPwMbHBLCPw0Fuqtt8vy0eDLF6YNlJl9Oq6DT3uHATcj7IWKklr3KnoVjYeGzy
 wnzIxNqZQ2hLRse0kM6zQkXcLy/JnpQ2mjVY1yjOmyTCbmsinal3/Q4GXE6S5Hh/Krr2
 kVY6/w/JJ+zJHsCbx0lD6sUlHFpoV42LJjshA5t2EWc1oWPoaEL5xteeRT84Jves9J3u
 6x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790982248; x=1791587048;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NQtubQ2NhGnt/Pb37kg635DUUt17Ujk2Lk2dRGVHaKs=;
 b=bWgZtB8gEiu+JXMpGKUP4HigoKtY185i34QL2vQkSVNSGi+YcxkeHUKwIcGVW6bU3w
 HWRXRuJ7Y6ohlbw66Q2sAwbKi01yfVzijIprlB2Xq0JKlEAN4BipPVtOp0RuLHwFY9+Y
 Gnxst9iUs9zkXckxvbIp4HwJhaBbkE+hu9JYSD8kqvgLH2iRrK2Y4yuG/bPOFTrg9Jn6
 Md309MfTnQEkHbIYtwDFSb4B1bnoRRy+swUhPx+N4LvQs5GlICSBnNthWAWdCB1dYjMo
 zTw2gAxISim/0jxBQSX49Q53sc356Owfy1tX6+TzQl4O7AYYE7dfN2LwEQWDaByqcb4q
 SPDw==
X-Gm-Message-State: AFq9FYLYtNwKkL8GUmukMQt8CDybx+okKTqQLWEZrko/rqDdnewYmTs5
 Jn8UPmlpqSuAU+pYy7IbFTVubC8XotvbJvqKz7buqPW9tkFAGUBpTlYHxA5+IunZm9d+MWGCpt9
 Fwx7DL5DdHX44B08jkr2e08KIZ46ECfYCGvHtHeq3pOI=
X-Gm-Gg: AYBFou3uL+C3Fxi77h9iwkFmb8z1Io5QIBocod9Ta/OhdorKKgKKRuf9v/VWK3C3XB7
 rSHSTqyEVhHUDRbptlNtgmVqNn9VaUIPc9tyxoE+oMo/N3+XJaJ9PmgTclt6YIXo/r772v1GxtJ
 HG9ypv4HS4YsZNXMmol6RTqn/jFsOLSY4lvp6ygcCVi7pJFL/jWMFymBvGiCFijfLSGKZawnwkx
 qEmw6tPJuMtaOmQCDP5Oyyqir+sILXWCjbEt6+aLFZxPgx3SEOBnSrrF3OjorqE2kca6lZIOQxE
 iLkcsshKDhsVMoQi1b0wGGpVAGWtPbZgQRVfhzPEkGOWlWkDdM5EpUZEK0yG4/mD0n+DdD3M5kv
 /XW09gAF0Gx9E
X-Received: by 2002:a05:6214:20c7:b0:914:1807:dc70 with SMTP id
 6a1803df08f44-917c009e0b0mr95558236d6.13.1790982248209; Fri, 02 Oct 2026
 16:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261002203140.121165-1-me@nahida.im>
 <20261002222021.149450-1-me@nahida.im>
 <c4da60aa-bbbb-4afa-bd86-6516d14f5809@redhat.com>
In-Reply-To: <c4da60aa-bbbb-4afa-bd86-6516d14f5809@redhat.com>
From: Nahida Buer <me@nahida.im>
Date: Sat, 3 Oct 2026 07:03:52 +0800
X-Gm-Features: AclHuK97182Dn1BYPQmtN3m8pINXQ6fE69KuYDiIokH1t0mLziTTHvfwDPWjgyc
Message-ID: <CAEEzyciisJgZgx4PZQbEEkUUKRMpiAsmmsW9JfQzwCCDx4xZKA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panic: allow overriding panic QR code URL
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Thanks for the review.

My motivation was slightly different from disabling the URL when the
configured endpoint is untrusted or unavailable. I wanted to keep the
URL QR mode while allowing the same kernel image to use a different
reporting endpoint depending on the deployment.

It also allows enabling the compressed URL mode without rebuilding the
kernel. With an empty CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL, the QR code
contains the raw kmsg. Supplying drm.panic_qr_url=3D at boot instead
switches it to the URL format, where the kmsg is compressed with zlib.

This could be useful for a distribution or a locally built kernel image
used on multiple systems: the image can keep a neutral/default
configuration, while individual systems can opt into a specific panic
report collector and compressed QR payload at boot time.

panic_screen=3Duser or panic_screen=3Dkmsg only disables the URL QR mode;
it does not provide a way to keep that mode while changing or enabling
the reporting endpoint.

The parameter is read-only after initialization, so it only selects the
endpoint at boot/module load time.

If keeping the URL fixed at build time is intentional policy for DRM
panic, though, I'm fine with dropping the patch.

Jocelyn Falempe <jfalempe@redhat.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=85=AD 06:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/3/26 00:20, =E7=BA=B3=E8=A5=BF=E5=A6=B2 =C2=B7 Nahida wrote:
> > The base URL used for the panic QR code is currently fixed at build tim=
e
> > by CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL. Changing the panic report
> > endpoint therefore requires rebuilding the kernel.
> >
> > Add a drm.panic_qr_url module parameter to allow overriding the URL at
> > boot or module load time, while keeping the Kconfig value as the
> > default.
> >
> > Keep the parameter read-only after initialization so the panic path can
> > access it without additional synchronization.
> >
> > Expose the configured URL to the DRM panic helper through an internal
> > getter so the helper can use the runtime value when generating the QR
> > code.
>
> The code looks good, but I think it shouldn't be allowed to change this
> setting at boot time.
> You can already set the drm_panic screen to "user" or "kmsg" in the
> kernel command line if you don't trust the default URL, or if the URL is
> no more reachable.
> It introduces some complexity, and I don't really see the benefit.
>
> Best regards,
>
> --
>
> Jocelyn>
> > Assisted-by: LLM
> > Signed-off-by: =E7=BA=B3=E8=A5=BF=E5=A6=B2 =C2=B7 Nahida <me@nahida.im>
> > ---
> > v2:
> > - Grow the formatted URL buffer to accommodate the maximum 255-byte
> >    runtime base URL.
> > - Reject unexpectedly truncated formatted URLs.
> > - Test the maximum-length runtime URL.
> >
> > v1: https://lore.kernel.org/r/20261002203140.121165-1-me@nahida.im
> >
> > Tested on x86_64:
> > - Full modular build with DRM=3Dm and DRM_KMS_HELPER=3Dm.
> > - QEMU/virtio-gpu runtime override with a non-empty Kconfig default URL=
.
> > - QEMU/virtio-gpu runtime fallback to the Kconfig default URL.
> > - QEMU/virtio-gpu runtime override with an empty Kconfig default URL.
> > - QEMU/virtio-gpu raw kmsg QR fallback with no configured URL.
> > - QEMU/virtio-gpu runtime override with a 255-byte base URL.
> >
> >   drivers/gpu/drm/Kconfig              |  9 +++++----
> >   drivers/gpu/drm/drm_panic.c          |  9 +++++++++
> >   drivers/gpu/drm/drm_panic_helper.c   | 17 +++++++++++------
> >   drivers/gpu/drm/drm_panic_internal.h |  4 ++++
> >   4 files changed, 29 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 61111d50b..3d9d421f0 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -111,10 +111,11 @@ config DRM_PANIC_SCREEN_QR_CODE_URL
> >       string "Base URL of the QR code in the panic screen"
> >       depends on DRM_PANIC_SCREEN_QR_CODE
> >       help
> > -       This option sets the base URL to report the kernel panic. If it=
's set
> > -       the QR code will contain the URL and the kmsg compressed with z=
lib as
> > -       a URL parameter. If it's empty, the QR code will contain the km=
sg as
> > -       uncompressed text only.
> > +       This option sets the default base URL to report the kernel pani=
c. If
> > +       it's set the QR code will contain the URL and the kmsg compress=
ed with
> > +       zlib as a URL parameter. If it's empty, the QR code will contai=
n the
> > +       kmsg as uncompressed text only. It can be overridden with the
> > +       drm.panic_qr_url=3D<url> kernel parameter.
> >         There is a demo code in javascript, to decode and uncompress th=
e kmsg
> >         data from the URL parameter at https://github.com/kdj0c/panic_r=
eport
> >
> > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > index 9fe97c4ed..463544f71 100644
> > --- a/drivers/gpu/drm/drm_panic.c
> > +++ b/drivers/gpu/drm/drm_panic.c
> > @@ -49,6 +49,15 @@ MODULE_LICENSE("GPL");
> >   static uint panic_qr_version =3D CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
> >   module_param(panic_qr_version, uint, 0644);
> >   MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR =
code");
> > +static char panic_qr_url[256] =3D CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL;
> > +module_param_string(panic_qr_url, panic_qr_url, sizeof(panic_qr_url), =
0444);
> > +MODULE_PARM_DESC(panic_qr_url, "base URL of the QR code in the panic s=
creen");
> > +
> > +const char *drm_panic_get_qr_url(void)
> > +{
> > +     return panic_qr_url;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_panic_get_qr_url);
> >   #endif
> >
> >   static enum drm_panic_type drm_panic_type =3D -1;
> > diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_p=
anic_helper.c
> > index 8913c3d22..b0ea0b4e8 100644
> > --- a/drivers/gpu/drm/drm_panic_helper.c
> > +++ b/drivers/gpu/drm/drm_panic_helper.c
> > @@ -609,17 +609,20 @@ static void drm_panic_helper_qr_exit(void)
> >       stream.workspace =3D NULL;
> >   }
> >
> > -static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned in=
t qr_version)
> > +static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned in=
t qr_version,
> > +                                         const char *qr_url)
> >   {
> >       struct kmsg_dump_iter iter;
> > -     char url[256];
> > +     char url[512];
> >       size_t kmsg_len, max_kmsg_size;
> >       char *kmsg;
> >       int max_qr_data_size, url_len;
> >
> >       url_len =3D snprintf(url, sizeof(url), "%s?a=3D%s&v=3D%s&z=3D",
> > -                        CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
> > -                        utsname()->machine, utsname()->release);
> > +                        qr_url, utsname()->machine, utsname()->release=
);
> > +
> > +     if (url_len >=3D (int)sizeof(url))
> > +             return -E2BIG;
> >
> >       max_qr_data_size =3D drm_panic_helper_qr_max_data_size(qr_version=
, url_len);
> >       max_kmsg_size =3D min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFE=
R1_SIZE);
> > @@ -686,8 +689,10 @@ static int drm_panic_helper_get_qr_code_raw(u8 **q=
r_image, unsigned int qr_versi
> >
> >   static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int q=
r_version)
> >   {
> > -     if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
> > -             return drm_panic_helper_get_qr_code_url(qr_image, qr_vers=
ion);
> > +     const char *qr_url =3D drm_panic_get_qr_url();
> > +
> > +     if (qr_url[0])
> > +             return drm_panic_helper_get_qr_code_url(qr_image, qr_vers=
ion, qr_url);
> >       else
> >               return drm_panic_helper_get_qr_code_raw(qr_image, qr_vers=
ion);
> >   }
> > diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm=
_panic_internal.h
> > index fe6d514a0..f33552265 100644
> > --- a/drivers/gpu/drm/drm_panic_internal.h
> > +++ b/drivers/gpu/drm/drm_panic_internal.h
> > @@ -14,6 +14,10 @@ struct drm_device;
> >
> >   #ifdef CONFIG_DRM_PANIC
> >
> > +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> > +const char *drm_panic_get_qr_url(void);
> > +#endif
> > +
> >   /**
> >    * drm_panic_lock - protect panic printing relevant state
> >    * @dev: struct drm_device
> >
> > base-commit: 54e61ea6c492d69a1717018826d8340810c812eb
>
