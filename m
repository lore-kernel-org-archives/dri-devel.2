Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E84606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnR8pc3y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A11112A80;
	Fri, 23 Oct 2026 09:53:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01945112A6C;
 Fri, 23 Oct 2026 09:53:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D0D244042;
 Fri, 23 Oct 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792749215;
 b=Tx3uvSzest1qIBFf6vY/9GFxkAjCuTLhbPnim0vIHYu3NlHrg2XaB+hOPuKixy1pIANX
 p7ExvLQOCvk46uEIyzkYLJ3RIV5ZQpWeVBXm2wnDnY4dbfd8jcpX3JUWr7TPOvD93JP/e
 lTORJX1rQMInbddHC+nwfmJNtmV8ad3Be5gCobSLIu1wsaOE0NKBgjdCFZ1v0Y36Zaa/n
 jH0S9MKJ84hSZ59CUAcXkMTzc4GRtUcrrSILP0tdBXRCyu31thRzT1ZtoUMgJEVXVbFCX
 1G4Km9K7Z1luWmTh7u+DhVa/MRC38bAsq9XTH2qI9DHav3q/cH771xUzih1VXS+Pw6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792749215;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=k76C28WvueFM3AIT14tJaOsYhV8LFBqv5UIAtJ5c2mw=;
 b=DTiTZt/g1CwmetdluZ5mF7Lc+SxSuN4JoGgJhfqX0w52nUiHBSWcFd1KeAVy/5PLAnBj
 IgUl+ZDPgboe6jkYJlZVg34ZUstjCzE7dREL/Ug5NtehpeztmRhL4OhIp14JDnv53aQLn
 b9WeaxkavDO3QErz0v38hFxiPGWkOSpHDQwCxR9t1wJo6mgQm9MRCeP9gpJnT6Asn1SeC
 2hvxGe6/BMrIUwlJy8kXu9a+hw6Y9Mzl+40ueZW7TyjvpdlC0GlerRvVXV0uevnjcZJbX
 zKtXq3Z8c/epVtdfHhwkC6lq0uNSSpj5FzO1Smu0d1q0B1qBgBAWxBqR2bhVZySykNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 470261F031E1;
 Fri, 23 Oct 2026 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792749215;
 bh=k76C28WvueFM3AIT14tJaOsYhV8LFBqv5UIAtJ5c2mw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XnR8pc3y9GJkkSkf5/6soXcqZMwCrmVODwL58jX0IxCFd4760M4K2e+1NEGDtZbBD
 qqNzqwsa6OI3e59OUJFDuLOfcw/xbGaGFU5DcDvtr1hk+NXNVJ3BsdYeW6VjrofZLO
 CFmc7GR5Jjv/pXok+x5VnDpXehChaWOkB3vi58yukJHV+gSWu39F9XsdSvUSW4Vij8
 5Hch0HulOP4ds44WyEq0UCXg/e1q6RHjLBtkzn9k6upKYctl6NN/EtX2pHCQH4+dTf
 hAn5PpkDJsKasMIvO2AoBdGgKEEKIC95XRpZdND2YiH5OAizk7ykQ+fK9R54Tzt7Xc
 f1P06LqlQuVJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C1E9A44489;
 Fri, 23 Oct 2026 09:53:33 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 15:23:32 +0530
Subject: [PATCH v3 2/4] drm/msm/a6xx: Program the PDC sequencer on Adreno 620
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adreno-a620-v3-2-2d1d566e5e13@brar.si>
References: <20261023-adreno-a620-v3-0-2d1d566e5e13@brar.si>
In-Reply-To: <20261023-adreno-a620-v3-0-2d1d566e5e13@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792749211; l=5355;
 i=patches@brar.si; h=from:subject:message-id;
 bh=Obs8CON0X6HWKVk8YPJT/kXnMrbnAoIHP9bqVC978ec=;
 b=jyX1ZvF9oDj+esowCc1UUn9to4UyZo7aYH8B7Ut0tLXoAz5FLwMW/xx0JGLyDxJmySDapmjij
 r5fnK+yXTDxAFwnq58wNnjeJGBGUgahrZxeOV8qJyYABOTKinZyhuok
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

Unlike the rest of the A650 family, the A620 does not get its PDC set up
by AOP (the downstream devicetree has no pdc_in_aop for it). Without the
sequence, the RSC never acks the second power-up ("Unable to power on
the GPU RSC") and the device hangs.

Program the sequence from the driver, taking the xo, mx and cx resource
addresses from cmd-db instead of the hardcoded ones. Like the downstream
driver, also program the VRM command when cmd-db has a vrm.soc resource.
Add adreno_is_a620() for the selection.

Assisted-by: Claude
Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 35 +++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 +++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec..8d426f1f1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -686,6 +686,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	u32 seqmem0_drv0_reg = REG_A6XX_RSCC_SEQ_MEM_0_DRV0;
 	void __iomem *seqptr = NULL;
 	uint32_t pdc_address_offset;
+	u32 mx_addr = 0x30010, cx_addr = 0x30000, vrm_addr = 0;
 	void __iomem *pdcptr;
 	bool pdc_in_aop = false;
 
@@ -697,8 +698,18 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	if (IS_ERR(pdcptr))
 		return;
 
-	if (adreno_is_a650_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu))
+	/* Unlike the rest of the A650 family, A620 has no PDC setup from AOP */
+	if (adreno_is_a620(adreno_gpu)) {
+		pdc_address_offset = cmd_db_read_addr("xo.lvl");
+		mx_addr = cmd_db_read_addr("mx.lvl");
+		cx_addr = cmd_db_read_addr("cx.lvl");
+		vrm_addr = cmd_db_read_addr("vrm.soc");
+		if (!pdc_address_offset || !mx_addr || !cx_addr) {
+			DRM_DEV_ERROR(gmu->dev, "No PDC resource addresses in cmd-db\n");
+			return;
+		}
+	} else if (adreno_is_a650_family(adreno_gpu) ||
+		 adreno_is_a7xx(adreno_gpu))
 		pdc_in_aop = true;
 	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640_family(adreno_gpu))
 		pdc_address_offset = 0x30090;
@@ -766,25 +777,31 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD_WAIT_FOR_CMPL_BANK, 0);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CONTROL, 0);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID, 0x10108);
-	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR, 0x30010);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR, mx_addr);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA, 1);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 4, 0x10108);
-	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 4, 0x30000);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 4, cx_addr);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 4, 0x0);
 
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 8, 0x10108);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, pdc_address_offset);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 8, 0x0);
 
+	if (vrm_addr) {
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 12, 0x10108);
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 12, vrm_addr + 0x4);
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 12, 0x0);
+	}
+
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD_ENABLE_BANK, 7);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD_WAIT_FOR_CMPL_BANK, 0);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CONTROL, 0);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID, 0x10108);
-	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR, 0x30010);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR, mx_addr);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA, 2);
 
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 4, 0x10108);
-	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, 0x30000);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, cx_addr);
 	if (adreno_is_a618(adreno_gpu) || adreno_is_a619(adreno_gpu) ||
 			adreno_is_a650_family(adreno_gpu))
 		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x2);
@@ -794,6 +811,12 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, pdc_address_offset);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 8, 0x3);
 
+	if (vrm_addr) {
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 12, 0x10108);
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 12, vrm_addr + 0x4);
+		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 12, 0x1);
+	}
+
 	/* Setup GPU PDC */
 setup_pdc:
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_SEQ_START_ADDR, 0);
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


