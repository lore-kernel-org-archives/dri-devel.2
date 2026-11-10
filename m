Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BC60A3838
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RzfuSFdh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DSlFSAUR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2B010EDC9;
	Tue, 10 Nov 2026 04:56:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D652910EDC9
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49wSv2297600
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=; b=RzfuSFdhQ5952aXu
 cirCOYQZC7ICfSLnHOqeDszI1BIU7N4tKTMSJjegbhRBU9ZRGJO67Mon01ROKWXH
 mJMPJEL+4WMQYdbKxrujlKc8Yt8Vo03kmfdnR0ZGFvJb1umf2wDwa8WAuRVWy5gA
 8bHfrByiCMdL0B9WCh6+ePl5k9Ougt3Dg7XcfEP47g6K3aAXjjV43o3LFi3mmywJ
 yHeoeazc7mgIqXn6cfcSJrIo/XTQwc+4U66m/g2v8aReb2C2E+QKlOM1TikGJQYR
 lRstc6Q04cE6/zKZZ/mIiSkF4D0hZe77F2w7fUg42j4rJYN562Jyh7sokYJYdNCr
 yKFdCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2n0m7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-945b0154705so250526285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286581; x=1794891381;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=;
 b=DSlFSAURby5UW/PQSHBm1Vpfvxvq5Mvujsu0qFf6ls2yQde/+8HKhmZvmrE0gxFa+6
 HEO+/h49003/IoJWdWhsxZH3ch+S8PRvS0XC1n2L0H8L8IH0mBp/Ud7/F/vD6R2ooazn
 pEIsbPBfrfFwjTFh4P0Zxv1qlqusitCLf47jR/wH5KElDOLs4aZ7/SZSohFwIAW7If0F
 L4lXL4ajh0ZvcXNA1ZgiqXmIikD6A2BSHdxGAwk9GoUf68AhCoWQyVZHFk7q0qVFPAWB
 O4ty2zqE5Hjz4/vUbnw4kuIqmHJ2innCzDYirpamUjM3KdIjIPq2y5GJ5rG0vmhj/Vuj
 aXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286581; x=1794891381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=;
 b=aD18SSeiGid25rJgvJlPhIbVBOK8O8gtVGh39VRme9uQm9Xb50ONhsxTuYsupv/bsh
 HyAL308kol50WTtScXR3Tozxi8YA+ojKUvIrCNjQANQeetyBShhOye1eVkTrjPNfTcEk
 f+Uu02+Mobaoy/1Ubis3oYboihxaeLrAbC6SBQc5SEVuYpr0m4Kvklhqvz532GpmjjO0
 Hqs3mDjRCd8V2/7LMOjXuegsD+ufcsHVDvUatjQ0gMFJs68Bz2lhNOnVaIN00qoUKayM
 LXWcNLVIUdjrOJ36nDKpLBWKHqrmCONjA9twYvCbfrTcXKQxzGrO3aFUdtj4mp/36s5g
 NBdg==
X-Forwarded-Encrypted: i=1;
 AL+hErFlCswkHGeh/MTLmQeVhUJGYiePZXtDlcb5ZOLP+k0b9vU1LN/E8Q0pQngj1hXIga0Z3baGrvMdeGI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9BJaeab9xlb+PTv7qNNrolgMta6JvLqMXKIdsugExIk7msCgXf
 QJft5ngNFuP28m8SyG4x25SXm8sKZsRgPbuco6BCTYoNaGF8TumfZU69TihKy/+kqulTBLNZrL+
 YIlmNOICsnKp6Wj2r3+Eie12K9Y+rW2m9PtBvI97phvhSBYPumRq0l/0hrjD8kJkYf/OQKx8=
X-Gm-Gg: AYBFou2vYjU6pdGNePmnbdxNoOxZtAykF9KeI3LtWhdVVfFwAmBMqwifZcMlpb8flQS
 ZTat6l5+F+hoiDMliSZ91wJ6VqLay87faFcQrtZiT9L7JE8TawpJ+8lv8x+UszvkTRfdUesRF6s
 QZOrhDsHaUPD7C78R94gDYi8minCkQyPUwbmS6iChXBhyIzCy0w7WlTN1IZ8idnJs6/7Xf/tEbQ
 i2siT6u48Meff7jze8OaobbNNrhCA4J6B/EUIlQ/Lz16I0U0h0bHQ3j+stoZqLl1dKW7X1sSzCn
 27jB6WHQWwVHyJS7GSqU9d9IIAHXqDs0v5vjsaby8Wg0D/6ktIiEsMLlkDUhcxGsPRlmFgmvQaR
 hT6i7pg28YKaevJ/0/sABBB878vJ0nYnf0Y1JMS6NXRflxWrqvjx7rE/X86zJv461nrQ2MZsHm2
 ijQN+GPAbL0AxbvwGWEe4jEWxq/Bxx+s1bn4+i
X-Received: by 2002:a05:620a:372c:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-9479f2e9e36mr260570085a.53.1794286581270; 
 Mon, 09 Nov 2026 20:56:21 -0800 (PST)
X-Received: by 2002:a05:620a:372c:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-9479f2e9e36mr260567285a.53.1794286580766; 
 Mon, 09 Nov 2026 20:56:20 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:20 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:43 +0800
Subject: [PATCH v8 22/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-22-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=3343;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=AdBLBWWEc6vpplMBiBDW6FZCSILo6YakvdgN8c22ZTs=;
 b=+nn+fqbCq38uv/cS+G9pgRip4Cl6d61cANKpVXId41EtIwyNXBmAsnJKySqi7BCfV3ViaHji8
 TCoKQRmY/NwBREIn0KwYte9cpwjUevuOEEfyXYCiWfCR+Y1n4quKLbu
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af2a3f5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4giLZ5Ks3fHH
 NUtB+eJjCi5ylxVM50qLvaW6M2xoyd7tAvm3RizylbJFxpiSPsxSmfFlfKOwDKD9Kj2STxKLLlu
 j7wvwaNlyecdov1Y1Pk+SkW0wwN+UKCS/FMfDTZESHtQG7j2ACDcTYIQ6iqRI73C4VhgMZbuPvL
 0NFcCzNYYXqlv9y7bcGRvnQV5+gWffBZvj2ypZH4EhRrKumIFMZ2HVijvE49h9wUEd6WQTZsOvj
 EVTbXE4AXLTaaL6FQPlamD56/meRRtzcLA8fI7M4+tbl9MYSlDDNudL5IzP4kZAm2x++nKXHmOI
 xnKAPInuNxzp4gi9U19iMscsJ0LzQhhfPhqA8WdDkmV4GhxA/4vEPwZIOtpicGZTMSJy6bOZDKN
 FBFR8RVbWX2h3NnTmFe4RmlJUkkSGCjxMyBAGp9jipcJhySqgKfQBHbMiT+qOULLePhPZc9NrSz
 MyGeZEszJwGGT67kJ3A==
X-Proofpoint-GUID: GPbR8kt26WsdX5HeZ_DJOzhDplPpJ-09
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4D2A0f45/6PA
 A6VwaHGAL8npzke4a3X6MOVHu+ds8brC8Lh1v5ykcaUKxTxaphg68elJfCBW1J5JdlueeGdL3ca
 xScXU35CJ3M6vKZtf2Am4uZl1TIKpn8=
X-Proofpoint-ORIG-GUID: GPbR8kt26WsdX5HeZ_DJOzhDplPpJ-09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

Call drm_dp_mst_atomic_check() from msm_atomic_check() so MST-specific
state, such as connector and topology changes, is validated as part of
the atomic check.

Hook the MST helpers into atomic_commit_setup() and
atomic_commit_tail() to support non-blocking atomic commits for
DisplayPort MST, and ensure MST commits properly wait for dependencies.

For SST, non-blocking commits are already handled via commit_tail(),
which waits for dependencies in the DRM core.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c | 14 +++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h    |  1 +
 drivers/gpu/drm/msm/msm_kms.c    |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d3..e70e5088cfe53 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_vblank.h>
 
@@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return drm_atomic_helper_check(dev, state);
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	return drm_dp_mst_atomic_check(state);
 }
 
 void msm_atomic_commit_tail(struct drm_atomic_commit *state)
@@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 	trace_msm_atomic_commit_tail_start(async, crtc_mask);
 
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
 	kms->funcs->enable_commit(kms);
 
 	/*
@@ -322,3 +329,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 	trace_msm_atomic_commit_tail_finish(async, crtc_mask);
 }
+
+int msm_atomic_commit_setup(struct drm_atomic_commit *state)
+{
+	return drm_dp_mst_atomic_setup_commit(state);
+}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 597728ec6f3b5..ebbc138935c43 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -211,6 +211,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
 		struct msm_kms *kms, int crtc_idx);
 void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer);
 void msm_atomic_commit_tail(struct drm_atomic_commit *state);
+int msm_atomic_commit_setup(struct drm_atomic_commit *state);
 int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state);
 struct drm_atomic_commit *msm_atomic_state_alloc(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea6294484..33ab30300e16d 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -29,6 +29,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
 	.atomic_commit_tail = msm_atomic_commit_tail,
+	.atomic_commit_setup = msm_atomic_commit_setup,
 };
 
 static irqreturn_t msm_irq(int irq, void *arg)

-- 
2.43.0

