Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6799606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lAfL3Tqm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sagxh2bn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD022112D51;
	Fri, 27 Nov 2026 19:45:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51142112D3D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB07H3134360
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KvZwkbWp8+Nl2K1PrPnNMNb3pN4kwzB/Z6/fiZHIt2g=; b=lAfL3TqmR8Hps45h
 zEalo4PtEDMTRRz2YBSFytFrb3tNxejxXuZQU4V9I+SqvKAtww0I5/q3B41TyxO6
 tyOcMFzcXdebQsjbiN8+y3Gsv1hQpqBi3mgPTjm6ZO/k1SRFuxWl1yBnSpNjz6TZ
 YvRUrreZGoOtm+X9mA//QL2VF79G2+ndXIQpf9w60ETPxzSEUyYhbjjo1vsuaeq/
 E/q9AL+MLQS37ETNejqbc0yHJI8nRAXhjOtW086NmT3b+fvCp7Yr/4lSBdOn2etq
 Uy7lT7zoHOvzb/D+SNxUc+9a9iPUBlO/o+1bDt4dAGqzdey5Xs7nD5HgbYZThW1F
 oGBCAw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gatrus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94967c6d4f4so943419385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808708; x=1796413508;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KvZwkbWp8+Nl2K1PrPnNMNb3pN4kwzB/Z6/fiZHIt2g=;
 b=Sagxh2bn0xS5JRUTyfx9N4HgUNbVq5MSfPo2QjXt3T5JpEhEPRINzNXRxIisCOQQrY
 HzLIRbz6q7QKkwkuq5f+rY6ifSUNfyYLOuN3P3M3OreDDW/Vlp6l9QucYb7iscDdB+9U
 9NJInjUTw/xhPFaDXPKV7STkZM4fxbeAbbrk3Hd8UXzSjchkpxVoJCoJmVl/n3/K0IRO
 QS5IOKHj4dbKRPEgIzDK9+Si4NYX3h8ZJTOfqo1h7kWmxu6f5q1/YULLhTYbiLDepajc
 y2e05LNt1s/4lIpRKtM40hBo34gRBH5FNXC0tkC30m0RB/1WIKGtK6Hys9EqpPkhrWXI
 AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808708; x=1796413508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KvZwkbWp8+Nl2K1PrPnNMNb3pN4kwzB/Z6/fiZHIt2g=;
 b=1rh8Q8G+KNdoD0hZbQaeH6FIEbnoCRF2Ay1TI9ynw8GhLd4+VsCD4+zAhN0/x/PCB0
 Y9HLHclBSXmfp6nRb9eOc0NVJ6WgKLgcaMQ4vdIGJENQZXbyL9VkGEtv7Ns6fF9e3HK+
 MknVvyvHV/e4WDsrifhf9p+4+tr0RkgQnl0ktW5FK0wBUOl4dQSh4ZQUsUNDv9mKEdUL
 VBLam8Wy9r676CUjH393cCD/sFqPyAQXX42gHHzv3tYqLiJVUGUr6xXJqOZJQDFJgIx/
 kdb4uwSFiXOoMY3Kw1tx5edLTlzUyHOxAByHkb/fOzjvhKUKmU7S+CnvYpKmpqbOOP4L
 9eVA==
X-Forwarded-Encrypted: i=1;
 AL+hErH1pbJqsGxJfPt5LUg45H9IyIQHaE1/35ndAWfa6UmVt+tPg061+aYgWoLU3gxRz4iXLoXW97Nczgk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yYdt7nH4Zpvt8nkyD7w7XkFAKLcF1iieAkyLRc5153lii+HlE
 o5eHLk3gvLuNRo+vx90WLoMweSR++U0SCewFoeQSr4q09q35hxWAt4TzcoHOF21srYz3Ox5sXe3
 iIDBwyTKOqYcUJy3QpBBNpbU2Hi0vvnig2AiBRlphJZLmiucfJPf5CFufS8GVtQqtM9uvRPM=
X-Gm-Gg: AZFdTZfCO3hnNrjvK8MVXiejku9UqCYBeGxbYryHtZplUxh5YmMNkUeFE0QT5Go846q
 Q1tO7MzjELgVv5wc/PoFUU7deK6kL4LDdLWQfkc5W7g323185Kfruf96BW5KfV5SRJ7YNBlApHn
 GvH7mGoYVhPK7AsthDrDl3SFsPULfl1EwBrB//Kgz0LIwvzphMJISVx9w/K2x9GBN7XSxbpQQHy
 rGucDbcDuT9hS9eSclvBSXPzR/DFZfmOtfC4FoYbxyCAFSffepZiTFctLNdbQ4wVy5DVhiAsSpO
 NCbFU4Zc74sZf2vhgZZOegHB7RC07CyGnh9J1lEj6ud/7YVE6BaEfciolYx4fiy+mI0Ec5CwpIw
 uMNuYEoz/iiVINywUT/4yvBmQ7G3Ey99bt5G62AMEM+B8vwyMnyp9JN/pSEJeUEWdTZtubfEgIE
 Y1R7SpJXLRzI52Hnej//M9O9dJelMkHB4YV1a0DOnlUgQjocFg8PT7f46m1AUiLg==
X-Received: by 2002:a05:620a:199d:b0:93a:48a:167 with SMTP id
 af79cd13be357-949baa001d8mr4450391985a.39.1795808707582; 
 Fri, 27 Nov 2026 11:45:07 -0800 (PST)
X-Received: by 2002:a05:620a:199d:b0:93a:48a:167 with SMTP id
 af79cd13be357-949baa001d8mr4450387885a.39.1795808707126; 
 Fri, 27 Nov 2026 11:45:07 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:22 +0200
Subject: [PATCH v4 09/14] drm/msm/dpu: don't tear down a failed hw_init twice
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-9-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LTc7bKP698tnyAhsvxfmRQqNfbXKCPF/Q1izJgul78E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2l9ltT6q6ZqKJW3XFi1JTeKp9lixJYeOVra
 RvKNlJ7dGqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndpQAKCRCLPIo+Aiko
 1Y2BCACFC3sPZ/fKCXBlrIF8QGYsf5zaSriCsBRkiKvz/GnUkU8zVL/kvsN7Yiw8G1EtkUGwoCN
 2JZHSk4NnsI0kgGVZL84Z2Fxj/4riSSLPrq0s1cdZ8QdqfCghLJadCAR+KHhZLyAvOzlbf0LJK3
 tOK7tF/6rJDNGlg9rjiPr+XOCXZ0W2j/zZvjtWFnizm6nM+6rPVakjpcfn16mPpwChYfEKZ/6cn
 HU3xOZvKSeK68AbKTK0Op6t38D7B/Nj3mCTR/8AFr1HGPXjXBpwxgFjVLDDHXTklCBDa1qAzY4n
 5iazoRBccfQBDNAJvCDwBhoN3MFXyqQfMQm3oSrgYeX3qDib
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 1st3ZrUYABo9wieuXEuZfFOIS8U8Dqu6
X-Proofpoint-GUID: 1st3ZrUYABo9wieuXEuZfFOIS8U8Dqu6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX6SV7rt4BJZuD
 TYKfo6hbLyWoa599Jwzmk5ReBfvhIIj4bFTBUbWifvCmUY1HUmnuio/lwY9jRV8QhoHQLuS5CyY
 TXO9nQFZoOazo9V/b3JhVEJHDEH4+cohh3L62zDKFL2kb30gClisUPnSfuJ6EmT5zuu5V/DoA9I
 ioUhmgpTp2BZ3bPl91kyFYMFWlJou3jOwXYYphC88zZb+yEnWUMDhqtkWAb4sdvO45fLem9uAdk
 HmG+SUe3vaPCWIsuquCH5rKMOiFZcHpTqPZMxuB178tu4g3rjQrCSJ00AJMtpllqDbMjLo3/PwV
 6ZUlHibVEfxrONIc/yDGuD5orwEvRh0YqEgmkOhEvPbtnpkVVP9CGivJzeNaKNat5f3CMlYBi0s
 aKfk63/8nBAx6KYtoUeuQoj8G2TDlzFwvcUBGVl2OWu89a9t0uTFCGD7dexNfmdAny4lx616BLt
 OZAgGx5xf9/Ns6BsaAQ==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b09ddc4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VuwbfrIzBJgoMi6EY_8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXxH5gKv3bg2Yv
 Vk0RdKwzmH661GvUPQp8nY0Ult8ABdLX8POOrvhwAXf4wZYT9o82ukQ9ATi7sj4+Yd3lF07hqXO
 7d4DVvTFtr+3aBj5pS/qd5l7c06kbF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
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
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

