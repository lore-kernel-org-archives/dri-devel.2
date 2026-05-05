Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B34ECD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A41810E43E;
	Tue,  5 May 2026 12:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oJumnstr";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449BF10E43E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:27:43 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ad2b375e58so2395795ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777984063; x=1778588863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VkB9fZzeXBdMOAv5MDDWZl0j3iCw0olbI+cJ31NwW94=;
 b=oJumnstrhqn7w+2f2s88iBzQ6I0g/D/UoTAsBHdaijVADzV5kP17SF4RQpjeOOFnPd
 Db2LsYbA7C9TnQqm6PiJa8IEQUJ9alm9xbtJdQs+r+DD6HiIYoC3IyZXqPHtkPnKmyQe
 OjCeon4+JL3tQK0fGUKdhCxTlE68AH6WJ/M5k+byvbZbdzxj0Mvq7oK8FoGKwju8FBfI
 3saYFSD3qXQYEDvnM6ec8WGDI4Wv53pD204/5xx7Xh28f/wtOY3ONYp84bwlGg6yap3b
 A1w62Ulsvzog0jnC9s6hJ6N0jGpaQEPALMzLYG6aUabcGRguStyjUOpfqsALY4zZTthi
 e/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777984063; x=1778588863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkB9fZzeXBdMOAv5MDDWZl0j3iCw0olbI+cJ31NwW94=;
 b=NNi7Y70G7EUVCB02DoCBKTjGZQ1KlkNtFdB0BjONqCMQ118zB/AsmjcE+/Zag4SSPt
 eKPc/ek+iVB3BoLT828pPfVbcimy5BvhJKO0shgCuy1zeSfLF3uMzweP9YNwKkT+2d0J
 TRfcsAQkljBut0iBYV6XYRBa5Nj7b3N3B71O1bxBJGA7uCBGl9CiqOV+OFS3Hq+VTR85
 db7uytgOBCTqm+Zuvlf31mSnfLXomQ/CfmZQSAAtWpdRyzIhSh5FUYwZiBUiges/u8Zy
 2tyGNgHKf1BBhHYKudaXM35nOvhx97JIZAACasV3VtUK1/mp9xBaUSQ5Px59lrBgMax1
 fbgw==
X-Gm-Message-State: AOJu0YzO8e1ZELCe2F6xhAM1pakCuW7wWuPzWHue+CnulpYsHFNHplx9
 zWgV6dSHFTZtyAFmx9XQ5V/6mHZIMkDnMjrDHLcOiDJNWppWe3+CZulJ
X-Gm-Gg: AeBDieuflkSzqOYoXqAZawykSifBEgH7MmCJsxgjf76KXzuLGVkLT6tWtmqdnYfNP1S
 7isUpy2T/8Ne27ZcWI8RIWqi24rSkViXWD/f1O68WVKDIbz+Rso2LblCXhFU70QJYi8G3mrSyGW
 m9Pg2BnzzJ4PsVFdurWoWJwuQNHNa/dgokAHAxGIQZff/S2y45Na8vkLpJ/1JATw1vwqzSIvPIa
 mQxdfCiomSndBx+ZEZLkrfIjrmBPE2Aie/Ostm2M52HaySDhYqLHM/42VcGyv0cBPSvC+V8pstz
 d6icMdegMJbBGWyarkTOq9SuPF/YgIBFslmROBuoeD4VnG8HFlSClH/Lu0G6HSX+ZD0NotGVCi+
 i96Dfnfvo3Kqpt5MfR2o9ZEOAiuVHq/C79wN0Bu1Kb9j0X2ydv7Lc+tv3aTMyaayGaWBKpjHbMr
 u7mTPp00v3XqA0JMAzuGTelqpMLYvOmYVE
X-Received: by 2002:a17:903:3545:b0:2ae:54b2:27d9 with SMTP id
 d9443c01a7336-2b9f283fc3bmr67457505ad.7.1777984062612; 
 Tue, 05 May 2026 05:27:42 -0700 (PDT)
Received: from marchy ([2405:3800:88c:d085:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caab231dsm139811825ad.26.2026.05.05.05.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:27:42 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	Adam Azuddin <azuddinadam@gmail.com>
Subject: [RFC PATCH v1 0/2] Migrate RAiO RA8875 from fbtft to DRM
Date: Tue,  5 May 2026 20:26:28 +0800
Message-ID: <20260505122636.11859-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This is a resend — the original submission on Monday did not go through
as I was not yet subscribed to the list.

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

