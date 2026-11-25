Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5E606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I957pA1C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D2D112130;
	Thu, 26 Nov 2026 08:11:08 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBE310FC6E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:52:02 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6ba1e22ff4dso6848704a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795614721; cv=none;
 d=google.com; s=arc-20260327;
 b=ai4sHwNvhpKc2IRvJcXgoiRhHCx9PD1Ldic4eZ/0eO/hzTJT7TbfFq4gaF/KSvjLCu
 kTHhW/MozCf0/Qx+0lAkDD+u2obCLR2hLJeaCBRhbYx91bUlMQfRWnfbVPFO+eklTg0J
 dQ/NlGYIr6U/ndajVmiD7ugb9/N8tMKwRYMwbuXrYNmCEmA2atpqHU/q/3/rZp2a/aBJ
 QSo2QPMd6bY0C3sM3QaEnKCOL09GWKFxUlmQTJI9LBg79lSnswC/Xw5ke2akxF3xNWc6
 MaQbwlx9VErtlUhnVG9/hUb59gr+62AQjE+cbnL1M0nECteXKCjbEIasoIfMN0op5+dl
 WhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dk5J3h/sVjTiXHv23N868Pwgsnpoz2KWfjMivypjcyk=;
 fh=XbMbzjxFvtptJ6POOf0YdBEXTTtQstmGMYnxeut14tY=;
 b=F1fVbRX6hfbaYa1tEGlIgHA1AohXh+ILk/IhA1N4VankkJXYo20GaK8Vd2gsOQHrKF
 KhWUrCN06YLlM6TYvjJgQVa8cGd4xJsKaPMC2KKVNr1kSNUJOMgHTWVDfSzMBKyPyWCZ
 A3ohYAsjS6JU+4iDKJagwEiiahyTjp5ZjDMy56opKqFxqvJX9Jw7QkEsMtm1VvyeKvwO
 yvcFehc6+oDavV7dcVX9tKkMWx/3i+9SthqGWv11ejWlXRjg6aE3d68me+GBU0LbnGhd
 eAZqH04MYpmF8b8FKMEJLACjexVJB9DqA3E4MBFdkdcNeJg+Dc1kJMaCcgBYW6xHt0Tk
 BQRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795614721; x=1796219521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dk5J3h/sVjTiXHv23N868Pwgsnpoz2KWfjMivypjcyk=;
 b=I957pA1CCBnVty6meG/F8KTCgML3MYHFndsCpiD9j+PEqSGVwPEC3xXUGyU+r6EP9j
 JYqWsaBHQuDx0ljh7DigwwY2NgSAWU+ZnviLupexBSLsSXrDmhweCMMdTZ2FbN838BX4
 x8zuFpFeTjCRe3l/z8Mcaj/g7auXUE0AbXkw1Fvz6VKeRE/4bZerUBNr2MEN8xI7mMrb
 LTCW2v0DlzTvqGRvWikeo5BvAATJIojINcfUhmIzDT7JRljqN4bL6SS8LPhfN4kj+YVh
 VbgejAMrWFnAo/4RXYIRmbwooZ+irbozfSkk9ACs6o+QIAzfx6Dc26XSzUIuo2U5ncXc
 SVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614721; x=1796219521;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dk5J3h/sVjTiXHv23N868Pwgsnpoz2KWfjMivypjcyk=;
 b=fPulEB9fhbO68IF2RqCIABnA5R7xjbG1ukq2gi+5sKn37WqCeTUdF1I2Nccp3iYVGD
 kbeGzlQZ+kat3H0RF14kE6QvsnLFMOotksdvW4hxtIvpuBkH1NzYjT0kTplgCkGMHBOZ
 yWTyMhmx9Qf23hGvcXG95jcsChzB65xhVqPsEqtBFGiFvUh5svovlZPW81AfKwlTUhT7
 TdjG//Ne3i5H0NwsoVVUqu5iQt7oFfjdi8RQ5JejQcOsWIyBFUj/D0LjiikQ9Z6WOVHe
 s1TU4SGL3xMIPrwvApDdRc17baY3r/y28C8HmzZ4b2qx7Hlo50JQJG2dCLq5C4tzVwvm
 uCnA==
X-Forwarded-Encrypted: i=1;
 AL+hErFPz+E9R1bXjkKoX88jD7UCh9WjWh2HRZGm5NwCJU69vKAbiYCMre+PcTotq5Axm72uPeOA0w18qUo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/oQ707AzNiCRcjhRekhjKnl9c1jPXKNYoyu+wfkFsMcHmQr9N6
 OTbt1pz4c1Z1GxXYj8A2xIzIL8A7Nft+v6Jhj2HxAkcfAqVJkhpG5hP0nU5wOL2JCf3xdEX6lke
 4EATTRKrr9lp9KPJRF+oF1ICIPty87eg=
X-Gm-Gg: AZFdTZdVRBnDxsyZJVSCmJz9Wg1WxuGYwYnQwc753215SAEATCUdcFq0bybJ7CQMzyB
 FmDaYWtgKEpy+L+POjp9v4Y+hkyx1UbrzNr8TVvURmGW3LWgr4poJ0LQ0tCE6u97yh20ZUFyh8x
 K3Ua1WLSlkjxlMQ7bgMA3fumI6F9WRNiHYQOJSn0mggGdBaA2z0jGfHTp8dhRQ8YDUwIDsHD5zR
 LeJB+K6YLOy+SAq0fmJPAGIW7Ou57DqspyX5DH8uHTPGiplIcQia1AoKDzF4wcy1r15voEZ/1+8
 QXAvIu0X9x/84M5RFYPPu2a8xKMsVqg5cEpRmzdmOvFGDt+BwM66nAD3+qAxwky4ahWW2ZUtC8j
 VOSvW45T5ykel43f5owsy4Upl/rGfEU9hVSc3PzVwiqS/fh55VhJXkOupfCi4GGOYvbib3Ti1IR
 S4PRh+Fh6mJtWnF3YFEFAGZGtl09J/H2kQo8QZyH68216w+QKG
X-Received: by 2002:a05:6402:234f:b0:6bb:6df:1fbc with SMTP id
 4fb4d7f45d1cf-6bb06df2246mr3254979a12.18.1795614720526; Wed, 25 Nov 2026
 05:52:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMnMt5aufzBXQvs2OeFpBqdh1_VgNUxstvkVX61dPPcfo94QOg@mail.gmail.com>
 <4df7445b-f4c8-4615-8f1d-3fcc59f8cba0@suse.de>
In-Reply-To: <4df7445b-f4c8-4615-8f1d-3fcc59f8cba0@suse.de>
From: Herman Semenoff <germanaizek0@gmail.com>
Date: Wed, 25 Nov 2026 16:52:17 +0300
X-Gm-Features: Aa3M54pK3hgtA55gmMohtw-eYgBCkVBj9zN9rKUbfTXwsOwAE6_ryIdlXxyJdas
Message-ID: <CAMnMt5bOFRye_=Q-nXmpaO4ZsJmnh6tWxjaxsFXEgw5TpFA_zA@mail.gmail.com>
Subject: Re: [PATCH] drm/ast: Optimize cursor updates and reduce overhead
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I=E2=80=99m sorry. First, I didn=E2=80=99t break it down into multiple patc=
hes, and
second, I didn=E2=80=99t test it properly, and I also didn=E2=80=99t note t=
hat this
patch Assisted-by: LLM.

=D1=81=D1=80, 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 14:5=
3, Thomas Zimmermann <tzimmermann@suse.de>:
>
>
>
> Am 25.11.26 um 12:24 schrieb Herman Semenoff:
> >  From f9574b5a246bf9021ea75f530a9a8ab7c9995274 Mon Sep 17 00:00:00 2001
> > From: Herman Semenoff <GermanAizek@yandex.ru>
> > Date: Tue, 24 Nov 2026 12:53:31 +0300
> > Subject: [PATCH] drm/ast: Optimize cursor updates and reduce overhead
> >
> > On server platforms equipped with ASPEED BMC GPUs (such as AST2400 on
> > Lenovo RD450X), VRAM is mapped over a slow PCIe link with limited
> > bandwidth.
> >
> > Currently, on every cursor move (e.g. via drmModeMoveCursor or atomic
> > commit updating plane coordinates without damage clips),
> > ast_cursor_plane_helper_atomic_update() invokes
> > drm_atomic_helper_damage_merged(). Because userspace does not provide
> > damage clips for pure cursor movements,
> > drm_atomic_helper_damage_iter_init() treats the absence of clips as a
> > full plane update. Consequently, on every mouse move event:
> >   1. ast_cursor_plane_get_argb4444() performs format conversion on CPU
> >   2. ast_set_cursor_image() recalculates 32-bit checksum on CPU
> >   3. memcpy_toio() pushes 8192 bytes over the slow PCIe link into VRAM
> >   4. Cursor base registers are reprogrammed
> >
> > Fix this by only updating the cursor image and base when the image
> > actually changes (fb !=3D old_fb, plane was previously invisible, or
> > damage clips were provided). For pure position updates, only update
> > the coordinates in the hardware cursor signature and registers,
> > skipping VRAM transfer, format conversion, and checksum calculation.
> >
> > Additionally:
> > - Add DRM_FORMAT_XRGB8888 support to ast_cursor_plane_formats and handl=
e
> >    it with opaque alpha in ast_cursor_plane_get_argb4444(), preventing
> >    compositors from unnecessarily falling back to software cursors on t=
he
> >    primary plane
> > - Implement .panic_flush in ast_primary_plane_helper_funcs to disable t=
he
> >    hardware cursor during kernel panics (CONFIG_DRM_PANIC)
>
> I this is mostly wrong and the patch is terrible. I refuse to further
> deal with any of this.
>
> >
> > Signed-off-by: Herman Semenoff <GermanAizek@yandex.ru>
> > Signed-off-by: Herman Semenoff <GermanAizek@aizekgroup.ru>
> > ---
> >   drivers/gpu/drm/ast/ast_cursor.c | 39 +++++++++++++++++++++++++++++--=
-
> >   drivers/gpu/drm/ast/ast_drv.h    |  1 +
> >   drivers/gpu/drm/ast/ast_mode.c   |  8 +++++++
> >   3 files changed, 45 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast=
_cursor.c
> > index 690d4cd1db5e..883d1e6f20bd 100644
> > --- a/drivers/gpu/drm/ast/ast_cursor.c
> > +++ b/drivers/gpu/drm/ast/ast_cursor.c
> > @@ -142,7 +142,7 @@ static void ast_set_cursor_location(struct
> > ast_device *ast, u16 x, u16 y,
> >    ast_set_index_reg(ast, AST_IO_VGACRI, 0xc7, y1);
> >   }
> >
> > -static void ast_set_cursor_enabled(struct ast_device *ast, bool enable=
d)
> > +void ast_set_cursor_enabled(struct ast_device *ast, bool enabled)
> >   {
> >    static const u8 mask =3D (u8)~(AST_IO_VGACRCB_HWC_16BPP |
> >        AST_IO_VGACRCB_HWC_ENABLED);
> > @@ -162,6 +162,7 @@ static void ast_set_cursor_enabled(struct
> > ast_device *ast, bool enabled)
> >   static const uint32_t ast_cursor_plane_formats[] =3D {
> >    DRM_FORMAT_ARGB4444,
> >    DRM_FORMAT_ARGB8888,
> > + DRM_FORMAT_XRGB8888,
> >   };
> >
> >   static int ast_cursor_plane_helper_atomic_check(struct drm_plane *pla=
ne,
> > @@ -229,6 +230,30 @@ static const u8
> > *ast_cursor_plane_get_argb4444(struct ast_cursor_plane *ast_curs
> >    argb4444 =3D argb4444_dst[0].vaddr;
> >    }
> >    break;
> > + case DRM_FORMAT_XRGB8888:
> > + {
> > + struct iosys_map argb4444_dst[DRM_FORMAT_MAX_PLANES] =3D {
> > + IOSYS_MAP_INIT_VADDR(ast_cursor_plane->argb4444),
> > + };
> > + unsigned int argb4444_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> > + AST_HWC_PITCH,
> > + };
> > + unsigned int x, y;
> > + u16 *dst16;
> > +
> > + drm_fb_argb8888_to_argb4444(argb4444_dst, argb4444_dst_pitch,
> > +    shadow_plane_state->data, fb, clip,
> > +    &shadow_plane_state->fmtcnv_state);
> > +
> > + for (y =3D clip->y1; y < clip->y2; y++) {
> > + dst16 =3D (u16 *)(ast_cursor_plane->argb4444 +
> > + y * AST_HWC_PITCH);
> > + for (x =3D clip->x1; x < clip->x2; x++)
> > + dst16[x] |=3D 0xf000;
> > + }
> > + argb4444 =3D argb4444_dst[0].vaddr;
> > + }
> > + break;
> >    }
> >
> >    drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> > @@ -261,13 +286,21 @@ static void
> > ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
> >    unsigned int offset_x, offset_y;
> >    u16 x, y;
> >    u8 x_offset, y_offset;
> > + bool update_image;
> >
> >    /*
> >    * Do data transfer to hardware buffer and point the scanout
> > - * engine to the offset.
> > + * engine to the offset only if the cursor image actually changed
> > + * or the plane became visible. For pure cursor moves, avoid
> > + * expensive PCIe bus transfers, format conversion, and checksum
> > + * calculation.
> >    */
> > + update_image =3D (fb !=3D old_plane_state->fb) ||
> > +       !old_plane_state->visible ||
> > +       drm_plane_get_damage_clips_count(plane_state);
> >
> > - if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &da=
mage)) {
> > + if (update_image &&
> > +    drm_atomic_helper_damage_merged(old_plane_state, plane_state, &dam=
age)) {
> >    const u8 *argb4444 =3D ast_cursor_plane_get_argb4444(ast_cursor_plan=
e,
> >      shadow_plane_state,
> >      &damage);
> > diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_dr=
v.h
> > index 4f221b848d68..d846d5cf4f5e 100644
> > --- a/drivers/gpu/drm/ast/ast_drv.h
> > +++ b/drivers/gpu/drm/ast/ast_drv.h
> > @@ -542,6 +542,7 @@ int ast_sil164_output_init(struct ast_device *ast);
> >   /* ast_cursor.c */
> >   long ast_cursor_vram_offset(struct ast_device *ast);
> >   int ast_cursor_plane_init(struct ast_device *ast);
> > +void ast_set_cursor_enabled(struct ast_device *ast, bool enabled);
> >
> >   /* ast dp501 */
> >   bool ast_backup_fw(struct ast_device *ast, u8 *addr, u32 size);
> > diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_m=
ode.c
> > index 08db132acae8..f94f849d157b 100644
> > --- a/drivers/gpu/drm/ast/ast_mode.c
> > +++ b/drivers/gpu/drm/ast/ast_mode.c
> > @@ -639,6 +639,13 @@ static int
> > ast_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
> >    return -ENODEV;
> >   }
> >
> > +static void ast_primary_plane_helper_panic_flush(struct drm_plane *pla=
ne)
> > +{
> > + struct ast_device *ast =3D to_ast_device(plane->dev);
> > +
> > + ast_set_cursor_enabled(ast, false);
> > +}
> > +
> >   static const struct drm_plane_helper_funcs ast_primary_plane_helper_f=
uncs =3D {
> >    DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> >    .atomic_check =3D ast_primary_plane_helper_atomic_check,
> > @@ -646,6 +653,7 @@ static const struct drm_plane_helper_funcs
> > ast_primary_plane_helper_funcs =3D {
> >    .atomic_enable =3D ast_primary_plane_helper_atomic_enable,
> >    .atomic_disable =3D ast_primary_plane_helper_atomic_disable,
> >    .get_scanout_buffer =3D ast_primary_plane_helper_get_scanout_buffer,
> > + .panic_flush =3D ast_primary_plane_helper_panic_flush,
> >   };
> >
> >   static const struct drm_plane_funcs ast_primary_plane_funcs =3D {
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
