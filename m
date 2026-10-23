Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67604606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OENizIr0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LPSP88ET
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4CC112D37;
	Fri, 23 Oct 2026 23:20:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBBF10E723
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLuwI42495556
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=; b=OENizIr0fGMDYU/b
 TkxjhlcpNOaEk2pBaYqQzzUy/5xFQNzmmXS1rlV9RbeyXSke3rm6KiGakJAppvlj
 ioeFR7Fv4SqusEuXP22lM2ERIgMr9YIRkgrlBGwtyrih9Br6V8bLdRhPhQBfa8/1
 /WudqBlWKw5n6XSdgNpxgUYpZ4/agKzjbt4SC+fdFsZHyFMLQIU70c4YhfMk75Ok
 ykaCVn/zQdhY77kC2DCh7cczl/Rgjd5GQd/SDe+gYY80pq2BCtyghOaCCI0HPnSU
 vF7cHz1mxhHDpSC04XRBKKzZAsxDeg2w/bGl0KesoJm/mV6+m+s0n8Goxvj5fEqy
 OY7zOg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr08vck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so234007285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797626; x=1793402426;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=LPSP88ETPaZjYUYs/UWtbqTqrfM33a3czKpjWb/dW4lHmqHCg+/sk7pCI+2iJE9RNp
 bWiySaAdyaHVh/xoAcArZ5aRKXG7+LWSwHucd7Qg2UtlIgbkX2rZ3nnqJv2JXBCwn4cJ
 +eok8vqs6CoU3wi7QzAjhDvS9a1zBBd154S8QDwVKyot2zzNkN5PvrUie/vLGhJTAW7C
 S90sWC52zp95PZOW1OUN4Z5p19YN15xtFqQLfV3eNDrEgc8y6A3D760QoNIygUhFaUg7
 ldxCb9pjZJZvwVmtqj7hRe6A1zU2r9QCawVaQ9hLXn2f08xTvCkucZpvrZg5wb4b0wvl
 VPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797626; x=1793402426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaqajoRcBElyuICZhCmUKXN7s8u9DKYWFfzft5nFEDw=;
 b=mW5jQmNY8ZWjTNBAbdT55PIOe/kYR2wHmscbX17J4N+MFGcOAnfsI3InTxj6CzT5H2
 fATz/qxAQKyG4HZkK4W03l3+Tihc4s28Mzhe40v4/a3qdU5dl0+rx4lKG2RMfqPO5ict
 bo4f6S+3/aXCePSD/HDfDANGuzTJVHo2/D2fDIry/6o7d4WZIbv0JT20zt2NDaXdympt
 jvSXQFZSAFMcejToz6v675ia6mP0Hb2AlbvcfnghE93H389YJGJqMmTfTwaTaY8xpHvo
 8EzU3qA8gQ508k8r1+BQWuS3ONtJtG/xa5Nt1h2n8LfSgHYOhSc1fCWHQS7Iy+RqPutv
 MDOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBww1teOxm3jrIyu4Eo8RSDtlv4k0gARDt57su9eN3fpIPfRPsnRXkScV3Vi+FVJGnXrHDuPl7T4b1A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHQ+ysTuWv48wV5gA7nq6fxUoMkGQaD1wd5gXZRC0Fu6B+EbzQ
 qggOPRf+F/XzMpjPmVQQDEZkDKPAJnbqJnNF5V3E3ioXORYdI/kx61LFfNOM2av0fva4zFjverg
 bRjoY3hdtkixhLVXocLRLJaqlTqL9ETLb49d/wZBRpkdzeWCPJrkJyPOYQRbUJW0vjJslm98=
X-Gm-Gg: AYBFou1mck0YN2ApP6Vmi8vJzc9T6OShhbkurq0YXe0lEoKQwIB4TfY8roHi+uPSrUt
 aP4kBQ7Kv8giJIeT2YTxxG2p9erQZzO5HtaflBykIva7dKFktOxaLxFube0k0lQP5QAIvmy9gEf
 212EqSBIhuHTh7ElPAPY5DTraUbYWH2UsJvjANmdbDNjoCyeWc5utQG2eQbk+PCdoYacAVC8itZ
 HBnkn3ptJUBAyHinnbQ7rnSZ7R+nsE5wfcmWjDPKEL1V6FCodDVqNEmtzut4CsfBbVFghgjJiPR
 +TNwJDCdESWFxAITT9z3u8T1FQst22QV6GmMsAwN9LFJx69xs2dC9fdf8IZVXUoUglGN23w30r/
 Zb5o6kvp2PDlnFAmORm2Q21anQOMzm18d+1Dzj+Ln2oZFwcT1ZF2WWRXPYGSmc5LAY9PnjOl9oM
 5qqo/w6ReUMeJz
X-Received: by 2002:a05:620a:1a13:b0:93f:3d2e:6bdc with SMTP id
 af79cd13be357-940ef914dbemr88637385a.16.1792797625957; 
 Fri, 23 Oct 2026 16:20:25 -0700 (PDT)
X-Received: by 2002:a05:620a:1a13:b0:93f:3d2e:6bdc with SMTP id
 af79cd13be357-940ef914dbemr88633985a.16.1792797625436; 
 Fri, 23 Oct 2026 16:20:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:42 +0300
Subject: [PATCH v3 09/14] drm/msm/dpu: don't tear down a failed hw_init twice
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-9-66a30120a5ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2tPDXcEAQdfx+uOZ+i3gT4JR+STW+/Lz2xQF5BcD1Wc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uUHPTIKtGo7CKHpbbn4VefkDvy0Hl+yHV5g
 i0gJoZcksKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrlAAKCRCLPIo+Aiko
 1RbCB/sGIy2KMeo5ebduC/X3dqd8P6TXBzKZ0mL6umDRUbH7TyjjlQp+MJHi2u8iz7b54bxHr8E
 z+V2WGXyBPMWpVgRnhjvmuXhjJWlx0MoJQm3Fy0S0ehpGa7/rZ/CxLI65BfrHoLLyX5LX1PsLg+
 ybY4df1UD1m0BMQbMOR9OykLmeG193LzRuzJ6sPoqgyTcS53Hwg2gX1DeATKG14Chs9Vp8MmfyJ
 GrZeNTus0EoIfFa4QuiAHYFsILIlQk3+qC3N8BP2KNneNUol2YwmSJgHRPE1si1JZSJFMMMMbv1
 xTxXa0qOXtScKTRNt8/kY0LAPDgR6vWrLTXI9t7gQJy+6a3V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: GfxWAu3H4jv7LdbRaha0FVB_OmXI1bUQ
X-Authority-Analysis: v=2.4 cv=FM6OVOos c=1 sm=1 tr=0 ts=6adbebbb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VuwbfrIzBJgoMi6EY_8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: GfxWAu3H4jv7LdbRaha0FVB_OmXI1bUQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX1IygXQ11tuy6
 VPvcDG9QayP7m2JymePf6siF6ofS3zLRd5X9KdOOS/8DvZ0cxeMeX+UZGd4/9IpDBJ79rm+PB8u
 XE0FnB0KGsvZVNBByhfKWejDY1C9j3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX27i48ppP2lfV
 UgKHTgM/qEMmsBodB/w1cKVvARaxFBXPzQ04cCOHjH8wWQ2KTiXmIUZnOkdn6VPzT9JNIo219w6
 08Xo9M3+nQMO9J76udaiJDtsiXiCm4AeJvEIVib/V5UyBILhOPukdzpjWnaEYAptbAoxIL0Hj/T
 ckL4sc4r0A6uJSTMb5WCK+KkwAJawe0y144V4Q+hd814hxFRXkku+6NgrPFFHa/K2tgJiQ4ltRT
 cogGwRTlgAW8W7x+U1mxPU9ABmWYgX9RvNp8sHHQFkUoyjmnfZqAE0TV5liKIL2l+lqfW/Adwsx
 OSIvxMHPJzolEUhrWyMZyp/xforDMrKnfHrFOe5Y8stxwEFkoB0qf6mPzjD9Sc2qjajRAndiyG8
 47K31LC/voSc0hnbgzu9O21qpbJmoxB2Jt81o+wCj9gKdfsI00A89oxYxMFUvuKhNOiixtCTT/R
 ILBpNgykj4zeW6BrS+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

