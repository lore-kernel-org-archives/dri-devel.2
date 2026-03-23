Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A32F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5ED10E3FE;
	Mon, 23 Mar 2026 20:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIsb29pf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGQ5s4Fe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F69510E3D2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqfR9943795
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZUIEeydvmYEvJ4AasFR6sWOSfK2dLPW2bJak6RaNFAA=; b=iIsb29pfOLl8jjMx
 1Bx7nY7TtB8c02p9LXjZXleyZS65YbwcWV/bkTiBoptVdI4KGIpsdyOfz2r59XTU
 e8t7pRzjbm2ZN5MyA/Kc4xtvtLzxt0ozB6xw3hCzHgV3kUc0t146NpKU4q72r1nZ
 umUa+oyyzd7j3AU+wbbM/mrKJ/BdmvM6Uh2ewcFGSl3Zp5pgNodZdzjHj63XNbKo
 hQ2C9KSdcKkuxqyGvQV2s7w2Ends0WTPqcXgIJUwjtTKi3iFTEg8XXvjnOgzOAWB
 Gemrvp2i9nydko7onRfz1Fq/shRNvw+L0Y3bBNrbsDYAQIZvecd316RJK/QsM4KK
 UH3w3A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkss0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-829a9d3073bso1698807b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296770; x=1774901570;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZUIEeydvmYEvJ4AasFR6sWOSfK2dLPW2bJak6RaNFAA=;
 b=IGQ5s4FedOIWTaQH/ZLr+7TxEcX0jlzyG0CcuWoo91ZiyKx84vz7k0TSP2+KYCkbn5
 LdR1yjkmtWfCZdqZtcwX0oW0QkXeB4UqHu+7RWJB1E4y3TtTrCnAEISox6/6eLPmhGuP
 rbZqgOhjN/OueXsLFw/3doUNhrUaYfbRc8XBxH+rZsmujX1NUMiJnofTVfNRhjIouXzE
 c1FT709cppYLNYKo3xVGM+lNrJqEbxY3EVg7MtGE7od6ASp3/vwKxmaStNKJjy/HlF9C
 OJ1HTKXnTGLBd5Jsc7msbXipb0We61LqwzBcHAhXNYbv3+vhStJ4wweeL6/krLXpROPz
 0KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296770; x=1774901570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZUIEeydvmYEvJ4AasFR6sWOSfK2dLPW2bJak6RaNFAA=;
 b=F2Nka8hTw/00Xq8aE4LUYH9IF+hlNDzz/DjVXxIRa6fUPLa9VzQhS/KqBxdSEcGyu+
 3Pz0mQcydinD/XzAj/JREKsAx7wZfxYFf7PWvcUT7AqRkYj8k8hhPXTVegS5YoPFBgBl
 wFw7vttacCzP6DDkvyAzCCOQEDu3UqIJCK9jlVr4FX/V64KWdgrK9EsAxrjt3wi1AGs5
 sHqszHoauFIckr0/LCMGjFvBULrq9Xty1UlH5Y65TrJfboonirMbpUcjb4JILdIi6kK2
 m8YWkkCdgXxJvhhHuAT7kai60vOFp7YNULSv/lxkt1fs3uwGzXNc0aVKE2VN80htfC5O
 FnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVufWhdqRI//If8FKkdX1yp3CLuS747/hYLYH+RIp9PkmgzHLRJnXKizF5ubOz/1/ls9eBTly5Mfa4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS2wXuibn9yIRbqmBm87fi32WsMiZFLS+d62SmIbHoNUnrBdom
 zk1w0RTASfYR7sYxeWHnmKHxjZi9imglcqvUP8uPnm2GgjvbU9I/ZnVJAZ3cVHYoEyQWLasCLJi
 V/2wR7hoOu24JI8HHwyOucE/MEbC2c480uL/RJE3zZDPf1LaeintoUaiyhvzmzmO31ojiuGE=
X-Gm-Gg: ATEYQzycfVN7iGhleZxc3JVzWi5V4osX8kGdYZ0UwyZcxr6TBsjVJLdtXUFJWQTGzHn
 JmSDYrbv7VF44RYSZ4vzWuCUAvjcqFg1ZfUp3f95Qi+eHYojc1etv4zDhXA5aXwE76VTKU835Fw
 TGf5svxp3301Nt2BMKpClzngFqRkBGZ38x/BTSIAgdgl6683rbm+iGTBDx6WpLykWDTb4hVn62y
 Tev+Edo1l7mLzpqiiDMiJa09nHpKf0vDP2BJH9RZzvPNbhZAqIbcuJQFhnAg85x3qWXVygzqcD/
 +VoGN5Zi8rQW3KI0zG6TtvT9ctslWGjxwIV50fjb4cW3uq55PgzK9p9XX7QK5x0dm4fHRFPH1Cd
 Gpodh9nasvD+tVl0jevvirYzK3647xWhqoYoCV5E2JMZ4YQ==
X-Received: by 2002:a05:6a00:21d5:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a8c233026mr10856569b3a.1.1774296770502; 
 Mon, 23 Mar 2026 13:12:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:21d5:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a8c233026mr10856553b3a.1.1774296769990; 
 Mon, 23 Mar 2026 13:12:49 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:12:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:14 +0530
Subject: [PATCH 02/16] drm/msm/a6xx: Switch to preemption safe AO counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-2-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=2121;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DJLzmbucRspXCItdG/LdYzMZhld/T9yZi2VyuKHhrhU=;
 b=7eIpyiPVzz3/lA3tNdx6v3BjVJkz9FAwX5gIBKai2tJFGSn0FlxJ6dayYSPkVj/CSLne/fone
 t1xRhr84PPcDzDlp69R41ltZrzK+IhHNEbKr9lypHSHELE9CV0laPKm
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX9L5e66aIo9er
 MWt/eT6uBkQuPudXQ0HDJfGAUppzX445P+9R8FeH4YiPJ4B7Hd7cB9w233GB19uO0f1wfjt1cot
 SBW3cG5UJFj0iKCbKDLQJDpJCu+6obJ7Njk//UfRB23cGvnrE4oPYO7Ajxx5CEb0Lio7XKDAwg1
 vu9KBFMdiyJ8Q+FBS/ygj04LhyF0fOgxmVdEp8Xn4SP0+1isuDLfvCLIHZWXmvXGwDK3MP4+l+d
 gRUGzqTE+cmr3smBxM9w2PBnZhk+VkCFmQzzmdU2RmeAFSidBCGwJ0FA1/gJuu3LbsevG59tEcv
 c/+6kSyf82cfakHi3M49BhtFgRBJzZujuZyI2RtjwKzJUL71tjylL/TeClAByEdYfloDi8Qandd
 vvkARjPadKTbOq+SZKGn+6EQ+oG8TmILA2VjOlSIedmxj5CmqGH3i7mzxaRB87Mcot2FbyuqZdu
 6EmsL81xpIIJm5yXAXg==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c19ec3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5jko6oGmZP8uHvb63LkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: amDAmRGkNX1w-2M-haP_B5dMpTdRHFjD
X-Proofpoint-ORIG-GUID: amDAmRGkNX1w-2M-haP_B5dMpTdRHFjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
provide accurate data about the 'submit' when preemption is enabled.
Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.

Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 14d5b5e266f7..93bf2c40bfb9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -345,7 +345,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	 * GPU registers so we need to add 0x1a800 to the register value on A630
 	 * to get the right value from PM4.
 	 */
-	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
+	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
 		rbmemptr_stats(ring, index, alwayson_start));
 
 	/* Invalidate CCU depth and color */
@@ -386,7 +386,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
 		rbmemptr_stats(ring, index, cpcycles_end));
-	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
+	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
 		rbmemptr_stats(ring, index, alwayson_end));
 
 	/* Write the fence to the scratch register */
@@ -478,10 +478,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	if (adreno_is_a8xx(adreno_gpu)) {
 		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
-		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
+		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
 	} else {
 		rbbm_perfctr_cp0 = REG_A7XX_RBBM_PERFCTR_CP(0);
-		cp_always_on_counter = REG_A6XX_CP_ALWAYS_ON_COUNTER;
+		cp_always_on_counter = REG_A6XX_CP_ALWAYS_ON_CONTEXT;
 	}
 
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));

-- 
2.51.0

