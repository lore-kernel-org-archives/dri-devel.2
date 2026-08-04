Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABA9C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78D010EA12;
	Tue,  4 Aug 2026 12:49:58 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D31C10EA12
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:49:57 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-9773507d36aso2781606241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847796; x=1786452596;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JBGPEMXGhnDdgHfHxVUKfwNAKxtFiEiLS7I0AAldjOk=;
 b=TN4OApIAzSkX12mLIrspI/13YtMnf0zYiEOnD3XFm+Hie0ShLMAfJa9DJc7QRcOx5h
 KbJFX+mtk/ZkoJCZZ3TzA3PmX/ThRrwwDAKyMmB+ItwaNUgOvNoIIbLX8FHgXQQls1lX
 QiEt1wt9nnlYfKeLYS7KODWbUU69SBGHh2l5+VD+lJjs7PAorHrS5EH5lsmDok/ui3s/
 jQco25Sn3ufhL8EIuYxJqK6lDNWXYNGiLtttauxDHDGlvcy1vG19IOD8yVh7BmYnz1rV
 1zvM3iYD328Dn3OZjmRHc//TgQHIKv55NQSklgefa0TzOP39RxNTWcW+fpSMGu9I1HPj
 A1qA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM6G9gDe1JxWrjRTsfXemO0vlfLh640d0R9fDR+7e8gUCZssL4GVX+nOcwsG1Ig1pwam6w549JTdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZnOICg/W96edcc9CKlUfL10RP+o8G4TJ34xpTwkPSOblzXnbC
 93iNnhg6mVeba2mzSQFTXCzneFnXybc0IFiaV+vegLtRiUztm1cmNKzoLHvBF/mH
X-Gm-Gg: AR+sD13FfSb9xy4fd1M4PtftovTCmPZsFqjbsbqYU+aURHS/BNawnnUhe4m+Y/hsWgE
 UzC5svQB1V2zBvQAhW66cAQv/8fJSb0aiPdw66PYuv/GDbD7U3uquIKONoUXLQ/mIy2mG7oHU4Q
 c545pMSMwUcL2w1QryamplWjre9P4G/MrEfsKRbzpf47GmMl29HAPkzhhaZs06FvG3ReaZ+OY49
 WZMd3z6fu0Qj5JZ2n3IadeHeD96WUJKrreVuGnqUEJN730C8bw7CqUO6JUcx4twfjmMcBP7311M
 aQUgye/F2N6NGvonZXdX8RvKh4QGPML0MCNR31TSX8TMWpztT5m9nqH4A/yWvoUCGLNrPwNcrq1
 FCumWTO8/63nKFdANPFXsN527wPnXsCYxFVvA9bnlzyZoKRMVN+9nNpaX00YnRSvZq9ld645kxT
 C7j/z0sLM+PTvfyilOub38ppqTdGx2uyJ2GpRdrXHx93z9bqvaZJsApVQIUmcH3LA/aRIBG/4JL
 yPNeIDD0nVPgN7texM0t93uvQ==
X-Received: by 2002:a05:6102:4b19:b0:74a:b948:d16b with SMTP id
 ada2fe7eead31-75b2196037dmr10877414137.3.1785847796036; 
 Tue, 04 Aug 2026 05:49:56 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9782c7d0a96sm20043241.4.2026.08.04.05.49.54
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 05:49:54 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-74748e3a4d1so2086682137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoXUXttXC9lRHpXWMLNdTrLy/ThngitY+3AeiMB1fTEBMOZtMbkXIiJ/d/zCVmStLj96+PkEjS+Trs=@lists.freedesktop.org
X-Received: by 2002:a05:6102:2c86:b0:745:1c72:cf72 with SMTP id
 ada2fe7eead31-75b2406f27bmr10567769137.13.1785847794532; Tue, 04 Aug 2026
 05:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
 <20260526181700.25310-3-leandro.ribeiro@collabora.com>
 <20260721234802.GA439272@ax162>
 <126e8bdb-9c39-4fbd-ae8a-26a61dd4f3d6@nvidia.com>
 <CAMuHMdXXbPUkyOy0R0s58ayBK0mFFjZa4BKMUBwsnwr-oCQ08Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXXbPUkyOy0R0s58ayBK0mFFjZa4BKMUBwsnwr-oCQ08Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Aug 2026 14:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3dno+-XD8kHG=vQSue9oZe+H1uAWF0v9ZhqUqrzHF6w@mail.gmail.com>
X-Gm-Features: AUfX_my1DFORQUxVgV1ttAGOeGGrmxibdLdSpELwdogkwifIufYpPCOG_LYxVNs
Message-ID: <CAMuHMdW3dno+-XD8kHG=vQSue9oZe+H1uAWF0v9ZhqUqrzHF6w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm: ensure blend mode supported if pixel format
 with alpha exposed
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, 
 Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 pekka.paalanen@collabora.com, simona@ffwll.ch, ville.syrjala@linux.intel.com, 
 linux-kernel@vger.kernel.org, 
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 4 Aug 2026 at 11:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 22 Jul 2026 at 14:08, Jon Hunter <jonathanh@nvidia.com> wrote:
> > On 22/07/2026 00:48, Nathan Chancellor wrote:
> > > On Tue, May 26, 2026 at 03:17:00PM -0300, Leandro Ribeiro wrote:
> > >> Before "drm/drm_blend: allow blend mode property without PREMULTI",
> > >> userspace would have to assume that only PREMULTI was supported by
> > >> drivers that didn't expose the blend mode property. But now userspace
> > >> shouldn't rely on that, as they can't count with drivers always
> > >> supporting PREMULTI.
> > >>
> > >> Warn if a driver exposes pixel formats with alpha but doesn't expose the
> > >> blend mode property. This way userspace doesn't have to guess. Drivers
> > >> triggering this warning must be fixed.
> > >>
> > >> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> > >> ---
> > >>   drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
> > >>   1 file changed, 21 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> > >> index 66f7dc37b597..8cca1dea3b3d 100644
> > >> --- a/drivers/gpu/drm/drm_mode_config.c
> > >> +++ b/drivers/gpu/drm/drm_mode_config.c
> > >> @@ -674,6 +674,25 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
> > >>           encoder->possible_crtcs, crtc_mask);
> > >>   }
> > >>
> > >> +static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
> > >> +{
> > >> +    const struct drm_format_info *fmt;
> > >> +    u32 i;
> > >> +
> > >> +    /* blend mode property supported, no need to check anything */
> > >> +    if (plane->blend_mode_property)
> > >> +            return;
> > >> +
> > >> +    for (i = 0; i < plane->format_count; i++) {
> > >> +            fmt = drm_format_info(plane->format_types[i]);
> > >> +            if (fmt->has_alpha) {
> > >> +                    WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but "
> > >> +                         "blend mode not setup", plane->base.id, plane->name);
> > >
> > > I am seeing this warning trigger on a few of my machines in -next. A
> > > couple of those use amdgpu, which I see has already been reported in a
> > > separate thread. Another one uses ast, which I do not see reported
> > > (apologies if I missed it).
> > >
> > >    [  +0.000137] ------------[ cut here ]------------
> > >    [  +0.000004] [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup

> Same on R-Car Gen2 (R-Car DU without VSP).

And on R-Mobile A1 (shmob_drm).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
