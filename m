Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D1CD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E32110EA46;
	Tue, 12 May 2026 11:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eBGZepLr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A5610EA41
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585864;
 bh=tfPS7Mqg9xifmcDhlQr+7/z07rg8RK9uZs8tqik28yU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=eBGZepLrG7mGhUK6r0Fyf4Z/bENEY955d5jiufqfCVqArEyeWzVkFRniJSK1VGR3j
 5G4SAY/jlSY3QGxu1we5TUtEossuqquv6htpnLUAxEqnZWrN/oRhzPqdvLIl1z0EGf
 oNWY4yCSLn0sxOT6yKyZTNC/o271mnuVkhsqeb1nHH8TdZpXl7iwVnuGUv7SaiNuAI
 OhGvx7kygPKDF6DUoh+WeEehb/Yi0CyDu+yfyNBl5zaOD2EsOwGXSvjzLz/JIp0X57
 PAAxZ+DpssxDKTzxjJBxdIBTgvwnNOmXQ/14TAzU24jtPcCOuxQVkKDBQriOhXl0DE
 7hXFr3eBkIEqA==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0AAEB17E38B5;
 Tue, 12 May 2026 13:37:44 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:35 +0200
Subject: [PATCH v2 05/11] drm/panthor: Make
 panthor_fw_{update,toggle}_reqs() callable from IRQ context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-5-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=2293;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=tfPS7Mqg9xifmcDhlQr+7/z07rg8RK9uZs8tqik28yU=;
 b=TxIi1m30WN4DEsgs/OZPI/K+W8ORFzz0YWVSjZA1Cd9DvPyhh0i+jyXlD1WQGmGEijH+qitL1
 oE62P+zDQxJCVyOuL8WpvCNieDwTEhZqLzsNTYArekomooQHNqecRKY
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

If we want some FW events to be processed in the interrupt path, we need
the helpers manipulating req regs to be IRQ-safe, which implies using
spin_lock_irqsave instead of spinlock. While at it, use guards instead
of plain spin_lock/unlock calls.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_fw.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825..e56b7fe15bb3 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -432,12 +432,11 @@ struct panthor_fw_global_iface {
 #define panthor_fw_toggle_reqs(__iface, __in_reg, __out_reg, __mask) \
 	do { \
 		u32 __cur_val, __new_val, __out_val; \
-		spin_lock(&(__iface)->lock); \
+		guard(spinlock_irqsave)(&(__iface)->lock); \
 		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
 		__out_val = READ_ONCE((__iface)->output->__out_reg); \
 		__new_val = ((__out_val ^ (__mask)) & (__mask)) | (__cur_val & ~(__mask)); \
 		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
-		spin_unlock(&(__iface)->lock); \
 	} while (0)
 
 /**
@@ -458,21 +457,19 @@ struct panthor_fw_global_iface {
 #define panthor_fw_update_reqs(__iface, __in_reg, __val, __mask) \
 	do { \
 		u32 __cur_val, __new_val; \
-		spin_lock(&(__iface)->lock); \
+		guard(spinlock_irqsave)(&(__iface)->lock); \
 		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
 		__new_val = (__cur_val & ~(__mask)) | ((__val) & (__mask)); \
 		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
-		spin_unlock(&(__iface)->lock); \
 	} while (0)
 
 #define panthor_fw_update_reqs64(__iface, __in_reg, __val, __mask) \
 	do { \
 		u64 __cur_val, __new_val; \
-		spin_lock(&(__iface)->lock); \
+		guard(spinlock_irqsave)(&(__iface)->lock); \
 		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
 		__new_val = (__cur_val & ~(__mask)) | ((__val) & (__mask)); \
 		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
-		spin_unlock(&(__iface)->lock); \
 	} while (0)
 
 struct panthor_fw_global_iface *

-- 
2.54.0

