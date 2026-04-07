Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEBFFB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 03:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878EA10E31F;
	Tue,  7 Apr 2026 03:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEt+DKcT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aE4r+Add";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB96010E31F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:23:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQKq63537311
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 03:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OK++8WcMbyqDqJRvkHrdUK
 BaMe3ofWql14darhFggQc=; b=GEt+DKcT9JCXfCu/QMCnfTshCZUlcvracIlddE
 YmMp0mMp1Jib900PZZAra22KI9yi8izg5L0W3vvl3LsCH9BT8zNdsHrgIetQsS7M
 ErCritSK7faQwtTiYO7WkNutc+o14spbUTPDi+PaLKWjcf59llozU/ONrHYKVeTY
 002W4lpM49b22qbJ+uAoTC8Ax1DB5PGYxieZxXNjQPRAEvTg13ct9mODSCdr236U
 m8MpA6m/nUqB+OXm0qGGOy78f963MlkOD+x8gmT6cSUPBN/aSqN8tAI4x21aVl+d
 vwGJm1/+JkXgPBKvV5nAkD4gO8dg64mwUaCnIIoKOaj/fY8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra0tsd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:23:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4987c698so127255441cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775532237; x=1776137037;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OK++8WcMbyqDqJRvkHrdUKBaMe3ofWql14darhFggQc=;
 b=aE4r+AddJCDIiV0FNR4ePjdlupoeouEVPaRErY7exuyCH6/m4S1pllH8SCAW7ZyHsY
 KUAw7g2CHSatRBxNOCldiP+nQaus5AfKriDhPC5TSvWZ1a5mYhV67meQXSvqtz4nnHQh
 m4LeHWjY1Tx8LSBD55TBLRSI6kRoIpP/6FHQ69NpVPCXtq/RxeU1nji7yCSADln9Nmdb
 Adr9p45wjTxpKJLVNlIkb+RHk5LLn/GGE2JUvWwViSAu9SSinonQlM7gtcKSMUEMcxlb
 hAACClA2GPvd7tjbOfRd9/brOZSjKILnMeE5ZKnJLKJHZXrYMlcdIy/+GXTptkl2wWRq
 NTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775532237; x=1776137037;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK++8WcMbyqDqJRvkHrdUKBaMe3ofWql14darhFggQc=;
 b=WcMPqPdTOtohVvcS9cqCrZvAeJ7aXyuxsMTQHZHeivOjr8dklrRDVIaw9kIg/FS0zs
 qnpl+6sotl96fEzYgbPCudWsY5Jxymz/IjdRor4zQsYazLM+pIqwYhrXuz3GZ7xIk0na
 Lvfw2lDWPFINRl5JnDnqOdxRE2SLqlIM8d1V20T6zp/9mUYEJHiyo+R82IhtHrdl5sl+
 XNPAQ8hLOSii6uy5+jjTJY6WxeIegXxHfOBo+KRMblsJObSEiZS4cepoqCFQiR2sFeXo
 A1BSJUqvhml0hSjXQH8Vv73nL49WferQeEJ67yPkWLfkRxXGOiOnM9R9QEZ/s8bSp3Bq
 Vlzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgMaiCCeB2Hd6jcynClouycd7IPubhLHYcy1zf9vQwkwVIJNhuAfEMbzoSU6tl08k7rhd3SmHHE5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQ6olGen4Oef2NGa8v8jAIXX8JLsHVuP2bazQrxd8ewe6zJRKC
 1gGBsXcVgx6RHnvOS7KrAYPlRCWSR8RQOwqls5jyAM8e44rWu68HGd+8mWLXkWWKQxIPccsnYTn
 bV6o7MJCLI2oJ9eO1DQeOL1KtV225ZyCesgr8hBnozypwt7JnzNfzC4DA+uLW6BUsKMBtTKY=
X-Gm-Gg: AeBDies8uOzeXMhBjZokvBo1YKvINMoCCNMGcvxNgGcq31eTL8G6fdicdewtjeo/uKD
 8cjpkxVLKkmC77/KvDzBvNxpQ+BaFNu5csaDGjxukikWRpNoIElRvxNG8zt8iGjyuILbM7upuyL
 H6DWn3DmPgqmsm6qDXDHdi6NaMWXaM7pdDVv3PTCbncnBwlDVKy8tzuCZj0BMqnbkZqyLPCSBQt
 gfM58iXHGdMAVZIbEdH3y/M1Z3AH0zpCxod74UlDFbwttrogweKzMTBHU0UkSNKPLTS8pzI9sVy
 d8t3wby4FAHYoIMMIEwuGyhNH/DTrRBUcfeI8Oh3o7n2AUhpTBlINjjoGbpoH5nVz7TnteouOMP
 7ItwbZo8BDL19nTZR/wSDK6RuKiPbtOk+15DTZ3bU3MkYDaLPbbJUo1DEZ3702VdfsQu540VwMT
 2dn99AlZPs2tUxk3zwUcEsfhgoTdlmvyvivU0=
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id
 d75a77b69052e-50d4fd24b4dmr235753081cf.38.1775532237198; 
 Mon, 06 Apr 2026 20:23:57 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id
 d75a77b69052e-50d4fd24b4dmr235752751cf.38.1775532236732; 
 Mon, 06 Apr 2026 20:23:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fff886sm30768591fa.17.2026.04.06.20.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:23:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 06:23:51 +0300
Subject: [PATCH v2] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-adreno-fix-ubwc-v2-1-7ff73624635e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMZ41GkC/3WNyw6CMBBFf4XM2iFtw0Nd+R+GRVtGqRGqHUAN6
 b9bcO1mkpN775kFmIIjhmO2QKDZsfNDArXLwHZ6uBK6NjEooSpRiBp1G2jweHFvnMzLYqVVWRW
 1FKQkpNUjUMo247n5MU/mRnZcNWujczz68NleznLt/bfPEiUao4w4FKUw+/rkmfPnpO/W932eD
 jQxxi9KCbVzxwAAAA==
X-Change-ID: 20260407-adreno-fix-ubwc-6a2564710e21
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=worjPPj4ESVBaBV4MNEMASe3hAq2NdQk3yUJ68sqnTA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp1HjIDXCRr5zKUdKi2UpZ12hKraipBs3O9o8Gu
 yc7oN+r8DWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadR4yAAKCRCLPIo+Aiko
 1YQSCACIV5VUw/gWw2R562oWys03qBIMJyr2ym4v+Pg3fUrsAiIRATT3pSktxFBBM3n7DId+G0b
 83Fw2IdKcmLE83kLL2KEtqKH6t0L2sjk6/yc1mL9VwKH/uJXQLECUvhz2TWm0vpDv98lQ5P/PZW
 6RWB5uJywzfg7edo9NtTUCfQQ5RNu+8Zi62Dnc453Rt2eVbGt9kQRxNb1lpUTs8tlR6ZviCEoIc
 RWEz9u75r4D7r6DrtRRMsdyJZIwUqDWSP6D3GrYSj388eeOMJPvAMCxzn6yP+GN4G226xW1RSSO
 Nq4Jyzyia2TWyIqONt8Ua9d++lAcUkGXQ6Tpu8e0XR94LAXc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: I-ayWcHyTAkGV_5aPnoYTwmf0CbAw_Ru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyOSBTYWx0ZWRfX7yggKiKkwNdW
 0qfnjVrOOFmFRPSHf0uxMOqaCUEw74FDlvNxk2BkMdoJjQuq9qRIUvsh+lFkjYUbW943JnyplZX
 NMydsILOxOYlNarCbTb+KRw1t5L9sSLWBcAHz2SYuPvcRR4oTqBQLqFcIrpiLAzyEDMOT0MqDzy
 2e01kDPp8j/0OW0h4t70Yy2syXBdjUMSQBHsFiommqABCuF3BMKAMuDbqd2qb+4bqwzcpeds5zA
 qiFiT8ZDcgMTSy6f8x4CQcKpnXT3ahRkuHwQJjHLlBagqggExEr6Q68vJ7Gax2aJBlh4T+G7YGv
 g8aGEPnZwfEd+D1dRx9GnfouHTLCu2rDpJeuX5sGa16JZ4e9YRWMlbAJoiAibCmYUPjhQ87z7qq
 3aF7APhkjtIzJR2NdiH9DP5Uz+F9xWrND5idk4LAUpN5k25Lw6KU4hJnfNd7fIsUs2MdPJf6scO
 20WWdmTxorTy6D9IFAA==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d478ce cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=5ICTkH4HVDsf0thFk5wA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: I-ayWcHyTAkGV_5aPnoYTwmf0CbAw_Ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070029
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

Before a5xx Adreno driver will not try fetching UBWC params (because
those generations didn't support UBWC anyway), however it's still
possible to query UBWC-related params from the userspace, triggering
possible NULL pointer dereference. Check for UBWC config in
adreno_get_param() and return sane defaults if there is none.

Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Changed adreno_get_param() return -ENOENT for affected params (Rob)
- Link to v1: https://patch.msgid.link/20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5fe6f6f0dec..34e4ab43b0f6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -426,15 +426,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = vm->mm_range;
 		return 0;
 	case MSM_PARAM_HIGHEST_BANK_BIT:
+		if (!adreno_gpu->ubwc_config)
+			return -ENOENT;
 		*value = adreno_gpu->ubwc_config->highest_bank_bit;
 		return 0;
 	case MSM_PARAM_RAYTRACING:
 		*value = adreno_gpu->has_ray_tracing;
 		return 0;
 	case MSM_PARAM_UBWC_SWIZZLE:
+		if (!adreno_gpu->ubwc_config)
+			return -ENOENT;
 		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
+		if (!adreno_gpu->ubwc_config)
+			return -ENOENT;
 		*value = adreno_gpu->ubwc_config->macrotile_mode;
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:

---
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260407-adreno-fix-ubwc-6a2564710e21

Best regards,
--  
With best wishes
Dmitry

