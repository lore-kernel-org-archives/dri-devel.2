Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96E7F54AAF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20ADD10E6AA;
	Tue, 24 Mar 2026 13:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4+bo43M";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AEF10E6AA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:18:12 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c0b6f22aa4so314302eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358291; cv=none;
 d=google.com; s=arc-20240605;
 b=UJ10MepBkcEaL5r4t8qWvHyL955esTOEeARZhURujEUCKF47ViNH45AA0Mm6utNBiI
 HKyP/QNNg6W9BfPn96m3nyGZjDhVGYzv+wiCWcD/zMXjpkxifaKIbY5vobdLFlbBQ8Oe
 bbcDtwfEiFAYWLrTzvGWQQ1BcXVDMUc7QN+RTD7WzRNhAq6b1OSYg+0ZttYcHimyT87H
 8r1aixtVKQtfThUSUK1TuNXO9jmFAKRDRtn/0rl9xqAqr98hZ4vPjZAISolAIl2G5dyW
 5uGnOLxiYX3OXxq32GTon6C6q2WniXcsYJP6q55AfNfYdmA6GTaSBFWZ3s0PaxK28BWr
 OjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 fh=/pD3SMLp5ExREQKicuW+Xgtg2F0B2t9yr3zKXKGBv0c=;
 b=XXQ1appqxJQnqQY3O2xDTJTqSq+wYWfBO3hNKfzBDlvqMFuw2GIuRkJFSJWq6wny3I
 U97bVOIQ+tAQHSGtWkYhz8SIjpq5XKdCTFmOxy4FZwalmlERJeqTyItB58+eqFIhEKBX
 A8WGqIp4FvQKfAwNJx4D5u4xz9enOj/fHb44ITATh6uytqBzsXnh4RkQTQf16uGdIZOk
 p6ce7hXcPQnFtCBFxj0j3CvuUAyuQlTlzTawtZMLNDpMLoxMs6f26+3r1GBvT0HDBwQY
 QyxTnnmbbBXRr1SkoUr99eOK3hHSoqDfJ8f4LOep/Z0ftofVt8SxfgXapGdskgaJnTGG
 17UQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358291; x=1774963091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 b=L4+bo43Mq2ZAc3gVesc4ULuc1B5ndhZWhoPFARm8BARVFTvDuz7KPF6+4U2qa1kHAN
 L1EoTwDgUvb6MjitKE/chLjWMVkzkgPwM0IL2xKQktkoOMY+3CJ8/8uRWLXKZ4OwEpl5
 2lvrdnxWBaGgvLPLVq77qXDqjJ81wPq4NYdvhi8K7wdk9MWURYTnnfUGlmTOnhJwedK1
 U4/DY4C0CA5FEgSdFsU+Yth5s0Bxuk8CUZWBSCrc6bO4wFdBYbfCP7fv82QpEbP5z2GQ
 0qwXeZl7bRpAYAmY2xVBjhy2eofVsGG4JKKMj1gd457hn3dFvuJ/y0PdK17XObFK+I6t
 vmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358291; x=1774963091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 b=NiZV8xZPQayE3Nt5sNfWg1HIYhLJ3avbQRvVOXbg5tzzzgv62b1pKN9jH5ycbjX+kU
 mTgesPuts6ACmloczvAHnZ7togVACaJjWFzbe8RF2BiyTdjoBRQ634Gxpyr6nKYUt+aW
 8MCrD2Xhzv5O38FbpnaXFOyTE8IDAus35vUAGtUlf++gUpgHEOwzuBtu0yFiE5NeKMpy
 /Pf5c/T3V6ewDly4+lnMTYLUIbcAVO1pa9F3r+e50cKmt7RtwwQzuANK2LY7INTf4Z4M
 y/QGLYy93YVToqjK4UgLzJsEuhw7CxTHI/3HX63DBGjwGguem3NrAG2sy8bD+kGwC5Wo
 KC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoi+cKjWA805wdiyf0Bn7Gwd4aIaWjDpV4stetzzO/3exDCU+MVSNfn7jDacqEiKSt5LvFSNgH2ao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRR4EDhXsrvUrJf5Joe9nvID1VDTppqtbPMD06HwJKbxQtYiye
 oaXx7xB5v5/AkVdye69rp7dbtTVrny0eKZDali99UdVTzdzIeop/GMXB5+i0kBUtL6j9jTEJBvG
 hkHaixxevVrjhAONApQthv2hZbHZWYk8=
X-Gm-Gg: ATEYQzyu2ZXD7f7ZLBIfqUINyHW6fdCpGKdEXziLKRKm70w1IaDjp9gypncKIK20m1m
 xAsQCgn3D9A8AEabKDr3AvDJjGeP1QrQJrYSz2rKjl9EV4FNY8MAjQEaEoJ3rRvhsk2wmsmj8xO
 zr4PsPLSbefGwpI6JFnfARqx+eHnBQ1+DlD6IPgOK87fe52y55sDW83Z9mm7QTimQo9IfIe2irq
 ecX33gvgPTdLcH6RVR2CSZFpackmR7/N/e5o1CCqdh20I7nxoy84hBvwjkG7mOj0hxnBtHWTGR4
 CMmBaWN5nIJ4VJFvSd65Di+hBkZDLO2RcYV1+bVim4drPzyG7BWwOab/a6HE3tnUmnzhTFzeXWg
 JoIcD
X-Received: by 2002:a05:7301:4442:b0:2be:7eb2:2ed3 with SMTP id
 5a478bee46e88-2c1095f6454mr3344144eec.1.1774358291324; Tue, 24 Mar 2026
 06:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260321105717.6212-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105717.6212-1-kexinsun@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:17:59 -0400
X-Gm-Features: AaiRm51BvxeAEOmeZZxEHJw085Bt5qt60MIORwpxuCeiZLkyyl9_4EF2NqW-WTs
Message-ID: <CADnq5_PATAoqfG9NMTB-dGxs0V+t6PA=jVvo=OkUDyNbqca3SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: update outdated comments for renamed
 vblank_control_worker()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com, 
 aurabindo.pillai@amd.com, ray.wu@amd.com, Wayne.Lin@amd.com, 
 timur.kristof@gmail.com, superm1@kernel.org, ivan.lipski@amd.com, 
 dominik.kaszewski@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
 ratnadiraw@smu.edu.sg
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

On Sat, Mar 21, 2026 at 7:14=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> The function vblank_control_worker() was renamed
> to amdgpu_dm_crtc_vblank_control_worker() by commit
> 6ce4f9ee25ff ("drm/amd/display: Add prefix to amdgpu crtc
> functions").  Update the two stale references in
> amdgpu_dm.c.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8ab6..c2b7b31b0d29 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9894,7 +9894,8 @@ static void amdgpu_dm_enable_self_refresh(struct am=
dgpu_crtc *acrtc_attach,
>                  * a vblank event disable request to enable PSR/RP. PSR S=
U/RP
>                  * can be enabled immediately once OS demonstrates an
>                  * adequate number of fast atomic commits to notify KMD
> -                * of update events. See `vblank_control_worker()`.
> +                * of update events.
> +                * See `amdgpu_dm_crtc_vblank_control_worker()`.
>                  */
>                 if (!vrr_active &&
>                     acrtc_attach->dm_irq_params.allow_sr_entry &&
> @@ -10062,8 +10063,9 @@ static void amdgpu_dm_commit_planes(struct drm_at=
omic_state *state,
>                         /*
>                          * If the dirty regions changed, PSR-SU need to b=
e disabled temporarily
>                          * and enabled it again after dirty regions are s=
table to avoid video glitch.
> -                        * PSR-SU will be enabled in vblank_control_worke=
r() if user pause the video
> -                        * during the PSR-SU was disabled.
> +                        * PSR-SU will be enabled in
> +                        * amdgpu_dm_crtc_vblank_control_worker() if user
> +                        * pause the video during the PSR-SU was disabled=
.
>                          */
>                         if (acrtc_state->stream->link->psr_settings.psr_v=
ersion >=3D DC_PSR_VERSION_SU_1 &&
>                             acrtc_attach->dm_irq_params.allow_sr_entry &&
> --
> 2.25.1
>
