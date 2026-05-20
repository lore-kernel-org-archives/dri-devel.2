Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A703CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647CA10F0FF;
	Wed, 20 May 2026 16:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4nioBH4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7597610F0FF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:58:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C7C460129;
 Wed, 20 May 2026 16:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F01F00894;
 Wed, 20 May 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779296292;
 bh=PYgD9+ngn1y3m8y9QJoLnE+DdTg/ScDaLJtJEVZkodM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l4nioBH4mvF7o7wgrzBtL1MqTAM4s9OpSnjSIdqqQrYGF3UD5/PXCvwGFElmz3Iz4
 MNThZMdw6m4LuuGlS1iyfSK1w6SRmjwGB4ItZ4KZodFMbzcwUM05hpAx/d3b/00Loj
 cWiuq3pzzuMZ0tKa+qVpaA9wx2oulDGzGGBfi7VY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, kernel test robot <lkp@intel.com>,
 "Daniel Thompson (RISCstar)" <danielt@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, Lee Jones <lee@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0745/1146] sh: Include <linux/io.h> in dac.h
Date: Wed, 20 May 2026 18:16:35 +0200
Message-ID: <20260520162205.067126444@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 57b3ec396dd898aadc073bb16f3d05ee64b2c8af ]

Include <linux/io.h> to avoid depending on <linux/backlight.h>
for including it. Declares __raw_readb() and __raw_writeb().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-lkp@intel.com/
Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header file")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/include/cpu-sh3/cpu/dac.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-sh3/cpu/dac.h
index fd02331608a8d..323ec8570bcd1 100644
--- a/arch/sh/include/cpu-sh3/cpu/dac.h
+++ b/arch/sh/include/cpu-sh3/cpu/dac.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_CPU_SH3_DAC_H
 #define __ASM_CPU_SH3_DAC_H
 
+#include <linux/io.h>
+
 /*
  * Copyright (C) 2003  Andriy Skulysh
  */
-- 
2.53.0



