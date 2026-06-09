Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EC9CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E7710E1E3;
	Tue,  9 Jun 2026 09:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+hW7hmP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZW/TV36x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CF010E1F8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rbPu2034541
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=; b=D+hW7hmPAwJOQP5X
 s5zO3sRRK6NmN5OGElUEjgIjgGVFMQoPO4+NTNn6Zr2LlKq4CxY9mfrQMqUtk0cL
 RBl1TbNsvsxYghlru9i8Qo3CIx8Zmqaqj6my1M261U7P5gdH3AbwTFTnePsX2RqL
 w2X3GtyAiRUlHZ6zLLkiXlh962PyVeJ6IjviCngCLYMndrqpasg25GXo0svumuCz
 0gSy7uX5sNOi8LJfWuMiluGYr3Uia+SBF/GUUnNzQVyMQlAwOPyCIE8Q5Gpv90Z7
 tjokGk6aGNnkwMYaMGZSpJYVQIv0ZQlVBuD3/zDQ/ZOYvE/TxH28qZGSj2bHfc9M
 9nUb3Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeearjke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9158f2c4b55so1044913285a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998423; x=1781603223;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=;
 b=ZW/TV36x2+5oA+EHWeqE2fsPlMFrhAS0ZgfHXvpeeziqtivuVw6DawKtZp0ld16fjc
 V4MyXdMNtrWqZxwzwlF1VT8injyt2Y2SO4IrMkNKAxQ+xId8r3znhj2KkFPOhzmMW0eh
 anmKG4idgV+Mj/atC3KEYJQj341D2CAKANuAB7rvfFts+/N3V5luWCd0lbg8E4OinCXF
 3jjByFl63QSvfW4RjPrlqwpR4VSPByc2ax96nvYOR2FbHe2ybO3TGrsil1LIM/EPEXwT
 J74WIFU1LHDZs2KVi/6Xy2JemFWzHNduVoUCP0lsjQzRCbHWfVQ5FPOT8lP3piwLruUw
 ak0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998423; x=1781603223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=;
 b=ASfRBpKo+5ObcLOlDvRb6kbGp3lxV2duauONICWoxLWoeut1teGs85/1fNsDvRYfxQ
 zFLPYN2ido8YEHPylluYLUNZappkRqc9oZNTrPcHQdQu2/gzNYGLWw7HLwP7h6DLsvUB
 ruD2S5cZFKCqxSyT/8p1VOWdsW7lgdppwK8TKrpoBb7nk6O1bjC6CdWAuFBleuYwwFdj
 rNTU5zQI9mjkzoTz0oAHOQtzRO2Ed1fJhAdFL6Z9XdZ4tSDSIWs8FZtj287ejehwY3rY
 1t786T165KpenaRT5alIeC8K5VpGrQN0G20ahdmvg1CUaAD9E3VVjkxnbVMAL/IJRZwX
 Pn+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dm/VV7Q9vqmxUFKJe2ojVrh3gsT1sxcpfAQ1DzicVi5xMj2b/SMwcWGkGcA8l+3m1kYOJJ+zRf4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9fkVKrqL3WsOMVNDRQK8Bgevs2gfzpTG88Z+gJF71l32dzeIO
 N2zPhMTlnQ0oxj7LFE72xTI9Za7YBn+pAqus0bbrAxMRKNJljrSBRh6MQWQZqP3UXCkbhgwGh6Y
 VrD9ajShUyRgVORzGjMtlN0m6uM+HE064vEFD5flxjQNQPay/YypgfcCw/50cNTDG8/JEcQc=
X-Gm-Gg: Acq92OGb9clWaWPLVRP4WqsbTQlOIpXo0umLwZkbsF8m6WEtWATVIJTSo8MnqCh/HNF
 oruYW9ZRDKRnfQ/zdqOl0GxH+XNq6vWV3TgxNf7Sukam1YXkP2wnV/anrKLDhT0LOUg/VhKK6Pr
 D2gx4D8i3XJWU8RgXHWE+Ran+dmGCIWOZYp9J8KKWzrYpWFhyzrtUmQDkBwlk/4mz0doCK0/7GA
 Ww9PV1uNeTFqgrDSPNWnH/l5f9JQO5+6K72XoFvBlx4p3xNScQsIqB1xidkRTVggh3ifL7g8/Jg
 W9B0DUU/HkRhYcz4u8yfyD5kRVD2jR7nrw/8mQ6J1a8uLERw9tWJaYUZXtZBvFKghI8duCvTBJx
 hNvfwKOb8Wmlhk3LLHTvEqbqKkjGXcYOsbf08g0BLHs1ItK/Sx14kHtEPlOxPjWbvf49KlGldTo
 qvGFl7euKhMCKUj0FeUQ==
X-Received: by 2002:a05:620a:6507:b0:915:9d08:94e1 with SMTP id
 af79cd13be357-915e831bbbbmr245012885a.46.1780998423366; 
 Tue, 09 Jun 2026 02:47:03 -0700 (PDT)
X-Received: by 2002:a05:620a:6507:b0:915:9d08:94e1 with SMTP id
 af79cd13be357-915e831bbbbmr245009585a.46.1780998422916; 
 Tue, 09 Jun 2026 02:47:02 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:27 +0800
Subject: [PATCH v7 05/15] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-5-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998392; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=k2Fff3upCougTurRhx1qk32jaQDI5eLSE+rUossKmgQ=;
 b=xb11ZGlCXDEh1bxcp6TS59hAhz44+4Cx8Agb9A0zHrLtoMrZCIw9sWK1MQJilzjEp8GYmTx9D
 VTzcFfrPaTwBpb/CCAgH0oiIOEmPL0DUERHxacmp5TPFNbBMQLcOdIu
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: OqgAWyNfQhhvdcFmBe5B8qPTUyyTxRK7
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27e117 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TC1OlXllJ9dbkp4NpB8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfXw1ShdqcgFrVm
 MqF+1CjeWSEM6fNY1EOZPzaqDCKpcBqvyOZEp4VXS7YpuX97qlyM1QqMi+p4I8H613VgW18H1k9
 ldoeALsY8SIfppnqVeTNYTj+Mbj52u4ALqgM4q862aXikpDB0KoKmBxrV4sH71lnun1/X+lxY+Y
 aVoR00JVfHHFTy+jE7U8nAFfO3AX9uUrGrEtHZkOANmkoZUD3CtblXyupABIsuZfKoE3gYOm+gn
 nGoA23XiQ22b29tU0e4kWEhctoPuo9vdX+0VbKXZ1mOds3S70wSP14oyJ+cGHUAnddRnXA43CuL
 cvdhPk64fy3gP+NmrVyU2ch7XZ1e75xEHjHNn4WJD3gUcjGgsfo4qLJKDAf1R12P79codVzOfKJ
 F46nAqGEZXWN4kKq9cluctx68BYWkOLpamSy4u7/1KHZJc9SsDh5TtvO3vkQ31j8YPRPNJH8m17
 4muAsc1qoRs39D3S+8A==
X-Proofpoint-GUID: OqgAWyNfQhhvdcFmBe5B8qPTUyyTxRK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

Refactor the MISC1_MISC0 register configuration into a standalone helper
function to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ed2ba47881fd..71d45b2c4daf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -458,17 +458,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -482,6 +478,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.43.0

