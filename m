Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CFBFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B35810E970;
	Tue,  5 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rk2awgdX";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A0910E0B1
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 02:14:12 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35fb262f92cso826069a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777860852; x=1778465652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+aGMILBpdA7Z2vP2ImAoYwoEz5ssc9d51Wzjj0viQYI=;
 b=rk2awgdXxFfYIw20Zz+7uvRmXUiMLH6YM0MTces+tcaqAu8YwX+27lDxz8TPjxlw+3
 oDXmULeAf6I49XOt+ELjELK/wUsWTgGyDU1BgbbyYigW97jnOkMNi2GGHOhtbTswT4Zz
 bqu9ZvIMkYXfMU4krTDenGo/fN1cx0JEct+gLM3AwQQyGSYex6HwDG39PJSnNaLc8TqB
 I0pJA967Libgy3M69cX/bJ2mfGbsnYFjQvE3jwwnIrKR92a6UqyBqExoKfRKcF7tDml0
 0Pxw5E8Pcl9+GT8VQGOV1cwCH2zrsJZM+MTStGO043k658Dx3KDP5wDuX1D6lj1h9AXd
 PlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777860852; x=1778465652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aGMILBpdA7Z2vP2ImAoYwoEz5ssc9d51Wzjj0viQYI=;
 b=m869cUM70kY2yBxPDwHoP+aE48Kxzp2/4v/6CST/JpkjVnGAdUGI90DUCZObkwLVVN
 0iJ9a7yLGFS6d4RlW1IHsiefWGY156RryOKcHPK1hAgUmk2ewZkXdc9mZwcZINM/Kew6
 LxxLEUB8TRbxQo2M+Mxa9j2/RHna5tRzYQszYBpui1ppw7s5GD+uuVAFptP6OLEFqyVY
 QsrT9+aHFwBPHiQZN47tMzxVUzF1OZNcfvJQMzs6EpJggrBbJknZWERb+oPVMNZG1ewz
 15mYXXYSz4NRWq4KEJ08lmqlmZhoHpnwfkI9ap1jisCgMPu/TEhjn0N7E71qEE1d+miH
 6MSg==
X-Gm-Message-State: AOJu0YztkiP7YkDF/S/IBhttg4/JuPSEbcPsLGNX0BcHSeFIPu2+Yu0Z
 CF2yONP3Ft/aZvGld8/xTd3P7LgL8betVSzfxoudsFEF+DBkVHpKveVc
X-Gm-Gg: AeBDies1R3DGuwM3/E9rICXTbhPKHX9tHU6McjDXwwrXav5QTgvC21AoC9YJDjs7RAH
 kumWkYHA4WCbJUUH2e8YpBv6kUTR/jzutYtn8nAREOoxHEjWW8xlj1ownTBqXcj/MUu5f5oHdBH
 ISgpcBP/tesd1iAeyofo+QSI0wVFCDRpjpuUmtf+DVpu/nFPC9Ve2IKHw/EZ0ojMqmHUFXrI0M1
 nNbsDBDoo8lhORcZAsXEusIhPnUEvHEIpcTFR3soz/fklefVwULzXf0eatI3kV2Qduk0QYjOdIk
 cs7NP+P/yqY+XkigGMi2e/ZbEQcivbPriRvEnWMcGIX2F9RFhW8Gx9GdMBc52rVePQf4KCD0Gc+
 XgIWeTZ07cz+E15+OkecuGe9xi0p/KaOUFb+Qmw7NozZiYSR/meEYlaS0Um0pXS9I3wc+IJOslv
 SSuHxL8QMy8bUIlJKkjNfXPe1NnFsceIzPk4k+qLcRc/s=
X-Received: by 2002:a17:90b:2b45:b0:364:6f0d:c0fc with SMTP id
 98e67ed59e1d1-3650ce8437bmr4116823a91.7.1777860852258; 
 Sun, 03 May 2026 19:14:12 -0700 (PDT)
Received: from marchy ([2405:3800:95f:677d:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec73aasm9365566a91.2.2026.05.03.19.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 19:14:11 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	Adam Azuddin <azuddinadam@gmail.com>
Subject: [RFC PATCH v1 0/2] Migrate RAiO RA8875 from fbtft to DRM
Date: Mon,  4 May 2026 10:13:49 +0800
Message-ID: <20260504021355.72128-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

This RFC migrates the old fbtft fb_ra8875 (drivers/staging/fbtft/)
to a proper DRM/KMS driver. The RA8875 has a 2D Block Transfer Engine (BTE),
a touch controller, and PWM backlight control. This driver currently
implements only basic display pipe, with BTE and other subsystems as
planned follow-up work.

This driver does not use drm_mipi_dbi. The RA8875 SPI protocol is
structurally incompatible with both Type C options drm_mipi_dbi supports.
Type C1 encodes command/data as a 9th bit within a 9-bit SPI word. The
RA8875 uses a full prefix byte (0x80 = command write, 0x00 = data write,
0x40 = data read, 0xC0 = status read) sent as a separate 8-bit transaction.
These are not the same thing and cannot be mapped to each other.

Type C3 models two transfer types via a D/CX GPIO. The RA8875 has four
transfer cycle types and no D/CX pin. More critically, the GRAM write path
is stateful: an MRWC register-address transaction followed by a streaming
pixel pump under a single CS assertion. There is no way to express this
through the dbi->command() dispatch model without either abusing the
abstraction or reimplementing the transfer layer underneath it anyway.

Other than that, forcing DBI would actively obstruct the BTE
implementation, which requires direct control of the SPI bus at the
transaction level. A direct SPI implementation keeps this path clean.
Any feedback on these would be valuable.

Tested on Raspberry Pi 3B, 5" 800x480 display, kernel 7.0.0-rc3.

Currently placed in drm/tiny for review purposes. The intention is to move
to drivers/gpu/drm/ra8875/ in v2 to accommodate future BTE plane support
and the touch input subsystem on the same SPI device node.

Known limitation: at 25MHz SPI, full-screen throughput for 800x480 RGB565
is physically capped at ~4-5fps. The driver mitigates this with damage
tracking so only dirty regions are transferred. Full-screen animation and
video are not achievable over SPI at this resolution and are not intended
use cases for this hardware.

Some questions:

1. Register writes are currently capped at 1MHz. The datasheet allows
   higher but some boards have signal integrity issues. Should this be
   a DT property or is 1MHz a reasonable default?

2. PLL initialization hardcodes a 20MHz crystal assumption
   (PLLC1=0x0B, PLLC2=0x02). Should this be derived from a clock
   subsystem node or a DT property?

3. Currently using display-timings in the DT binding with
   of_get_videomode(OF_USE_NATIVE_MODE) in the driver. Should this
   use panel-timings instead, or is display-timings the correct
   choice for a controller-level binding like this?

4. Given planned BTE support as a DRM plane, is drm_simple_display_pipe
   the right foundation or should this be a full drm_driver from the
   start? Happy to restructure in v2 if consensus is to go full split now.

Future work: PWM backlight via DRM backlight interface, BTE as a DRM plane
or through drm_rect operations, touchscreen via input subsystem.


Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  76 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  14 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 681 ++++++++++++++++++
 6 files changed, 780 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.54.0

