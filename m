Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCD606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=J6g0BAVG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ED210F504;
	Tue, 24 Nov 2026 11:54:50 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7471610F505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=ZfR/6lnsUE/pnRQi/PbCLWIsXUsmgZSZZiyw7HHwysA=; t=1795521283; x=1796730883; 
 b=J6g0BAVGuTFkRNHC+fQnKh0SsK564lCMw6z08/O3fEGt4Tl3r/ZlOhfId4L8drXyAWFhizXo3vU
 7eiL77q/1fW7xjmBQMRO2r96qAY0Kdd/8cY16vahSC2pvee8O0SiAVZzedWJnt/OOPKswWonahXSV
 RvSWg+RgJwMN1gdtx0D5KC8ZLdwp8jVfgYbvFZrKUr+VGMKD+OJiANou3S3mgNf5/SIQ92UH4jEKl
 Z53RZvj2URpbrqOe/4fVXAM1QpG/VAiFOn9fb1rlc3hR0QLx/hoHVOTfND2gNzGT2AsgG1F2b0TCA
 KATEUtN7TG1L2smpGkhJp38IuOKVv3RlPx5g==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 24 Nov 2026 12:54:18 +0100
Subject: [PATCH 2/2] ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset polarity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc3-reset-v1-2-a5d27fe4b5de@kemnade.info>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
In-Reply-To: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@nabladev.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=GLBUHsrqFLUlRWZt8GXXwr1nDsTd3sjuIa8AxQT8QUI=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBrBXr1CRJh/k3SF9zhnM67HN2W2PpCGKtwoj8rs
 m16MvjwmDqJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCawV69QAKCRCEYUX6QCjc
 8ca2D/oDzZqBbg9Q6EtTMYB9aOdp8ZoNadLZJTOgTpzJyL2LzN9+ByFR/egZ410Qg7AVj2SB56P
 hZaJ+H/QyPO2Dx5opg154a4TR94MtYM2Q/1FpSRV68fE1HmNPVApLgZR6GM8BsB0wGd4a0O9nd9
 fm1cdr+PmQU42qZXM9Z5fs9vvqyNj+bXFycpwr5Rq3EBGdhRRf6UMq+jjnXrKtN+O2UekTpC2cM
 Epo+k5CGn6CLhbuMqUCsTizWdxBkpfHBxEVpcyO1/DuPeyxv/H+aH2VwuHHYYeoFCSWs0+FAcmg
 5DOB8uU01m7RdkQIbJjm6HhO61RR7e6F5tSa2TNOzbwxCCjWhzp1KXXe09VoIKjE0xYfNcfy2WZ
 32ZoKTCABmz7Yh3scDhhB+LIrEX4r6DfSRIMxCzF7ztjkalnufW7nxCfvLdeVKil7TAWweKzoZP
 py+vB95lER6nvtaZS6Ie4N3nuTccqCqAU9utFpW1MhibUlFNq4j4fGQyQrl96iInIds2t0GsD6k
 BI+NNo1R0cToaZSjgXerjfDefiH4Dc2Qhp6QVmf0P6dHswP8VE1lj+xm+QbcXg76BHs666QdzKD
 TI4Q4zEpf4PR1ddQCM43HmVM5GhWvPkVcZ5/y+nR4KwbyusEBicryFiVy/LjSmN3WcvkRNxNqXc
 IQDAUPDi3mgPpUw==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Reset is active low. It is apparently set to active high to work around
a driver bug but not to indicate an additional inverter in the signal
path. Correcly describe the hardware.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
index 518c269a1dba1..6342a6e757c12 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
@@ -35,7 +35,7 @@ &dsi {
 	bridge@0 {
 		compatible = "toshiba,tc358762";
 		reg = <0>;
-		reset-gpios = <&attiny 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&attiny 0 GPIO_ACTIVE_LOW>;
 		vddc-supply = <&attiny>;
 		status = "okay";
 

-- 
2.47.3

