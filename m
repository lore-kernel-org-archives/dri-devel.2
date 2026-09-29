Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F101CA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63D710ECC4;
	Tue, 29 Sep 2026 04:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V052ugJ4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFYO3/Sn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B004310ECC2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Hq92774997
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hOq7VIBslc55pX7juh2Nxe8h7Akt+B0A2pEl6naHBj8=; b=V052ugJ4zHcSbCLp
 exXlAEviZdoyGPqnTUzfB7bUtuC1Cp97ryz6+6pqc3Pi6hI/00+tReypjDAtCtv7
 F8PGp53oUvT8qrjCTaqNGi84g68zwcILEl+W6urYivlSlyNX1VKfLYMPwKD+0Xiy
 Equ1WuFecjTUYp3cxywgj2XCiENPpMW5IviVxWxQvN4NHFXvSHFGtfzsnEtqAIAJ
 y1vAaCFGponvKTk7UoLe1BCEGx6ORSBI4DJ/TuqY0b7ARxh0T1AUBxSdF4EL1fbs
 ldv/dOuR1gehCNQLTwEeXG/EmhVJLRA2kHjUm2kR0bG9+C+WQJDchASM3yX/Lhh3
 E4vhCQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw224ex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9143d796129so64831966d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656133; x=1791260933;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hOq7VIBslc55pX7juh2Nxe8h7Akt+B0A2pEl6naHBj8=;
 b=CFYO3/SngSX6LGOQgUVkZsSwyi2KhBj9btU18b3AuLOMtXIJypNrDxKow3fSHUfQlZ
 31T9UTNe13ubIVBje5Vswz8c0WUJahGzriKLzcsCOtvjuG8ktxPQ5lPLmTNdEgt+XUmq
 /NQePoYPKU+BS0aRvZKFQjUQrMK0X7+0z5S+x8C3ByPSvmw8TY8HhS4ImGfsNiNXMKYh
 upJz+sUIih38MngyBKSwkNWFZXBDxLMInOELRUFceFWg/b13nqW7mNKnAxUfutWWUX7a
 GQnxfdr6GPDndO1hGDfu3o2sFBhFqoUShoZZMfNQ0bWloW5UkADBi/+J1x54Sk3Xk9KN
 Vgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656133; x=1791260933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hOq7VIBslc55pX7juh2Nxe8h7Akt+B0A2pEl6naHBj8=;
 b=y7EZhGQbcLoLv3p4Cz7kO+1II2Q72KZKbKyAJr7ZKOMKWxcbtyPQhtcPXspsENCg0w
 d0Jjc6V8abCzADQmi/V2+XFK4uOojpokb2zhhX9/cj2WFE/S8ejukFC6qeQ5gqXS+7YY
 BcXzULlCSZOqUmb4CPZnXIjohEOeXDbhi9cRQm5oz97k6AzKxgqsERe4kCos/MYtwZzQ
 NwDChxn+33DjuPVDhnumYU7JnxQLO+f9Olg2TOkVHMyg762V3Dn/2XBIM8bxrDxGE3I4
 UIPrTlYhxo3VGfJ3Jeivu+wLEUm305M1/yughdf9OHw+Jpk44OjuyC4/BHVx5Q5vvQPc
 Qj7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxesfz1HVvQTtq9H7KNFU3c1Sn+U9pvCV+JlSUIw9Ik+HPHeXmW+Crxkg9Xk/qvpN+xRZj7GSl85Yc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEejTjGMJTTzkkz2gPFEbsgU6rI9OCv9R+7xUHLfffLjAFms5E
 L/qDvtWrR1sb5lzVjyUT09V2/f+tc/Lw/WnIPx3uiouMIKMdo/QlRr7cf4QNmBU13gtKrDGvSPp
 muy6GzZoeI9F6czJUl1bEi3lxbHq7m/XZ+8D89XjVzhl2oBv4/EQUy0s3Pap3kCD56/Fi86A=
X-Gm-Gg: AYBFou3se0pYvN1tmbMRR2w/PrbNellBebLt+YyAG77HlYGB5cBDiLcHindw9/LoIMl
 6iZpL8r/rlBHexsi+B4uQLJ2FMkl1eyLpQS7BW45gZSlAUvlKgyyhcVD0t0YMZMTmgZBsHE85qb
 SIcrnk9wkCqnvpGDmmjfvDq77iSJtZQRCuB/tc/aOdGq8O4+MBAgl2EiduPLb+FaD+WeZH1ZhaN
 BiVFNUOBq9TYvnP0Rfgw8YrQexWF0AR54MCUZyceLj9NxYcaTXaJ2Aq/WuRMBu+jJ0hOZrRMHXI
 VXujSLm0MyxId9NQW3PGvhlmR+LoGDMklLYGiaUkuM4Fh9rtfhbxvMa2Vwo0ZXXbiIs01fbCh4S
 fhVgM2yYLTIvMNOLhiscJrbxvidhGtIen+gDShG9Mt7kGJO/cw2acsPSzEgfRyM0=
X-Received: by 2002:ad4:5766:0:b0:916:57f9:6b6 with SMTP id
 6a1803df08f44-91657f93836mr79982036d6.46.1790656133077; 
 Mon, 28 Sep 2026 21:28:53 -0700 (PDT)
X-Received: by 2002:ad4:5766:0:b0:916:57f9:6b6 with SMTP id
 6a1803df08f44-91657f93836mr79981786d6.46.1790656132652; 
 Mon, 28 Sep 2026 21:28:52 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:52 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:55 +0800
Subject: [PATCH v7 31/35] drm/msm/dp: mark the SST bridge disconnected when
 an MST-capable sink is present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-31-4b81473185e7@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1383;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Q0M9eu0gJ8kozUV6W/p0p4f4GrBEI4mkkt4w23E91HU=;
 b=rvmfUrXoCdDbySP7zij2KQN5vq44q01KMRK9e9P5BIlKVibYvveFS4CBnqdfrCJVQzhl1vJhY
 /lVN0vF1HkRAbTd1wpuGzKQ46jUv197v2BH3LTo66D3YbABQT/OO5gn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb3e86 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E_DJWZ853T03DlUWG8wA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DZSy0jahGNRUmp6qsOt_VFLfjGTuYxJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX1j/Z0GWDFX1B
 VumNrKENGuEOUjL+Hogh6jarNWAZjqkOUQsHcVHUtcXYdqDGw3VDPFa8/Iwf3Z13op9ElLZE5ST
 yUYCrQfN4nc75cBSQgo921r6yJx36vZUSG0JnUzki2s/yHuz0yOsf7l5ZiYfAPokXIJUQOL6+9t
 8iG7M+O14/X2soZIIRtSPuYOA8VvlGwRwszjk3ySncCBfJEJjCfWY5DP5mfBAFCZC1m/v+Y4RC5
 l4fxw5wUeyVEaFLvDxkUiUxT6G3+eWkpXSFVAaJKSlCbBiobafjx7OgxSOjGMO6FRonLvRbnMOX
 L0wOBrQCsPJGAogJrN6B3pxJM9bizNnAGf4OA090ZssUE+KXWvNqf+G+fu3EO8TpUqw+8Z2Jaab
 D396owXMZiHi761IabugYmdHnB28S4V+p5CDH3h2CzU2XurxMoDICeWEsQGEvnG27PcRE2LVaIJ
 ssMTbIuHKamuf5UMn0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX5agID9cJYlOf
 qPQg/wBsQ4cxaIUSYc/aymynX8FF4x8zfhiZkw3GU274m2kszYV/x2t+AMcWbEMn0pvV3OLWYt4
 VuyZlKuwK2O/jx7+c8c6zMaJi8yz/sw=
X-Proofpoint-GUID: DZSy0jahGNRUmp6qsOt_VFLfjGTuYxJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

When a DP cable is already attached at boot, msm_dp_bridge_detect()
runs from the connector notify path before MST has been activated on
the sink. The DPCD capability read at that point already indicates
that the sink supports MST.

Return connector_status_disconnected from the SST bridge whenever the
controller supports multi-stream (stream_cnt > 1) and the sink reports
MST capability, so that connector detection is handled by MST
connectors instead of the SST bridge.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e913ed91bbfd..0e8181932c27 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1057,6 +1057,11 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			status = connector_status_disconnected;
 	}
 
+	/* Mark SST connector as disconnected in DP boot-up case */
+	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 &&
+	    drm_dp_read_mst_cap(priv->aux, dpcd) == DRM_DP_MST)
+		status = connector_status_disconnected;
+
 end:
 	/*
 	 * If we detected the DPRX, leave the controller on so that it doesn't

-- 
2.43.0

