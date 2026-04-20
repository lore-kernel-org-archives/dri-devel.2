Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60418F588DF
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9EA10E67D;
	Mon, 20 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLieqVOS";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D3210E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:28:56 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d9472c97dbso278246eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695336; cv=none;
 d=google.com; s=arc-20240605;
 b=afOpPZLZQ7lDU2Q/hAJzRiCWyj75t/4dzGxz/229g61P8G6MRAg4hcv4pzHTAZJEFY
 F2cRP7S0o3VIjigG//6ODryYwsR0JrtDMS9J/8dzOxTXzUM+IcAkXSH9sFEiqjGoa89H
 Rl51qYhke2VRM62KDxyejsDoI0SH7TzEUCPQGK7Z80ML3OJpfYletZn55nW63mIObzSR
 SV41qUt1SBPp51dbWzcKSEnnKOliGog+n/JioXHyAPpNFm4/oGpquejLd6BLTvq+W3hr
 ML7xUpbmQbYZxLTfb57QE7NpT+gdYJtxt9cf6jMJ3Awy6Fe8yDW+rPaGClV4OwSoLiup
 Y4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eZmECXGevCVaK/wwY62Jb7j9GBCzbmIgxR8ypNglG2Q=;
 fh=onYFocRfLAytT/77LqjO1P7xDzKmut1wDz0Z3hw5wrM=;
 b=VG+maj6Rksd+Hw0sWCp/cmGaXxODavj1wTt6dXhx54U8XSxB/6WscL/w+Ej2BM4WJl
 c0U1xTTzZciQK3BnZ880PZtQT3Grh8SQR4Ef5Pj0efr3jb2jcol7Ssbo1n386xNGfaaU
 SuyRVJfL30K9Qjh1eU2ac9Maus3wdBWiJBRa71nlb+VJo2HsWWIQmdDemObnYbEteEn9
 WxAlJ1u3sNo7hmt1utAaJe0clG7nyZ7lE9SG8tgYMSbCkaUfFEgFM9SKy0cZLuvw4BFy
 rqMYZAdo+Lc7lTQhPvsM7YQ3mnVz985VpKh6TkM5RGu6cn6htOw/RBgW8ApKN9xKJ3Gl
 Y4qQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776695336; x=1777300136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZmECXGevCVaK/wwY62Jb7j9GBCzbmIgxR8ypNglG2Q=;
 b=cLieqVOSEN13CNCpXyNI+JIhDg+WpIUbrY9B0UHU4Rn4GEzBYLrA/o4ZW5GF7Vny9o
 dA+UPNeL9c451IfQGA0zDXkTiBGdhkRIM4HZjkAE2D6Wb9mULUueiPPZcipwF5MEr+jg
 sYPFWzxLz7xlBmJmkLH7tc+mDAs5QCOFiXhJLOMOVH9muhb9mocCY9Xg/ZmWamkehVgx
 juB2n+Sbn64baz2MarXMR8yp1TGq14b9cWZLxNGuVOIfKFbI6QJ4VmycVltkejw47/lI
 TQL91FGyHVORk868z/4xuhfSso+ZD1D3jve0eXX0D/MWGmATwirtWU9j62CfIvSkO+pO
 1JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776695336; x=1777300136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZmECXGevCVaK/wwY62Jb7j9GBCzbmIgxR8ypNglG2Q=;
 b=hAJQGzWfnw1CEPtr/xROWbPhBPzzeAPIhKChD08dwv+y6xQ3/6Ha4FvXJYGAbjE7VP
 OU5cca8iUAYa+Ixr+fOI//RUJLv6ArSnGJCCCZHMbbxXiIhU4z5AGOEsCDp26OuNo1oh
 SX3OMQJM1omYCY57xK5JHviOffda36uLadYGugj83JGlI1MiuOZjvbe2G9ofMeA3ubcf
 9a1gtMJiOjCfRii8oGBFqUQrTbz4fu86skafmT8Qwz9bEtAAJct4GsW7hXk9K9QjbWb0
 YBHSedOgqCvlEu8+HqEHauzl7UmPF4e0kfos2YHCYL3fmEF2+NLn8noNOiIH6kRMt0Ht
 E7pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UoGBUhpECLZ/cbJQGKe28e7Z7WL9xtTuLVNE+Kf3Bg8oKXn6flieLd6xy1c6USggki3UmsUaKpyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQwlr+W4p+cQxGVme8bt81xl5vDLrIzQ85YTB6Eo3kjkMAzsy6
 u+uuHnrwpOvrfxzh5zZAanrU7ucfaD7gBQLA7e0ZohYnlWe/87bvn9tBCnyESGTYi9z2b+rfX5Y
 Prc3Wco4PYkWU3n6/KH9xjA5VqST9Ge0=
X-Gm-Gg: AeBDies27OaO84oTJ1dL3MTOJ2Uii2Jw2sr2xvsTyeW/B9HXUIcOBG1qfyj7MFuVIBm
 Lt3gXJQkCaL3GRqaltfzQDGSvhMHzp4aG2c9TML8BsL8sdusvvfkC34EofSOwijRDmpV6BtDT8G
 zSApmJGEQM3KY98ldRlwioP8nPV/tUnsmXGmhHFq9jkD7LOaOpAnt6QoBvbvLgAXLPTmalQTpXN
 o2Dfrfn+KmdkDN8iYRhz/kZbhsRW3YOEIF5wV2bsKJiG6782KvnxmNYCqIHCSs6FXbc3wRgvXAp
 NceacW8P318M6Sn7YWA4SGiQZZac5wdsPG9gZwu0AiGDsdXvkqxQ+dunlEynCxN/lO0UWh+T5xR
 nj1ou
X-Received: by 2002:a05:7022:618a:b0:12a:716c:d27c with SMTP id
 a92af1059eb24-12c73f65e7bmr3336746c88.2.1776695335696; Mon, 20 Apr 2026
 07:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260420125223.234974-1-tzimmermann@suse.de>
In-Reply-To: <20260420125223.234974-1-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 10:28:42 -0400
X-Gm-Features: AQROBzAfpKXjX3L7Hkb49pntXhT2-oonx5BaqtdUEdryQOx7lU1Oxs2Y7j6KTKQ
Message-ID: <CADnq5_Ms0U0Pmpt3cvz6zFLZGrG0f6-x=4Nqam2XU8+gXGZA1w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace VKMS vblank timer with common
 implementation
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Mon, Apr 20, 2026 at 8:59=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Replace amdgpu's custom vblank timers with the shared implementation
> in DRM's vblank code. Both are built upon hrtimers. The vblank logic
> is identical.
>
> The shared helpers contain all initialization internally. They also
> handle a number of deadlocks and race conditions that are present in
> amdgpu.
>
> Also remove the set-but-unused field vsync_timer_enabled from struct
> amdgpu_crtc.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h |   4 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 123 +----------------------
>  2 files changed, 3 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 51ab1a332615..8069fc41cc7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -38,7 +38,6 @@
>  #include <drm/drm_probe_helper.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/hrtimer.h>
>  #include "amdgpu_irq.h"
>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -505,9 +504,6 @@ struct amdgpu_crtc {
>         u32 line_time;
>         u32 lb_vblank_lead_lines;
>         struct drm_display_mode hw_mode;
> -       /* for virtual dce */
> -       struct hrtimer vblank_timer;
> -       enum amdgpu_interrupt_state vsync_timer_enabled;
>
>         int otg_inst;
>         struct drm_pending_vblank_event *event;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index e54295b56282..9f497e9c65b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -5,6 +5,7 @@
>  #include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_vblank_helper.h>
>
>  #include "amdgpu.h"
>  #ifdef CONFIG_DRM_AMDGPU_SI
> @@ -42,81 +43,6 @@ static const u32 amdgpu_vkms_formats[] =3D {
>         DRM_FORMAT_XRGB8888,
>  };
>
> -static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *=
timer)
> -{
> -       struct amdgpu_crtc *amdgpu_crtc =3D container_of(timer, struct am=
dgpu_crtc, vblank_timer);
> -       struct drm_crtc *crtc =3D &amdgpu_crtc->base;
> -       struct amdgpu_vkms_output *output =3D drm_crtc_to_amdgpu_vkms_out=
put(crtc);
> -       u64 ret_overrun;
> -       bool ret;
> -
> -       ret_overrun =3D hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
> -                                         output->period_ns);
> -       if (ret_overrun !=3D 1)
> -               drm_warn(amdgpu_crtc->base.dev,
> -                        "%s: vblank timer overrun count: %llu\n",
> -                        __func__, ret_overrun);
> -
> -       ret =3D drm_crtc_handle_vblank(crtc);
> -       /* Don't queue timer again when vblank is disabled. */
> -       if (!ret)
> -               return HRTIMER_NORESTART;
> -
> -       return HRTIMER_RESTART;
> -}
> -
> -static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
> -{
> -       struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> -       struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output=
(crtc);
> -       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -
> -       drm_calc_timestamping_constants(crtc, &crtc->mode);
> -
> -       out->period_ns =3D ktime_set(0, vblank->framedur_ns);
> -       hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER=
_MODE_REL);
> -
> -       return 0;
> -}
> -
> -static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
> -{
> -       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -
> -       hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
> -}
> -
> -static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
> -                                            int *max_error,
> -                                            ktime_t *vblank_time,
> -                                            bool in_vblank_irq)
> -{
> -       struct amdgpu_vkms_output *output =3D drm_crtc_to_amdgpu_vkms_out=
put(crtc);
> -       struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> -       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -
> -       if (!READ_ONCE(vblank->enabled)) {
> -               *vblank_time =3D ktime_get();
> -               return true;
> -       }
> -
> -       *vblank_time =3D READ_ONCE(amdgpu_crtc->vblank_timer.node.expires=
);
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
> -       *vblank_time -=3D output->period_ns;
> -
> -       return true;
> -}
> -
>  static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs =3D {
>         .set_config             =3D drm_atomic_helper_set_config,
>         .destroy                =3D drm_crtc_cleanup,
> @@ -124,45 +50,11 @@ static const struct drm_crtc_funcs amdgpu_vkms_crtc_=
funcs =3D {
>         .reset                  =3D drm_atomic_helper_crtc_reset,
>         .atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_stat=
e,
>         .atomic_destroy_state   =3D drm_atomic_helper_crtc_destroy_state,
> -       .enable_vblank          =3D amdgpu_vkms_enable_vblank,
> -       .disable_vblank         =3D amdgpu_vkms_disable_vblank,
> -       .get_vblank_timestamp   =3D amdgpu_vkms_get_vblank_timestamp,
> +       DRM_CRTC_VBLANK_TIMER_FUNCS,
>  };
>
> -static void amdgpu_vkms_crtc_atomic_enable(struct drm_crtc *crtc,
> -                                          struct drm_atomic_state *state=
)
> -{
> -       drm_crtc_vblank_on(crtc);
> -}
> -
> -static void amdgpu_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
> -                                           struct drm_atomic_state *stat=
e)
> -{
> -       drm_crtc_vblank_off(crtc);
> -}
> -
> -static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> -                                         struct drm_atomic_state *state)
> -{
> -       unsigned long flags;
> -       if (crtc->state->event) {
> -               spin_lock_irqsave(&crtc->dev->event_lock, flags);
> -
> -               if (drm_crtc_vblank_get(crtc) !=3D 0)
> -                       drm_crtc_send_vblank_event(crtc, crtc->state->eve=
nt);
> -               else
> -                       drm_crtc_arm_vblank_event(crtc, crtc->state->even=
t);
> -
> -               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> -
> -               crtc->state->event =3D NULL;
> -       }
> -}
> -
>  static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs =
=3D {
> -       .atomic_flush   =3D amdgpu_vkms_crtc_atomic_flush,
> -       .atomic_enable  =3D amdgpu_vkms_crtc_atomic_enable,
> -       .atomic_disable =3D amdgpu_vkms_crtc_atomic_disable,
> +       DRM_CRTC_HELPER_VBLANK_FUNCS,
>  };
>
>  static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc=
 *crtc,
> @@ -187,10 +79,6 @@ static int amdgpu_vkms_crtc_init(struct drm_device *d=
ev, struct drm_crtc *crtc,
>         amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
>         amdgpu_crtc->encoder =3D NULL;
>         amdgpu_crtc->connector =3D NULL;
> -       amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
> -
> -       hrtimer_setup(&amdgpu_crtc->vblank_timer, &amdgpu_vkms_vblank_sim=
ulate, CLOCK_MONOTONIC,
> -                     HRTIMER_MODE_REL);
>
>         return ret;
>  }
> @@ -538,11 +426,6 @@ static int amdgpu_vkms_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int amdgpu_vkms_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i =3D 0;
> -
> -       for (i =3D 0; i < adev->mode_info.num_crtc; i++)
> -               if (adev->mode_info.crtcs[i])
> -                       hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_=
timer);
>
>         drm_kms_helper_poll_fini(adev_to_drm(adev));
>         drm_mode_config_cleanup(adev_to_drm(adev));
> --
> 2.53.0
>
