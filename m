Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F119606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=OTpDs1e6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H40mRjH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2944810E324;
	Sun,  1 Nov 2026 08:31:31 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F5410E346
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:31:19 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 21E72EC06A8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 03:25:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 03:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793521558; x=
 1793607958; bh=2zyzlQZVxKaIY0yOEUymbeRyYHxqKX5mByILgxzc0jg=; b=O
 TpDs1e66qboqgxG2PpC16j2sH7TJddbo+oVPEpaRSHVhke3x8rRlmt4ycjx2R7dY
 /69lyaSpRTAsqFoQwBaW9mPW6jcusRd3aF8upzuJ9K6kHQ+PyrhZYq6wUsF/Wu8e
 ZS4xVSbT0GjLtXbfXNpnsh9zwz1vIwxFuRMplbkPlSHyhrSGsCdzb2Dgc+hHumep
 r9DhNLBfFA3qAwym6jjttL07IQ9E2j1P8cBaz3AI6X41WZDI8fKCr6iYkel2jQdD
 MTocZAlEsEkHjLZI0enuODUjZ/VRVCOFymLpl1ox7Xxi3L9S2n+t/97++/FO1hsm
 Ge/cSWrJsJOTWtFe8vIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1793521558; x=1793607958; bh=2
 zyzlQZVxKaIY0yOEUymbeRyYHxqKX5mByILgxzc0jg=; b=H40mRjH3c0gCWrEa2
 ZcN6DKuy5m+/f3cp+iLyt37jF1O4+mR6K4ASY7c3fsRQE5GgW41wu9hywDxNpZDO
 Xo8oxi2DTsQTZBHWBP7c5gB6shFXnI3Y1hrb+CP2DrItG7us2bp04RQqyYk5/3gx
 evDH44u9VE03Z3pTZ2mfKZzMgZJDleJ0fsDrH3++cdFlxyXZoLVbkH4eBrhP2vEp
 BqFovapOWK277RrJmOS+tviulbq1vyF/51LHrlrBtQTFFtkJ675B/HvopAbyLNAk
 3Kw3wvO7dS7tkBSI2omvUvdJVFkCktPVigfO+GzD+201SYtkSw0RtbjWpymaGw4s
 +MlEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521558; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:mUwS8HCvBrSlh64z70loKaYBYHQz7jvIwRMCNfVANM9SmY0
 FHeQL114K62zysCm3nZu7d1uGcLN1qsnbYAmFVfw8w2EmDlA3rGbdzDM5GFjx/E+
 etrL5/CguRMZjWRK/+AliaBbBSs1bdgfYD0FvIM7wQRWcHPHTE0ddhNZqzJ7h2/X
 WDhv4A7LZCBeHXdSYiVFf3YwOtBf6PYZkTBpWwJm00LmBlXsAKc/s5psBqrQxgxZ
 +spTHOkNAUxC2Q2GLyXQSm4yxobSSa7r3W5iYwQv9PBacEHe+xJPg1fPZEZp+k7f
 lxpsJhf7JP+sAwh4k1GmFzN+mm6mt/GiFitosug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:wv/eGDeElSENTGA8Ghx+iULvw+yggP6rkdnx5gKwE3g=:lsPRW5tbvjV1yB2K11YVzDhVzncaGOx91nla6MReLdw=;
X-ME-Sender: <xms:lvfmasrw7k8yaVKHeIUXNTqL-SMeEiOd4l2tWchfSFh9zGXbws60PQ>
 <xme:lvfmak-mQ3jm6UQKwItz2aTDrt-nnpoMXb7djmqVRZpWuB-o8I5luVdQ8BeJ50re-
 LsHErccyN4cwKeTjb7kjvFuNrVl0J_RXTclRRQPgREEsZluOt_iyO3H>
X-ME-Received: <xmr:lvfmav4m4Ou89MxTcoRt5HJBrRJRbdlErDs4v_jRxEbpFdpuHyHDrgwZI1TyLdPCSHJcweyM>
X-ME-Proxy-Cause: dmFkZTEio0HITRPU8VpT4PebgbYf+HqQTVmTBwoXIcaWhSPJQuOpCGNL4Feyfw1mm6jNto
 aCqGt+GjGmHddQdDYMsFOcBW2fd2wbE1C2hSqpUPgYFBCtzpG0VAhrL+r+dSJb3xHPmeXu
 bbiU80H+3s8diofjGu9JFbSOoisVQrvN3eDU6svi49hrmcI63rUfSkuUe5+aUvGFuszdig
 Qnc72eHSOddgDW0HvcKHXNvldok2Sz2296F+6Jr1XxRzNWV9h54MRHCMGFMHXdGms8Xsm1
 Bk/Rw1sBqh58/z5F2FEqlRBvxPnvur8T5rxLVrR8npGrMSSnol3N1co7aLduCklPXA/va/
 YXTHoUsCnKY9azuEaJJ5cCfMAuVhudV4dodqOzomVIYegi3ufkxBF55rrFoq3iaq6LHP33
 T76ZGeyGkijxFWxFlKRfgjr4wSs8XktqK9Cmvzz6H8XrlQbewx5zl72aflAIu/xJmUigHe
 ihwQFF+zsQXm5SSJ7HLlnBh5Kz2GDn0QnNv3awq93FX17kx4AxbOt97kEUTVKpXIVoXzrT
 xIXSHsKBUmxXWaF7TwhMQP2jYb2EtSIjvqSLK9L+56g8vFQOYlJ8YJwAmO1+lut35s9urn
 QvjPedj4/VeZ9I8NgTPNqwLUBD/0eyh+oDkjX0x/7kEUCaaYL9QzhA12nA4A
X-ME-Proxy: <xmx:lvfmag3kzYBO9WRsiDPs1ACndkAeqVnYC2zDsUlRioWhP2-sZPpzXw>
 <xmx:lvfmapjkGvKVYjvQfdTwGLhPQ62aXV3SiAYxBQ8ES1P_HdZZl8eyvw>
 <xmx:lvfmariUw_ppVMna6bgM_sYzZep3I-FyI8HA-J2lnXjfB91kZhx7bw>
 <xmx:lvfmalK4-DC1STWBHZWukQl1gPsGcWwbudOWBVlx-nTZY2ajX8FAeA>
 <xmx:lvfmam3Tn_xs7OPK_vb-d-tEDN15IQfKJm_Q4C2HTj2qrjyPjgnNri8T>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:50 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 15/15] arm64: dts: rockchip: enable the NPU on
 rk3576-rock-4d
Date: Sun,  1 Nov 2026 21:23:07 +1300
Message-ID: <20261101082307.151957-16-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
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

Enable both NPU cores and their IOMMUs on the ROCK 4D, and make vdd_npu_s0
the NPU domain's supply so the rail is switched with the domain.

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

