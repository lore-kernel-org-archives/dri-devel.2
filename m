Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25600606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWiV+r3R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fd0fl4sB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78517112174;
	Thu, 19 Nov 2026 08:27:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1D6112171
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vQ4l2194745
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=; b=FWiV+r3RZtlNKwfT
 1py8YOPAZSkDTk9EwoP6seWbhh9wci4VXLG+Yhql4WMFWgYCqW1RPcs2+/4hkpQE
 0iLmOgP3PMplG1FkwGSRW2GqoHtk5mBAjFHjJ+VUE+CEP2Ez1Vib+yLlrjApeX77
 KLtXo5BeOGbrkyXkhaZkaoP/yWrFPVm/dLvGOUGCiSsmZu3PSm32og8V3u+Erf/o
 9zh7at3qP2y/UJyn0y9TknF4+nTqvy0mbDJIDzSUYvMdbEfd8lNXLORVl2CKeIwz
 ZdUw1/Q9p9ESZUldTslRRf0Lpg6V4P0P5CFd4c0EG0R9l5czLVKe6+GamPLiR1jm
 6vQQAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qv08p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-920fb8b9859so4847906d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076804; x=1795681604;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=;
 b=fd0fl4sBMuZWvBtKXSslII+rclPWi2LZhhyz0CM5GRvCwiu3I/vy9RhbRXej6CAAep
 4Uh65cO5mxr172szBRBR5Bqo2cZ5ipL427MSmN4QugoDcvPuPD+0Lea0b+wpQdVxDm8A
 jSdWsc8Dz6D3JUaekQ0VN3duJLgiWgLolxtBe0lcbepEzRTuT+RiwMsOBAm+7oMlnqsA
 YDALJJaKbPtOegYax+pl+RAsmCr81BA8hhrm2bfkpgvxpHr69xazoHclCc4+jCMACb1p
 02OHXKc3BW+ZwtNgbP0YM8rHobnbGSeE5oPOChVgtVXuiczhZQN9tcxzAcBq5QaiJq6a
 CMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076804; x=1795681604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=;
 b=mjL+Pu8xzMumCKArpkJM0G8y5WimNGSWJQpXWKWTq+UjeMYCcZhrxnNP1yLnmLXgcl
 lOaFhptLr1USd0tkeyIzYtN6REkdT1rO4/7HWIFsAQ+a23B+3DXn4YCKf+Pd3tm8UVnb
 otWLexG3i4WNBWWtFXRmirZ69/xZYih+hQfbxzgYnKHEEmOVXWvZrF+aJc/R7TZYyXEO
 agS7lNl1vtNlxK/GDOSLK9S4Bd58Qe+xfEvZCZFdIPyCabThlinrEeNLTF1cqVVJMVQK
 9AIpAj1rms2kemd9vuwGOjFosYrr9FgzamV3es18EaRsCodC8gaXvmVmibmrQnI9uOS7
 Z1ow==
X-Forwarded-Encrypted: i=1;
 AL+hErHR9jDrks5RlBABiNFnuNZrpXZFs7nk/a7ETXaaAyYtifSpBqD6lqVyC93VER+H2h3RxhY1Y0rfXss=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z86ZWbG9VVYfMiOL93t/VzhviqVPpfKmjKFzDOI3bQpg6o0dpDR
 tELBWmxLYRcSUZ52C1cAYhstpL+TL2aI94LGWX4EfoHhaTGWpzJBduH3FkxZ6ckSYl3Qv5YQvdH
 6AhgqcAl7ytqgAL5145+IBxtlesXAu7dvtrVC3OjZPz4rNYoi+7nTCnhRqH/vexLwSBe5pWw=
X-Gm-Gg: AYBFou1mOcj/hRvwXCECRwArUNemp8OW3hi/dsDPkrshJnIomXohqRhHJ8u2izIUR9A
 BuwQ9YjhOKMWxXqFScTwN0bU0QYXu4nfDVpBZFd386ihvMrmZM8I24h2YxG9agw/wMOgFDHm75E
 Vy9NPhro4dSgzvESbtScz73TDzVFPaGhPJNd5JiPmrpXYDBTyMFaOLWRapDWCaiov98yPG3Uoiy
 EaGf9/Wy1sKVX2lttCHWN04jF5l1w/rpLDZejSi3z0HJEeduCER3oZrKcoDVGV+DDIRRzaGLYFs
 xzsweoHCo72xVqaEpTOvtpjQ5amhTJ+OlIg9/aQs2xFA4ASW2QW3G+uB62SJH0//z/Scx4wrrmi
 c0jqY5CqBix/XkZlshOER7+6gsZmvIU/IM2RVm1AexE0hQvG9Z75U6tq3cUumwu0uOz/ZARSN1C
 8rrBx2HwRem3Yk/9dk/0o+TZCGAXh5CqWR13rU
X-Received: by 2002:a05:620a:1d0e:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-9499971d885mr862086685a.22.1795076803893; 
 Thu, 19 Nov 2026 00:26:43 -0800 (PST)
X-Received: by 2002:a05:620a:1d0e:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-9499971d885mr862083585a.22.1795076803407; 
 Thu, 19 Nov 2026 00:26:43 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:43 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:28 +0800
Subject: [PATCH v9 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-26-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=1XWb8mR9FYw/3EXAUOxkw/H8bP728zpMqkwMJ+1kf7E=;
 b=5Le6Ow7xDjp7G1d+34n2dhDxOimAVUJpPTRb+B7nB643hXwWmX1xNESzkxoim+Af4c/zSgvct
 O27nfarjCEMCTfn5Y2SI9LsyEWTBTnrKBPfNUtkUhN90d0gNTgbDjgE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: Wp1WK_45ou-eMj4tqL6nwPB1nsMXHaDE
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afeb2c5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX3TVpkDim1wAn
 3vDoWFN9OyBpGJmove8807yx33PN6RZ3Xqo+ia7OIOv/hyaVK8kHaNb1G9nXKZ+MYmEdn/sx1Vh
 /rlBjl0ouZThTFtnlBfQIE5Ye1s177Y=
X-Proofpoint-GUID: Wp1WK_45ou-eMj4tqL6nwPB1nsMXHaDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX1OaRwUHmfpNO
 ANKLzUFHNUaMx9EeXGMaXt/fk7JQg6c5uO3rkWoiejmJFC0FLbWfuXjccvcg1ob9xYooUmcC9iS
 MqgrhEbrF7mxNWDXKuPU9Ob9t0v0Brjv0BHyMVJo2j7LCmnMjGhZNX1L+z2z3TkueLoBmwcZpZG
 8L+fwucAFjUMaIFi7RQsRRSlVtAqndfEcdahgOlCoyHxwA67yplHL50cH+i9/dUFMK9TlaYPsH+
 JXdv+e92INI12NkQXE2T+rsQyvJmLPhda9Tz7dMf1rl5lj4xOJ3zFZVRO8Lpx36UL+geMYI2IM1
 ZSaOoPcjckcnpiQA7u3uwYBAdR02FDjoqQwNjEQlmHsfC7rZHjPyXNmCJo+t6bNVfSKUUtniAS3
 Zw6iHSXttXq61yw5C23bD1zHFDnDZeKSs81fbNQeB4EsEFgFHHAhABisW0G8yuvnlxRylDboKv4
 Ohj68hFtswsvo4+ujnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

The primary IRQ handler latches HPD status for the threaded handler
before servicing DP controller interrupts.

When an HPD interrupt was pending, the handler set its return value to
IRQ_WAKE_THREAD and then ORed it with msm_dp_ctrl_isr()'s return value.
If the controller ISR returned IRQ_HANDLED, the primary handler returned
IRQ_HANDLED | IRQ_WAKE_THREAD instead.

The IRQ core wakes an action's thread only when its primary handler
returns IRQ_WAKE_THREAD exactly. In that case, the HPD status was latched
for the threaded handler, but the handler itself was not woken.

Return IRQ_WAKE_THREAD directly whenever an unmasked HPD interrupt is
pending, after servicing controller interrupts in hardirq context, while
retaining the existing IRQ_HANDLED fallback for non-HPD interrupts.

Also report STATUS2 interrupts as handled. msm_dp_ctrl_get_interrupt()
acknowledges every pending STATUS2 source, including sources that need no
additional action, so they must not be reported as IRQ_NONE.

Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 3 +++
 drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 8012c3d47711..bf3f1b35abdd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3021,6 +3021,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6f1f9dd3660d..ad8c30a8ea79 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1091,23 +1091,24 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 	u32 hpd_isr_status;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_HANDLED;
+	bool hpd_irq_pending;
 
 	hpd_isr_status = msm_dp_aux_get_hpd_intr_status(dp->aux);
+	hpd_irq_pending = hpd_isr_status & DP_DP_HPD_INT_MASK;
 
-	if (hpd_isr_status & 0x0F) {
+	if (hpd_irq_pending) {
 		drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
 			dp->msm_dp_display.connector_type, hpd_isr_status);
 
 		spin_lock_irqsave(&dp->irq_thread_lock, flags);
 		dp->hpd_isr_status |= hpd_isr_status;
-		ret = IRQ_WAKE_THREAD;
 		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
 	}
 
 	/* DP controller isr */
 	ret |= msm_dp_ctrl_isr(dp->ctrl, dp->panel);
 
-	return ret;
+	return hpd_irq_pending ? IRQ_WAKE_THREAD : ret;
 }
 
 static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)

-- 
2.43.0

