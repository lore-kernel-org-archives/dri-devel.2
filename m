Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE89C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC94910EC9F;
	Tue,  8 Sep 2026 15:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GidDwibB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgJk8em6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EFF10EC9D
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1MQn3527053
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7u35nzDdP94dCsNs9Tn0dCNHt60+fGcXSN0rDFrXnv0=; b=GidDwibBtWZJCxXf
 qIOv0n9Jc4+Asol05gQd4euONroAXVkmUBOx8jjilhdJFMyE6C0XmeBgq+j+7r0w
 3n76TtN6FS9/MRyG9El2TJmWTBvn3efbdxeCMLKEYLcBC88d3SidUXnqpMxI8i+6
 dNF6LuVsgKgC3aCSSqQTg//v8XgJhOMtHtsPhtIQGgaeJkkvFuPnuJ6vvyipW51G
 HEmF/8nCgJJ6CV0cfB9kvrOZ6Mj9Lv2zP4TmFxu2/AhBLsbc0EpEH086bfvLb9Yk
 CuCR4D0oSQE2byHHCMv50g3q9ufQ8XekHMMtS7vgVPcI1fOyU3E6bVvz6300KEXr
 p+l+JQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjaguju7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:17 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-980682ebf05so444273241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881057; x=1789485857;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u35nzDdP94dCsNs9Tn0dCNHt60+fGcXSN0rDFrXnv0=;
 b=KgJk8em6OaHp96kuHY4lPKAPW6e8oYDICBLumYtEAcrwD1uEALMzTBUYK4IPM881pE
 ec3e5J1cBcwz66zFjCLo2W5gtHsZK0l0D82ajm1XSrHLhfCHJ5EP3Wrb/q6STRzIBa/x
 uYgh5X3ayGm4w8WBCb+24m/+zWiUIAYZzQu6EnX2QuV+DUzGeAQ5rVri/N+8JBu+dUX1
 2wD4L6mlauqCDlU5UQkRxtE79ho5NUjad0/8RHbS5xuoxaHd2+YvMaAUxngNivHqmWZr
 8fDeNYpZ6WoFwaGVsPfiSuIrrvXQHfZtxM4Jv9l/deJnNeXAPOEgaXgSpL7X6bMLI95s
 u3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881057; x=1789485857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7u35nzDdP94dCsNs9Tn0dCNHt60+fGcXSN0rDFrXnv0=;
 b=M92TuOLmUyCozyFPB/+hKa/3BxYQZc7jiqfIG0Hlw0oup9xLcVRWTtw73EN8RXKx0c
 nFmtwsxwwBk2wztslXJnL5HL8/mi7E0k47TWvWa1htUeQ5jaNSYzIWVbJaF+muy0qohJ
 3Od1CihEsbaO2pJIwZFBTKbArZiYd5XFiTIo5RX79EQ5TXfntyXRhThuxL1AF7+PvaDz
 wWgmbqXMvYlKX8MaPoEcJjO5aq3pc1NIdXW6ybJZUxkT4HhU3WyGuz3eIxjG/UXjDX31
 syOuo62a2CaU95cmxrf4ybu98m0WoKHRp+Ogw1+zXm8Q5uqf52CNXevOAJVfhnbSBTqb
 2dSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1gdgu6/GCWNW7g1rYDuqQONMnVs/7RATJQQ7/mcp74oUUiG97AB9654l/1L0fjVELgSJ13H7NdaM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kBc3d5p56IuugfXD/TDll0dCWr6dD6TsS/ImOpfDpltwKLraTk
 SyidWhQVMrwKKKldNSSqY0Ztk3QSDfSNxpV9j0yojKjId6ayEeUUz3DAn2djPed6FuyRCOltITp
 S9ln1s6d7RXZN/YmSyKsALR+fXQwyUzJtSAEcVNvMqfhkyI25j1NSdZ512Y7AfroaEeRVUdw=
X-Gm-Gg: AYBFou0UlGByEO31Jybmf7NnjORWcOTEnyQKhA72oheCAhJzY0ZLL9qkBbWMidX70US
 M8b+krL7F0dZyc5bAIqfJlma8gIZ5AvIUPfXH0zDHDY6THg0Z3QJoPdRwTMRJckDYDg+/p7NGfH
 v3vH2K4xsg5ZA9CPSka/DO0jy7qtn/IYGORB3jgygS5LxcrdRzbRNjRdrG7dz3yD/lv1qOAL/QW
 /CdRTW+TVigGQfwyKiQdXMVdczK6N9kwg4qvv2DaL+4aaMe4cMNHkEkGPbhDyXiCLQTcEMdJpHJ
 aJRsMoayi1uMdqa7k2YyUJnJBO8JJsOcsEEScaxvyKMjULd6WYDfb2ABwcv8Gsy/fni6Y1HJwWX
 wJ8CRh4ExxczTWzFL210ZeIm1dt/OI/bEVZuXn/Iu0sFCIdnbBPSLg7KdBv1vVrNDVPY/u0I+RZ
 4eSbqLv3ZxHACL
X-Received: by 2002:a05:6102:808d:b0:781:210d:2897 with SMTP id
 ada2fe7eead31-78a4aa07b1dmr10166205137.9.1788881056754; 
 Tue, 08 Sep 2026 08:24:16 -0700 (PDT)
X-Received: by 2002:a05:6102:808d:b0:781:210d:2897 with SMTP id
 ada2fe7eead31-78a4aa07b1dmr10166164137.9.1788881056246; 
 Tue, 08 Sep 2026 08:24:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:09 +0300
Subject: [PATCH v2 1/6] drm/msm: serialise framebuffer pin state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-1-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4350;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rvnAOg/zYGiII6SLbLFn05Y8Y0cbEo0D1VGSCTZYDa4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9YCjVmMqW1mq7+cNEpusGd0Dq7t5pqxcJVqruvhp/Z8H
 AyM0UadjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZhInTL7/5qooJMlxmXd6yRn
 7+uMjqrL32nskvE3QeLU7rOJMVO5v/FVNHrr2ibFJnFYP/DkP9Fv9lCnfuMGy/Yleaumx+v98n6
 59Fo/k04Zu35npzaznvv35ezhy42ENgh5unk+M7Vtuc0oXffAduVujw6x7kOp8nkmO9/kZx1Kfa
 jxNbxxu+JE5ZTs4tmqG+TYdppdtLjdXh/47dNO79rIda8LU//NUvVb6rd8fnV/1VLHLKZJItE6S
 eXXqnkMHnecS9Izr+b+8mXvYb8cr0drl0hduyq19MKfBvGWpp7ChzYl+dz2NrXz9q9R0hN6u01P
 7cfsnGXXzmT3hPIEt8zwUz6ZKVfvn+d85OYSoRKmAAA=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa028a1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=-SLBVWGn-DbGgWclMpAA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: lFSw9kZxtkBCNJF934FZ89trcoUTDezN
X-Proofpoint-ORIG-GUID: lFSw9kZxtkBCNJF934FZ89trcoUTDezN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX5qnJsaUtGnNj
 kdggQyphZxIlxccfeCbVk3fqgrV7Bs5ZvuxwJ9gIp61zLFdtutQJj9tVIfS+xEK/E7yRDL8A+nY
 KxNo5JeOFH1/gXU4hpOXadkt6uIugcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX3yJC7vGKCA3x
 x0pbmqRRcst6Nt7rpUu9teRXw3SCH8frXJyPaEqs+zSa9hMCCllJvRwus9TZ91ZOV+qql9wzxop
 ldkxMYMEH1JWvodp0Ie3lwSRSVG3Pf2NIUBEM+btMj+4soH4Jv4QPFt51c8BnaPvlgaNG/h69Rh
 a8wrNsOu/e9hKEGo/XpVJ9tNC/zbcHlamp0ejhW96N9jsuFH5kMYa4PNtfx0g/5zrETO2anxTsH
 7S+2vESKTkElx2vRNaJX6iQnZFEZUvJHhvL4zzP6G5rFJq3BFwX5a/SYr/c7XXCt/e8DsbgsZXZ
 9CZY58wEbsbKmYRPSeoewTazgxINEy+qS6doFIsEFKPvP0dTJRDsGQYtsPSIp56YuuH+pgaw3Mf
 nS5nddrRQGgfbg15qHtQnXnkODyfBabHXxtUDo9BMUoK6towFIP4td0eVtrr+EoW1ocj2a0LjSE
 lSoJS85G9LetJYuRR3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080166
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

prepare_count, iova[] and the pins they describe are updated locklessly,
but drm_atomic_helper_commit() prepares a new state in parallel with the
completion of the previous one -- stall_checks() only stalls on the second
previous commit.  Commit N+1's ->prepare_fb() thus runs while commit N is
in ->cleanup_fb(), and for a double-buffered flip that is the same
framebuffer:

  cleanup: prepare_count 1 -> 0
  prepare: prepare_count 0 -> 1, pins, stores iova[]
  cleanup: memset(iova, 0)

leaving the plane programmed with a NULL base address:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11

The opposite order is broken too since commit 8ac37c88f991 ("drm/msm:
Refcount framebuffer pins"): a prepare which finds the count non-zero
returns at once, assuming iova[] is populated.

Both callbacks may sleep, so a mutex will do.

Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 60c108d35d2a..d69591245231 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -22,9 +22,12 @@ struct msm_framebuffer {
 	/* Count of # of attached planes which need dirtyfb: */
 	refcount_t dirtyfb;
 
+	/* Protects the pin state below: */
+	struct mutex lock;
+
 	/* Framebuffer per-plane address, if pinned, else zero: */
 	uint64_t iova[DRM_FORMAT_MAX_PLANES];
-	atomic_t prepare_count;
+	unsigned int prepare_count;
 };
 #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
 
@@ -45,9 +48,17 @@ static int msm_framebuffer_dirtyfb(struct drm_framebuffer *fb,
 					 clips, num_clips);
 }
 
+static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
+{
+	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
+
+	mutex_destroy(&msm_fb->lock);
+	drm_gem_fb_destroy(fb);
+}
+
 static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
-	.destroy = drm_gem_fb_destroy,
+	.destroy = msm_framebuffer_destroy,
 	.dirty = msm_framebuffer_dirtyfb,
 };
 
@@ -76,13 +87,15 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	struct msm_drm_private *priv = fb->dev->dev_private;
 	struct drm_gpuvm *vm = priv->kms->vm;
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
-	int ret, i, n = fb->format->num_planes;
+	int ret = 0, i, n = fb->format->num_planes;
 
 	if (needs_dirtyfb)
 		refcount_inc(&msm_fb->dirtyfb);
 
-	if (atomic_inc_return(&msm_fb->prepare_count) > 1)
-		return 0;
+	mutex_lock(&msm_fb->lock);
+
+	if (msm_fb->prepare_count++)
+		goto out;
 
 	for (i = 0; i < n; i++) {
 		msm_gem_vma_get(fb->obj[i]);
@@ -90,10 +103,13 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
-			return ret;
+			break;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&msm_fb->lock);
+
+	return ret;
 }
 
 void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
@@ -106,8 +122,10 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 	if (needed_dirtyfb)
 		refcount_dec(&msm_fb->dirtyfb);
 
-	if (atomic_dec_return(&msm_fb->prepare_count))
-		return;
+	mutex_lock(&msm_fb->lock);
+
+	if (--msm_fb->prepare_count)
+		goto out;
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
 
@@ -115,6 +133,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 		msm_gem_unpin_iova(fb->obj[i], vm);
 		msm_gem_vma_put(fb->obj[i]);
 	}
+
+out:
+	mutex_unlock(&msm_fb->lock);
 }
 
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)
@@ -206,6 +227,7 @@ msm_framebuffer_init(struct drm_device *dev, const struct drm_format_info *info,
 	}
 
 	refcount_set(&msm_fb->dirtyfb, 1);
+	mutex_init(&msm_fb->lock);
 
 	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 

-- 
2.47.3

