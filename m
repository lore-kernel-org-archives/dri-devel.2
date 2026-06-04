Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B498DCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1199410E03D;
	Thu,  4 Jun 2026 20:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFkww4E7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PgF/J7SW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E45010E0E2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:12 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654IQBJO2667053
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mWmDJM0N9mm3A02aZeVYmXR6PbCLJg/3M0xQs4mdPe4=; b=BFkww4E76r5J+nhc
 RJFp1m4kVxLhSh6s+3PZc4TP7yxQng50Gc20pAM17T/QZYJEc+26nQYuImhwgI6u
 Wv+dz3JpjJfpasuf6kyEpSpAi+LeVoUIIN7G7/EblkUOewrWJbmKM7U2o9hR0fFX
 1jhGWg1OPQY64dLohg5nASQsy1G3MvbjceED7QqAsd3uzzJ34U+q+y7n5ry7a1WM
 Wzc1T8+fEwsulNdqvqzgZiwhqWY7sMFJMNWBo7cFcveKYnRAuwjhrLqI2cr0HcBK
 uzX/A0c/Yfn1kWuiQfb2Zh52hAKBGU4hd91yIBDZrdrYLMROUlpij+ep+/+jHUF6
 Jmxh0w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekemyrdbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8422f987f2eso1809611b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603811; x=1781208611;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mWmDJM0N9mm3A02aZeVYmXR6PbCLJg/3M0xQs4mdPe4=;
 b=PgF/J7SWSo69rRnUemkBF5R5dy6SZSeBCITbYFPgp2qwB/U13fJDGmSzj8yvWd2pEM
 0qwYBvn7BkYp0fxfQ1S6Z3L9Ziki3twcag3Os0NsiD6CzbQfkEUrqaHZS8hrEP0XUM0D
 UG2w+IY2UcH+W+8XxPTNtobOM1TjcB5ufkyNNzo7FTAyZr+/oTpX4BvgymA0GGIpoP2Z
 0sjs2Dmw99wXvQ60fs0Sg/DL9BvCaTE5FhKJamQ8Rheh7mYSNE1NsA9gck3hdLsxT9V0
 5ji/KR0bBAMnadlvObzbBinh3Wz+qA6vRDBtP4WrVuePDto4OrGHpVjZqDHHfUPoAK+H
 f9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603811; x=1781208611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mWmDJM0N9mm3A02aZeVYmXR6PbCLJg/3M0xQs4mdPe4=;
 b=oJ6HIWkq1xaQ6x1iL63ZgiDmsxveLuf9v/5uE44pPEb/WlwawPmmn5Jh5bdxvUmTo5
 Mac3YJ7xlgcnRkrEJxl9QPg7BPfncXQXne1qwpgKyH+9ldRAm4ehP1c6N1OLZ1PgOJrx
 5QG4R7yE0ULaXCJPj0p9KoW2pdWU3dPM3da2d8NL81HFKwBLkAujqZh39oIpCiFSspdk
 aljkOn6ZxMEwrpjJ42gXFunn4PocHzjYpPZMaN8/cwQoJwYDued6G+M8VzsKjXLomSi3
 F0WCXVNgYjLKz1pJ6GytUUuTdhRBvFI9fUw6COvQxDAFtM1LaPnYF/v0j4HBcXSh6Jw0
 QQ+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xm3Ql63amxZbdkn9zB/6M4AVYwyUL3NTb0JspDss46smy+7ooyu2SQMknua4g+aaXCTQLRKGzZRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVuJTeGZj8uZN4wxid+4myN0V5fx2Hg68RW/mwFCki9bEj7NTH
 DBkj4qhtuM822+fvFM9tCe96/HJ/amaGxQev7lZ7cJelbHs1eQvhNluqpHAF+uCLNWKL7xDD0nF
 03Ul07VjS3SyKVeQ3fdfvvQdm0sMTYjyOGNt+iKXBt7AVYcXOMRGH0VvX+O2nQ3HoNz89ymg=
X-Gm-Gg: Acq92OE0h0tOFLOOr21lpFoDTs0gTab91A6qYYXWzs1B0GBl7mIfRHJoOuL6iXzrhlw
 KKwoD/dAt2Mz+TcJ3zMSs24vso5agUQIVWpjLKgbGZ/7dfj+oPuKNdhHIa7Y8DOoya/0/qwlo+6
 Dk6szd/9pq7U0mqmUmbE3KgVWEFWBYRGgoS/31jD+VZvy1pIQuO500jXecrLgmEi4MkkR+KNa7p
 j8Z3g0g5bofUXGHRD3kz2VyGFCykqQZ41uxajUMRIK5Fpjl3Pg9PTuW1FZURrqVHwnDge6+ytya
 bpxy6DBuYqEUzFUrfhvCF439f5rsOyEv8vO+hudGOVyTXMChSRO4fwvjniWDxKi7e6ZtWs0iajx
 87UElAUi8hLkljem4DJUs0wQl+g9P4hPHEMwQofzyMwByeXs8asMaO+RG
X-Received: by 2002:a05:6a00:2449:b0:842:38d2:a358 with SMTP id
 d2e1a72fcca58-842b0e3c6c8mr236270b3a.26.1780603810762; 
 Thu, 04 Jun 2026 13:10:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:2449:b0:842:38d2:a358 with SMTP id
 d2e1a72fcca58-842b0e3c6c8mr236248b3a.26.1780603810290; 
 Thu, 04 Jun 2026 13:10:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:10 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:17 +0530
Subject: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=1319;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vnWI9LofjIKiQz+B1zHq69+BxcnVku90YJ6k3gZAcg4=;
 b=mWPf5hC9/oifI5qgbqsc0PZQgowmTz6CJSuJvIDfT1BB//5T/7oslABaYdw2Y3DCO9W56FEwj
 JVNTsphmWo3BmF1WMmk0jVcmEqbG5VAHnu2f81rVewBv3Xuzl1wESbj
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 5KVjNaQlRaVZMcHxXyqOIrLDzxfAllYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfX9jgHG5wqHtvt
 XyzdAqW+UL47cSDawwRmJYlNxiQTJIs8U48PSoa7xiG7oUrqIELQrcFe59yFIFI6HDJofKx0sKD
 V5QCVDJ3/44gu/rqN5PWvuJOGZEI/Z3rYDjLuEBPfZbQVAIfgLamOvIFUtHtz/yxDd1V5Y0vmYr
 xQk02rJmnNKaQ/KJ//nyTK+Xlk387R5wBMK3hvDjqEpNfVchqmj387bDQlchC/G/QCV43L0YFBU
 i6F2HF7U28ZwYsjKvXJapsFj3EjEWzpMiwbqolPFVKjKk9kHB1v8h9K8gJt4+Wrbm3pO5uW8+95
 UL+OdUoDc+jQwPYjeFv/3AcgozoQ82i8q4tYfi3RD3Wv2dfETplbPO1TvsP/vwWlbBahtsmTtUd
 QZ8v8PUqBZ1XBHq1TzG1lVID3VIn9W8xoq0/Fra54GM0LivoaAw7ucr6cCPTAlGUWMSsdiQfyPw
 o5HiFON+ReSH1dwFm8w==
X-Authority-Analysis: v=2.4 cv=K/wS2SWI c=1 sm=1 tr=0 ts=6a21dba3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=oU5QhpEZILUeHJGd72wA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 5KVjNaQlRaVZMcHxXyqOIrLDzxfAllYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040197
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

There are stale RPMH votes (BCM votes) observed after GMU suspend. This
is because the rpmh stop sequences are skipped during gmu suspend. Fix
this and also move GMU to reset state to avoid any further activity.

Fixes: f248d5d5159a ("drm/msm/a6xx: Fix PDC sleep sequence")
Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2e5d7b53a0c3..a2f6918c4f7f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -642,7 +642,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
+	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
 		return;
 
 	if (adreno_is_a840(adreno_gpu))
@@ -1465,6 +1465,9 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 	/* Stop the interrupts and mask the hardware */
 	a6xx_gmu_irq_disable(gmu);
 
+	/* Halt the gmu cm3 core */
+	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
+
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
 

-- 
2.51.0

