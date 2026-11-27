Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108A606A331
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjDMO9vk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD99E112BAB;
	Fri, 27 Nov 2026 15:29:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BFE112BAB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:29:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9775D447E8;
 Fri, 27 Nov 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795793343;
 b=SvGdZ1aNzqaZ32HYtanRIRQ7uuCg8uUfZTr6kNOLDYm/6JHnRFoeaesF0xvaca6SRoUJ
 HU9y0wdQyFDR2YQw9tQqmsGkLUVfeu0JEzpyZo5iI7EjVIiqeUCWCvwonl2R3+tOQBzrD
 eKWvjCoQ+Z+RHevILQ8CisY+Ng7MncwyWXbFoKlfd2XONGoNahoOnNv/KX1Dbos5vx8Hs
 FKbmBrYke2YYjd6CGrGbMAk4xMvKq4mt/YjPpd6XqLsJKBmPMeJlecYFHT/UiXMAJWlkG
 kCHpYMkcUgb5bIdAOSsdx8FEqXaaLLvruM+ermZ+3CVGOFs8LBglqidpGbRMHUVcKdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795793343;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
 b=lHkOaEpz4cGM29Xn6uPCiBoL/bu/WO/o06qwKLZ4kgvlubTRiGZWCCmejVVu2vk/GiJ9
 +n5FrqMrVU2XSDmxHYQ47rc30G+CUSRUPllI0OKu39AS2aw5XoXwTQapzjxX40juV88XX
 BWRWmVjp0Iie1TQRrzswLzb7OvwFS0dLpXvEAZMVJNs6QG8PbFpJdYD4DEy9tr9LWmCy7
 UPPZbgl4xRoTTv8Nf7/Fe9HcRCqybSieBw/yF5et+6yTtNJgw0ICrXHQLjwXCyTxMA66s
 i8Ud7fhebKivFQMvS4Ur3gZfSEsTbqhifrKvoP4CLEfD5iG1ee4mAg3dS5FOf2BshPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D3FDE1F00925;
 Fri, 27 Nov 2026 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795793343;
 bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=OjDMO9vkfL+uj5gUUtgO5sMfoySJp7q487ZkAd1uDGfsVDWFZgrdvfD//AO21NON0
 7n8t1RiEtmdUjmjTCkOXX7TjdF5EMaDuFRr1+MvK+kjFbj3fBdOhXiwUmw7uvN8+DW
 XozQfyzMsVdgM9btKfmasVa+cTY/XKdh/Y10HE5Xr6SAFL+lzg1oz8hXSYQxN4QziF
 EOvpPWtCG+RxJ336TUqVkith3iI9Y4xck8AS+f2gxkaYbbRyrOZ0tuUF7Sh9DzQKKO
 Esj+ujxFxhFoHmE7SnsNrmBOAQXqmcNxDTuJnsQgaa/Uabei9sBFEJh8VJEL5fqO7Q
 KuZ2WnM5OUzHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2ABFA4DC94;
 Fri, 27 Nov 2026 15:28:30 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:11 +0100
Subject: [PATCH v5 10/12] arm64: dts: amlogic: Add HDMI TX PHY node for G12
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-10-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=96ezTxgocDNVGkQVkrXP3m6ZHN0B1G+z/JYBO9mFeTE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwukyn0847WZYHLn8/IcP0e8fVVe5+mr8MXxhJbxD9
 75Eh8vOjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiqy4wMmzMKQr7FN8T33t9
 m1j+nSBR9t3/NFQ637VIOW77rLEkzYqRYef+cxPd1j7YdkyyMPpb7w3puccuLJ+RbH1go6dM19x
 bLWwA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Content-Transfer-Encoding: 7bit
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
Reply-To: linux-kernel-dev@aliel.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-g12a-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3135566df880..7f9eda4298e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -210,6 +210,7 @@ hdmi_tx: hdmi-tx@0 {
 					 <&clkc CLKID_HTX_PCLK>,
 					 <&clkc CLKID_VPU_INTR>;
 				clock-names = "isfr", "iahb", "venci";
+				phys = <&hdmi_tx_phy>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#sound-dai-cells = <0>;
@@ -1683,6 +1684,11 @@ mipi_analog_dphy: phy {
 						#phy-cells = <0>;
 						status = "disabled";
 					};
+
+					hdmi_tx_phy: hdmi-phy {
+						compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+						#phy-cells = <0>;
+					};
 				};
 			};
 

-- 
2.56.1


