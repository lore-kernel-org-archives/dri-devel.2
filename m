Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B5606A326
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op3QARKf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B113112A2A;
	Fri, 23 Oct 2026 08:49:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B57D10E5BB;
 Fri, 23 Oct 2026 08:49:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14849414D7;
 Fri, 23 Oct 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792745344;
 b=mEloBm3HytvI2bJidKRXf70So51df40OqICbfgt/5v4eE1iflqMhP9mmZ9TWhYzpyHbv
 iO3hV3P++UU0MERuTHgRKrKoHkTFJySu9TGp2R+OqGhPmMGCs3hQCUOr8IhvQG+xbPnvx
 nLHrebRjAS0V5nphyVH5eemK5PJS49k5t9cwLzmRGOQFFw/152ZycS0955/UmdBLbf9xF
 y0zsBIjpJlSMPtdS/7deSegaOYSrE8EI+AU3VjrtN9KL7MIU4dmb/mgYu3eU+ppHqAQDT
 yoWBRGtk+2Ok0CRNo5D2ic0w/2ySMxVyNfmd1lURT0rwGm55UVfdZWBJFkRy70nXo5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792745344;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=xHlSYqdR9q31S0bfncvvUPXZgEEK7pDhfbawLSi5Dwk=;
 b=DJdx3dd/EtFOrxoLLEEdk6sY7TXeDpNmBHbO37zAuSgCaIFTxnugl4yAOgXjssETlO8d
 XK3HLBZsvBtwlKya9+AJGQuidZ4sRcN7qhMknFoEFqZYZhAnO11yc7jqBNqiVWYtKiu/q
 mISqLTKoj1KUqennbfBzI7zByr1ph6pHCBbtlXm7ldsRGgqdB4pNOLtfc5hN5233s8QFb
 3nCbtvWRQGiyhvVEmxYW4rf9AuHlpk9HGWeMxjygvq9Kxzz/Fi0izohe74TnDwTQhQ9Z9
 mXQjHKm2xJZoQggSuRrFWX3sKAtOz+b6mUUI5KVWljCysDqJzDM7acmM4OtreeHdZIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E1DAA1F01829;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792745343;
 bh=xHlSYqdR9q31S0bfncvvUPXZgEEK7pDhfbawLSi5Dwk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Op3QARKfJZCU6eAXaDirWBPYKyASGOQInkJJ/89/sqP/4cRsDZhcui5RTiiRj9E4t
 Ch5B3zTQCQiaqSY7cD1oIVNf6GapDo1oBtpITKx7OJEcSf0mJ4RpdWEZX9BYXlBSxV
 jlcdE2jm83gQsKXWTDj5LO56Sq69i5UhjHa7xmy0M96TU1XZS/omYG4UEFGGH6Wned
 J5dlMbXcXWcwjjVdF8obMVyA/K4CncQaDu+XV/NAsoGbinneN2OwbgIEogFGbbH0AK
 QRaGRuZ8pay3Yai0utFnU0iFr+gKDN8B0zF55mM2Cva9Ghgmo4NdG3qGtchakk/mfb
 4HEf6olGSYcjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 727514443D;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 14:19:00 +0530
Subject: [PATCH v2 2/4] drm/msm/a6xx: Add a bandwidth table for the Adreno
 620 GMU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adreno-a620-v2-2-1d654c3f52d5@brar.si>
References: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
In-Reply-To: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792745340; l=3158;
 i=patches@brar.si; h=from:subject:message-id;
 bh=ZgldijA3JDgDsTY5MOw8s5Wh1FCac7/xjEdjhBWUFz8=;
 b=PNMT/GH5Th4EWpLP567H9jPExcocaDeL/mKA6+DjOYItbWDx5d6oy+g0qVJ+1//kwvQY5AWvc
 8RozAjkVxWUD9h0+6IynxGRDilXyhpcv+7C8sGEiqAmZsmPOORsMXSo
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Without an A620 specific table the GMU falls back to the generic A630
one, whose BCM addresses do not exist on SM7250, and the first GX
performance vote times out.

Like the A650 one, send a single "off" entry just to get things running,
with the BCM addresses looked up in cmd-db. This is only used while the
GPU OPP table has no bandwidth levels; with them, the table is generated
from the BCMs listed in the catalog entry. Add adreno_is_a620() for the
selection.

Assisted-by: Claude
Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 34 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 6b34e704a..b59853678 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -553,6 +553,38 @@ static void a650_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] =  0x60000001;
 }
 
+static void a620_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
+{
+	/*
+	 * Used when the OPP table has no bandwidth levels, otherwise the
+	 * table is generated from the BCMs in the catalog. Send a single
+	 * "off" entry just to get things running.
+	 */
+	msg->bw_level_num = 1;
+
+	msg->ddr_cmds_num = 3;
+	msg->ddr_wait_bitmask = 0x01;
+
+	msg->ddr_cmds_addrs[0] = cmd_db_read_addr("MC0");
+	msg->ddr_cmds_addrs[1] = cmd_db_read_addr("SH0");
+	msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
+
+	msg->ddr_cmds_data[0][0] =  0x40000000;
+	msg->ddr_cmds_data[0][1] =  0x40000000;
+	msg->ddr_cmds_data[0][2] =  0x40000000;
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU but the
+	 * votes are known and fixed for the target
+	 */
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = 0x01;
+
+	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
+	msg->cnoc_cmds_data[0][0] =  0x40000000;
+	msg->cnoc_cmds_data[1][0] =  0x60000001;
+}
+
 static void a690_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/*
@@ -818,6 +850,8 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		a619_build_bw_table(msg);
 	else if (adreno_is_a640_family(adreno_gpu))
 		a640_build_bw_table(msg);
+	else if (adreno_is_a620(adreno_gpu))
+		a620_build_bw_table(msg);
 	else if (adreno_is_a650(adreno_gpu))
 		a650_build_bw_table(msg);
 	else if (adreno_is_7c3(adreno_gpu))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4b2156825..b77502446 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -443,6 +443,11 @@ static inline int adreno_is_a619_holi(const struct adreno_gpu *gpu)
 	return adreno_is_a619(gpu) && adreno_has_gmu_wrapper(gpu);
 }
 
+static inline int adreno_is_a620(const struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x06020000;
+}
+
 static inline int adreno_is_a621(const struct adreno_gpu *gpu)
 {
 	return gpu->info->chip_ids[0] == 0x06020100;

-- 
2.56.0


