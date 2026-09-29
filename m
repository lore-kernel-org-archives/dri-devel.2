Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6561CA5FB1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FEA10ECB1;
	Tue, 29 Sep 2026 04:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXhUrV9W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMEt0cXQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C8210EC98
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T475Ah3390855
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=; b=JXhUrV9WX+8SdlkW
 l/kztBKEDeXYOML2v+4d6jY+22/2fIWsytujgg3vnEj4hIJP0Xn1JJW8eU/hygi+
 zDWPM05/b+T56RbCsxceQ74BrSnkfKwn6vrBKR/iKe9KBnjvPvRf1ZsoiL8Ohe9J
 S4B/C57+F1k6KBjMfyJgXnQAQu8yAY+7VHs4P7zJLQ+ROVM2paSc81y6cZC0j9Eu
 3xBDzAUfPtoi6ocBlpapfAqw4z0os4Pm00zQSisLw4uJgDTkHgaCGiboTVptLMmA
 YrvQB0RKeMid3rTi3m0jgQNunauEM6DwdpW9dILS1L5xMdk17dX0DUMlE15zG4w1
 CjO1Fw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkgvgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bfb2da664so1088017885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656083; x=1791260883;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=;
 b=HMEt0cXQmMm2PDwTg1rN50KRvDYlCqAkwZc0RQ8CpcKwidiQel+vhUVyxo/FptLV79
 PcMu/6g5FB9WVcopPJS6lNOmNEVdscJpIXFxeAryYSJ4Gggd4i8U24ZUq2uA9iZuWGVN
 dVw/07PkW7xTyiPcrW0Vz+/3b6/S+AIB2RhszACIyoM+W5I9SSKfUMJ763WNyD3jANgv
 pg7p+gN7vjMomLlSVkscVWRZFRmnBv57HJ1BEGjdOrs+nv1N+CHFNOYdtC1Gw/LyIDrA
 aJO9DKfT7HfNyz5YPiUiyC7Yfg20NpyS5SpSNwXUVmQAPJV8CZO2RpTUl9L889DIy9Hb
 ivVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656083; x=1791260883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=;
 b=IjmcnLqAymCEdfBUwuWkHKE0VhUwK2+a1teFthJclpi9hQ5dtdtvIXla/rbfIZAWo3
 uHQoU/tmpsBl2ybtipjGpSZ1S5M7tZOePHXz7PrAA9hUHF/v+tnkEL3kEWkPfOHsHMc9
 VIIqnWh8o9WXQXma4w85J/5uNbmN9PMSBlzQMK3hZKuIOKGiYERURzT2BKnxYqJ6eWa3
 XFpJNJtGyL+MJRsWmDPIGiP62bVB4fwHs2tEPjbUF5yrkVqvfQEhQEFE1k3GNb7bDwX3
 laydLKNC+mT7D7upvy04sq0/7Ek15uxZ/aMCUNiyzY+UCJZX0vxnULILJZ0p13c6f7D0
 ay4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2U/lahniCkXepyZJrahEXtj/c6aOrulSoMvKtYuZM47lKgduQNbRgKpmakoHdyScqvK2vw7w3iIc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0P+/DF9FpCoPKa6PqnqOl+aXgfErB8lMhRf0QZKTXJ8RpAAd2
 gBBiWw2rVOkss7uR7fwXexDFWxHIAMRl1j3R3QG3lC/KEX9APR3frSkHIMP99HM6j2zU9qeyfi0
 Mudjs/zXSJ6f+7X2uKsIVG/30QALDiOc7rAYL3RtMFfprzKVXe19pysRKRUoJ7Zl7d99hdPYj7p
 9m25c=
X-Gm-Gg: AYBFou0Fx3SCXlAfMYHj2oPxuoLZd+qkxPOFEWdSLMG/4jqKLls4hgm/eggQrV/rvKb
 A8poydeh3/BDoWJjxyLdRPdnS62ypgmUO0Klb/rRs8cSbz5FCJnVNWf9B4bd3/b3c53MvzpJk1+
 kxx4rnpQR4tqFKh1ps51SW/244bs3w5QSKWBIlqWZ7w/w7ofnlJT/QckAoyPcaXvNFi4h2FLqXR
 5Mty/NYxuMFsCN2mCgbaX2P29Hk7Egz2fTWub3V9dHL7oy26E9TQ3pAIQLyzWE7jtqSUpCZ+uib
 QRbpJ/Bg1yTg5PZMoQlav01vuRxi95SXIxy4UvcrhNyWE0qehzTyOwToi/EznDG/Tqx14BgNnn+
 +XcnaREnj5xL091Jvk16ttKBgo49uPAi+qtQs3X4nwMsAjI3T02FriOc32xmipqM=
X-Received: by 2002:a05:620a:6602:b0:939:f89:3688 with SMTP id
 af79cd13be357-93c47498f78mr2243576785a.42.1790656082750; 
 Mon, 28 Sep 2026 21:28:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6602:b0:939:f89:3688 with SMTP id
 af79cd13be357-93c47498f78mr2243573985a.42.1790656082256; 
 Mon, 28 Sep 2026 21:28:02 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:44 +0800
Subject: [PATCH v7 20/35] drm/msm/dpu: pass msm_display_info to
 dpu_encoder_get_intf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-20-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1951;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RFTciPI+nxW5BGq7bvVuLZ5n+fGy2vZwA3KysuQPE2w=;
 b=0ZpsaYMN1m/MNaf81oF/EXLAIvZEeuCkX6yO19dzRJ8r4d82ydlMdvRiZ7Z0HfczW4rySQgOa
 VP/5H8V6lcKAHnU16naqGY8Ktu7/z1Egq49zy7x5RPqbrXYfMy+athg
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/jBnsDn3ETe+
 mCjnfl77DLN9swiY2IiLTjaPHRfdFLOzZvWLITtN4mJwsV5hkZpo/ZeiDovXVf3GSNc7K5i0Jj2
 NzWYwNW/1EKoJbKGNMzv8KvQQ/0dokk52kzar6lNpOXF7idP8BcRGLUJtcr3tGsRUL181trzg97
 gUOcVPgtrH4yKdhIUlaa+glScnl1UvuoO1BpOdc38NcvZzYAStGuSkQklBCAGyw2ZdmxkKSab4m
 e032U2hHKKzhAoTqf5WZ/w1zZjXDhjq04p9MLxtH5c5GwOeIjrWoQK0WbjL/b22EDvkoVUvI8TN
 DSIQzIlSa/0zWpDZ5pxYYlJw1qPKCYsg8E4VJ0uIrt3WDPe9RWnFiT1n+xiuF8WrOBmoFYgYR97
 iha0GEn8iPwxNdtK0O1TSPAFEK50mO/MpIFy4ifdN624Y6tyz6AHO5qFlzfJnmuZUMJNwVZ7+Ag
 mmwxGdHRx7yf/tPBmdw==
X-Proofpoint-GUID: Fp7SNP7pnhPQ1cxQyKzKsdfFb-obTR-J
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb3e53 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TTd-C8IxYANZTSfMnlIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Fp7SNP7pnhPQ1cxQyKzKsdfFb-obTR-J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX+2FG59E7muA8
 VE9O4V0uVavM+1Qd3tqSm/+yeHhfKyFR3Zu0uXBkp8KjRaUzTt7F6bAWvkMx8f0HUMSZ0Anuy71
 4eTZuP7qOy/yCmewsWgxzL2oInB3fbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
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

Derive the controller ID from disp_info->h_tile_instance[index] instead
of passing it separately to dpu_encoder_get_intf().

This removes a redundant argument and keeps all interface selection
parameters in msm_display_info.

No functional change.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..91cbb0ca521b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1437,15 +1437,16 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
 		struct dpu_rm *dpu_rm,
-		enum dpu_intf_type type, u32 controller_id)
+		struct msm_display_info *disp_info, int index)
 {
 	int i = 0;
+	u32 controller_id = disp_info->h_tile_instance[index];
 
-	if (type == INTF_WB)
+	if (disp_info->intf_type == INTF_WB)
 		return NULL;
 
 	for (i = 0; i < catalog->intf_count; i++) {
-		if (catalog->intf[i].type == type
+		if (catalog->intf[i].type == disp_info->intf_type
 		    && catalog->intf[i].controller_id == controller_id) {
 			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
 		}
@@ -2674,8 +2675,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 				i, controller_id, phys_params.split_role);
 
 		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
-							   disp_info->intf_type,
-							   controller_id);
+							   disp_info, i);
 
 		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
 			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);

-- 
2.43.0

