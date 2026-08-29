Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64339C61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 08:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737AE10E0DD;
	Sat, 29 Aug 2026 08:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QjTFuIoA";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD4D10E0DC
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:59:48 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso347335366b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787993987; x=1788598787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibYckuXaq6TGpx88vTI/hlaavXq79ydxG55neiNaehY=;
 b=QjTFuIoAJzhLBtmdujjlJ9BcSaGAKHyv3UBFT+M8eWAewRbrW/uU0q/DcXwpc8ku9r
 gNeDIafO5S90Q2SPbOqQMZ508Fz2vzMcgJF82kbvsg6Ua7hSbsj6OE+uJF6OAi3acLAe
 fWJJdn/AZ26tciQ1X2zsArFrcuk74Wtg95BKlRPxxZMoJdB9SBMo5sH9lT1BBqBerPnw
 meWCnEcRUqh5KWdLQXJnY1XxbzqzqqjXInvxxFeMPxB7leMr4YYRK/71JelwBoDV5jGz
 CTOm2DtwSzxSECsTgYMaZwMvL5trH2Yt0fgKnotdXe2/Qlku7rJNHa+WvdTmBsBRPPtq
 E+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787993987; x=1788598787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibYckuXaq6TGpx88vTI/hlaavXq79ydxG55neiNaehY=;
 b=BBzgJshURGdwkjfIUqGN/mGlDrps1hUraPkAWnLyT1ZXcl7HzOx+98IzCtgcc3jgok
 UaDKzIgr5OJIzjD42rJHNqJe2OVV4AQYxj0+D9cE0GJEXPDJP/S1WaohiUCeYCpbt3vS
 OVszmsFbUTJvcDTvvLaNKRfhf4N1pVcvGWiO/iR5s1qcaNN0UYlxMG/8kFkVJhSgFX4L
 L2vmS8PFUs+jXuA0XzmbNGWPUaZYc99AoVkn7G0PjYqHXLQ7kbkYp+Tu25ZwTwUN5PkD
 2C3icoVYefwD4PQ4OwubD/8HvCwSXBCsMazzk4Z3IHgG/2hJCU0rSCi4MMUmCXx92wxZ
 Xx3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RolkPsXyZNfORQ38ABUqE0KOrTuws+7WglnNKPTkc7HSS5XslupMOBMwvZ1v5KTKnDzFHAkXEYoxeU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2CTW6mFFei2YkYzhJAzDjss5Mukzr65kXg0lKNGnUezeExW/h
 njkgMfxgm4PBBB3Te7re9U7PExWSUrRgJZ5K7nKG5mber328WS8CfnnB
X-Gm-Gg: AYBFou0zjqc2nBXIs41OMTHZF5ucBbhzSAfOSqXKcUIE6TU83tJP0K9xN+TOu3KEAqg
 Aym0FEbg6sbmEoJVZmZmLgyuQBZgXNmOArsoOD6CUo9dIqVt8rqAmpFpF0GEqhr/PvA86OQF+Ap
 zvtEkmgyxC/DVShKZ5Gq8MSrK9EsJqMl//rcd5hyKkIjFry3A7140FWlSwX77miWCIQDMUYn/W8
 dDZM6BYgWhvyciZ1yLUhtKjwPpkI2/Vn78jC+gUyG5YVTca3h+cN6J9mBhEs08vNztuI9gtlgDu
 viZXDgFsNBVJCftg4WkrzXNWS3ZIS5EITPf+ZM9QqEI2vONNFXiaKDcsApHUeKqv13ELCClE4uZ
 ATRCzk7rbnP14lztR9W/VM8+hK8nL68MNF3svugDJkaEqG1Lfs3WK0qVW6XcBA1/foRFBNH0e87
 lMB1NHn2gSri/jwyLKh2Zn/PWz2VOLFASDQkxAvx8CUQjogsii0A4xk9pOnY40IlWwRXVNjekiw
 eF/cuWuT1XqFX3knEe3oA4J6oWcR/uuK0dyVfGS80xQcNVpS5d1IhtjVhIk
X-Received: by 2002:a17:906:9f8c:b0:c25:833d:3839 with SMTP id
 a640c23a62f3a-c25833d3ad7mr25284766b.15.1787993986608; 
 Sat, 29 Aug 2026 01:59:46 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f273e8bsm180812366b.62.2026.08.29.01.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 01:59:46 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, ChiaHsuan Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers and
 masks for DCN3.2
Date: Sat, 29 Aug 2026 13:59:41 +0500
Message-ID: <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
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

Opening the CRTC CRC debugfs file on a DCN3.2 card triggers a WARN from
dc_helper.c on the first attempt after boot:

  WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:53 at
  set_reg_field_values.isra.0+0x30d/0x730 [amdgpu], CPU#1: cat/58468

Reproducer, on a fresh boot - the ASSERT is WARN_ON_ONCE, so it only fires
once per boot:

  echo crtc > /sys/kernel/debug/dri/<dev>/crtc-0/crc/control
  cat /sys/kernel/debug/dri/<dev>/crtc-0/crc/data > /dev/null

The WARN comes from the open(), not from the write to control:
crtc_crc_open() -> amdgpu_dm_crtc_set_crc_source() ->
amdgpu_dm_crtc_configure_crc_source() -> dc_stream_configure_crc() ->
optc1_configure_crc() -> generic_reg_update_ex() -> ASSERT(mask != 0).

Since commit ef45aaf73717 ("drm/amd/display: Configure all CRC engines in
pipe CRC source path") the pipe CRC source path iterates every CRC engine,
so crc_eng_inst = 1 now reaches optc1_configure_crc().  Its case 1 programs
OTG_CRC1_WINDOWA/WINDOWB_X/Y_CONTROL before enabling the engine, but DCN3.2
has neither the register entries nor the field masks for those four
registers, so the masks are zero and the ASSERT fires.

Engine 1 needs three sets of definitions to be usable: the enable bit,
the window registers that optc1_configure_crc() programs, and the data
registers that optc1_get_crc() reads back.  DCN3.2 has only the first,
added by commit c79354d12cb2 ("drm/amd/display: Fix CRC engine 1
enable/disable on DCN3.1.2+").  As a result engine 1 is enabled with its
windows never programmed, and a read through optc1_get_crc() case 1 would
address OTG_CRC1_DATA_RG and OTG_CRC1_DATA_B at MMIO offset 0.

Add the remaining two sets.  All six registers exist in hardware -
regOTG0_OTG_CRC1_WINDOWA_X_CONTROL is at 0x1b6f and
regOTG0_OTG_CRC1_DATA_RG at 0x1b73 in dcn_3_2_0_offset.h, with their
field masks in dcn_3_2_0_sh_mask.h.

Note that making case 1 return false instead would break CRC capture on
DCN3.2 entirely: the caller in amdgpu_dm_crtc_configure_crc_source() does
"ret = -EINVAL; goto unlock" on failure, so a card that warns but works
today would stop working.

The same entries are missing for DCN2.0, DCN3.0 and DCN3.1.  I have no such
hardware and have not touched them.

Fixes: ef45aaf73717 ("drm/amd/display: Configure all CRC engines in pipe CRC source path")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v2: also add the CRC1 data registers and masks (OTG_CRC1_DATA_RG,
    OTG_CRC1_DATA_B), spotted by Sashiko AI review.  Engine 1 needs all
    three sets to be usable, and v1 supplied only the windows.
    Note that ordinary CRC capture through crtc-N/crc/data reads engine 0
    only (hardcoded in amdgpu_dm_crc.c); the engine 1 readout path is
    reached from the secure display code, which I am not able to exercise.

The six added SRI_ARR lines follow the space indentation used by every
line of the surrounding macro, hence the six checkpatch "no spaces at the
start of a line" warnings.  Using tabs there would misalign them against
their neighbours.  The added SF lines in dcn32_optc.h are tab indented,
matching that file.

 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h    | 11 +++++++++++
 .../amd/display/dc/resource/dcn32/dcn32_resource.h    |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 60c01ec28b65..492760779226 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -146,6 +146,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 68e7140f1505..fa8cc89cb3f7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1054,6 +1054,12 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_DATA_RG, OTG, inst),                                    \
+      SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
+      SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
       SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
       SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
       SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
-- 
2.55.0

