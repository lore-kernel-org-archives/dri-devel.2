Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F6C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1F910E26F;
	Sun,  5 Jul 2026 19:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bMpPbK1y";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACBB10E22B
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:31 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47de008b020so139879f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278869; x=1783883669; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rBnb62S3pox4azVRKerhjkKWZjHIp9f0CrUrLIrizHI=;
 b=bMpPbK1yLGS/IsA2T0M1NJ1FhKj+Hnix5ihkwi1CQlEEx9VqxshshYDTJjc08SUzI7
 i7LnF0Cw9yjHsqrDV4JELlkmTb6QB1UNzSJZbg2NyQl8xLEJvVP59IEWQLIeP5m3b5SE
 E0OUPRtrcrl4esmjAL9EETF360WWEfVVmZz9L56xmHFQ1p7c8PkRjAljeRoC65XQUnBq
 9bMqHwov4JOdkSrRS30WyvG2iME+xBzjQS7FSQObP7uj5Erz06hCuHpp8oHiTRhYCt9i
 VRX0AkKr7J36soNUnV9G3EWfTJJRmDe+A0XJldgBof4HtdWjvyxk8S8TZ0mZvgo+IbQz
 5iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278869; x=1783883669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rBnb62S3pox4azVRKerhjkKWZjHIp9f0CrUrLIrizHI=;
 b=nbmb/giG9YMb4TjR/6nhIqF7rn2T4MrH26pmV8euJGqCfv1ZGROcwGE8d6iHXIwBWC
 iTx0QC2+ETSPuK8ke1Wv36csYYSjneui4Fv9PEIZg48AsoqXYXqpoZmRZBhVmIHmpikl
 t5Rss0TuRkrqdd65qwHIaHImGPRW8UHNqwOdgDMyl/neA9Sao3czIAIrKcwf4B4cJoFV
 TdxsZczHxBfkycms2NX3cKYFo4UZXhfj2IVKrewYfFbbvaNq5ysqtAVHeTX7SDhOJI73
 7IF+jEQtnFdNbgMPpaenm+6MC2L+WPeY8rQQfu4xY3ToORA2i6TeLJffj920S5ekHMgn
 973g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGYdqa41H50NSRW9bnkEtzQBlMcoDEHCQHeCiXosc1y669IaR5k/J2Sde4thh3WzfKdDLQhmB+71s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBvtSkKN5m12eMff1l9DQz/BcqCYPWkPVPw4cceRH1IB4amt9o
 5s/GWUdmisC8+LlkEd9mvSJ84EiQxdsIVsXuuyag9IbCZqSZpXpklK0=
X-Gm-Gg: AfdE7ckKgXRCrOphdxIIde4n3eDwE31M48X44yVtjFYvXMIDw/zubEw1sZNC8ylWlHV
 w2KIiOdF1SkrMmtDnPzJib451BqQCb5MZwxL6z4OvgUvL2sbDsi6dDDDHCjrWT82zPcbTb7wlhC
 +PI2XkDXqzdA0IBovoScbMOqoOlTueZ/uXKyfmGDTfQf/nhHpD7QA80IF1SPU8opSMG6Uagthcw
 90Kng3BLV7iwy5WnHNl9UZ6ViPLfWtZ0Uz3NOKM2FSXbzi4DnpaZPTAOCZ7z7OwsC/nMzG3+DJN
 exYRnbG+X5Z6/iZJpI7hXV350KT2qpNYvHRkyclXS/6iUAwvrhS/fLhFvl+Lvb69ZQjoK7vOmzZ
 nG/IXQJDoAZboRRR8ddG01jkS/1FdfonyM3iohONGCdg4cWg5WhsCh/nLOhLqt/ktpdjfw3EiWh
 0rnGzO5bqVoqUONIR0C3ajFuBeegjDmw==
X-Received: by 2002:a5d:4530:0:b0:472:28f2:506c with SMTP id
 ffacd0b85a97d-4793561c1b7mr10294287f8f.13.1783278869284; 
 Sun, 05 Jul 2026 12:14:29 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:28 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:42 +0200
Subject: [PATCH RFC 08/13] HACK: use cb1 address in lpac dtb node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-8-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1103;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=lEQBWGFQsawhS3Z+empPXIW4pjOUFPTBX61IJG+8wpQ=;
 b=ghyBtO3mPmOZCBw2AnqYHPShuXdJyTE+gTcOSZ9YU5rU1L9CLwjDKC2Kyv3ZqsOQvXyq+rMJb
 aTedKIXba75Aenv0imb3SDNfjufYxVMYzOkJYRnVags1gnQPFh42M4o
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 44e5f9d4b335..66ea9155e228 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4133,13 +4133,6 @@ tcsr: clock-controller@1fc0000 {
 			#reset-cells = <1>;
 		};
 
-		lpac: lpac@3d00000 {
-			compatible = "qcom,lpac";
-			reg = <0x0 0x03d00000 0x0 0x61000>;
-
-			iommus = <&adreno_smmu 1 0x0>;
-		};
-
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-43051401", "qcom,adreno";
 			reg = <0x0 0x03d00000 0x0 0x40000>,
@@ -4254,6 +4247,13 @@ opp-834000000 {
 			};
 		};
 
+		lpac: lpac@3dc1000 {
+			compatible = "qcom,lpac";
+			reg = <0x0 0x03d00000 0x0 0x61000>;
+
+			iommus = <&adreno_smmu 1 0x0>;
+		};
+
 		gmu: gmu@3d6a000 {
 			compatible = "qcom,adreno-gmu-750.1", "qcom,adreno-gmu";
 			reg = <0x0 0x03d6a000 0x0 0x35000>,

-- 
2.54.0

