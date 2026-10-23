Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AF606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaqWxeIF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8036112A3A;
	Fri, 23 Oct 2026 08:49:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FEA10E5D3;
 Fri, 23 Oct 2026 08:49:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EF6160A99;
 Fri, 23 Oct 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792745344;
 b=Dzd+oARVAGmhebe817RLSJymBjw/+w6BtFo9K4QRC9luBd5W68n6nSC7N+/qdtl5beSI
 IbE0ctn16Mh6HiVvs+5elb+AwbIZNNwfbxaep82AFKTLagZSsN0bAPmzpqmCed6fYuzST
 91AMzfvHYML8niPVQvtOh+zr1fz1j9Q2jmoMtZSVWat2wFbFzJLTooFL1lzZl/uQwJ1ww
 Gy5zfDWaXdbw3Cs0LAQsC+LAUo2A2G8kIt83DzFbxxYVH8WJUhbXibOveSsp+/0atAXbA
 5GIr6HTlcImgFZRayefyaGNg2ZRaIZbs9RpepA2LCcRAJuDADUiEteobQ30mDTGZcBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792745344;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Hqsj8laTNJRGhLD3PRbXSk/+NGmj8/7mSk/guKoQ1qE=;
 b=ung2KrsFKbpJjztzPX+NV4zXTu8D8dSPpdmmxOq6ZpdPGvpS3ee0/7dIpFhSRRUtMabZ
 1YZYQM9PBtmNxJV93KEhgemmKDZGjv+gBrlQtMGQFYh6cZqM8MH6phg3whFi65Lde7i18
 lNN9vbOgnVbmffZehYiX6VUxVy83RC8s2sQQN/0pULO18vafc74RvUkDfVudMGLvrM8kY
 BExfYwGv1AxgjPFf42iQA0JVbwJInxG2NvKzzZ8Q5p5u2CrCXyECp1BWMvVSOG1T3dZe/
 Ir0UNtt6IPJBGqqkVWVxC8NST3gRvM2yfAt8UNEGesB7UgOyobf8CBwFJpZbPQFi9Sg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E9DC51F031E0;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792745344;
 bh=Hqsj8laTNJRGhLD3PRbXSk/+NGmj8/7mSk/guKoQ1qE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=WaqWxeIFG+DGG/gqkvsVWgZYGIqjiMhExiNQD55PHp8a2D8bYV6wQidFGLSJGpkEr
 9wowExXUZ4Ca1nQhvbOX24+syLSWH+aoxBKKU2EqPPqQLB+xvnFzAslGdRvd6pE+4B
 jJJtwfTxSmUrOmhA999+QcSxNyzcEs5NkAeaMB+RauNwSIK2ftd0rRituRHYMDTWNr
 hDvvQTVmeTc3O9n/DmDAmheomXBQ1ny8TZ++UAoyaQ9/jQ7hn69rZ+KryVHjAqU1S6
 jfvIeQ9op5e5TIqmyx/XqH6uUzmqzbCD18DSErLPJnwshIpDZKzIb8UGhc6Idpdc7X
 rdQKXMPpH0zDA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7ADDB44441;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 14:19:01 +0530
Subject: [PATCH v2 3/4] drm/msm/a6xx: Program the PDC sequencer on Adreno 620
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adreno-a620-v2-3-1d654c3f52d5@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792745340; l=4541;
 i=patches@brar.si; h=from:subject:message-id;
 bh=x4HOsHyXPYSkJ2t+WDA/wMUzqtU9tuPNuXBzb9lwnYE=;
 b=YTHcpeO9DF/KCWZAIWs3FqVznniqYVeIc1vrEw3Svor8mVrLAYlMah3ZMp88GOFGnMHdVaMlZ
 ca6nApgpXpJA9sH5iqmF7bqPfbO6C8rjF4QMjhI0wuNkayzYo8N/fkR
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
addresses from cmd-db instead of the hardcoded ones.

Assisted-by: Claude
Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

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

-- 
2.56.0


