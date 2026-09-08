Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0C4C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDD610ECAC;
	Tue,  8 Sep 2026 15:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dw1oc+Bd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A7TqcXbM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7012010ECA4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1PTm3237136
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5hveldepbFOlrTK82JptzZAqafhP4xGd41Uh3UvDE8Q=; b=Dw1oc+BdXv/gygR4
 gPkUad9PeInTVCR07yFjnrzQZw1zgaUZbMmvy6iPc0zFabVtYGVK8cXOB7uQvVLS
 yb8kY9ZQfpMsSvHKsp+pIVclezlDTmxOH7QzNpgVc8DisxH3QXQ6Uq/wdqGfzMh5
 gsTVF4BOVcaPKtk5USPGRxNQ4lL8F0k0Uz6aidx8Ly4HZ6IrDpkVJs8LlxnHb107
 0M5GGjSxJZ/ZvNWj83COy5E5Z/0OG0NYU8Ct9spG3HN0cmjEEEVLuTUl5hvpxwTU
 i1Z1J8iI/F0NzIBiRFImTZB7eRa359sGqh6rIoQZ+sRmlAWvYfH2mCsAYCClXkj+
 jIiURw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjf1chq9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:19 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73a8aba30a4so3971256137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881058; x=1789485858;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hveldepbFOlrTK82JptzZAqafhP4xGd41Uh3UvDE8Q=;
 b=A7TqcXbMuwDGoIZeh6FhRZ5y2W+nHLUNpv7oAyNguwSBCRs12oz85pYVhgl8/tz4H2
 /wbPrePgjMgARYQS0hMEmN45zDH3G8Mbp3gmnbMKEbq/l7bX03tVFG2BMT6w2iF1Hn2r
 WIHl5XIg80f1AgyzkvevXJhbykipKvA40kYEBc4eXWZqysv/HIKDtxUXoIX5JMvDxAle
 Dez8xQ+jwsfxcmisiLSDUarve1WQPc6ZhjS5FtR0B2BmJYhU4SDXC35sVJV7odyVh09g
 0TpiYwl36n5VXZXUNbikLLO+rSYbFxA0DJ+yjycirYJaUkFtIR24HR2DjM7vsx+OgIMl
 ePXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881058; x=1789485858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hveldepbFOlrTK82JptzZAqafhP4xGd41Uh3UvDE8Q=;
 b=pU79C1qFOb+Qa1adlpLvq6MEAS9so63nTrU64a9EKYxuCaRVB/7ytYHI20iZjESp4n
 AZieaWnf9k9wyLYy5sWLz+OYhHLputZOiMAmrpaBRVnaprNKEFUza0fRscg76qind0/L
 maLLgbMkrdpzDC6h+g4/Zj0WvADwMzICJQpkZIzwrZs5t2K3qH227NE3fcSwZSgMoROZ
 Ld6NbPtqAzfwecgYq2uJXKHHS6e5Yx9Fy5og+7nFP1AZy9FVXI4dOPaSpe45m32oyM6P
 EewZvXEjCs6Qg+/xOmiblBu1Wh/j+HIowuBBF3RJ61t6RO8jygL8ixIluvj1UDF7f1Gm
 NCrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHAuH37gJaZfyDCoVoXvBg90u1jE+YC5zL/Li984HwFdB867xeDNsvsrJ9mhn3d7FMcTPppVhqJpA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYZ6iSFXG6JHxrb91x0TgKzezJqAwqoqI+j5ABDedadcWXrBec
 FGY5ZWe7dthbUmzHGiKFi5CxABcB3eAKW7IUFmtqJUYVj3nMsS/07kgyOr7+QmNJlgGq824xRbQ
 tA0RXun1Yhkp32Su4hEHm9QE0NjA9n6Bp4MhJUIZNchy04sTfVxE6Fu/K4Xz1XTLKjS5+2PM=
X-Gm-Gg: AYBFou1nvCEqsAZ5k0B9fUCO02n4fBTx9qM0eXGOesRVLaMgLMQcJiEHLtRlnMhxQ6D
 TKqF2s6M6jFTkyeFZr4/4FXPzfF8tsEGP6netUgdKk5v6aAho/0/v7M2ulLD1qCQGfyzx+n7wvV
 LHE4VMjMq9A31YhZQGC1GBF+e6gIHTlkDS3tnS8NIxrOknziekTfVhgGotmUHBRqN3jHQm0MG/5
 noFt/G1CnhfwOqPnMpEprWud+nTaNFMAQ8mdHBFYHB6a6YoL36toTIQkbjh6fPF/c2o7T7zuShz
 NBjdLUQXYo/Vl+vgE20Hv6JzdB6vr6OlAgwZ3EcVvKg54+RDqCPxVOyxFGRnn/BPMa9uhsYaxXy
 hx0Wcwsb4kLl9fWdmuxGQqYFGeJ0Vsy3UcJ8iVG0dnVeB5MPZa9wnyBFtG7qfxW923mjRQpiwi1
 pyVSxf8ue1N5Td
X-Received: by 2002:a05:6102:6495:10b0:734:54fa:971d with SMTP id
 ada2fe7eead31-78a2ee06a31mr6908222137.7.1788881058448; 
 Tue, 08 Sep 2026 08:24:18 -0700 (PDT)
X-Received: by 2002:a05:6102:6495:10b0:734:54fa:971d with SMTP id
 ada2fe7eead31-78a2ee06a31mr6908198137.7.1788881057969; 
 Tue, 08 Sep 2026 08:24:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:10 +0300
Subject: [PATCH v2 2/6] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-2-9391815742a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UYl5uPwIe+02hy+yKWe86cREn6t55UaPf6pfOMS27Gs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCia6fWmhiI78WH05KOSSQqikZ2cN4aPI378b
 2uqSykW3KiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomgAKCRCLPIo+Aiko
 1RjdB/9wvr9IkU9TQglSkUwUDy0hAnyERZMb0gBDpBkUyGuYKgLfPQqcTbTULAuYSvyLM5PwTeW
 p7/XdIVMnBPIlqsvk559eJmhooldOjoCl4NV346dKKP0WJRoedRp1FvdlZ1k/qalrStSJeQr34i
 t9q5maP1p7UtjN40q3KaqTQ+NlNaoVlnmsKF1Kkm56AxsYDvGT3M1YPwtZwUhTeLnek0WehSVfw
 nXULlKvHcyubiBNHLJHVBGJtGPMTHi+x620MaYiWdA3NAdabSt6ShCfEBbh+NGIonkaD9xgo6YW
 V6r0mI7zIz6enTUzHFBhWPKGqmF7qE5ZlnucUKA8AtJ0zwE0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VN3tWdPX c=1 sm=1 tr=0 ts=6aa028a3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=tvlXP28v7VYLJ75qtzUA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: j2w_tGgvmUOHo6aZuvOXo7u9QhWq_qLG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX6GnvSE+CxQ7G
 Y+UToKhbDvMc1q+cBv9QY7bXPUgnMxalfUmoUJ2qTUQCC4jY3g5vABSEtC3m8JjKFQ84m1wiwe2
 ypnwnUejFHw7TEOQ7XArRTZJOr6m1r8=
X-Proofpoint-GUID: j2w_tGgvmUOHo6aZuvOXo7u9QhWq_qLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX4xwvnev3Vi2H
 49k+9AsSTwBAH5hgH69G0gOs6onyZrN7YvlNIylW8iZg+JQ3SqSVZcKVeNvOlZ8chRsPL1wEbNi
 3QVImJLfWmtPDVvSQsw7hKdgh5tp6neehN643PnLKPKVlJC4o+rurZ34lyYd/WVVCEv+/uCXahc
 miFrC7SrA4ofH8s8U1DXVhbGq6Nvg0MA4neXyQUZsnwgYsESVbPhD1+dbjkO2fZrMgTDvXJ8MXy
 Vqagv+RFlC6fi+iss9ahq3STIzHUiN+D0IO/sjvRtach5s7eDC2cTRQB7p/iK8VaOf7bQpwkGDQ
 CZ4ooDKcuN/8exkLLjPImaKXBcafG1qxJBK49+HvfV7ti1FMiumSgaso7D+gcWI8a9ErmK/Z+zq
 fmST8EQ4dgiQU7IYPogkmq4sVFU9V3zI3QsCX9yvCmN1qBWJUUSIk+9Jv7QPJPgSCqyOXQgiyTe
 LyTnkQ9gLJsKFZoFIig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
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
index d69591245231..dfe040d5260b 100644
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

