Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ADA60A5BE7
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXwrfe2L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3D810E15F;
	Thu, 29 Oct 2026 13:53:18 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684E2112300
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:10 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1475367f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281989; x=1793886789; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hqI3xUsD2cNMA3OqjFeaiLeXLoIzktOWAoDJXR6bb7g=;
 b=NXwrfe2LAYcvcknS8hWP4b5zCvlhMq4p9phtE2QNEOpq8wYoWtwMttxu74exQAV/rk
 Voqy8y1kiGIJMdkM9WCZ9dkHwkdoHPvZC9xwy4RZ/MFvf173xY5f1GFILrQoSIbBhdmd
 9GG5/KYzhuDfXyO5t1o3W0jMtB5jQVBY0bjjgB+KfCy5BMC69zmRAaL+gWcBQmdqptoG
 c9VHKHDwh8Uwjx3C+RHzAmem/YdELbO5XQ9wMrmIBfWmOnvblnVNk23u9y41XYpdJsud
 t2ODTT0MP4jpEOX53BsV9xQxUqigzL10LYBAaAtF/Q0h1KiKK63v5/vTAsnRG55NdRrR
 Yu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281989; x=1793886789;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqI3xUsD2cNMA3OqjFeaiLeXLoIzktOWAoDJXR6bb7g=;
 b=PgEo5l/ZJ2vsr+pBusuND8OpgTg1Kxo5eoh9PmjqTUMxDTYHUjFhyG6IH9bKNQha9D
 7XQKlG0QJRoIMpNxPtjNkqXLw7zGuKmcbi0p6iJH6t/h0U7ZV18lQu7b9Tsh4wusqLpR
 5mA3IRE7rt7mQyOYTbecPFr/7NLhHXi3otz7jByjxNOZcgVuS/p5ln+4fa0cVQjg5UHV
 zB6nbetrB6diXiwJNdscPQnJeOESD2Zpl0Uv41NFnvfCtAuoDjYcbBSU6UMaTxn3g9Vc
 1NJCNS9F1BjZuv3oJeWj7LacTk3oHVmjLsqNkvoetMnDF4l2iKMlw/EA6xBe1JPEYdYN
 IINg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1E6DnKgZzhXKfjmUYpMzSjP3AWG7KycOv+8eZ0DE7NooNWwlL4suDzQBb+DVz0IGn6y8t5udt+zo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3dAtlChoyGhm+SSZSuZSrm/Yf0FBB2MEHfqizqABcU0SvoRAh
 8NOY8oPD2AdxJPoJYkIQlbniRhNhNE5VzuH5rPE+15Egul8QcxQINOM=
X-Gm-Gg: AYBFou3+dK+34uNHkVsh18DSjXIs8splez1rIES8mB9Hxnj/tvqFmOXTXafkwYZS0MB
 bpiRrhrp+4gBpOC8kz/A/AUUcK7UngiQj5T/dgZ0nBkX9q0LLxE9fK/viepHae6OVLO306FnALZ
 pxIxrjxdKWZYC8BN6+q5eSF0u6uXFmDPU+lkNIOu3UrnmZI7dVHLwy3I2xa2CU3k1UiTnF2ogoT
 hk4QJq53HnV9c+gWYsszhGAfFSPR2BGu9jiXKncBegOatlsOxRjFdZIRq0/zHSPoKz/UaLWpJdI
 DtCE0UyQ3vEo8B6IjIhoP39ziRjfoq7GC1SzUxFmfM+83VaJj+GieFU7H8Ul/5cqTpZ59zkTnEt
 zup+MNoR0BI04T3XLgNetGox6UDQQld1QTjhhNkyMq2K0OCY3lzOxbGDdFr76EnC06/qmIQpMuq
 MnzQwBF6/aPSIreBrdK5YE8pU6G1O1MQ2XJB3K5VYbPDGiO16Ta6zWFtKm7pEn3OVIWp4bRnfgP
 EzBvQDGsjHEofbdEn2+MbqdmjVSpx6j8+stkNS6qOI/baKKXf05R3rctjimHveBdU6dTD/ukf00
 JAj/nfqI3m9cX9F/Xqzai7KLgVEVkSz8DtW/7gXmPISpUw==
X-Received: by 2002:a05:6000:2806:b0:48d:ff0d:cfa5 with SMTP id
 ffacd0b85a97d-48e5d5e237bmr9297013f8f.47.1793281988693; 
 Thu, 29 Oct 2026 06:53:08 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:07 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:41 +0100
Subject: [PATCH RFC v2 04/14] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1186;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=m8LjyZqlFLsxlRip5l3NXkwO7GG8cECPX+LNQd1tpmo=;
 b=ARxR4H9sfFo+nvh8rZ3WMz/5vBOcWptYc4QScQ6BwDzQQ9ZqJR17Rkbis3J/NCOw2T3Y+DXYV
 1uradRrW6R5Bl+J4M4CED5l+9lrrUHdMAtWHma7WA0JnTxjPc/6/H28
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

Previously both SID 0 and 1 where associated with the same domain.

When LPAC is not used this is needed so firmware can acces memory when
initializing using the same page table as GFX.

To use LPAC however we need to move SID 1 to a different device.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1604bc8cff37..f47d1dbd06da 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4144,8 +4144,7 @@ gpu: gpu@3d00000 {
 
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
 
-			iommus = <&adreno_smmu 0 0x0>,
-				 <&adreno_smmu 1 0x0>;
+			iommus = <&adreno_smmu 0 0x0>;
 
 			operating-points-v2 = <&gpu_opp_table>;
 
@@ -4158,6 +4157,12 @@ gpu: gpu@3d00000 {
 
 			status = "disabled";
 
+			lpac: lpac {
+				compatible = "qcom,lpac";
+
+				iommus = <&adreno_smmu 1 0x0>;
+			};
+
 			gpu_zap_shader: zap-shader {
 				memory-region = <&gpu_micro_code_mem>;
 			};

-- 
2.56.0

