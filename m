Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F62606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJG+4LeY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A3210EBD2;
	Mon,  2 Nov 2026 08:04:08 +0000 (UTC)
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B716810E3B6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:22:11 +0000 (UTC)
Received: by mail-wm2-f8.google.com with SMTP id
 5b1f17b1804b1-4a77811be24so14481845e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575330; x=1794180130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K4MSO6pcyXAftScjjOcAhCdWHBG+owT/f6hFef1DRbg=;
 b=WJG+4LeYr5qC+XohIR/nDZPKn2ED3DZ8qMQYxSi30CQk71UdtXwa1sifD6k4xgRwap
 lfLqzJzYKozs1MApC9oDHY0qFQ1nYmU1RYyEpYe4GUdEiQtjDvqOsu3eNYtgaz290/st
 QtHvntcXVfw0VqxNj6dQiC2aCneV1QXuQONWqSesE0D03IVI1Bc+yR0cqjqfjT0GAHo9
 51tXAnTd99HwZcXPV8Ck0z/Zjaq54OhJZVTi85qHMFDc/D+0FL+nEGc1T3wlfTZzBU8D
 PIzrPRs4d6EgIcVSNSKO/To5TvMET/PL9F9V3N55IS69XNwsPtEu+iQbG7mxzQk87+CH
 biXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575330; x=1794180130;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K4MSO6pcyXAftScjjOcAhCdWHBG+owT/f6hFef1DRbg=;
 b=E3RWvIHhZj+MNO/W5+yiqk53YGmJjdxaqzSdQC4K2yg3/4QzJv5GJYWQNJyqqMZIUv
 XiQGtW5D6Uq4mj/Y85YvKFB8SipgNNAuqZ8XTaSImvAjQkGn2WX1UZOoXF/V25s9VT+i
 tUmHbplK2/q47ybOdOuNhTThjOfOhcDwhr1TrYj6pQFmW1vEc3olyCvLQt/Dbkzq3IXt
 1Madlw6cErE18ow6t2wMvoEvxZa1AtFC6uDJOQmlgCbB6AqWbxQhXD1Dg/GQaW4DHBhb
 zxlq7Xk2egh9x7OSgP9FkidoIx20+1Fk0jOsSsT2gJY/+TEqqCt8R00XuT9eR2dqe2L4
 ZPAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaXWNngoVZUDZN8Nzvpl/JkiFE6hqf65PGDTZA5tCtr4P9Dzeg2w5IF1Ue2tSJPXvH4YFCmDYHzkc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwZzG9fjGN7Pdc3Pz80KYIocfPqXAc3Rxq+akv6mic/03cosNA
 ty9tssGPP/jTDeefs48J4rhpf6V9F69xxWZZ7LX50I7F9gBl6Ymsc2Xq
X-Gm-Gg: AYBFou3TM5B+pkE8YajuPJOnW6ywVwPZI/cFwwC4huBVL9heGshok6X/x+9Jrah8mrs
 leOfEqBbiK4K1dG0K6OWlndz3cU+3gQ8zDpShJnJXLk62aUJoHiuPhPCG0pEUwxtl8J81HOsolC
 0oTpWqeZ0rcSfwVTiJmgjfQs4jAASW4H+BTTeT5ceIesrhIHtyfdGwNRyzX/XeWKiwzcoHYJEY+
 d3G8Ae1lbkcQrWOkqupEuGdpTKMRHs00xbtOoRL63T2/LGS8zlg8HtRJNtj6ml77BOknSprOhkY
 hJ9XZteut2o9DJaVySNWqQPgNqKxtYvbN3QmWe+LeW+WbB93PUcVgwmFrvm93/MYXkPicWTaS/f
 CRrMSqdrevvqMd6xbH5h1RXM0EyBnuGMSaw/YnTfB3OrzjzvEn025YSwJ9k/+RbBrTEgq2MSlp7
 MZkl4K8WeApTYVDkora8gbNVSmxzXomLEDv0U2AlIm6b0UCvmuMFgnb1s3INu11qb/IYcuRAdi6
 EfWpEET982n+2ebDD1gil470n7MFIHWrBQyo1gH9bsHBBu0mmJsLxMD1s1aOWytxmnZjFPcONK3
 WjgFJVyA0IMxFSt4eFqBXG2I4IXrb897Ww==
X-Received: by 2002:a05:600c:198c:b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4ac151a9a36mr202114225e9.4.1793575329980; 
 Sun, 01 Nov 2026 15:22:09 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm367155575e9.3.2026.11.01.15.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 15:22:09 -0800 (PST)
Message-ID: <9c9310ca-9c2a-4aa3-b03c-83fbaf17710b@gmail.com>
Date: Sun, 1 Nov 2026 23:22:08 +0000
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
Subject: [PATCH v2 0/3] drm/amd: Enable 2x1 tiled display support on Apple 5K
 iMacs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
drive their internal 5120x2880 panel as a 2x1 tiled display using two
2560x2880 streams over an internal eDP root link and a secondary DP
link.

At boot, the Apple EFI firmware initializes only a single 2560x2880 pipe
and leaves the secondary DP tile unlatched with HPD deasserted. Because
the secondary tile reports HPD low and requires a vendor-specific DPCD
handshake before it responds as a DisplayPort sink, amdgpu currently
fails to detect the second tile, leaving Linux limited to single-tile
resolutions.

This series enables full 5120x2880 dual-tile operation on DCE < 12 Apple
5K iMacs so that the internal 5K panel behaves like a standard DisplayID
tiled monitor:

1. Calculate the pre-OS framebuffer reservation in GMC v7 and v8 using
   mmGRPH_PITCH and the mmGRPH_PRIMARY_SURFACE_ADDRESS offset from
   vram_start so the full [3 MiB, 59.25 MiB) Apple EFI scanout surface
   is preserved during boot handover without vendor-specific quirks.
2. Point the secondary DP link to the root eDP link via an EDID quirk on
   DCE < 12 (covering iMac15,1, iMac17,1, iMac18,3, and Polaris-based
   iMac19,1), latch the secondary tile via DPCD 0x4F1 on the root eDP
   link, write the 3-byte Boot Camp source table (0x310) on the
   secondary link, keep the secondary tile out of D3 power-down, and
   unlatch the TCON back to single-pipe mode on suspend/shutdown. Once
   unlocked, DRM's DisplayID parser populates has_tile, tile_group, and
   tile_is_single_monitor on both connectors natively. (DCE >= 12
   support for Vega-equipped iMac19,1, iMacPro1,1, and 2020 iMac20,x is
   noted as TODO.)
3. Report all_displays_in_sync = true to PowerPlay after
   dc_commit_streams() whenever all active streams are synchronized into
   a single timing group by program_timing_sync()
   (timing_sync_info.group_size == params.stream_count), allowing SMU7
   to downclock MCLK at idle without modeset underflows.

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
  drm/amd/display: unlock secondary tile on Apple 5K iMac panels
  drm/amd/display: report synced displays to PowerPlay for MCLK switch

 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  8 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 ++++-
 .../dc/link/protocols/link_dp_capability.c    |  4 +++
 .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
 8 files changed, 75 insertions(+), 7 deletions(-)

-- 
2.55.0
