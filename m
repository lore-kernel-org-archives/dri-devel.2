Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B260A263A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TG5pcZAX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DE611231E;
	Thu, 29 Oct 2026 13:53:33 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F360E10E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:12 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1692892f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281991; x=1793886791; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/SMmhEanFf2ZRlLzrXMdAPzQTHRLaYYpOnEMjr9oaE=;
 b=TG5pcZAXDiSBZU9F7Smk2CFRIW4mz3VbPVS9xyK7jKk36tP5vpUvosSYQkdS0ipxOi
 IrrN4a+6Hgh9Izi8L8Jv1oHFHRNtRX1WXKtzpv1PDeEX6beN6RTxWsRVK4LeQa39PdNq
 KTTDFNFfTMdUPZdKW4mH2nUKvOFCHN4XjhkL660kmvtw2QwMAWIc8QVyR7A5eksNtxlb
 /HSMn18yaK98z0Krs4h2yLGu1xpJmMjis599cA9EWPwWgTk6lHp6qb3OX37LP0uOAvTV
 jPvss3Mhv3GCaWFcp8n1ox8M7JMVKm0k0vWSQTEg68z46ijJeqy2IZuj7yKF8txxyxjD
 FU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281991; x=1793886791;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/SMmhEanFf2ZRlLzrXMdAPzQTHRLaYYpOnEMjr9oaE=;
 b=P4iis3mZWExG9dmnToIRFQViz245wAiXQIcXHcRkGl3tz1rTCiAOVaSWLx32H3AWLQ
 7vfNFnLf0Kx2VKP3DKSgIPab2Wv04IDJ8AU5wUs7szAQ8bLBZOvdKVQZLUduk8iyxo9r
 9a9QlW0jZ1ue1LIHRbzog1QeC9bPkuxbk/TMjCVrwSsxmZSSHdbzuP/oN+AAEHV67oSs
 bLGBC5Ok3mU+PRpcSD0q75Qg6bnvsMlC2FmrWOSf1ODSF+9eLC30Nw3hAW+qK9VNwGST
 MFcw+HORGfb4hXAcgr9rw89u0heqh5iANpdH9Cx+xcqgT7QoUXFFYPnzScnOgMuBijML
 CB0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7fDk+0UAqdCtjzJghzjPtrRmWmhXL7BgVLi/rF2CHejvYVeVA3rK2jM1ldV7talWE/gWhhisnp9Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLvEx2+FuNfI8/JBIPH8J9m8H0KeNQ96wuyqMrBIkY9iglsIMA/
 IxUxawTLEYLAmXROCCbgx95+Oi2ujKGWijRY9zi4UIrCG7qBiR/zBHo=
X-Gm-Gg: AYBFou3QB/mid9CRE70lJePgt7nYNVa4ZMP1eOefhM8wuEiGrhTKtE1Aovyyx6nmWkJ
 Jh8pZOyMZvfxnqyYOBctXKuRWsv0nQZu/jSJ5L98BCPX24D8N5i2JzYYJTTclrQaz07arFsEww8
 3kaPsmsNZdg9Qma1Yp4VkZEh5F7hU3OVgjWZVDskxQ5bVWUdEAEkmJ6YK4Yio4YGe5Nm1t43s/L
 tFkvinWcqrI7UFsPr263AGs2wjhZxY0Otw1TJldSPZomqmXFafOgUlv4Qo97eWjb4oXxip5nP7Y
 McGqX6Q6iMWDLbvcMXTgwWOcqvr6u/5NwEapbMaM+o9n/EOaZhmOKs5KREkSpZ87YaNj+ZnRN6B
 7JgwZEcTTokUGYjkxIKwWdD3L+WWEY8/aRWwW3jQ0/RDWQhNkZPbzqR0yOEpcVv+a/Xb2X5e3Kv
 1cLGkAeemZaYpLZ0pLRn9aCFkgVvN2lBU85yQRVKkZr+KMSJqZlKJa6ie/h2zwPkSeYihjsGJwu
 r+x9R7VM1q1GovYWX3dK+C774bXPdYbo1Ww/jaAZ7S5XoVxqylPmCSXC1TtsT1MPcNzOhQU5/Ee
 vsLXBJazhEf+GYVnMT19I6vtSjLCwqnIZKUOf9n1IvSYvQ==
X-Received: by 2002:a05:6000:989:b0:48b:123e:2f5c with SMTP id
 ffacd0b85a97d-48e5d2f2222mr13148384f8f.29.1793281991354; 
 Thu, 29 Oct 2026 06:53:11 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:10 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:42 +0100
Subject: [PATCH RFC v2 05/14] firmware: qcom: scm: Configure LPAC aperture
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=4016;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ivUR5Pb7Po44Alwx0ZT6ubl1ZzDqmOPjsdTHTPY8+aE=;
 b=CzZBZhvXfsPR7VJKCtyL4sntORzIwyrw5dpz/xoNsZ5uORTwXp8jhcD9HDV0cCBFD+qYUv+9N
 gi7Oj1wgVHTBJ0bjH6egCOnjdXcy2F6zKpvCrmki17UM3EuffiJgPc1
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to be able to update the SMMU registers from CP for page table
updates we need to configure the LPAC aperture to include the context
bank that will be associated with SID 1.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/firmware/qcom/qcom_scm.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  6 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 include/linux/firmware/qcom/qcom_scm.h  |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9b06a69d3a6d..92093399f20d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
 
 #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
+#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
 
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
 {
@@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
 
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
+		.arginfo = QCOM_SCM_ARGS(4),
+		.args[0] = 0xffff0000 | (1 << 8 | context_bank),
+		.args[1] = 0xffffffff,
+		.args[2] = 0xffffffff,
+		.args[3] = 0xffffffff,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_lpac_aperture);
+
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1dedeb19946e..65d34d0cfc38 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -658,6 +658,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 int adreno_hw_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	const struct adreno_info *info = adreno_gpu->info;
 	int ret;
 
 	VERB("%s", gpu->name);
@@ -668,6 +669,11 @@ int adreno_hw_init(struct msm_gpu *gpu)
 		ret = qcom_scm_set_gpu_smmu_aperture(0);
 		if (ret)
 			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
+		if (info->quirks & ADRENO_QUIRK_LPAC) {
+			ret = qcom_scm_set_gpu_smmu_lpac_aperture(1);
+			if (ret)
+				DRM_DEV_ERROR(gpu->dev->dev, "unable to set lpac SMMU aperture: %d\n", ret);
+		}
 	}
 
 	for (int i = 0; i < gpu->nr_rings; i++) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 1f201322cb6e..ec234a483036 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -64,6 +64,7 @@ enum adreno_family {
 #define ADRENO_QUIRK_4GB_VA			BIT(6)
 #define ADRENO_QUIRK_IFPC			BIT(7)
 #define ADRENO_QUIRK_SOFTFUSE			BIT(8)
+#define ADRENO_QUIRK_LPAC			BIT(9)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 5747bd191bf1..70fb93e303e2 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -100,6 +100,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank);
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank);
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void);
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);

-- 
2.56.0

