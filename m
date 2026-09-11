Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6311BC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF4A10ED5E;
	Fri, 11 Sep 2026 15:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/fYRnm7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JsVbQDf+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC0810F082
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF8ilc170556
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a3b4UwBK4xHO58Q36xweSRGPLGI+zEDxQpaG3A4xvtg=; b=o/fYRnm7a8olrqzO
 vLo6+L0NqSocJR64l+gsZ0GQnTf5iHgirvyvUycTN611vwiKuzjkhVNSAkBurNwz
 t6d1xkkwWt6U8f00hSZC0Wy+lvbNE06IUUGHu/EBHjELHZvCOwA4kfMIB50VR2ti
 tFpqAc+WY7d6n0j9mkLr53xc+UwhfYGsBIgXBb37WD0mxCu3RqVgdBALezigHTHe
 c7uMw8f1WFQw25ye4yK3JKEyLqw1CV3kgS2602wUTl/4evFtNQ09Y494DBsfw8aR
 iovGI5fFFDKkTkqvuJpBmV2RV8vVPUMQhgJ/YlHBpXmshNmUxD12j7fpyHWEPes9
 hap4Yg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e847g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:59 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-455cf15f8b5so1714912fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141079; x=1789745879;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3b4UwBK4xHO58Q36xweSRGPLGI+zEDxQpaG3A4xvtg=;
 b=JsVbQDf+gBEYIF8GYf2ReJ65sblQ6eXglKwP2sXE77LBOdNIN61rm4DVesSXNrCAnI
 SdCVpFLva8aR4bleeAupAaVgfrd3BcTzNmJR0YY3E0k/+6Ni/bUa2pQlZWwkg95/RkV+
 f0eB8FUYOMtMkQw+9c0oPatKI8Jxa1glJI7oYtb/6NMJU8BP2nIXvZQbbdPhaBlGDG29
 p/IJ9Jf+DP8x4pxmoV5oULOFgdVP7cpnCavUGcp9DQzROxKCjoO+Y9LEDLqahZBwuvJ1
 mG/2JAV8NbfFftlekZ+65I+wtWCvObvT2ONECrL8tL/4DsPKLlTfDhFm5NF3qrdF7xz8
 c4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141079; x=1789745879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3b4UwBK4xHO58Q36xweSRGPLGI+zEDxQpaG3A4xvtg=;
 b=gBHcNjhAmm6Igi1kBYXx2GEL2NP0QFOqZSdM32XEz/8F6lUF6aaSgwgpWaTBHGm9SK
 r0mzXbd5XOEr5zKsp/Bx5j4N77c4WPUT2hHZlLRtgX2dZaw/EbfIo69tOYwzFy3bOf/b
 yv4wKjWGSHgTxsg2ExTTx4csr8SzFLONfAVUGjS4/Sct4rD325LB+LICV8r08eAILjHb
 fvomlbIsPgi0ceuzajhpLiB91yQNtCntEovpNXOzgU6+XhQqDS6nSChhutRwmTdXFk9H
 PcA/P2jKKJ6cVVfo7hiYtIDFycpXRWWii0advhBdqrlXdlNLV+cl7iy13u6uwEpJyzkt
 DNiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUIEvXp5FfbsybLnti3UCoK8RwxSCuvETaWFCk4GeQa1RW8fp3pz79oXJGLI8KYfNyCK4uCkoUUNk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7doMi6Sxn9QlnZK03gGQXeork4KYgW+QuerygA16bGL6egRkO
 EMtGA8gmAs/tg9JG7jR58Y3ZqnKK13Ae+bePLK48fmCYDASi1qdKH8NarHrFee7Lz4NmGhu6/PU
 ZC2jRgWH3nh+rfENTux0pnqVvJNLvGczm6YdS4q84IUYSXeKXTsA4sCWmaIhnb5weO5kFdGw=
X-Gm-Gg: AYBFou3hv7oOU4GOshVj3BDXp3SXPrvd5agK8bm+gHr15gVIFt1rqC1D8dNPvyljBc5
 8hCygGcu7X7ZEmCQO4ad4Wp6cc2/yD9/7g0tmg8LevTgZ8K1rKQvviNZYyDE7RdWv5T7F98XzN4
 zKwVbwDNCVkX3F5tXHrE7r6togO5LIDtxsADIwj82dCWJQQDdhNfqfIf3eYWdZ64872XVTO/djC
 xmvC/G+aVXNP4akPlO4/neLDWihX7PTJ83wnbEnzCtz9KtEBCpFtt/Rk07U/RnEsrZxJIfDVgvC
 UGxqeWrX/KeV4Ajp93HsR1FjF2mN2BWAOAzPi8MVr3c3HOfT3qQRHDbXhON0fNf9kNKtZ+JM12E
 7gNUZpe2ZcmriqORZt2tVMESlzgs=
X-Received: by 2002:a05:6870:9599:b0:456:4c6b:773a with SMTP id
 586e51a60fabf-47dd260022emr2776979fac.9.1789141079236; 
 Fri, 11 Sep 2026 08:37:59 -0700 (PDT)
X-Received: by 2002:a05:6870:9599:b0:456:4c6b:773a with SMTP id
 586e51a60fabf-47dd260022emr2776953fac.9.1789141078821; 
 Fri, 11 Sep 2026 08:37:58 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:58 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:37 +0530
Subject: [PATCH 06/17] drm/msm/dp: Add support for DP controllers on Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-6-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1636;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=ZQKmc91CyQsnRW9gYuzHEpGY83cu2vNY2czx81TJ+4E=;
 b=y/qsLOGWDhcRqZYEtbq8zdeWKASA4zme6WOoFsKiY9BMi4SXhW8VaksKMG85ynnflPfDBcRfB
 xH48FZ/7pmBCZN97tZLOl7NHAZFwiJExWbDi0uVkuGFAW0WqV/8X6DA
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX8qEKQYMPyasY
 9L9ZPYgqAb6Kmq7pPAKSb1EHyjqtyy1cEH9xYK5GJy6WWTQypxheaEWvoEChplCTOyMljGc6hPm
 BNWof8RVWsFxWLTQdV7jpsb8nPLiLVGm8orlna2AYGyFsCJCZl60Bf8cN/cOcnFiRtZTYes+ob9
 59uzPtmdcHSAdSFwN3Qrx3JAydpIdCB/MqlsoiPjKj6hcR5P41WvwKc/pXqZwOM0LZdYkEj1O3c
 MjwOEmeLou4US+NYrKgqBpi76SN/PDHZfSpH484txsRuPov4e1uQrG14azyoVdTv4PjU0BxIks+
 Lzv9xkb9LScx675hcTAfBrhU5AhLism9DI7EGJPAXEmNytExeKkw7t5TErkHAXHrgPnKzT7ccv6
 rIiT/gu0xcM9BIQtYKRhgnO2BMihKxr7sbD9sjEXJWsKZ3A4kyTYGXpZuq/bBZJcECrqZ7xdKVY
 fvxuaOcm5eMEsPum2YQ==
X-Proofpoint-ORIG-GUID: lo45OoCbIuw4xP2wwE-ceuYNamSfXh-K
X-Proofpoint-GUID: lo45OoCbIuw4xP2wwE-ceuYNamSfXh-K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4QeHc1bSq4bs
 S50VHhnqtVdnxkSFD/skBu48BJCvqqd/dgXXjn48CUpyKSaGm7AtDTb//bTH9O99wPM0L8XnVHI
 51I8EpIvlevVYl9PJaPE2RDPQRnS1W8=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa42057 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rrrw5iIUSJUMZ46_DcEA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110218
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the DP controller description and compatible for the Qualcomm Nord
SoC, which provides two independent DP controllers, both wide-bus
capable.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..7e23cb2829ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -103,6 +103,12 @@ static const struct msm_dp_desc msm_dp_desc_glymur[] = {
 	{}
 };
 
+static const struct msm_dp_desc msm_dp_desc_nord[] = {
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
 	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -161,6 +167,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 
 static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
+	{ .compatible = "qcom,nord-dp", .data = &msm_dp_desc_nord },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1

