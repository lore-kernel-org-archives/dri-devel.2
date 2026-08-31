Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1236DC624C8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCFB10E745;
	Mon, 31 Aug 2026 08:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kd25IvlE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLysNrU8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A0410E744
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xgTI2419530
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /7utkUh5DGGPO01r3em/y3HgsFdRZPOx4e1kb8cs6dU=; b=kd25IvlEbuF+4tjB
 KaRS94/MW8qqX4RTVbMyfOEDuyNxecC1cZrdrqoRL/XWBJMlGbVjIHVHYb6WFD/y
 e2tvB0eYjAlG1TPNFNtUNBKiAw+597V4R6CymwwXcLeSxO9WNCx3uvrM44s21L+u
 t/+FKy4rLXDxW14/g/v8ZS3SCGDxqtU0N7r/Bcx9J3bBXXoSyZ5DEjlLxSigGQ2T
 C/P9F48oXH8Ims5WuUoBv2XFNZIYIrHmdZSPCwOOIAkFfMQgTk5/8+K0kAggQSyz
 RUVzghOBCF7FLe4kpnteZPhe7ZxyrFjSSkeo1vbS+rb0aVlkwtKFLloPqS5eulZr
 7UgdhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6nc9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so455969185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164409; x=1788769209;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7utkUh5DGGPO01r3em/y3HgsFdRZPOx4e1kb8cs6dU=;
 b=jLysNrU85/yZOS12IUVCzAj1TJ3/3SJ97ReAp76h3KDrf6nt1h8MO5RTsAZnH2+VGU
 iU+SxLZXeLDrTf51vAHsHm/25jl/SoDD1ifY1VKxxABwkJ2QeQyr6t5FesrCLcOl+8M/
 +6LlJzlXCcDgLtBqOOGG9ZTIA/00uW1eDiA6qQ2eIQszryitNllqhQdwAojSwMyISEqu
 ycnvOUUtMX3slLsK9/KmoYQzffw45MFd5ygySb4Acvhzwqd6GUgZb64Xr6RlQlL0wzEg
 zm6kcoaZOm+QFCAngrAVmFfyRRdnKBngbVxg3UQeItcJatGhp7VJZJXB7AfaT2RVvA9/
 sIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164409; x=1788769209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/7utkUh5DGGPO01r3em/y3HgsFdRZPOx4e1kb8cs6dU=;
 b=IsTHZPZPYxqnd3mvEWDWpk3W4NxGSVxYylVGCxUzuHxJ6XvFm3uqmr5DxI8EVOwGZt
 JVScCI1uCR6XHxqcb59dNX4YmEluCwxd7MBIwNO4wLIrPLltotlVXAdGnkkjsuOjwfEO
 dHiVJW+ZVAwK7ywRJqV35EQa/yjcVHYa33HGLnP6Wv2sM21jpG+u7tooWkCcjyOXfrtr
 BydQ9EfCSltK+CIjLzEoDy2MaaOUdp4vlR3qIa6j58XMf7Y2OfTCvp7W6Sgal0Ac6N73
 6IKJarL09IL73IKA531v/9LmLG35dUc+RxAJ4lgx73Cr7KJqpyaVUUe9y8AfJed3QlPl
 r7tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTUfhNFyLm/oxedzqsr/VtCy5J7e0JJ7B4Jiy/4VOSuop0BTaaIAaj78FbCORiqylemZlw4eidLtI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l61aFzalswLTbx125aS10S+ov7YH8Z2lt9XYke3xntzuxme3Ca
 1sZHrLtrHYe2tSK1es/BUBKBih4mvZqO9FHF/Q+wZWwv0gv87rpPATQ76Hw2wNVC1AVXbOoTRTj
 g09nu8ViyjvUuLKVy5zMK0Qmdf5zMc8cewjO/Nf66nowrSXchs50Vfv7CTmZswbQ26kiJ+pc=
X-Gm-Gg: AR+sD13F2fTHaGro4ib1HkYZCESeqEOBMOZVx1AZ2qstedmci8MZpo1zTsvsvLzTyjZ
 fkarah1R/GjcgXF1BVDUL1yGIAKbUfFdH+s8/r7VijUBsOXfbZU4tsV8LNlVhfwZYXiJGudnKcl
 I+JUKIxLKCU6qwJEjrbyjF+ib3Bh1uUDM4wQhD18hd/1683ue1f+fFtSPYS/l0JC+5RQR2HOq8h
 pGmJqSO3k6KN7kTiHvxG9s0x+vVR4DATyEVejEdw004QalYOuLFIqNnyuBQ15fvpnC7n/omKUkJ
 69d6XBLLHromxlF3oUQkwwYtTb+ypELRCWgtjh4mi+nCbIBrTHYW2xE7wVr0tHFqMwR3BWz2kWb
 7oc2kjCWurEc7JYMLIue+3zDE05w1Tx70uy/0bf79H9aKoKZPn/IKTbrXMtTLlys=
X-Received: by 2002:a05:620a:271c:b0:92e:520a:ffab with SMTP id
 af79cd13be357-93942bc5d61mr128905185a.38.1788164408766; 
 Mon, 31 Aug 2026 01:20:08 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:92e:520a:ffab with SMTP id
 af79cd13be357-93942bc5d61mr128900785a.38.1788164408148; 
 Mon, 31 Aug 2026 01:20:08 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:20:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:45 +0800
Subject: [PATCH v6 28/29] drm/msm/dp: mark the SST bridge disconnected when
 an MST-capable sink is present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-28-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=1360;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=FtG0OtAF0cEV+melS90shLLkD3JKef4yMUSpzTrvG9o=;
 b=MAsD4O/FZCIw+md7L0Mbc7jZOxHxc3x02AYpVe088cK6PBce079tY51MoNdgezu/eyHlnTIg3
 CY1micG7rFhBNpDJk0ulGpI/QzDEfMaODS7egHsxGwNdPegiXikUJFt
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: tDEByX2cx_fOlmHq2DyGQpOqLadskB7Z
X-Proofpoint-GUID: tDEByX2cx_fOlmHq2DyGQpOqLadskB7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXy4ek/ct0+8TF
 xw4sD0AIMhI3YyeEUTx17zDAUcOQO56fFkMEf5cJLGTV/mcTHsafZV0sjFj3hgvDa4OpybTk8RV
 8Ju6hUcUrO8c3WwXnqkja90BNqiTpsvwPKEDpdn7jypAbiwhCM5PVOxIjmwPGUp8pqbA92X5BKq
 Sek2HU6GphbLCsLCOZT9J03B1yyCrNUCzS01HDb5t9mf8wZQ/6Vp/wjxEFnTQyME3+pBKkzPvcI
 I39vz4yqgfLvdO3xT7oK7fQGhWYvYZC5U7k8W8Z7vgZOzsmUgQC2muZpBIEpCa6IXXSLbPPISaM
 KwqmxqKwf+Wxd5Nn7M0tS+W9AFqRfnRlIqneCpWYnw8L3pbLzTJbs6meWTHCb3YpIg44/BbVplO
 /bc0UkG7wS52R7YmQb+pnWQMNeOQEykMqWdzzNT6kYaTdZWRUOnkoO2FZ7HQiuE7THIqAAetlAR
 T6dMNQ74mZagMut7QaQ==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a953939 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E_DJWZ853T03DlUWG8wA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX0ZnDJp2J9mI7
 O5sDoCEHFenbZAYPLCp4qI0ClJSxey1PV7xYwU2mMLSljFwfzeG2fpRut48sTxzi2hX2yCY2ojf
 cjHGL+LtayCfKuW40/V98nK2mnu3BAU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dbc0e82d333a..d2b2c7141db0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1052,6 +1052,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			status = connector_status_disconnected;
 	}
 
+	/* Mark SST connector as disconnected in DP boot-up case*/
+	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 && drm_dp_read_mst_cap(priv->aux, dpcd))
+		status = connector_status_disconnected;
+
 end:
 	/*
 	 * If we detected the DPRX, leave the controller on so that it doesn't

-- 
2.43.0

