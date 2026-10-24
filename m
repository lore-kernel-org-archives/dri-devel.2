Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C242606A323
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jK3gg1sf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2Rtdmhr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCFF10E14F;
	Sat, 24 Oct 2026 10:31:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D2810E14F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8nxVF1165499
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ecgpGIqf6FUlCAfUyGUDHXzcM3+nvbVKBJYxSLRhqgI=; b=jK3gg1sf09lSDDAD
 QOiyM+RCjrZF/qXHPMpk+XgYPvB4+MHz6Bd8qKbfqyjA3ltEcVkQloIrY1n/hgPP
 iQfrGD0O0wZXmcIX9+UaMjVyxJpqtC4B32j7HOkm47TFgvl/1o7u+Q8efC7EFK7R
 4z5oXZKyBI3cpxc8Sspfp2hUp/doDtjsvMRuXbyRgQbEKYYJjPwz51kwqlPllf66
 ZP6E9+VubLZiWp42sz5R965tpL3EaSZR2Y5LyxwDF87J2IcWquFA32kmHgwnMZHu
 5mS7VQt5SD/6GvS6OL3VQoTPbkG4Ry5ZDtFTZ0FLovGmCK/gaNwKGP7XMFfTlS0B
 AZCgVw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gqej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso3009468c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837870; x=1793442670;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ecgpGIqf6FUlCAfUyGUDHXzcM3+nvbVKBJYxSLRhqgI=;
 b=B2RtdmhrnOFcEUnPEVo2hkyYRE5SHm1tr5A5mLc6IhobDC4XEfPc86GMlI5xyRECfZ
 sL9Rg6GEpKSkB4sQXkj+Bttdl40MmqgsjFLuJmB3UyaCnBSYUenC32yzIs0wwe1yzlb4
 2R4lZONCdsU0r6Ubt/vMHOiKdvVr2bwb7+oEOh0U1lv/tcoXFJbg+BY7KT5cVO7mTQZS
 /8mWmKQbW0nU1ldwvonT9F3yjkHaezossHqZZ6PmdlCwhRTWKx8h67SteLAnsmxcFuwD
 hhHyvuX9DeIIO0pHEbF5U/nKgIT9awSLYCPcVfz9eeIuM94ijSEP79dmtNGMSBRrkAoY
 2QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837870; x=1793442670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ecgpGIqf6FUlCAfUyGUDHXzcM3+nvbVKBJYxSLRhqgI=;
 b=TGP8JfuOK+m+x8oVoH6uMMgIy4a+667i59y9PgsMNqJqqlQpKpjVsN8EfrJEO1KIZJ
 64Jgk72WHAS058lxmGo/lMlFUjQEtUmx36FurtHNCPDG649pyuipYPVOd/IJGh5G7LwS
 UbmCENuZAcDbv3xTuTLeJeIEUGStysdBX6IcecbF2Fj49bg91XBzuhNb+PZa5vBrxnSX
 4xB0kUdrxXvuMGYOWSUip0ohcdfqMOqzNXiJHp8NW//eRF7VEmLfQ1ae7Y7DNMwgd5ZV
 U4scmZ9+yNWCpiCOS/MppBDvH1EtICmFf1sAIZJDmOLIYHKDB9oqcQCoJSy/bGYz3QVo
 BIEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWyX6EWIT/C/Pel0Rtxrlfomv0aZmKSUZKwS91spGW0/KkYxfPEuWniGIX55so6m1+xCM2yId0uig=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLfTDTvaIxznNcxziVueHIF2gw8cDoQCFCgm44CEZkM7J9C6dWq
 ERqUiDyCCDZyCMUxnf9reANepy4HSd4LP0V27LyMbsvmdQMwtDTVZ1x1BHAT2yOk2E6XEDfyfob
 mUFhwXpVRoNuCSJoHoPVKrst7EeMQo7WDILgy4DTwSuPq4i+EzM0Gz9/wKr+8pOyDcewGQxM=
X-Gm-Gg: AYBFou2ddsoxPyLpNWpn7+FspbP2ZJ09QrlhvTpRf9uuGxBDmOaAZ3PE9qR1f/NJD2F
 3Sr5fgCnQLjweIMIKvdD9x3grLeufgvWHyaI1Grzv/Vm31foeQLOW43NA+zYpd8dD0CWtMZMmL3
 d7xEdJ09Q670iRdMMQ/BQGmrVXA/gedBM0/Bb+/wTXsP7vS4iBZNrkn7WJ89V5obIy7kTvuwdLi
 wVJVigBUWh57hItVE9bSPOO+X5YJQX35Z5xQfbdgeSEZoungDqPJYLuN8ZQz6C00k1SONww7Qz7
 NeEgG+PNfQ92m0CzaQ2919/xAfBA2Q/rGARrA6efAobk8+Xl2YKWew4v5IX7xZJEYZQ18U3nmcw
 WxQnm8ox5ssWp+XutCcSts7c=
X-Received: by 2002:a05:7022:e803:b0:16e:4723:5f86 with SMTP id
 a92af1059eb24-19936a60764mr2616131c88.29.1792837869832; 
 Sat, 24 Oct 2026 03:31:09 -0700 (PDT)
X-Received: by 2002:a05:7022:e803:b0:16e:4723:5f86 with SMTP id
 a92af1059eb24-19936a60764mr2616102c88.29.1792837869307; 
 Sat, 24 Oct 2026 03:31:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:31:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:13 +0530
Subject: [PATCH 7/8] drm/msm/a6xx: Request CLX enable from secure world
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-7-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1301;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=f62WUqPk8JPeePU+Bm0XkICywuM1HT6Ax9xW96mzE4s=;
 b=WscAtm2o3l9CuzM+yZyAhNMO4ROOr682SdqdY3B1OcYV8NsoR7qljmwjsKmFf4kVDrTUY7a01
 LA5ob8zUl7YBrSjAk9PR2k85RLWiddD/HL3Vmz1um9xkdx7xUQEMeTl
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 07DPJUeZGJNVkWrkfJ2fAMKNnvhWiHlz
X-Proofpoint-ORIG-GUID: 07DPJUeZGJNVkWrkfJ2fAMKNnvhWiHlz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX2hF4SlU9ofcL
 mIsdExiKSl+4axlWURE8WIy0b2c5lMXMyw9uhYDBpMp9968YYH7hh0lsdPybxtSAvxUrCvKvhmq
 671+SKF8PLgaNqwI7m6EkP0U4LoaDLo=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc88ee cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=p4fv3_zKGVfQUpdSR-gA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX+tUxVI7NGPNJ
 O+OkEZjxKJnk6j1o3L47p+2yHYLl/Cy8+qDNrO9rizuzg2GwWaWfSpZXTVqh4u80fsFarAIxbmT
 UAtao+jtT74xb2HqDD6hj6YM2iDAHTQxEKX7Zt/DjU3mBxhxaPVVn5J0JLpCxpIdkeN7KKycMZP
 6Gk8ZqVVXoJEPZJ0q2bVLljwHB+UBjTay9QlYG4F4h45+N0e90Nob664dEfijc4e6WNaTyVzITw
 DEmVopD3Qj5anoZBBlRLLTqJ4v/RxYKsf6mv5WhtGdNrQwUaz+JNrk4yG4MIpY3MTBb9wjQrGPG
 PFbCzVaRn7SGQcOJqN2C7ray2tBw4lb+7jWFFLTLobGCkg/FALiL7qyVGxLuweUciA3HGAg1VK6
 pYKmggJO0pvUMXxnlHe+CEvSFMwcCRfKzVBSzzqgnP8XP5Gencx9TYo10rkqsodVRQ1j5eLt1gi
 VJM3TDXM5RgvKC+SgVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CLX (Current Limit Extension) feature also requires the secure
world to enable it via the GPU init regs SCM call. Without the
QCOM_SCM_GPU_CLX_EN_REQ flag, the CLX tables sent to the GMU over HFI
are not effective.

Set QCOM_SCM_GPU_CLX_EN_REQ in the SCM request on GPUs that have a CLX
table in their catalog entry.

Fixes: 967e62fbeecc ("drm/msm/a6xx: Add HFI support for CLX feature")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 991db3c9cd96..a1561ca41a5b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1247,8 +1247,12 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
 			goto done;
 		}
 
-		ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
-					     QCOM_SCM_GPU_TSENSE_EN_REQ);
+		u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ | QCOM_SCM_GPU_TSENSE_EN_REQ;
+
+		if (adreno_gpu->info->a6xx->clx_tbl)
+			gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
+
+		ret = qcom_scm_gpu_init_regs(gpu_req);
 		if (ret) {
 			dev_warn_once(gpu->dev->dev,
 				"SCM call failed\n");

-- 
2.55.0

