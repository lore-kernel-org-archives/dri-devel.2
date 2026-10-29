Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D39606A832
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BcoYzhJb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EA511231C;
	Thu, 29 Oct 2026 13:53:32 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C646B112309
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:18 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so455273f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281997; x=1793886797; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rFW0YNxgIXO3yK9W7NnNeF63YsxO45UeDwCNLoLZDXE=;
 b=BcoYzhJb8NFOPZCizwhWLkhOBnlDRs8enWi7B78jvxfA7txy2MeS4RbMc8L7M240E3
 k22NaRYcEutWmo822oal4cHW/hDUFkzQ9mn3noivkUlCWAla+pRJNdJAY75ErXcEWWMv
 QmrRg/c1pQcwBmOuyQybaHtgSyOy18T39U1p6ZgWdnRsb8VuNqgtwfFbeFKQ1+zc4lbs
 fGOQvCF9LyYM7AKnkCqqKMDBKSVVFvejjra+vWhjvgPVqyLHyH8iXOJ66mbe3H1og2OV
 5Z7WemPccWNHzz6Zbcb8b+sfV+c0JT4YRwcJP22o5d7fsrXPEJKOP9MAnrpvb1qpCaYh
 gUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281997; x=1793886797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rFW0YNxgIXO3yK9W7NnNeF63YsxO45UeDwCNLoLZDXE=;
 b=CJRrJLoimpl7yxF2z7UqYVvaGhAKy2NoWo/xM/Wh7y6D5dATZg9CXQmFGyLwXJUjct
 ao2/61KvW8J8uAUDc0mJ3DIG1pUDSNWUFO/Ffe1+rSXRzjcu6V7L0tKWpKVj2wF0e6U0
 Qph06S1p/+F1xgQPu+iNqjvihHy+yotUeOozh9zP/QMQZn1+kPWJU+99Iq80NA0wuKPw
 bzOFIvcP2vyVOn5FOXdlNkB87VxUL1bXAXP+JG/HHM0oiQy6QljbXPQxEvwZClUj8zqz
 m1KjiCTCYtL5203mdad3C+c86jApnLZ85jOtLNn8v2QGTPYsaA1aLPEapjavvYWfasoP
 q4fA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdcHFjvazyjBKuKJfbkIG8svBkANIfPGI/bIJF9+kOcf6z+Ra579QoJo2vvdLbCLiyncGzs7Sa8TE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2AD+kpvHYqipN2N37vEXv5TT6gbcKGpixIPPnUDoiZRO6TAkX
 qHA+dWfJWilcUm7bCceUmIDChsF7DeIQSUEyQaeF2n7QQup1n1y4KJU=
X-Gm-Gg: AYBFou2A3yxdgPE2qotW1ztHHT/C0BbRo/+ZflSuLz2/DYhzJl+2XuCRrKXbNe2XhDO
 WPLp8mA7sQgkH0Cx5ByDKAVZJgs5NX5o5Nd/ISl9GJqeAJ81YNdv+nu0I3UZ2gnFskWAeIikRJS
 5LraIOHCC/VKwnQNUvkJbMFiyYqTsM/4Vq9pdCegK4IqamwT0x/0LP9Tv/DvLS9zvbJgGsfSq6W
 c+BXmh6u2Pw81/GubdBeLlHrL5zaiRc+pBW6D5qJlyOSavIXyqhmjLacLvxQY7SXgR7KTW7C3CE
 Y+2kU35RJatNx7QhdV43wDEczh6I72W9UKZGAlkQqwy6paPX4r5gftwIoqJFsfebcKJyiu0FF9p
 nATmh5lkPKTPHpTnWBjjnuqP5PYeK/3VirGAqtZZ1WIdw8gz86HE7vJ0xiJkMLx7VX0qkEQCExb
 bOUujVqEJaC5CR/ZeRfdAM6VpbNoK9H1UpTYP4Mgw7Qhoeexiu2PxWUIa+57GJwzWoDJaUtog71
 4UZYzEDMUIT2kq3V6ta4Fpym+Maow3/JRSu/HgaG5tZphrX6b9b5eINVVshUCqEhcOb1LZlEe2h
 1BkSUm8hhUDb+xKbcmURBH7duBbT/eGnhOMqjzHBkxevzQ==
X-Received: by 2002:a5d:5b91:0:b0:48e:60a7:e0bd with SMTP id
 ffacd0b85a97d-48e649933c7mr5094994f8f.17.1793281997067; 
 Thu, 29 Oct 2026 06:53:17 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:15 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:44 +0100
Subject: [PATCH RFC v2 07/14] iommu: arm-smmu-qcom: Fixed mapping between
 sid and cb for gpu and lpac
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-7-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2537;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ddmhwqAVzi4UvZ7es6VT6qKlZqL0nH2dFG7G9BUrboU=;
 b=bSLxcYA1Hg7TlJKZ47oBfv1YRksocS8fOUT+GDiqsMJuS2PEP6fGuu8UQ7sr0kvqrRp2ErWZv
 hi5jOvHNIWgDaeJxu8pdrMCwt9FmVwlER2SJfgdk1R9+hQIkj2UjR5Z
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want to map context bank 0 to SID 0 and context bank 1 to SID 1 as it
makes it simpler to deal with.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 31 ++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae6152bddf8f..9413b748e79d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -225,6 +225,24 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 #define QCOM_ADRENO_SMMU_LPAC_SID 1
 
+static bool qcom_adreno_smmu_is_lpac_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
+
+	/*
+	 * LPAC will always use SID 1
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+
+		if (sid == QCOM_ADRENO_SMMU_LPAC_SID)
+			return true;
+	}
+
+	return false;
+}
+
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -237,8 +255,7 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 
-		if (sid == QCOM_ADRENO_SMMU_GPU_SID ||
-		    sid == QCOM_ADRENO_SMMU_LPAC_SID)
+		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
 			return true;
 	}
 
@@ -313,12 +330,14 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
 		start = 0;
-		count = 2;
+		count = start + 1;
+	} else if (qcom_adreno_smmu_is_lpac_device(dev)) {
+		start = 1;
+		count = start + 1;
 	} else {
 		start = 2;
 		count = smmu->num_context_banks;
 	}
-
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
 }
 
@@ -363,8 +382,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	if (client_match)
 		qcom_smmu_set_actlr_dev(dev, smmu, cbndx, client_match);
 
-	/* Only enable split pagetables for the GPU device (SID 0) */
-	if (!qcom_adreno_smmu_is_gpu_device(dev))
+	/* Only enable split pagetables for the GPU and LPAC devices (SID 0 and 1) */
+	if (!qcom_adreno_smmu_is_gpu_device(dev) && !qcom_adreno_smmu_is_lpac_device(dev))
 		return 0;
 
 	/*

-- 
2.56.0

