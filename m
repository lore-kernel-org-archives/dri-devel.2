Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65574606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0te2y17
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA53A10E8CC;
	Wed, 25 Nov 2026 01:00:44 +0000 (UTC)
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com
 [74.125.225.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39E710E8D8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:00:38 +0000 (UTC)
Received: by mail-wm2-f10.google.com with SMTP id
 5b1f17b1804b1-4b80834ce1aso7711495e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795568437; x=1796173237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4ztWU0LVXdWdRsX5K6cCqmpXvJ1UHD07jKNkG2vEvTY=;
 b=q0te2y17Q11mrYs0obDfFVfwNnSGwDcYhUAxx+adjSJ68ocrSrHat2fjhGj5QzY+51
 2s/sJiP19CQWHlVdUfTLBnIaP/yViexQn//B95TKVr/jCUo5RsRS3rFU5OdWL8G4gCLa
 kEsU616qO3o2fvLBqkNH4wWBuJfWLUEork7w10B918vvOeklh1ORYw56D7qQl3KaRj7V
 PVvSusMOh4gh6LlQvRJXjK25urcDP2zBqI0GrX2rJGytM0t+NY1IdJKisgr9lHTb8lJb
 QvS2WPYpm6MMqZKXdFXeQHXWWp7zVJqyxUBU25OsIoEr3Ve7uPOyQFvg9nHMXe3OGaoP
 VSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795568437; x=1796173237;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ztWU0LVXdWdRsX5K6cCqmpXvJ1UHD07jKNkG2vEvTY=;
 b=a2+W9z0Odm42wepBjCTFss6uz0FF/AWhQ3PAupirv9NR8zBc3ZXQxkZ0QGWkUVt4ox
 bmv8GmcK3hYcQvcN/1AG1owgGM3bxMXqc4fhcOKIsGDe4NiribvPqBEcxZBHyIjoDnXy
 hfFf8L8sB+BJOqcPsFEWLlx9ymZpr+DGVQlG1p9Gxu3xrTUdEItHXBZLEfnJX3p21cAa
 o1COyttwygp3C3Jfvx+zTRSZ9UjEyh6mjGBiwobXlDd13Zv7eRDqgHHWxWVaIpUZH6Ye
 xo7HcFtnkVk/AY6eD4f10j5itDVygBEYK6vG4MC9hBZmc1lC2DY/h0+z8IL7HONCEPBq
 FzTA==
X-Forwarded-Encrypted: i=1;
 AL+hErEsGIxyDjTYhoyIXHthhZiJL5h0LkLhvGIbfwcjhaJxMHXz7JksTYhk5c30TUVTJLZHi2I8Brfgt0A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ESkD5drcuOpEsSO9ndnaXjKWxXC5o6ChU2KISKIhsxSTN1sGo
 7Krukj0yzvjYYra0jn0tO+HoyR2IT3J4q2pYfOFoMeaYUMgAUQ8drvxJ
X-Gm-Gg: AZFdTZf8maagpQCsv1kD/7FHvO3jx2WyOzLm1LBGKkeTNbK3N+m71yjJzZ5Uc1eJ5vF
 Eqi9g5/NESmvNuy0nuuC7r+tUqWf3ASZX1ARy5nsSPdIoewUGCuBDXfTHrzAskVsWEAhHdel3et
 c5hWW+bwdUeLEWSABnB1ZRSUB1ye/t/UR4HCHw99EerHkd7oRBBNg/WhGJRHTZ4GVd0801ldm2U
 5ij5yfVl+LlOljgBbYog5SZrn17wO/a4JF2Nvv0KI67658mH3TWnHIm+IeLPMNSErZEJ5JQIE3m
 A+lGwuwlCHHi3+Dy5vUZSqEg2nx1r1l96tNb6VT2+H7lODcRfl6CE1+w1gmffYoUotgl4Jo5GyJ
 lrtnhdZTxSpdwqdqFI051++kfroknZfZOZhnDI9vOV1ngJ4i2BQHh4doa2g6IqOIhH4suYd6bEy
 t2d704YksZoWUKB/Xlu5Z0kap0VPbFFEerj7K9s019RXLkRRQoOtkXY7oBAmBQlEgEzbNqrZLge
 WN6dZDP48p2PNQ1KPVC2Q7Prwi+Q8scn/Cuo0MThe4d8WU9uHJvB8g++zWlwlIqc+qz8aCmi7qQ
 4VwL5mRjRBgqd+Py4Hm6s54m/bvGiwZ53e/6
X-Received: by 2002:a5d:64c4:0:b0:48e:7b12:ac9f with SMTP id
 ffacd0b85a97d-4abb5fa17f2mr31649016f8f.40.1795568436905; 
 Tue, 24 Nov 2026 17:00:36 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm32363611f8f.8.2026.11.24.17.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 17:00:36 -0800 (PST)
Message-ID: <8342fe8e-5c52-408e-a2f5-0f04b10f332e@gmail.com>
Date: Wed, 25 Nov 2026 01:00:33 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v3 0/3] drm/amd: Enable 2x1 tiled display support on Apple
 Retina iMacs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
iMac18,3, Polaris-based iMac19,1) Retina iMacs drive their internal
4096x2304 or 5120x2880 panel as a 2x1 tiled display using two streams
over an internal eDP root link and a secondary DP link.

At boot, the Apple EFI firmware initializes only a single pipe and
leaves the secondary DP tile unlatched with HPD deasserted. Because the
secondary tile reports HPD low and requires a vendor-specific DPCD
handshake before it responds as a DisplayPort sink, amdgpu currently
fails to detect the second tile, leaving Linux limited to single-tile
resolutions.

This series enables full dual-tile operation on DCE < 12 Apple 4K/5K
Retina iMacs so that the internal panel behaves like a standard
DisplayID tiled monitor:

1. Calculate the pre-OS framebuffer reservation in GMC v7 and v8 using
   mmGRPH_PITCH and the mmGRPH_PRIMARY_SURFACE_ADDRESS offset from
   vram_start so the full relocated Apple EFI scanout surface is
   preserved during boot handover without vendor-specific quirks.
2. Latch the root eDP link via DPCD 0x4F1 prior to EDID read on Apple
   hardware (DCE < 12), point the secondary DP link to the root eDP
   link (apple_imac_peer) via an EDID quirk covering 4K and 5K Retina
   iMacs, latch the secondary tile via DPCD 0x4F1 on the root eDP link,
   write the 3-byte Boot Camp source table (0x310) on the secondary
   link, keep the secondary tile out of D3 power-down, and unlatch the
   TCON back to single-pipe mode on suspend/shutdown. Once unlocked,
   DRM's DisplayID parser populates has_tile, tile_group, and
   tile_is_single_monitor on both connectors natively. (DCE >= 12
   support for Vega-equipped iMac19,1, iMacPro1,1, and 2020 iMac20,x is
   noted as TODO.)
3. Compute context->bw_ctx.bw.dce.all_displays_in_sync in
   dce100_validate_bandwidth() using
   resource_are_streams_timing_synchronizable() and copy it to
   pp_display_cfg->all_displays_in_sync in
   dce_pplib_apply_display_requirements(), matching the existing DCE 11
   bw_calcs() flow so SMU7 can downclock MCLK at idle on DCE <= 10
   without modeset underflows.

Changes in v3:
- Patch 2: Added pre-EDID DPCD 0x4F1 latch on the root eDP link in
  dm_helpers_read_local_edid() so dual-tile detection works even when
  third party bootloaders are not present on the EFI partition. Added
  21.5" 4K Retina iMac panel IDs (AE19/1A for iMac18,2 and iMac19,2)
  and renamed apple_5k_peer / amdgpu_dm_apple5k_unlatch() to
  apple_imac_peer / amdgpu_dm_apple_imac_unlatch().
- Patch 3: Dropped the dm_pp_apply_display_requirements() call in
  amdgpu_dm.c and instead computed all_displays_in_sync in
  dce100_validate_bandwidth() and copied it in
  dce_pplib_apply_display_requirements() (dce_clk_mgr.c) to match the
  existing DCE 11 bw_calcs() path.

Changes in v2:
- Patch 1: Replaced the hardcoded 64 MiB Apple quirk in amdgpu_gmc.c
  with a generic calculation in gmc_v7_0_get_vbios_fb_size() and
  gmc_v8_0_get_vbios_fb_size() using mmGRPH_PITCH and
  mmGRPH_PRIMARY_SURFACE_ADDRESS.
- Patch 2: Dropped the DRM_MODE_CONNECTOR_eDP override in
  amdgpu_dm_connector.c in favor of DRM's native DisplayID tile
  properties (has_tile, tile_group, tile_is_single_monitor).
  Renamed tiled_peer to apple_5k_peer and set it only on the secondary
  DP link, removing dm_helpers_wire_tiled_peer(),
  dc_link_is_apple_5k_secondary(), and inline explanatory comments.
- Patch 3: Made the PowerPlay sync check generic for any combination of
  synchronized displays by checking timing_sync_info.group_size ==
  params.stream_count instead of tiled_peer.

Regards,
Richard

Richard Lane (3):
  drm/amdgpu: use pitch and surface offset for GMC v7/v8 fb size
  drm/amd/display: unlock secondary tile on Apple 4K/5K iMac panels
  drm/amd/display: report synced displays to PowerPlay on DCE <= 10

 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  8 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
 .../dc/link/protocols/link_dp_capability.c    |  4 +++
 .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
 .../dc/resource/dce100/dce100_resource.c      |  9 +++++
 10 files changed, 89 insertions(+), 7 deletions(-)

-- 
2.55.0
