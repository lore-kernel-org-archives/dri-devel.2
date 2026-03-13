Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C382106FD87
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778AB10EAED;
	Fri, 13 Mar 2026 06:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="iTjuUkJU";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5FD10EAED
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:39:41 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D603uQ2137844; Fri, 13 Mar 2026 06:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=l
 SfwTn4RhqYcfQyKrLWOxz7Yjw24ARLAK6iiRB5tXcg=; b=iTjuUkJU5y4b5Mu19
 bAC8cu8PgiwX7GhUQVDgKxId3jO2kJ3dDRuPmWKzCtMD42+cKLud6ZGfrl8c/kJX
 btCcQlOG4JBNYI9DBwBKRebM1WVbH5a313XqPbrdPJMPdvtWMmoUtCc175eWFwG1
 a+e832l463S4EcnX49eV+5qTD86oYtKh8Q/fZIZJUH2Ty2DmiAdI6tWOmkH910va
 dFEDGXUHxLcjxWkvls8PwxzrosgXD8dILPNa38JBf8l4v5Eymj7T58i9DVryjesJ
 5qKJcqEYZmWj4fAEptD1GNrt/x48fRfdQv9vXrNgdtStVA553QEPNEzxZDTDj15M
 /A4rw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxvy2104-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:39:32 +0000 (GMT)
Received: from NP-G-BRAJESH.pu.imgtec.org (172.25.128.99) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:39:29 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 13 Mar 2026 06:38:24 +0000
Subject: [PATCH v2 1/2] drm/imagination: Improve firmware power off for
 layout_mars config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-b4-staging-layout_mars_base-v2-1-9e3c251d278e@imgtec.com>
References: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
In-Reply-To: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773383967; l=4796;
 i=brajesh.gupta@imgtec.com; s=20260107; h=from:subject:message-id;
 bh=IrRv7Y+1q3Or2+x/1KlI7iemilzjl2ITCjfigj24apo=;
 b=7190ou/V9Gb9yEvMWcN6Dh0YIdAcr/8wRJhwPZ9krkHuRaDGjQ7ofil97kO98xeMljgqAs85s
 OJe+Aq05mkmBEFcQexgDoUd2lhJNMW5TP2EUlFiMxd0xSEf1idBjNYg
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=mxdDr22E/sHiu68U/bLe0W/SRYi3i848ZgoBuEyk21E=
X-Originating-IP: [172.25.128.99]
X-Proofpoint-GUID: 5vgSxkXZLglLi0WJtHe7P75sFUUCAAY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfX30sNDiLNB9fW
 AW0eo2w5NvMQdYCkwLkZAj5n5+n3Jhy0WCl/qK1bwtBzvlksJ2hyLnURS3wYoG668UmRIrvJJNJ
 MrjNZlPEd47ZZeLQcyRc5z85HXpJCxqVMXBuU4a1FjshBY/bHKOa+XMqruo6mAYYIE3sIh60M0L
 my3XMObyXFVR9HtYGvGUDA+ftjyPG/l6IuMlNJZRgiZ3eJpaDbPRaNyNBUXymJbYgvUvKAAJZPS
 dHSF6BY/lAE8wJ9LoQUTz35TQJD+1i8hjbQy74PKu50esItjAKw27bhL3RQXmU2ZszXgEwsJdtL
 xl78m/Spizqgrfhwpt8AUjgFntCCSHPSo2SCCcEtIhHDxsRu+iA5iQSGi/d+bwNNaYpG/Iwly3R
 jjpGyVaonAqturVLcokIj7+af4XPdldSQAkI0IBNcymCDl+HjfODvU6hsfGHaymDB6778fwuutx
 mNOgaTrz2P7xHwv47Pg==
X-Authority-Analysis: v=2.4 cv=NuzcssdJ c=1 sm=1 tr=0 ts=69b3b124 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1Ouegpa_-vYA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=C9Ejk-a9CUj4VfdxkvIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 5vgSxkXZLglLi0WJtHe7P75sFUUCAAY2
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

In layout_mars HW config, Firmware MCU moved from Sidekick to new Mars
domain so Firmware takes care of powering down Sidekick/Jones and SLC.
Skip checks for those from kernel and check idle bits for Firmware MCU
and system arbiter excluding SOCIF.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 85 +++++++++++++++++---------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index dcbb9903e791..e47224ac0547 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -209,18 +209,32 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 					 ROGUE_CR_SIDEKICK_IDLE_SOCIF_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_HOSTIF_EN);
 	bool skip_garten_idle = false;
+	u64 layout_mars_value = 0;
+	bool layout_mars = false;
+	bool meta_fw = pvr_dev->fw_dev.processor_type == PVR_FW_PROCESSOR_TYPE_META;
 	u32 reg_value;
 	int err;
 
+	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value) == 0)
+		layout_mars = layout_mars_value > 0;
+
 	/*
-	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
-	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been
+	 * For cores with the LAYOUT_MARS feature, SIDEKICK and SLC would have been
 	 * powered down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (!layout_mars) {
+		/* Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper. */
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+
+		/* Wait for SLC to signal IDLE. */
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE, ROGUE_CR_SLC_IDLE_MASKFULL,
+					 ROGUE_CR_SLC_IDLE_MASKFULL, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	/* Unset MTS DM association with threads. */
 	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD0_DM_ASSOC,
@@ -270,27 +284,25 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 		return err;
 
 	/*
-	 * Wait for SLC to signal IDLE.
-	 * For cores with the LAYOUT_MARS feature, SLC would have been powered
-	 * down by the FW.
+	 * For cores with the LAYOUT_MARS feature, SIDEKICK and SLC would have been
+	 * powered down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
-				ROGUE_CR_SLC_IDLE_MASKFULL,
-				ROGUE_CR_SLC_IDLE_MASKFULL, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (!layout_mars) {
+		/* Wait for SLC to signal IDLE. */
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
+					ROGUE_CR_SLC_IDLE_MASKFULL,
+					ROGUE_CR_SLC_IDLE_MASKFULL, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
 
-	/*
-	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
-	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been powered
-	 * down by the FW.
-	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+		/* Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper. */
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
-	if (pvr_dev->fw_dev.processor_type == PVR_FW_PROCESSOR_TYPE_META) {
+	if (meta_fw) {
 		err = pvr_meta_cr_read32(pvr_dev, META_CR_TxVECINT_BHALT, &reg_value);
 		if (err)
 			return err;
@@ -304,11 +316,28 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 			skip_garten_idle = true;
 	}
 
-	if (!skip_garten_idle) {
-		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
-					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
-					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
+	if (meta_fw || !layout_mars) {
+		if (!skip_garten_idle) {
+			err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
+						ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
+						ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
+						POLL_TIMEOUT_USEC);
+			if (err)
+				return err;
+		}
+	} else {
+		/*
+		 * As FW core has been moved from SIDEKICK to the new MARS domain, checking
+		 * idle bits for CPU & System Arbiter excluding SOCIF which will never be
+		 * idle if Host polling on this register
+		 */
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_MARS_IDLE,
+					ROGUE_CR_MARS_IDLE_CPU_EN |
+					ROGUE_CR_MARS_IDLE_MH_SYSARB0_EN,
+					ROGUE_CR_MARS_IDLE_CPU_EN |
+					ROGUE_CR_MARS_IDLE_MH_SYSARB0_EN,
 					POLL_TIMEOUT_USEC);
+
 		if (err)
 			return err;
 	}

-- 
2.43.0

