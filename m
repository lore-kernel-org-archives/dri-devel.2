Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE96DC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0417210E11D;
	Mon, 21 Sep 2026 09:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GACWsMYl";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB58010E096
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:57:42 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2170175f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789984661; x=1790589461; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmVqhVDjsbCPitoyrJad06jlhftAP1UlcN5QiFNDWgg=;
 b=GACWsMYlCqsuYYTu7ecnBciGVaz4MA9VTdd+BDVPxBGtsaSfEUArWXjuB+WieiT3Z2
 dJ8HY14h1m0Txb1IUSZyNQNTsG/WlszQlInzXGk+JRqk5IsaDcVMlqLkjwPHVgbr+mKv
 V7qwL7GnrnctG2nhV1JT7v7NvGSo3o3NfMF2x+CJOQbFsG4NCt7xrGENiNPY8khUNOu9
 VCLWfOSira5+9gzCGIl4Tqv+kzNKMsq4nKLFYqff4tO6M30fI5rsoJKWAQfS6gSoIPeL
 QhrYnjVmoXImax3hKt3mfobbyWBg0M06roPMcZTTAzIByFa1GWpvV0VswF3mlRaefVZB
 13Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984661; x=1790589461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SmVqhVDjsbCPitoyrJad06jlhftAP1UlcN5QiFNDWgg=;
 b=ZBQDSBXKAN7jyFGmskViLniSGM93F1uEYJ9oxmpB54vLhn1moPx6F6Nd06VrYISfFd
 BMUquma3iSDba/leSZtcllRzjkHi3ZFSXSR3XUsMgZFrSgeMbr7keRnudHjidE9hO8lK
 IN4peTZ8LQ14AftpxgrnjTWSeA7GzSCIv0TfdC1iXOZAHXkhmeL1kzSl7St2+kcZjaod
 5JMzZl6Q5JinMbYRZTAMN15nHcudr+IxiE5Q3z0GQrPoA58PfEr3IfhgXMNOa2lpJ3k5
 oCcJUNz2uqIWtBan8HVINk/D3nEUsq5tFXvoTfbxJySoyqnDMI+LUwtXvfp66+sYUAWU
 +0UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNb9OfPgWLfiUFJwbp6g6pvDZw67Rm4uhEu0jMON07AN5lO3s5HBNfEZ3/T1ibV3xDWIwwDz/jzKg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nsB+a6lz/JwUhrFhe05E0U9YN7zGkXpIOwoSt+R4DxyHI7VIHZ
 8ZJ5xHORETlz4/WFOmK9jygl74wdgrAtv7dfsVqW3DQsSCjYE2rnJgrC+ugOGvE7khw=
X-Gm-Gg: AYBFou22UGmECMEsJYKHsG28DSB/EkGKzzzGV6LNep1nJWlZzc/IiAsvhvEKyFaPbxq
 i7yeSXmnAMGy6N2cM2gB3PlJw7DNEpGPTVHdzX76lKmxE7/Jf69hEFmPf1Z/WRjUPKIWI16Gftc
 HVbKczxXbNIZs4efE1EIodICiq/dxc4SR1QNlTbwraI5i01Qt3NMVwjGruplPhXtC72z3KCIwQZ
 iOgla9VMbr9vpaMd2fRWWm8u3cSyfgU7A1vXLtosX94sSfTK8n4IT31rwkg3DPvjYNwNvcCfkh1
 21VUH8Jaj7aBV3dq5nv8cHw9nCZXAmi8GxRhnWxVIflR8FW7lrTVgRARRMcUI0zlp4e6AswScJV
 Ni2Yrhdx3lF+BgIGEzqlnp9mOkpkgGdV8mC8XIKQTx6BPzEvlU8/JBlmnvxzqMhq/JfJ9Z4voBY
 fZdwtK2ksK/zlG2FliPSPfBZ7dIY3hEEk3dwXsv5OvLVtWFoiSR8HqI7nBUScSFjP5QhKZ9bE3/
 m9LyPX7EWZBZv5SYGU=
X-Received: by 2002:a5d:64c8:0:b0:487:1084:10fb with SMTP id
 ffacd0b85a97d-4871e395fcemr16963002f8f.36.1789984661019; 
 Mon, 21 Sep 2026 02:57:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487243cede9sm23826513f8f.0.2026.09.21.02.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:57:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 21 Sep 2026 11:57:33 +0200
Subject: [PATCH v3 1/2] drm/msm/a6xx: Add CX AO Counter registers used for
 a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-1-2b9015106553@linaro.org>
References: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-0-2b9015106553@linaro.org>
In-Reply-To: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-0-2b9015106553@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i875AYKR7692m6TI+q1mLN0BoE/Exug7bMQ6K0PhV68=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqsP+SOtbr427hIA28m16l5eRxKm765jfvOuKSOQ+2
 Hx6CT3uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarD/kgAKCRB33NvayMhJ0X9ZEA
 CwwKNoquZHNnBZpJimRM6Wjqa16TTIo3ZNhMAdoNrYuUPt9gjpn8iSyHgWMCLB695TOFjhwdP3L0e3
 m1QKQubVkEMAE5XsAJl7VGUyiUcShU06i7XrEsJyGJSrZ2XqyOh41Y0tDNcP1GMfVptDEzssNkMIwl
 GakpOJ9UhQWow8Rl4TCtblz50wI0HKLXTWCp1PIy2xY7JWHAGwd6kr+Z1JZjwRGqtFcMxiceSSokpY
 rvz6tFca6JN299Czy4aeEUJs4MAn8bMf4VI38cQPeGvaBxist71xXkIZWTxlnQHozB2Uimh9IWe4FE
 QAH0oxlQ8u6gKpysAu7BZM/V+KICXihXetyDsHmf/SIxa2lcG5h/WT5ZaY/Gv4otdBHj9JDJMdw054
 tDpDWyCvG6CoHkn5d2kvjhOBRXWxRIVZ9tQLEVc6cVJN1CtAv7WAlisGXI1/U5n8xCBXzy4gHjPnfw
 s62yQmPmcWuuD1Gs+zK9x1pC4qtJP/bEw6t0c7u+AB2JQ+bAsFCgUak/tPpMDXwNwa8PHh1hMnQC6n
 oCj/ybUyG6B5IP+Q5UkS/gAz4fAaxT8jrKuESFDti2GKQJ5G+CgGOBTy/wEVB1r/55arB+YynQm6WO
 aHqhDfAxlH38wjkpTIjHj/Qp2RJ2bKpO6BF9+8KY0mjRaL5Qn0a1ohhPflYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs.

Fixes: cfc8b48649e1 ("drm/msm/a8xx: Fix the ticks used in submit traces")
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 33404eb18fd0..b3082738c99d 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -141,6 +141,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
 	<reg32 offset="0x1f957" name="GMU_LLM_GLM_SLEEP_CTRL"/>
 	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
+	<reg32 offset="0x1f880" name="GMU_CX_AO_COUNTER_L" variants="A7XX"/>
+	<reg32 offset="0x1f881" name="GMU_CX_AO_COUNTER_H" variants="A7XX"/>
 	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L" variants="A6XX-A7XX"/>
 	<reg32 offset="0x1f840" name="GMU_ALWAYS_ON_COUNTER_L" variants="A8XX-"/>
 	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H" variants="A6XX-A7XX"/>

-- 
2.34.1

