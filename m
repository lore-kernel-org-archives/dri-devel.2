Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD822606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aluv/iyv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVsUyBne
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BC610E731;
	Fri, 23 Oct 2026 23:20:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A3010E71F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv9p53683591
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=; b=Aluv/iyvrrIKRl+1
 /5SyUn54dDWT63KmrMF9ijQNx6s2cvN/L7S1Sihz9adCoj42OovdjAwWoKjR1538
 DJvuIQ6LyvhBp0hPCouGkkhy2mJ5he0yVM24Yda67h+Ycn/VIX1h+leBnoL/1c6W
 SRqgZR9+0iDYvsBiRf5dQjgum44a9DxSK74C02icYswxvC3P0uXnHKrqtqt+QZfn
 BQcfLEM/Se0ZqWy6GRCkZW2E8PVteDSzRcJKentGOcj535F4EWpSDtM3Uy8a5AR6
 JcZfGyabaYdfGK2wWb1hv804/B8v36UfMpDWJrNnl5lfu40Z81x6LSx1OzRfZCYN
 +UR6Iw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6sb4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f26dd2165so93731585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797600; x=1793402400;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=dVsUyBnews36s/ka8yovzJp5fDLs+oJfowwWaaUujqdjVI29qQ8xsRt7fWpp6Tc2oO
 gfpMcHVeeFSCF12gT1ZvCkJPjdWyQfTR8SkVHRAdO9sKrVzQHCdRhRzf5O4uC3ITX8rw
 0MwXduHS+O/oQ7ykFS8LWPsq2lfpjhYsGxtzxvST3W7un02FT9oo34cOvFlUdOZIXIFn
 5bgXJ9CYhXsx2NN9lL4rtMM58/DCTbvN/L8q24wZQVg3HSIPDpbOZAO4DkA9bhpjZFw7
 aGbUeCgMy0lcUqYzPNw50/vpAmJz8EEmhlA3jFx4FWMIsJNVIOV/BpMRevwimqPmt/jb
 Y0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797600; x=1793402400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=vkcRuN/lIppzyl2T4ZJBl30tcAgxrvXEaZv7a3Wig4gzCvBTVU9OTgGoaikbM8+R5D
 7Zf0IIpH+dhzGzczeXDxYg+8UGnW16PRUCuRdh9pDBCgZH3ygQT8H4tAEVbRtTSNj6z6
 UY+EcoR4cct5Qk5DfdnkWpMumyuDLaYZGY6wEKlovQUUdX6I6UD8goazosKTx5PlgGBq
 gao48F+QzcpeBPfx0DHwydkBcvMBluUCvqT+DBdaO2MQPNC2AiQzk16kaFa1dHYGbuF3
 IE0ELKJy8TPcHsICmIgUcEuoYiRYQLl5XislJBRlxFsOS0f4yKukqpC/Y0cSEI++h7qe
 xdWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwELHhteJ8+QaN4vIlibtSgJL97iIbkp2bNfWwDKmBWOHPqesjlKohEUvX6nZV0AwFL1M6bSotRIHQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAKpsaeHCfTYjIrhDLYa6rZIRQACgBR9WtnKIL42bbCAbKspwU
 y7/+ElBBlSjB1NITI/o4tIcgS/fYBRROI1s+r7cjkiuirOG3umTASLQe2ga/gTWpCA+5hlu+LWo
 q3vk/I3dmyIaUN2ru1WwL0g6cUAxuCvcQrafK74wXCzUXYmeo7UP+BFQ3AjwBioKwe2BsXLM=
X-Gm-Gg: AYBFou2uQhFaPNZ6NCWDsAOx8HWpnIHhYB5kBJvWR1gZfvBpbkbEyfyMHXvSBjbTSUr
 pFsXXPxnBOht7XQcMTXE4rKE4VhHgUsnV3Kxpc0+PYoKxdoWPeKyoWEIq/zBmxUpMMawTvXTAsv
 3ctTEEXWdyYVnHqHUIJXP1josYGCWIUlqRILsR2FffyrSXNZGTSempCOmilmWAlV+Ymzz+Q4x71
 sE45BxtItHftXydgTkDOD4Mmzd3RBz+pi1MULcxgZF4g3F/tbqqQswAfHQ0G8rPzJ4oIHQYVh9l
 LiEuLW7LXatFsM6zcRVykFDpi1KPE055a5iNth7jbJqFIh3YklIikkqFdQ3JnwvHrLZelRc17+c
 hBGOOSFPuKwoyLOElyb757t9sKHB98SV++5yz4z9aAs2VJY3D9WoBVlJ9yYDImmB5kB9YbOibN5
 XtrO9rr+oYQdXT
X-Received: by 2002:a05:620a:4008:b0:93e:d7f0:497a with SMTP id
 af79cd13be357-940ef8bea57mr86708885a.16.1792797599845; 
 Fri, 23 Oct 2026 16:19:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:93e:d7f0:497a with SMTP id
 af79cd13be357-940ef8bea57mr86707085a.16.1792797599390; 
 Fri, 23 Oct 2026 16:19:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:19:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:34 +0300
Subject: [PATCH v3 01/14] drm/msm: fail the snapshot init when its worker
 cannot be created
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-1-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WsQ21XZW4TA3F25Pv6HWJIhCOEkArUvMa6B6iciNKmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uNWzv5sWeJLMJrumC5ZpaqGpCgFn6aRBMY1
 Z7whunSVnOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrjQAKCRCLPIo+Aiko
 1bAfB/0SiCwjML8FgRX7IJ9T+KYMFwwrg5nOqeAVTruHFCS6kMOf5truYmZeGWkt4jYs5xnCpIt
 6yVo2HP8aGa1yzqRHRfa6kCF9fij9rqA6QbmviKkFYFNDYwDl9w9lp79bdjSEsyhlURLUTWF91L
 h32BmF4jDdXrsGNjFCZiSojmJWcPv7Q38MJF2gKbDvWFj3p7GDmiQAQJkEwv8A+No/oIAe0gnZr
 HEkhBmym7QZ0ZY1DSl5rdKx6v8cP1GI9t90Pk8s8zqinebLsgs1QrxZKSIkncE+90R72dfaxgpr
 2ZCM6g+Ie/Qp0Yi5QohmEWzEbmeIYmmzK7IT0EI8i4v/HGAa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MSBTYWx0ZWRfX0E8z/KSSFake
 Y+Ja38yNpVL5Fp3l7/FOnC9Whp1EJRaLOYyqJCFTqMnJkG0C2WQ2QxEotCuzS3Fz/58Zjl8N/lN
 5GlqPYHK9IkaS3+J/UAZg45tpLtH1gxN9jaoPVQFUbD+u3QbxchjcqryRMJbw0UQBFHKaeKAqlJ
 CTLTfBLRBOYW+J9VpeWtCYw4Lv3DvYG5wSTAAcOsAANB01KATMOzlEafdHVxN+9xx+tqObY58Wb
 uFXaWuhxHg70KIlnxKhPNFz3rM+zt0GIX0HrxEv8d6moGXZFwWOsMrFkiVfnBwD6EwDFY/bRRTQ
 m+/5/IbZJ1Ck0904aSs8i6XMyLJWFz+WJ5JbppK+w1NrznCcAWPWDInr3SxBtZjwPadNw48z+0z
 nNV2aaBxcw/2SWA5NIhvU76UvLlj71fyLPovjxkzymGxKBNxhQWThyrOqMXGAyPcTYyBdLJIuCY
 LIM6yroXBM4vdpqQrOw==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adbeba0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=D-zmcGmn4BrKCB6hg70A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PiKEAssoFLmfI4rURVZoyKeUjzdSlaVN
X-Proofpoint-ORIG-GUID: PiKEAssoFLmfI4rURVZoyKeUjzdSlaVN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MSBTYWx0ZWRfX7UPO2691Y98U
 A/jqRR7gG6K8KXPzIfFwjBUxJMvDTlumhW94ICq5T9d5iKQuU+6ZsTXbt3lqPIeRbJB4oR4BHk7
 ++pdhlmYs8qecyRGLdsjuTG03+rp1F4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230091
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

msm_disp_snapshot_init() only logs a failure of kthread_run_worker() and
returns success, leaving the error pointer in kms->dump_worker.  Both of
its users then dereference it: msm_disp_snapshot_state() queues the dump
work on it on the first display error, and msm_disp_snapshot_destroy()
only checks the pointer for NULL before passing it to
kthread_destroy_worker().

Clear the pointer and return the error instead, so that the KMS init
fails rather than leaving a snapshot facility which crashes when used.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index d99771684728..d1b10656e41a 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -98,6 +98,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 {
 	struct msm_drm_private *priv;
 	struct msm_kms *kms;
+	int ret;
 
 	if (!drm_dev) {
 		DRM_ERROR("invalid params\n");
@@ -110,12 +111,21 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 	mutex_init(&kms->dump_mutex);
 
 	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
-	if (IS_ERR(kms->dump_worker))
+	if (IS_ERR(kms->dump_worker)) {
+		ret = PTR_ERR(kms->dump_worker);
 		DRM_ERROR("failed to create disp state task\n");
+		goto err_destroy_mutex;
+	}
 
 	kthread_init_work(&kms->dump_work, _msm_disp_snapshot_work);
 
 	return 0;
+
+err_destroy_mutex:
+	kms->dump_worker = NULL;
+	mutex_destroy(&kms->dump_mutex);
+
+	return ret;
 }
 
 void msm_disp_snapshot_destroy(struct drm_device *drm_dev)

-- 
2.47.3

