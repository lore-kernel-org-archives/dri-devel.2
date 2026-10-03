Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB840CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F5B10FA66;
	Sat,  3 Oct 2026 00:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTnh8c7H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQ0guZV9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A8910FA60
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:45 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Nesi73187117
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzjg01sXsoPCXE0wHWdIrN/dgfnVbFdqvxoenT1ojpY=; b=MTnh8c7HFYCdHLef
 4RmKM7b/fKOYx3maTPELlv8MqsZf8xg4otf4S5/YkbeIIB1MmuvBBayY4YMihaUY
 WCv3pPniqbrtQmh+yYUT19ErZe663Kc9buZm/alBTVMExDgqIa2Jo9Bp3DD9Cdg0
 12wz1+iG7Shb0P6nKvswgdleaj8Lf9I6O4OJTm874Bf2jKwqurEhMhNFWbttLpS6
 G7gqrRVJ011YeVZ39JjwdrGt9eOYSUFFnCZrEazWyLAmpVMYO7dejb/AUSitj+7H
 3UL4zgIvvNoHHOkTdWj3R08YzhexOrXLRoJWRA1kqcjM+yFsSFWTzcELQiRU6NVL
 H57euw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh4v2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb71b1443so34621085a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987444; x=1791592244;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qzjg01sXsoPCXE0wHWdIrN/dgfnVbFdqvxoenT1ojpY=;
 b=CQ0guZV9xFwn7ktm7BuQfXX800KsAFpfGe8KTfgy036Tg+1HP/gCW+Rs3QIGYlw/Jp
 vl6vU/MfmhAp017vA7vN8Wv4YFHEzq160As6gIUgKCo5tZfjzN4nwegE0GadRbysyR6v
 UhCNzm247XLXAM5E0s5MWO8zYOnkFtQhFxuuW8CG5FMFSAvTMFVnp6EWSC4MQ+jswWKK
 qJg98YcEsHg7GVrqe7cVCPEuMvOOnCoZeDORIe7Xo+PPo8xMvNGthtOR9RsN4BI4MiNf
 v+FN/GJKvswXKoBKqKpTySbBic223LA14KkIrJlGwLnhUTfmn6aj5FP6caZdiXSOvojH
 C0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987444; x=1791592244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qzjg01sXsoPCXE0wHWdIrN/dgfnVbFdqvxoenT1ojpY=;
 b=NDa2bPgxBHf+vIvMd3vzzodp00mj/VsoFXtwC1X5ccR5jTb4Nl11aKYiYlMPfn2u6M
 gZQJPWtl8EoSxl/3gX0EeQ3pdGsUrUtRzOSL22+Ymu096uCcKEJvxcuM/SdJyCpZRjJv
 IUy4Rfe9SLDp2ArpX74ZCfChtKBF0TEdso57Tz+FHGva6wLUSngTMHD9Q3OBjSgrYG9Z
 sL+UMBEN4/kREbLxK4x7eTINpOX2ht0dJwCwRbSA0nSEYnmIcTZUnWHJ6LFvOz3sONJ9
 eeoeHugjIgq1CxZasg2xLkfTou58lgKfDBqPJ8O8B1aMjGmmlTsT7cEkfpmt7diLyoCR
 qMAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw03O+QMO06bRtsAxzOK3KJAk5gRMjfxg+ghn8Vz1CBQ1eM5Jhv5b468D5d7/jfppo9jCjRF8nR68U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loqPSpxfqSQbKoxCkvA4PON1hQnN60uoxvdMvluaE8vYhCnfsH
 eISqL1PazcL9llay52hH4RL9mhdl+0ddQbeiAEOr6zrdVagf0b0lXw2qok7fNYcuWtrQ7anrO/N
 W7YHtFyYMe4vV+BOS9mYPjLg0kYMymi3AW9Q8RoN+VVuroT6kbUjP9+Ld9iFk32FhI05lVKo=
X-Gm-Gg: AYBFou38RG4micQ3nVFIIT1UncCX63sRTOwwkdC+llumOkoIG3lTpUWi2rh929XqYvJ
 JmxeuvWakLkTyGSPrXuFShTnGjfrGnn3UxSynAUlwzdwDPOjztp3I0JwePMN0Dff+tjTjeGmKpS
 eIxxtte+oF0YlWmcQamsUGCI1L1MbaWRHzAaP+84Wj11ODZyXEDstqAZoOiinhvX4nWJNtFcJSQ
 cG8cbw8K5Ot8+L2U9fA3W0G27+19PnpbGlGpDiw5ZMgNzDdyQxLxS5sXlKn1daE0wwTvwZ7xWVd
 6GfArFrpkQWaQ/LZNywqmsBnYI+lkOW6+HPwM5SAfkThWQtN85U+/xMrniRi9sGGrkYsYrRLeZT
 UMSUW42Q22D016L02HudHzAXfnFbTCBtnwksDv46LyEW8IBKRabVJD1T3bfbGPMEB6dIbJxJdG+
 UxjAMdsZvPKL0L
X-Received: by 2002:a05:620a:63c6:b0:93b:d79e:18fc with SMTP id
 af79cd13be357-93cf19d9c9amr774727985a.63.1790987443766; 
 Fri, 02 Oct 2026 17:30:43 -0700 (PDT)
X-Received: by 2002:a05:620a:63c6:b0:93b:d79e:18fc with SMTP id
 af79cd13be357-93cf19d9c9amr774724085a.63.1790987443099; 
 Fri, 02 Oct 2026 17:30:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:21 +0300
Subject: [PATCH v4 06/10] drm/msm/dpu: clear the CDM block left by a
 previous reservation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-6-2a44d4d8ac77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qDC/1kRYej0W7VGTHQU6LFLcQkIBjfcgW4nJJgJo66A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEyexXbZPcj2WkXmdKFhlNCY+LoLA1/Qrgh5l
 /wRsNz84FSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1TG3CACiUyiWNJ27fRieqtZ5gqVLddU9hRWY04Ge4EcUVyP4o/6epwiUq8efwp/WK0DPgMLb7zd
 8fbIl/Kz/g7zBxFT/s3OsZrX9K85Chyf5TEhyot7V30EEHWTbCP//rzAj4+RrKKA2oy3f0uTGO3
 RGf6eKOUBgBpnq7ReNbjajwh9hSvniPIKhYyS36ff23brrbkGdl3cYpnobahx2buNQsnhHJkgzh
 UMxNC9ztYCQy0csWcuiFg75jLoI6uisjBzUFKFyy9Qg76DJKzWfa862vevfV9OMPZavC9N8MvDr
 afvTdxX5DX+bB1L9LBo8lWWb0R67MMgz7m1dvhJ+XCcBk+u6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX0+DIhfleMsQg
 FtwmSkVzST+rUgyZJJ4CbP1zrKvtnxvCUv6b4J0hCWn3XWjduK2dS544GOVY/jSnhjzGyov7aAp
 Ks6zwdhYS2sRHYmgUOb3YeIBaCHcJnw=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6ac04cb4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=lW-OXhpROnvg2TLzoksA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX+l2w3IWlv0nc
 2I6lnXUDS5bqrlqJLjPcwYNCDVygYvFYwjERXp3l+DNnUl0Rw7vlzN+VUaZe5o5acmb4LxE8fB2
 5yeatkYeGlkKZMBuId3GYELyn47olR0aE2g6yorIVyKhKWWp6bpJGWDAVCjqKthQ+AEHkDFYtPp
 ZtT52E4J2erdZ9rCahZ57aXXn3fnq3FOcH8iFSaD8JvCtDOfJotjkSuiCBFSwuhMZK+euL/I/lR
 bxUJhz9sx43hCNIMkOwCUUQRD3CwGw8v7O/Et8EoXi5GAdzGUFOPcCpENIirzJExhXTYgoBZhke
 T8pqxHsSJlYjSCV6Wa19+Ncn+IvNlJubDzRMzUQUmu6JawJ6xKGHkoGfJdpuu/rMbBAD7ylig+E
 Io1PuI7+WUr/1kh8/ciImzjS+v6sBLNDY2cDnmHz0njTJzgPhIBtSZimEJmmFfe3mFamBDbkHqo
 /ii1BjkBfU+G8scRNcQ==
X-Proofpoint-GUID: ONmXVYSEYmRwkNjC7_uvWjj3fAPWVlpw
X-Proofpoint-ORIG-GUID: ONmXVYSEYmRwkNjC7_uvWjj3fAPWVlpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
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

dpu_encoder_virt_atomic_mode_set() only updates cur_master->hw_cdm for a
writeback with a job or for DP, so a modeset of a writeback without a job
keeps the CDM of the previous reservation, which the crtc may no longer
own.  dpu_encoder_helper_phys_cleanup() later unbinds that CDM from its
pingpong and flushes it, changing a block which may by then belong to
another display.

Store NULL when no CDM is assigned.

Fixes: 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index f06b52579740..6129b01c35e6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1160,6 +1160,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_cwb[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_blk *hw_cdm = NULL;
 	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	int num_cwb = 0;
 	bool is_cwb_encoder;
@@ -1231,14 +1232,12 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	dpu_enc->dsc_mask = dsc_mask;
 
 	if ((dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) ||
-	    dpu_enc->disp_info.intf_type == INTF_DP) {
-		struct dpu_hw_blk *hw_cdm = NULL;
-
+	    dpu_enc->disp_info.intf_type == INTF_DP)
 		dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 					      drm_enc->crtc, DPU_HW_BLK_CDM,
 					      &hw_cdm, 1);
-		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
-	}
+
+	dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
 
 	/*
 	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not

-- 
2.47.3

