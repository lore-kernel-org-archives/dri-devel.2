Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4CFCD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6733F10E81A;
	Tue, 16 Jun 2026 18:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="ZjLIv3Pl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7rW0s97";
	dkim-atps=neutral
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03BB10E81A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 17:59:56 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id D75DC1D000F0;
 Tue, 16 Jun 2026 13:59:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 13:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781632795;
 x=1781719195; bh=LdYyRFprC6/IPCwiBAmE0jouE8njFaOE+umllzwrd5I=; b=
 ZjLIv3Pl3h0t2eVLt0aSC+8Tq26OeoxRnr8gaTkejPx2aZlI/3YcIgpzzCBoAkPG
 7DWXnTXOI0q26RoC6AXPGP9e9uJ0A7L0yq4ihH9wQcoWfYoCvXRfIORiRzvPmYfW
 ba4hlOxdVK0RiyluoADQLcZM61yFfmSbC7LE7sjAsTBXyLkzyt4XyO5OITpePtJP
 7QKl8qrnOxMHrQ1Nxs99Zt2FGImvJaB8M8NelRP0HUm5euKbL5Yh30GQTLmZ2ann
 Mpm03FZLeeofgJPjzQyL0heIjdLxwtkIwnENvWBPCxyv4EzyySieMnx4pgH4ME4R
 Lww0glOX58REm0D8Ar6LNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781632795; x=
 1781719195; bh=LdYyRFprC6/IPCwiBAmE0jouE8njFaOE+umllzwrd5I=; b=j
 7rW0s977+jiEibVm6Q5O7VvEamm21gqsyxgO7mWqkK8Ay6RCr6pEba0lqig+hdlg
 x79KXc7ykrBaqT2xUMYsR6fMVTFcd2CDEzZYIdH8h2rs8DiMZy8e2Hr/aUvZfuqN
 Rvpb3wi+Daq4KWbl0bvAFtPGPh4+jwTayLNS0I+r8IMuXxn42Xx0PgEA8ID794Cn
 7Mloc4OWMZaB36hQ84pIb5iH5BodFosaoA0Ylj3Z5dKdqrpB8tIEmDHsWyDBJN8F
 opGc5QiRTIppPTQ38XmFmnMwcP879ydwLn12ZQcFmu1ow0WhKXj7BYy3RutnaEUy
 JJZFAKAqZxeeypL5Uy6XA==
X-ME-Sender: <xms:G48xasyylIi6kkcoif8zoikzuIc3TZT7_gVj6c54AJYGqbNaMJStFA>
 <xme:G48xaskyhSnnMnR_sT19IN8CCrF6Cs76_Pgrj0XxmOLolPshJD7lt8TbEoAgZWvK1
 HYzs8Z4HNghdFrhhblwooGjS1HKWaNAEyfmYbgCzTQS4GZK_JBMu9k>
X-ME-Received: <xmr:G48xav_XmDLA5Nzb0SR85yYDb2nIWiTg__b2ICbm6crmwMR0cuQ7LXUsUDREjsyAlfVEazEeh8lLGcvBkucRasUa3IkM>
X-ME-Proxy-Cause: dmFkZTFzMoEVwJ23/63BROQGNT0ZS7cXR47HqO+CDSdbwtxHNmnrRpTLZYdoYwpdUpZHYj
 WU0KyMLp10RzWf3fGNyDiytarS8coUyAbaVJ854ZzfbbNXzExBiFXYdhxw/Ksaoa+hrCIx
 EDRhErfzw8A2jkir0CHck11DpMFn3TyLDsxdzSFBiyYcfZQLs9s3JpvsMupXLgDfFBYWEJ
 XqylP9jwLhP7kCi9W17W5QBv+Ns3OCGUfhOM2MbeWkNc/DrXRJEyuiflezdKW4QwnpE4Mh
 HXsrrpRLWtjcij2rIfI942nASQZ65knyAakhCDAfsNu9FN4D1mwCJyvaGubQyYaFSQebnd
 u8PUicg8tQsv4f48woRTEPR4wX/1XKdMJYDFqcsHZYZAT5rmYT1REK9QZeTEZAnhGFRPT3
 XLVJZ9KXIV/8L1Gb3BqlBuz8rI3RZ+8dFlBsEdw+o9PngrJwWteHY20Mi3ObwjXbBjK0Jl
 rNzwML+cxIBbdBoapxbRZuejUYReRHADmjB/qJC/QZqZJ0J8jgMt0qCUw08yllaPnQF5ts
 wufkvb6ZU4aspVS1wznqlIzT7LtIbJ1b46nUI35J6ZX32FqKnzJdsMr9OZF8X8Ida3W8Uk
 pLzzzOdnpsK1JRAD6BJXoALc2OXJe4oN7//DpCeRR8fGJzCl0JqhZNR+8EHw
X-ME-Proxy: <xmx:G48xanrQe2cy8Z76Xevp_zNR2hhvEiD0rPk54CVzd0piTJavtks6tA>
 <xmx:G48xajL8XgzQKaKUaeknGp_zvtY1A3NX40iMYAAiehCvkaPE3pbZaQ>
 <xmx:G48xah0mxJf5dNcYG6qydtuBdjaxSpT5Tdv3N_0jFrVCw3L7YWD7_A>
 <xmx:G48xaiX7PS4uYrgKm6036KkGDXZdljEHenGRWnL2VVecgov6Pb4_1A>
 <xmx:G48xanO2emRvETbA7C-1L3hOHUkEn7XjRpsFUDOZBnm3IeVgcpvAn_JH>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:59:55 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] arm64: dts: renesas: r8a77995: Add GE8300 GPU node
Date: Tue, 16 Jun 2026 19:58:35 +0200
Message-ID: <20260616175835.2109336-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616175835.2109336-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260616175835.2109336-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Describe Imagination Technologies PowerVR Rogue GE8300 BNVC 22.67.54.30
present in Renesas R-Car R8A77995 D3 SoC.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Use SPI 119 instead of SPI 223.
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 5f3fcef7560c..c42d96540ce7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -1295,6 +1295,21 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a77995-gpu",
+				     "img,img-ge8300",
+				     "img,img-rogue";
+			reg = <0 0xfd000000 0 0x40000>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_CORE R8A77995_CLK_ZG>,
+				 <&cpg CPG_CORE R8A77995_CLK_S3D1>,
+				 <&cpg CPG_MOD 112>;
+			clock-names = "core", "mem", "sys";
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 112>;
+			status = "disabled";
+		};
+
 		vspbs: vsp@fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
-- 
2.54.0

