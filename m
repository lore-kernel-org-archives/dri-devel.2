Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015D606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfMNQsFl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E25010E857;
	Fri, 30 Oct 2026 08:49:25 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CE610E857
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:49:19 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ea19c28a50so1403685ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793350159; x=1793954959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kKraBs2ABl72GsuXTCZX2vWgKGWo1rPo+MH8y/IARx8=;
 b=wfMNQsFlKTdjzOQvpkHiACmw5xn8dEq17v4vJjIQMKn0x1OrqpwvvdVxzwXZb1Kh5x
 NYDv7ZKcJwBDQfN1xZ/m1fAjUqiPZKRE94zqB9OyEiDvWKRVUsMlgzUNRsHn5/skoj7O
 O6ONnz0UDx+q+k+jxQxg1SWy/JKo4PnWeqAKhp0PWVdm2ixzNzNTLrCOmZm9B8CC99YB
 Zw/Hw98lb2nUgpIti/6HDlXcg0J1ExNskyXbgD7YkseElCh82tphFl9YkPNUi0rVl061
 tvppROeCaDds32MDroqaMHrUwosg4tr8kGzkHuGr+3NP/3/PQ03cwTafUBgdQXclslj8
 kuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350159; x=1793954959;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kKraBs2ABl72GsuXTCZX2vWgKGWo1rPo+MH8y/IARx8=;
 b=gjZwR3dfMVlaQnbg8XAMUlN5d7Wen8Xz42r+1w/m2+opsNbPuAvDkC7BcwmT17iYE0
 O9P3AtYMzlfWiLuxI05DhPh4jZB/IlAa5AyB43dwqDyisE3uHBU1EB4gzBKwPznuxO4Q
 4wxDaFOesdRwJBhlh7u4uBrWpE0WceExncCcWRr8aHzKYG+TOytdbMYbcqhyoLM28M52
 NWpVQtoDIHa31hd64SdGlUAk0FaJavzVtIUVQY/S+f/iNZ7iqErplHPl0Z3yxTso/0Wf
 SFEWVmzXZuDnjapuzXpq6hlgLovD4rdvxHRJOFeNn0QYfgRhqVu2F/B/9AXCVueko4ap
 esHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBylkGrLIuV4hoXNPDwLVFIXUuQ/Ek170dCXd1c+N1Bbxfn7vDrcn500A7pGPvrttyxK1T/J+JYbc+I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLCc20MTDogAlGSX1YMu6AyoPUpay9CgA0T/uZWO45w17QTebsq
 9MJqv2orgJXeS3WSFYybcbKcZQGRzguwgdoqn1L/6KKHzddPOEfnjBeKPMk4X7M3
X-Gm-Gg: AYBFou35TU1mwfsIuHeVMl8fYl/Y4LiqIIKLUFdmMtWGaIoSVXGehwfHq7k66D+oKDC
 gQu5Cun/NragySxrBhPA38U7dAos/v6wtBGgoXtiIlqOSVWZSttEMHk9VPHBNKK6jWKEXn7aVjD
 b9C194U8RVUU5yzGrUFUrWPHuCkP8KLGhWnxNID9W7F4qrQz3kpgQ0tMuTC6fZ0OSlPAIjOr1oE
 9NQ1CpMphLa8RqkiyLsvawcZzOxCJj7e5g9wMAU/NAWlmQok+1pWMqTGlcjuEIZo+4o9WmdHas5
 lcmwbcsn6ZGYTDS7OklGc/dJ5HHqlX3qg0TmHFXahcJyYStLdzDs0QLvfpjrUQhN5yLarMCl3v0
 D/Fz/5dwM4I1rPpvZIpC6SnhxYjY4UKraA6S38QaxWKrC8PxUH2nKD8A/wsNgXfoGpxEM5T50kj
 yXKqEq/fXPPsVpIeCQU7S0iiyPhIA4pbDyeu/SPfUJxRQ2W+grwfQaBl5LBvaBS/2L11MbCf2ki
 OkFk+i17UfDZpJKKii+99NvlHqSoT3CqDGnbZsUBGmG6B1j58sM1IjC4F+23O7HpvvXZpeu2dIb
 +3+qGbio3y/ISb/AQU5ZKg==
X-Received: by 2002:a17:902:d502:b0:2e9:6788:937d with SMTP id
 d9443c01a7336-2eb364bbb77mr30486455ad.4.1793350159314; 
 Fri, 30 Oct 2026 01:49:19 -0700 (PDT)
Received: from marchy ([211.24.73.58]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392b15f0sm4576265ad.73.2026.10.30.01.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:49:18 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v5 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Fri, 30 Oct 2026 16:37:34 +0800
Message-ID: <20261030083737.47188-1-azuddinadam@gmail.com>
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Based on drm-misc-next commit 73df79cceb8c ("drm/virtio: add ARGB8888 support for primary planes")

Link to v1: https://lore.kernel.org/all/20260916175942.3186804-1-azuddinadam@gmail.com/
Link to v2: https://lore.kernel.org/all/20260924145400.1385815-1-azuddinadam@gmail.com/
Link to v3: https://lore.kernel.org/all/20261001144128.2336301-1-azuddinadam@gmail.com/
Link to v4: https://lore.kernel.org/all/20261012064518.3497285-1-azuddinadam@gmail.com/
---
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

 .../bindings/display/panel/raio,ra8875.yaml   |  87 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 719 ++++++++++++++++++
 6 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

