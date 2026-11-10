Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB340606E47E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWG5Ogrb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4B610F6B8;
	Tue, 10 Nov 2026 13:05:30 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0709610F6CF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:22 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ed283e2bffso2108195ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315921; x=1794920721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6x86s7blevtluoP9nJsSdSKJgLOgTfshLxyDXczjN8g=;
 b=zWG5Ogrbc7XKtiqwF7qUD2PEFxeZK4I0Rshk1Pf1Rxjyg1BQmE1DUaHccTFzKrIFQ2
 PFGiZK2Kbmp+srOE7/qvxoZdWGXQqt61A8j2NSeVqZwJrqvhg2Qin7rCriiynz/uEbYh
 kIC2JKKD+IdacTBON5y8UViU3VCRTmcftDXLuIt+9NlgXuBLYXQHGV4mhDy917ACCYvP
 OA21yg99WT1XwCsPVS8EAoir8ff/3T6RY4NVc1bd444MmonV8oR6/VAKnSU83Av6t+S2
 jcb6kDO7wPhxs1DM9N85Z1PFRN99r3LgCTIM0O3MlVsb2T2KRM46OHnr2+Fbag+HZpsq
 ywTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315921; x=1794920721;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6x86s7blevtluoP9nJsSdSKJgLOgTfshLxyDXczjN8g=;
 b=XzI/4pexEhU72TqHq0+rkr+Td0r1wiJUOA8GJSZn7QNf8GchsWKulwG7oDs5UM2c2R
 bwkHafJCHxOP1DX4YJ7g9hsq1Zbh/pNlfBSvrsIyAEeS5oEFnXEqcUddYr8Vk3l+raAU
 JkanKZJFXjuLQMNvy6jRD7WqTC3y/wNpFIBoM7IJD5dUowQZybZJOQOSt/x20oJ7/2fP
 IxC/oMYDa+vIJlzibjW9ojXfgGPPo7P+4z6NxdQCQltkF/FnBCrCdQzg+GgCpLVITGwi
 m8vX0q0RtwrCSmjixC2I+FCV6oPyyE7P5l7gSZuEsozmblYXnKzeY9q76wnQw8gP4bAF
 bvnw==
X-Forwarded-Encrypted: i=1;
 AL+hErHHuJ7RWSIMRfbLcj3P4skSCByeC5j44NxHV/BsXnl66Dj6pPSXT7MLrRJ+JF9jGcrO1TDqTrWJUi8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81stXyVmtnrCfQEhu0yFURpWXzpivZnyBcHEjjcVtb9TH5Xpqr
 p60fHlbKLinb4BJ+97A2JZtU41l6ObW6ElFT+au9cyEn1i7WA/1k4piQ
X-Gm-Gg: AYBFou3Z41wD3ryffIXmqdgCZndnbfd2jJOX9xgsh/Eg3Scd2SqUHlILXz7IPrleWC7
 TMCg1pw/U+Iy5DM0ObUAfNWioLGdn6BP3m+7NWO/64IHyk3gcyeeaUcx6lL+Zjw4PsHLL+EOsIH
 z2Y2lhOG6hXxdPTy6ZC5zHQB4V6f3qq8+19Pw+8ykPlNzaVEEaO7Piex7d98nKhPsK+f/qBT9zZ
 akbcwHaYos+BPDwVTA+rKFtmIoIxortNsanF4YN5RAzkal/YYH9iwS4RPy/vcJr8jiQLYmymq4x
 nZ9jf5pBrU4EPgreAw7aIwLCYC+n3k7kaljISPBU9ChHdUE+E7XVtIhFVyeCDsawojHRZrCBj7e
 S7tiBC+TR+gUdjkdcK5eZUxoSXfNoMowg38KHOGKotyjEZiqonFRFVCH6LKtZwYZm4VFFAxvgr9
 V4rXXhvtND2BS2Ga0KpIwCx7fBmIG+Ak+ESrI7c7VnGwcwpA6sIIdRqQMgoqQGLuH+ey3p+pYUA
 jCMwM2HbeUmaRnBU8ToKZIY3W8aZyV7RkxrTmuobPiJ7ZjtL7GHiaFW+W77nOkmPSjQFG22gl0/
 2RFFBDesZ4rNbtP9y1tZ82nzw4Y=
X-Received: by 2002:a17:90b:53c8:b0:3ac:a7ee:6785 with SMTP id
 98e67ed59e1d1-3b166ad51d9mr4660163a91.1.1794315921137; 
 Tue, 10 Nov 2026 05:05:21 -0800 (PST)
Received: from marchy ([2405:3800:918:486f:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1678d1f42sm3982296a91.7.2026.11.10.05.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:05:20 -0800 (PST)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v6 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Tue, 10 Nov 2026 21:05:12 +0800
Message-ID: <20261110130515.45819-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a new drm/tiny driver and matching dt-binding for the
RAiO RA8875 SPI display controller. An fbtft driver for this chip
currently exists at drivers/staging/fbtft/fb_ra8875.c, but fbtft is a
legacy fbdev-based staging driver, and nothing in mainline DRM
currently supports this controller.

This driver does not use drm_mipi_dbi. The RA8875 SPI protocol is
structurally incompatible with both Type C options drm_mipi_dbi supports.
Type C1 encodes command/data as a 9th bit within a 9-bit SPI word. The
RA8875 uses a full prefix byte (0x80 = command write, 0x00 = data write,
0x40 = data read, 0xC0 = status read) sent as a separate 8-bit transaction.
These are not the same thing and cannot be mapped to each other.
Type C3 models two transfer types via a D/CX GPIO. The RA8875 has four
transfer cycle types and no D/CX pin.

My ER-TFTM050-3 board has RST tied NC, and VDD is a fixed supply
set via an on-board solder jumper rather than software-controllable,
so I couldn't test reset-gpios/vdd-supply myself, but added them
as optional/required properties respectively per review feedback
for boards that do need them.

Tested on a Raspberry Pi 3B connected over SPI to an East Rising
ER-TFTM050-3, a 5" 800x480 panel driven by the RA8875 in Linux 7.3.0-rc4.

Link to v1: https://lore.kernel.org/all/20260916175942.3186804-1-azuddinadam@gmail.com/
Link to v2: https://lore.kernel.org/all/20260924145400.1385815-1-azuddinadam@gmail.com/
Link to v3: https://lore.kernel.org/all/20261001144128.2336301-1-azuddinadam@gmail.com/
Link to v4: https://lore.kernel.org/all/20261012064518.3497285-1-azuddinadam@gmail.com/
Link to v5: https://lore.kernel.org/all/20261030083737.47188-1-azuddinadam@gmail.com/
---
Changes in v6:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
- Drop Assisted-by tag.
- Remove sentence referencing driver polling from interrupt description.

drivers/gpu/drm/tiny/ra8875.c:
- use drm_atomic_helper_connector_create_state instead of
  drm_atomic_helper_connector_reset.

Changes in v5:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
- Drop the "Add YAML binding schema..." paragraph from the
  commit message (Krzysztof)
- Add interrupts property for the INT# pin

drivers/gpu/drm/tiny/ra8875.c:
- Move bindings table to above ra8875_spi_driver definition

Changes in v4:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
- Drop the sentence in the description saying the binding covers only the
  SPI-connected device (Conor).
- Drop unused panel label

drivers/gpu/drm/tiny/ra8875.c:
- Catch error value from ra8875_write_pixels
- Use consistent include header format.
- Return if fb is null in atomic_update
- Drop unnecessary extra byte in pixel data spi write.

drivers/gpu/drm/tiny/Kconfig:
- Add depends on OF, which is caught by intel 0-day[3]

Changes in v3:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
- Add gpio.h include in example to pass dt_binding_check
- Remove spi-max-frequency as there is no reference in datasheet

drivers/gpu/drm/tiny/ra8875.c:
- Remove debug-only ra8875_read_reg function
- Chunk large SPI transfers to 16 rows per chunk
- Remove unnecessary includes and spi cs setups in probe
- Create ra8875_write_pixels function for clear_screen and fb_dirty
- Use 2 spi writes instead of 1 write with 2 transfers and cs_change in write_reg

Changes in v2:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml (review by Krzysztof Kozlowski):
- Add hardware description to the binding
- Drop the display-timings property, and instead require it in the required block
- Add a required vdd-supply and an optional reset gpio property
- Rename the example node to a more generic "panel: display@0"

drivers/gpu/drm/tiny/Makefile and Kconfig:
- Remove TINYDRM prefix from the config name (Thomas Zimmermann [1])

drivers/gpu/drm/tiny/ra8875.c:
- Reformat device_id table to match current convention (Krzysztof Kozlowski)
- Drop unneeded linux/mod_devicetable.h include (Uwe Kleine-König)
- Use drm_dev_unplug() instead of drm_dev_unregister() in remove callback
- Move stack-allocated cmd/data buffers into ra8875_device struct
- Add mode_valid() callback to validate height/width against panel maximum
- Add optional reset gpio
- Use dev_err_probe() in probe function
- Remove connector detect callback
- Remove unnecessary |= on register write return value in hw_init
- Migrate from simple display pipe to manually-handled plane/crtc/encoder,
  following the simple-KMS-helper removal effort [2]
- Use defined constants instead of magic values where possible
- Use drm_atomic_helper_damage_merged() and drm_fb_swab() in plane update

[1] https://lore.kernel.org/all/fee2a743-d3e4-46b4-812f-05c3cc3a46ae@suse.de/
[2] https://lore.kernel.org/all/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com/
[3] https://lore.kernel.org/all/202610042347.idGisdDW-lkp@intel.com/



Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  86 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 719 ++++++++++++++++++
 6 files changed, 827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

