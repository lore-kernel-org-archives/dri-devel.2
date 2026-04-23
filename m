Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9894FDEE46
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF6D10E20A;
	Thu, 23 Apr 2026 19:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="e+AbSH98";
	dkim-atps=neutral
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AB810E20A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 19:50:39 +0000 (UTC)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-8aca6bd57cfso67019246d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776973839; x=1777578639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcR7mlIfGhkpn4od8iEvTL0+vUUhsvUAn626yYYyrHs=;
 b=RYyUXFBl/Zyw1XfkqsnTl25F0aY9eVkJekQY6wlQNpEA/tExvx/r2hZLY3JMosiynL
 c8M6aianbUmYkWtxnxXclbUdWxuC5G8Sb9kWPp9rwjztnSCFyCDYD6w42PfqVtRYEk5P
 l7bGj7y4TQ8c50+0NzbvvttbMgGHXm0CHC3vZGLGIoDcg5MKy/hHzdLA3frWC8+lIG4b
 XL0ecxa9e7cKOBKTnCqmNWPnwippSmVEkMpXrD2e7fmIgV2xnBzb7Hx28E0Xe90BCAN3
 n0m8+Oh1xx+xkknyIN+ZU6sTvNNXCnWJCL2vqVO1YM3GNGl0Z0mMmwWWdlt91VC+3s5W
 GONA==
X-Forwarded-Encrypted: i=2;
 AFNElJ8c01eR5FcVKmt2MhXIwPhKtNEUoTE0uBDGUK3AzaCpeVMvChBz/yqs5xiV/p3OkpR/DAOeJWGwvGo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2SpX2xE2LIJoXLyXATN+/sJFBN/uaemilff+weRHb1DGurD0W
 gL5dABIOPbI6u6hh3OTNADANfi7jjUGwkSh0RuxUZNouq+Ur1qWvJ9NawdjYSfoMY2jK+MRsezP
 veWpUojXUT9QUES60oWb+Sd0EIwjKOMiFWiUfUCb4KXMfGtXTAhoaSPBhsaHLyPmxusbECSSs3N
 lIvVz7C880qOBXx8EEC6TLsl4YljTJ3N5gewkfCogbK7JV1xK4rkcf0nMeEOaWrYCPyAtmEDrJ+
 CnXp9v04BjU0VB+lJNK
X-Gm-Gg: AeBDiev6xbpxXSdRlHct/UzmJqs03iSGkmArlYgeLdX7ACTSqb7VRVJBLWWAVH+YIS3
 az1vemhAYOfzawQHPF7DCTADFa0pxLJdYSAqobqyovvESBnaXQbVOfVF59FNnOw3+IUZNEWvJ2q
 ZxNRoie1uGV1L7Bmm6IfVycyu55s4f/sc0cQA3Dol0WTkOhkxwyPvugcn9k7sih9O0yWYTuFCzp
 JKe0PWz5z0yQc8VhVIHc0kvIqJfsV5hhG439TIGKjcwAUQm6htYqrhnHdT/EeO2eCnMLyXjS78F
 lptGZRAOHHVyvmXffvOzCEz7Btm6VKKy1ib4AOTG2BFitRcL4r0CQ406X8PQ46sFK5ucQtMSst6
 Udy2f/hbcafp+tu3nz48Do/G8CcGFOFj378aN/Jvkwc/ds5hP5C+RWi399z2SOqSAgoGpqwCfBH
 M1lHjeKjHrI7nWxtaHV/VVkX+BXkdXX1ccW8Qw2hBAkJEXiyq1yFgQVp//wD+LAxL/
X-Received: by 2002:a05:6214:4a84:b0:89c:5d56:bca8 with SMTP id
 6a1803df08f44-8b02806e013mr437272916d6.16.1776973838471; 
 Thu, 23 Apr 2026 12:50:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8b02ae65a78sm14866676d6.22.2026.04.23.12.50.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2026 12:50:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38e0ef48a2eso32994661fa.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776973835; cv=none;
 d=google.com; s=arc-20240605;
 b=avV0Yu1UJ9SFPWrCE6yAGPJBafPT4S4KhNzE21on5CZA2sPuhBE457mzOsDdLx6TWm
 O9ieKLjO5+RggLYAF0FN1hWwuHgEX9B+psi8hfXPamGWbPvog4g6lyg2ztAh7TAXp5Yj
 b874r7dvf86pNzvTSA8z5KJEfMpxiiEq+hv2DqOfjSiJ347hm5ucEaH/9k4m2Sl4NOzb
 N0MCTxj1butbvaUtLtmkTMShPEJqPS9ElSV8K2YkDg+0VoDfrmIEeMODkXdbpwZFhwOY
 8MpgkLmmZ55ZC7i+/eIGwhSRWFNCLQv3iLfUsI47+ZYulA7t1MBSU4qi9crOo++xp54C
 ZRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TcR7mlIfGhkpn4od8iEvTL0+vUUhsvUAn626yYYyrHs=;
 fh=/mPfY0pD1TsFiFf+NGFylFall1mIKGkyrYnZUzDvaKw=;
 b=IH+9mblbP9LaCl2423bm8jUvhVw1AWZHzZ6283KiBYtAJlafAKiby+x6rUbmHO77xy
 5ShP/VpcfHu81XEkPYK95EW/5YEwAUyk98A996bR9K89fFUbMd1kTSt8kpJ6WLo/5HhQ
 rGDZJ1SXsTLTfirHB71Em/f+6d9gJf0V9h+5SHLndK1n8y9pLup57raygxBbfO2DeSqH
 etNVTGno8F1FBqvVcHdTkQlvF2/2CfwNzWbAhDa3hsZ4/Rc+zMBTzTM0edS2OeeP9uZl
 7w3UDZNRSuEIj6nHbpRcea4tmua6sxOH3AIvkJ+RlMMK5W69SSnIouOK0F/Wrpcd80PF
 HNlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776973835; x=1777578635;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TcR7mlIfGhkpn4od8iEvTL0+vUUhsvUAn626yYYyrHs=;
 b=e+AbSH9890cDDoyoyaKti9vFpJLxUv3RkdX9gC6k6D/p7t+z78Cxh3L/6yRTkSGjbm
 Bpg1EwCowN4TTrlhPKUtiU9ihnweq/K0+AqZBL4bfEb7kjBqhRVmLW+MtcKo2ELfivZX
 dRN/FYq1m6ztMzv1Wmw0mUdJ8830uVelXWszc=
X-Forwarded-Encrypted: i=1;
 AFNElJ9/DTILLVrtazJs9d0v4M3QyIdAQ7PDoFTp4sI0he9oz3jNn8+Y6rCDW/kh/0eYKXi1zHEveG39Zuc=@lists.freedesktop.org
X-Received: by 2002:a05:651c:2109:b0:38f:e440:893 with SMTP id
 38308e7fff4ca-38fe4400cc5mr72265401fa.5.1776973835341; 
 Thu, 23 Apr 2026 12:50:35 -0700 (PDT)
X-Received: by 2002:a05:651c:2109:b0:38f:e440:893 with SMTP id
 38308e7fff4ca-38fe4400cc5mr72265291fa.5.1776973834704; Thu, 23 Apr 2026
 12:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260305134122.246884-1-tzimmermann@suse.de>
 <20260305134122.246884-4-tzimmermann@suse.de>
In-Reply-To: <20260305134122.246884-4-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 23 Apr 2026 15:50:22 -0400
X-Gm-Features: AQROBzAUi5Dbbk7neKng8PxdibXzCHAVv6T5TPMWTwXNfFe841N1XUF3aYd_wp8
Message-ID: <CABQX2QOXweV=+_-O0wumzKys6BtfHKmMaNtdCxj6c-zkr9r5gQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/vmwgfx: Convert to DRM vblank timers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000444f7f065025f6e8"
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

--000000000000444f7f065025f6e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 8:41=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Replace vmwgfx's vblank timer with DRM's common implementation. The
> timer handling is almost identical with a few additional bug fixes in
> the common code.
>
> Replace most of vmwgfx's vmw_vkms_get_vblank_timestamp() with the
> shared helper drm_crtc_vblank_get_vblank_timeout(). The common helper
> also works in the presence of delayed vblank timeouts that modify the
> vblank counter concurrently.
>
> Set the timeout handler to vmw_vkms_handle_vblank_timeout(). In addition
> to handling vblank events, this function also controls CRC generation.
>
> Remove all the hrtimer-related code from vmwgfx. DRM vblank timers
> provides this.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 63 ++++------------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h |  1 -
>  6 files changed, 10 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.h
> index 445471fe9be6..b5670ece90a9 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -322,8 +322,6 @@ struct vmw_display_unit {
>
>         struct {
>                 struct work_struct crc_generator_work;
> -               struct hrtimer timer;
> -               ktime_t period_ns;
>
>                 /* protects concurrent access to the vblank handler */
>                 atomic_t atomic_lock;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_ldu.c
> index f07669b27fba..6f22d5f5c379 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -402,6 +402,7 @@ static const struct drm_crtc_helper_funcs vmw_ldu_crt=
c_helper_funcs =3D {
>         .atomic_flush =3D vmw_vkms_crtc_atomic_flush,
>         .atomic_enable =3D vmw_vkms_crtc_atomic_enable,
>         .atomic_disable =3D vmw_vkms_crtc_atomic_disable,
> +       .handle_vblank_timeout  =3D vmw_vkms_handle_vblank_timeout,
>  };
>
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index 605d037d18c6..cfb8ad3ebe43 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -797,6 +797,7 @@ static const struct drm_crtc_helper_funcs vmw_sou_crt=
c_helper_funcs =3D {
>         .atomic_flush =3D vmw_vkms_crtc_atomic_flush,
>         .atomic_enable =3D vmw_vkms_crtc_atomic_enable,
>         .atomic_disable =3D vmw_sou_crtc_atomic_disable,
> +       .handle_vblank_timeout  =3D vmw_vkms_handle_vblank_timeout,
>  };
>
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index dcbacee97f61..1f5497e2638a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1515,6 +1515,7 @@ static const struct drm_crtc_helper_funcs vmw_stdu_=
crtc_helper_funcs =3D {
>         .atomic_flush =3D vmw_stdu_crtc_atomic_flush,
>         .atomic_enable =3D vmw_vkms_crtc_atomic_enable,
>         .atomic_disable =3D vmw_stdu_crtc_atomic_disable,
> +       .handle_vblank_timeout  =3D vmw_vkms_handle_vblank_timeout,
>  };
>
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 15439ddd4f22..20b6dfd3d3c2 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -195,27 +195,6 @@ vmw_vkms_handle_vblank_timeout(struct drm_crtc *crtc=
)
>         return true;
>  }
>
> -static enum hrtimer_restart
> -vmw_vkms_vblank_simulate(struct hrtimer *timer)
> -{
> -       struct vmw_display_unit *du =3D container_of(timer, struct vmw_di=
splay_unit, vkms.timer);
> -       struct drm_crtc *crtc =3D &du->crtc;
> -       u64 ret_overrun;
> -       bool success;
> -
> -       ret_overrun =3D hrtimer_forward_now(&du->vkms.timer,
> -                                         du->vkms.period_ns);
> -       if (ret_overrun !=3D 1)
> -               drm_dbg_driver(crtc->dev, "vblank timer missed %lld frame=
s.\n",
> -                              ret_overrun - 1);
> -
> -       success =3D vmw_vkms_handle_vblank_timeout(crtc);
> -       if (!success)
> -               return HRTIMER_NORESTART;
> -
> -       return HRTIMER_RESTART;
> -}
> -
>  void
>  vmw_vkms_init(struct vmw_private *vmw)
>  {
> @@ -258,32 +237,12 @@ vmw_vkms_get_vblank_timestamp(struct drm_crtc *crtc=
,
>                               ktime_t *vblank_time,
>                               bool in_vblank_irq)
>  {
> -       struct drm_device *dev =3D crtc->dev;
> -       struct vmw_private *vmw =3D vmw_priv(dev);
> -       struct vmw_display_unit *du =3D vmw_crtc_to_du(crtc);
> -       struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> +       struct vmw_private *vmw =3D vmw_priv(crtc->dev);
>
>         if (!vmw->vkms_enabled)
>                 return false;
>
> -       if (!READ_ONCE(vblank->enabled)) {
> -               *vblank_time =3D ktime_get();
> -               return true;
> -       }
> -
> -       *vblank_time =3D READ_ONCE(du->vkms.timer.node.expires);
> -
> -       if (WARN_ON(*vblank_time =3D=3D vblank->time))
> -               return true;
> -
> -       /*
> -        * To prevent races we roll the hrtimer forward before we do any
> -        * interrupt processing - this is how real hw works (the interrup=
t is
> -        * only generated after all the vblank registers are updated) and=
 what
> -        * the vblank core expects. Therefore we need to always correct t=
he
> -        * timestampe by one frame.
> -        */
> -       *vblank_time -=3D du->vkms.period_ns;
> +       drm_crtc_vblank_get_vblank_timeout(crtc, vblank_time);
>
>         return true;
>  }
> @@ -293,20 +252,11 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
>  {
>         struct drm_device *dev =3D crtc->dev;
>         struct vmw_private *vmw =3D vmw_priv(dev);
> -       struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> -       struct vmw_display_unit *du =3D vmw_crtc_to_du(crtc);
>
>         if (!vmw->vkms_enabled)
>                 return -EINVAL;
>
> -       drm_calc_timestamping_constants(crtc, &crtc->mode);
> -
> -       hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_M=
ONOTONIC,
> -                     HRTIMER_MODE_REL);
> -       du->vkms.period_ns =3D ktime_set(0, vblank->framedur_ns);
> -       hrtimer_start(&du->vkms.timer, du->vkms.period_ns, HRTIMER_MODE_R=
EL);
> -
> -       return 0;
> +       return drm_crtc_vblank_start_timer(crtc);
>  }
>
>  void
> @@ -318,9 +268,9 @@ vmw_vkms_disable_vblank(struct drm_crtc *crtc)
>         if (!vmw->vkms_enabled)
>                 return;
>
> -       hrtimer_cancel(&du->vkms.timer);
> +       drm_crtc_vblank_cancel_timer(crtc);
> +
>         du->vkms.surface =3D NULL;
> -       du->vkms.period_ns =3D ktime_set(0, 0);
>  }
>
>  enum vmw_vkms_lock_state {
> @@ -346,10 +296,11 @@ vmw_vkms_crtc_cleanup(struct drm_crtc *crtc)
>  {
>         struct vmw_display_unit *du =3D vmw_crtc_to_du(crtc);
>
> +       drm_crtc_vblank_cancel_timer(crtc);
> +

This will need somethging like:
  struct drm_device *dev =3D crtc->dev;
  struct vmw_private *vmw =3D vmw_priv(dev);

   if (vmw->vkms_enabled)
         drm_crtc_vblank_cancel_timer(crtc);

Because vmwgfx only calls drm_vblank_init if vmw->vkms_enabled is
true, and drm_crtc_vblank_cancel_timer references drm_vblank_crtc
without checking for its presence and it will crash here.

z

--000000000000444f7f065025f6e8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBD6
6yNWt3NLhePaNubtwmKLIMZOi3+/cnWgLIWDfHWVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQyMzE5NTAzNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAILzME4QOu6zeKjhpylvCwN0jKyj4KrBrx8mdcgR
4sb88nD7nGhGEupetTCLo6u+OZeAFh95oFotxuZX2XpjcVqCulesGKt90hIPXlnKjxvcdGHpjDh5
uggYjPaMqgLCS+N378nsvmWr062+7kZBibqQ2opzW6Epllnj/tXHTaTfpYR1wvzlEUYW+qql5SlO
1p1L6jaRDXW4YGcejJ0t92XvrPXuvnJl9tMyCwrZpEyEfWXbNI2J7byTrHDLwDrPf75bJ+CMeTJO
EDKS0XxLFCY1ZV8yLmozGQoxiqz3r4fYBkIwrC5LF5GG3FrPi1bp+Tc4lAgv24q1LV3l1HsWRIU=
--000000000000444f7f065025f6e8--
