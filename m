Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3C9C61DBD
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 00:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6CE10E074;
	Sat, 29 Aug 2026 00:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlOen2FA";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB65910E08C
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 00:46:19 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so282762466b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787964378; x=1788569178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LNgBCT7AcYnH8EZ4h37NHCshagsts35rqplG0HejEE4=;
 b=nlOen2FA9qkmayOEkkrr+5SdQZvF6Le/COP2pSpabA1A/JQvD8FWuyt/Gc66lN7Jex
 zRRTykoAlE63pSd3lRd+7RBXsONZPuNyOZgDYxDTMaQxdet3VzQoYcE3N95KVt2e1atq
 UMrZt+zCBx50ktUgl1CyKudp78/Ymq42fQYXOUuJlWCoyodSxjRDsvEt6xDQ3Hoq3cK/
 fRWcU7XOXl5nk0u0qTocBkZ6sWxVW4ssypp9TwDtTXrddYMj+lP9jRjZ9xUbc4JzL9MI
 jqdzZYfXWvOlxAJkJLlHrOR+ZR1S+oT4k9Nc6C9jV01jGpfROns6jr1sIqiuB8gMcR6Z
 wgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787964378; x=1788569178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LNgBCT7AcYnH8EZ4h37NHCshagsts35rqplG0HejEE4=;
 b=PIP0aHTHa0C+ycSGNB8L+dl6Tixbx1IO/HgwZVz8q+WHOOP23cLPMVZtlL6t3LxRTY
 O98vnq4QTBgHvDtRulrV7SEuD6u8bEQ5Q2zCbDYFklDoarWJkPpgpFpb1pnNZvKG6lxX
 fCdA0hUXya9GGOTJ14H9384OFAzKgBglPhVoDgSJCUUH0w8pqwaWjSts3ss8Mh/WWB4+
 L8O/7qgueDiUHySxZN+0BDuIAy4iF1R3yeKgquFRQpN3TzjdNEz4C8fE5XF91vOauGWb
 lu67q/CyHyI3SyUQZg8zop8ad1mkcNHWW4LVgQ5jv4Quh4+26pAPy2a8nuPXcquORu9/
 TU2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4oQCoudahF2yKMwMCuc1VH8N2W/g4mxRocgXrQ4LqGdQQx7ybfkSMz0l93xZ3HtMG5Iyosy2lqck=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWTYkqX5pIgfp3NkOahYE/dwldX5g5tadHzjTh/FCByI3dEQhD
 LCiVCras9gIGKj0BeWFvN1/nZYxLldLkn+rQnFUYo+CIihdIfV0g1nE0
X-Gm-Gg: AR+sD11B/Y5Z/XbLhGvnc5aWGMRZvcYsx57YnXmChymxLhW21bV3dcZukDeVGgBzwPg
 +/ZTUMP5nceiiW/2Mb6PSTy+ICGyByaf+v2kUSXxBrv6/m4Mu54VYgE9W8s9LPDnWw0fHGcs70U
 V9JDm43cbI3/Z1SUH9wO7clX0IQZEd5RDMAvvfkIQBPGhFJhp57j02ClO0hyWWWB+iEJkEhyl4r
 pcOTce1IiZgKsCCP7ESukM0wAkmPjIU4mm4h83CSY9Jz6aoR2iI/h0vIpxKlx/C+pfqZiCoAHQY
 x221Ub6PBDbY0NVEnWDzmhZoVRcw0qIp+skaZmxUoyd7ow1qLJadum7Z/+G0b1V87vwTyxLyeep
 wCDWxXkal9IAR95JUZ36TBBw6s4HHqZiv+ewo8xygXyqBlGX4Vox+jVWAe7WFnAD3xN2jqrF46p
 RnUZjzkK+cLAUicSV+/nSRSDNYRtiHO/cF2pY3Un6390uNDNK+PTz4WX8tFCOSd6lVzYEa+WAJf
 K7AS+Pj+AvDkzsAad7vGNpL830bCOjSyrpNugSJJuxb1fm2+sgIezlH27yQ
X-Received: by 2002:a17:907:805:b0:c25:61f4:b478 with SMTP id
 a640c23a62f3a-c2561f4e7f3mr480340066b.15.1787964378057; 
 Fri, 28 Aug 2026 17:46:18 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25613f8bc0sm128171966b.31.2026.08.28.17.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 17:46:16 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, ChiaHsuan Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: add missing CRC1 window registers and masks
 for DCN3.2
Date: Sat, 29 Aug 2026 05:46:08 +0500
Message-ID: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit c79354d12cb2 ("drm/amd/display: Fix CRC engine 1 enable/disable on
DCN3.1.2+") added the OTG_CRC1_EN mask for DCN3.2 and guarded the enable
write, but not the window writes above it.  As a result engine 1 is now
enabled on DCN3.2 with its windows never programmed.

The registers exist in hardware - regOTG0_OTG_CRC1_WINDOWA_X_CONTROL is at
0x1b6f in dcn_3_2_0_offset.h with its field masks in dcn_3_2_0_sh_mask.h -
so add the missing SRI_ARR and SF entries.

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

The four added SRI_ARR lines follow the space indentation used by every
line of the surrounding macro, hence the four checkpatch "no spaces at the
start of a line" warnings.  Using tabs there would misalign them against
their neighbours.  The added SF lines in dcn32_optc.h are tab indented,
matching that file.

Tested on a Radeon RX 7900 XTX (Navi 31, DCN3.2): after this patch the
reproducer above leaves dmesg clean, and CRC capture on engine 0 still
delivers a full 120 frames per second.

 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h    | 8 ++++++++
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.h    | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 60c01ec28b65..f696e4ee3bc6 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -146,6 +146,14 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
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
index 68e7140f1505..30878aed61e1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1054,6 +1054,10 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
       SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
       SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
       SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
-- 
2.55.0

