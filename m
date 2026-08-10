Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68787C5B567
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B393610E220;
	Mon, 10 Aug 2026 19:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XaDfzBQC";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E30810E983
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 19:16:14 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cad68425a7so2956645ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786389373; cv=none;
 d=google.com; s=arc-20260327;
 b=QXw6odTkb58+WwOKv73m0NlXyP+AzOqXs3xu6U4z1e4aR5UtwZXQlTL3dbNspq1dpg
 8nW3y9iSBjj2mC4b6eoGlRajyEKTBNaBh3y1ZuBj/u0O1bvJcxgFkntlFHAt1CEmrOCc
 c0ynFFu4vt6QGeZn6OLl063ZuE83ygzalsp+J07oHgEu+VSZGo+701EHMqf0i522KoyS
 9nl0eEf1TiUxuKKpe1xEUxeB6CAS0nVtKup1ka3+LoJfePvOtqgiWmAc9ox+76Q/LZ4J
 mkFZikTc/Fa+crHXHxr3r5UBJV89qcKVWfWJ9EiSDjiEAMkVjGF/uN8/8W+ECQl/HaQS
 35HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 fh=BeE8eaZWYc4u8bW+r5LvsS8zwra9QIeDmyCOdzZHEm0=;
 b=dBpFfc95B7MsDcBVvVSO1qrCGuYcM6l9XUjk/tHzyRFP+EFoDNEBtVXgK9xRrzkEOu
 16ZZrMzHPsBUi5GLrRoednsytwRQHvFx4WC9dfXQDUfxWyp+RP66iw+wjDVzY64dcYw8
 pnEC7RJqXVVNUICr1EBk6x/S+zEdFgs7lcY6JVYDtdwm+tASrYI9IBrUMQQcuAu4ne2/
 agBYFqx7LarRn8yg4BGHApu7mlVAVoS7vtzAasmM27r+PYDTKEKFrwit+uOj3bihF20r
 vh7Ppf+Xy35hIasKDVi5tbGivtPIUGwUoY6IWucA5/xH8PRDLu8aAT/7onj0OKeaQ4UN
 Ay5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786389373; x=1786994173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 b=XaDfzBQC7lY0qq9CtZHFxqHWcUGOQzkpbj10s8+Q6r3kmwBLvYKebTfccx8fsQpX6F
 zM8oSEn0ooMj2eCRMOxkYPAnMmFTQ2kDO3irtGF1es9X/+vm+Ud3kCxffAGJJTuxn/rD
 KMWWSEKeuwqX7htfYnKdHaI2pBAewWTUwGXgVZe7MSlFzniRyNxEc+yznzk1pEvDC7WP
 ygmxnbZF7jshzupp3OrqksRRhFvdoUwB+rRHkMNiJyRhcqW3IMj2xsx9EN1XYK9bJQX5
 JwdC73t2KwM6QTJBYVLLZAmFIMPWcrwcOJkW/iVQmyS0d/Z7nAazRRcYh8frF2dcMeEL
 oxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786389373; x=1786994173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 b=sceo22ohR/59+ymabCfp9V3a6J3uO+0EBcRb1l4iVuQhG4R+z+503w0M8FhJKNigtm
 Ap5mxXkm4nBWUjNiTK9QwbCRbVKSUMB+m8DzuaqEuftowliXdwR+FNPVG3Trq46Wn6X2
 bzbgHW1DA2r5CXXPGw0AMyuW4EcuGO1mAm3mnTie2PvJnMPL34Si6mriLRb66xw+aYS6
 QDtmEUVRAQjFDMul8XMiFWW4UfekFJ1T84uAEwg0CFj7gsmtFswipvlQDBNdv1RA/RYS
 r/pIaOihNLqX63jeVQsZmPj3R5QIR58qrv4P8zDAZrW1rJvqrZWFuekmVhZHx89cyfGn
 YbCg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq85YLOvdYu77ZumNXxA6pedWrHtOR806XB3EFDXyJdLIYzS2Dg94JuGsjcE687xtu0KYumwfnZDQo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgLNfpEgPiJfVnIMLDg4l0tI7HUxb8xeXJVIcbejJNY/5tdMd8
 /PPcxwLH1ys0M8UoYSCXJ97ixxBEfMHIDC0rk068OZH5f3rp1bZsP7zggVYGXMto30e7V9LZBJ7
 z2gRz+1U7gP36FduCbu6X+oqiTQYj4f4=
X-Gm-Gg: AR+sD12sTs68vmRurhHB9rAyZ3w50j+TVDS56gAOgEgDrv23KJqUkQ7vgKGtIv0AQDL
 7VyRtqRac7O6PNwmy+YSEP+NXgg+w3GFbtWaL6zBtZQ6A2wgeOvKsH2T1Q9sGfp7durdfmTo4Xz
 6Yut66dZSQ6pLKEzFTgfLcWrmYHd0KEMVLJExe8vRMx4QWAdY5DvmD5DU5lo/ijybeBArvzFHZh
 I6bw9EkZ5frlOspXUGtEL+DklV7ujaHJ6njxudT6siKXBd2qgJwSl4L3ANPB9QPMvYpK5B3qOr2
 5Ooa0qYdcSsSs4WAagCy+/+8k7tEvxNGMyhsKlZyfhWx7O3jigDQkiISXeMorlj6bB3zW/3/nae
 gxhQHfCwg1jypmsQaiMA3OcAnMUx6Mdw=
X-Received: by 2002:a17:90b:278c:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-3903c776ae3mr32451041a91.4.1786389373401; Mon, 10 Aug 2026
 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785616749.git.nlucasgit@gmail.com>
In-Reply-To: <cover.1785616749.git.nlucasgit@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 15:16:01 -0400
X-Gm-Features: AUfX_mwrEJIp4EMHkXnoK416XqZ0pGnbbA8pXDtHVtlj5DDXVcVLCr8qek9F3n4
Message-ID: <CADnq5_NMWdV_zy6xJUtkdLGxXSCe2vfGp=Kc0kH_Rqg1SAV2Kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd/display: fix BT.2020 YCbCr output CSC matrices
To: Nathan Lucas <nlucasgit@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, joshua@froggi.es, 
 mwen@igalia.com, leorize+oss@disroot.org, alex.hung@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied the series.  Thanks!

Alex

On Sun, Aug 2, 2026 at 10:35=E2=80=AFAM Nathan Lucas <nlucasgit@gmail.com> =
wrote:
>
> This patch series fixes COLOR_SPACE_YCBCR2020_TYPE in dc_hw_sequencer.c
> which is used for COLOR_SPACE_2020_YCBCR_LIMITED output but does not have
> correct luma and chroma scaling for that output range, and fixes its
> copies in dce_transform.c and dce110_opp_csc_v.c.
>
> It looks like this matrix was originally added in commit 40df2f809e8f
> ("drm/amd/display: color space ycbcr709 support") as a raw BT.2020-NCL RG=
B
> to YCbCr conversion matrix that had not yet been prepared for unsigned
> limited or full-range quantization.  Commit 973a9c810c78
> ("drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix") applied offset=
s
> for unsigned limited-range quantization but did not fix the luma and chro=
ma
> scales which are still full range.  Because of this, output on a calibrat=
ed
> display is too bright with incorrect color, although it still looks rough=
ly
> correct at low luminance in my testing.
>
> Later, in commit 51e6668ab4ba
> ("drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs"), the
> incorrect COLOR_SPACE_YCBCR2020_TYPE matrix coefficients were duplicated =
to
> DCE COLOR_SPACE_2020_YCBCR_LIMITED and COLOR_SPACE_2020_YCBCR_FULL, so
> those matrices are also currently incorrect.
>
> The first patch adds separate matrices for full and limited-range.  The
> derivation is in the commit message.  The second patch replaces the copie=
d
> matrix coefficients in dce_transform.c and dce110_opp_csc_v.c with the ne=
w
> ones.
>
> For testing I have only been able to check the limited-range DCN path on =
a
> 9070 XT with a patched kernel.  amdgpu_dm_get_output_color_space does not
> currently have a path to select COLOR_SPACE_2020_YCBCR_FULL although the
> enum value exists.  Also, I cannot test the DCE paths as I do not have th=
e
> hardware to do so.
>
> I ran into this issue measuring PQ test patterns through mpv with the
> following command line:
>
> mpv \
>   --no-config \
>   --vo=3Dgpu-next \
>   --gpu-context=3Ddisplayvk \
>   --gpu-api=3Dvulkan \
>   --vulkan-display-plane=3D3 \
>   --vulkan-display-mode=3D22 \
>   --target-trc=3Dpq \
>   --target-prim=3Dbt.2020 \
>   --target-colorspace-hint-mode=3Dsource \
>   --target-colorspace-hint=3Dyes \
>   --tone-mapping=3Dclip \
>   --hdr-compute-peak=3Dno \
>   [pattern file]
>
> Free test patterns:
> https://diversifiedvideosolutions.com/hdr-10.html
>
> Below is a table of values I measured on a Samsung S95H (US model) with a
> Calibrite Display Pro HL meter.
>
> Three sets of meter readings below:
> Unpatched - Unpatched Fedora 44 kernel 7.1.4-200.fc44.x86_64
> Patched   - The patches in these e-mails applied to Fedora 44 kernel
>             7.1.4-200.fc44.x86_64
> NVS/Kodi  - NVIDIA Shield Pro with Kodi
>
>  5% HDR10/PQ
>  Test Pattern        Meter Readings (nits)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PQ%       Nits   Unpatched   Patched   NVS/Kodi
> 15        1.01        1.63      1.01     1.02
> 25        5.24        9.68      5.46     5.12
> 35       18.78       40        20.5     21.2
> 45       56.55      128        62.0     62.1
> 55      148.03      369       155      155
> 65      384.71     1106       403      401
> 75      973.13     2681*     1030     1025
>
> * This is at the peak capability for this TV.
>
> PQ brightness overtracks a bit in Patched and NVS/Kodi, but that is likel=
y
> due to the TV's default calibration or my meter since the readings are so
> similar.  Unpatched stands out as being way too bright.
>
> Nathan Lucas (2):
>   drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
>   drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE
>
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 ++++++++++++-------
>  .../drm/amd/display/dc/dce/dce_transform.c    |  7 +++--
>  .../amd/display/dc/dce110/dce110_opp_csc_v.c  |  7 +++--
>  3 files changed, 28 insertions(+), 17 deletions(-)
>
> --
> 2.55.0
>
