Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8EDCA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862E10E7CE;
	Sat, 10 Oct 2026 13:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lnFFoJMh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DmpBMvSo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445BC10E814
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ACUxr33358178
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nHgDkse1J96XXA7m7gVuOIekqMbkMW4XF0e62Fe8Mkg=; b=lnFFoJMhIiExyeI9
 h4x0ut8XLz2je2DkZR/cXjPE6+o20p4RF5AYM1WmKaVX6rnweXmMuIAjGRfiFYes
 Ke7m1UpHxNt9p+lZUw2glOEbHGcBHNVhmOF7+9vDIDfRLTEpdntxjFkSFMnXdX2x
 x80nihr+tIYof4Q+AjuJmizoF94JIz3Zit6rGJuoGu33CxMKBzQYlv+RkpDv4LkU
 UgOPYNARZts08kDbxP2ZI6FVQB/MSI89gQfCucjIdr2+yDxiVd3zSiwYPkH8LSVj
 QuwZ4cz5EZ2iFHYTwdiJSPivyxyqkxpWPvKHT3+VmiWQODmFsnr91/dJNz4zW7mf
 wsSqAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjgy15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so1619415eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791639520; x=1792244320;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nHgDkse1J96XXA7m7gVuOIekqMbkMW4XF0e62Fe8Mkg=;
 b=DmpBMvSotA9OvoKcHOTw1RyM/75iFyIRgJERIpTLzmu+mMeZyvCqEszt72g3d7YeA2
 7VqsPRUWe8VW/Aq2kXek6xyWff+6fBhQenk99KLO98vcBKes+LTJQxRKvr89IV+DEbT2
 kAPLCi2E5CzTa8hDgAL0jIhZhFPS0TWSwAljjv2p6sgVZF/1nw67F4IrwIuxPCsRHc/i
 jlx3vwWjeV0ENGbcSRwh+mV+6Wl+v1PvyR4trXABK1UFiNrh1bO35eelRhNqxiQH64t+
 3TuTHQZQlrmUj08qqjQgSkgJY8BdSCv5m5ZmNSRJzNSp7TxfMFX1zKUW7Fqz+Dv9px4Z
 tlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791639520; x=1792244320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nHgDkse1J96XXA7m7gVuOIekqMbkMW4XF0e62Fe8Mkg=;
 b=AmBQhrnTBNkhP7KThH8dlXQLocTjNsRr7G94pRr6vYH2bq7ogoIBOQgrI1qrWJhZL1
 CjYIiG6S8cv8BkNkTS5UAFNY2V9OmSmeu5sN8X85kYc8zWxc3KZHgH0+QXQ7hTb4Re+m
 LI6BErQ65nMhNzu6b4hN8awRGfD0mzLlLiMJ4lvtGa2aOYj7lv/dWMTayzvyunfikfwg
 yFeIrYvFz9cguWlCaWEDr/dhq9AkzLxMpjUwew701zy8CSDRZ4EewM/et4WsOr3su8UU
 yAV55Dd/2w9p73t4k8Fi+rE6cgwhfOuAq43vmGc5fT8aqvmF9vb1Zzr564b5EpPdbe48
 tHzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPzh9SF9iaDg78hquWi/fNMZK06zSCXmTo5po96ybEtrxtW2x0ekRdFL3y3fNzlc62iYZXmVqCcH8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUaQPl6Cum085x751nLy3WQFk0PTggwdst+ZkpTRdlhTYcwHcp
 U8p452hDDy/jzbllxT2crCdHVe5WGD8QuN/tEQuMKES7lXhOhTjXMhfsQrK9cz4J6aUCGd02XQm
 G0/3Ft1I16y15bAapu3C/DLs64ASgbcBCW5+pOagXcsN8Pt1JdSS3ANFVX9AW/BTaUNRvtWU=
X-Gm-Gg: AYBFou2xcwXZhmiirVI/1HExIQBA4HOvQBjLfv4PueH4Linw0kU37VhkIfyCeFeMk0n
 wcybzAIdIAAX6sPJe2/B7p5MUl/7yrj/op3xBND2vwap6PE+zzM7QlefIe2wzEMNaUiXl19vjt7
 287nwRIb4Rpk3D1hw04aumkWcvx2TZ92qPmYKMNoyTpGNaQj04362pJGbh405FrQYEVI4+4Dngh
 ceVMGXqnQhwKUDqMmO+Fkwe08UPnHXexoue7ETknuErvhaD9vMKbAr3j7GUHu5bgkF2eO+iA+wf
 2vrA2mQVjfWmBl1Fgb7esjVZhHxchUBHl20Pp6BahsqKSKAUWJRsSy/D9pi/TC1AUlEdTsMced/
 yaHV8+SjNJ0qvkfwFRMPOvFm27A==
X-Received: by 2002:a05:693c:83c3:20b0:351:591b:7684 with SMTP id
 5a478bee46e88-3537e04271amr7620405eec.33.1791639519574; 
 Sat, 10 Oct 2026 06:38:39 -0700 (PDT)
X-Received: by 2002:a05:693c:83c3:20b0:351:591b:7684 with SMTP id
 5a478bee46e88-3537e04271amr7620350eec.33.1791639518619; 
 Sat, 10 Oct 2026 06:38:38 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm15232827eec.4.2026.10.10.06.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:38:38 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 19:08:22 +0530
Subject: [PATCH 2/4] drm/msm/dpu: add SSPP op to program the source split order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-pipe_order-v1-2-9d8bd29fd78a@oss.qualcomm.com>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
In-Reply-To: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791639504; l=4157;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=rmFIBBdLnwpW2eE/0l3ytGX1iuO0WIb/U+KmegawFdg=;
 b=R2KZBseePjfVkJAOeHkE5tcvy3+YCr50BkkxV1BOYcfpURVsHwkKo0EmCw80HY9MXspq/aQYn
 8awH61Fp+oeCp8uuuiOqev2jmNKrezKsRKehRqqemYL5NjGxezPobyk
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX8PduOnumGMdN
 wqGuzoHelNxk2D2GJqJXbjbPHriR/YkqVPhHoIKRXchMvtlaTmoiRpX2Fo5ts6dnry0q8DTggwd
 MKqiMfIcn6ftqeLRwOPFwvk4xDTlm5Zpg2VK9q1H+O/D0AnzyOWs+xlliJKBnLHXl5IaCmoYBb2
 FUtNb2iQpDPpRB7mgLSo5WHCcZmk/itXBK3KQUv1dURidRZgexMTf/u2oc49y2Z/Q0aDNM9ddtJ
 QR4CJISxIlianKecvkoawTnRb75hgInRSWEyg5LO6V8kpk+Mb4uFG5UH5nwsCW9Qll6VPM87TYn
 uSvAt0ia19Cu8sDu32QXkzerohSOPmv0MHLgVNRRkhsz5s98m4AC4HShcz30bD4mNuZQxHLsytY
 od7Tv4xrzYdv6mr55k9LPV9J3ID3PwcnYJAIDnZpS/qbQSSvD61sWyuu9j1j9aofakkPdauWR/J
 PD3G3Lj+Lz5c4ha/tBQ==
X-Proofpoint-ORIG-GUID: Sp-4C3Z04C47JxPNr8dy1D-O-H4cCTwv
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6aca3fe0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=h-rY-VAj1oihTiXfbOoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Sp-4C3Z04C47JxPNr8dy1D-O-H4cCTwv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX/F84SiLCwHeV
 +ahZ0PCCtOXugiOGucX8nj1oiMcvuY4pyRGpDmJunyg15E0tC744lN/qeMycCIivCAjAhDPBMzg
 MlJ2DZQgVwJM3nDPhI9fUIS+XhsNXPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100054
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

DPU 5.0 introduced SRC_SPLIT_ORDER in bit 4 of SSPP_SRC_OP_MODE and
SSPP_SRC_OP_MODE_REC1. For source-split pairs using legacy CTL routing,
this field identifies the left source with 0 and the right source with 1.

Add a setup_src_split_order() operation for the SSPP register layout
used on DPU 5.0 through 12.x. Select SSPP_SRC_OP_MODE for SOLO or RECT0
and SSPP_SRC_OP_MODE_REC1 for RECT1, and update only the ordering bit.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 35 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 11 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index b5e50fc1916f..f6ec883f9066 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -84,6 +84,7 @@
 #define MDSS_MDP_OP_IGC_EN                 BIT(16)
 #define MDSS_MDP_OP_FLIP_UD                BIT(14)
 #define MDSS_MDP_OP_FLIP_LR                BIT(13)
+#define MDSS_MDP_OP_SRC_SPLIT_ORDER        BIT(4)
 #define MDSS_MDP_OP_BWC_EN                 BIT(0)
 #define MDSS_MDP_OP_PE_OVERRIDE            BIT(31)
 #define MDSS_MDP_OP_BWC_LOSSLESS           (0 << 1)
@@ -260,6 +261,38 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 				 ubwc_ctrl_off, ubwc_error_off);
 }
 
+void dpu_hw_setup_src_split_order_impl(struct dpu_hw_sspp *ctx,
+				       u32 op_mode_off, bool right)
+{
+	u32 opmode;
+
+	opmode = DPU_REG_READ(&ctx->hw, op_mode_off);
+	if (right)
+		opmode |= MDSS_MDP_OP_SRC_SPLIT_ORDER;
+	else
+		opmode &= ~MDSS_MDP_OP_SRC_SPLIT_ORDER;
+
+	DPU_REG_WRITE(&ctx->hw, op_mode_off, opmode);
+}
+
+static void dpu_hw_sspp_setup_src_split_order(struct dpu_sw_pipe *pipe,
+					      bool right)
+{
+	struct dpu_hw_sspp *ctx = pipe->sspp;
+	u32 op_mode_off;
+
+	if (!ctx)
+		return;
+
+	if (pipe->multirect_index == DPU_SSPP_RECT_SOLO ||
+	    pipe->multirect_index == DPU_SSPP_RECT_0)
+		op_mode_off = SSPP_SRC_OP_MODE;
+	else
+		op_mode_off = SSPP_SRC_OP_MODE_REC1;
+
+	dpu_hw_setup_src_split_order_impl(ctx, op_mode_off, right);
+}
+
 void dpu_hw_setup_format_impl(struct dpu_sw_pipe *pipe, const struct msm_format *fmt,
 			      u32 flags, struct dpu_hw_sspp *ctx, u32 op_mode_off,
 			      u32 unpack_pat_off, u32 format_off, u32 ubwc_ctrl_off,
@@ -636,6 +669,8 @@ static void _setup_layer_ops(struct dpu_hw_sspp *c,
 	c->ops.setup_sourceaddress = dpu_hw_sspp_setup_sourceaddress;
 	c->ops.setup_solidfill = dpu_hw_sspp_setup_solidfill;
 	c->ops.setup_pe = dpu_hw_sspp_setup_pe_config;
+	if (mdss_rev->core_major_ver >= 5)
+		c->ops.setup_src_split_order = dpu_hw_sspp_setup_src_split_order;
 
 	if (test_bit(DPU_SSPP_QOS, &features)) {
 		c->ops.setup_qos_lut = dpu_hw_sspp_setup_qos_lut;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 69d68cc916b2..9b9ea2e00a00 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -236,6 +236,14 @@ struct dpu_hw_sspp_ops {
 
 	void (*setup_multirect)(struct dpu_sw_pipe *pipe);
 
+	/**
+	 * @setup_src_split_order: program the position of the pipe within
+	 *                         a source split pair
+	 * @pipe: Pointer to pipe context
+	 * @right: true if the pipe fetches the right half of the pair
+	 */
+	void (*setup_src_split_order)(struct dpu_sw_pipe *pipe, bool right);
+
 	/**
 	 * @setup_sharpening: setup sharpening
 	 * @ctx: Pointer to pipe context
@@ -349,6 +357,9 @@ void dpu_hw_setup_multirect_impl(struct dpu_sw_pipe *pipe,
 				 struct dpu_hw_sspp *ctx,
 				 u32 op_mode_off);
 
+void dpu_hw_setup_src_split_order_impl(struct dpu_hw_sspp *ctx,
+				       u32 op_mode_off, bool right);
+
 void dpu_hw_setup_format_impl(struct dpu_sw_pipe *pipe, const struct msm_format *fmt,
 			      u32 flags, struct dpu_hw_sspp *ctx,
 			      u32 op_mode_off, u32 unpack_pat_off, u32 format_off,

-- 
2.34.1

