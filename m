Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16DBE99065
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39EE10E926;
	Fri, 10 Apr 2026 09:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJufMGb3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PiyOJpaj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B7310E928
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oITm1925126
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 InbQY1tkNpz7LPlGE2uWAafYcXfhGCbw+NsHxeqXBug=; b=kJufMGb32nAtOSwz
 5/hURrCPuQRiMBnpdaQUdSEgHH1bWFT/8zKVM9UatIr4zWXN5NfRCu2ByYBp6Pgb
 PofHeZfz0TT/r450wPz7Q5QgXY2iLlywIVYOiLLWNlGsNcT2c3cf1hFA7rohmzMg
 4QnnRMLHzyeLRELd04BfAFk4ro5B3Mldg8ZVBhi7exXPKzHiEHpCNNr2kd1ePk5t
 VbglxgAOzdPPrOs1W+vLm+Q32ZbXLHVLFGM6+sf41shdqXE3/o3ihOnjMUIdetlg
 GZsvDYSG3xv2UShWZkIa4urkb/y9BtGeHR2/Ph2P3xu8ZwIk5wAbBuxjYcRmR5kf
 O4RSJg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrtbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89463017976so46604486d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813783; x=1776418583;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=InbQY1tkNpz7LPlGE2uWAafYcXfhGCbw+NsHxeqXBug=;
 b=PiyOJpaj7nz2gCh3AgiR3nbvIjY1oXDvkW2bb0QRllBpAhbDNxkpb8SBIVxZenQkUD
 yKVMvcX2WCauB7hyzg914poJPL+aJwp9eDJeMPPNZMF1JNCJ1rNYfiWxynjLfHVY51oO
 6qdYC4V0qFjPfQvaIooOM2JbN1gr8UBbp2aQv1ZbuIEQp7zBGSj73CSLtfC34rNAETVw
 BSg6GjjlPj0LEHuOmNzR1Yyn8r3LOKQb+iaMTh1DUa9EQSYVBHNhJPMeQ173ISpCT3Lv
 F4ipeV3wyS21gMRlILpPwuahvv4LS92U7N64m2KAa/dbO2QV8sQ5AKk30LxRuvQ8n7b4
 qy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813783; x=1776418583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=InbQY1tkNpz7LPlGE2uWAafYcXfhGCbw+NsHxeqXBug=;
 b=MbNY/7F61lulaDIhQwCB6hgXCiERoardeGuRhnGuG2EkEHgcFvbeTeRsXyCsZtlOL0
 C76sxHjXLdSMFwhIKIhaLTs3A0ymjP8Solh6s8gaFGYgz/dIWlErZW/ZIlOCLuQ1Qp8v
 Af/p6jKoHDvKMQGyWLPF857t/MpaB0O5Ah3oHGPSPNOLcafreQchciCaYS5cB27ZNy4Y
 WmZMEUplOcAVX1Dki373tsifwTHcPWuUvcGz1s92NqEQLB+FuMuAEReH1/n7HEDe95Vo
 ur/0/vaHyJGtnQ24yD6ZOt9ghJjb+Bj8Tmj5PFcifE5+zN/Hn9fNqHGC8N9loCejG8My
 RLug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVc4hrwIRuMhrwh4RZbHIfVqzgEEmBG+p4nmWvDS+eKecQzL7PlO8ChUpYQ5WcBCjZhoK0oCA63Is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjcG2FxR9Znhq5AJvWga0Z49sLG1SIbCeXN17G3uDOCazTM0JS
 boVKYvlMnZG3U1fziKBNCWDXK1IlhQQe46qnBYg3Qc9R/qwpz6Kh65KQawycV4hB9T72jUgBDK4
 ypEQg2uiA/pYQjR42uVNMpZzPvshXQIdZXsJcMuTbMOda3xszL+Em1mzBvDsMwhYrjshFIEg=
X-Gm-Gg: AeBDievM1vwlElNIST2iin106ZnYmk44afMM6ZSy15ZC9DVriJgURus214L7VSYpnl8
 sc+8ULEZFc6ze1n1tF+yuhGiG5oCa82Vzrmys5zUynvdyxwMHibitqARg7/c2Vkc3Nq2qmdLuPj
 qQGQUIuGRwMP1E2ksrVlYrTLQCVHUT82tbtd0lES9f97hLZFGwWCswekoOuYhxiOBsNzjPKGVgZ
 acDCgKAFnZDMKnTDKGoGs+hzHkP6MUGYHpf5TAG0gQfNXnnDRQHMa3ugIwyeg56rdqyvbwpTmrH
 ldb6a1WP6jhtWVb1JKUCCNbGi+86IwDjMgnahGzgQMUW+X5xCDBpZDxCRTCLAsC2LkLJ6OiJCgV
 k+31mwyEEaTtFuCfbh7hsyOaJOoMm056Kt4X52rcj+ZTGf9dcJC4O8FdwbOaiGaoBHecAyMB+aI
 2Dyt2cwUo=
X-Received: by 2002:a05:6214:3a89:b0:899:ea4f:12f6 with SMTP id
 6a1803df08f44-8ac86285cfdmr31567356d6.35.1775813783007; 
 Fri, 10 Apr 2026 02:36:23 -0700 (PDT)
X-Received: by 2002:a05:6214:3a89:b0:899:ea4f:12f6 with SMTP id
 6a1803df08f44-8ac86285cfdmr31566926d6.35.1775813782540; 
 Fri, 10 Apr 2026 02:36:22 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:22 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:05 +0800
Subject: [PATCH v4 30/39] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-30-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2242;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=HNW6+4ELYah4hoMWWjK4ifF1ZFGIAFGBz4FjvX3SfX4=;
 b=RyKQ2XP3zT8/QWCbbMypHlSFYRjXW/EA7xCX2jtB+ehOrBxDk5zacjDPCR8HoRVeERcjV1bpX
 teuIZx+8xt9DQke7CzHoNE3/AVpCaZeyO9t+32DAZ/Q3AShDVKG9Szt
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c498 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6cFZRJIsygQ8aEszaMkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: u_otEKdpG_SMqLS3KoZnK7P3vNIERbVD
X-Proofpoint-ORIG-GUID: u_otEKdpG_SMqLS3KoZnK7P3vNIERbVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX3FL6/eh12c4B
 HSv9V5vxYp2XBp5ZT4E+OJOLqz12P1hDkQ2XnKD8FkxHM1mZGPEr9zQw41brhyifYb9gOQjh/+p
 Y3aXLyOE6MpRuC7WLwGLKcrLi6/TBXQsbScvKMpOAUxsfg8pnuj/NsRmRbsj2Izl2rmdrCkmzER
 pSWJGh9RxECUwwjkx4yodk+9UaDY1n45RXvNL7Tg5M/2oj6J8u0lJ8s15wCh0+AgJX51rTsCKVh
 lR2zaK3emdJwyNljBm/GFYKZd4nMT0Xp1/M39lCs1JroMNsJEoYevQPjAHLbYH0K7IzDZwuTGr6
 jx6/17TYNOCUlgL2fEoPZaIN7R7Z/X5vdE9+X+a8fMX9LtC1nXZoZZQNuNEptNxF9saeXI8hw+4
 nB6jNugyCHNlPo6GkO0CSwsEKwJrKg5nM5x8Ly61py0gKf0ObTqXdhG2y6B0J/9RUpHFx2HOtCx
 Kf3AkAS/LZ/1oGM6tvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

Add an API dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index abf26951819a..1f26283b2dee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -571,6 +571,30 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[0]);
+
+	if (IS_ERR(dp->panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	/* FIXME: move out of panel */
+	memcpy(dp_panel->dpcd, dp->panel->dpcd, DP_RECEIVER_CAP_SIZE);
+	memcpy(&dp_panel->link_info, &dp->panel->link_info,
+	       sizeof(dp->panel->link_info));
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 2548f67cd441..5f3ef295d710 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -59,4 +59,5 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

