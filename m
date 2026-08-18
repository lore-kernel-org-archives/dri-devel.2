Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C5FC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B9710E4CA;
	Tue, 18 Aug 2026 20:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZR/Ff+y";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A84D10E4CA
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:13:50 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso963038f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787084028; x=1787688828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9aelghBA4TaVvCFRFUwS+75eHiLyMl0AxVtE9OK5vvU=;
 b=hZR/Ff+yT8NFEJ0997clTRjQCS9gXjHq3TRpndRFClGqeBzbiDsePaVYy/FsfulICp
 4bI2wldxCLpnKzYwiScdganGAWhRoazlZdTT3rEPN9vMY3FiwnTOpgeibhaDtbuBvtrw
 6HDNJ8eNM/5wCzH1fz9Ap7C6fnupA378vk0MSXygFQZRHJ7uMHV04AUYYp8pcueZ9dmj
 TUejnc4NxmrH5FBwyAZJ8i3c7/HtrWtKfMMQOmEsDJfG85FNVhtl8fC1fKM8xeQH/A1b
 XvBWR1Xc1/LAlJ56MoVz0leR1QACZN+qlgDgCWJU7Bi4yZrIXXfRMv6qfpG/94juHiJw
 CXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787084028; x=1787688828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9aelghBA4TaVvCFRFUwS+75eHiLyMl0AxVtE9OK5vvU=;
 b=b/9PBw3N0mdrgTvuDk4BkBFHWRB/F1dPSMpHQZue4lTSIpoQOxS62V1IeLG6Ofu6zs
 LgWgRUdEi90zNinK+e3Bm297Df4Cj1Pt3ONXucD+pE604xBuMBDDC57rcoAldT5gi2fJ
 eam7x/IQmRxNo2gLX9O/BITMV4WLepd3nN0ECcBEuSbCu59E6oxdxTH5my1zfNP3AAcA
 ErBScrPeprLGMT9zCr5hpoCEmnhdxmawFU25M1bHnDAB9+8Ng1U+ED7gl0kMCdv/HhJh
 H2UPj+ohz+f8v8VNXhSqtZ2Uh7p+f4TLCbuVj1fKDtwutnBgGUmuvKiGs6oMczlqMMqV
 YNZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiEi7p0RaZP+4e9wIrP+ZULhVEltbQOV46lq+S/gq9BEF4k6mfP+qSBaQ1MJy0AQdFoOGKDTGyuPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy52mkCpj7ySIYCVN0XZ7FM9L3EaYwoCoRRkJxJ8W8IiRq+7yp/
 lmqkXCgZyWFT+C4DxfKfdCyyGveBgwsOFy5jt1Mic94okXc5duMaQZoO
X-Gm-Gg: AR+sD10jBuZeFl607RqEm1bc4q0oFr0q9mzjNp+JJImDEG23PvTUeuGcWuYBJkDBk22
 k6ttHMUisHRNDYgHDurCKf7O8iO1xkqwGH5X+vnUJHwDE1NJE0cXs7LJ89kiPHrRj4cSLxypr4S
 +M+/V7mVQRx2Bj3wE1Z41nyHwKqouSYxqAfw7JSwU/kBdUuwk/5ur7pv0pEE9i0FZvT3XShhcYy
 iduGDihTNZvvd90zlIfhbV9Os1aqdA1u525fTVsGnjKdFefzhsD5T6fDjMrxYCqGyMorPPX81RG
 XhbyTdNkJDX2uv6WDT3En/AdYpPIA9eyu57Y6aQJKn5HjiyMUi290qCGlllH8HXE2z2EJJCxgKS
 EwVQYQZ4/rO0fUsrJV4m0WiDEjWNKbIIxUfGXoWvevevuXUV07GFRBrfocddJRw6WvtOl+JS5eC
 iBX8GvHO81nUvilpbCAzrzXm7H02BzBlAogEI12tKcET6Ydh424c/iOkO6ZD6b+gQzGD/TSh23B
 c7p3ccBV4x/rGc=
X-Received: by 2002:a05:6000:4013:b0:481:562d:6fb1 with SMTP id
 ffacd0b85a97d-482b06d1c7fmr1374197f8f.6.1787084028154; 
 Tue, 18 Aug 2026 13:13:48 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b77fa3sm13932329f8f.26.2026.08.18.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:13:47 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Tue, 18 Aug 2026 23:13:29 +0300
Message-ID: <20260818201331.39232-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoQd7qsojnphARpH@ashevche-desk.local>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Tue, Aug 18, 2026 at 11:55 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > +static int ssd135x_init(struct ssd130x_device *ssd130x)
> > +{
> > +     u8 remap = SSD135X_SET_REMAP_65K | SSD135X_SET_REMAP_COM_SPLIT |
> > +                SSD135X_SET_REMAP_COLOR_BGR | SSD135X_SET_REMAP_COM_SCAN;
>
> Same comment about const.

Will do, same as in 2/6.

> > +     int ret;
>
> Why not placing it after cmds?

No particular reason. Moved below cmds[] in v5.

> > +static void ssd135x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
> > +{
> > +     const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
> > +     unsigned int pitch;
>
> > +     if (!fi)
> > +             return;
>
> It's less maintainable than
>
>         const struct drm_format_info *fi;
>         unsigned int pitch;
>
>         fi = drm_format_info(DRM_FORMAT_RGB565);
>         if (!fi)
>                 return;
> ...
> > +static int ssd135x_fb_blit_rect(struct drm_framebuffer *fb,
> > +                             const struct iosys_map *vmap,
> > +                             struct drm_rect *rect, u8 *data_array,
> > +                             struct drm_format_conv_state *fmtcnv_state)
> > +{
> > +     struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
> > +     const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
> > +     unsigned int dst_pitch;
> > +     struct iosys_map dst;
> > +
> > +     if (!fi)
> > +             return -EINVAL;
>
> Ditto. The problem is that the current style is tempting for subtle mistakes
> such as defining more variables that may use fi in between.

Noted, I'll move the fi assignment just before the guard in both functions.

> > +static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
> > +                                              struct drm_atomic_commit *state)
> > +{
> > +     struct drm_device *drm = plane->dev;
> > +     struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
> > +     struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> > +     struct drm_crtc_state *crtc_state;
> > +     struct ssd130x_crtc_state *ssd130x_crtc_state;
> > +     int idx;
> > +
> > +     if (!plane_state->crtc)
> > +             return;
>
> In the similar way here.

I'll move plane_state to just before this guard as well.

-- 
Thanks,
Amit
