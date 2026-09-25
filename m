Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4AC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C28910E83C;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=solidxs.se header.i=@solidxs.se header.b="JSmaowXt";
	dkim-atps=neutral
X-Greylist: delayed 348 seconds by postgrey-1.36 at gabe;
 Fri, 25 Sep 2026 12:01:08 UTC
Received: from mail.solidxs.nl (mail.solidxs.nl [135.181.160.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56E310EA09;
 Fri, 25 Sep 2026 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2001:2042:bc22:2b00:665f:5046:e84a:28d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.solidxs.nl (Postfix) with ESMTPSA id 5A7692DA0053;
 Fri, 25 Sep 2026 13:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidxs.se; s=2026a;
 t=1790337316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mPFXHOweYUJn5VvQHi3d8rLLCyBG+oOdevRP/Ld5GzU=;
 b=JSmaowXt/5pxfwqPdHN9sOD6PiU53SFgjBK97jRl9fR+34RUyW9/UAGQO4mvE6OeWy4qWM
 LKpp6NYTXJeiyn24jgdHTmnetQzlTwObYIb9hK3YHkpYexhKx/U++VAGw6n0v7pOz5jypy
 oWO2ZFuZDGRXl1tkQc5Yz/Da22Ve94Uctr8ZTz1qXzY0wJ7wJIsQpnP9n8beQanGbkBMvi
 axOhITogzJddTFZ+ef01veUAqTD1HUGkw7f81/iFarhmhCWLM1yqGdoh3tgmzPExlXqHXM
 oSwcPJ5bXHk6vLAngTPUnhmbG4JwtsrSosMzawHSP5eO22rBZQgxtxAC9mj26A==
From: Marcel Hamer <marcel@solidxs.se>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vinod Govindapillai <vinod.govindapillai@intel.com>
Cc: Marcel Hamer <marcel@solidxs.se>, stable@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/irq: crtc guard inside interrupt handlers
Date: Fri, 25 Sep 2026 13:55:10 +0200
Message-ID: <20260925115511.1655213-1-marcel@solidxs.se>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Interrupts are enabled before the crtc datastructures are initialized.
As intel_crtc_for_pipe() is called inside interrupt handlers and can
return a NULL value, this can in rare cases lead to the following NULL
pointer dereference and panic:

RIP: 0010:handle_plane_fault+0x19/0xc0 [i915]
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f
1f 44 00 00 55 48 89 e5 41 55 41 54 49 89 fc 53 48 83 ec 18 <48> 8b 1f
65 4c 8b 2d 24 90 31 ef 4c 89 6d e0 41 89 f5 48 85 db 74
RSP:
0018:ffff92b180003e50 EFLAGS: 00010086
RAX: ffffffffc0911fc0 RBX: ffffffffc06e0b90 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff92b180003e80 R08: 0000000000000005 R09: 000000010517d5f6
R10: 0000008000000041 R11: 000000010517d5f6 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f72f5b72780(0000) GS:ffff8bbdcbfe9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000102f2c000 CR4: 00000000003506f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x2c800000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
Call Trace:
 <IRQ>
 intel_pipe_fault_irq_handler+0x42/0xc0 [i915]
 gen8_de_irq_handler+0x1ed/0xdf0 [i915]
 gen8_irq_handler+0xb5/0xd0 [i915]
 __handle_irq_event_percpu+0x6e/0x230
 handle_irq_event+0x3a/0x90
 handle_edge_irq+0xd1/0x1a0
 __common_interrupt+0x48/0xe0
 ? generic_smp_call_function_single_interrupt+0x17/0x20
 common_interrupt+0x84/0xa0

Fixes: f13011a79999 ("drm/i915: Pimp display fault reporting")
Fixes: 138d2bda4eaf ("drm/i915/display: pass display to intel_crtc_for_pipe()")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Marcel Hamer <marcel@solidxs.se>
---
 drivers/gpu/drm/i915/display/intel_display_irq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index a59b75830bd1..4ffc8789c9f3 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -131,6 +131,9 @@ static void intel_pipe_fault_irq_handler(struct intel_display *display,
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
 	const struct pipe_fault_handler *handler;
 
+	if (!crtc)
+		return;
+
 	for (handler = handlers; handler && handler->fault; handler++) {
 		if ((fault_errors & handler->fault) == 0)
 			continue;
@@ -148,7 +151,8 @@ intel_handle_vblank(struct intel_display *display, enum pipe pipe)
 {
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
 
-	drm_crtc_handle_vblank(&crtc->base);
+	if (crtc)
+		drm_crtc_handle_vblank(&crtc->base);
 }
 
 /**
@@ -425,9 +429,14 @@ static void display_pipe_crc_irq_handler(struct intel_display *display,
 					 u32 crc4)
 {
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
-	struct intel_pipe_crc *pipe_crc = &crtc->pipe_crc;
+	struct intel_pipe_crc *pipe_crc;
 	u32 crcs[5] = { crc0, crc1, crc2, crc3, crc4 };
 
+	if (!crtc)
+		return;
+
+	pipe_crc = &crtc->pipe_crc;
+
 	trace_intel_pipe_crc(crtc, crcs);
 
 	spin_lock(&pipe_crc->lock);
@@ -465,6 +474,9 @@ static void flip_done_handler(struct intel_display *display,
 {
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
 
+	if (!crtc)
+		return;
+
 	spin_lock(&display->drm->event_lock);
 
 	if (crtc->flip_done_event) {

base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd
-- 
2.47.3

