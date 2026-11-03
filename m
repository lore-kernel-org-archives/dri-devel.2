Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12672606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvbWvDvM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A68E10E461;
	Wed,  4 Nov 2026 08:58:45 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5AB10E4BE
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:32:59 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7ba2ee12f65so122947137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716378; x=1794321178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3G7pSRUiF1oMr/5t7UqnDSRU1cxD8M3NU6pDWikGy0=;
 b=rvbWvDvMzNwCzGi0pkNOz9lbR9R/ON+Obgrk0veEFhdawo1jpSDTRn8pP0GZBBbTe3
 97EanloFOfV0Rh8kTsS4uk8ohquepoZla+hY+r0AJ5Ug7DaceCY+tAAVjuYf8M22/SEV
 S8T+9g0IBTBw/rVMeblEEt3IsMqPFtYHJUfplGiaLysZWpcNJS5qUxhM6sQMer/XxIJh
 FcrlekwWZlrXxwnWQVTEW/wFTTK0MPvADgzEzLfpsInyaAT+5t97NzSPgwY7OkGBc1R5
 oz4mC0K6RydBGbsMxZ5oUojMtzTifQD6e7vSjU+Y+e16LCAae9jiO4sXe4KAApK4w2iY
 BVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716378; x=1794321178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3G7pSRUiF1oMr/5t7UqnDSRU1cxD8M3NU6pDWikGy0=;
 b=qkdEFsFCgb+RZgBxGNVDDYKesftve6MYHNAp6uj7dr0x8XUIQZPgy123L0L31NoZU/
 86/4g+YvFjeNBTtEktm7Fd+/zgPgUt98lc09ylRY6/aWbJEjXKdlez47NBh1hU4+ssZn
 cD9xjxRNlphD3Tet5KAviVc5RXox50i97orQFlFYOP17dMFnxctaJ97fzWb44o7NQlYr
 JsqoPzo9aAPC8dkIpjfxJ1VqqR4fFraIXSrsBoMnevCGuDaYqFbsGkoXorlpnwTjrjEC
 GgVK5BVUMvxp25YYvv1ThdWnpzA17FalF8hd2VZWz6pUgqpgRNu3FsxRkkR0JfXxstDZ
 lqLQ==
X-Gm-Message-State: APuU4Z9+1QAmW6fE5VJESYrHraPx/rYalDjr/HXfBYmrmrk7dXhQ7ugQ
 PXuzxWHT/56gOz7CfVBnvwNr+mPlwQKuosaTmMpltCqi5NjPSavxrF1x
X-Gm-Gg: AYBFou1c0477D087pqMjn98TOJldEqnpcWrm4mgSllxPyPXOc4fPOT3Dl1Z5O3XwRIY
 trJ7iYeRRjNSfWC037EEyiFy3Wvs4PeulUwewVnRlXJai/DCUwQwBpXC7SzU+dGyTygQcCVxIbp
 6mraGl/QsBDyEDprswPXL2KRXFTbaSTuNb9q8YY+nwQdZINSEUxu3WCQg8uTrUvycc3q9r7rR93
 EupM2kds2vW5FChno2g0kOFCZsDF0Z25yoe+ol0F+4hYx3pY3CV5Ttu70DQ5H574Q68Ho626Yyn
 0EynP7+XGUwHPEGkFYy6IBxNi2Z+ni5XcK9UGH7A+7MRQf5WdQH1/Zcl0j6DytQuyx/GfjI1SU8
 tM7CkNkh24MrfoAoTao3cSEIohWktC3siawTk7GVgXe17rouAr6OuGRW3YvDvKiYLU88oEW7asC
 7iCYoRllSeXue66s44jJlUUy1SiUYvl2M+TY6VjkoCwTBruYKW5MZ3ptKALC0OIbpAYHI+1etcM
 XI/Fuc1QeZJAL1GKmYfv7luTonuP1Bwdam3ap32q9cU+wwY8DpUgAnTZrzDZufmDy3tOthvboHU
 q0+W/kwdsUXE3xYj/NQ0zxbB6cMkmanKXkULkbP57WM4KBM4VJxBy2ysTtC5RFSPiMVS5XiS/hA
 BvCKordLTabRkXaU0huIG7kOcZIpZwr+xjeomrg==
X-Received: by 2002:a05:6102:8346:20b0:7cc:174b:f7b7 with SMTP id
 ada2fe7eead31-7d07239e743mr5924420137.0.1793716377707; 
 Tue, 03 Nov 2026 06:32:57 -0800 (PST)
Received: from saruman ([24.147.105.254]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945c358a369sm263859185a.25.2026.11.03.06.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:32:56 -0800 (PST)
From: Justin Ward <jward92@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Justin Ward <jward92@gmail.com>
Subject: [PATCH] drm/amd/display: use the HPO VPG/AFMT instance on DCN 3.0.2
Date: Tue,  3 Nov 2026 09:32:48 -0500
Message-ID: <20261103143248.59765-1-jward92@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dcn302_hpo_frl_stream_encoder_create() hands the HPO FRL stream encoder
VPG/AFMT instance 5. In dcn_3_0_2_offset.h mmVPG5_*/mmAFMT5_* are the
DIG5 block (0x256c/0x2576, BASE_IDX 2), not the HPO's packet generator
and audio formatter, which the header does not define at all: it goes
from mmHDMI_TB_ENC_CRC_RESULT_1 (0x090a) straight to mmDME5_DME_CONTROL
(0x093c, BASE_IDX 3). DCN 3.0.0 defines the same HPO sub-blocks as
mmAFMT6_* (0x091c..0x092f) and mmVPG6_* (0x0931..0x093a), DCN 3.0.3 as
mmAFMT2_*/mmVPG2_* at the same offsets, and both resource files pick that
instance for the HPO. On DCN 3.0.2 every InfoFrame built for an FRL
stream (AVI, HDR static metadata, HF-VSIF, ...) is therefore written to a
VPG the HPO TB encoder never reads, and the sink shows the stream as SDR.

Add the HPO AFMT/VPG registers to the DCN 3.0.2 header, numbered 6 as on
DCN 3.0.0, and use instance 6 for ENGINE_ID_HPO_0.

The register-map analysis and this patch were produced with Claude Code
(claude-fable-5-1) from dcn_3_0_{0,2,3}_offset.h and the dcn30x resource
files, then reviewed by the submitter. The dcn_3_0_2_offset.h block is a
verbatim copy of the DCN 3.0.0 AFMT6/VPG6 block.

Tested on an RX 6600 (Navi 23) driving a Sony TV at 3840x2160@120 RGB
4:4:4 10 bpc over FRL, kernel 7.3 with amdgpu.dcfeaturemask=0x402: before
the patch the TV reports SDR with HDR_OUTPUT_METADATA set and HDMI audio is
silent; with it the TV reports HDR10 and audio plays. TMDS modes are
unaffected either way.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6086
Fixes: 70ed4679c512 ("drm/amd/display: Add DC resource support for FRL")
Signed-off-by: Justin Ward <jward92@gmail.com>
---
 .../dc/resource/dcn302/dcn302_resource.c      | 10 +--
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   | 63 +++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 88dcf8166..d8c036a88 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -319,7 +319,8 @@ static const struct dcn30_vpg_registers vpg_regs[] = {
 		vpg_regs(2),
 		vpg_regs(3),
 		vpg_regs(4),
-		vpg_regs(5)
+		vpg_regs(5),
+		vpg_regs(6)
 };
 
 static const struct dcn30_vpg_shift vpg_shift = {
@@ -351,7 +352,8 @@ static const struct dcn30_afmt_registers afmt_regs[] = {
 		afmt_regs(2),
 		afmt_regs(3),
 		afmt_regs(4),
-		afmt_regs(5)
+		afmt_regs(5),
+		afmt_regs(6)
 };
 
 static const struct dcn30_afmt_shift afmt_shift = {
@@ -486,8 +488,8 @@ static struct hpo_frl_stream_encoder *dcn302_hpo_frl_stream_encoder_create(enum
 
 	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
 	if (eng_id == ENGINE_ID_HPO_0) {
-		vpg_inst = 5;
-		afmt_inst = 5;
+		vpg_inst = 6;
+		afmt_inst = 6;
 	} else
 		return NULL;
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
index 47f09e233..67929fd86 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
@@ -14396,6 +14396,69 @@
 #define mmHDMI_TB_ENC_CRC_RESULT_1                                                                     0x090a
 #define mmHDMI_TB_ENC_CRC_RESULT_1_BASE_IDX                                                            3
 
+// base address: 0x2646c
+#define mmAFMT6_AFMT_VBI_PACKET_CONTROL                                                                0x091c
+#define mmAFMT6_AFMT_VBI_PACKET_CONTROL_BASE_IDX                                                       3
+#define mmAFMT6_AFMT_AUDIO_PACKET_CONTROL2                                                             0x091d
+#define mmAFMT6_AFMT_AUDIO_PACKET_CONTROL2_BASE_IDX                                                    3
+#define mmAFMT6_AFMT_AUDIO_INFO0                                                                       0x091e
+#define mmAFMT6_AFMT_AUDIO_INFO0_BASE_IDX                                                              3
+#define mmAFMT6_AFMT_AUDIO_INFO1                                                                       0x091f
+#define mmAFMT6_AFMT_AUDIO_INFO1_BASE_IDX                                                              3
+#define mmAFMT6_AFMT_60958_0                                                                           0x0920
+#define mmAFMT6_AFMT_60958_0_BASE_IDX                                                                  3
+#define mmAFMT6_AFMT_60958_1                                                                           0x0921
+#define mmAFMT6_AFMT_60958_1_BASE_IDX                                                                  3
+#define mmAFMT6_AFMT_AUDIO_CRC_CONTROL                                                                 0x0922
+#define mmAFMT6_AFMT_AUDIO_CRC_CONTROL_BASE_IDX                                                        3
+#define mmAFMT6_AFMT_RAMP_CONTROL0                                                                     0x0923
+#define mmAFMT6_AFMT_RAMP_CONTROL0_BASE_IDX                                                            3
+#define mmAFMT6_AFMT_RAMP_CONTROL1                                                                     0x0924
+#define mmAFMT6_AFMT_RAMP_CONTROL1_BASE_IDX                                                            3
+#define mmAFMT6_AFMT_RAMP_CONTROL2                                                                     0x0925
+#define mmAFMT6_AFMT_RAMP_CONTROL2_BASE_IDX                                                            3
+#define mmAFMT6_AFMT_RAMP_CONTROL3                                                                     0x0926
+#define mmAFMT6_AFMT_RAMP_CONTROL3_BASE_IDX                                                            3
+#define mmAFMT6_AFMT_60958_2                                                                           0x0927
+#define mmAFMT6_AFMT_60958_2_BASE_IDX                                                                  3
+#define mmAFMT6_AFMT_AUDIO_CRC_RESULT                                                                  0x0928
+#define mmAFMT6_AFMT_AUDIO_CRC_RESULT_BASE_IDX                                                         3
+#define mmAFMT6_AFMT_STATUS                                                                            0x0929
+#define mmAFMT6_AFMT_STATUS_BASE_IDX                                                                   3
+#define mmAFMT6_AFMT_AUDIO_PACKET_CONTROL                                                              0x092a
+#define mmAFMT6_AFMT_AUDIO_PACKET_CONTROL_BASE_IDX                                                     3
+#define mmAFMT6_AFMT_INFOFRAME_CONTROL0                                                                0x092b
+#define mmAFMT6_AFMT_INFOFRAME_CONTROL0_BASE_IDX                                                       3
+#define mmAFMT6_AFMT_INTERRUPT_STATUS                                                                  0x092c
+#define mmAFMT6_AFMT_INTERRUPT_STATUS_BASE_IDX                                                         3
+#define mmAFMT6_AFMT_AUDIO_SRC_CONTROL                                                                 0x092d
+#define mmAFMT6_AFMT_AUDIO_SRC_CONTROL_BASE_IDX                                                        3
+#define mmAFMT6_AFMT_MEM_PWR                                                                           0x092f
+#define mmAFMT6_AFMT_MEM_PWR_BASE_IDX                                                                  3
+
+
+// base address: 0x264c4
+#define mmVPG6_VPG_GENERIC_PACKET_ACCESS_CTRL                                                          0x0931
+#define mmVPG6_VPG_GENERIC_PACKET_ACCESS_CTRL_BASE_IDX                                                 3
+#define mmVPG6_VPG_GENERIC_PACKET_DATA                                                                 0x0932
+#define mmVPG6_VPG_GENERIC_PACKET_DATA_BASE_IDX                                                        3
+#define mmVPG6_VPG_GSP_FRAME_UPDATE_CTRL                                                               0x0933
+#define mmVPG6_VPG_GSP_FRAME_UPDATE_CTRL_BASE_IDX                                                      3
+#define mmVPG6_VPG_GSP_IMMEDIATE_UPDATE_CTRL                                                           0x0934
+#define mmVPG6_VPG_GSP_IMMEDIATE_UPDATE_CTRL_BASE_IDX                                                  3
+#define mmVPG6_VPG_GENERIC_STATUS                                                                      0x0935
+#define mmVPG6_VPG_GENERIC_STATUS_BASE_IDX                                                             3
+#define mmVPG6_VPG_MEM_PWR                                                                             0x0936
+#define mmVPG6_VPG_MEM_PWR_BASE_IDX                                                                    3
+#define mmVPG6_VPG_ISRC1_2_ACCESS_CTRL                                                                 0x0937
+#define mmVPG6_VPG_ISRC1_2_ACCESS_CTRL_BASE_IDX                                                        3
+#define mmVPG6_VPG_ISRC1_2_DATA                                                                        0x0938
+#define mmVPG6_VPG_ISRC1_2_DATA_BASE_IDX                                                               3
+#define mmVPG6_VPG_MPEG_INFO0                                                                          0x0939
+#define mmVPG6_VPG_MPEG_INFO0_BASE_IDX                                                                 3
+#define mmVPG6_VPG_MPEG_INFO1                                                                          0x093a
+#define mmVPG6_VPG_MPEG_INFO1_BASE_IDX                                                                 3
+
 
 // base address: 0x264f0
 #define mmDME5_DME_CONTROL                                                                             0x093c
-- 
2.54.0

