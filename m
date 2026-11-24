Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=LqPFM7mM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MeLfp4qW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006FE10F29D;
	Tue, 24 Nov 2026 00:03:35 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1378B10F28A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 00:03:23 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6D2281400396
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:03:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 19:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795478601; x=
 1795565001; bh=PAtsEURMjw6BMx3O8gA1fyA7I7ZNfExjOJqh5VnpOJg=; b=L
 qPFM7mMPil54tq78/Jd716sHwg7RwguLNAEGWU7uMM3cP+oa852l00DPW512c992
 l3KLI5hWIA2keF9wrnHOH44SfbQ/DF+IsiaPgtd9wVJk56SLUPJ+ewHvG+OPTTfN
 cgdKC91hfDy0OYCKlNhkclYnNzbYrHvjoRitALYt2WNGRduADer35oWsySCWts2+
 PxnBy9sNYUhaq8P7+sYq5Brzb5CVB78P+5mb3cVlRzuwhPErrYSmCkdVz4t25Mkz
 /4lQUMm8GizkCmcDwy35uI9iCpc05f4wYtIuERYHx+/Rmp8rMhPtYmLsyMwE9ThU
 LAkMYEtGgc4LHxzE8/dXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795478601; x=1795565001; bh=P
 AtsEURMjw6BMx3O8gA1fyA7I7ZNfExjOJqh5VnpOJg=; b=MeLfp4qWPzPIBJLHc
 fvrGICUQsgTwFQvsKP4tFcZKQLqwTEUCUxA3iNHs8GihxZ27B2jZPBYJEx0uci8T
 C8TsEic6fwdRVx+eUEVWLgtRPvAYUV4Cbl4YpczwItKcIwTrxwhNjnKX9nqs6RKT
 gtWj8uavBJcv++XU+br9iKu8iFvGfZZIzW6ymjP/UOXN5u73WSmdxHExiOjNXVXl
 AJjcQxq90VZn0a3xhIB8a3I/EGxlNMpAvkNBDMvzf13eF3nJ70btcAnv6dHvEc4Y
 aT7dXN/jXtg0LCKUT07iJ9Q/bDEX5IXxD78ZDclrDWqMOTGJQZu3KXAoAkgGY95H
 1Ricw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478601; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:k/7UU7uLltKNK0+QIwegiico6HFAZMiVHQoAjH7ysGM83tH
 bgA7nvQc4VpChs4zqV0ymLFwDGY2aWEDQbg/zULnabo90zekxwAuvfjvyx4wtLke
 yCq/lDI+0RBGsuGoz9ypLSkxaZZdEIqPHD2/frw3I4O8L+OTZF+zzgfjtotvhC7D
 FSua+mOJ9rq96Az+pz+kYkKw2fwrmHyseBgxw1IiuE53eVPSrkoZA14mE1IELYBQ
 lL6V06tiIRUPcG+JgzPZTJEs6jqIHK6B8GhPY5322IQcwKhnCNz6dtLsHKyjJ6Ha
 81El0JQRRwh7YgzB42ZRMYX8Y9W2VlxvC5VT3DA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:C1BWLQcnSytZepq4fTMqH2u1iaoudV1OrEuQTXPxCxI=:75ct8d2NEqNy8dcL0uqvryMqIsqJanWM8NlkNmCp4FM=;
X-ME-Sender: <xms:SdQEa-sIeKyLAuqXySBonp3mPo5W-yYxD9H2Yap2i-QpPv0ygCY62w>
 <xme:SdQEa0tvnOUEJ-OcoUYOXRapDxUTmlv44FJnLcWcc21weubyfhGm3G1ZYmVWZXqR5
 D6xUtRTVCwAEdfQBz9jDtk53-AHBD0cl465bKSZz_ybLnHWiw_5VFXQ>
X-ME-Received: <xmr:SdQEa_F_XEC4OTo-W7frqgaExL9vSfuVFgcnc8h-bdzbk8L774n-e5HISmI6u_EnFURzrrHl>
X-ME-Proxy-Cause: dmFkZTEIvCBAqgUEloIsFZ3FkPJniX+pdPbA8lwmlIZBO9hGOTGGz/x2Hl+7nFbV5nyvKp
 t925nNRn8DutQCQinVZPr73dXFznYxFvXbL116jqCZ/GfyonUZh/Db8T2FiyXrfT2tvgmY
 iobzatdB+GcoyC0jM5VyW//zQbbnDI1hKnSbxsDcxkUlD4xzycqbxXM6vvDpB+AvPZI9PO
 U/XSWb9pjObA40eWatkEvdJBkQEqjCEU+A4urP116L3cv2N0DBt76GIBJcBDbwZQhbIQjC
 SOwjlJv+Q9QIaSqFf9Kz25pG8hZtrsSllc9yq5WXEJr9X0qGFNbX1Y7L6XZjelykM9Ldlj
 QmYfQnu0oE0th0KiUcGx0BpMkjJLthd3bKUwFDw4YTV0EKGlUjFGl7tgyMnt+y+zTjDfMn
 A5hn9D1CuCrMq63UC4P99nXpZOxG970N7X220xsTvy0qEZVNUEzFBwLxXq6z/ptaQdLiK/
 5ajJg4DLERCe4jjGrZU50SAnnJv15ESTpkwVwTBKOZ57IUR2lClbNgO4PB97kdYHOcVIYI
 vf0Oy+mmADrxqqMTl7osFUtXo4LyLrTomfvYSe6UEARwkvgzImWLUKXmg3FhO4wovXTLNi
 Yd0svLJbtcBfeaZEUYGDbhnTPHzxtURDZto106cvXxQCV5eSz03oHModg6qQ
X-ME-Proxy: <xmx:SdQEa3KRuUEyLxuR93E9SV1LN2Afhyae9W7rL4bR-1BH50iDrkH9Lw>
 <xmx:SdQEa_Yl73dEbwPGkPLddSp9eFvYSOAtvmkfy5OMPGiv9SfFxLgQlQ>
 <xmx:SdQEa8rlnUnM0ayQtCzAukRelyoXbPY_-L2Sv3wPuyz9phY9w_Pygw>
 <xmx:SdQEa_HTdRppX0ht58zEsMip-7Po_arXDr5VrqTkylbdCl8rl3Q3dw>
 <xmx:SdQEa3ojmRkqc_OHowVk7JwlBn0DV7gOfg64nfTP7pvvp2y0vgl7jhSb>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:03:13 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: ddrake@baylibre.com, royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v18 8/8] arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
Date: Tue, 24 Nov 2026 13:01:43 +1300
Message-ID: <0bcd73278a4c7a0cb2e1b8bdb9aba306355384cb.1795478392.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795478392.git.gahing@gahingwoo.com>
References: <cover.1795478392.git.gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable both NPU cores and their IOMMUs, and make vdd_npu_s0 the supply
of the NPU power domain. The rail is switched with the domain by commit
b1bff9ced657 ("pmdomain: rockchip: manage the RK3576 NPU domain supply")
in the pmdomain tree; without it nothing holds the rail and it is turned
off as unused.

npu-supply is set because the binding requires it; no driver uses it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index f068794e48d4..72b251d396fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -722,6 +722,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	hdmi {
 		hdmi_tx_on_h: hdmi-tx-on-h {
@@ -779,6 +783,24 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

