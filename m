Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394F9CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3679610E720;
	Sat,  3 Oct 2026 00:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibvi7BYH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VkWB9LNt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFAE10E720
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:22 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeJho2309730
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=; b=ibvi7BYHEst74VdS
 xaIFT6PTCnXGdTDdRtWJZp0vgb2LpSeCOgdFHdrJZRmiL5UD1ajCTP3A7ASxFJdQ
 nQtE0bTEpj8fb9NjsakOxB3eqIks9YO7GyL8iaUni5mru7g0c+2IyQBkOpmL8/CC
 CGKz0RLcbsYWvj1vUXfYhNYXYEFxX2QD177E3U3h/7MFB9fB0kn3jyw2BFv4xIpK
 R7xzuFcw++BtjDuJe5UPI1q9bOErD0l6LrZFyVZyPo/fpyE+2OvnOj2ZvoLiBqrR
 adTIUDjvmo01MOiQX5pXWGOzGeCes4sRbdTicUDIC1ORTyvk6X5pcRXuZTzaMoWK
 a95Ytg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3da2ba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc359d9easo17898285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987240; x=1791592040;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=VkWB9LNtd6GKK8c381/LkEZiBWQak7TQXSi8UxRP2Trl4XhYHfCWInaq7bgyI1OB73
 a3IXfle1fxmrR9Q2APONjj3VETHCmWHhOG04ezY7nRkwC2WOKBRfsYzg4n0NDJVup0Xc
 Gi8RCGrwsZ+svT/x29xRLoheSq4y1phQM05e56B53ZYntV3mfyL/Og8B5DcGN1Pl8dlJ
 /IFMkYXSjYMVg87s70XDFk4GhJ/+1dxuRhX2IOW4ceLDpYaoSLUHZJrFDzRUpBDLa6qY
 MfS8ovewKp4LE54Oi2qy6KrNBPIhXA9+pqKzb+SYrPZ4YoGIe7nGtckZEnXR73Sad6z+
 shHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987240; x=1791592040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=ZcIXnmEgdXrsXMMiA1pM3V5gGCmGQcuAxyoDTRRUKSnbc+QcmWvqrFWE4tUueBXD6Z
 1etEeZMltq0l01bdqtuKSHQindS2XC6I9GpSidZmoFhojNeA+7lWbPBYJ9oRm9NAl5t5
 HjUBnh7D+fNNqp/nOQluW7ljRIyWcXOs70HdUQR7gAFJVCxe4XJgMoT2xn2fXU41hzJ5
 ket86bg5vy9L+L+/B73FXvBd/TYR+tZpwN7JAjagLVWzSfs3byHRgdzbO/jrentmBQED
 22r3j6uWxNYTnTNQvWi4eQz0Lg0Bexd6OioYVxeeYYkA+rWWwTeT79FvEpKzwpoPn6cj
 BuUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxZdDSp/Pj61V/P4xMInnWh3NBNdZSxwmoykmjQBroMk+9nJIBF27i5G0SSAcspRDh+vPLDRoQ6o0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFiGKLgWdN8vuUhrl6dteThzrnRY42reutV2ZN/Z8brhJhgIzN
 fFQVrhyVNzYZueCd2PTnewxfOW1FUndFKilluJbQUhSRchNfyuQ6yX97TnObL9qoID62VZNq/az
 AoYFTYx5qeazD7hXNwmSUdmQcEng85Oed8LQx7RzS1/7aJi5rndi7MSyV6u4g4fMD1wMzPio=
X-Gm-Gg: AYBFou0IcZSXMoBMgeQlVHtxigJnXOcbYVLXaIAnSlHkto4axIuAggEMxRaNEVQiKEf
 u2uUUKtIXWRCwaFP59sE2H5ytqZuQzxGVXeMu7x2rIR7QNhXqP+cC8GHWgMkQb8+nZg+WO/HOCZ
 FPnvjFYGCl5mntX8wWsr2mles1ABXJ4kRMB1g8G7ppmDFjUxVqQLukzK8gI/sx6t0seugrF6awd
 lIqWIicFo/JTdO7CseibIW08agievSLvX+SwyygqByWXaKxkMNywUOb/u7JFoybeGFetqHJDZhM
 7j7qai29o0NyzZOwWyHwSlgnT/8eOwyH9yE8g8iVnTm0jx+RbOsDrVXRzck0CwYpMc6WjzY8Xxi
 /YMxY/gfXGSCasmf6BzHqwahwctEzYxIGwJynAZKEeUf4FSgf6fujBNXL3ueTZQWAZd0PzjEYFM
 9ue8dqeH5ueDz9
X-Received: by 2002:a05:620a:4890:b0:93b:d79b:9a54 with SMTP id
 af79cd13be357-93cf1889e4bmr829882885a.53.1790987240352; 
 Fri, 02 Oct 2026 17:27:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:93b:d79b:9a54 with SMTP id
 af79cd13be357-93cf1889e4bmr829879685a.53.1790987239891; 
 Fri, 02 Oct 2026 17:27:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:11 +0300
Subject: [PATCH 03/11] drm/msm: clean up after a failed msm_kms_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-3-e062b7dae77f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AzyBqQgyuR3fL1mDrTwzGfxEu1JDwGk4Yz8+Ubw/F28=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvf7927W4xjaDmisgjEqzonGTHC9UgMkK4qI
 /sNqpqNLUaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL3wAKCRCLPIo+Aiko
 1bo4B/9iunFOP3P2Uyrjz2EkO+PNZ9yYY8L/gD20KZ/zDa7+wWzVLHfF7PM2fLSD//Cou6TGFPc
 7V9KVQ0CxnLv0OSTEZCuqMLaCsT4APASgZJBs0ZsPFcsnRNDc+jniK/A2VrazbIVRFkgoxgmytg
 8IZj+9r0TTBAeX5JD1IT2qif6asy4eF5ERYHFplvqjvZmVahGQFh3S8DPNqGvPQ2EWYu4kY7Ghg
 I4Ba6MuZqT7nW8JRA1HVCLmerQ3niinR6PZSVSlgVLy0sl4WJgxpRZsCkEl0EcAeiSfc0JWnsH6
 LY95lctGW/UUjTROa0bmJ8YpkkEc+25LQONyibbkQjCw4ShN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ZLh-wCAtKzQNovsZbnua4u2Dvuoa_q1z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX6bWGWuqH7DP2
 V/kvevab/VqcXWfcjENmNvMqiCIAGcnOL59vkSvR9ZJ57ob0H/bPe7iMmwykQiudxDlcGo6w453
 m4ELEiu11Q5i4nUizHRSX2AeeGTu0pg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX0NB7TdtiJATK
 Dm1Q4ZTS+e4mtRYLpvJoWz0/Ja2fPD1isMjdTyZHvyXmsu6gQKCoLddfUI38wCUcPGNBQ3rh5u7
 RlonNJxy6T6qis3cfC/k6P4cJjmkwBnyHTPN7tqtQQ4FYrEU9PUSWeGUHMS3i42yAJXzhU0UaI4
 vuAhhMhbsDHlZXvnhOR/SkvFmtyuK0+DWGvLJnOidwn51r0l1T674wceSNoUZIRm/9GJau4JVc6
 YZfzklt6nt6obKID+69vEFxfBVCPcITaKEZ0yAIgInvZ+hpK8ID12KB2faCQVLfM4K0Xr+Y9ypX
 JoxoIUugu54rlfJhpe/NhZen4+NHSx7p0lT339SQ6zt0RetswrJ9pEWOhElbagK2qiEXg06/fjX
 p8Rw3wTQF6qqn10vUjAvZ7Op1wEYfvnxE24x0RjSn1E3jnjCapcS5a17ebPA9w6tOkP/aeGqZqI
 8/nIwRHR0yO6cKfDYow==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6ac04be9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=MHPtEXvVaziToaNGM0QA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ZLh-wCAtKzQNovsZbnua4u2Dvuoa_q1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
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

msm_kms_init() returns early when it fails to allocate its workqueue or
to create one of the pending timer workers, leaving behind whatever it
has already set up. The kms drivers' ->destroy() callbacks still run in
that case and reach msm_kms_destroy(), which passes a workqueue that was
never allocated straight to destroy_workqueue().

Tear down the timers and the workqueue created so far when
msm_kms_init() fails. Until every kms driver has stopped relying on
->destroy() to clean up a failed init, let msm_kms_destroy() skip what
has already been destroyed.

Fixes: a409b78fcdf7 ("drm/msm: move wq handling to KMS code")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c |  1 +
 drivers/gpu/drm/msm/msm_kms.h    | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d..c26b0c7acdfa 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -134,6 +134,7 @@ void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer)
 {
 	if (timer->worker)
 		kthread_destroy_worker(timer->worker);
+	timer->worker = NULL;
 }
 
 static bool can_do_async(struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f25b31e502d2..ee98393b9855 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -175,7 +175,8 @@ struct msm_kms {
 static inline int msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
 {
-	unsigned i, ret;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++)
 		mutex_init(&kms->commit_lock[i]);
@@ -188,12 +189,19 @@ static inline int msm_kms_init(struct msm_kms *kms,
 
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++) {
 		ret = msm_atomic_init_pending_timer(&kms->pending_timers[i], kms, i);
-		if (ret) {
-			return ret;
-		}
+		if (ret)
+			goto err_destroy_timers;
 	}
 
 	return 0;
+
+err_destroy_timers:
+	while (i--)
+		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
+	destroy_workqueue(kms->wq);
+	kms->wq = NULL;
+
+	return ret;
 }
 
 static inline void msm_kms_destroy(struct msm_kms *kms)
@@ -203,7 +211,9 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
-	destroy_workqueue(kms->wq);
+	/* the kms drivers' ->destroy() also runs after a failed init */
+	if (kms->wq)
+		destroy_workqueue(kms->wq);
 }
 
 #define for_each_crtc_mask(dev, crtc, crtc_mask) \

-- 
2.47.3

