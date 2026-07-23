Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A29C531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D651910E5BE;
	Thu, 23 Jul 2026 16:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JawhSxzA";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A38A10E0AC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:32:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8C3B01A119C;
 Thu, 23 Jul 2026 16:32:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5E3E86038D;
 Thu, 23 Jul 2026 16:32:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 94D1E11C11162; 
 Thu, 23 Jul 2026 18:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784824335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=DFknPV/GGHB02nua1SEKnaLuICGqgcjtDBUVB39Ztr4=;
 b=JawhSxzAOl6E6aBJe0CaN1Gr8aoZxJvWHlkvwa7jKNFI2qDSJ1FIWdFoM7t/A9Oe7HZ39K
 7fNlAbALMJRDv661IJTVfaxsQbaiqxw24+xO2QuVs8r5Ae5sS7+aRJERcZ/fEL16LGqcRm
 Z6aIBH2Ch4KMU40080tT8Y+uevL6m1K1KKpdjlMCCzMKCRur7X+aSMtYaZcvbLKa2CZAya
 DaoadFv+KMhbTSvxKba/hG0gbsi0UVA3GnE2OZauyTL/AnpMjw26ZrmPs6NbcYcfcv4DR9
 bsDURO+5tr3H+5KeuiYpN49CtP7prxuFkDQRiOLuDmfkmZQ5KjqGerejyWVPXg==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 0/2] drm/panel: simple: Add support for Ampire
 AM-800480N3TZQW-00H TFT panel
Date: Thu, 23 Jul 2026 18:31:48 +0200
Message-Id: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ7CIAwA0F9ZerZJZaZDf8XsALM6TGRImRqX/
 buox3d5C6jkIAqHZoEsj6BhihXbTQPD6OJFMJyqwZBh6kyLOqc05YLuhpZoZym25X1/ItGInXN
 s2Xu7Z4Y6pCzn8Prtx/5vnf1VhvItYV0/r5aMYH8AAAA=
X-Change-ID: 20260723-support-am-800480n3tzqw-00h-7aa686bb8966
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784824328; l=706;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=3GsCtopjO+bT5HdhUJ/GppIlZFQfqMz+16aoNJV+tFA=;
 b=/SzAMGo548M1mxkVtyd7zMansXGrN73Nu6oxSm3eBrfAHO0DdKLxHpZ8L65I4uSahSJJpcrrh
 hPYCcs4dpYMDnB73y5lio91NSjE/x4L+R7lo+ybkrPDesz4CxLoJ4J7
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
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

Hi,

This series add the support for the Ampire AM-800480N3TZQW-00H 5" WVGA
TFT LCD panel.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Paul Louvel (2):
      dt-bindings: display: simple: Add Ampire AM-800480N3TZQW-00H
      drm/panel: simple: Add Ampire AM-800480N3TZQW-00H

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260723-support-am-800480n3tzqw-00h-7aa686bb8966

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

