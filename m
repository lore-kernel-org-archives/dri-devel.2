Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FC606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlsysScl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2E810E323;
	Sun, 22 Nov 2026 05:12:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E2410E323
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEA2F60E18;
 Sun, 22 Nov 2026 05:12:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795324353;
 b=yrYSTyw8c5qja5A5KmFiKX3o79WaQ8Q5Yil42BGV9gr4C7MTSK8Y6Az/ZEkyJ9tGrn4r
 EQPlXN1oJ2KXbCzvS3fuCpxZTa5cJb4kic/QMJNfkPjceS4/hgkePu7c5nr4nfhFi/0Ji
 UFUdHz6wislBuI9uoSg0g8jtlFlvkaHWvgxRSfdT50dfqETexU1RjgxSVcVtWNLVH5Grn
 2p+/vR0pIBhqKBVLF/K/EBWun3dJjsHKt1AVoFTKuhtbc4rHM4GGB0wXZ5uOjl6TlvOKV
 nEsjkJE/cBr5y8rYbJG0acQlYJGQhGe2N2kYCe9pyPv2qgGfL5+7YlqVOyqDf7TQa0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795324353;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=BqA76MtHP34dwJ/wyvQ6JwjfXJ/sPAsaOjMCcNPFGOo=;
 b=FhE3Dc0f0eB1GGX36BdbBF1CTzKl50FzC46CK6fHgo+2mDyMBs95I9K6cy+4atI9l9lr
 ErGTrf5iXLCjuzTY3nvw92+EoN0AZzd+vlnO4Gb2zL8aVAL0qeUy8oplTB8wrrDnssLJ4
 yhP9TYPCpz7hQRh9ZxRunzToMsgnU5fQYXgZhtIuUJYNmjIrncw6KR6bMD52nvDN2w/L6
 XrBR7MM9bf91DqgoAfQATcz6uqr6LsEk+AZsKoOcp37mKcMJ2FcrLK/t+8FymAvZpq856
 3pyA0XQ2xbJCh7Ji/mG0hz5eIX5g9cZBK2WU9FM86B4OjzKn8G02AjpRzyzpqF6reHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CEC741F000C4;
 Sun, 22 Nov 2026 05:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795324353;
 bh=BqA76MtHP34dwJ/wyvQ6JwjfXJ/sPAsaOjMCcNPFGOo=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=AlsysSclytREnuGuagVwrbwtIRSszCb1g4mrgHXhOTIgUVSsw/HGqnj5Y6/kSl3mU
 mmBekc1pcC9rldA6b/tbBd5047ljMY4vzSfzimp56F8g1VsQBuHpMyFmMQ9QxJ1Add
 vMakFUAw2gUQNtm2F/ehPEFpYhg0rEO0WJun7R/riwMGCmtSxFzr/fIWvlynAes5l8
 bgH3e0CaIGdjn8LsuTwTBSRV0Pm4UYrrUCcwKCuEbbkB506bfQFh4cGEK1nBabYHFv
 FCnvyvpBLzaFK8QjUHue7QIcpVhBAmSbW+OrEwv1iHmisXgiQkB4cvC380ieOXQKuP
 ZxlZAgC78P8zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5F7D34BEEE;
 Sun, 22 Nov 2026 05:12:32 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:12:29 +0000
Subject: [PATCH] drm/tegra: dc: Drop the bandwidth of planes detached along
 with the CRTC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-tegra-dc-bw-detached-planes-v1-1-e81ecc31c031@enser.io>
X-B4-Tracking: v=1; b=H4sIALx5AmsC/yXNwQ7CIBAE0F9p9uxqoWhNf8V4WJa1xRhsAKtJ0
 38X9Pgmk5kVkkQvCYZmhSiLT/4ZCtSuAZ4ojILeFYNu9UkprdEazDJGQsdo3+gkE0/icH5QkIT
 HvqMzdca1mqGMzFFu/vM7uFz/Ti97F851tTYsJUEbKfBUo8rD0u8NRtawbV+EJH4+ogAAAA==
X-Change-ID: 20261122-b4-tegra-dc-bw-detached-planes-573a8a34d02c
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324350; l=2558;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=tnytgEmbcAbEg+Rxnj8ubadIh+RmzXaDqjz9Brhzka0=;
 b=/UeI9zggcODVbkY6Vw7Azm48TE1Cc4+VDfGlkuVPX7wOhPx4Z1hZJ1xjYzeGkOo96s5VDdXBc
 dbkbEXvAKRdD2btXiK55aFoXVgQ+AYA8WWcMzilaByCSGqEkloxywzn
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
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
Reply-To: emcp@enser.io
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: EMCP333 <emcp@enser.io>

tegra_crtc_update_memory_bandwidth() removes a CRTC's display bandwidth
from the interconnect when the CRTC goes inactive, but only for the
planes in the new state's plane_mask. That covers the kernel's own DPMS,
which keeps the planes attached. A compositor may instead deactivate the
CRTC and detach its planes in the same commit, as wlroots does when it
powers an output off. The new mask is then empty, the loop zeroes
nothing, and the early return skips the per-plane update that would
have.

Seen on a Tegra Note 7 (Tegra114) under sway with the output powered
off: the atomic state shows crtc-0 active=0 and plane_mask=0, yet dc0
still requests 245760 kB/s average and 274708 kB/s peak from the memory
controller. That request alone holds the EMC at 204 MHz while nothing is
scanned out.

Walk the planes that were attached before the commit instead. For the
kernel's DPMS the old mask equals the new one, so nothing changes there.

Tested on that board under sway: with the output powered off, dc0's
request drops to 0/0, and powering it back on restores 245760/274708,
over three cycles.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Fixes: 04d5d5df9df7 ("drm/tegra: dc: Support memory bandwidth management")
Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/gpu/drm/tegra/dc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c9df14544c..5a52535192 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2127,9 +2127,13 @@ tegra_crtc_update_memory_bandwidth(struct drm_crtc *crtc,
 		/*
 		 * When CRTC is disabled on DPMS, the state of attached planes
 		 * is kept unchanged. Hence we need to enforce removal of the
-		 * bandwidths from the ICC paths.
+		 * bandwidths from the ICC paths. A compositor may also detach
+		 * the planes in the same commit (wlroots does), and then they
+		 * are gone from the new state's plane_mask, so walk the planes
+		 * that were attached before it.
 		 */
-		drm_atomic_crtc_for_each_plane(plane, crtc) {
+		drm_for_each_plane_mask(plane, crtc->dev,
+					old_crtc_state->plane_mask) {
 			tegra = to_tegra_plane(plane);
 
 			icc_set_bw(tegra->icc_mem, 0, 0);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-tegra-dc-bw-detached-planes-573a8a34d02c

Best regards,
--  
EMCP333 <emcp@enser.io>


