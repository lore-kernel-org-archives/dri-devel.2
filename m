Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41590C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF4710E474;
	Thu, 17 Sep 2026 16:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="vXDNmjDm";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D6D10E4A5
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r3lFi7VTrci7wx2uzJUBSjpcitHOU7JtfeIQJ7cP2hM=; b=vXDNmjDmmGainwm17oqjrQiLWM
 YBxgjWuYrexzLJXFGQg159zezzMyEwbonCM6PzxEETXzfg7PFaXkjTWKLSlQM/i8/Vy9GDr0mt0pG
 vlgzxBuL3yaR/N/xYOf1yIEDBJjUPal5NI6GDKevwG8N/voDgnqjiADmQFKShsHO0Z70=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x7FDS-0000000Bw3I-1aE7; Thu, 17 Sep 2026 19:44:07 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: [PATCH v2 0/9] drm/panel: novatek-nt36672a: Extend with 5 new panels
Date: Thu, 17 Sep 2026 19:43:02 +0300
Message-Id: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0JmbU0ZsA2uvIdhUeooY7CQFkgN4
 e4WjCuXL3n//QUCeaYA52wBTzMH7l0CPGRgW+MeJPiWGFCiklWOwo2FUhqNGIyjLggqSqNRad0
 0J0irwdOd41681l8OU/MkO26ZzWg5jL1/75dzvnm/evFXn3MhhSVZ6VKiVWQuL3YdxXj0E9Tru
 n4AxUF8GMEAAAA=
X-Change-ID: 20260912-nt36672a-panels-e34a72677bb5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Aboothahir U <aboothahirpkd@gmail.com>
X-Mailer: b4 0.16.0
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

These series make the driver for novatek-nt36672-based panels more
easily extensible and add support for 5 new panels to it, used in
4 different smartphones, all based on NT36672A:

 * Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
  exact model string is unknown
 * Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)
 * Tianma TL063FVMC43-02 for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
 * Tianma TL060FVXS16-00 for Xiaomi Mi A2 smartphone (xiaomi-jasmine)
 * TXD TXDI600YANPA-43V3 Asus Zenfone Max Pro M1 (asus-x00td).

Combining two init sequences into one was previously briefly
discussed in [1].

[1] https://lore.kernel.org/all/20260523035734.6602-1-chintanlike@gmail.com/

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
Changes in v2:
- rebased on next-20260914
- vendor prefixes: changed from "txd" to "txdkj" in bindings and driver for asus-x00td
- vendor-prefixes: correct company name for shenchao, expand description, add a link
- nt36672a bindings: changed description to mention several panels instead of one,
  fixed alphabetical ordering of compatible strings
- patch 5: move tianma_fhd specific deinit sequence (set_display_off, msleep,
  enter_sleep_mode) from nt36672a_panel_unprepare() into its own
  tianma_fhd_video_send_deinit_cmds() deinit function.
- patch 6: sort compatible strings alphabetically in of_device_id
- patch 7: use mipi_dsi_usleep_range() instead of usleep_range()
- patch 8: use correct co-author's real name in trailers
- picked one r-b tag from David Heidelberg
- Link to v1: https://patch.msgid.link/20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

---
Alexey Minnekhanov (9):
      dt-bindings: vendor-prefixes: Add Shenzhen TXD Technology Co., Ltd.
      dt-bindings: vendor-prefixes: Add Shen Chao Optoelectronics
      dt-bindings: display: novatek,nt36672a: Add 5 new panels
      drm/panel: novatek-nt36672a: Set driver name to novatek for consistency
      drm/panel: novatek-nt36672a: Combine two init callbacks into one
      drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones
      drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
      drm/panel: novatek-nt36672a: Add panel for Asus Zenfone Max Pro M1
      MAINTAINERS: Add Alexey Minnekhanov as maintainer for NT36672A panel

 .../bindings/display/panel/novatek,nt36672a.yaml   |  11 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   4 +
 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     | 573 +++++++++++++++++++--
 4 files changed, 543 insertions(+), 46 deletions(-)
---
base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
change-id: 20260912-nt36672a-panels-e34a72677bb5

Best regards,
--  
Alexey Minnekhanov <alexeymin@minlexx.ru>

