Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A58107BCD6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDD510E439;
	Fri, 13 Mar 2026 18:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fkix8BLk";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1525810E439
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:25:24 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bea8e46017so75948eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426323; cv=none;
 d=google.com; s=arc-20240605;
 b=X/neQQdnq4cO/sCOw2C4K1QjZgo4IsZXhv9k6rQWwxlTyimdIq4HXfpcwzbFEvLIpb
 chLA4IPaoLKQffLvJRtfx4Fdufw68l2xowONp1tgEVMgWaZsMi2G1Zfow0p8HMipmY3P
 dTU7VLe15+eumenafFWUZbCcJm0QvTYgvgRv0LAn14bB7e78Od2NnC8MyLWDg/Djj4fl
 eef5ETbckEleNoM+6F1v4WMYh4vcevtoXuRcE9JiCW9HWer2aUYBc+4TREJTAWgZMUGg
 7VW5dcghKYj4CfW2vzQZGtC6Ue2EwspJ4WtlRLd044V8MV1O1Q3m9hcSR/VrV4QkW12R
 GeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 fh=5o7GtEcqbpQ3ADiVL0ZW80iA9AjOcSN6upk/CRwGwkg=;
 b=dDEK75BbHBanDFetgDyWNOW//AdtXholPD2NpHfPFN12ihQT7mpvryGEmRPE1yIt9E
 wLRjs+O+Egd51SiYBPwJ28YDxPlxCKbRgJXpNlEkshPYKL+U+RF48C0e1QMOS6RuPnXD
 HL8+KboB43WJN60B/LRRs/TBhuP/+lU6/s2atUJyx06WcghNHUi1RXPdivQ9eEoRS06o
 idyhPurtIX6fSM9JQyIDlzrz9aW3l+RBzeO+ImpEABjYVBf9T9rO3UJd9+28aLGdi3Uf
 gHQYIFLBOnZiAR0MRZt4rFP0uvz80GDatSdjDm7jd5ZcmHr96XfufyhmzZCVE/EtYAx9
 ynYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773426323; x=1774031123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 b=Fkix8BLk1OOIkZWO+dkroBLYQDvYn3wLkynH3ympe/XMWA5/CTiT+uq9bXcq9hO+Dq
 IbChIiysxz5/rEVGprT62EC6aSWCDOD4CeX45xV3H4d55/+OOOAF22ByF/829DrQ/rxP
 ZWSPRdM5dyLGOuc5872sv6IEjRCJfhpEOU83r3zJ50pjfznl1Cyvzxg/DB1ly/TWpuHv
 kVJ1EpryT3rQoj+sHzc5ONytrQG/GMQTzxqCqueBXb2zbLLvLQLcShPuNnpnS9pzbgY7
 dGsSBMiX1ugSGEtQ8Xj7l6zbvQzE4Eqbi82N3hFtM+ja38vK/AgUHA3kU7MkaTYu4AX6
 Dw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773426323; x=1774031123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 b=hExGPqfTPGjLBec1Q/RzdEJAZTJFD8WSAA0znPD2GTZqDwhAC7vzlvTAmIHVAl4x0D
 XrfR8CfMblbihiCoEK1lN73ZVtuIvdX23AEnbLdAMkGH8AJB98JsgRN5ABLlXYNgbYi5
 iG26nzg2PDJB9uy4L4YGbYEDd6x+MZPJbJZlRfvoufhhGCBV+2EI3enwNPUD62KJpT/Q
 j0WQzi/jjytmU3VjDVT1+MBQhG7W/t5UQt+m0xCuz1Yp+K6yezo1+uplMhj6zC5Ffs0D
 rR1J3xF64BW9h7fmUbvghRMC/8KpddUp9QEX60plhFxU+xtmNlcXxQP60oJjXg8LE2KU
 v2Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWQsve2pkmRIa1NVB1br2LrcFurBK1+iZ1TbpGd6FTPvvbgvMekF0g3IAz/3HJ792onn6DXJN9n/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAFBrtrcYnPUPIfP/kn61LrUfgX4qYpyWPlM4Bn+jQJEx4BEot
 4GUldsLp3g7bVMCRLIbBxF9xILEO5E1sD+n7Q/nTT0ju3WHV4xztFld6FdYdHZvcDRp4fWy+1HP
 iOKPGJXY466PZ4b/4TKNDau7PGFdTDs0=
X-Gm-Gg: ATEYQzww4y56ApAqidb1a4+NpF70xznlwATPccLXZw4jkOoC8iaCbR1/aSjuJQhIJHL
 jWyvAfqlqA2ijs/ozk6+8eKZu5noz34hAielhTy7D8ypz89m4AIJVNW6RyMdAmWBBPpZfiRStsj
 5luXMaeRkvyzQavPyJVqIPD7J9EygEhSCRNjE9I8swgFzAHNLpblKIPJihFBJ84qtGmyKJlllKP
 X+AaXX1nV95kfbWueRbnnUTFaOLFCDs7kCaVGSsPnbnGOI1xecqF21u4FxxE1VLbOeDvx/TmWBh
 utGzDYd5h5ANwKkYupYyuZ95Q1neoSekGFD3Bqj0A8bAv0Udd9Eyneu4yXaIzKccl3OfTg==
X-Received: by 2002:a05:7022:e1d:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-128f3c54944mr1003487c88.0.1773426322984; Fri, 13 Mar 2026
 11:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260311211837.2482799-1-alex.hung@amd.com>
 <15e4fec4-0bb7-41e2-9543-1b1df3905172@amd.com>
In-Reply-To: <15e4fec4-0bb7-41e2-9543-1b1df3905172@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 14:25:11 -0400
X-Gm-Features: AaiRm50caL1unr1QUXWg4Ne6w2il78NkCemnwIzCnwTbVvp2BgSUj7srZqa2V3k
Message-ID: <CADnq5_MhmgB0PzkpBqC33MoeEBDgYAghN=9LUBmczNeVat4AEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix gamma 2.2 colorop TFs
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 contact@emersion.fr, daniels@collabora.com, mwen@igalia.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Xaver Hugl <xaver.hugl@kde.org>
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

On Fri, Mar 13, 2026 at 10:44=E2=80=AFAM Harry Wentland <harry.wentland@amd=
.com> wrote:
>
>
>
> On 2026-03-11 17:18, Alex Hung wrote:
> > Use GAMMA22 for degamma/blend and GAMMA22_INV for shaper so
> > curves match the color pipeline.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5016
> > Tested-by: Xaver Hugl <xaver.hugl@kde.org>
> > Signed-off-by: Alex Hung <alex.hung@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > index d59ba82d3d7c..aa4658867e55 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > @@ -37,19 +37,19 @@ const u64 amdgpu_dm_supported_degam_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> >
> >  const u64 amdgpu_dm_supported_shaper_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> >
> >  const u64 amdgpu_dm_supported_blnd_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> >
> >  #define MAX_COLOR_PIPELINE_OPS 10
> >
>
