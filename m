Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB7FCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D83510E6F1;
	Sat,  3 Oct 2026 00:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kyus3qMF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VN//EdI8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74CB10FA54
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne05N3883843
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=; b=Kyus3qMFcahMVSeX
 KqW6ZsFtVlBqDpuOoTY/IgeqI8L9K+TCqFMM3ecWRbWa7IJK8rYIH0TGBcUumyDT
 hc6n9lSbJ3Hq0lWu6oMLHCHOW+BuuJKtwBh3Q5NAn9MkPjTcwWQNTsB17KLY+cev
 uPNgZB8T8Yp5+ckfnOKXcWY5frChp58NRwOgbf8VltrCrvchKunPlasgDNoX6L+8
 /X6kuIF9DSlchH7Sluz4rQnne5BTOHzxtC4ydftbnrX9BbBPyyImBPWlg3815KmR
 LT48NTRPwofrF9gHnIV6g18lf1wzoYxYKOc5rraxqMbstTgM9f2CDHrV5VDBPOgw
 fsJ/fQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40k5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso411065885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987246; x=1791592046;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=VN//EdI8FiUI6fZsiRspNa5NvzV+OBiNXVNz6i5c34QheMhNa/PJjni167DyFl7S3v
 LS45+FqSFtiMbHJ5vkM/T3SrtCm486+PyWkiE+kCixz8RGY/wq5yXws53lnHZVDyKXD5
 mq6WQTAhl0XW+NJ9I461Yqibxq0MgJQG4deQN8u16rj3STrQQ3FUB13P6VENlRUMQU04
 vWF2NV1VtGLD0L8aK+g+S56ITw0fwVWiEzkOQiBuhlfo7rFWixYEZRrppgmNqQaX4/WQ
 C4YGsyAJlCMxn25u9PQDt2G466bUkwF7uVvWelAoXJdCXCbEzqmYPwVdKxBtkWREVOhb
 QN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987246; x=1791592046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=IuD4HmZKJOaUk0hWX8texTCrcHY89d5NNY0e46AkseCuIhTFAJK35cp0C9oUffHixJ
 oidBk4KEH5EGrrtItsVozuaARBRHFFNo2U75wAlaLVJP/AixFYi9ijeD/Ll8q5dqGN3I
 SglDIC7/HLmgfXLq9GrtBMfrUThzw5Xjfa6nFpa3J/H/dPuJg5xHmKpsEZ2pH/m6q4Jc
 Mr9/WX+Z7N5XGfdxwo9hTMPg6ODeKuwEJowG51a3tE8fi4A4GdkBExyg1n9UNMnRL6pk
 nb3AQE8Ts59BSbFGqUagvsw2gpvWPouiV3DUOS2bcKYiXTRYzfmNQprokSyu5WPl94ZJ
 xdyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxscND/gnQVCT1afqiacFc6V8p8f14EAKWtsQmM4cZeCDY1cIPVsA2rVAtOHQuCI5EQz3ZX7Wsr/Tw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvRXD7oXH5FHzfCVod+0cp8L21C73Anl7gNagRAG+oKsK4gipJ
 pr1UQ7+06rNnSXNyNPj9e07DNgQXthcSTBUxBIlTU58aFmKsUarUrvFvV8+64CYnfl2V2EdgAkw
 zYWelluhHqMT5SreBCO+4Ht38pQGhX53RBL6w4MZDd2BroaatyeyN1Cqg1wViYMzyMcGmgKg=
X-Gm-Gg: AYBFou2QOf2+8oK600JGx9pDaQh2xp54jU2ihN8weXCkdwR8Ul3X2CUT/ijhB3oi0Pi
 0zBd1xBMRc6w50W1B/FTXSQ4uSPpzCj/c65W8O37G5DgKPIenRYykTLh9anV7SIKpMdXDFuUDNk
 6NyTaPGqRbFfH8Mq3QtZ+QYf5qwk0milAsZlcZlaEx4Kg/EskF4Il0UyRbOpcaWQn4nrJF+uQ7i
 E6+quQLkUSHkNRPKHEQsq4oL9XCgATBOj47PZ7hc+v0sy6akZRdKnnAzjz+KsO7bZ7H118OhM6l
 TWFCSAKH0PnzOmBqz5UsSY41JtLsrKLp4vu21vbTs9curqR1tlJJUU6zIpGsAptChyiGk58qTCb
 4Bq0YiSgjXVeOs7Xr9YAOd0e3eITJ1yLZPU9O3r8iJN17FcLLfNSb9neYUSS5VmQF11x133MDPz
 D/HvefcVFLrOgG
X-Received: by 2002:a05:620a:608a:b0:93e:5677:317b with SMTP id
 af79cd13be357-93e567733bcmr15682985a.25.1790987246134; 
 Fri, 02 Oct 2026 17:27:26 -0700 (PDT)
X-Received: by 2002:a05:620a:608a:b0:93e:5677:317b with SMTP id
 af79cd13be357-93e567733bcmr15679485a.25.1790987245608; 
 Fri, 02 Oct 2026 17:27:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:15 +0300
Subject: [PATCH 07/11] drm/msm/dpu: don't tear down a failed hw_init twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-7-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2tPDXcEAQdfx+uOZ+i3gT4JR+STW+/Lz2xQF5BcD1Wc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvgSdkNKxXHXbSoa/NL1JPr49rBP8XNZ9FD4
 25UqCiD/UaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL4AAKCRCLPIo+Aiko
 1camB/4zQUisPg+F5H1bh8WYaQluZmeN4KhaKE8VbAkauyTNg73e5C1D6l4JHp8eGElqBuOX/uz
 mdCHSy0Y1EcmXD+rB5DQGKez4noUSsHuVzQXCeRhSLWvcP/c3WrFHDxsLBubOYnRu3dwEm53hj0
 bxp1KT7QPs0K8K9lJQXY5cyX9vFA3brKCqxM40QGbX0kNyYjnHqfW66lyss4l3R7WSj6oqPJYZa
 30Ky9LVvfNbIwqXH/OXdGt7AGktN+5kmuQ/0an0PjLEPvhhP5RFdRArx7x3WLo1ZFYcSA61hYyS
 FPqLzAHdLFi8VLc4S+10NV+3mZfa0gnxvR6rcKroOKdTJahf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VuwbfrIzBJgoMi6EY_8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: s5Urmonazshcpn9rQRQnKrq9D9jLUZuk
X-Proofpoint-ORIG-GUID: s5Urmonazshcpn9rQRQnKrq9D9jLUZuk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX+n42EqPCnR3r
 ZpTDy7LEYBcmjjFxdxeuHLzZt9rOZUsZT85iEI+n33MByPkYwiGUKUeQ5+akbLhh/RFf2JK8yCn
 MXc+218X/MihsBKDVdRtFQUfvbAyp0s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX+O7ggN/xOgPh
 O4etRyL5HKwsCrp+CzFksZKExnRG+S0h+y2L8+tmI0E0OcBdmss4YsMryJDESpqFXUQR7VEFoR9
 +VCsrTEcX3DfHNjVVOQYd6wKdH42wm3Zp2bICGn+/Ua61iITEw/wHT6lat4FN75GvUzDWds3FpK
 dHBJPjIB43VRHRILhc0Am/aLNB7N7wqBx8kaMxIi1v3xqZb8CC7i92rMAibSo1VNt/28UP7nzKV
 bE5YFpAoU+As+DUaDB43FQJPEL31EnwAQ9RigrUKBNjgeTLU5AKov9bbAoASGwCcaQWH8QC9Ns+
 xxLC6hDWol9YFWNjD8yXzpnpniu1/YUKUl1bxWGxHEql5iYMCj7f/HHyU4NCBdn5uelsSxhKSET
 MQQGFcMfVNy91N8hBvIr4K/3yq7bPMrhNUGEaLIm1LbNWvF7UHsccGMidXEWMj+RaM8X96PwtIj
 6JPjAzAs6mmTTRAcMaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy() itself, and
the caller then runs the ->destroy() callback, which calls
_dpu_kms_hw_destroy() a second time. Since the global state object is
finalised there, the second call deletes its list entry again and frees
its state twice.

Fold the hardware setup into dpu_kms_init(), undo the steps of
dpu_kms_init() when it fails, and tell the caller not to run ->destroy()
after a failed init.

Fixes: 49e27d3c9cd6 ("drm/msm/dpu: finalise global state object")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..255beb83fc94 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -55,7 +55,6 @@
 bool dpu_use_virtual_planes = true;
 module_param(dpu_use_virtual_planes, bool, 0);
 
-static int dpu_kms_hw_init(struct msm_kms *kms);
 static void _dpu_kms_mmu_destroy(struct dpu_kms *dpu_kms);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1067,7 +1066,6 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 }
 
 static const struct msm_kms_funcs kms_funcs = {
-	.hw_init         = dpu_kms_hw_init,
 	.irq_preinstall  = dpu_core_irq_preinstall,
 	.irq_postinstall = dpu_irq_postinstall,
 	.irq_uninstall   = dpu_core_irq_uninstall,
@@ -1135,21 +1133,12 @@ unsigned long dpu_kms_get_clk_rate(struct dpu_kms *dpu_kms, char *clock_name)
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-static int dpu_kms_hw_init(struct msm_kms *kms)
+static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 {
-	struct dpu_kms *dpu_kms;
-	struct drm_device *dev;
-	int rc = -EINVAL;
+	struct drm_device *dev = dpu_kms->dev;
 	unsigned long max_core_clk_rate;
 	u32 core_rev;
-
-	if (!kms) {
-		DPU_ERROR("invalid kms\n");
-		return rc;
-	}
-
-	dpu_kms = to_dpu_kms(kms);
-	dev = dpu_kms->dev;
+	int rc;
 
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
@@ -1301,6 +1290,8 @@ static int dpu_kms_init(struct drm_device *ddev)
 	int ret = 0;
 	unsigned long max_freq = ULONG_MAX;
 
+	dpu_kms->base.init_unwinds = true;
+
 	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
 	if (!IS_ERR(opp))
 		dev_pm_opp_put(opp);
@@ -1317,7 +1308,17 @@ static int dpu_kms_init(struct drm_device *ddev)
 	pm_runtime_enable(&pdev->dev);
 	dpu_kms->rpm_enabled = true;
 
+	ret = dpu_kms_hw_init(dpu_kms);
+	if (ret)
+		goto err_disable_rpm;
+
 	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+	msm_kms_destroy(&dpu_kms->base);
+
+	return ret;
 }
 
 static int dpu_kms_mmap_mdp5(struct dpu_kms *dpu_kms)

-- 
2.47.3

