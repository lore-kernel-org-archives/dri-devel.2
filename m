Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C918C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CBB10F062;
	Thu, 23 Jul 2026 10:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="itEho+g4";
	dkim-atps=neutral
X-Greylist: delayed 410 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 10:09:03 UTC
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE2D10F062
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:09:03 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784800927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fKO3/sNuYCNDhBBpHqdh/zQRxpb4D5xb2jR8UCdl4Us=;
 b=itEho+g4YiGRRWbOoblyluFotUHWbYIuG9mMUWv78bZkvZDzInxTiIUIxFHnZaNGWnZcAl
 xwXrZp21yT7N2hgk/nwKvjOgeHCYNJ1tovk6Pv2Co2CSE4zyjiwr+sOL7FFGmGb+tRo4p2
 zO/uyOdhSaMQNogifKjMmoImedB6cQ8=
From: Aditya Garg <aditya.garg@linux.dev>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>, Aditya Garg <gargaditya08@proton.me>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS, mailmap: use Aditya Garg's linux.dev account
Date: Thu, 23 Jul 2026 10:01:36 +0000
Message-ID: <20260723100136.14467-1-aditya.garg@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Aditya Garg <gargaditya08@live.com>

Due to non standard IMAP and SMTP protocols by Proton Mail, the account
was giving trouble. Since my linux.dev account has been approved, all
communication related to Linux development shall now be done there.

Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 501d858cb..baea6ba4d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -19,7 +19,8 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
 Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
-Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
+Aditya Garg <aditya.garg@linux.dev> <gargaditya08@live.com>
+Aditya Garg <aditya.garg@linux.dev> <gargaditya08@proton.me>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Adrian Bunk <bunk@stusta.de>
 Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab873685..f32e63428 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7970,7 +7970,7 @@ F:	drivers/gpu/drm/sun4i/sun8i*
 
 DRM DRIVER FOR APPLE TOUCH BARS
 M:	Aun-Ali Zaidi <admin@kodeit.net>
-M:	Aditya Garg <gargaditya08@proton.me>
+M:	Aditya Garg <aditya.garg@linux.dev>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.53.0

