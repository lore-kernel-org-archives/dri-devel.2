Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF978606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYkSyXjE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4043310F86F;
	Tue, 17 Nov 2026 17:41:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA6710F86F
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA2234065B;
 Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794937269;
 b=I0BVdHDi2BfYv90RhlOr9Lr0bOayMAlSSAQ8LiPWg88locaZPtZ9G4xu0tGuvNFlEdiB
 BFuxfOzHEJGWw1bHBB+LAMkn/4NVxhqtW184YA+od36nlNfv9pPO8iGXiHWIfuxZBUrKP
 jVvTJ72JBMRYp+o+6c49SQqa7SMmyfxk/Qx8YSL/WkOBfhKCTGFRD6hNXPySiCHl5uV4T
 BPtC2/wm2CvmnQqNJ4lwIA+Tf9YSAryb3NN2d11vKClbxhALxkzrGoiNvbsczs6TkbrWt
 Nx1JvYJwRokemJkc+JOZjpMOW0DskjXJeB76QuKyGayNFSOWe1sMFaFFiDnE26DDvNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794937269;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=YXlDBZaIvHo1e8VAiEashHwtglIY0Ep4HLvUXrdMPlw=;
 b=r9XvizCuHIf6GQXjeb5Qt67MAs0cSRPs1EJzQ/U/BhvqbD4oeIiGogCJ2UYJR7tWHT0i
 RYLJUr/qK9oaCFWBoBS6f5Cqo+Igr9kCks2i09tGh+M12CcObPdZQPLkOLthFeyxLMbZH
 1PGBjB2p+3//VpSVypBfoWa60oyQp/s47dR8gG1uZ5lMqgjhD1iETFssArU1GgYfrT3av
 qV+lcX9Su7iBp/jwpCLwnxTjsjwzvBeZQT+ncBDlmPXRzlYPdc1Fv+lTLdYWss7OWU+2R
 0TU/4a7kcNx+w9gmfphnH7soFP5g1hIMsnIbgW5tWKs9LrA6Urjb0gmYfZHl+D8mkHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EE7131F000C6;
 Tue, 17 Nov 2026 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794937269;
 bh=YXlDBZaIvHo1e8VAiEashHwtglIY0Ep4HLvUXrdMPlw=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=RYkSyXjE9IAgeydM0LPE1fBgolP7L1M15dIEyE+OUkh1gfjutGEyAZA9406V/gtEm
 gbELMh/Oz9Te5GdelpTeIH0FNDS7GQO3CWpbDyY7EoQWNtsCGtNNzIqhoheaYnCKi/
 zqYLLjgtJDd4ZIc/7jKAFNG9SeFRL34qcpMUFjv3xKHMhv/FwgsTymuLkyIzjMr02E
 U5/RvpPSxs8sRfuX4qNJvRh9Q8oT9m5AM2N0+PQxuI73puYGJaVkn1Osp7ahTR/y+g
 QdSG/bhd/rzN6hC+HhNzbVANhFK3rOTZ1lsTMC526mARaCq/kuBLe1YwI1JuxNGKmi
 kcx0h5Mm701UQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4C6824AA16;
 Tue, 17 Nov 2026 17:41:08 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v3 0/2] backlight: add ktd3137 support
Date: Tue, 17 Nov 2026 19:40:57 +0200
Message-Id: <20261117-6768-ktd3137-v3-0-b4fd957e3b00@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ7CIBCG4asY1mL4aWlx5T2MC6BTi9rSABJN0
 7tL68ZoXL7JN89MKIC3ENB+MyEPyQbrhhx8u0GmU8MZsG1yI0aYoJQwLCpR42tsOOUVLsDIkoi
 61UKhfDJ6aO1j5Y6nd4e7voCJi7EsOhui88/1X6LL7g+dKCZYl7poJeGmFHAYvYtu6JW97Yzr0
 eIn9iFQ8iWwLMhCClNSaEEVP8I8zy+sGjsXAQEAAA==
X-Change-ID: 20261102-6768-ktd3137-4ec95068fb6a
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794937267; l=1886;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=FSVxmo57BknMiKWx0HlL7rvM1SWImH1ToEyr5Lg5KGA=;
 b=6xP59/Y/AqYpXNqfijQP8uk+tItfqsnD/vfknkIo3xT6XvOWTesQ/9sLKcMSIUDVjHwFf5zuP
 CVa7id8j4z9C+ndMYh7N5W4ZntdP/oHZI02bEPzdMo6rJGO3juJZXtN
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
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
Reply-To: rva333@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds support for Kinetic KTD3137 backlight IC. It
supports linear brightness range from 0 to 2047.

While the chip supports PWM and MSB modes, they weren't included, since
MSB mode supports only 8-bit brightness range, and PWM is not enabled on
this board. I have checked other Xiaomi vendor kernels, and their
configuration appear to be the same as on my board. I'm not aware if any
device uses PWM mode with this chip.

This series was developed and tested on the Xiaomi Redmi Note 9 board.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v3:
- dt-bindings: bring back vin-supply (Krzysztof)
- Driver:
    - Move enable_gpio from the struct to local variable
    - Use .name for i2c match (Sashiko)
- Link to v2: https://patch.msgid.link/20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com

Changes in v2:
- dt-bindings: drop vin-supply from required list (Daniel)
- Driver:
    - Drop val variable in ktd3137_init() (Daniel)
    - Replace KTD3137_DEFAULT_BRIGHTNESS with KTD3137_MAX_BRIGHTNESS (Daniel)
    - Drop gpiod_set_value_cansleep() in ktd3137_remove() (Daniel)
- Link to v1: https://patch.msgid.link/20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com

---
Roman Vivchar (2):
      dt-bindings: leds: backlight: add Kinetic KTD3137
      backlight: add ktd3137 support

 .../bindings/leds/backlight/kinetic,ktd3137.yaml   |  64 +++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |  11 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd3137.c                  | 257 +++++++++++++++++++++
 5 files changed, 339 insertions(+)
---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20261102-6768-ktd3137-4ec95068fb6a

Best regards,
--  
rva3 <rva333@protonmail.com>


