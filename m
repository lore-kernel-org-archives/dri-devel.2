Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A69CA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073F610ECCE;
	Tue, 29 Sep 2026 04:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/fkupnm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTHbI5Qt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6C110ECC9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47O9o319100
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=; b=N/fkupnmm92kBOJD
 17QVIlHe3eCaZFq3zfKRIOocSI20dZ+XJl5mtlyYYpRhYTw7CFyuPyxPe19c84kP
 jXqyb2GK+JvOAkJiZ3A08cDuhYHq2o2SQT0YfeUJurcFjnYJ4aeBCGjrGRYmje/u
 fNDlV7Fakz3KJiji7AXgaobjeMhmnPJC+/HvG+rTYTmFh0sGYUPbUC4z/tAS28Nf
 9BFLn8yYoM5h8Qdt226cvjw7TNiFB6dHqzZvB23sYu+sm6xCyxD8pdt6eDyEzg9p
 dQzafYbcK/j6apI/K0c0opEYkszljJuFD2ZccFn/ZsiUCoYw2M09EuFEYHfKCcNi
 NAvslA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03j4at-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-916cc44720aso26584036d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656142; x=1791260942;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=;
 b=aTHbI5Qtg/bd6DkC7wEeoZrK3KeHcgxYxV74dayhYzohHSWG93+bOU0xCdk6Epv/5h
 Uzq0c+Nt+igc+sIbnANbyKIv/YrzZhEnaR8C4hCdaTjJmnXC9yFol71VLOR0dOtv/v0f
 u4SiBJKVZwsQ8nad6azSsjwWzBry1EuXge9Viu/8lBeF7eFzIKkioDxPrr0fbnFwDxDP
 fl6lHYq+SgScBbHy1LXHhvDondQO4gG54K8ZlsnM4bLCmnRYkN6J7CleDKlOlHYpZXbo
 YDZPDD3uZxO9C/Adv93E41MyWhrd4N+lRJ9p6NgCNzGj3yCz5sSPZnrSI/5k1sN6soru
 YUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656142; x=1791260942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=;
 b=U+g3IRa36mpYNXBJWqpOxI5lxHN4LfFGk3NyTZvxJmC9p1SidVqWX2B+BGzKATUEcz
 2qElYvhAnqo8Tbm6zZg8xsDPaOEKavXjvSF93lhLyWCkyNvIKtMbZyy/qv46/2pB9TLy
 hKncCjBq0I+TSnavNN60fd61pgu9dL8wZ+oiy/USgMMbXqMvTvu+vQDEvkmz3odKzhhk
 jg4fzHqgS41RXH3qC2Umm+cEz/2FVZj/cn7XJs2LLe3BWVIb4OZLfG9JjPdP/PxeP7He
 gMnUxL8hokMdNdQ2AREb3fZuhmh2I1eThCBqry0E12WGtnolHvpLTZlY5LHAt3nl38Ss
 m7uQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwoRCs/WkLb1taMXJUFKkFtY1g/0OOvYVDjmoQi8k5XiMHiMz1O3dYcQRasYtLgRKXB+ZGIFXTmSM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWSJjAFOU08PhT/HdGPN0EabYaC7tSk/aCFEK8MAZV/oZjcJY1
 aZM5b8Wqix0BGfDkocl7KQ0wriWKi7SsSiVMavAc9B3LY8fxTmoymeHo+5J3Sb6dRqcjFTX9jWY
 60pnJlyEkXI7M1Krv+BLIZAjYgWYA2MGap4IktOHdwkK35VVZSsVvSNtqbxrjHSN4GjSihSc=
X-Gm-Gg: AYBFou1VhMrQ/3QSZ5SQh5q0bOqdnNPZIDVeoox5XKtGevv6pBogwVRVU5hPUjeEPfY
 v0jIP09kaHjrS00EEjkzPRN9950UKY8wmrecGSOvQhUhHzOSBV+5PgQlXSGrnB7VYOCE7z4Ft5l
 W51ZECvbaVQL9jFyDeNiM/MF9pDof4wnQVCacAVp7gOnxftD10zKZFgmWP/M6ZeL7iA1sXhG3Wd
 RhiC2RV8+tNqwtK2vuF496JHVCHAb4ClOVUm/KhnkkE+aP1ejM3K1VDnVT5LxoFvpnxyh/5UcHQ
 ban1an/f0Ia3PFG2831wEhlkrAcb7nvUCsZHs6eQOzWVYiP5yzdPAuVc/TLW2hQnOm7Swm2W6KX
 0KLdUEI1iB7k8ZZS8V/LylrUg0TTQZJTjIfnZ69B9oTRdjqvAyhUL4wzTqWdV+go=
X-Received: by 2002:a05:6214:6187:10b0:917:8238:2320 with SMTP id
 6a1803df08f44-91782382925mr34606306d6.37.1790656142180; 
 Mon, 28 Sep 2026 21:29:02 -0700 (PDT)
X-Received: by 2002:a05:6214:6187:10b0:917:8238:2320 with SMTP id
 6a1803df08f44-91782382925mr34606096d6.37.1790656141676; 
 Mon, 28 Sep 2026 21:29:01 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:29:01 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:57 +0800
Subject: [PATCH v7 33/35] drm/msm/dp: wake threaded handler for HPD IRQs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-33-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=aSeBGV8VMkTSrgHkv0/PJ4kG5TxILdtIp9OP7FPqUBI=;
 b=xy+JB5mpVmGt+3/yWFmznUuwQ53lLquWq0Yx7BaW5umA651LMuHClsVgbrilUuPTJLH+j/k2N
 NVs3qwQdrzWAb1u6kuHTD3N6BPTvCIKIkCCRddqmm6YWxjNX5/+Ywaj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX58AN7IqNsDoX
 Zi6/V0y8BXWgniSzo1ONo/w2oqvqabI1PO92VKxyL3dp+Yvpt8ZW6RSaDpy54tui9E/FgHR1WkM
 QIKFiA6woaC0RXloT3FTfhvUkgE5ksw=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abb3e8f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX4Fc9N4UQFaLA
 Vc3Y4DXD5SRWsq0nPfkuT9dd6moZDDmry/FYfBngwq+Hsv781kjpkE2PH8hXr97MHMqcAHi6Qo0
 vUYB/KGXPJ50lS2kjOIh5OTc+InLB5oUxLXMMy/yeI/7DHdVNjMgsJFm+xy/IVft6HarFxgEHV4
 h1lzHv2Ev3uOaxaM1rLXfdSeFvW8pEL8ZrZsh2Cmyt8lessEeRl2yyORJ6HE/1Mxv7tbFELSOE4
 pzw7fb1Aa+t7EhGUdSUO9KUpYN9r0f0ZSc/L6iZcdWSm5wtQ85VEoi5HYXC7jkEZe4XTp/U0tTD
 CPie7n3DWGqLMdlfbsYIcgCtIi2hpPUXD7RHrLIAxqLBCASSOk7AdFjCd1EMhvH8kn+cbiAzI1B
 I/hqpP9x1ilvW9n5SapFzpJGGM5f9f0yOEgmICIYlTuewVqOQzIFW80J/iyrpHStPPku3StnKxH
 VS/walg3o4DePa9qiTA==
X-Proofpoint-GUID: O7hD7MLL0kg_qx-XcEnbEdaG4elUyEcF
X-Proofpoint-ORIG-GUID: O7hD7MLL0kg_qx-XcEnbEdaG4elUyEcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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
index f1642413e4a3..53dd7a23e091 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3051,6 +3051,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 327777f5c95e..ed0b93e3bd08 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1089,23 +1089,24 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
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

