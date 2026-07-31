Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34130C54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F7A10E2B4;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=elsta.tech header.i=@elsta.tech header.b="rULPH7zn";
	dkim-atps=neutral
Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D523410F215
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 6ECE28D53AD;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id xeUqlHFTY-a3; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 361278D53B1;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 361278D53B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
 s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785494793;
 bh=ucDX/yN/bgjQ8eR0W+6x3z0eH/umeWeTO6jHUIXSMlg=;
 h=From:Date:Message-Id:MIME-Version:To;
 b=rULPH7znXxtYdUGCtyyXimK08iELqDDg2QzjwGCjf6sKnmGmTgmCETypxrzBSHudr
 EcC7Y9VNZt5DRh1sl5bZ+SBA6SNHQTOUscOFrooxdKT7Y7CjOAClYD0VXSBZugwDtU
 Yl5aiYGhFpLcyiWxdd8cfWTuYFbz/oA0tpTqN9ZzfT8A0dwtwy4f5GhCUyhShmacqI
 xe8zVd6s2mxpF48b6Ex4YEu4Jtt4yL2jmfPdpCF3bKaZWhc5pdQzREids5pd0gIEzn
 NP5tcN5rtejCxa+EzVoiBqf0rR+zOz7qvLb/nq1nupp4TT0FpyJsBI1HOAO06sFJ7d
 OSRSAzXg2YgOw==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id vZUgiRqc2BKT; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
 by mail.elsta.tech (Postfix) with ESMTPSA id EAD058D53AD;
 Fri, 31 Jul 2026 12:46:32 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Subject: [PATCH 0/2] fbdev: ssd1307fb: add SH1107 support
Date: Fri, 31 Jul 2026 12:46:15 +0200
Message-Id: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPd8bGoC/yXMQQ5AMBBA0avIrDVpCcVVxIJ2ylggnRKJuLti+
 Rb/X8DoCRma5AKPBzGtS4RKEzBTv4woyEZDJrNS6lwJh30QPCkltTC6dNpWts5tAbHYPDo6v1v
 b/eZ9mNGEdwH3/QCePyXvbwAAAA==
X-Change-ID: 20260731-feat-sh1107-c76f7d8d93d5
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
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

Tested on:
- imx7d-colibri

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
---
Jakub Turek (2):
      fbdev: ssd1307fb: add support for Sino Wealth SH1107 controller
      dt-bindings: display: solomon,ssd1307fb: add SH1107 compatible

 .../bindings/display/solomon,ssd1307fb.yaml        |  17 ++
 drivers/video/fbdev/ssd1307fb.c                    | 234 ++++++++++++++-------
 2 files changed, 172 insertions(+), 79 deletions(-)
---
base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
change-id: 20260731-feat-sh1107-c76f7d8d93d5

Best regards,
--  
Jakub Turek <jakub.turek@elsta.tech>

