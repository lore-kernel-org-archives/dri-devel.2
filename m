Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69574606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiOYoVjP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3A710FD6D;
	Wed, 25 Nov 2026 16:01:47 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9EE10FD63
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:01:41 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-703e2625ce6so218027eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:01:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795622500; cv=none;
 d=google.com; s=arc-20260327;
 b=P1NGB+sYjyfwJS9ggkAJqHH20rPLaoRCsvP7ZrsRYHwSFZs+TByHK/SE2z990n90NO
 br1/axFAA0pVyRtQtX3slsQkHUKR//8D88NMECs0n80RNo3nQGhV+w5Wyzzn7s0QBem/
 ACdKBI8yB3XNzwc1pdLnNyTkMxKIrknekJq/9iueUCdes4XNxOeOirp+iY0UuxQLwyHI
 HtAInirCZLPch4Mf2F20DozurI2NAEjwfYb10vD7PiO47SlykTQw2xj7JvZ6Lktodt4+
 u1r48XnSgMyA+9y+V7rxdYe6mPZBwopQ1XaxmfHeqTLGm40oCx8ha38FaDBcpZtcxe44
 laNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fI4P20bQCmfh6R7YugF4cBFoiAc+EQcossZkRSNDFiM=;
 fh=eNSPyX2+hUhP9MQVprUi2lKzrzWA8wHb7iI5vT8Pxro=;
 b=sY5tPbH/293J5Nsl5Wxj8iY+BbR/AR/w4CwTkwNk7IJDTjk62soHIFPpmETFnP5TQz
 jMVnesC9vOS6Gyaj403VDnm4Kb2w7OTA7IRA9YuSl8MPRvKzYDegz3AbJ8402010kvxY
 76qeWDIMLN1KMlK+vFX2+SfhtBHZSJjF2VIs6BzU43XNoWGvZqVyWrebdQ/vpUi9avmZ
 FoFWC0iFqEON+HIBaMLYquQ9k/nwsc8724lF4PmSLh5E5yIU0HKFJaG3A5jnT0O2Cejt
 sXrNJ10VTadxmXTGYlW3Cl0usYsVPAr7wXRGRWqpzDQIY4UZga0GyLwM7ULbWgqQHTfm
 EQWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795622500; x=1796227300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fI4P20bQCmfh6R7YugF4cBFoiAc+EQcossZkRSNDFiM=;
 b=wiOYoVjPbS1MftjCO+bBEP4PsxnKTwEhv710g5WS6RjIKbotbgZ6WLS14n1SSfpHI7
 tNxfC6nOw8uHf24RFdLrKK0bcD/B9znhkfEJVjETS3cLSMhmjChUPNIs6wclbL5FsV23
 3/AMGkiNg3Bf19DCjHzUK1MYOBz9yrxvJ1dwfn/syGOI54t5br/jYJ20may3g2tW35Cm
 iKwMy8V6Ru4yps30F5/2RCs8FCrnERM8CZR0pGJ5oSPxsh6T+GuVGNf0mPldLBZOE3Ec
 m0+9iwwgJ1uOMTDgm1wP1qE4WnNHpGNRV5DbxnTpLefgEs2kezmrChsdymUlGrDRNVUX
 i3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795622500; x=1796227300;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fI4P20bQCmfh6R7YugF4cBFoiAc+EQcossZkRSNDFiM=;
 b=LuCnEyVGn82LSaeS6tigWi1y+YZPJk/Jxjz3d/vlKL2rmxw7w+ONKhSIoCUi9N9WvI
 Kw1gKLjxnHkr6chzEOjjDtaWdQBfQNXaH+YO955AiJlwyZQ8wGPmDEv0i8hm/9/7o3a8
 bC0lqB+Ge3JTOcz3yUo4Ayk0DUM9o0nONwbr99Nxrk+OY8QqDLMSQOGt0H6g7NbNS8lH
 v1XaN2Y07x0ePbNoTDZDI59ZFZ7P6Pkdbi5n+/7Xhux5m24ONLorzPsb8QSXXSnjgPxe
 TAaKf9io+h1JRm3buJ658mivfFm6mMuq/GoW0Vl0zYPC1Klt9dAwH/QneoKHC5PmHvS0
 8Flg==
X-Forwarded-Encrypted: i=1;
 AL+hErHA49XdCiFsXXvQZMJPWkpnT1rST2lRVV2HqDZdoD3O+GQWzfrczRY4MJ6y5sLXmHY3taqmXsEX9zw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bGkylSU9N1mj5oH1PlGSqg/A5jebVUQ9sykevhPP/hqcSnnzz
 PHJnTYIjHpMNM1AC3f86rsbUAYTQWmPqnvnrkqX1GpUEPeRlU1ewadm+3+OO9kQA4qohwbYvDGY
 5ps29aoL6dHaVcvDQH72PgnvFkOBkypU=
X-Gm-Gg: AZFdTZf9GC/W1EVAgODQznvsn+vWWL6NDG/qXK9Og2O+zbi/5mHOx3zTISAuQHmloMA
 kaY7UkZ+VqfWQmCG2HTBGT5pg7dmQ0Tab0hG4AD9eXi3Oh221kezjNVX8pq66m+O72dGUQzknnU
 m9EgkK6RZiRdGmEKT9DcURnsKnTJaB9VvkCM4ohf2v8fEpUmYBE1MGa8ZHte+Hf3YfbmLunplBS
 Ae2F+9UevuC5p/DW8hdEmk/5+qHdpCVFyiTsIZKJvjW8YJIrK40yEn+0o/KVZvLK1ZJh0nT2Mgh
 4rWtTeoUTLALSKdJGZQAtdlZtQogEwxw4QMwqTjiS3Pe5+Oeg5Eo4dcN5VK1rBJP7LcRvcUw6sZ
 U1PYYbCwe5VzqJbjiYsa6wPPZ6GP2C5Fs8XFspw4NFZ+jEGQBacitha69T5XldrdVxDHtUA6YZd
 vYexyjCkkFkVD/kH27hLN+QxDio6XLGAetSwke9akim3FXtNn4XKFICxUkaYo=
X-Received: by 2002:a05:6820:840d:b0:71a:ee8a:5d26 with SMTP id
 006d021491bc7-71b3903669fmr16310397eaf.0.1795622499664; Wed, 25 Nov 2026
 08:01:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8342fe8e-5c52-408e-a2f5-0f04b10f332e@gmail.com>
In-Reply-To: <8342fe8e-5c52-408e-a2f5-0f04b10f332e@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Nov 2026 11:01:28 -0500
X-Gm-Features: Aa3M54rIbsxve4YKvieiQM2tewmvhaZrVPRdb31u5oTtH2lIeVSsCz--7sCAIE8
Message-ID: <CADnq5_ObYb3d7V=cp7bm8qOoPi7bp9+B8LxPcx-0DiNxvJ=d5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/amd: Enable 2x1 tiled display support on Apple
 Retina iMacs
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 8:06=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> Hi folks,
>
> Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
> iMac18,3, Polaris-based iMac19,1) Retina iMacs drive their internal
> 4096x2304 or 5120x2880 panel as a 2x1 tiled display using two streams
> over an internal eDP root link and a secondary DP link.
>
> At boot, the Apple EFI firmware initializes only a single pipe and
> leaves the secondary DP tile unlatched with HPD deasserted. Because the
> secondary tile reports HPD low and requires a vendor-specific DPCD
> handshake before it responds as a DisplayPort sink, amdgpu currently
> fails to detect the second tile, leaving Linux limited to single-tile
> resolutions.
>
> This series enables full dual-tile operation on DCE < 12 Apple 4K/5K
> Retina iMacs so that the internal panel behaves like a standard
> DisplayID tiled monitor:
>
> 1. Calculate the pre-OS framebuffer reservation in GMC v7 and v8 using
>    mmGRPH_PITCH and the mmGRPH_PRIMARY_SURFACE_ADDRESS offset from
>    vram_start so the full relocated Apple EFI scanout surface is
>    preserved during boot handover without vendor-specific quirks.
> 2. Latch the root eDP link via DPCD 0x4F1 prior to EDID read on Apple
>    hardware (DCE < 12), point the secondary DP link to the root eDP
>    link (apple_imac_peer) via an EDID quirk covering 4K and 5K Retina
>    iMacs, latch the secondary tile via DPCD 0x4F1 on the root eDP link,
>    write the 3-byte Boot Camp source table (0x310) on the secondary
>    link, keep the secondary tile out of D3 power-down, and unlatch the
>    TCON back to single-pipe mode on suspend/shutdown. Once unlocked,
>    DRM's DisplayID parser populates has_tile, tile_group, and
>    tile_is_single_monitor on both connectors natively. (DCE >=3D 12
>    support for Vega-equipped iMac19,1, iMacPro1,1, and 2020 iMac20,x is
>    noted as TODO.)
> 3. Compute context->bw_ctx.bw.dce.all_displays_in_sync in
>    dce100_validate_bandwidth() using
>    resource_are_streams_timing_synchronizable() and copy it to
>    pp_display_cfg->all_displays_in_sync in
>    dce_pplib_apply_display_requirements(), matching the existing DCE 11
>    bw_calcs() flow so SMU7 can downclock MCLK at idle on DCE <=3D 10
>    without modeset underflows.

I've reviewed and applied patches 1 and 3.  I had a question on patch 2.

Alex

>
> Changes in v3:
> - Patch 2: Added pre-EDID DPCD 0x4F1 latch on the root eDP link in
>   dm_helpers_read_local_edid() so dual-tile detection works even when
>   third party bootloaders are not present on the EFI partition. Added
>   21.5" 4K Retina iMac panel IDs (AE19/1A for iMac18,2 and iMac19,2)
>   and renamed apple_5k_peer / amdgpu_dm_apple5k_unlatch() to
>   apple_imac_peer / amdgpu_dm_apple_imac_unlatch().
> - Patch 3: Dropped the dm_pp_apply_display_requirements() call in
>   amdgpu_dm.c and instead computed all_displays_in_sync in
>   dce100_validate_bandwidth() and copied it in
>   dce_pplib_apply_display_requirements() (dce_clk_mgr.c) to match the
>   existing DCE 11 bw_calcs() path.
>
> Changes in v2:
> - Patch 1: Replaced the hardcoded 64 MiB Apple quirk in amdgpu_gmc.c
>   with a generic calculation in gmc_v7_0_get_vbios_fb_size() and
>   gmc_v8_0_get_vbios_fb_size() using mmGRPH_PITCH and
>   mmGRPH_PRIMARY_SURFACE_ADDRESS.
> - Patch 2: Dropped the DRM_MODE_CONNECTOR_eDP override in
>   amdgpu_dm_connector.c in favor of DRM's native DisplayID tile
>   properties (has_tile, tile_group, tile_is_single_monitor).
>   Renamed tiled_peer to apple_5k_peer and set it only on the secondary
>   DP link, removing dm_helpers_wire_tiled_peer(),
>   dc_link_is_apple_5k_secondary(), and inline explanatory comments.
> - Patch 3: Made the PowerPlay sync check generic for any combination of
>   synchronized displays by checking timing_sync_info.group_size =3D=3D
>   params.stream_count instead of tiled_peer.
>
> Regards,
> Richard
>
> Richard Lane (3):
>   drm/amdgpu: use pitch and surface offset for GMC v7/v8 fb size
>   drm/amd/display: unlock secondary tile on Apple 4K/5K iMac panels
>   drm/amd/display: report synced displays to PowerPlay on DCE <=3D 10
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  8 +++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  8 +++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  3 ++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
>  .../dc/link/protocols/link_dp_capability.c    |  4 +++
>  .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
>  .../dc/resource/dce100/dce100_resource.c      |  9 +++++
>  10 files changed, 89 insertions(+), 7 deletions(-)
>
> --
> 2.55.0
