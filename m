Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE408C561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA3710ECF5;
	Wed,  5 Aug 2026 06:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="nnVc6o4S";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+xsd7rU";
	dkim-atps=neutral
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EE910ECF5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 06:39:50 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id 94FD713802B4;
 Wed,  5 Aug 2026 02:39:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 02:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785911989; x=
 1785915589; bh=sgu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=n
 nVc6o4SYwwZTj6Vk+l+xfiUe9OeptoP/QtL8JNdxvIZkQ5KoFuw/eKMh2fyqzcDE
 srF2dOzJA4hg8sYyLN77b6LUGSp9oZbiCbjb3mjOvNDB4vybbGWb4RQnlCcwUD81
 KLcV16KfnnuyIMEqjJOxaLA2kiGhp2E6br3WjtGDA37ZLlIKdmNWsOn1dLLFx62r
 fxVSYsvoPPtj6KfeToJyrQrcJARKjBBY+u7ta5xp/j8nMCjc8YMZrWHQ0faUbSNe
 1JcFxOSvTWcQg1FqWWejRN4lEgbWypJas0d2PBDIF83+eEwFzGzSEggEnhM9DGEg
 RjfUnKqG6yv96dZzVO8PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785911989; x=1785915589; bh=s
 gu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=i+xsd7rUchE64hOng
 1d/N+OTO+yPwLPy8M2pVsjrUE7P7Ca7sI7ZSp99Zl+J6tyfxSCt8UHNG6O+9AW1b
 b1/GngK/9RQDu98v3IHAQJs7bvDX10Fa+8+uKGKy41+fAaEYfQZC63Zrj+DMCw3i
 MFeXtSRD/U5vSJf9+I13tZxbhBU0tJQ9QxloDVpnSy8854Kq3ZA5vgPdG+/6b73A
 ljVVSIc7Ke9eYMOgeTPNLPaX8m43iK/bp4GxnRd0QjbvdueWf0m3qFqeC29zqlEY
 y7zHL3/J+1PeOammtx73rs4m7VCeV9fm5vilblstSyOpWQbiMKqmWGK063qDEU5A
 YzwAQ==
X-ME-Sender: <xms:tdpyalwDTzDvtCYRVykQjMJ1hDVJDmA2ZCksfzaaW1RDJQutMTx-jA>
 <xme:tdpyapNdoz1alAxVduo86h8xu4pHuwNWAh_XOD691wqFEA273TiAPDvsFrHSXNc4a
 8hgki0T44RZ-aX-OfshzrHjqJEuacbz5eNJvV_b_MMyTbNmVrJLOoBo>
X-ME-Received: <xmr:tdpyan0p4grVWgU1xRLTkuQHAmc60Py5Qu216I3oqlXKoF5qKriQjWindTnO1cZk2LBM74r4gQ>
X-ME-Proxy-Cause: dmFkZTEMD1OFu076QwS9SFwNgP6f5aaFBOwJl5YptK3m8ebGw9lTTouZHPU4h9ndohppuA
 MqhtPKehSzM5cGKuNBr7L6AJ+uKJutNiohMQhyJKCTICyfajJ/xSmO114JbBqjULjhSC0i
 Xlbxa+pOAxXg2slJctiMdK5ps5AbzNH+rDDT9fXXq0g54RoxSPklkyLc3RP+86Tl3mTPLD
 /CWbaQf672RUMg9LfQxwI5O+ggniqgBk/wewxNq7ajt7vQQvywjAFU9vcqWNy4/76iwxXo
 1STNvatirfOQsprQ3D+aYGRSjMJWxbKmD4Sm0dtan9ggAh4pCQ0vJVqSCJ6plnee8sAotn
 JIPDgs2IkNgZ0ZOs8jBCMoA7smDBf+rP2Oam7L0IFLsMWxzF3Vns/F57rEIAROCMT1PxWC
 HK0Mmy3KwiK6zDt7qxZMdN6LnjBHZoxeppGyMiwjLMfq1d9+StUlw9Bvn2R8KHgdUHcro0
 awb5zDKAi0vm+cISnCiCHH7VQahSSVdauGeTmhWTAb3+YzRdQgGLzOSt4UFiiOv6eGcBSr
 8T3XM2+Z6rZAjiWRkmYqbqkz8Arz5hf1p5eQUIvKWE8SP1VflAt+mbgF9ZPwqiCWazwA6F
 p+6ZCsWTn7O5JhZZMWRbC/SlfTgk+ULmN1v0VrzK9aL+g0e2sQBEDy0k7nmg
X-ME-Proxy: <xmx:tdpyahEJqupNNvQselDLjMiNe4ife2dY4smmWJGrfSuoBTMjD-B4Ew>
 <xmx:tdpyauh0_5Zk-9YPQmb-2cOFzv_SPtktRxa2qctp7UKh4t6t_XzixA>
 <xmx:tdpyaqdI9sKdpdCWYE8Xyf27G2skeFkgcViGENtLHw75vDxhStuoEg>
 <xmx:tdpyakwfCGTTSvlTy9GJHYYhkCcbkO9mVX_cvy1mxJwLi3JG89mApQ>
 <xmx:tdpyajAquqjKv3hUQGr-7NEswes9p9f6VEiDaWcz6yPdJOqaZmtR1til>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:39:43 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v5 v5 8/8] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Wed,  5 Aug 2026 18:38:26 +1200
Message-ID: <20260805063826.95682-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063826.95682-1-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0.

The supply is marked always-on because the NPU power domains are what
gate the block here, and dropping the rail underneath them takes an
async SError on the next power-on rather than a clean retry. Only
rknn_core_0 is enabled: the driver binds one core per node and the
second core is left to whoever can test it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..965e0906b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

