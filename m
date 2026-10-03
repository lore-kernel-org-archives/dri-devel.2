Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E9ACA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B2010FA6E;
	Sat,  3 Oct 2026 00:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+ejAjoc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5YyITM0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFD610FA6E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Nejxo2502806
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WHO1R0BGEddeIvFPLIyMAV9UF/O1N3RpMgj2RHjLQ04=; b=Y+ejAjocicWrPsHy
 rdMq8xkt4a/8XiuBzZEv1alTpLzGw8gADqRj2L0O4VDPztWeG/pZXrpjRKxHq2SP
 0yPfF7Y50PTmpjSQ+Bv6VCmhI8//wbab4jJALMQryGMtX8BRsymhNTEu6j4z7UN8
 1Z6TcD3F32GsKPle+jkTeEyyCOGs2MImzGlxeLr8mWRN5N5j/lJR7Szw/AnNx/yQ
 HVMWVDZGShyABxQnoW5GNBaVj9seaLnTCkeHOXE9kSqno/a9fC/umJgdDaxFIAIG
 QIChBlT+MuDL1BAPZdpfZiRctFAKpyqQ8mngnMMv5gWgUNdqVeHnL6cVlKtlmbpd
 9mICNw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8ss1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso22683185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987437; x=1791592237;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WHO1R0BGEddeIvFPLIyMAV9UF/O1N3RpMgj2RHjLQ04=;
 b=L5YyITM0VAJgdDdFLX8gqGe1iLIhM0PqgRYpTCdTANN9fbKjouUljrXMdddO46Bf4t
 Crm3pVSpdlrolvn1ed5CA5z2x027/2FfNoizlegcpiSjM8cUGIGRU2dlf8HeHg+22oDR
 pHEypkMrJyzejjLmDPZ+EZ/C9TLXv8T0q6Xc9orw93EUa+NhRm9xMaSB7UGIxUjVrf5P
 xFtQsG8e1lSNSHbwDVoTZ1rRt3cRgqenSpjZDDtypu5Z19RxnHo9C6tzbQRFlNMgJIxR
 lms5Qs8XZ0uvq0t5RnRkEbArbMxF7C7zNJG0hSa8AdXmrWT66oVczGqckCtE6gh6Bfxv
 LuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987437; x=1791592237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WHO1R0BGEddeIvFPLIyMAV9UF/O1N3RpMgj2RHjLQ04=;
 b=VVfF3ky1yyNW5blbH6dDBuyUSyiOnWT1VEM1D8ysb7nHfSXBXeZlqD4QY2ZnaDATOV
 /3z3zhvsHfXEsx6zHZrixMfxgfn6d2arL7CVjEDSaDUD7StxLSyQyseuN1vcOJ+7qAAe
 wiuvEBw5XIQ0dh30h914pd9NBsFhSutC6qKVfvu/7we4JGZrpRHt0cWpZwFkQS5raItw
 w+zb8v30zBTDY+SOt4BOZjpvJDcVXCLDP8yGvN6er+YXJvBeoDHlr90ULye8fWiKlNhz
 WYz/BS5L+fjvpQ08Vo/yV0W39bPSavup4HNswkuy4/7pWBgfKhzrH3ws2CPEPeVerJqM
 Jjwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByiEbIktfMa9OcZG7npO8NgMqOzWnM7B81d+DQEn0GbnQqDpsqKNU21iH4BT0ZuC1P1KzkmeGI+oEs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/Yshjt/eYfSA81seiEdQNll5WO2HS77M+hkq3P/evCjn1/BS3
 PCLcOu6jkWZBIve1JmIaS5CyIWhKt6fwhScFW1ui3p1AS5yAaQyBqkEmUcDy7b8CXRHZtmtq5yc
 uQRk7Ud+g5NtXGsz8VWYm/tkcWvAF0IHYY/FQhjf2y/nFTOk8iJBf1t9xhhEfJaIb27e1h/c=
X-Gm-Gg: AYBFou1EoS93O6GobYretyuTgl+Xy3YQls2Pj3j0fQbOEv/I7SdYf2p1lkkFqDWGXlW
 SqBb6HGBm3KZG5KGMnPCeyUqqweW3Xra6Lo+Wprr5vq5ZC0KfDgT++g17SCWwkmiV/HSMMXEgAC
 y9bFhhlS1rvq85R3WbYyMmYAxP6o/X/IJsZ/MgSqo2FIpjn7Wke+ZrfnKqHQyx/IylKqErrZfZj
 GpLNlE8+54bqkxrXVB+oBj32Tf3EFTEyL5sFmdUKDKLjS4twFFjXHmEI0Hv8I2ZYzxi9VvSxt9+
 hOQschVpVz0Pj4qe7bOFdCJqZwcW1QLWJhHPZDWj2USKhB1TdaCnM4Skk0Z3DhxvwX2XLK9QYef
 65BkQVKPemxSFeYyChRmNT3/XajxbOuNAeZNPOTi0RjYqYEL+zC2G2s8n2YxJVKko4NKUH7/S99
 qszblqamW8XblY
X-Received: by 2002:a05:620a:172b:b0:93a:2e8:5afa with SMTP id
 af79cd13be357-93e50feb9ccmr210355585a.30.1790987436572; 
 Fri, 02 Oct 2026 17:30:36 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:93a:2e8:5afa with SMTP id
 af79cd13be357-93e50feb9ccmr210352785a.30.1790987436133; 
 Fri, 02 Oct 2026 17:30:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:20 +0300
Subject: [PATCH v4 05/10] drm/msm/dpu: clear the CWB blocks left by a
 previous reservation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-5-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7+lwU5rXGQZC4vRul2fWqdbsN1B1VCF9Ap1oW/StXpI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEye/r3W5tyhm7AAlUZKHkHPqB9uxUnur430b
 2CyoTie4ICJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1RRzB/47TJrjfGg1sBHCy1T3RHniccw8kMnCzrpeVi3Tw/bAp6/3+KwwAuXxcYMTE6aZG4X4Pcr
 Ff+QML+svqKaTqGb8caZstZDQoQOfNjtyKifmkh5MsMreuN2hyaUYZCc1x3pMdNujbld1v28LPI
 8fWz6GeReaiNxnWUT8IXAFZUHee1rDQ0C12lxk8s+jbYZN+WJCF1TX0ikwI70J4a8JDqvD4p6Kr
 lgBS4kWfbIK/RaSiPmEzxyX1/ZBrlWzpeYzDyANcpU69F9y0VS7vrWZBwOrrO4a5XZJVRfXk+Nj
 IFnfA0IYQPkQxrL/pdtVSJcE11aUvm6QDpFYks0ZPJ8Izfgj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: KNdT29csVimBIssPmXk_E2c5RK3SWLGq
X-Proofpoint-GUID: KNdT29csVimBIssPmXk_E2c5RK3SWLGq
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac04cad cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=00kiT5jbeo-7mEmJU9cA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX1NkUioVRvlcG
 HAuQU3nagydoGAAsqy6JPQkhfZ3zCuKikmxYNNkbiZcqzxGQnqy7eMa20d/4PtaaGQRt1QiULwk
 yYR5C4Lrlc7CK9x5Jnuv+i7bchGqcB4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX5rxvxRyD9a8M
 pEu4z6qwKbuUZR0tdmerneGWaMJxJgRQow6VnQZ8zygvoIzqxLUPTNfIyXVo0p3l+oUKAycTrmm
 wtxSszc0oSf6gD9mgUUAxhsuhssLfXrY9zQX+75dcCLNRrMEl6915frlqw/FzuWIFxISEOeA7D2
 qmXMFPRIWsxGOR/I1U4+SGQGi1ZNoISCfUVqyB0/iB2K2IPYZVHbCK/fefFUybGK0/Uw/PtWCfZ
 XiVxbWPm4jyITzPraqkhfjRBH0NJyIioXT6Bis6kceC6s2R61Y0xz1uiUs94GHrakPay7fezPGC
 3MlSjh66CEPo4KUmEfgpSudiB0VCQe1XFjOJoNXsuhCdl6/AvDqHo5r6qYFdAk9b9/nesrGRTag
 KGlwJrK4U/bKQi2rIKSk/kBzg3G8nzNccvjafpGuTChcP9TUy8QGlE9vbDKXdHiNvgYLyQhQXyY
 D+lcKJBSJOkzxYSHsyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
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

dpu_encoder_virt_atomic_mode_set() only writes the first num_cwb entries
of dpu_enc->hw_cwb[], and not at all when the encoder is not the
writeback of a clone, so a modeset which drops the clone, or reserves
fewer CWB blocks, keeps the pointers from the previous reservation.
dpu_encoder_helper_phys_setup_cwb() then walks every non-NULL entry: it
programs a CWB mux the crtc no longer owns, and looks its pingpong up past
the pingpongs actually assigned, in the uninitialised part of rt_pp_list[].

Store NULL for the entries which have no CWB block, as is done for the
pingpongs.

Fixes: 5008375443ed ("drm/msm/dpu: Reserve resources for CWB")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..f06b52579740 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1205,9 +1205,10 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 						       ARRAY_SIZE(hw_pp));
 	}
 
-	for (i = 0; i < num_cwb; i++) {
-		dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
-		cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
+	for (i = 0; i < MAX_CWB_PER_ENC; i++) {
+		dpu_enc->hw_cwb[i] = i < num_cwb ? to_dpu_hw_cwb(hw_cwb[i]) : NULL;
+		if (dpu_enc->hw_cwb[i])
+			cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
 	}
 
 	dpu_enc->cwb_mask = cwb_mask;

-- 
2.47.3

