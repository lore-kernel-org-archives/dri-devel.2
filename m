Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57E606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JTXsWQCy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gkAzylZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAF7112BCB;
	Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C1B10E697
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7KqQ3002685
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=; b=JTXsWQCyYfxqy0BP
 Hd2gQwsaeH5HirwE8Q8VIuQniTq4DRwu5oUAVjJywJqeO9lraCsLGKDUNPSS3+5r
 idAwe2g7/mjLdInYTQlV+Oq0A2D7E1o8Y0ebXjI6MkyqDBzAmYKs382KN+ytXR0/
 yBMSFBkpQU0wR8RjFgtcis2TfF8bsoBlnHl6ZquBNdfDFH9gh7qBYFvWFI9AJmaF
 9yZdac3MighhB5InRhFuyXKtioP9Sa6D0fZZ2kRNvtzfsrWjdcldPkZpdKJ/XJLu
 qtmuXF4HWxSTW6CiFz43XEpszZ4lh3QGgUMUTg9zrjvRpH67rZseIQdrC15kBSxs
 aINCMg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0q5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:01 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc06b9cb33so171686137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769521; x=1793374321;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=gkAzylZgd071jFlhDcRZDZjRRzqjhPmN/0w8S/jnfLlRp6kpyfjObvrqtndpcYAA4u
 MbwuNYLR7IPHKnQL2i3xb83fnRPHONTnJJ2C/Nn84K6nK7wNLHz348S3AIWnfwJXr0Pt
 Xtsm1W8Glc9exFrUedcgJO6DSS0O9ht+UuFOP61XmH6uVInZNJBcS4eYcB0uQWSlZxvz
 IKmR7KbCPBVeuJugmMZfYL07YEuopgweAYlegQH3eTKmFQAI9ZiEWeiz2NpykbA+WgpC
 9mrki/oLHZ526gaUcmt3A+P6f41TpGuWdiy3fzN9SlgKiq614KBN1jd6zPFcdGKQ5Z8l
 TcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769521; x=1793374321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=eqoc+yBZ+mUCnoLpphL7AnG0ZufEJA8JANcv9D/dzgZLKmfI1hPLvSy2FqcgurbszQ
 I+vVqUGCAazw80yOCAQInqg6zdLz+1PZeUTFoX4ABEJMXQD676j8lWtmt8QUId4GHCou
 nDc8b8F7q7y6I+9/x5K79liEEMthFpuS4cgGhuzkxbVNn33mDsKddRpAJ3nnW3RWViYL
 V+gtF18OioBLQFnEve6Uc0YltqZAo9fkKNxz9VEdYwMEqbkOS3V8PHhtMl59cH/vOVYD
 WFHk27cQYts+QMzVDQ83eBHbJeQAAZJOmR6deM6aS9+RudiPhq8yrKpTXcyb2Zgc8AYd
 TDHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmzwhH4pEFtSNVAc4aVN7TeNWTRif7frkb2r/FNjCb10ULMLmfOFZ8rgPn6MkjipN0GV0nK2R0XTk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6i+4DQumlkzlsV+mu4dmJi0nObb5ilqoIhmGCyZAeYCQBMB2g
 U3385Ye4ISnmZX4kyOqbm2uNhYbFnMJUgFWEW9/Id0pngBdh08sAsYNrSacFUI/TkSCX5H4WIB9
 aKO/e7Nr+VRwyCFc2OcnkbzxyTyaRvuAszNDtChcIu4tzN8DY5H6jItO4X8RLgBzLWCq0w7k=
X-Gm-Gg: AYBFou3GQvUMhA6IWSQAlfCb8t+srcz7aO5HBE9qMMJ1PgNVfD1UvLb+IEd+jEbCtvH
 zVZS9kIhzJsQPSlOKNQqUv8T21wCngdbuMlW//p2zQJaLwCFqWQ8apTixY+WQ8tvzAGKwdGIlvH
 N7h1GlUFiN55I1YlbzFU5YBOpH3VgvL+9r+EACVNyFQfmUv6Hp7sVAUOEJdVoJy92yW/sVvPdSK
 tl4zt+7or3h+GLyJFonlFxCDW/Da2xu6SXenAnXCnhCAJepM3CaLI3SPKcu48DD4aIwWa2eR8WK
 mpIOE8PV4wr7gpC6FZlhe/rufYfL4/8xb1R8RRVBifDSK4eLgjrJyocFwF1LBRb/J6Zk98Le13/
 CBxqQFN4XGtdozFaZW757KsLeSGn6Ian3WgmFWQA/VJRxiX1QqXumGi8wCG7xJI5JrAQ7zdZ3bC
 /jXKJJXipBHBYT
X-Received: by 2002:a05:6102:c54:b0:7cc:2c29:54f0 with SMTP id
 ada2fe7eead31-7ccc300d074mr855764137.4.1792769520950; 
 Fri, 23 Oct 2026 08:32:00 -0700 (PDT)
X-Received: by 2002:a05:6102:c54:b0:7cc:2c29:54f0 with SMTP id
 ada2fe7eead31-7ccc300d074mr855736137.4.1792769520451; 
 Fri, 23 Oct 2026 08:32:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:24 +0300
Subject: [PATCH v2 09/14] drm/msm/dpu: don't tear down a failed hw_init twice
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-9-83727c122de7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2tPDXcEAQdfx+uOZ+i3gT4JR+STW+/Lz2xQF5BcD1Wc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233XBTSWsE53xutitq/OEOQAia7nweiTo0Qsm
 uWw6zou+MeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt91wAKCRCLPIo+Aiko
 1Sh6B/4pDgiRwSuUDdbhfYHChub9ldhWqn5cna/i0xrfiRlJEk4bnMSlnH74c+LBXS5nZ+nu2mn
 +fIbeXycqw5dEn8NJ9Kr5MaT4VRK+qH3akiOu5sQSxY6Jolyv3hANfy8yrRiu7yRJ9Ez5Bz/Rmf
 6HKqyMjQzKLwWn5KvxH3lO/jewUNXRmK+ztLjzHTHUGJZfsfr82xX8rw2G1i56nOlVuGXqnvZZj
 LXznOvZvlj0tF9NFuIxVumMwps5EAOebdfvsoPdGyAZiQfxqdfBei6V4+7QqdjaC8P+W+FIcPWl
 afcfpNkcKdWfBTLCj30ZmgUlD9Ln/1dO/cSvOGITJeWJNPqZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX6L5PMexs95st
 aIrHkZsAv8Xt2F6pmF3xvBsatle9OIe0af3OBaedYF5BqORfA/DxBivSiPVGb8OMLSJXQyrRlfJ
 3opajdShUukZ7h6M0iaP6twYH/J0y3anL20JwNmX0F25r7xwDM4AY+d0G3uieSDgW/wyx42/Hcx
 I87Dke+9axuV4PqsdAdPjkMZyj1gArGA6qmvZaZk25FyGw+cSqPW0Qvhw4at3v7054OYKneeWtq
 o1G8jWqVFoIvtXduKT3ujqR4Jf6acrrT3SluMVhGv//Tg+Smcn9ep+2Sw4/cKU1YhL4iDlc065I
 Eh9IGq5AZ+uQczBd7+E34mhAM5fNfnbJ3eIGh4fjuPP6ntuhN85ZtPKMofSxB1owLq3JfWkJcaN
 KWWn6AU5kqIcaQmYIlTLJ3Rh51rHYi7zVEil3EG6/iuROCUvN+0dEYilkaxxNDoNN+Vuw4jCq2I
 ytBAOUTq4OQyg2RXV3w==
X-Proofpoint-GUID: Zp9StPB3HlpIMxab0gDuGIaiTx_RVzwy
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb7df1 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VuwbfrIzBJgoMi6EY_8A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: Zp9StPB3HlpIMxab0gDuGIaiTx_RVzwy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX2VvkiE4HpB5p
 wGA3FDYoJMcS31qricfIKFx96pDrCoS1NkGANiv4b7P8A1jhzSAx8fFawUBpvhQ8iOLBN1qKCmd
 fE2ekSDj/hpWklmQZW/EK1qNt+F0nk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230060
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

When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy() itself, and
the caller then runs the ->destroy() callback, which calls
_dpu_kms_hw_destroy() a second time. Since the global state object is
finalised there, the second call deletes its list entry again and frees
its state twice.

Fold the hardware setup into dpu_kms_init(), undo the steps of
dpu_kms_init() when it fails, and tell the caller not to run ->destroy()
after a failed init.

Fixes: 49e27d3c9cd6 ("drm/msm/dpu: finalise global state object")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..255beb83fc94 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -55,7 +55,6 @@
 bool dpu_use_virtual_planes = true;
 module_param(dpu_use_virtual_planes, bool, 0);
 
-static int dpu_kms_hw_init(struct msm_kms *kms);
 static void _dpu_kms_mmu_destroy(struct dpu_kms *dpu_kms);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1067,7 +1066,6 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 }
 
 static const struct msm_kms_funcs kms_funcs = {
-	.hw_init         = dpu_kms_hw_init,
 	.irq_preinstall  = dpu_core_irq_preinstall,
 	.irq_postinstall = dpu_irq_postinstall,
 	.irq_uninstall   = dpu_core_irq_uninstall,
@@ -1135,21 +1133,12 @@ unsigned long dpu_kms_get_clk_rate(struct dpu_kms *dpu_kms, char *clock_name)
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-static int dpu_kms_hw_init(struct msm_kms *kms)
+static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 {
-	struct dpu_kms *dpu_kms;
-	struct drm_device *dev;
-	int rc = -EINVAL;
+	struct drm_device *dev = dpu_kms->dev;
 	unsigned long max_core_clk_rate;
 	u32 core_rev;
-
-	if (!kms) {
-		DPU_ERROR("invalid kms\n");
-		return rc;
-	}
-
-	dpu_kms = to_dpu_kms(kms);
-	dev = dpu_kms->dev;
+	int rc;
 
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
@@ -1301,6 +1290,8 @@ static int dpu_kms_init(struct drm_device *ddev)
 	int ret = 0;
 	unsigned long max_freq = ULONG_MAX;
 
+	dpu_kms->base.init_unwinds = true;
+
 	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
 	if (!IS_ERR(opp))
 		dev_pm_opp_put(opp);
@@ -1317,7 +1308,17 @@ static int dpu_kms_init(struct drm_device *ddev)
 	pm_runtime_enable(&pdev->dev);
 	dpu_kms->rpm_enabled = true;
 
+	ret = dpu_kms_hw_init(dpu_kms);
+	if (ret)
+		goto err_disable_rpm;
+
 	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+	msm_kms_destroy(&dpu_kms->base);
+
+	return ret;
 }
 
 static int dpu_kms_mmap_mdp5(struct dpu_kms *dpu_kms)

-- 
2.47.3

