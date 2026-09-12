Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDC6C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB6A10E437;
	Sat, 12 Sep 2026 12:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGHgIF+y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0aWTobK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687EA10E704
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdZnc3457070
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ajJdRqrp/b4NGOrhwXdxyfHIWwR8F0qeHZQ4G6QppSc=; b=EGHgIF+yaDOOM4HY
 V9CwnZMaXh9qdyvB1FGYy0cc47pM3gKJPw5y4GSpcE2DCaT1glY+TRo1VuDinUna
 z7QYOD4/RcQwtJLRO8cFZlDVU0thar4r8OhHxn6iGZwn0SIsSjK22xEtRyQSk8Kk
 7HbVsH8Yzzg3ymCciiq0xTpl7g6ZKN2ay3l37czv/W3pZ0uLsGyxmjjJQykHPikj
 EF2bpX9+hfZ89wCPKQThm4w72McFBKjnXQlL9ncZJSTB2qbKCeOuv41tXp8Ld1kh
 zqOKvMhz9ZqoDSBbGiP/Oz4TOBnGTIHDpjhWDbi/JjmQhqNVRJ7qtv85JLNOihz+
 3aeJ6A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgxun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:29 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c6725e7891so865350e0c.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217309; x=1789822109;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajJdRqrp/b4NGOrhwXdxyfHIWwR8F0qeHZQ4G6QppSc=;
 b=M0aWTobKDBbsuLdN1QX5rSaGdKNbJ8R9NqWoPLXg+whzaHvD4PrzGiQdtF0O9rJgBK
 iqpwwnQ4wkVA08f0zmjDilusC99vdzHxjQ8AC0sSNoWUPqm31dUqayqxP6MPfaan/4K+
 5YOwNnM7c7Wc7dKJPe1faI9wpv22Tak3XKqQmIOiALdm01Gjy25J5zJqmz3GFj0Aplyi
 9OMe7FgqwhDomclg9aOSpA2DThESvDPOUrq/5j32Yt9Akku8qgJGnm2g9jM78OBLZ3a9
 b8w8NDSqMV2Aa/k9aG/o35q4+1Wjg/HLyMO9SqnOXIMXM1+XsuVAUMyrCZjTM81yKLbs
 XstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217309; x=1789822109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ajJdRqrp/b4NGOrhwXdxyfHIWwR8F0qeHZQ4G6QppSc=;
 b=EvlJ1WnDYXQ9xRcgZIxnIlXsAevNvHDl77WcqYlt2YbK3+zcN/XPY7U2JjlLl87dhW
 iOXI3cWCbSbIj4Odlg1HF1xgJ3HwtOE1m+Lr+iTwG8UCzEJcMvQ6wux3cA7axSkTFXXY
 b2NruCPA5xN8IuaJhKHxEnI5Q6JqF3rBjyaCkDsO1zNN3AMMqVvf1NotP+eQiP0dR9UR
 dKdp8Ept7okmS2FG2Z504eDxYmeIoIt3ymc1Ryk9k2qHGZ6uKLlo0e1qJEh8KvYE55K3
 MvCHR66etWyXHPVJiNqpELnIefd6RmBbEQbRl6DhfJQ04O+Z9I876lawaPE+SW6eQvWm
 VewA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUMKiYLhpspP4sNfOWmLEdqjWGv0h10ugTDh85uTFDk5FD//cMZCtElUlfgen8PFRWga5t2guh2Zs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++moUf+y2I8+GwkegrNqJUSNSPSsDIszX8CbXj0tKtfhSxWFSS1b
 D93mjRCYoQFXq1uywDmvakuN4YzQPuPDSNhbKlNoHPM705OHZilfxJPGLNUpid0YTFsB8uSBaMr
 +1vfLFS+/8k8HsNdwcIySQpjmxfV4e3ZvgNO1z5sY7VgQJFX41iLJs2Z40S1mYLofSYsrMDI=
X-Gm-Gg: AYBFou3p15kEsmNNwm7Hiny2rZGajiSI3FKFIZR2LlQwWg+wBkCyKpTSUbtPZcGo9+F
 vhS8Gw0aU9SUIwv/2q8F3x1AOlyVWDA38BMHjV8ryr4d4LyeGmnGFZO5g7S3HpSX2dBM6cmCcv/
 B6i0mB+ht22v8TXLJ6mMM2/ZLUSXaEwKpkqDKzFLg5+kN+QNwD/q9U1Yq0s18Ba0IbICPNfkPiA
 HhlaTr2gqxYbLZeLHMTYoXY1KZPuxFX4mZFeyXY33bxUT40bRqAl2WMzxNtNNVb4XPDDC5zDjWP
 7UuYZ81VZBdRqSF9YysX4rvcky6ir1UMlgZZ4QZFVYmqbX7DyAIpmniWR3xWofRIGSU8AW1eAAe
 F3OdtHpb7grLFrciLI8eaPJuxoFu32AaCQaFGgfgNEe034OZh7mSOJ54l/9OKJNJd7IDZILPRLT
 b+OCgScozyYWFk
X-Received: by 2002:a05:6102:94f:b0:791:40dc:a1f3 with SMTP id
 ada2fe7eead31-795ab7ff924mr1518646137.11.1789217309249; 
 Sat, 12 Sep 2026 05:48:29 -0700 (PDT)
X-Received: by 2002:a05:6102:94f:b0:791:40dc:a1f3 with SMTP id
 ada2fe7eead31-795ab7ff924mr1518626137.11.1789217308812; 
 Sat, 12 Sep 2026 05:48:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:22 +0300
Subject: [PATCH v3 2/8] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-2-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QY9ysFxhmb2CtXGWZoEbLvZr15d49FXuEMy/zVQSVA0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoWuEQvk88wTjsRw2D/AVDzN2lbBytzilskT
 5NdOBZAIBWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFgAKCRCLPIo+Aiko
 1eXqCACCrqtXMD33umlggPg3i7lcdVLQG61UoaTPUeXoqbI48UaWmLOy87sJQPm+jTsx+/RPxTk
 I6007iHQP9gHbzHMDO/pWTtZMmFK3+9fdC83MsdQcNKnNacWTdrCA2DymBREkO5K+gAeIUejAqh
 FifPvmeGlN67zyVnyPwD6DedZS4QahCEzLLs6WBIDvesfGFu71tFxAQ3v5iQyxzkDuNa+GL4LHL
 r+1UUVcpFVwlyfW1/5Z6as3IpFYMipUE3ud3WdKTpsBhpKTfe8gK5npHvVmyS0Sv02IIjPk4Zdj
 vaAhBbVgVt8IF9dF75jzf8s5RX+kXidh2OVg3h8hVZz4ABKQ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: olW9KYsjcGsJLQ3r2dYOtNcLZKdDYzzQ
X-Proofpoint-ORIG-GUID: olW9KYsjcGsJLQ3r2dYOtNcLZKdDYzzQ
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa54a1d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=tvlXP28v7VYLJ75qtzUA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX8FWM62Th3eze
 oXnqxW5qvvGHHylaWB6RvTDHNv1rERx9vx6YpeEn+D4NSSbfXGscoWKlfxPntyH3GB5Y2NP8nuZ
 AI925+bT+CkLlPNs1x1xR1KkWhNaYU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfXzxOeZlZHuQNU
 ohzinvyNZkm13530MQeJaYjvmlZ48bdETUMuy/piysnpU/kZey8G7V2/5zlBG2iNztoX6yDGjEU
 JjjpNjvi44v6ZHGltWzCTPv6c15WWDUVKX+SOLw7sgplJXwgeQeWEBCzjc32jXYhnYXGSdg0GXD
 VQUti1kMx8EMdqVPoLJegdOUhNE0Asu4T82AvhFEZGdXzbiHac0DhVNmiex/6Vy+LfrN9Rb2hKX
 FosLc0UBbNx7/UEWBRg+XfsOC0dRe05oSiJ0mIUeKcTzzGb8WUIhg1X0Zdu8g3smh+yNzUgpAiA
 YReQcWc+3WYSqjO0HRspsShAK/uT5lHR3vQ2fJ9WVQLEdBgfhLJGWqvs0futb8oLwASSkIRxVi8
 Pzqgh6T1JWvgastNGnPc7y9yKFTmiBu8KaSFfC9A/9fCfpIIjVe7BRcV8rVVrBARxYZnwwYo24C
 n2xpmO0wVDUS8goDI2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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

msm_framebuffer_prepare() bumps prepare_count before pinning, but returns
straight out of the pin loop on error, leaking the count, the
msm_gem_vma_get() reference and any planes already pinned.
drm_atomic_helper_prepare_planes() does not call cleanup_fb() for the
plane whose prepare_fb() failed, so nothing ever drops it.

Since commit 8ac37c88f991 ("drm/msm: Refcount framebuffer pins") a
prepare which finds the count already non-zero returns early, assuming
iova[] is populated.  With the count stuck, every later prepare of that
framebuffer reports success while iova[] is still zero, and DPU scans out
from a NULL base address:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11

Unwind properly on failure instead.

Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 77415302e6d8..552ca5cf0745 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -102,13 +102,28 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
-		if (ret)
+		if (ret) {
+			msm_gem_vma_put(fb->obj[i]);
 			break;
+		}
+	}
+
+	if (ret) {
+		while (i--) {
+			msm_gem_unpin_iova(fb->obj[i], vm);
+			msm_gem_vma_put(fb->obj[i]);
+		}
+
+		memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
+		msm_fb->prepare_count--;
 	}
 
 out:
 	mutex_unlock(&msm_fb->lock);
 
+	if (ret && needs_dirtyfb)
+		refcount_dec(&msm_fb->dirtyfb);
+
 	return ret;
 }
 

-- 
2.47.3

