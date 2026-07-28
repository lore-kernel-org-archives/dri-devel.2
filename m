Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F07C54F51
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34C910E529;
	Tue, 28 Jul 2026 06:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FLFrzTNS";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EEB10E529
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:37:31 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-6679d88abdcso4331402d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 23:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785220650; cv=none;
 d=google.com; s=arc-20260327;
 b=YqGlkvZd51L52GaFR/7at9keVOsAl9YtnGFdSJ7csUE68haaLBg0lAZzD8Y8Lyh8rQ
 6CUqBXimn3s2HPNTk5XgsjzT5VpWAOJEPxwD2dUN8nO9aAsJufNR3FQ5u8I0un2bWboH
 t+9NtFJsCfEl0fi2R2i32i/NOM8OMIQzTwYfFTOhoMUkBPM6l3zPZNlWW5auZlM1rvEQ
 J0OrMIKmGWDdsttHeZxFPoCocEyuBjCR48olngbaV0IjZAEizNGw4VuxsKz9IIC3OTAx
 KiG798kGuzc4U2rsZIAy6nibi5VfyFlJAIyLiXiN+tg9dIDXVEEkL/uauruZCcfUfOwR
 p0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mk5KhGYTlO9SDZQRF1URMyQmuKRxWDOHbudIP8iEbWc=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=mw+/xsO/WSqZK678NeG7TuXJcABysX1EtPIpZ7nVDl+BRbZwWn2YX5slaoHImTFIN/
 dpNTJu3Qso2GE+FXuFqM/J/0nA3A5Wm3mgrpU9ef3rwTf3OlqAoM59cpaFAZBRvKOAa+
 GlHzHFmC0Yy+ZeGPv+hZzVOp20/ilMaWwkvYc26ITA6VJ+8GNusqmTFV58cEzfEebNI/
 0pFV4blEM5T3OicvRWpPFr5NvtXeOKP0JRBGsCqYYYc3rbIq5SNC9XRCTi5IpkSLuKld
 N6E5acdojXsQmHPXdDmRSy15TstLIWL0PFvod8HOeFQVLn3oAval7SmK4Mg0MOz6oFjI
 9p6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785220650; x=1785825450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mk5KhGYTlO9SDZQRF1URMyQmuKRxWDOHbudIP8iEbWc=;
 b=FLFrzTNSAr7sSIe37rGF18BkSsisTe330Qm5rqUj/TNWod7nfJQLJMdS5hijP5hgw1
 G8BUBMtnoJUJK8w4OrHMDztRfl0P14QNhkEjT/8XrHs+w2w3YESKYscPSCubCa6rEwce
 ezAD2UbG+ksVQ9zF9cNTAS3FrjWJRSKAAtX61D36zrpvmMkgXKhw98LObBlaAG8a0X9y
 Suy38tYOs8y2Ex1Ucz19w82Phuqd28F9Xd0ghkAa+Wk1aqfbaAqHKMuP1MsEDLHY8uc+
 5Nr9rPtWstMlxH/RGNfzEqxxGx5CjtfbimnyvaVWE5rXZzSJc6VPRS9pmsG+5K6wHb4Q
 nUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785220650; x=1785825450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mk5KhGYTlO9SDZQRF1URMyQmuKRxWDOHbudIP8iEbWc=;
 b=lp1y+NjLGEk79HTgsjpBScNfiz8CBMYuePW1QSn+KqhO3++rDU5hD/bJ7CryrMcY5x
 eiyxctF6MVEbnkQ+B3GKCLN6d/FoxHRbAxu0E3bHWuUKRzgSAzDWO+nqc9rJL9/mXhnq
 YIq9Ad8AhBZaJV6rVmD5DCeTGSBpBmUuHEpjN4/bNkMIriQSKRa+ADgbc+fOE1D/nXHu
 SGCv49GMbL1RZh8XcMcn7X5UHqDxTGiRFe+eoIkJo17ygCgQtbXfxFIAeslNGId76a/x
 OjFEsvANzTOORrWuhLX7BkQYWkZt4Kc6qYJuFO/AYzyhMgQvTkNbvkp+55NNKM0n19zU
 dl/g==
X-Gm-Message-State: AOJu0Yx7etlxqBhKryfDVTVqK5ikKK1SCMSkxeA+zKFFu1bZZrRSTeFA
 vaqI+fPX4/zKY9xFx4NSL6sqeEhieDjmAOVysTJisKm2S5fVPk+J86t0mGNOBTG3ktuCrJ822IV
 pBxf82jTU8XcwIK48yaoCAwJk5CW64yc7vYuGmY3RYA==
X-Gm-Gg: AR+sD10CKhYLHDzpGKIeoG1aGGoI7TzLyGnw41wn024iR2oMHfpFL4TPZ+hl6xq6XZ4
 OFYdBWT9M9L7LHtzxV/8KRICu7jmlRwfz4rvp6vHODCONa2aiehlY5kAca7gV7PjzsQ6icdszyT
 2Gvhh1RFiSWAdOIOn9QHbleeH7nlDs65b5F1BrVVheSHP9y+VpfNN656m15YVOK9pzJyEWhufPC
 k1r1QgeukINf/6GjI93iOS75tLldzKRa/sntFWNcvm2nPvhtxA71XTt+bOWA/mlzZg89/3EEUcj
 1nDvWeWWHeXUikQZiLMh/sZVllwE/VG+CxGcM9cYu+LKc9b4ImZ/49+jOg==
X-Received: by 2002:a05:690e:4399:b0:667:bc49:373d with SMTP id
 956f58d0204a3-669056d0cf1mr334752d50.33.1785220650016; Mon, 27 Jul 2026
 23:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
 <20260727095508.AFE0B1F00A3A@smtp.kernel.org>
In-Reply-To: <20260727095508.AFE0B1F00A3A@smtp.kernel.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 28 Jul 2026 14:37:18 +0800
X-Gm-Features: AUfX_mxx-inJEI6IbUDD3Rqk6HOiXBBAdRSlUJRhQEKqDucg-a4vSYyIbI9dTFw
Message-ID: <CABymUCPWn8qz7pg8VOtA+N15yHG8id7L87fpkMMsTV=2SovM1g@mail.gmail.com>
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=
=A8=E4=B8=80 17:55=E5=86=99=E9=81=93=EF=BC=9A

>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Unused pipe configurations are not cleared when transitioning fr=
om quad-pipe to fewer pipes, leading to underflows, stale pointer dereferen=
ces, and hardware corruption.
> - [High] Missing VSYNC source configuration for the second physical encod=
er in quad-pipe configurations.
>
> Pre-existing issues:
> - [High] `dpu_crtc_get_lm_crc` and `dpu_crtc_get_encoder_crc` leak uninit=
ialized kernel stack memory to userspace.
> --
>
> --- Patch [1]: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual=
-DSI case ---
> commit f34d7a5a3191bc6943da26710d69eaffa718ab5d
> Author: Jun Nie <jun.nie@linaro.org>
> Subject: drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case
>
> This commit expands the pipe array size to 4 to support quad-pipe topolog=
ies.
> It requests 4 mixers and 4 DSCs for high-resolution scenarios where dual
> interfaces are enabled for virtual planes. Additional pipes enable parall=
el
> data processing to stay within width constraints and MDP clock rates.
>
> Link: https://lore.kernel.org/r/20250918-v6-16-rc2-quad-pipe-upstream-4-v=
16-10-ff6232e3472f@linaro.org
>
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm=
/msm/disp/dpu1/dpu_crtc.c
> > index 42d0a529b4d51..1c6d65ca561fd 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crt=
c,
> >               struct dpu_crtc_state *crtc_state)
> >  {
> >       struct dpu_crtc_mixer *m;
> > -     u32 crcs[CRTC_DUAL_MIXERS];
> > +     u32 crcs[CRTC_QUAD_MIXERS];
>
> [Severity: High]
> This is a pre-existing issue, but does expanding this array to 4 increase=
 the
> amount of uninitialized kernel stack memory leaked to userspace?
>
> When populating the array in dpu_crtc_get_lm_crc(), if a layer mixer is
> unassigned or lacks the collect_misr operation, the loop skips initializa=
tion
> for that element. Also, if num_mixers dynamically decreases after CRC
> generation is enabled, drm_crtc_add_crc_entry() still copies values_cnt
> elements, which can read past the initialized elements.
>
> Can this same uninitialized stack memory leak occur in
> dpu_crtc_get_encoder_crc() with crcs[INTF_MAX]?

Increasing the array size here does not mean leaking stack to user space. T=
he
crc data is copied to user space with necessary length that's from the
calculation
of  dpu_encoder_get_crc_values_cnt().
>
> [ ... ]
>
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index 778e231d49677..90d44c4777fd0 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -55,7 +55,7 @@
> >  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
> >       (MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
> >
> > -#define MAX_CHANNELS_PER_ENC 2
> > +#define MAX_CHANNELS_PER_ENC 4
>
> [Severity: High]
> Does this quad-pipe configuration leave the second interface without a va=
lid
> VSYNC source?
>
> In a quad-pipe dual-interface configuration, the mapping between physical
> encoders and pingpong blocks uses a stride of 2 (the first uses hw_pp[0] =
and
> the second uses hw_pp[2]).
>
> However, _dpu_encoder_update_vsync_source() appears to assign VSYNC sourc=
es
> using sequential indices:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:_dpu_encoder_update_vsync_sou=
rce() {
>     ...
>     for (i =3D 0; i < dpu_enc->num_phys_encs; i++)
>         vsync_cfg.ppnumber[i] =3D dpu_enc->hw_pp[i]->idx;
>     ...
> }
>
> Will this configure hw_pp[0] and hw_pp[1] instead of the intended hw_pp[0=
]
> and hw_pp[2], potentially causing TE timeouts and visual tearing?

_dpu_encoder_update_vsync_source is used only for cmd mode DSI panel. While=
 only
video mode panel is supported for dual panel currently. And the VSYNC
source should
be aligned in timing, due to the 2 panel are modeled as single logic
panel in CRTC level.
So there is only 1 VSYNC source in high level DRM framework.
>
> [ ... ]
>
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_hw_mdss.h
> > index 0e65bf5ddc4a6..fd1f3e7982062 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > @@ -34,7 +34,7 @@
> >  #define DPU_MAX_PLANES                       4
> >  #endif
> >
> > -#define STAGES_PER_PLANE             1
> > +#define STAGES_PER_PLANE             2
>
> [Severity: High]
> Can increasing STAGES_PER_PLANE to 2 lead to a stale pointer dereference =
or
> hardware corruption when transitioning to fewer pipes?
>
> When transitioning from a quad-pipe topology (4 mixers, 2 stages) to a si=
ngle
> or dual-pipe topology (1 stage), the duplicated pipe_cfg array retains st=
ale
> rectangle configurations because dpu_plane_split() only clears up to the =
new
> num_stages:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:dpu_plane_split() {
>     ...
>     for (stage_id =3D 0; stage_id < num_stages; stage_id++) {
>     ...
> }
>
> Later, dpu_plane_virtual_assign_resources() iterates up to STAGES_PER_PLA=
NE
> and allocates an SSPP for the stale configuration.
>
> During the atomic commit, if cstate->num_mixers shrinks to 1, the calcula=
tion
> in _dpu_crtc_blend_setup_mixer() underflows:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:_dpu_crtc_blend_setup_mixer() {
>     ...
>     lms_in_pair =3D min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
>                       PIPES_PER_STAGE);
>     ...
> }
>
> This causes min(4294967295U, 2U) to evaluate to 2.
>
> Will _dpu_crtc_blend_setup_pipe() then attempt to program lms_in_pair =3D=
 2
> mixers using a pointer starting at mixer[2]? Since num_mixers =3D=3D 1, c=
ould
> accessing mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(...) cause =
a
> NULL pointer dereference?

No. It will not happen, because pipe and pipe_cfg is allocated and zeroed f=
or
every plane preparation in dpu_crtc_assign_planes. If num_mixers is reset, =
the
pipe_cfg is reconfigured, sspp will not be allocated for unused pipe_cfg. T=
hus
below check in _dpu_crtc_blend_setup_mixer() will avoid accessing to unused
 mixer[lm_idx]

if (!pstate->pipe[pipe_idx].sspp)
   continue;

+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -883,6 +883,8 @@ static int dpu_plane_split(struct drm_plane *plane,
        u32 num_lm;
        int stage_id, num_stages;

+       memset(&pstate->pipe[0], PIPES_PER_PLANE * sizeof(struct dpu_sw_pip=
e));
+       memset(&pstate->pipe_cfg[0], PIPES_PER_PLANE * sizeof(struct
dpu_sw_pipe_cfg));
        max_linewidth =3D pdpu->catalog->caps->max_linewidth;

        /* In non-virtual plane case, one mixer pair is always needed. */
@@ -936,11 +938,8 @@ static int dpu_plane_split(struct drm_plane *plane,
                 */
                if (!drm_rect_clip_scaled(&pipe_cfg->src_rect,
                                          &pipe_cfg->dst_rect,
-                                         &mixer_rect)) {
-                       memset(pipe_cfg, 0, 2 * sizeof(struct dpu_sw_pipe_c=
fg));
-
+                                         &mixer_rect))
                        continue;
-               }

                pipe_cfg->dst_rect.x1 -=3D mixer_rect.x1;
                pipe_cfg->dst_rect.x2 -=3D mixer_rect.x1;
@@ -967,8 +966,6 @@ static int dpu_plane_split(struct drm_plane *plane,
                                        DRM_RECT_FMT " and " DRM_RECT_FMT "=
\n",
                                        DRM_RECT_ARG(&pipe_cfg->src_rect),
                                        DRM_RECT_ARG(&r_pipe_cfg->src_rect)=
);
-               } else {
-                       memset(r_pipe_cfg, 0, sizeof(struct dpu_sw_pipe_cfg=
));
                }


>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-msm-next=
-quad-pipe-split-v21-1-965dfa5b669e@linaro.org?part=3D1
