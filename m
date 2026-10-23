Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F1606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LnS80R2n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b4nCj/jM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410F9112D3F;
	Fri, 23 Oct 2026 23:26:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D7C112D38
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvCYI4006361
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=; b=LnS80R2nHDWpSUJD
 EEYQn6h//V+BzSs9AmGR7RnIeRomeP0/SND86emVI9y3oXMHIsXsmRYnwFx4bfer
 IZoo13T9fc7y5j/WWZhD4DDfSJhVlPjM4SPaVo8+gTIBFovdqd2iHJ1pFQF7w3e8
 TWwVdNl6w1yoS4/412vZ1HzVZFVONMmJZndDBhg8YBcsaljn8ssZNGPyjt+BkEd1
 rfxB1Ih2qb3ERlQ+q04rXQnQrCwve4T1hpqyp0dL44D1jfPy+7x0OjJ9rCeh9sAg
 asx9tlAWfOp19LV+4+2BwqafQgHsQilPmhWKQZMRyfsqXIuP0i0Fe7MvGgjbrsiv
 GkzzQQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn26ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f62934ef6so327565685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797956; x=1793402756;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=;
 b=b4nCj/jMrWh/WGxucljBKHUgC68fmwuBQ3XBzXjlg0Wc++n0Obb2DOHq6MZdFaR/B0
 rB2KcCCa+yVEG9bzotqP4ZdxKQHl+PUSg+mxzzikXHYgNPej2aHnTfU4wgIIQjy3HXq6
 mnzV/mM7kECv70pa3rfhggwOkiCTQkPvu6qC/RZY0Fx3WY68q1ywGznpDjTvRj2EPWc2
 Iz719Pk4A5rx9qrnKUY02FhKCRsopgD/C/f1zvPsXGBdw22Va0jODR/UU4Zce3X9PKmB
 q+BzKyGJtgy5Z5PbMHfL0YDrPZjVoP3HKW6aJAHRLfnUu0ynyp8rTNwfAcNZKWAqUdYt
 2iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797956; x=1793402756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=;
 b=NRdHQ+pnEfMtcQ0XfQQp4BSwv6macWNUXho2DQFgcNqE8B9x3TNTTF/FqUYDnhKKI6
 XwjJdXY4rH6+OO3G9q7beqBFxRWwe2qx/ggEqmiKm/sVJsHZ26hU6ZboMV9vVWp16MOI
 EDcbra6Poa6k+f5gPsDi9t4gwZ1ckef/MFHqxYEstmv8eBZrkwnBbzvOezGpyPMbi1Om
 zyK+g5vW7SQW84lObRexvVQDbvEiR4wMpujrapR3XrolegYNEUZSqq36kTyb5TW3ArmX
 LVB4b2qZ3VYEK52bjdkMTDE7JUSBAWg+LSDTOpUA+XjUORazRVwGDpKrJ4icjq4yUkkt
 okFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTMF8hP7/N0RMVuvX8wYM1uuwfKepdk4ApFwpeishqf31xJcIvp7BY7qdi3tVn6ufqaSGruOftIAc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIldaohkTdhND2r26iEJIpcWoGhb/7ruF3SepdZt1IrdMqJjaoV
 szNpk15BaCZba6VhfkHa0Ka1LyzSBROmfysYrS+ZHHEoS4N8I/ivKhkU0sSn9SmVfP2q7VL+l+2
 MFyjiNOoLnpPZNd3exfWydojxpZiKrxCzkG3M4zGk6/l5oV0BWovu1N4MsnUngK6ztXJYkbY=
X-Gm-Gg: AYBFou1aDDM50MHUiNNyK5WuUyyozHn1j2M4SNDkMKBdIpG0irL2V3Jo2eDbB4Vd54t
 maI0Vhoimh9I8rq5M1XydC7N8pQo5j2N7n4e7dISVQ4xrBj1MerpQFgTbd0jB29D05VKlM9Bahc
 bs3GkZUuOhoeG1puzlT7mxW6x6SQlzmVBfLxtJcuFLM2K0Wjr9e4VEBH0R/ImDBjdKRt/FHBVSR
 p5i4PXtBRDLY9CV2HU0F6ZG6LpF8Y8AFHKkPYW087RK30YvEiUJgQREsu6EIGOfTXIGyB78gFUu
 cWMQZ+H+HtTRfnqALYLvS+GXA5iu2of8ZSl9yOc3GKu2vWTbcafKf1cisLDuaSgREqGwCBVDNbt
 oPm+L13x9YFnSkkGgUCKtbUKnXCQuI6QQRad5MJyEcfcCM4fTN/90v1DYgoDaJswBLnqZDiYcIB
 61uhxiElsUKbUk
X-Received: by 2002:a05:620a:4002:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-940ef8ad076mr91124985a.16.1792797956237; 
 Fri, 23 Oct 2026 16:25:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-940ef8ad076mr91120785a.16.1792797955717; 
 Fri, 23 Oct 2026 16:25:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:28 +0300
Subject: [PATCH v5 07/10] drm/msm/dpu: clear the DSPP pointer when no DSPP
 is assigned
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-7-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T4qe/ky6P713qCmilfQ+5NwYZw9WXGDP/jjKvtHyyOo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zqQkfwczTu9DR5C8IzZO7jqCBsr7m+Zvz5f
 nie5Z4ZopyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs6gAKCRCLPIo+Aiko
 1TvHCACz57GHDO9exaxWFrq3FpilvizySn9GffjbNQwdodh0uir/gw4cy7Mhj+wWzLUMfkOxw4L
 mXRQqzoHYfWjboiEotZo+L+ER1pfvA+9oaXAmnqIEvbpbn24e7qCPp/wbeSuYPRfYtD+yylCxAH
 Fgi90OnK3QPOWJg2UwQP+k3L8YsMvmWosOMfQ96HD4et5X+uSKuVQIVnT0gKF9+8pb7Zr7nlOmH
 Ihj5ZmirSmVhfdK7n3tVaevyrukZ12kYAXCtVMPHSmGJ0we50TljrNsCR0JwjaEvb5RTkb/gpL/
 dHM7+kbpZqwYHnbW4m8TYJ73FTXkJSdDp0GETCE3RdVNGugg
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX00zi9iRDqPnn
 716E8tgqVF9z385RiYIQ8DntSGyKburqHt3Yr/FaqcoOi1Bt/IuCA7PZtKRoB8Cxth/1i9Y2dok
 Sf8oZAm9w3mYTJxfgKiXLAMbGml5j0NMKJKNkHsfl0RDJDHB2DOYk/D8e5AWP30Zp7n+I/JfZh8
 a4aG3pYNpm026S0JjHytlL0uscu8KLyeaQJ08bcLBm1balLXaLmUrvwjYD503pckTSKIShRaMTm
 YLAs3pdbn03UmG6cxl7hbUNuFrqFLGSZvcLdRxKTYR4MZseeF9adBkzdOoIqOmoXiH92YCP+tUc
 +wZLBnVtJe84loBq+vXm3e5SJhXEchiAfKyZOMzEFiQz5Ad98UvI+Yi2cjaHPuOkWt9KyQt7HQS
 2d77tlsp1hLWtmW+ZgWrkE96QcJi4jIEDN/cxxfTgv6N6YW4wANUNREaEhtbJCLm7wsevU1jHQm
 U9X5NZa0oUImY9H722A==
X-Proofpoint-GUID: TticVa7JgUo6ou_YJWdhY2o6ivkBhS-l
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adbed04 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jpbDcG_WXHA3xrgMYRUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TticVa7JgUo6ou_YJWdhY2o6ivkBhS-l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX/inDQqcYiO0w
 8ZdF7OyVZYbbb2G8Osh2WFsP53WcaJV0h/BtHO8UUj6GCcM6Tlz/VDGIKnkG7J0HoIXIygDLUzh
 VaHxhNTnAVFJTQg2ztwL+NxHhn1UngQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
to it for the rest of its life -- across reservations which no longer own
that block.

Assign NULL when there is no DSPP for the mixer.

Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 1f8fce366a1d..2ff0dab33710 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 
 		cstate->mixers[i].hw_lm = to_dpu_hw_mixer(hw_lm[i]);
 		cstate->mixers[i].lm_ctl = to_dpu_hw_ctl(hw_ctl[ctl_idx]);
-		if (i < num_dspp)
-			cstate->mixers[i].hw_dspp = to_dpu_hw_dspp(hw_dspp[i]);
+		cstate->mixers[i].hw_dspp = i < num_dspp ?
+			to_dpu_hw_dspp(hw_dspp[i]) : NULL;
 	}
 
 	cstate->num_mixers = num_lm;

-- 
2.47.3

