Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8261CC44528
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CA810E6EB;
	Mon, 20 Jul 2026 07:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="f4+2uIhA";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEv7vYl3";
	dkim-atps=neutral
Received: from flow-a2-smtp.messagingengine.com
 (flow-a2-smtp.messagingengine.com [103.168.172.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E329C10E50E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:21:33 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id 96C621380331;
 Fri, 17 Jul 2026 23:13:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 23:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784344408; x=
 1784348008; bh=YN8hcc7LHmdlR/Uog1WmzdV1gpimyXqpsnNhBwVT+7c=; b=f
 4+2uIhAusfUol4rxC2dMLYoC9KnygfD5PaCWftweDogHfD1Pp5zajB3+yuEVXa76
 mt7m15J2jk4pziHy9NkPY3d7UGF6HUct/5UJGe7rKRyPS1ODGcrw0WeC8DfK+Nyk
 yQ2j+rOltDpK27ul2KVhpzzK/4oavW/InO5GqT5jSu6d5bPgpvZgWcrJ9kpFcUao
 3DYJHLDRFkZB3gU4bpXNZeFAA+FqHdjKMcssmWCwD7jPBa4fK6IhBZYRApPR0Tey
 qJT3uLN7ggcHJM9usHld60Z7KqMZ91NLpW8fkytDHQ/OalJ/7SOdpdDpy/9zvOOw
 yy+UILUUJ9ndqu1WIea3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784344408; x=1784348008; bh=Y
 N8hcc7LHmdlR/Uog1WmzdV1gpimyXqpsnNhBwVT+7c=; b=FEv7vYl3eSjTFiTJK
 hifT8+DxYPkP0CoXACUzlbd+jbHSFBxu83xjh1VCH6smVg+grMVc4LVP+YWreYVH
 PCM9U2b1y8nG1m5YuKOCzpwgjOEsEvty34Bu8em8Nt46W+YeWkwZhx1Fy6DJ8hUt
 QV5emtL0Sinl56sEJon6bo1vDnyNUY10CvmIeFZaoJ5hcCMEa0Mbu92fZTu1g6Jc
 8D+nXPEwS+n5tQHxrv1DqnCJowreGufzQzSHdUAI7G2LpS8nCdmAbKcPTMe0Nzyl
 5GJBbiwqMajqSJR6mbLrH4acIP5g+C5mIF0ubydyoB5Nt5J1rgMuoeVxpXy2+4cL
 aa2WQ==
X-ME-Sender: <xms:WO9aaq2awbw2ry2nB7Yjzv6XjedsVQkGwaz-o3Sky-6ugzV1ZurkEQ>
 <xme:WO9aatf98LaOu0OjVOXed4eKH3McXkXl_szhHg85Ml8o89F0tN1Du8Jji41XM5sPX
 1nQMXeC3rUfGSz_65RPxG753kuWQvMtEa1e91VW3un-lmK0zAQxfKY>
X-ME-Received: <xmr:WO9aakBMmVtG9ddQlMKjxwrYxlygba_qASdW3Yp3-O7G2p4s-IRUwRJ2zxoFQprhQz1MCMqDngByMmnGhdc>
X-ME-Proxy-Cause: dmFkZTGo/Hd4L5rRwOTvh0WCJISmOoXEdIqPuYccPV++DcxWf8Powz1Ybe2qRyZPFweND+
 SC523aTq5VzMTUw6xzE3TE+6TtlEB8vrrH4BUWnWvZIVs8l+O8kw8bSbEXZq4tcxWLKFnA
 IwLpvCvHFvCqvDLsht2am+N9qIBZJoYs9mEGKuttiOELjod/llVLMCR0u1IHVoIgucxxIW
 anxc0LTCCqkvsrJPqxq1atY24kesrMc6Brp/3dB1YLFs+ElyHTkaHO2ZOqSszleqXA0zXU
 HezeftBat/hbrTwvfrp/eJrkQh8GYvdSWkVFdy401SIxYsUskCWq+ozS3QCLOeylVm+ac4
 mhkUCZfzedlPV217ifuS7BuzBzAZj5FR8Vb3i70lAsAb4Tz616O2qLJCUSo8KHCxill/Sv
 x/SOTD1uo27taJZ6UzFY1U86vK2BYoaOLXtnvWBMKKuEm2BRAfuduUFBpUqGS7Hte7s7Bc
 2lEdCQ7R4kNrjhIxju+zU/BKmehiamiYQfbZUH4ImzbwfCU45zE7lc8py6MOqCAGwoB+Ft
 evDgxSzO37rdydZ98RNpUU5W3UWgd3kOpqaKP9C/N7+qPe6OEamMoDhPLR83GD6j5Nn+BU
 oa/R4skBzef0HKnUgmwkOiMugYbnwO/SOlJUhRqWzz/Yh090llGEL/ekQGkg
X-ME-Proxy: <xmx:WO9aan2omCOwlURAYbXOEylDkALHO5j2Mp7ttuunQQ7zIk2nFlgg2A>
 <xmx:WO9aasMPy6N3GQDS8uqr4iLhbVtzI8dobNroC35_m21_45kaFyHiHQ>
 <xmx:WO9aatePHnr1NvVjEFPqWNxXLKHikvbSzJbAZASGNgF7TEkd03lQxg>
 <xmx:WO9aagMGmMbhQi_jC6k8ObMxKh3PGvxDtYjaFNy_uLsKIgxOLjApzw>
 <xmx:WO9aas7Ck9Id7mPQYJwG_Sv7-QsZpBZEOKmtUPYQv5ZrLs-aZzTbqyu7>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:13:20 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 8/8] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Sat, 18 Jul 2026 15:11:46 +1200
Message-ID: <20260718031146.3368811-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Enable rknn_core_0 and rknn_mmu_0 on the Radxa ROCK 4D and supply the
NPU rail (vdd_npu_s0) via npu-supply.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..09d2fc98b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,18 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	/*
+	 * Power BOTH NPU domains (NPU0 + NPU1) like the vendor's single NPU node,
+	 * even though rocket computes only on core 0: the CBUF->CMAC read path is
+	 * only fully powered with NPU1 up. rocket attaches the multi-PD list.
+	 */
+	power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

