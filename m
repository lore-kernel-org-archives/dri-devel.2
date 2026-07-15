Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFAAC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2620B10EFAB;
	Wed, 15 Jul 2026 10:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5zEUM9Q";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DB910EFAA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:58:03 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so306195f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113082; x=1784717882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+9OlOuI/USMeVEuGNjemjSs9+FlhS95mQyQ5/NIJRXg=;
 b=T5zEUM9QrA8lBt3trm8XCjeWaAWQvq+9NynjWdzTuKf6GALYqBt6LjVbBQx34RpnWL
 CWaQoB9h376WCr7AO7ef+YLtGLIWeySs3Qj5p6sa5XWm7nExNfP0Ak8qusRM8oGxXLki
 Mu54DrPtL0RmQzhYg2EtmVb+P/MLuANmSb7NT4/V/76QLdQk/Tlrg/UDeRJZ1q/06jqq
 dj4lxRlmaAz6Zo9v1oNIgRQvBd0RtO1T6I8nNlKSkJRw+GT9HYV7kT341Gvj2B70FfrH
 fVWWwfeTcAH7YaI19yEj/RJIztiIiXsWRgYS6kpaOJBscs3cFi/J+gsDazzfs/eCJsQ6
 5MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113082; x=1784717882;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+9OlOuI/USMeVEuGNjemjSs9+FlhS95mQyQ5/NIJRXg=;
 b=NcwU7mRnNw2l2xvOAXQD9OwydATHCPEOWA7JCzvRSKrJNGXlxwTrNZV1hUtzY/tIng
 763s0Hqf1czGCn44BZcZeYGa2E7ppkKjBSUmX78SkW+ZidiSRlbKFTdTTGRFhmKekjK1
 nE+d6L9g5ae3oywkB9EIl8UmFi/AhvRtbQDW4qHlIP1X3wE08XEwKEqnpE7qi0JeBc74
 uZebjG+Ko2byxIDTwggcB1bF1CeqHsntzXT7RUEVw/tEwUlfmjmOmJ1CdJmb5wB2RB1R
 JBftrD6JCaqqLqo/BklKHqn9uaz9SlHgV7TEwI6+ZSliYw6qPSO/tz5V7qO+gHGjoHC7
 ocgw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp05aFJQOzoiQxtkXDe6t9OjGEVcvZe3VVpgM3G7NG1h9ECuKB9gejqyyoQupb26a19VWN0fYcaUUw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyetsgUP+g7fLZUksOhLKtujFV1DQ04E3Uyau/99yGoLVmpW7Nm
 b2/CWMbRtzwfobnjikJbah3unXrDe1hjog6OFOTLOoooqf3E8gHiYGBG
X-Gm-Gg: AfdE7cm55L7h7qKFL4Za+hcKbcoefdsXjj8w3wTPB2GbQWYzc2jQXU0Kl0IEcXu66+G
 8knlOnNCdH3Wkj38xQALDAAF9QCuTEAkIyH8fG0NL9s7uvTEqm4Ev5fEcmeZ5O75uV33NBa3848
 0Pq/PdyB9iirKVTMImSnJ2JrJXUm/Vj2W23oiEA7E9TTYMjcb6wdcZtiWHe20MRlD5TEy8r5KGq
 wKAczJCusZLv1hkmfiPB69wNalYrZsAkjcVVgQlRF357L9jERoYHEB9fqN/fXPdZ8O6kcEf7j0c
 zEjsVvqJSUSr/DoN/IsLUT6ko/w2xY1XqP4VryQ6n631LGgNMki0wotkjqZqIOltdaAqVrJaKSE
 AzNKTeBBpXzPvUwOsM84gJ9jBD4ZfHJo6569y6q+dbZ0OaBIU70zFXHfX8lA0GThOoXs3f+We8f
 ZBSOjQujY0sMZnA6zra3biQF10xVsFpZ/HMsa9cZeeVVxLJRCHffNfdw==
X-Received: by 2002:a05:6000:29d8:b0:47f:40f3:88bc with SMTP id
 ffacd0b85a97d-47f40f38950mr8622758f8f.19.1784113081667; 
 Wed, 15 Jul 2026 03:58:01 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm15091094f8f.32.2026.07.15.03.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:58:01 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Dieter@nuetzel-hh.de
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>
Subject: [PATCH 1/4] drm/fourcc: Add modifiers for AMD GFX6-8
Date: Wed, 15 Jul 2026 12:57:54 +0200
Message-ID: <20260715105757.13125-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715105757.13125-1-timur.kristof@gmail.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now. These are the Southern
Islands, Sea Islands and Volcanic Islands families
of GPUs.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. GFX6 uses the GB_TILE_MODE0...31 registers,
and GFX7-8 also has GB_MACROTILE_MODE0...15 registers.
DCC is also supported on GFX8, albeit not displayable.

Note that the tiling table is uAPI and userspace relies on
specific modes being present at specific indices.

How the tiling works is primarily determined by the
so-called array mode.
Use the TILE field to specify the array mode.

Pixel data is organized into micro tiles.
Each micro tile may be 8x8 / 8x8x4 / 8x8x8 pixels,
depending on the array mode.
Add the MICROTILE field to specify microtile mode.

Microtiles may be further organized into macro tiles,
which have many configurable parameters. Macro tile mode
selection depends on how many bits per pixel an image has.
Add the PIPE_CONFIG, TILE_SPLIT, BANK_WIDTH, BANK_HEIGHT,
MACRO_TILE_ASPECT, NUM_BANKS fields to specify parameters
of macro tiled modes.

Furthermore, tiling is also influenced by memory
configuration. Old RFC patches received feedback
concerning that, so I looked into it specifically:
GB_ADDR_CONFIG.ROW_SIZE needs to be considered when
calculating TILE_SPLIT, but does not need to be included
in the modifiers, and also PIPE_INTERLEAVE matters,
but it's hardcoded to the same value on all GFX6-8 GPUs
and changing it would break userspace, so let's assume
it isn't going to change. Therefore we don't need to
include that in modifiers. Mesa also reads NUM_RANKS
but actually doesn't use its value on GFX6-8.

As a side note, tiling works similarly on GFX4-5
(that is Evergreen and Northern Islands). But that
will need some additional PIPE_CONFIG enum values
as well as some extra fields not relevant to GFX6-8.

Initially, let's only expose the tiling modes that are
most relevant to sharing buffers between different
processes:

Exposed array modes (TILE field):
- 1D_TILED_THIN1: micro tiled only
- 2D_TILED_THIN1: macro tiled

Exposed micro tile modes (MICROTILE field):
- DISPLAY: supported by DCE (the display engine)
- THIN: more efficient but not displayable

Exposed macro tile modes:
All possible parameters (25088 permutations).

More modes may be exposed in the future as needed.

Technically, the amount of possible combinations
of all possible tiling parameters is in the range
of hundreds of thousands, but in practice, there are
just a handful of possible modifiers for a surface.

For example on GFX8, a surface would have these
modifiers, from best to worst performance:

- 2D_TILED_THIN1 + THIN + DCC + macrotile params [1]
- 2D_TILED_THIN1 + THIN + macrotile params [1]
- 2D_TILED_THIN1 + DISPLAY + macrotile params [1]
- 1D_TILED_THIN1 + THIN
- 1D_TILED_THIN1 + DISPLAY
- LINEAR

[1] The macro tiling parameters depend on how many
bits per pixel of the specific surface has and
how the chip is configured. There is only one set
of valid macrotile params for a given surface.

DCC is only supported by GFX8 and newer, and only
with non-displayable macrotiling modes.

When sharing buffers between different GFX6-8 GPUs,
it is very unlikely that they support the exact same
macrotiling configuration, so they will likely need
to use micro tiled modes, which are still much better
than using linear buffers. (Note that currently Mesa
always uses LINEAR when copying between two GPUs.)

Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/drm_fourcc.h | 209 +++++++++++++++++++++++++++++++---
 1 file changed, 191 insertions(+), 18 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e527b24bd824..7a0a1e5dac75 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1620,36 +1620,69 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  * For multi-plane formats the above surfaces get merged into one plane for
  * each format plane, based on the required alignment only.
  *
- * Bits  Parameter                Notes
- * ----- ------------------------ ---------------------------------------------
+ * Bits    Parameter                Notes
+ * ------- ------------------------ ---------------------------------------------
+ *
+ * DRM format modifier fields on AMD GPUs:
+ *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
+ *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
+ *      13 DCC                      Delta Color Compression, supported on GFX8 and newer
+     55:14 (chip specific)          See below for details, depends on GFX block version
+ *   63:56 Vendor                   Value is DRM_FORMAT_MOD_VENDOR_AMD
+ *
+ * Chip specific fields on Gfx9 and newer:
+ *      14 DCC_RETILE
+ *      15 DCC_PIPE_ALIGN
+ *      16 DCC_INDEPENDENT_64B
+ *      17 DCC_INDEPENDENT_128B
+ *   19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
+ *      20 DCC_CONSTANT_ENCODE
+ *   23:21 PIPE_XOR_BITS            Only for some chips
+ *   26:24 BANK_XOR_BITS            Only for some chips
+ *   29:27 PACKERS                  Only for some chips
+ *   32:30 RB                       Only for some chips
+ *   35:33 PIPE                     Only for some chips
+ *   55:36 -                        Reserved for future use, must be zero
+ *
+ * Chip specific fields on Gfx6-8:
+ *   16:14 MICROTILE                Micro tile format
+ *   21:17 PIPE_CONFIG              Number of pipes and how pipes are interleaved
+ *   24:22 TILE_SPLIT               Tile split size
+ *   26:25 BANK_WIDTH               Number of tiles in the X direction in the same bank
+ *   28:27 BANK_HEIGHT              Number of tiles in the Y direction in the same bank
+ *   30:29 MACRO_TILE_ASPECT        Macro tile aspect ratio
+ *   32:31 NUM_BANKS                Number of banks
+ *   55:33 -                        Reserved for future use, must be zero
  *
- *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
- *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
- *    13 DCC
- *    14 DCC_RETILE
- *    15 DCC_PIPE_ALIGN
- *    16 DCC_INDEPENDENT_64B
- *    17 DCC_INDEPENDENT_128B
- * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
- *    20 DCC_CONSTANT_ENCODE
- * 23:21 PIPE_XOR_BITS            Only for some chips
- * 26:24 BANK_XOR_BITS            Only for some chips
- * 29:27 PACKERS                  Only for some chips
- * 32:30 RB                       Only for some chips
- * 35:33 PIPE                     Only for some chips
- * 55:36 -                        Reserved for future use, must be zero
  */
 #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
 
 #define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
 
-/* Reserve 0 for GFX8 and older */
+#define AMD_FMT_MOD_TILE_VER_GFX6 0
 #define AMD_FMT_MOD_TILE_VER_GFX9 1
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
 #define AMD_FMT_MOD_TILE_VER_GFX11 4
 #define AMD_FMT_MOD_TILE_VER_GFX12 5
 
+/*
+ * Gfx6-8 tiling modes.
+ * A complete reference implementation is found in addrlib in the Mesa code base.
+ *
+ * - Microtiled modes (1D):
+ *   Pixel data is organized into micro tiles of 8x8 pixels.
+ *
+ * - Macrotiled modes (2D):
+ *   Micro tiles are further organized into macro tiles.
+ *   These are optimized for even load distribution among memory channels.
+ *
+ * Note that only THIN1 modes are exposed here.
+ * THICK and XTHICK are for 3D images and not relevant to DRM format modifiers.
+ */
+#define AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 0x2
+#define AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1 0x4
+
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
  * version.
@@ -1748,6 +1781,146 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_PIPE_SHIFT 33
 #define AMD_FMT_MOD_PIPE_MASK 0x7
 
+/*
+ * MICRO_TILE_MODE, 3 bits. Determines the micro tile format.
+ * Only relevant to Gfx6-8.
+ *
+ * DISPLAY - Displayable tiling
+ * THIN - Non-displayable tiling, a.k.a thin micro tiling
+ * DEPTH, THICK - not exposed, not relevant to DRM format modifier use cases
+ * ROTATED - not exposed, not implemented in Linux or Mesa
+ */
+#define AMD_FMT_MOD_MICROTILE_SHIFT 14ULL
+#define AMD_FMT_MOD_MICROTILE_MASK 0x7
+
+#define AMD_FMT_MOD_MICROTILE_DISPLAY 0x0
+#define AMD_FMT_MOD_MICROTILE_THIN 0x1
+
+/*
+ * PIPE_CONFIG, 5 bits. Number of pipes and how pipes are interleaved on the surface,
+ * which means the shader engine tile size and packer tile size.
+ * Typically matches the number of memory channels, or number of RBs.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * P<n>_<a>x<b>_<c>x<d>
+ * where:
+ * <n> - number of pipes
+ * <a>x<b> - shader engine tile size
+ * <c>x<d> - packer tile size
+ */
+#define AMD_FMT_MOD_PIPE_CONFIG_SHIFT 17ULL
+#define AMD_FMT_MOD_PIPE_CONFIG_MASK 0x1f
+
+#define AMD_FMT_MOD_PIPE_CONFIG_P2 0x0
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_8x16 0x4
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x16 0x5
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x32 0x6
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_32x32 0x7
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16 0x8
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16 0x9
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16 0xa
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16 0xb
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16 0xc
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32 0xd
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32 0xe
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16 0x10
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16 0x11
+
+/*
+ * TILE_SPLIT, 3 bits.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * On GFX6 (or with depth tiling modes on GFX7 and newer),
+ * the GFX block uses the GB_TILE_MODE.TILE_SPLIT field directly.
+ *
+ * On GFX7 and newer with non-depth tiling modes, the GFX block uses a
+ * split factor which is stored in the GB_TILE_MODE.SAMPLE_SPLIT field.
+ * SAMPLE_SPLIT may be: 0 - 1 byte; 1 - 2 bytes; 2 - 4 bytes; 3 - 8 bytes.
+ * The actual tile size and tile split bytes are calculated as follows:
+ *
+ *    bpp = ... <- bits per pixel in the current image
+ *    thickness = ... <- depends on array mode; may be: 1, 4, 8
+ *    num_samples = ... <- number of samples in the current image
+ *    tile_size_pixels = 8 * 8
+ *    tile_bytes_1x = thickness * tile_size_pixels * bpp / 8
+ *    sample_split_factor = 1 << SAMPLE_SPLIT
+ *    tile_split_bytes = clamp(tile_bytes_1x * sample_split_factor, 256, dram_row_size_bytes)
+ *    tile_bytes = clamp(tile_bytes_1x * num_samples, 64, tile_split_bytes)
+ *
+ * In both cases, the display block (DCE) has no SAMPLE_SPLIT
+ * and just needs the tile split bytes in the GRPH_CONTROL.GRPH_TILE_SPLIT field.
+ * To maximize compatibility between GFX6-7, we don't include the SAMPLE_SPLIT
+ * in the format modifiers.
+ *
+ * The actual tile split in bytes is: 64 << field value
+ * Possible values of this field:
+ *
+ * 0 - Tile split is 64 bytes
+ * 1 - Tile split is 128 bytes
+ * 2 - Tile split is 256 bytes
+ * 3 - Tile split is 512 bytes
+ * 4 - Tile split is 1 KiB
+ * 5 - Tile split is 2 KiB
+ * 6 - Tile split is 4 KiB
+ */
+#define AMD_FMT_MOD_TILE_SPLIT_SHIFT 22ULL
+#define AMD_FMT_MOD_TILE_SPLIT_MASK 0x7
+
+/*
+ * BANK_WIDTH, 2 bits. Number of tiles in the X direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank width is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank width is 1
+ * 1 - bank width is 2
+ * 2 - bank width is 4
+ * 3 - bank width is 8
+ */
+#define AMD_FMT_MOD_BANK_WIDTH_SHIFT 25ULL
+#define AMD_FMT_MOD_BANK_WIDTH_MASK 0x3
+
+/*
+ * BANK_HEIGHT, 2 bits. Number of tiles in the Y direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank height is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank height is 1
+ * 1 - bank height is 2
+ * 2 - bank height is 4
+ * 3 - bank height is 8
+ */
+#define AMD_FMT_MOD_BANK_HEIGHT_SHIFT 27ULL
+#define AMD_FMT_MOD_BANK_HEIGHT_MASK 0x3
+
+/*
+ * MACRO_TILE_ASPECT, 2 bits. Macro tile aspect ratio.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * Possible values:
+ *
+ * 0 - aspect ratio is 1:1
+ * 1 - aspect ratio is 4:1
+ * 2 - aspect ratio is 16:1
+ * 3 - aspect ratio is 64:1
+ */
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_SHIFT 29ULL
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_MASK 0x3
+
+/*
+ * NUM_BANKS, 2 bits. Number of banks.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual number of banks is: 2 << field value
+ * Possible values:
+ *
+ * 0 - number of banks is 2
+ * 1 - number of banks is 4
+ * 2 - number of banks is 8
+ * 3 - number of banks is 16
+ */
+#define AMD_FMT_MOD_NUM_BANKS_SHIFT 31ULL
+#define AMD_FMT_MOD_NUM_BANKS_MASK 0x3
+
 #define AMD_FMT_MOD_SET(field, value) \
 	((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
 #define AMD_FMT_MOD_GET(field, value) \
-- 
2.55.0

