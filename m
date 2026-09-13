Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB20C88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932BC10E812;
	Sun, 13 Sep 2026 06:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="fXtyPWq/";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649B910E812
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b041m3FFV3xdV8s944Kse+crSg3aFNdjdNDNILp69A4=; b=fXtyPWq/YGUFONUzpiG87CI0mR
 9nnElNXy7anUt0s0ipfiYloqOk39cCde2mMT28j3DRe2AqM7blvG+8uEqzO5zSj+MzpvjGQxx4/0z
 O8g87KXtRaD/RafjxsDowd84g04K+kw1VJjmh1kvbiX56c2F4OIMWWm87v94rhLjid4w=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x5cu2-0000000Dxg1-2GZR; Sun, 13 Sep 2026 08:37:24 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: [PATCH 0/9] drm/panel: novatek-nt36672a: Extend with 5 new panels
Date: Sun, 13 Sep 2026 08:36:32 +0300
Message-Id: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EMBCA4VeROWvCoI19FXFoGYxIVzqIRLy77
 jp+h/+/QCgwCXySCwIdLPz1EXmaQDdZP5LiPhowQ53VOSq/FVobtGq1nhZRVJTWoDbGuQpitQY
 a+Pwfm/a17G6mbvtt4L4fOkZSOnMAAAA=
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
 iAboothahir <aboothahirpkd@gmail.com>
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
Alexey Minnekhanov (9):
      dt-bindings: vendor-prefixes: Add Shenzhen TXD Technology Co., Ltd.
      dt-bindings: vendor-prefixes: Add Shenzhen Zhuohong Electronic
      dt-bindings: display: novatek,nt36672a: Add 5 new panels
      drm/panel: novatek-nt36672a: Set driver name to novatek for consistency
      drm/panel: novatek-nt36672a: Combine two init callbacks into one
      drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones
      drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
      drm/panel: novatek-nt36672a: Add panel for Asus Zenfone Max Pro M1
      MAINTAINERS: Add Alexey Minnekhanov as maintainer for NT36672A panel

 .../bindings/display/panel/novatek,nt36672a.yaml   |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   4 +
 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     | 549 +++++++++++++++++++--
 4 files changed, 531 insertions(+), 28 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260912-nt36672a-panels-e34a72677bb5

Best regards,
--  
Alexey Minnekhanov <alexeymin@minlexx.ru>

