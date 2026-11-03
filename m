Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5583606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACWgK+DF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CEE10F7D7;
	Tue,  3 Nov 2026 19:28:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDC610F7C4;
 Tue,  3 Nov 2026 19:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 434F560609;
 Tue,  3 Nov 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793734095;
 b=QBhgSCI2Hq0VS+B8AFy+Bk+X//F2ewkbMVaAIKdtvZ9VlKbLx/PGl9n+4le4xvrWNUyE
 FXsdeykC0nhJntfPpwi2+yKMtS/qVqOUTaMKWKOaSfxsMeOZP6XMYY8jxdisI9Upm44WV
 Sz488hDFOu060phiHRqRhAso75X0IZSZpFF1x+TBVr2cwJbESUv6SL+rO1tQN+AJq73TQ
 io7aYFwYONhkJcce5heSn99wTNkisF6IJjFn0F+msGpJIE/n+TggPI5Y/z0s4SFmsRwIv
 YmILhsfDNeqr7hbKvBsjTKg3wUEeJtRfGXrlSWuVONvizF+DQks4y4vjC2PYOUooOEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793734095;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=WJac30W+Zgm/eZyctil4AFCBpQAeJTdsn2sd26VSGS0=;
 b=RR7QvcC7C7niCqDKfaaGXmopfIwX6DkO4xIvCTFM8vMlB5lCZdG0+UFK8twhd5hAc+88
 FjY/p3JNsoCu2T94AMCyhVIv8IDmrOMAAMCywgEYjOPB3oaCFGG6KC3x8BTiK0O5x0TUI
 bjo8iyptpsih2Y+VrU/hOs6jhC67UObEyvlwUZDnkr7N9mRMA+6EDynkDhstj1iGHtSR1
 Cq2lgC+sOJKfNIGd6ZaBirFid8xe1FEdHsv02BRBQyGjcJztX4X3uBWnUEkVtdwjgF0vU
 CAIIExFi/y2tmnrE1Jedn2kZoWbsxl7uxY8SsmiFpIhm/UIcwhwqfjUpYg9i/nyR8pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 742611F00A16;
 Tue,  3 Nov 2026 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793734094;
 bh=WJac30W+Zgm/eZyctil4AFCBpQAeJTdsn2sd26VSGS0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ACWgK+DFSI43P6bcfP9WiqEDfT7y6siosWuGg0YIcQ+iNY6gAE7vb5LHKyfaz8Fxs
 fSNagBY+jmB8BhyWafVzntwzP3W7mox6CGbNKOpvNmoF3wduHP1jtzW3akt5c2jGKs
 Xu3yUtE2B0QTs60QfJq0J+HJFddW1Br7ij6laNSL8T58mkdtEQI0Md9OkKEWBUBRl5
 T6mOP3KLpWx13D1VBufmTnkeIPGrLEE1DGGdL2gbsKRr/KnLDcDbfNdCKhFHl8CS7j
 uqtoKNZ8kYHLybhIRpptnSaNfjaSzRonD50PcA8bDl5TWiYK1G8sn0XtRKmK0oQnj/
 y15xIytSCdw/g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1390946AD3;
 Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
From: "David R. Hedges via B4 Relay"
 <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 13:28:05 -0600
Subject: [PATCH 5/5] drm/nouveau: don't let an IRQ_HPD hide a plug or
 unplug event
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nouveau-dp-fixes-v1-5-892f4bd357cd@thelittleman.net>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 "David R. Hedges" <linuxdev844@thelittleman.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793734092; l=1736;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=tP85nBIrptt737aDB86qPgSupi2I6nalDmVpTjCbdVo=;
 b=XrppRfVCwBqBGeUwfkz8GLy3LuTrae24FAi6dAaSGrRH9AN/7b/thlU74Ss42oEYKgGLOI7M+
 be1rwk3vWEvCfRM2HKXHOwK6PvMEO1zHF6IZ3apGnLWEA6nS05gtEAi
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: linuxdev844@thelittleman.net
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "David R. Hedges" <linuxdev844@thelittleman.net>

nouveau_dp_irq() passes an IRQ_HPD to the HPD worker as
NVIF_CONN_EVENT_V0_IRQ, adding NVIF_CONN_EVENT_V0_PLUG when the sink
count has changed, or NVIF_CONN_EVENT_V0_UNPLUG when servicing an MST
hub fails.  A real plug or unplug can also be pending in the same bits
by the time the worker runs.  nouveau_display_hpd_work() skips
connector detection for anything with the IRQ bit set, though, as long
as nouveau_dp_link_check() reports the link as fine, which it does
whenever there's no trained link to look at, so those plug and unplug
events are dropped.

Only take the link check shortcut for an IRQ_HPD on its own.

Fixes: 016dacb60e6d ("drm/nouveau/kms: pass event mask to hpd handler")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index d71dcfc6ee66..4398cf0fc541 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -462,7 +462,12 @@ nouveau_display_hpd_work(struct work_struct *work)
 			    !!(bits & NVIF_CONN_EVENT_V0_UNPLUG),
 			    !!(bits & NVIF_CONN_EVENT_V0_IRQ));
 
-		if (bits & NVIF_CONN_EVENT_V0_IRQ) {
+		/* A plug or unplug event pending alongside the IRQ, such as a
+		 * sink count change reported by nouveau_dp_irq(), still needs
+		 * connector detection.
+		 */
+		if ((bits & NVIF_CONN_EVENT_V0_IRQ) &&
+		    !(bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG))) {
 			if (nouveau_dp_link_check(nv_connector))
 				continue;
 		}

-- 
2.55.0


