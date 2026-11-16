Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4B606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zc7kL8HQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QeAdXNyn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA18A10F190;
	Mon, 16 Nov 2026 13:18:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E64710F188
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC1HKU3117241
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v7E6DqGo000I7uPq00z0emYDzpAMFMtfVm3oUlX4g4c=; b=Zc7kL8HQ1JDu3LsG
 qhLcwxYLryxLs3hRcdFlehR+VbQl9CdHfnp7kAXQI8M6/BOF2h1hGQfrYEC3Qiby
 jpPgbBjyxs7EnWcuyBK6S6qrFOqIJBiIuQLjHArQisBn3EsjgDF99UZFcqtDfdHh
 5eiYdPGqq99JWMmo9DdUrRui4hgafPHQFT5+om0TDMobDxg7W1gMoz4g4XLHagdp
 myd0A2MCOeydg1vO5y71eLfdAqfRomtjk15LKznV/8UaiAeNjEkuhl6/pYEDzHZs
 xxIIek1Xn9oBCWHhRZw44OPVAtgKvQOMTqLSP/MpKHkWGXh/cUdtQi4ifxDnobgp
 3DnK9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f8082q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so614635885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835089; x=1795439889;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v7E6DqGo000I7uPq00z0emYDzpAMFMtfVm3oUlX4g4c=;
 b=QeAdXNyn/NCXY5SFYOxw1BI8HVp8zBLWs+thWG5czAeQRv9vJD4MCxeNRlr/ufoygX
 2C2SG1ISjBKk8lfXoeRA8rMJrK4Og5NOZx/v7IjtiMWTSfyDZgjCUox5d26gn3ox0U3t
 qA4uWmNtiPrhOIEZhQN3+IFJXjUPtfENL7kSX0uedUTZMaLTuHLIqm9J3uKmTwranNKM
 kLP50wNtxoEg/AmFihOEg4dbOLzKRi47CD9Jski5IVCt4e2Mxmc2+TthirTLUpPs4Bl6
 J2fBuSoWwAkLY/DK1MpQSlGigDV8F5UiTHRVcYzuPytgccc6WnC8lBChMq6pdv6XhlJ8
 9f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835089; x=1795439889;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v7E6DqGo000I7uPq00z0emYDzpAMFMtfVm3oUlX4g4c=;
 b=IOlzVEBIyU90i3plMXlfPOTYrit++bDcqLMfBCCjUOArjUpBOhgqngt4jIDVenwmXr
 sEJr1I33Jg0ke547Dc8qiTHM+cBHDw9OPk4yfgf+Xit3IwrRTFv9fFfE/92Ltyq4EeYg
 CNZbXEN+RXX/N+JJeMfop6wlhArfHQXL1Dpreni2/avOS/mYG1wI2lDPlpQK8i4ZOzEz
 mp0sDutbxUC4NaMvmaavzBO7ceWsockzu2hxx7PZhO9RXG5C50Qve0KW0QpxaGM7Rvj0
 YefJXkvJHLjJ3KQYtyY/i6T7FQc+s8QN3qBwudysptwlktcpGetkVj3O66sT6v+mwOTe
 ELuA==
X-Forwarded-Encrypted: i=1;
 AL+hErEOs2UYwyJJT2TAoTKH+ltD0cnQCOZXs1Iz2o8irqCjftLtNgZ+I4bfVRzUaM70v391ckBGm0Oirm8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9g+QcFMtwGQFw115a+oYFebLmfDqIjFmO5LgKIWSKkixCozTRN
 9IeFowy+WfQftQmijl5twjZ/WOYEDzFZeqdy7T//Ekr8ntNIx2bbrKX2Z5ayYxdGB8eNFaDEkHl
 uuWdlQmn0eg/wwgB6+4mfkUPQ94WgtE+akG73yzo+FkIgKlql6LqIdAN1x7mVag6O+7Jk0uM=
X-Gm-Gg: AYBFou1eymoH3P36/EZxJDNwGqT7gLX/X4pyBqEfLCZsmiE8YWlAkaxG3SujXH31ntH
 +qJf0NPWPx2nsRbumKNyxZAi/Eaj2LNBChzkmcukN/HoC7Ab0BgYvFewHzwP2dZRBxehUNAU6wg
 CV40wePefPUh09xZsXhQUmc//Mkmny2J28nXxq15Uw58vCIK4aZMgGXholv2aouJhD7o4SNu+/2
 BfKMcIPJcse/z63lzulqIIZhEBlIkwPkNnCh2AImfDZsqsO7zwo/IHAXlpobl0hUKoh3BfgR3Bi
 XQGZ8YJRsqqVX6nNe7qq0VxBcBzAhA4pNdQnxD8ElZxtK7oAID+YzUMRlyds8NjhJnGA6sZ3p4F
 3GOBBx8DfBwY1HlW1EZFXayP7PzODAgkEtyw0ewGwQTrdRBMr2f7LAEoMkMbzmbR2JkEjFtWD1E
 to
X-Received: by 2002:a05:620a:2949:b0:949:7b7e:c101 with SMTP id
 af79cd13be357-9497b7ec67cmr478585785a.6.1794835088849; 
 Mon, 16 Nov 2026 05:18:08 -0800 (PST)
X-Received: by 2002:a05:620a:2949:b0:949:7b7e:c101 with SMTP id
 af79cd13be357-9497b7ec67cmr478577185a.6.1794835088123; 
 Mon, 16 Nov 2026 05:18:08 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:18:07 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:45 +0530
Subject: [PATCH v3 06/11] drm/msm/dpu: Fix DSI tear interrupts broken by
 adding INTF_9 and INTF_10
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-nord-drv-dt-v3-6-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=3056;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=tNJZcT1SgyiVCTR5tI3Rgit0As7OaoMsLm8aGW6FkJY=;
 b=K2WAePHAK5sxP8sTbvcHlOZbYHt25AZY6NwjI0xtAg7tOCOGfYh4hTYpP5BPWCh0oqJ1n0I7K
 MMTczlWpUd6AYrAkk6G6wJxGt1o+x4PoOqwoy4cRnsnQMZaKfTKVwAC
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX/Lwn9z8bSrp+
 YidWDGaYhwvlli/vP9aWR43pnF2qYvmJU53xaDveH6QEyX+eD6rX9pLbZ9xDLFArVClhso5EeyH
 TMF7igcuJe/aX9j5VmRknvaHNV0qCPSvcMgJTa8PaPb4DtzdN+xVffI6Fa/76SCJLFLS0TjY8bO
 nw1b5eUDyQg2JCXyLGdyv88vJ+IeWadvXdDbH+R+P9LjBjYbaAD1VWwVJ4vwNgeYK084bJxdEV/
 FwyGKUVM9K1MaPVkEbj/SVCACj2H4LPmOGp0MUREhkKccExl1+SSB7AuEyp+ctpuzPLfLxUBKQU
 WL/r1SdW9XnYFVYh1+o+PU9OJUqUWB2Ls4Iqgz6Zv24Za6BenMEkXN0LsgVCzk/VPW1/It0T9zS
 mIlkm2DBjwPRRUFqyozQuAMyKclQUzNZmAk6H/bbhjKQAuU+SYm5pGicPpJNgVXoIHowCLkFvoA
 EIFPVu92uOsQqin/z+Q==
X-Proofpoint-GUID: BNMvQwpSyi1kA_UIymI3yqPUKOVfwM7P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX3GGYUnpi27JI
 MEGjEJQWocyNV+aUPwue/pUQs+A1VayWTpnzTJAsGcYOt1QlFQsZOuLM8jAD/0brzLFJLLT2QrY
 jnTBh407BgMkOnJOoopEUFfUSLLinYU=
X-Proofpoint-ORIG-GUID: BNMvQwpSyi1kA_UIymI3yqPUKOVfwM7P
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb0292 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=QKV3EQzOLTW8gb8NrR8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nord requires INTF_9 and INTF_10. However, enum dpu_hw_intr_reg relies
on all MDP_INTFn_INTR entries being sequential — MDP_INTFn_INTR() macro
computes the interrupt index as MDP_INTF0_INTR + (intf - INTF_0).
Appending INTF_9 and INTF_10 after the tear entries would break this
assumption, causing DSI tear interrupts on existing platforms to map to
wrong interrupt registers.

Fix this by inserting MDP_INTF9_INTR and MDP_INTF10_INTR before
MDP_INTF1_TEAR_INTR and MDP_INTF2_TEAR_INTR, keeping the sequential
block intact. Add the corresponding register entries to
dpu_intr_set_7xxx and dpu_intr_set_13xx.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h       |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 5b7cd5241f45..c9c297ca080c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -206,6 +206,16 @@ static const struct dpu_intr_reg dpu_intr_set_7xxx[] = {
 		MDP_INTF_REV_7xxx_INTR_EN(8),
 		MDP_INTF_REV_7xxx_INTR_STATUS(8)
 	},
+	[MDP_INTF9_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(9),
+		MDP_INTF_REV_7xxx_INTR_EN(9),
+		MDP_INTF_REV_7xxx_INTR_STATUS(9)
+	},
+	[MDP_INTF10_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(10),
+		MDP_INTF_REV_7xxx_INTR_EN(10),
+		MDP_INTF_REV_7xxx_INTR_STATUS(10)
+	},
 };
 
 /*
@@ -282,6 +292,16 @@ static const struct dpu_intr_reg dpu_intr_set_13xx[] = {
 		MDP_INTF_REV_13xx_INTR_EN(8),
 		MDP_INTF_REV_13xx_INTR_STATUS(8)
 	},
+	[MDP_INTF9_INTR] = {
+		MDP_INTF_REV_13xx_INTR_CLEAR(9),
+		MDP_INTF_REV_13xx_INTR_EN(9),
+		MDP_INTF_REV_13xx_INTR_STATUS(9)
+	},
+	[MDP_INTF10_INTR] = {
+		MDP_INTF_REV_13xx_INTR_CLEAR(10),
+		MDP_INTF_REV_13xx_INTR_EN(10),
+		MDP_INTF_REV_13xx_INTR_STATUS(10)
+	},
 };
 
 #define DPU_IRQ_MASK(irq_idx)	(BIT(DPU_IRQ_BIT(irq_idx)))
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 142358a105c5..7b8a04f8d209 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -27,6 +27,8 @@ enum dpu_hw_intr_reg {
 	MDP_INTF6_INTR,
 	MDP_INTF7_INTR,
 	MDP_INTF8_INTR,
+	MDP_INTF9_INTR,
+	MDP_INTF10_INTR,
 	MDP_INTF1_TEAR_INTR,
 	MDP_INTF2_TEAR_INTR,
 	MDP_AD4_0_INTR,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 0e65bf5ddc4a..7eccb4d2c65e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -226,6 +226,8 @@ enum dpu_intf {
 	INTF_6,
 	INTF_7,
 	INTF_8,
+	INTF_9,
+	INTF_10,
 	INTF_MAX
 };
 

-- 
2.34.1

