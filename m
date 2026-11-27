Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U3dc27p2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SoIqr5V/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE53112D5A;
	Fri, 27 Nov 2026 19:46:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C5D10EAC0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB07J3134360
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hwNG2bG+XTPWI3596iFZ/msYtqga2lGkUMVk/EaARXc=; b=U3dc27p2k4VVY2+2
 xMUAePyEVFBkJ/HC6Pyv1ZmJV69zKrong1Dh0D76out/4APji81IMTdOzHeHfiTj
 sleu5T6RgS/gU5kiIfb0jeH91Ql2s4CJdoIstfUwuCqUKWUIVaROcaNeOGBlpzlb
 sO6H0lpaLqXp7TdXjaJbhhJwckiYdswmhUO3KtxjakJHkJgq149zHaF0ccxoJG/e
 3MZV4zNWtOyM/7Oz86lZK2Ed3JsDiUVBcsWG/L0QpmleUlEFIb+Ka9Pt7SP9XGyF
 TAYOUCxiQ/poo9UomDj+Xb7NqUqCFIJSc07W2TPyB75dSfIpTj50PTJgypzSgZZ7
 7vDwzQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gatrv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-92179251e32so56557066d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808711; x=1796413511;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwNG2bG+XTPWI3596iFZ/msYtqga2lGkUMVk/EaARXc=;
 b=SoIqr5V/5fDPmNN0d+6076/kdr4BRQXAhMPcTgk62jJA5f+eSgW5XbHiqxFM1Xj6G1
 nUVLIOhFsxjKMy2bcMBPutnGHZyv+ZYW8XzAdVlGPOZAVuzrJhV4B/pIIGtVM9b++DPF
 nbzSKK0cyQ0yRuXOtQPQgiirs/eQTi3Ml2Y+WedpgPSD2QnDDRAXJcNPMIkhHxy9Z6q0
 FbpcLHNnv6FyHUNoF2llMiW4MGrsLgZvF/GyFS5VncLuTt43ZE8YmzMjGeTN6xd5+VaT
 BXuriuPrch8LIoWkr0KHZG8uB0hjVryT89tqwqSlsLdcBfeHI7LHuQtXvQWdVqZIQpM8
 9WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808711; x=1796413511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hwNG2bG+XTPWI3596iFZ/msYtqga2lGkUMVk/EaARXc=;
 b=Ynhy7p/fxeKQbgC+s1E+M7ey5zwS/5acw0ntWFdg3cun4+DniZBkGqI2kMCiFOaJKZ
 ZjarpOjaM5NbvHqAcj/po188kblSC8/4cqp8bnn4m7cWofzY66xNiqcW1KbSJJWsLPx1
 m3S83uWuEPgD7I5RtBrpcdJnBEm0OqI30S4AWoM3we3R2syM4sp4iwBqKCosijVKwFIz
 ZSTYQ8emKLt91lpvs5lMoU09blnFB3bD+7+wZhRrP18D4vjf09m90NKGonVOUZ/jWvIN
 yC5KgdssZ1Kq3WgtV5NIvzo8vnSRpbu/pjF2f9Uovgwl4Ywx5fnU965QufEPYMzwwe+/
 +QPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHQbjC6YAhKkx4qVWktCJl3GviPOXplc3F1d0nJ2YMcIM8odxa6cay19z0Rq1DO+6Jr6bHy9g37vqo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/SVyg7nADTFpk3Dx+8aqzBM+Is9h5T8CU6WRbqhU9H7kQvQ+2V
 i2VtUrTqI3riqLOkF4H3mLKM9lSu2XIPnvhvQX5rxsyi1L2emfst0SyWHeqqi63l/IFatKLDNen
 ofKlN/JDmvwevzpuDzcR/J6JNraxYScw/r22SjKODFPLZCI1d0VzXHiCy5CyXFglRKTotgo8=
X-Gm-Gg: AZFdTZdKp3RMe2lA/5eazcyGt7Cs9HOQngNyfqAktrat+88GRSZBllJ61Ji5sVhaJyF
 xhDZTZZH6oZ7vJPd5jCFZYo72tXKJpgv6K+f07RdaRLI52hm6B6qoWVrxgWran9VRp7687huCOy
 J5TtlFy1ceCYbm39PlP4QLR7zPLBX8JnX8/0Nk+6kXLz6czqS2nsYClmXQ1znxDEveSl2nZHWiY
 K5e4jfZcscWjsuMNaKj5edULoiEsNrwg/YNFdwfwfo5S8QSfK6WJuPRjRDYHTLidzId3nN4O6kJ
 LwV/vB/n/Js/MtYy0MYbyq740MOdNk9twk+fkWSe3BGhs8bSxe6hCMXv4bYv0Zt0xp9Lj5geDae
 KW99yoGcCZBWO6/y/kuF4RDzb4IXbJKbEYYbiaYZrKkS0BseLkuIWZHGfOtmDDSdCZFgrkYHvCz
 TvQnnjx5KfsCvPbnbtwjQRi2wNsOHp8fxwjwFQpRrPspqI8rKhRl26JkYwEJjNoQ==
X-Received: by 2002:a05:620a:40c2:b0:949:6768:fae8 with SMTP id
 af79cd13be357-949ba9e160bmr4631494385a.49.1795808710795; 
 Fri, 27 Nov 2026 11:45:10 -0800 (PST)
X-Received: by 2002:a05:620a:40c2:b0:949:6768:fae8 with SMTP id
 af79cd13be357-949ba9e160bmr4631487785a.49.1795808710297; 
 Fri, 27 Nov 2026 11:45:10 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:24 +0200
Subject: [PATCH v4 11/14] drm/msm/dpu: clean up the self-refresh helpers on
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-11-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=D/uWkxcvDmXzNDWbOytGgnOpR8lFPnO6KIN97YblHnw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2pv7q3g4iU6+NyAMh9IDYZqTyzPL49qurKH
 qDOv7/cHGSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndqQAKCRCLPIo+Aiko
 1QqeB/94oTDnZNMGJ6YKAksRLJJdpbjeiRB956P/JWKiejc/Vv0hieQseh3gQhxFbGMtXR75sd4
 bURWLq8gHYa2CUpVvSR6Ak+rbVKdFMNP4q0mbAzcqNFnLwnMsJdjm7Qqm7srZh5TExp3umG8hpM
 yIC2hTx9mAzGn5h/TOAcr+Oo8oiX/TRhmAmgthAikS6NVKDE30ppFnq0U4IXAqXpxpt+TGf46YL
 I+gf3vZnC4TwOGNvuLrdwTuEZN3SDuj4Prbn5F/dpv3EvH1cns8o5+Ec4uejqYaMz9klK+rBzLB
 p4nhQITPDG870+P11onzAui0hzHUj6eku9iqLj0euXT/ZQqN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Sa9xNClkwJzhIXaKjTwBcP9sHsYD6YQN
X-Proofpoint-GUID: Sa9xNClkwJzhIXaKjTwBcP9sHsYD6YQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX7ZNi0GcbPrdq
 Y6e+5nlvQh/K17FQOw7YXkIlEflow5+fhlNjeOXjo93FTzv8/fp6lHxuXcgk7sWPlglhQYgWwzc
 lnTkFKeRIRXfzJ4Vdj1QYd5ZB5nhJo6KJVOziKQ13F71oby5XxSJnBgnbR6dnD/iOq4WP65BXyF
 E/2rECyjVrdkAsVZSx9b4hNh2AfgLVyk3Sf6BiuuM0UtBb4dLPbX5OgZWPqzCDsZ/k9pzv3drig
 PWek2ufeTHASY66ZyZjRkXUG88ZTay6WNvIdinrCcgZnP98atmuOuTay3plTJtY4pfx24KoF3Cw
 6jVcIs2NNuAmA+YLchGUkfxFzeD4KbZSxZp3EBlpjBdgnFrLImpXv5AmTQXDFLkaAXxFPzOY9la
 y3Zqdl19M9s50RTLpb5zJXUp3hPFvurSl6ehl0DyJ5IG7QhelKPMlfN9M3MlYkp3xR8pAow3k5O
 WAEhcQ65pB2epGh//mA==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b09ddc7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=r-hXt3OJkovplFG2WMgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX2uyqUoq/eNZ+
 +aX6blJBjLo7OxobuHG+OSEC3CO36FBcllm6i+kfGDJPhuAH5BtIjdI4S0m6lP4zB/15/CO7sox
 aAxrB/Hg1s05DpyyjU6wDQHAanpQr0U=
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

Unbinding the display driver on MSM8996 with DPU oopses about a second
later:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000870
  pc : drm_atomic_commit_alloc+0x10/0x9c
  lr : drm_self_refresh_helper_entry_work+0x5c/0x1dc

dpu_crtc_init() sets up the self-refresh helper for each CRTC, but
nothing ever calls drm_self_refresh_helper_cleanup(). Every modeset
commit, including the one which shuts the display down on unbind, queues
the delayed entry work of the helper, which then runs after the CRTC
and the DRM device have been freed, and its data is leaked.

Clean the helpers up when tearing down the DPU hardware, which cancels
the pending work while the KMS is still intact. Doing it from a managed
action instead would not be enough: the DRM device, and its managed
resources with it, outlives the unbind as long as userspace holds it
open.

Fixes: 1122697810e5 ("drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver")
Assisted-by: LLM
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 65ba8fa697e9..934ba47b2dae 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -17,6 +17,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
 
@@ -885,8 +886,18 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static void dpu_kms_self_refresh_cleanup(struct dpu_kms *dpu_kms)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dpu_kms->dev)
+		drm_self_refresh_helper_cleanup(crtc);
+}
+
 static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 {
+	dpu_kms_self_refresh_cleanup(dpu_kms);
+
 	dpu_kms->hw_intr = NULL;
 
 	/* safe to call these more than once during shutdown */

-- 
2.47.3

