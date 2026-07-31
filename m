Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32880C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E72210E2BD;
	Sat,  1 Aug 2026 07:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=elsta.tech header.i=@elsta.tech header.b="JJg6Nkky";
	dkim-atps=neutral
Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343B510F2C5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 4F9C38D54A4;
 Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Gl-KCpIJaSGg; Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 0C71A8D54A2;
 Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 0C71A8D54A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
 s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785509122;
 bh=a3oX5Y9vckIJeDx5jb2nrEOVorfbmSUri7o0WdMM75w=;
 h=From:Date:Message-Id:MIME-Version:To;
 b=JJg6NkkybOeBnqfHO26lHJnWUZH8urp7FURDaC2453l1GnaJXFT52nbDcLNtJd05t
 PlOt9ommnXMkK9XO7nKcVBO/+BWIBj2l7eAF7lrdDbvs78CwePKIzlrzoEDSrN7bnG
 nnvhoENgRDYH75QJ6ekHzxl/oT3jzfVSBZi4WZ9E0bF92S4cTToeNJN7bVT1boDu15
 EsHDSPz3kOK8QDgJ2DyW6Do89LMr/FrC+MCdL/UclDXv5EhJrTo1eth4QILsEQDpII
 tncEukZ4FaSGmblICW9vva/XnKd5hobJWveWCyJpB0AJF+xgecki34SbTUmYlU8+9A
 bBp+JJ1A95L+Q==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id L_nV2XvecfPl; Fri, 31 Jul 2026 16:45:21 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
 by mail.elsta.tech (Postfix) with ESMTPSA id BA4148D549D;
 Fri, 31 Jul 2026 16:45:21 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Subject: [PATCH v2 0/2] fbdev: ssd1307fb: add SH1107 support
Date: Fri, 31 Jul 2026 16:45:12 +0200
Message-Id: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi0bGoC/yXMQQ5AMBBA0avIrDVpRyiuIhbFYCyQDiIRd1cs3
 +L/C4Q8k0AZXeDpYOFlDsA4gnZ080CKu2BAjZm2iVE9uU3JaIy2Kk8LjRbzFAsDoVg99Xx+t6r
 +LXszUbu9C7jvB4seMQRvAAAA
X-Change-ID: 20260731-feat-sh1107-859027285291
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

This series adds support for the Sino Wealth SH1107 OLED controller
to the ssd1307fb driver.

Patch 1 implements SH1107 support in the ssd1307 driver.
Patch 2 adds the device tree compatible string.

Changes in v2:
- Removed unrelated whitespace cleanups from the driver patch.
- Kept only functional SH1107 changes.

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
---
Jakub Turek (2):
      fbdev: ssd1307fb: add support for Sino Wealth SH1107 controller
      dt-bindings: display: solomon,ssd1307fb: add SH1107 compatible

 .../bindings/display/solomon,ssd1307fb.yaml        | 17 +++++
 drivers/video/fbdev/ssd1307fb.c                    | 87 +++++++++++++++++++---
 2 files changed, 93 insertions(+), 11 deletions(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-feat-sh1107-859027285291

Best regards,
--  
Jakub Turek <jakub.turek@elsta.tech>

