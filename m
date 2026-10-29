Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EE606A82F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BM8YaRqq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B420F112309;
	Thu, 29 Oct 2026 13:53:32 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2986F10E53A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1157817f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281994; x=1793886794; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpY7be90G/SGk1dVlALZpqn7ki65kr0ccX4qFPemUo8=;
 b=BM8YaRqql7vofIJIQdt859J/Dx5RoJEYRxiBTcMrtqyw3HJOAc6t+Gv9DcrAv3hc3O
 TxxniFsysoLY48hce90prIkJFdIEO4OfemVNf89RkJW/OzhgA1D/j7uPx2p7QgM9Gkjb
 wUEAcorBAei2VtblN9Ozur2Cq687lsq/WJbzj+5FnCINrckWVvkqRvmQGtNdZmof2+bR
 28RuUTj4pUk80FyRptaBRvXTkTvVMF63h4cMUsR7TgRoXiA8KPrT2z94vF2z/0Aghn8S
 J3xDUhau4jwTfoP5OGrocUUTIxNNwQXBESlY0jm4bAuPLAppyHhGno6X8KC4ZJEAH/04
 n0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281994; x=1793886794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WpY7be90G/SGk1dVlALZpqn7ki65kr0ccX4qFPemUo8=;
 b=CK85GruNtuuiOVkemifGb/Wo+/IXnp8lVP8FbWSqCBIQ28m6t6Q/udmbjfrNpFld8v
 dnzpSdxOHCTtTlwBRtnvEGDCbfBF90Vd8M+s4hhuubqUJuL8FeWmhcQ9qtKL01lkHPTU
 73CDY9qDc2UNNnpY0TH75SZL+QMmqFfendzY+SQLBklekAfb/mym/RJNfbcxnp9jN03U
 l6l977KJoS2FaRDeE3h31QlClGHLI8kXJol4w4+fM2kGiyOpdVVrR30nuW2i4HC44WsS
 rAgD9i+0uxoWna7Q2+Y9Ei8Cm1sBN2r1Qw/0j4Nr1zAp7bO5R0l3QPdXjt4E5Brz0olr
 SqzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcu248x/WuAy0OickqApr4RqnHM4kIXrEm9gA3vjXqhr+mH58pU6y8LJ7dA39S3Az9/kBoeuMJVNg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtsnopCQf6lrJ8hfNNdl5krtE1o1+lpLEwQFf474++7QJRR7BK
 PKTKvLk9795huU+HPVkNyjKcbzsV3LZJgm6dVMyYXoHqzwl9tyF+Byc=
X-Gm-Gg: AYBFou04Y9Slv+xwy9vG+XrTqtecG603SPp8F/z39cSyLeyBK1V2dFGQAKVAoi66wMX
 U3JF90d0MXTwfOI4Q7i8eCjLCL4ObjlYJ3zHKopWCevOHXGj3+X7I4Up0KWI+EROslhcv6ujfyg
 DZfu8PdGyOp7QPtOuawVlyjrjFLZYMJXv90qM/lbutkv366w99BX1uSynmgc4hKoEIKJ6VS435t
 rGNhDpIT32fzQ0rBLNf1iOaa2Ho5MMJBAUXjTQDMG8B7QnXbgFl6s2jXOAOhLL+gkgVTnmi4xpU
 6MexvtIDSnwtgYlBIDN2jR/E+UvVmavc0PwRYQzoTfj2caH7io0P2NOgsOouxAKvuVGh3nqhMuz
 rI2Vb8yiT6iZNF+8iOKHqkMc8w3sD8jPUOkPf4IOKrlimzv22eCaPApnJ+IZ1iwJv0sN6aoM0Yt
 c8ZRD99lh/9gd07Uk4uYGnWTMYD4al/NgBu95JA9+gdLFd7gyRjf3AKMPGc4Fj0DktO8U+yi5fK
 UHmlsbDfdJVUt648g6Hvu23A6ePyx/om+4OWi8T0ZJHPP1uq3QRcXDBj5+3j7Q2IDRNzaODlBq8
 JiN6raZXzq8NAah1z7ioWwrduWEpZ3eoDCAK/0Dn2i+oHw==
X-Received: by 2002:a05:6000:4715:b0:48d:f383:2356 with SMTP id
 ffacd0b85a97d-48e5d5d16afmr13493554f8f.53.1793281994421; 
 Thu, 29 Oct 2026 06:53:14 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:13 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:43 +0100
Subject: [PATCH RFC v2 06/14] DEBUGGING: print contextbank and other ttbrs
 on fault
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-6-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2450;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=dH+it9hPPDLJzOx0q/+eo2IfgBzUDyQPf1+n9ilF6yo=;
 b=rSQ/TIKRIiV2aSX7/+jAtk7J1jcL0JxB8zRWLfn1sl11ELATT02XD6e/9sRnBZS+9corw6Stl
 Oo1uS/fWy8LCZ5C5THVWfEq4MkKG8/9Q7VkA0Io7j8QvOp628/2VM06
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

Faults can now come from different context banks so print that
information as well.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
 include/linux/adreno-smmu-priv.h           | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 65d34d0cfc38..4389559e1d17 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -329,8 +329,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	else if (info->fsr & ARM_SMMU_FSR_EF)
 		type = "EXTERNAL";
 
-	pr_warn_ratelimited("*** gpu fault: ttbr0=%.16llx iova=%.16lx dir=%s type=%s source=%s (%u,%u,%u,%u)\n",
-			info->ttbr0, iova,
+	pr_warn_ratelimited("*** gpu fault: cb=%d ttbr0=%.16llx cb0_ttbr0=%.16llx cb1_ttbr0=%.16llx iova=%.16lx dir=%s type=%s source=%s (%u,%u,%u,%u)\n",
+			info->contextbank, info->ttbr0, info->cb0_ttbr0, info->cb1_ttbr0, iova,
 			flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ",
 			type, block,
 			scratch[0], scratch[1], scratch[2], scratch[3]);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 48a590aaeb5e..ae6152bddf8f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -136,6 +136,10 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
 	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+	info->contextbank = cfg->cbndx;
+
+	info->cb0_ttbr0 = arm_smmu_cb_readq(smmu, 0, ARM_SMMU_CB_TTBR0);
+	info->cb1_ttbr0 = arm_smmu_cb_readq(smmu, 1, ARM_SMMU_CB_TTBR0);
 }
 
 static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index d83c9175828f..5d6de4b4de06 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -32,6 +32,8 @@ struct adreno_smmu_fault_info {
 	u32 fsynr0;
 	u32 fsynr1;
 	u32 cbfrsynra;
+	u32 contextbank;
+	u64 cb0_ttbr0, cb1_ttbr0;
 };
 
 /**

-- 
2.56.0

