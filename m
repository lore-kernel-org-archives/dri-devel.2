Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E2CCA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D28710ECA7;
	Tue, 29 Sep 2026 04:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLbhmTcd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AaZyU0+e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C23E10EC98
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47fhe4052905
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=; b=QLbhmTcdmCaGgkKu
 iztbDsfU7hZOTc+wYD7K1HIQqNmoUvLNY1ULap3Gv/RbNGqQjRBAO2A5PsfnsWrt
 2Xh3oyPq6UqtN+3Ui3l3QdidMwYwm/rXRn45AQvfcRcr+P/Lx2NUJpwb1jJoC8ck
 H4702V6E3664+AesNWUPUu5G4NbYeIpHqwS6+vwQO4CuzjXs01HkrtkvkqRpUoW7
 nDAVmzpVryFaEu8ivx209kktB4IveA9GUwR7RBVDQrxE8ILzGrrI5SlS56fLK/3V
 E2DVN0deSBb0SdIuyOm1BQ+qHG/0383sVDxnAKEtvTo9W3vqn3r30V+77QAxHo3I
 /Blvvw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2bt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91235881828so77517656d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656040; x=1791260840;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=;
 b=AaZyU0+e31jEbGmz/4t0DD7uVMsJnjFIkeGBOEoMoFbVW5mn2rI/GqZKQ+R5ywwfWr
 kZtYJpn1CKpi6weiCriSRFgYSmkElDBEk0uLRcSjSn9gUn9yoWOUuqulhl/j7fAQoZ5O
 FmZxnV7J92CoLzpR39mIw/DFGQkJTfne7FGG7RFBu3n1nbHV9yjD5Dtudj/7FkyYXe8v
 Zf9DhvO8arl8QlJ+aL8UeiASBEcAhz3NSfaRuKcN/KFeefoHbdnSLLi8RHIQYsByEi1z
 u1wWtSaBcJm3dZl0GQ9T0v976FyD0X0IIkNqHPqi3kSp3v97Z5yxadRqcdGfwZrz/7hK
 xRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656040; x=1791260840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=;
 b=IQyLAH6glhGxSGkYjLFnGC6+raNSJM2l+lZmYdn5TN6b2Q/gcltUu7B31D3ECY0b6Y
 /1SAEvF4/TGF4SisPtT1a4foizH2Pw/vDutv/9vy2p2VMGnLLAMhqEWPpm6wiTGhOiY9
 JFfWwYff/URCJdBvmxkV9VrJEYWQv6PVf/mgWlCauPGwwFYTEwae7sLFPa0VdO2buFUP
 dLzo3OWz0ST6U7x9p4h9fF6H4Ug8JGgaPs9tLcY9CG7XNRg0P3VxtozyG70mFK0x9hqy
 exffNBvLOtPDXlo0SeWyYwR9ZboqcXWU6VAlt0nYhOTIhWCajyomJz9OuvvbXxvFZp0o
 VbxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdCImxHS1RZzUn2lA4qL9hGzzy4lzImGzyqH3VuqFvoO8gJTHD3Q8qXAZB3AdZ88CFnFQncgb7bJQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLhioPCkZ8SHAD8JjkJrlfKdKZ8DpS5q4QH7+Xz9u5Mg30cKGT1
 4CSLXfMpGAgnXCS8ao528H7R3nmJDTGEYtGZPplR1R2LLBi0SkiJQO+E4arevdDmkxGWNKWePac
 1udtg0BvkgZhIwsZwSBXR+FM1kMNWUjSr5m9P3HPdDbEa/79ZTWJSSF3ijRGwJOXR/r3lSh8=
X-Gm-Gg: AYBFou3gG25jEAlmsm8TBzRxVtbwSHq39h2pkaVHuzBmfQgcITTKAkoke5zdW3fnb1o
 9DXQ3ZbLGW7rmT5N8W2RgBJnNQhgTSL0ddWkC76KMJpM4+4YWX+oAJq2/cXIjRQx6rBCeOgZqeV
 7eDDPibcUdHHvGTXgapXd7Nk0FfFhmtS29zg3bIApu0zF3EtiVJk4MufIvpQX/Hr2Rg44kO65kF
 1HLGVcIoKUkgokC9PCsQbFqjVJpoUh+9gfBfOnwLMHZyZ+ONLThvc/PBIKuMVhXTrsTlkf/2AmD
 RCc1daOvW8gxhEG7xfF6G76NqewEA8XK9hI23eXQaSOEgMC2VYaOBSnZGTAGHPbMioL/wcXo4J0
 SZX/Gts6Y0MJNCes36VdGOUjsSx5C1zd6u1WDkOomYxkZzsGofz9puYoshzU5/g4=
X-Received: by 2002:ad4:5aa9:0:b0:917:8c52:f52a with SMTP id
 6a1803df08f44-9178c52f5d2mr6396986d6.34.1790656040548; 
 Mon, 28 Sep 2026 21:27:20 -0700 (PDT)
X-Received: by 2002:ad4:5aa9:0:b0:917:8c52:f52a with SMTP id
 6a1803df08f44-9178c52f5d2mr6396646d6.34.1790656040054; 
 Mon, 28 Sep 2026 21:27:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:35 +0800
Subject: [PATCH v7 11/35] drm/msm/dp: always program MST_FIFO_CONSTANT_FILL
 for MST use cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-11-4b81473185e7@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2539;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=mtZ1HCvBc/lbpNSY8CTLdvHlrW0O7SuiIwZF96PT1pI=;
 b=8BjdvXk6h/sGDH/HoBzjSHm8Nyp8E8d3ShDrhW8Z0VK6qNXbE/gCZvvIW/gvpJK2hj3sCQ4HA
 qBP1z+6216GAmpsK1+tZ64vLB8yX70o9OQUzu9UmUmgKi4azG1zZnpl
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxknTmfSpk+Qf
 HlXwEXk8JldeEwE9wMqksYR6MppRbtvvJ595nos6Kt0DNQIIWwVxcRIbabWPWoithJ3ag0YNBtt
 l1Is4KE6zvalIotr8NYXuHHEY9zbb3g=
X-Proofpoint-GUID: 7qd3CVAeJwg9BAMT-WybEHV7xdwcT54F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX6cYrg4Cx8K1H
 yu0rUNQsh8LDbGjlcHuQQxrXlwLykG7fSK7+MgnLi27G3+dWxYHJRsBnC/3QvRLUy1HcL542x22
 KCrmQFdI5y3zD3VtC9fBQJe/+BFGOvgIMDd26zEWzarWWN2Fl7nAM5nzZ88erTgI7iwX1JW9Ov2
 YbNCqtxcY3Uvaa/EHPODnTmKuSw3Oe7kd2X5OW3lA7tn5saMmgw28VnOYlpdXqMMjcfq8OJGmmu
 8x/LAioIdeKN+ex+cgafXCySyb7tqCmqExWJzk/LmxcLpc56fYsfA/U45ND+p3P0CUtseP+QBAr
 73mBxA3XbBVu8kcxF23/2oBgqNZWvgA3Br3FRxe/u4iw3KoT8N+qTWvpGzxqGIoLWhQ8EeX0KLt
 AF0qpN0GXFMtlrabWjav7CsZYPMftf1LHjIMXwWKvtcGT4dEgv1xD3pWGyOqxoTn/TiLQp5L8yL
 MpGKQ++XLpwWq9Mzwsg==
X-Proofpoint-ORIG-GUID: 7qd3CVAeJwg9BAMT-WybEHV7xdwcT54F
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e29 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
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
index 77506e840883..9a0c9737e6d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -584,6 +584,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(panel, ctrl->mst_active);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d3468b73fdc3..bc7bad5ca3b1 100644
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
index dc046fec24fc..04938b9d2091 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -72,6 +72,8 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en);
+
 /**
  * is_link_rate_valid() - validates the link rate
  * @bw_code: link rate requested by the sink

-- 
2.43.0

