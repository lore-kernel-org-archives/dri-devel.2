Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D4606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWtGxFsT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ED91125F8;
	Thu, 26 Nov 2026 16:53:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A141125F3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:53:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5611160CBE;
 Thu, 26 Nov 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795712012;
 b=YauSiYwzE15/E9wOmJQO+ntMgltA3lCdomeNEVsypI8JBx6yZtEvLDnWExJ2EGvSLcT3
 aPUIZefD0QF3DoAOBDEp3A/JJGnIbN/wltw7ZLAW0rWHrHRjFXZkHwN+NjwFWwnaOvzTn
 QxUImCqwIXsY5eoGy8rfSt4dyPmZxaQ0HPEae3bArCZpXadAEiklEhLuFGwNH+jCFYxPa
 4paZQn5FbK4a9Au/+Iz5msQbHmzxM6PvpP/Z1Sei7w8vnpIGpUH0FNAHONfxskPypM2yC
 jZINuTSRY6J1oYDZ3r0BMp8K1tNBWZwNTFZsw7E6oSFnIl1DKfyncrRK0p3S1Fus2uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795712012;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=YYeo7BmF8pBBKhpoVelsSbR8AsEMtm6Bi1fepPpoRO8=;
 b=Bx0N+9M6bQEuEg+xiPx/jyuW2mbpyy8skR+p80C0ph6ekwtjdCaG8inIf0ESkjTXyH4m
 cckLoymExfN5yTS4Yv7RyR9IOV70kLs07CDYZoS9oH3IeWxaZYSHb+EQkeOw646lkfq2n
 tuAyG7HZDGNZ40Ohi/ddEpIJO/i2FkbXb6NciKhPyuvaEpfgy/7J9JCn82F+/yz64Q3+w
 55CuvvKYdaaQyI02GH3tgByVQfqFFDY87MxkYz9mJ4DQGz5IL/QLFAE0JcK+UJL5M8XI+
 sDI1AqmEUvg/y4029i8FcJLtpK0J6FH7itbqzetKr71c7iu/EXNfgxaTV5fpPuHZC8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 274C21F000D4;
 Thu, 26 Nov 2026 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712012;
 bh=YYeo7BmF8pBBKhpoVelsSbR8AsEMtm6Bi1fepPpoRO8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=SWtGxFsTbiOu6s/lYh3Rmi5iiLXqvX0li9U1Knxq8Ger/D58chDxYetvBlcrL0xQC
 2PP/zoOYhdwHTgCMqhO9R5Pr89egq40tAe7Q1c3XZIiuSsNg9hKz5v1QLbqQxovnDS
 +/7RMfGzEE0GHgnqp/R9hMQ7htTUVhOOimE6zt6CMXBB+JesO+tL9kHhxkmlj6Ttuz
 sHO1KKVo8Qn+vWOVKgM0SdT873cJc4igGP0XSPj2F/eiLaawKpxb8cZIS98McNwVkb
 De02jX8YhS4XTb7irweuY16cs/10s5OxwdCzitecZrCOlteOCNug7RcPWSWmP7h6zq
 fzZk9dbX013Yw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id AB1E84D73B;
 Thu, 26 Nov 2026 16:53:19 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 17:53:15 +0100
Subject: [PATCH 1/3] drm/panic: Check QR alignment centers one axis at a time
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-perf-drm-panic-qr-v1-1-51856937dc4d@gmail.com>
References: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
In-Reply-To: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795711998; l=1856;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=s2q8rdTFeCLN5bHoYDEz1EAk1bfn2gf/0qI/0v1epNE=;
 b=ZfZ7KBdVFd7SeRGeNdUGHSQKNc2jubIGoqCU/aVY3tNkQJpKdCNopEjtU6bmADCEHL6TVamaZ
 4ielgeyFJfxBPfkTgdA2+BeQYzZMT3X3IAypVkonb7abK1vIyyXfo6a
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
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
Reply-To: peder.bergan@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peder Bergan <peder.bergan@gmail.com>

is_alignment() scans pairs of alignment centers each time it tests
whether a module is reserved. At version 40 there are seven centers
per axis, so a lookup can visit 49 pairs.

Each center covers a five-module span, and adjacent centers are at
least 12 modules apart. Find the unique matching center on each axis
and apply the existing finder-pattern exclusion to that pair. The
lookup now needs at most 14 center tests.

Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
 drivers/gpu/drm/drm_panic_helper_qr.rs | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_helper_qr.rs b/drivers/gpu/drm/drm_panic_helper_qr.rs
index 4941731fb60fa..c6ed395c05bd2 100644
--- a/drivers/gpu/drm/drm_panic_helper_qr.rs
+++ b/drivers/gpu/drm/drm_panic_helper_qr.rs
@@ -746,17 +746,14 @@ fn draw_alignments(&mut self) {
 
     fn is_alignment(&self, x: u8, y: u8) -> bool {
         let positions = self.version.alignment_pattern();
-        for &ax in positions.iter() {
-            for &ay in positions.iter() {
-                if self.is_finder(ax, ay) {
-                    continue;
-                }
-                if x >= ax - 2 && x <= ax + 2 && y >= ay - 2 && y <= ay + 2 {
-                    return true;
-                }
-            }
-        }
-        false
+        // Centers are at least 12 modules apart, so their five-module spans are disjoint.
+        let Some(&ax) = positions.iter().find(|&&center| x.abs_diff(center) <= 2) else {
+            return false;
+        };
+        let Some(&ay) = positions.iter().find(|&&center| y.abs_diff(center) <= 2) else {
+            return false;
+        };
+        !self.is_finder(ax, ay)
     }
 
     // Timing pattern: 2 dotted line between the finder patterns.

-- 
2.56.1


