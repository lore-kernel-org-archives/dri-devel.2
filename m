Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1DAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C36010E915;
	Mon, 29 Jun 2026 14:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZ5C+cra";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DdDY/pJ/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7143310E920
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATE4n2579139
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=; b=jZ5C+cra2hvfEX6F
 7ksTjtp1szfj2k5MxoMjwHeqOYVfM1I2QJ/KDqup66wOkEP7ssUctAC8d4as5/S0
 Pb9MBBrL9J1NnvHTk+ox5ghwryN5CNfiC9eXFeFTGlYXdWo65zyIC/Ub2zcAPUAo
 au0W715XfwHbcJsDtaRfnm1MtletgB3Ql+1t+lz5oAGfjOLlYo0rPJda0fNLSFkv
 V2dFrLUk2O26v7R8lGN/c0BhAmWzr7JzzcVtQs3VQ6G631+pt6fPBCvNxnWCm+Ek
 5JA9zFM0wxLY4eb5ZuGCuzJ1xU9+6JPBlnz2aT77OzT/TUqIHuG9JAD/AhtydFfy
 ZCmnzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hqur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92af3d5e85aso733938085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742558; x=1783347358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=;
 b=DdDY/pJ/SRw2mw171FpdrZWccP5/8ta/My2Aw9KK92K11qXiwWioS8pQzlWlTNPwpG
 mnJvm0wlzjJdFZYVNbsPh7RgQp04aAYwHEcayaCx8+4sn53Blub4V0PwK67yeGbScP2f
 PYtzg0kO/Dz2UBQ+rZw9CdxJqWxEs17EzLLxUnWB4ZqbXNIb7o13z2cFos97+WlWK0D8
 pNY1d7X0x4ZSXXqbBXuEzxlVoSdUIyRFVSINxSuVryhE95cIK9fHE4QyOo70K5ThnKxQ
 W9VnXYy0ZmFq66NU8whNbbDlI5EvxwaXkMj0jal6eL6QlReGKYIsUM7y7g28PzpCtcO1
 r/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742558; x=1783347358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=;
 b=CkpEqtY+XdSf97RgzZNzQSg6rzLAXf0ywA6WzkqEASBcEuvnANU8ztWrtUBuT8wdvN
 Cx0TgnqA4cpQyqs96Lw6TZbeseJAr32tuGaXmNlirt5r93L/0jmgrqM3mjMaIWrfY0Nn
 CvaA6LtH0yx3mBqUDV/ff2YCJvlHCMCmEVNrZiOX/r5xMr1/Dyx3J1nzKJORZghO9dxj
 KwDmUr1VUP/w6EFj9I1Rr+I+zcVxw9v47e1Wm+90NpIG/Hi2pdz5BBsPDR9XSXaHlWFD
 06b3gHnjDAMyQLrdgK7DeZJeVwslahFilfIl3+L/v4wVKSK6oMyMUR695+v3QFk5s9rR
 qz2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OjePDpl84p5805sulQvRaOlKbR9nATwZIwRO6z87s0mvxCh6GbwovCQbo7I6Upo/pEe+BhfjfDHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXECnLRqk/Gkmq34PVzUwA360l68Zut+OxsKBOxYekLIFn7v9B
 AFPhP/UZDP5XwLGrVLGjGRPA5NhY616wvGfBbBuAHC6wUkgSDx3VJGOw1+AXipZLlxnPKRRv7w0
 /9MD8F6urOyV3Kf2Z1WnJ3MSfAj2gYz8bW65Irno/2gn+X/RT1SH0q6iMGgxRan+BvmP887U=
X-Gm-Gg: AfdE7cmFDt6oVGRgyzOjwc3y6AOMmUezsBZXWgkZ1fmC7fkR1v2s6NQVUwgIw9FP8RU
 buENAbbgXpSm52e7M3YvyLEEQljd8cTth3TFMFy7ge9akMNGOcam9x5Th6t2ch+J/8OZPfPdeCZ
 /s2gicnA+G+YG2spJTbYg7MIfsj8arzEybpLE876wboRqdg11Dj6XYE23MdoC9GZdm/unqcCWDp
 nX2chiF78QcLZ2FEQbpU8/PpPKktF3Y7tRdT0fxh0bQF2u8WMmeWrcswCq4ebvaDi24DHrPpQnE
 yE7L4j1s3lAvFEwMjrQn5+FtD5PNOh2l+0yRs+tHYGif5DYm3sXrkRhuy8Cy0ZStkiRuqlyv1uy
 Hu2jhPg1CRDkhnd8f01x8yTeXS177yvCYV//PQ7J3Q2favr2MyhYIWVT3YvDoxfancFQs1g==
X-Received: by 2002:a05:620a:2684:b0:922:d336:1990 with SMTP id
 af79cd13be357-9293a6b3700mr2639053985a.18.1782742557596; 
 Mon, 29 Jun 2026 07:15:57 -0700 (PDT)
X-Received: by 2002:a05:620a:2684:b0:922:d336:1990 with SMTP id
 af79cd13be357-9293a6b3700mr2639046685a.18.1782742557023; 
 Mon, 29 Jun 2026 07:15:57 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:56 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 10/25] drm/msm/dp: Always program
 MST_FIFO_CONSTANT_FILL for MST use cases
Date: Mon, 29 Jun 2026 22:14:31 +0800
Message-ID: <20260629-msm-dp-mst-v5-10-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=2539;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=NN3ZQ7RQKQ4IPtPV9Psg0vrIOb4voIVZosbAYDy6STY=;
 b=Wo0n4ZkKEwYBX70C4SIo6eYGpFXBnBHwd+EEq4+mLkMkNwPLRgJcqXZ7YtksKBSTHl7xTTCQ5
 2ZcEikVCzbtCuI/H7RE4pOEcKodV8H9ERY/4aL3o9tkxJTKyhvtzGJi
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXzoLP8THmadh6
 8+iqamDtU8TpzypGiezGe0PDWjB8tjdQbkiDRH7C1a8T4QmPd0CUbSZuVjhdgW8kU72ARcveSZr
 bPLkmEQAEb3O7ESbQ5L2xRnzuJu/Qzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX8qAvzsfkNavp
 GLCusL2DIjb4a02YjCs1Iv4aq/Gav7/4XXAE/y2TfV5U/68eG4oHd0Nw/dTMRSe2CrU4+XrXtb2
 fkA/UXvhfc0C/ay8xQ5Ur5qsBFon4FRpjfkreNaCoeOLUdc4+HQLexsFfhYc8TAhqlXGUKLh+av
 YULd1OV83o+fDknZG34ym9Rine/v/5bho6Ld/ulteD1s2/+bSf/HobgC4HYnqu26QGS6aMyTU4H
 a7oMkspRituSsq4YQXE/F0VUe+pYfpmTv09lcRTVTMN1faJcQn4hRDFNpHiuoc9wwYncrnRwPpB
 OGh2blrgOcxPx6QoksUR2EyKCgLnM6aR7oWPbhqdZMbkGb4WawbMyKbieyjjJ+rgktcfjRbAKQ1
 0PJgzQf3FHCChnT3JyT0pV3di8e09ATaz6nLMuGUQYITdZr8wOMN8X6R6DgsDab/ewByZigyt58
 VeEg5onZQqO7QEOJKhg==
X-Proofpoint-ORIG-GUID: RXq4IhSTBYK7ICKv4S5QwISoGAkHMOYN
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a427e1e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RXq4IhSTBYK7ICKv4S5QwISoGAkHMOYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

As per the hardware programming guide, MST_FIFO_CONSTANT_FILL must
always be programmed when operating in MST mode. Ensure the register
is configured accordingly.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c  |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c4f1a68b1210..80116e19fbbf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -677,6 +677,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(panel, ctrl->mst_active);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index cbbcc0dbf652..ba5ee2ad8924 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -741,6 +741,18 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	return 0;
 }
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en)
+{
+	struct msm_dp_panel_private *panel;
+
+	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+
+	if (mst_en)
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x01);
+	else
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x00);
+}
+
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 				 const struct drm_display_mode *adjusted_mode,
 				 u32 bpp)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 3e78af9e430d..edc39ee5268e 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -73,6 +73,8 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en);
+
 /**
  * is_link_rate_valid() - validates the link rate
  * @bw_code: link rate requested by the sink

-- 
2.43.0

