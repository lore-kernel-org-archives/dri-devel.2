Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C560A2613
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0vcv+m5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O4Jcxhi+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD5E89613;
	Tue, 10 Nov 2026 04:56:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B07D89613
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4Aavn2929011
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=; b=P0vcv+m5pfx1xDjE
 lsrCqPqc8XkT51nv4FEt9oVH+azDZLLZ3/BbMVHcBX0OKY3SVjfxsjhpJ59qXvh8
 wsNUXGjfPKDFXdZ3OcWklsV0MTOAmH6eI3PftlQXWTr440oiALhm0zYJPp5qblRe
 eCqZ6+Uw/eYIinx92VieZs229VGubIAZDI/jfLPkWb6ktKlKFEdboLu74AP5p1y9
 uPzmmJ5C89bupaRFmpg03PFttCPzyAZsnX6JAAgZ00PWf9vvoGu3r2xIQrjhuin2
 Jsc35FJwgvTaPJveu+lkRmsLe0+94z2J0MRGD4h3TUQbWz1YtO3Sw4rlhG4WSXjc
 4vvPBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx830eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so321431085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286600; x=1794891400;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=;
 b=O4Jcxhi+nISHeoXmAiQCkrECRjgUFAYsbmcrzsj4qPyubVI/DA4HFD0Fxadgh4NnBe
 Xo9nohpKqwA/XjwqeXwGu1qKCvMlGL3awCyJsdIHyYbzFOjUtQcpAGxMS6siiQ/4/DcW
 vZr1/9bsfmDdm7/CiXWG41XfQTboSugIUbxTvfqlFmMJgfbKuHbeXsOvkvnZ/3Hgcbwo
 ab3bhqWAi8UgMBBmoxs1cvvBdVbAOoCMl+6fOQfed0NxG6UaATSVWY2XDuy+5tYahOLx
 2EOEOKrMiT7pzJQ14hYJSoCNpTppHvGr4cwvh1Sk6d5CdcyTbakpqBEVpwaPOV0aWRfd
 4CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286600; x=1794891400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=;
 b=1XgyCABy3s89/1yaIRGBqLe3kgOO4S/3rLiJZ7TVNFRJm/iNCAJWYBJVmh5/SoMqEF
 tssUVP+3TGiClwmap4Sd7lXamzAJbVjhoaA3MESt72qmCrG2qiscBKjTlEccY3LjAc6u
 7e9JI5Fq8ZuFof5czmTvIGz197WQayAg54/iA27ZalIfvOqWgJvK9Q3QXMVu5sSuewB8
 jbBnERmKTnLmDJq1kge1cILp5Dla6LGOmXgic+6yd2AlBAkFBke32EidEHHcIvHSrMPY
 HuHqNa9cNfikDyT8YFKDu8zC1L1N/hloLlgynB3JYkvSHvVcOs6gzzejJwWXLKYkFKOk
 vPRg==
X-Forwarded-Encrypted: i=1;
 AL+hErGULVRYQjJ+LTJlrQ7tFzxXVLj9NRI5ZZj/F9poGgoJgnirlAuvGpBCOM6g+Wq7E/Bx/CCfEY8Xaz8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+t4YQKnSYRxG3SQBmkTldzroryjm/SRITi/Adcu0af7BH8YTux
 ifIZpNLHFIPFihPx1vkOjn5wZveBXY/PwoQV0o6WGOGFPZwsAF/jjAN0HDT2aoAnM2cesI46Z4e
 F36cBFrgUMI9/RNiX7D0c0MD3Of42j6EWO03r8QzNsbgcIIakFCsu7IaV0YahCu57fCVTU3k=
X-Gm-Gg: AYBFou2SGEiMmmQF+OaQoE7Cx23aEM+Ruz9upKP6LXzgULtWm5Ml0gyfQq+Z5ikqkS+
 UZRvFsG+RjKNEWR4RfGo1hEzYZK1JkYwemtd9uar972Cc9nqK9AABVIW24pECCOByY7jGijVSck
 WBlfqhpuCbpL0Eb/+N7kohaK9fdHYXShSQL4os6Z3njOiTxwTCH/K0vROndmz0eClq1zzeH64Rz
 Ma+jYz6lj17rjmVg99nC8DzXRpF/2ZpP6IgfuXmsNPTrNK2SPDRvtdN0WhDi2D1V36Uq1uGN7Wf
 Amr3eUJnDVGHTyCbJpGeG0QgEXYbA7naMEqwfhOWSXTiOMNGnIyYJ9azBEq1/Prf+tWbJJSuCez
 ueGTxi0A/m4dwS/j+m7Y5iKjby2IV5Ep8nLnPG2xWw/f6ZVSDF/s7/iBVhH0xWQHw6E1IKbqste
 yNuQuwqf34oYC5pzE6SE12urr6uQKSQvdyS3WE
X-Received: by 2002:a05:620a:4048:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-9479f40d32fmr264143585a.70.1794286600244; 
 Mon, 09 Nov 2026 20:56:40 -0800 (PST)
X-Received: by 2002:a05:620a:4048:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-9479f40d32fmr264140685a.70.1794286599709; 
 Mon, 09 Nov 2026 20:56:39 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:39 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:47 +0800
Subject: [PATCH v8 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-26-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=efENb0T/HAWReiK8VywYdb+gt3ssVoPh2n6XPte/XmY=;
 b=Ur5Nhx/DGjPp3ZgGzpb0eWbz69nrQ2sT4U9Zg/FswAAARtvvYYWk6sG/feiHhEo9PX/70XEGp
 9fZ6g1ik4zuByLl58BUOuR8idqjAgNovSbHxGaaR/geKf4D7D4ZQTdk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af2a408 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: jo4pkvvA2tWxr3OVhcL2Rzq6N3Tpwyqw
X-Proofpoint-ORIG-GUID: jo4pkvvA2tWxr3OVhcL2Rzq6N3Tpwyqw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX1UmGPDQrRjYN
 wrIbw1Lr5/el+cDLtIXl5fkg+LithDdUHgkCVN5VFmEivos7N82O0qVMSGwP9IrTEtf6I8cNYcA
 M4SWtDugQCw4SfCAuyY0CJI1UgbdlqA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX3bnreqYlWG8Q
 w13jkROg8lCP+gExGxeOuxYJXDYoa03SW6kvZk9f/QYprpw9FX/Qx+ZsF4/SqVQNwTA7l085iQ6
 5nQwZlzfoYPoS87GZqkjzTJODfGnxff8V//S1Dcj8WHF/cY4ik9bF4ZgCrPW4W4GrIxGnltqdC0
 lF1BzN2CTGfIpquEn6EYCRCDqskxzSzKTLdTjDgESAWBzp7ub8DtPAjbspS2Ytp2Lpn9uyEQOEj
 2IvF3W2ToOBhCUFxgWsnyH6lSSfn2HfGCHZ+E62gWA0JL/bM8El+3AZwZfRrErho/SzUN1vArdz
 TmLmL9kTco2RWP1w71Y6GsJJOUzJe69JOo+67fTD8ZcrwlNaPMy3KgmQlmu3R6E2GpMBlRThX0e
 7z0OgmVrEZAvY6D1k1uulzoiNT4P/YrAkLFxDQc1y0zKgO83idUt340bfEuSbx0rFIPttjI9OOU
 5A9za2IAy2z9O168mug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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
index 82fb3ae750f4..5623693d9242 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3018,6 +3018,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8ea3d258a98f..40b2f6e120cf 100644
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

