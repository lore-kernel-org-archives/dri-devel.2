Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A64606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jFUcnRwx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MU8OI7eT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E725112D33;
	Fri, 27 Nov 2026 19:45:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6806810E622
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRGJ02668916
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ekADTNsGBXddQN7XdChV33/pXH1c+6xXo7T+C+WpM8s=; b=jFUcnRwxj3UDWVp2
 cYiUDO4PyRw9CsG8xYDDvpUA98ZBPcVDYO0gzQUBsgo5c34qKeE7r6Sp1W5Yb6SM
 nFgCOI7YAP+C8EbEqkbarcxO6ysdqOz91MbMk2K2Ao0rwqPO5l3TRzWK0xJx0j+g
 TjGGX/2ihYW8A8XF33YhSbeA55U/lExbsuV9yMyGKbBTc12a6osf4d4LVBy2X0N2
 WD/EqacNx+YW5q4oA+YffhcOB0tLKNTvt9UtJAukkxARAc9XdSq79mbsRN0gQRoG
 ZkBvTCzUY6j4b7s0yykiSFc6ywM1jV18BNt+d7K9inVjBj3vkh4d7F/gd5oo0wHF
 R9hEPw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg1cj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so1607629485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808705; x=1796413505;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ekADTNsGBXddQN7XdChV33/pXH1c+6xXo7T+C+WpM8s=;
 b=MU8OI7eTgAZG/yT3D2WZbCazdw0Mc3UgVRX4q3AxL7vYqgygESUMRvYWIJYJ6k32R0
 UnyQcFelohqC+pmpwj9dyn4qkgGcQu4DBCZgAN3Z3HiIG8Qih+83AprbXIWsGVWP9271
 yWzKgYQK9lOpH/allmGXytkAr0UpMRQsOhfDx9Qyh8LVBo5GQWtJrZY59D6TmZlsb17s
 hmc4YO71nAcuLJObe8CB+IOv0StEm65ihE+h1b/6Tx0Km7S9oozWTGQIze3Ues5+YZwZ
 46nexA/+DcCtATwXxb9AYdVyGf7XSWDXEYxhVDI96l3bHPqetRdCJELl0L8F4YQsJ2kV
 jz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808705; x=1796413505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekADTNsGBXddQN7XdChV33/pXH1c+6xXo7T+C+WpM8s=;
 b=OMhUqUpqqJ3XHu2HCeB25ZTgeydZK8hqJMAu9wmDLFCeZXhqR1KVBmtiPDhRJy8F5M
 8e48Ac+eH3oBn+A4HY3SKgGfQDgj6qx1bpAuS7avYoguLA3RUZWgJ85Ph8Hn3jsl87WQ
 q+POUR6o1FlmGcbhUMXzCrOgOlJA/mNkCU0N3ZdRkBiMRS0/upyugAbbN8KTXmUWjAtH
 gmcDXXOeC6Rl0gvXry0SLzdRZQSEUg4d3xrlKXLuEf4rBHOKylark3MRXAQYhXRRTTXq
 jbn1lfYR4PXhb7jxa8DqhpNaW1amGTAx0IsgEm1+BRJwx9Qug6hKf0uWrZQyHqlP0EX1
 gsOg==
X-Forwarded-Encrypted: i=1;
 AL+hErEQ8eiLD11a1spT6+fdcSsWE0CY1IqMi3JNDNn4cAROw12Ish8wDFquIfxOPhsv8HjHdrwm/nP7bKc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/rrF3+sqjYxNIwd8/BKwd2gLa7+0G+h19uiwfNR9Ox3iVKciLp
 mdoaMDcM7apnIS0gJ4PhOKg4cb1zJmc14d209WXq7ncZ+9ZWOcDV8n+G/FLXQP2DGviCI8NoJlz
 hFV4Iytdfp+40nY9tj7wHQnXyifOVDSccAY1ARum0ggcoP/FjqcZ2sYgkhV1fvNez1jAYhTI=
X-Gm-Gg: AZFdTZcv+KAQYjzhw7KSTVHAeyh9fMk6ibsQNMPqZKrZPnpeg0wkggKcuXkCEMbVonT
 hK9XZouHA494Mqb/pqMk06wS79AHxt4mfUjP3eeNYos7QLDxDA17Vu3HO6e0ssvBzyhoTk6BKOO
 yrfTE5lZkfUvDKVVEFIjVsbFJKLvxgYj8qVmLai3DKhh/zArJrn3PcFStouhGqgFQnphzrqg0WJ
 B/1drWw5HUsBjk7fLmKv7/tUccR8gYndxJ2q0bUrQzYpPIRcR+KCeoBwc7JwcXK6jRgV8tyQ9da
 YOmHQZpbSqhJiRvR1HumYPrCsuuVpwj/h6rBI/7nl4JoSDAoPIS5ypP6mmo3jBCNG7JujpOoblX
 kJqJB2CsAZDc/JkT10pf4qHR7LDlEmbXkqIDI59/rJwZncfXOC6GPQZwmyFF7ziSzzgbsBb2SKi
 gROGLfCtVtsPy8x1RWMh9i02KeUpxYImmAyydPivugYYKdKwa6L4FtarmaJLZPcQ==
X-Received: by 2002:a05:620a:2856:b0:93b:d7a1:ba16 with SMTP id
 af79cd13be357-949bab28427mr4818614785a.65.1795808704744; 
 Fri, 27 Nov 2026 11:45:04 -0800 (PST)
X-Received: by 2002:a05:620a:2856:b0:93b:d7a1:ba16 with SMTP id
 af79cd13be357-949bab28427mr4818609885a.65.1795808704301; 
 Fri, 27 Nov 2026 11:45:04 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:20 +0200
Subject: [PATCH v4 07/14] drm/msm/mdp5: unwind a failed mdp5_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-7-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4371;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TwRmZcwZxmtcoSpUxQRG0/tQN2vHRVpxkXVxOYQdep8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2g83wxS45mEF+GFA4n2REdL0v6dascALSSD
 UQsGStjqnWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndoAAKCRCLPIo+Aiko
 1Sy5B/4nsR8V///tktw3GGSW1RIOKe3FZ7X2WwFGdZbpabyoNQmgGJCCHOmKhueL8IXxqoMfmxp
 7Thx7DkXurmF4/l3Uwokinzs8Rges3aa1K7yDgcXo2gvzRWk17CRd46Mwl571D7o5E7Zsyc5vwt
 Mp+VUyK7kIwhHJ56qbUBg+2SfJiTq/dNUKNEfdEUZuESnUwq5qKkaj0nxoPtLrC31zfWnVvr2HB
 5m1O/2nEw6D+nsiyILgDcFllmgYKSyZ9UdpGGCevAKxpn7+FuXl/Igw4JOvCV0inbmJ2zZAyKkH
 pr8lDoP9AjEmQI/LnrGICZEL9PRccadLRkb3PJgfpaXL9oJA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX8084U2rNQynL
 MAhvOyLAqJ3UMPHZfAfWQVZ3h7S/dKE25ri5alyDK2V0BBZ8JfIGP73NbfXKBeI6L/ZoGeoYIUV
 ZUK2vgav6rUCDyRI0li42+z4iEynirAoCrZGVmSwLHrc/CHWgqJxnAGybiYr5NPHlqy98JvPFYF
 UGOb2z6ojBYblcIx/F0izbSKihgiaMxIAOSShXainKAbuo0bhNsizhYwr6LhJXZM07k7oBBBC1w
 3iLvoraFvTCNkafZVdSvF0knb/iwX9r+1DHHL4RIzO3nrtE3/M0PFk1Ir4gU+xm0+vJgxGsnXbP
 6Giy3Vg3lcr5wWdOiDKulae2FtgM8Ky1p0WZLciv76mjGHB6mJNQeQmD7fiVmaBxwd8qw6PGhnY
 RbuBZynuPIwRhWNn6wUccNqwgTOcA56oces2djAdLl739SlW5dJMVqoTM1CWqbhMPKheter3nph
 CGCTzSiJHhZmxmEzhow==
X-Proofpoint-ORIG-GUID: tN0zZUrz19lYo9TOK8v-djMIINlUUfEs
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09ddc1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=MU5U8ZpPrSxGNErEH5sA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tN0zZUrz19lYo9TOK8v-djMIINlUUfEs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX5nmOFxRaXm2P
 0VRSR0GpHMNDzBxkasLWgdN0HNwwkrFHfKWdzzCx/6+BotKtiLmbj7RhMyH1iJlYVwMRf3j3bIV
 WqPbPfmBkBM9ZehjizOrQmy1Zkc1xdc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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

mdp5_kms_init() returns straight away when one of its later steps fails,
leaving behind the kms, the runtime PM reference taken around the address
space setup and the address space itself, and lets the ->destroy()
callback, which the caller runs afterwards, clean up. When mdp5_init()
fails, however, it has already run mdp5_destroy() itself, and ->destroy()
runs it a second time: the global state object is finalised twice.

Undo the steps which have completed, in the reverse order, drop the
runtime PM reference on the error path as well, and tell the caller not
to run ->destroy() after a failed init. Fold the hardware setup, which
can't fail, into mdp5_kms_init().

Fixes: 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic object")
Assisted-by: LLM
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 45 ++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 085c23820f46..30af8ef51e4c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -19,9 +19,8 @@
 #include "msm_mmu.h"
 #include "mdp5_kms.h"
 
-static int mdp5_hw_init(struct msm_kms *kms)
+static void mdp5_hw_init(struct mdp5_kms *mdp5_kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 	struct device *dev = &mdp5_kms->pdev->dev;
 	unsigned long flags;
 
@@ -58,8 +57,6 @@ static int mdp5_hw_init(struct msm_kms *kms)
 	mdp5_ctlm_hw_reset(mdp5_kms->ctlm);
 
 	pm_runtime_put_sync(dev);
-
-	return 0;
 }
 
 /* Global/shared object state funcs */
@@ -198,24 +195,26 @@ static void mdp5_complete_commit(struct msm_kms *kms, unsigned crtc_mask)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms);
 
-static void mdp5_kms_destroy(struct msm_kms *kms)
+static void mdp5_kms_destroy_vm(struct msm_kms *kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
 
-	if (kms->vm) {
-		struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+	kms->vm = NULL;
+}
 
-		mmu->funcs->detach(mmu);
-		drm_gpuvm_put(kms->vm);
-	}
+static void mdp5_kms_destroy(struct msm_kms *kms)
+{
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 
+	mdp5_kms_destroy_vm(kms);
 	mdp_kms_destroy(&mdp5_kms->base);
 	mdp5_destroy(mdp5_kms);
 }
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp5_hw_init,
 		.irq_preinstall  = mdp5_irq_preinstall,
 		.irq_postinstall = mdp5_irq_postinstall,
 		.irq_uninstall   = mdp5_irq_uninstall,
@@ -506,6 +505,8 @@ static int mdp5_kms_init(struct drm_device *dev)
 	struct drm_gpuvm *vm;
 	int i, ret;
 
+	kms->init_unwinds = true;
+
 	ret = mdp5_init(to_platform_device(dev->dev), dev);
 	if (ret)
 		return ret;
@@ -517,7 +518,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp5_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "failed to init kms\n");
-		return ret;
+		goto err_mdp5_destroy;
 	}
 
 	config = mdp5_cfg_get_config(mdp5_kms->cfg);
@@ -538,19 +539,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	mdelay(16);
 
 	vm = msm_kms_init_vm(mdp5_kms->dev, pdev->dev.parent);
+	pm_runtime_put_sync(&pdev->dev);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_kms_destroy;
 	}
 
 	kms->vm = vm;
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	ret = modeset_init(mdp5_kms);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -561,7 +561,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	dev->max_vblank_count = 0; /* max_vblank_count is set on each CRTC */
 	dev->vblank_disable_immediate = true;
 
+	mdp5_hw_init(mdp5_kms);
+
 	return 0;
+
+err_destroy_vm:
+	mdp5_kms_destroy_vm(kms);
+err_kms_destroy:
+	mdp_kms_destroy(&mdp5_kms->base);
+err_mdp5_destroy:
+	mdp5_destroy(mdp5_kms);
+
+	return ret;
 }
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)

-- 
2.47.3

