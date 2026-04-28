Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E4FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A38110E35A;
	Tue, 28 Apr 2026 17:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JJDdgTdE";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AB710E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:39:56 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2df943e0a96so606430eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777397996; cv=none;
 d=google.com; s=arc-20240605;
 b=Kse2JAVhCCGgptYLlbMgXY6uDBjdWCXHFG2SXfL/efBax+clR+eFTSlMzxRgb0u+IS
 i5yRm/dkfMpdxN1un1Kd0dKVMuLPLEOEO1q48WTDsmSOD3kkAk+MO8NhyaH7V7CG4tiG
 RB4fuDUIMbW4rcjGQXQFLKrKJNSAdnNvGiOoGvTQ3FYv/O08qzn8TLODg3nxROvMlO6F
 uQHdEo6MSi8/tHBlnxeWVUdTfhfh4BAWNsNRzWX5L/lWk070NKvyf7eF18xdP7scGdh0
 Nz84JbwshG7WYxKXPponaiblsEK6qdoMj/5GD5wBWmYU4d884MRx3XSM5kl0X1r6X2+F
 1NVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QJ5j2CybmJl3sUEm95KbaW1R2+wK5TN85G+0F72B7oI=;
 fh=OuKJidMaOITfm5cPF1EedD19tuTq478AY0F/DZHgJNE=;
 b=M40lBFFTcRVMufg6i7pXrOqir5a+tbh+1OCkEES28O/8DU1GpkYxLX1Sx+l+FhnSV/
 fW/80/S2kO+sNMYcvHULYNEn0LPlLsXecsyyi2YDJy2RGbYRHuVdfLujUva4gBI5Szuo
 lxKs3Q1qIHcuTGRE40BVg7h3naXDfkXYLjP+0zgtcO0Yqdy88vkkiVJZB92TLLLz6L5Y
 q7h2++dF6r/kIJpcoDdAhdYmlJMRncOX7Es1Zi2l61stFiqU+g4hOTVCQbYrmurNqexo
 9jBLWmxFhpAez89teNWSO3dEgNN9XTJIbGeLs6M3ZvDpaGwxkBTGYB+MizzUMgxBmko0
 Jacg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777397996; x=1778002796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ5j2CybmJl3sUEm95KbaW1R2+wK5TN85G+0F72B7oI=;
 b=JJDdgTdEXDGxfbo08XlhROvJaTcJf/u3NKGtE0uzIpk5YQMImZuiQEnaHdO2kvV1V2
 9tngiXhF1SCfr3KI7IrKZ/m7IOy+WzROqlYJTAeTJDEt9LdgsdoIdYsOFc/gCp9mpGUC
 Wig9wTPv1jn+N+h47iOqgVvaCa2mpXDs84emly5Y7bcMK8ZK3+QReF8fVQIS3C/VxvS6
 5EernaaTSIpPkk4cZLCUxjhkDuPD0xyH651SAyQf86dzAwvCoVj/sopgJptWPYOkfDgt
 UhBM3bKF1rPOu6PVYQ1iXe5M8L3vqifVpZxBl2dS6/xu3zEeJm5BEGGtaIquJ/nndK7j
 XnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777397996; x=1778002796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QJ5j2CybmJl3sUEm95KbaW1R2+wK5TN85G+0F72B7oI=;
 b=YxQRavXyvbkFlz4VLFdYgtt1S3EliRT9tRhH/qbFtSZFAWvdxhfIcLGuvHd8L7QBhY
 qjLqxnU58hjLllAVnGhrJMS0P9M20PsETNvup6tqHqr48SqQemoXM4YP6HtS3KhpEnP7
 /ZCKgWe/7OZ5ZIm9es/mLI+o0JspitLRAIPgkvvIx3d/zApRngZ4FA0GW2TcXDHavRXb
 s6adPki+Y8kwjYAL2hZmkZlD9gFaJfwmJTjeDQ6uMZfSXh4gIWO6M8JekImNDemfISjK
 k/UD7+PAb2am+k4vXoYOXh7LdpBeLf+VXdnbnKRAWfU1P8wQDtwT7yJzp61xL9oWSrUI
 qGng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1AZDkbpnLgoNz251aygExNNSFg3AhPd2jzUI9C7DNW2kheTmPZZbUtbypnQZLUGFgc7Hgdy+voHw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmpLuP2eFmeur0+QlE/FfCCMdYaWflGjdOy9fj6ZE5O0Oy+yl+
 ehgDUu4QKvK0bjhVJBnHd42XhbJ6PSDHnfuGt5couDZLn69h6Dnqfz2uo3DPilHWoZeT6hgb6U0
 qlrXaoTbSkK9mPNwj2bXwwS2yWljAP38=
X-Gm-Gg: AeBDieuU47d4ClDPoIVQ/duBZFV8jK8/20eoegnve9XuokS3SLk0pGdPMaLmaGkuo/w
 eyl1Hf/Wxqd1gkPQ/Dm1g0jZMAe4hrGMaBAgTcFv5Fzr2F2PsjaN5RfIzHqoOyivbe/FcxR5SBp
 sgrLu5AEAv84qMR7Mk7vB0jf2Zy6U+rj4jCr1bCUWnLccrOri/Qp5BMhGRuqwUDpkm3/ZXVW8UI
 niTdbdi9Vai6C+JWYaaDF9tSjMpiqsmyje8jasAGF1psUsfSCRZIlwZfoUNvazTnBrHBFlxGirx
 JONVPzfz++E9z4eLLmyQBD7DSWVEJe5WZl2W0R6U3dXDtXQAwtc9gxk500E0vbc/E/CNt1WvlGK
 rA7Tj
X-Received: by 2002:a05:7022:6289:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-12ddd54cabemr793879c88.5.1777397995947; Tue, 28 Apr 2026
 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260428024942.452389-1-ynorov@nvidia.com>
 <f5581e5c-c83c-4c8a-bfb7-9fa029ba1a2f@suse.de>
In-Reply-To: <f5581e5c-c83c-4c8a-bfb7-9fa029ba1a2f@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 13:39:44 -0400
X-Gm-Features: AVHnY4Izprew7Q-7yC_gp9kOM36lMG7cLA8Q-7YvS_NSjN9PYa41VUspQNnKQ1Q
Message-ID: <CADnq5_PHg1Wgks8gwFARnFO0tEx44zUt=UFCvneL4aJYEsPXYg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yury Norov <ynorov@nvidia.com>, Dave Airlie <airlied@redhat.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
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

Alex

On Tue, Apr 28, 2026 at 2:59=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
>
>
> Am 28.04.26 um 04:49 schrieb Yury Norov:
> > The merge-commit 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12'=
 of
> > https://gitlab.freedesktop.org/agd5f/linux into drm-next") removes the =
stub
> > for drm_fb_helper_gem_is_fb(), so the buld gets broken if DRM_FBDEV_EMU=
LATION
> > is not set.
> >
> > =E2=80=98drm_fb_helper_gem_is_fb=E2=80=99; did you mean =E2=80=98drm_fb=
_helper_from_client=E2=80=99? [-Wimplicit-function-declaration]
> >   1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, f=
b->obj[0])) {
> >        |                      ^~~~~~~~~~~~~~~~~~~~~~~
> >        |                      drm_fb_helper_from_client
> >
> > Restore it.
> >
> > Fixes: 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of https:=
//gitlab.freedesktop.org/agd5f/linux into drm-next")
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> > ---
> > v2: restore only drm_fb_helper_gem_is_fb() (Thomas)
> >
> >   include/drm/drm_fb_helper.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> > index bf391903443d..0c5e5ed7b5e7 100644
> > --- a/include/drm/drm_fb_helper.h
> > +++ b/include/drm/drm_fb_helper.h
> > @@ -273,6 +273,12 @@ int drm_fb_helper_hotplug_event(struct drm_fb_help=
er *fb_helper);
> >   int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
> >   bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
> >                            const struct drm_gem_object *obj);
> > +#else
> > +static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper =
*fb_helper,
> > +                                        const struct drm_gem_object *o=
bj)
> > +{
> > +     return false;
> > +}
> >   #endif
> >
> >   #endif
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
