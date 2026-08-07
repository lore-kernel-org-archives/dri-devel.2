Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95B1C5AC82
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CB510E451;
	Fri,  7 Aug 2026 18:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="agBcCM89";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F10B10E451
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 18:00:17 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso337562a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 11:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786125616; cv=none;
 d=google.com; s=arc-20260327;
 b=ccJdA2Sxs2VY7ArIgSU1EP4/yktsrknM1WykrbZ8m8tBr9iqf9v7snuzQgCgFTe/ag
 G3L6aClj4poZ7BMivNO3Vt+yd4+GjqotVmKVDD0d7LudZxsMseE9hpYoE/4dKPl/Kg5w
 fA5IyOpzJ/po5udoJvNiAyKGPetbSPDS2eD+onsrXq1hSBclKM4Edp4y6u35DlYjLI/l
 4y6k37sXPbLHHkEA71Vo8qrQdMnTQguAFwMnvKFhC9B4Jhfs00XyPX7YSXr7tauXzPKX
 MdIiPPQ/EEjIj1zqhQI1f83wu6FQAN6HHG41UjoldkU74AZ5E0SSU1LDGYs/Xc/EvoN5
 9LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 fh=mrzz8JDXGSa7zsfcURUdmteMqvk97YQh+1XX2Eo4XrU=;
 b=lFrAXOdTUIb/EXrdi39pZ8WGwd4Jejpi1WN4Pc+9jiTis6+cCES0z8vOdnvU/g/CdQ
 iiEFr150X9I2E+o6daJ+MMSmHqW4h1ic8tDPiECrMFSuld2LlQlmyZusRAoiOXecD9dp
 8kl+II5Fl3XkeS6htBKZoFCUX6vhVG3HGEAV6GLYCn8keS/bvDZX7W3AKZ01JtgJOFuF
 Rcn/VghatuvQ7d14ssFamY40lL7yUNL0cN7yoZQrcFm4jyDb8+TmDMvA6ZXXV/haYT8y
 1hBdrn2IwWvsbrSEGgHTzRx0zTe5ZS9uKB0rfdZSbdDn9llK0x+09oP0dqU/5IPJeUea
 dDkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786125616; x=1786730416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 b=agBcCM897KQt7na8r8A+PwhAFPihIEb1iXbPxHCoFGEBYY/2qvWwhdRf+3esfyoZUd
 ISPNYt+z0aXdl+eo9+u97RAi6hVoYniVh3wu4YoURiLO0VWhbRmbqnHgoG8jic360z+C
 VNQ8jSdfjEYac/v4bUQNUcJatZaQIErMTi6TirsY1RZ846gnPIVDiNoqCzOpabeZPMyN
 D0Srxwi97LP6BTg8b5ZMpGTc4AzGqihPtZNxUT+u7fpZO8u41e5sGcJ5ay37kZCBEnU4
 s/IKKFDCUiHu+3j4K+5wjyuvmxxpsykAojByknFrhlLxb/+EgN8eRct6qMXq4+EOkHf1
 U2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786125616; x=1786730416;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 b=c5J8I9nHH94rM9Gpe5UDo3D+D15vdDm6buSamNY4gwAqrctM+Lu6qhr+eRFMmhPeu1
 2v9CcGCsgIgl6ae3e38W2NjHXuB/yqejOi6jRIGYtuM74o887IJnej57OxAESVWqX+2h
 rt3P2nsGmIGihwRDv8mndtntyJsswoeHysHNRAara8mU/8eFaiTDdmq6XAjkqmiD+xRK
 Is8crOi5c7s+boipY7qjYtCOH4Pq/nfpKFiVsi6ix5wXEVbTGo3pt+XoQPB3FDyRJGGc
 739W1lNp1WyJsXWTPNpoiRrGa9Oe5AJlmCnyvjhaGs278VBwN5HhZfJI8E9SQhRMfkQi
 0eWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqal9WGQcmGZWuXo1LoerjLbCtgXvBcNUvvBLvbxUIvPhyTjfsVf2kzJZUM8bj8PBC8oRmeManp8l4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6brKOrvwZ6ShbWc1qgu69HKaDa3inMIo3pHeLNba9ZA4SoYPI
 mLeHf+8w11lrnX+++wRrldSUnBBhaNWtyh9v+9OFiiAuT/POqgZU8X90/pmK/t/u74bSjJmToWH
 Ea/d3gPcdSv/Ys59q/gcbh7zqaGE4UBc=
X-Gm-Gg: AR+sD11u7WkUwkAiEJci8hKf0ZdC49m4wV+1zv+IlDuMD9TXwIVFp72vkewVsVlZR74
 TRLK5jhgr556iSmk+7iGVsMpvmZoHbylpUwn62ozuIJDRVSYmlyRyRTAoj4K03LnSChqK9cm2k4
 kAIZFttqdS0YCryZkv0K2Mhohw2aOPQhsxFL0VTE8+odVHv97cs5GDOhIu0Sy7s37ckNviE6zPJ
 JR6BTJxPpUVrtxgaF4M8zVSt45MPwIX+Ygi6fgbbrh9GGry/ty1+vunI72dFc8hZ1q4Ngl0AckV
 hESUJRWiBaH+2p3y50yuoZOTariRyA8W4aF67oZapzeX6UzEe7lF6NrDjL77I5LQmF/WKlPwhVE
 YW+dq5t0l8htmGBVE7ZfCyiXiFJxKuCk=
X-Received: by 2002:a17:90b:3a81:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-3903c6e93e6mr17347802a91.2.1786125616561; Fri, 07 Aug 2026
 11:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
 <833bafaf-0167-4515-93cd-0828776741d2@igalia.com>
In-Reply-To: <833bafaf-0167-4515-93cd-0828776741d2@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Aug 2026 14:00:05 -0400
X-Gm-Features: AUfX_mzxIXXmzkMgICxD6dw0ZAqFqvVs53r2e1rHpS5oqJZtmayLF777l1T9PvA
Message-ID: <CADnq5_OnpUB1xVOc52g_-DJuKRTWSOJGrL9QHNUeWyC-mytumg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
To: Melissa Wen <mwen@igalia.com>
Cc: Samuel Pitoiset <samuel.pitoiset@gmail.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>
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

On Fri, Aug 7, 2026 at 12:35=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrote=
:
>
>
>
> On 07/08/2026 16:58, Samuel Pitoiset wrote:
> > amdgpu_dm_crtc_set_vblank() dereferences acrtc_state->stream when
> > vblank is enabled/queried from DRM_IOCTL_MODE_CRTC_GET_SEQUENCE before
> > a stream is attached to it.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> > RIP: amdgpu_dm_crtc_set_vblank+0x6b/0x4d0 [amdgpu]
> > Call Trace:
> >   drm_vblank_enable
> >   drm_vblank_get
> >   drm_crtc_get_sequence_ioctl
> >   drm_ioctl_kernel
> >   drm_ioctl
> >
> > Reproduced by running VKCTS with WSI tests enabled on RADV.
> >
> > Guard the enable path on acrtc_state->stream being non-NULL, matching
> > the existing checks in this function.
> >
> > Fixes: 34d66bc7ff10 ("drm/amd/display: Fix Xorg desktop unresponsive on=
 Replay panel")
> > Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 46d85457c77b..62eac6e65334 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct =
drm_crtc *crtc, bool enable)
> >
> >       irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crt=
c_id);
> >
> > -     if (enable) {
> > +     if (enable && acrtc_state->stream) {
>
> LGTM.
>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> +AMD display folks for visibility
>
> >               struct dc *dc =3D adev->dm.dc;
> >               struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(c=
rtc);
> >               struct psr_settings *psr =3D &acrtc_state->stream->link->=
psr_settings;
>
