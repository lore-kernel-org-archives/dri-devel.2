Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD7C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D0310F452;
	Thu, 24 Sep 2026 10:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="OXZbGBj8";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpkZGKAP";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DADE10F452
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:24:30 +0000 (UTC)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 292197A00C1;
 Thu, 24 Sep 2026 06:24:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 24 Sep 2026 06:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245469; x=
 1790331869; bh=6PrxhMJ+bPB8OpltSSCWTE8BVpTQwvXCSISkeXWvIiY=; b=O
 XZbGBj8+T5lzcBXJ6DbzWckayeU/jx9fEUBd1Z9ba/dCOnmIAMsAQHgfsN44KPVQ
 3WpQyZXArTNz0lWBxMhySJmoyJxrKoSIRTT1/T43he8T9eJes4thIhjn1fud+GI7
 PCBOyr0IOA2wR6+mrdXh0JvTmOYJUyeYYz1CGKaYDCaq85C0p7hAQBtOBNud71/H
 aSW3FjLUXN/+c7k5ahF3hoZrwsWciY4oYIZvzypnco2jKY3r9IXs+jhS0dqtnYTR
 ii+r7CIdBx/3fhm7OOm4B4HRkjjqZF7/bSHAc5rvEFB/4gxmQIdEmxLiyxvbuYW9
 xUxZ+bAT/zkAW97VE3Raw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245469; x=1790331869; bh=6
 PrxhMJ+bPB8OpltSSCWTE8BVpTQwvXCSISkeXWvIiY=; b=wpkZGKAPPHYcBNd+V
 hQ09WHv+Jk8Q2ENxxYXxTHbz75MRVx1S8F8TFI4DyjIMbCpKHQ8DhyvcmsbQZMD+
 AXMdNySgcSlpzUWvHe8RIvkIHRKXB1eOlM9+NBkrD+3NoP2swxUHnOv2pMiXWbDx
 Il3y1iTFfKO0AYXu9K9Li3kZwXTE0syGlMA0fYDPZjv+1PykKsYjYpJtQyYt9xBu
 3eHbpYDYWDA2Ju7yBPRi/SPbT3FBtoEYK4qB4L8xs1pqS9E3u054qTqcQrkJmjjU
 5Q2O3wiZFgveVeBWHl8vWG13RgByMVdvgTgWzS1h2TRwP3Cb3Ql+js41r6BTPTgL
 ur8jQ==
X-ME-Sender: <xms:XPq0al_1SH0uuiHW2uI4uyJZQEpAomtBA-azMzU0xWw4JfWs3hnXWA>
 <xme:XPq0ap2zH-hMfZ0g6czXjU53ifnn0mPzqUzJV4Y9BKtuwDP6_7_w77juhGfdh3P02
 BvBmugk8ONAMcWTuKPp0UcMFiXsEoM18AueSwFcKXuA71riISZx27Nf>
X-ME-Received: <xmr:XPq0ag3mcAYRAbYgjPOHOp2qROr5tHeOKzkcHE3gygyXqLD1Q36SJf1epKJGZHc9g5lpjNQnPQ>
X-ME-Proxy-Cause: dmFkZTEBXYU9ElO+94qJ8ZHudHNBHbuza7doTwCtgpbgd1pTdTbZKfrW+V7RUYO8gbXcVM
 dWcDbNbjJEPlrI62aK8xUkCwNf2u1C12tHkh3U5h2/TCheoYky1YSdht3EXYmGzOmMkCqu
 eAmKSeKrzy+zrR2U9yIZ6iBIFM+/JeqkOvqv0CPyWVgl6sOhavMEilcrkUPkEaFA1QyjG4
 HKSUze7wVMfOQPVYNC5kKiS1ccvN96KEYzBczq7p3AoiqTymtY7XRzB/GwkjQgpBX3Rzo5
 NxmhEp9g4tRWhIeX0obdYE+jVZa16cHIZPYpe+Z5pS5GriA8Cj3jKqvvSrfBffw16mObXu
 dDi3swy5lh1qoNKC8cOg3f4jVfvLkbeq25/sG7pI5ILDUhL8Un66qJ+7nd/1ATqmxmehmv
 jaRuI0jeGQ4d1+O1ND2CrFoLdLojI1oMmSkbhRcoqFgAL68dkuyiB00lxNbrDXIOpuseSy
 cejOlSAGgrqXObvWFvIYfs9FGWfGAsOmdOO3rXCUq5hIqyD02q8ZiyLz0lN2HIXTXY+d6p
 GMhgq/Cdqe9YmSYJwH5GoLoqXHOUP95VNfVltr3JD3QS2W3t9BobW2kNnvc+KQsk4EBV6S
 g0FY6T7DQFOiPWiAEO4wkkWnDzC9qND87QHlFpEas1XKvcf114bHUSINTixQ
X-ME-Proxy: <xmx:XPq0atvgshrOx1Z4a8WnLcLsEAjmGyJYLC-pkAekS7KbsPd7eGSXjA>
 <xmx:XPq0aoYtLKKX8SwBJ1003mslYS17V0Fhx2U1PvQVqkZ4TM-kotn15w>
 <xmx:XPq0arK5w5iSGygYCXAEFXt3INtWpTJoHuG47uujkWAOKLrf1njEdw>
 <xmx:XPq0ahgjtlPHr1qzeGTTABgkFUnvF1_JoXTKuzEflWVyeZC9phJPVw>
 <xmx:Xfq0au7yPuAaeQkA2WW7H59juc50ecAYehcyKvfILAr3LlbWpCoitaSo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:24:20 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v14 13/15] arm64: dts: rockchip: add NPU core domain clocks
 and resets to rk3576
Date: Thu, 24 Sep 2026 22:21:33 +1200
Message-ID: <20260924102135.92217-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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

Both NPU cores share the convolution buffer and the DSU, so give PD_NPU0
and PD_NPU1 the three clocks PD_NPUTOP already lists, and give each the BIU
reset the pmdomain driver cycles on power-on.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index d418bfc04..26aaf4320 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1070,14 +1070,22 @@ power-domain@RK3576_PD_NPUTOP {
 						power-domain@RK3576_PD_NPU0 {
 							reg = <RK3576_PD_NPU0>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN0>;
+								 <&cru ACLK_RKNN0>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN0_BIU>;
 							pm_qos = <&qos_npu_m0>;
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
 							reg = <RK3576_PD_NPU1>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN1>;
+								 <&cru ACLK_RKNN1>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN1_BIU>;
 							pm_qos = <&qos_npu_m1>;
 							#power-domain-cells = <0>;
 						};
-- 
2.43.0

