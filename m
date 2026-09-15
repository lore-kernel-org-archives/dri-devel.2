Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350D7C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AC710E1DE;
	Tue, 15 Sep 2026 20:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="p/3+iy6R";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C6E10E20D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=jy41rL2C99WwqbzsGdokIDAJtd++SsNXJlNToXkn2/E=; b=p/3+iy6RKWR4fabVY+veX2qDX5
 3M6Mi0mDKUOLqJpVxavXxhT5TUBzoqRyOBfPQSvY9OdS4qwKr81ni24bLEnwzYXfgYygDKrEGxJct
 25nzHXBtAe13aaGZhgGt5jgwgS7x90RNlwXd/UpsHT1dIQLgP/wC2cUGVU53dCEEPhxaF1KqyqXLX
 u2BmjNKSXeEIUK6BqBQzN0mReXSRbLFLqkHhV0/r29t1bb9OyT7mOQNC4pec9leyev8TTRi6zDXWj
 X/N9ocs9CoBcGaoE7mgLkJby8uxt66PizPofzNZ6JU07/9Lan+z1NGmfX3bKwLh1cA9885wBBviaY
 wqxBE33Q==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6a89-002dV8-2I; Tue, 15 Sep 2026 22:51:53 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 15 Sep 2026 17:51:27 -0300
Subject: [PATCH v2 4/4] ARM: dts: bcm2835: Add the V3D reset line
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-vc4-reset-control-v2-4-cb3a25b07822@igalia.com>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
In-Reply-To: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dlVUl7bzR8j4uxgKwkmLFvf4+0M2KU8ullpBi92dtio=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqa/Q000cUx/ZW8mpeb8DDfkPFYfpnTN4W9XSh
 LhU6EWLAtqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmv0AAKCRA/8w6Kdoj6
 qqJeB/oCNt+zDr+CHDkq0/Srg7hMhDTiOysPGHI+za99lJDZgxABoGypT7fK8AxOghIgr6pqnTr
 Xa0OH1TzG5NWGyhNo2/h4SS0ExyFkj/y8nzmx5lLGRvEfrQVDZGJp2SeRBFa2if/ie7H/3MupzD
 g2Cbb8ryaLzl3gsNJcC6cACX+bIpSXjXlHrNxhj+n1GEREMQij5jBbLBeprKPXQIIYNFsoyicMa
 ao/wfPVPBR3aX5oGL1ZbnD3pIZacL7PBzO4f/u5Hs1gairAfoz5/W+VC91PQybMuSjwMs/clFI4
 JltT9I2ZkdYQCyfOUgl9Jf5Gk5P10y8zlQGGC6jMrE7wlCk6
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The PM block exposes a reset line for the V3D block, which the vc4 driver
uses to reset the GPU when recovering from a hang instead of forcing its
power domain down. Wire it up in the shared V3D node, covering BCM2835,
BCM2836 and BCM2837.

BCM2711 already describes the same reset line for its V3D node.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
index 1e76b290510d..39eea8ce1058 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
@@ -139,6 +139,7 @@ v3d: v3d@7ec00000 {
 			compatible = "brcm,bcm2835-v3d";
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
+			resets = <&pm BCM2835_RESET_V3D>;
 		};
 
 	};

-- 
2.55.0

