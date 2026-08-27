Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1968BC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1C910EFC9;
	Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCkI4dbg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C4510EFC9
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80992600D4;
 Thu, 27 Aug 2026 20:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE811F000E9;
 Thu, 27 Aug 2026 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862797;
 bh=hXeCrlr2H2UZCuLEvvGGoMqVWRnxMZcI2iWHVfhvG3k=;
 h=From:Subject:Date:To:Cc;
 b=PCkI4dbgyKdkB4OV5KuL8wg7G11MgCfPxQHpr72rgWdnBfDwiLkxYtcu3rar3QMY2
 4rfszF2eD2ukLUDQbO8EtZZqvJRyqi/anmwCGpIV2HGGgnAj8SQIb96ball0wDaPbg
 CnZ9fyPA3GOH7SNC05Wtee8TnYYwFlrruTwjJHrIIIJoTHHH3R6QbVaJEygsJor8lt
 AOzbnu9FVjTMpnvC+AE/pbZ70esfsKamc5hEizOcIFATYN2VzYKyh+7t+TASj2Ba1d
 YJPApV9gXic5Fr4YcI+ZR/rasbvpKAkXRBhFHnKiTnaGIFzstRbRhmYI7sTrRZdBA7
 gHJJrqG7eSclw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 00/11] accel: ethosu: Another batch of fixes
Date: Thu, 27 Aug 2026 15:32:59 -0500
Message-Id: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNz3dSSjPziUt20zIrUYt3UVFMLYwuzVEsDAwMloJaColSwBFBHdCy
 EX1yalJWaXAIyQ6m2FgB+EhHQcAAAAA==
X-Change-ID: 20260827-ethosu-fixes-ee58386e9000
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

This is another series of fixes to the ethosu driver. It's mostly probe 
error paths and cmd stream validation fixes. It's a mixture of 
AI reported issues, different solutions to other posted issues and 
fixes[1] and my own fixes.

The series adds rejecting OFM tranpose in cmd stream, but then the last 
patch adds support for it. I did this so the rejection can be 
backported, but maybe supporting OFM transpose is small enough that it 
should just be backported too?

Rob

[1] https://lore.kernel.org/all/20260717061145.1478139-1-zhaoguohan@kylinos.cn

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (11):
      accel: ethosu: Fix ethosu_job_open() return value
      accel: ethosu: Drop IRQF_SHARED flag
      accel: ethosu: Ensure cmd stream ends with a stop op
      accel: ethosu: Ensure SRAM size is 0 on mapping failure
      accel: ethosu: Ensure SRAM region size matches job
      accel: ethosu: Fix probe error cleanup
      accel: ethosu: Factor buffer bounds checks
      accel: ethosu: Validate secondary streams
      accel: ethosu: Reject unsupported commands
      accel: ethosu: Validate all feature map tiles
      accel: ethosu: Validate OFM transpose

 drivers/accel/ethosu/ethosu_device.h |   6 +
 drivers/accel/ethosu/ethosu_drv.c    |  17 ++-
 drivers/accel/ethosu/ethosu_gem.c    | 240 ++++++++++++++++++++++++++++++-----
 drivers/accel/ethosu/ethosu_job.c    |  22 ++--
 4 files changed, 233 insertions(+), 52 deletions(-)
---
base-commit: f7e3f4d9f425cf4c5577cd84a096e6e618488083
change-id: 20260827-ethosu-fixes-ee58386e9000

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

