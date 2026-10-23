Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38009606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LAkPQxJe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yb6THiVT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2CF10E677;
	Fri, 23 Oct 2026 15:32:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F1110E684
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6JpS3557709
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +sknUJlIhDoCeuqBNgo9s/xQHtpRESuIUEkzFP4EMH8=; b=LAkPQxJeD1bDr/Kt
 ee5zmzt8kC41YgfuMuYkYCVl2/NgNM8v29SJDvI7rHsFMpwwxwXgsSGayehXPLh8
 wrpiLJ1inOmaeYYEjiDDxo9ttACXJlY0IothTdtrcuc0EgmzmURxeAAQ1PUf4Y10
 Ki8GnDioG98bAgEeIJ8d5qSowi7VrLrW7NpwuGs/wAPul4wU5qZXSsmPKTZYhret
 88z2wzWgAcDIxxr/01I6Y7MoqekajN1b+0KTbOeSYxfMT4Pp9Nndy0dTvqSyy2Wl
 bXA+nmHT1iMRgeTBJqdSf5Tyt24C9XmdZ9QkTv91Eq0DQSwLRvR3y4AfZvXx9yyt
 A2KlJQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjcbmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:03 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990aa76e3daso238065241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769522; x=1793374322;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+sknUJlIhDoCeuqBNgo9s/xQHtpRESuIUEkzFP4EMH8=;
 b=Yb6THiVTJ2BZ1nnoZg+V5RWbcvnOZeikM3Gyhv3JdiPVU+oT6JzvS07HJ7KUD+h5Rs
 YnqG5aUTH8rln2hIhhaqt+xtrkZEwQs7mhYU5/Wbei0T1eaoEhRyr0fblcS3QqBlWGma
 eTlWMadSHTP29vAkRDLjogb8RSo/xMbNgutpwnolm1PbI8+/TNS1nmFTx2/wEwlLj6cK
 PZ2cZyzAz9y9nVw1zSnMwLF9/mg+l65+wnFn3LJBFVNRJk6oeqaNvOgnR0Fe7SHa4LlF
 e0VklXjkcq2hccV3Z6xr6zrbqLkj7oafHO6aH/qPNcDdREEYdlQT0xpTWhELeUZOV43e
 vgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769522; x=1793374322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sknUJlIhDoCeuqBNgo9s/xQHtpRESuIUEkzFP4EMH8=;
 b=G7RsmLDhJgGDWLUuycQdW9rArMbCG+So6sHjxaQ/po+Yk222dHTZIAPqv0UC8iqH+l
 Nr4+iR+onph/ZROhgBtaVDWphzsZuAp877WgriruWu1dDxK70pYZ9h1eOde0TcRi0Gx3
 GzJkcGO56tsqtC0UfOrsrvLePMqXHi0CwKseUsALUnQd89wGVlB52hOz+YIxEUvG2els
 HxBeCTASDqXqMUD+ViSk8OMLiNmxWuqIyIocBekPdTpX7F7JKgpOsPzdFjhn5nKkYWrZ
 VSHzd6acGjeJpNOC4sVK3w52/dEcIS+UfCU56xJrzM69CMDWKwsLHsNWOmp9OJPtT0D+
 ioig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNrAsQGKt8flTPU+DmzcYNDUKrvVCXauy3fDvDIlXaDVeDHln2gw1zMwxYGfOcqicyChFh9EwdddY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLODbFHC+x5uiPBYP7Lcc3RSFnsjk08GqDugE66q3at83QjEtpp
 BCYstxPYHRLtYtjT/ZDzU0dCLJhkMyGd2asJFDxqw46CtxvG86lnMQ345dFRpNo7iQNBHpdWzUo
 FN8j5PZ+4MHJKLY3USlXUW86tQelmpar3j3XzfGQHGoS2RnHqyCPiblBZLEikr4VC2XKNpOo=
X-Gm-Gg: AYBFou3rsTWLiLH43/k0FngRFdEnO9j3BWiPfAZQ5wR/iZkHAyandun99ao+a5aBaoe
 nrxzXhD7TAuhvqUKaJ22MvNp/DuQwvmcV8We4tMbGmKYVPThbY35fLZZ8+45wLmrrUbbTqtNPOy
 D0/el0sHuKcpfnYJ18xTHw38bfTvxMyTFqx6uWFZ6GlD6OyuVlSGx46ktH5wl1E+osHGuqOg+zX
 EWTDsIkRrFf7iMYcPvfRuz7XCh6PPI3yBY5MKXen56OVtjUdcLSOc3d3o8pkSwmZ3//dTAkE+DN
 bV4gfbsYt6nAtxe8L9lVeXiYbWGknqOS8FDlXkRoOPCDgdQNc3ztSI6ksPliZ7Njyy0T4PyzXAW
 VavoqpkLpPZawQnMHSzQZEy+2fDOTq4CFtgyUbGzouBo239r81JlAVJk9H5FaaVAp1XhptIaulJ
 JkM6/9ts1/I0IM
X-Received: by 2002:a05:6102:3e8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7ccc343d2cfmr938873137.31.1792769522263; 
 Fri, 23 Oct 2026 08:32:02 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7ccc343d2cfmr938856137.31.1792769521788; 
 Fri, 23 Oct 2026 08:32:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:32:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:25 +0300
Subject: [PATCH v2 10/14] drm/msm: tear down only a successfully
 initialised KMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-10-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4509;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PAN630EnSzX3BheqdkticFypvYZfbOBPCaMWsVhZcGc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233YrOmxPRIDaXhST+Pt2z1sgFp7f5ZUnmoOE
 2KHOhxQI3mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt92AAKCRCLPIo+Aiko
 1XfaB/9PXSyiHdQxAHGqMgIcu1/9M+kv33GQSfsgOzkyKmv7UpdDp4EPbB1FzJgApgHUSp2PsaV
 Q8nElS8UWPqzWBjluph371P4W21eRpaSiVVjIeKw9KLGgtJ0zIziUKXmBDwBq854Yrxb5zjZ+pJ
 KGWxC+pvA5c1WlAVgGSudxS6mLCwVvHZaEyWT1jG7mdGJ44MzV+mHV2lZk4icUIivJ5cdpX72lL
 +YDQ9nAkF05KIaObCxqhwVN3NciYYnzEauaB+p5YpgPppmxTadMIrGFJ8VQlyf6aMhgsDS1lEG4
 Yfgvwd2rsD12ZVcu6ETNYjNZSQsldlCP5ekB3kFcuaOcnRb/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: F0udCxYN7xNvjeOLqoTEn3Nox5RDld9Z
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7df3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mlEQwpWygrYFFZNu1HYA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX9v0p5IZeM57P
 V6uYwwGDXaFLr999D7QR1x+cGPvqJTZadLbk94bDBwIIolre2qBx1IofqbcuAAbor0ZV5Noj1uL
 EU+NJPpVu3ilePS4Ai4//OpKq44u16Y=
X-Proofpoint-ORIG-GUID: F0udCxYN7xNvjeOLqoTEn3Nox5RDld9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX/negmzJ68P80
 oba//YQoVDE6i0Q8vwi+z44/o2SMr2mu4D4R8YaM8ryh407YIX5KkoMkPZD7yDUokw2aEwOPj+L
 3cfvex5OGG0/eX5J+FX/IgxZKKKCebbQzPKqWy4pthcGx4dV+frB8Yy3xWWTpERhcVgxRHcwT3I
 tKzIs6jtarr17o1hBohQiwUOrSGfYR88a4yKIGZ/YVMXxTt5R6wg39OxD298x7/DpDb/Y2TA6hc
 2ayf1Len52fSJfqBHlGm1r1Z12aLNM0athAnWd+peI5q4l0HDtKpUZRgtDfPMvb+w1f7MXGmfz5
 EG5UfkCR/YovOeO9vt95kE9XzLilHfz8UbOHJhLrkDuhrJZ3FTTZKQp86wmkKiqQmnEUXXRpBXj
 WMyJZX5CBQZaZ5ehOWxJrCzTq6rlJUXiP+NbHuVjtOlE7N28EKxLaN91Vnr8p2NVx4fp7YmHkSo
 xdcidaVI3TzXmQEgOAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

All the kms drivers now undo their own failures in kms_init() and have
folded their hardware setup into it.

Drop ->hw_init(), call ->destroy() only for a KMS which was initialised
successfully, and remove the flag which let the drivers opt in to that
one at a time, as well as the handling of a half torn down KMS in
msm_kms_destroy().

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  2 --
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  1 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  2 --
 drivers/gpu/drm/msm/msm_kms.c            | 16 ++--------------
 drivers/gpu/drm/msm/msm_kms.h            | 10 ++--------
 5 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 255beb83fc94..65ba8fa697e9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1290,8 +1290,6 @@ static int dpu_kms_init(struct drm_device *ddev)
 	int ret = 0;
 	unsigned long max_freq = ULONG_MAX;
 
-	dpu_kms->base.init_unwinds = true;
-
 	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
 	if (!IS_ERR(opp))
 		dev_pm_opp_put(opp);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index cc6f202aa011..b6615427cebd 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -395,7 +395,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	/* TODO: Chips that aren't apq8064 have a 200 Mhz max_clk */
 	max_clk = 266667000;
 
-	kms->init_unwinds = true;
 	mdp4_kms->dev = dev;
 
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 30af8ef51e4c..c349eedd55a6 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -505,8 +505,6 @@ static int mdp5_kms_init(struct drm_device *dev)
 	struct drm_gpuvm *vm;
 	int i, ret;
 
-	kms->init_unwinds = true;
-
 	ret = mdp5_init(to_platform_device(dev->dev), dev);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e4d61935a6df..9a207c1e8583 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -293,17 +293,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		if (kms->init_unwinds)
-			goto err_destroy_snapshot;
-		goto err_destroy_kms;
-	}
-
-	if (kms->funcs->hw_init) {
-		ret = kms->funcs->hw_init(kms);
-		if (ret) {
-			DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
-			goto err_destroy_kms;
-		}
+		goto err_destroy_snapshot;
 	}
 
 	drm_helper_move_panel_connectors_to_head(ddev);
@@ -347,9 +337,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 
 err_destroy_event_threads:
 	msm_drm_kms_destroy_event_threads(kms);
-err_destroy_kms:
-	if (kms->funcs)
-		kms->funcs->destroy(kms);
+	kms->funcs->destroy(kms);
 err_destroy_snapshot:
 	msm_disp_snapshot_destroy(ddev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 2f097e23e2e9..b5e1cd38cd8a 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -23,8 +23,6 @@
  * for constructing the appropriate planes/crtcs/encoders/connectors.
  */
 struct msm_kms_funcs {
-	/* hw initialization: */
-	int (*hw_init)(struct msm_kms *kms);
 	/* irq handling: */
 	void (*irq_preinstall)(struct msm_kms *kms);
 	int (*irq_postinstall)(struct msm_kms *kms);
@@ -149,9 +147,6 @@ struct msm_kms {
 	int irq;
 	bool irq_requested;
 
-	/* set by the kms drivers whose kms_init() undoes its own failures */
-	bool init_unwinds;
-
 	/* rate limit the snapshot capture to once per attach */
 	atomic_t fault_snapshot_capture;
 
@@ -214,9 +209,8 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
-	/* the kms drivers' ->destroy() also runs after a failed init */
-	if (kms->wq)
-		destroy_workqueue(kms->wq);
+	destroy_workqueue(kms->wq);
+	kms->wq = NULL;
 }
 
 #define for_each_crtc_mask(dev, crtc, crtc_mask) \

-- 
2.47.3

