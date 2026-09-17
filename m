Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79395C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33CD10F1B4;
	Fri, 18 Sep 2026 07:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DPLa8jGx";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA8610ED5D;
 Thu, 17 Sep 2026 10:42:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hlslt2LtTzKnRT;
 Thu, 17 Sep 2026 12:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789641770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XZlvotagOvflyuk537rr2+uKdsrQpekdHo/pQQ1mK5w=;
 b=DPLa8jGxG4sezSnxU2+XQYs4Wgsw8TPb3BvBG/Mn0N2E0iTJXRKM+zrqg7MVU9DURCjTj8
 h2uVVIPaX/SVGsRb6MNyuEGchQBp4+j2gLis3zSFelVaKWC1UndJB4EE6GiQJ2wROPz5MM
 p+CwHJVdzF1SXTi5i1pOrLw8rc5MbD4vzdmfwz3AQ4sG0OBy3Ig29CDUT6iwsllUTe5L7B
 rIzwt/d+nbS+pU4GWqWre+gQ40hMJ+TQbEAj7EBiHhR04Sm0ASJGofpc5X7ecmDmhaqbrk
 pypyEbwtiAWpfkEFFNiIBWl5jACtkZYJh9dcygJiFvvLzasQtcQCiX3cW1G89w==
From: Simon Polack <spolack+git@mailbox.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix stale replay_events after mod_power
 stream removal
Date: Thu, 17 Sep 2026 12:42:34 +0200
Message-ID: <20260917104234.18858-1-spolack+git@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uuheci4qwo3eshwuxs89sousmrgsghxi
X-MBO-RS-ID: 254495ab169330d7d59
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

[Why]
mod_power_remove_stream() shifts the remaining power_entity slots down
but does not move replay_events, and mod_power_add_stream() does not
initialize it. replay_events therefore stay bound to the map slot
instead of the stream.

When several streams are disabled in one atomic commit,
amdgpu_dm_mod_power_update_streams() removes them one after another.
The eDP stream can then be looked up in a slot whose stale
replay_events already have replay_event_hw_programming set, so
amdgpu_dm_replay_set_event() returns early ("already in desired state")
without calling mod_power_set_replay_event(). Replay is not disabled
before the eDP panel is powered off. After DPMS on, the sink reports
neither replay state nor frame lock (DPCD 0x378 = 0x00, no error bits),
so the HPD IRQ recovery does not trigger and the panel stays black
until a full modeset.

Seen with an eDP panel using FreeSync Replay plus two DP-MST displays:
DPMS off/on of all outputs leaves eDP black, while DPMS of eDP alone
works. Doing an eDP-only DPMS first makes the next all-output DPMS
fail reliably.

[How]
Shift replay_events together with the PSR cached fields in
mod_power_remove_stream() and initialize it to replay_event_vsync in
mod_power_add_stream(), matching the psr_event_vsync initial value used
for PSR (both vsync events are driven together by
amdgpu_dm_crtc_set_static_screen_optimze()).

Tested on 7.3.0-rc3 (238650ef6c7c): the reproducer above now recovers
reliably, and Replay still engages when the screen is idle.

The issue was debugged with help from an AI assistant (Claude), which
analysed ftrace/kprobe traces and the driver source, pointed to the
missing replay_events handling and suggested this change. I collected
the traces and built and tested the fix on the affected hardware.

Fixes: 4cef2ac4c795 ("drm/amd/display: Introduce power module on Linux")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Simon Polack <spolack+git@mailbox.org>
---
Based on v7.3-rc3 (238650ef6c7c), where it was tested; also applies to
amd-staging-drm-next.

This does not address why stale replay_events can reach the eDP slot
with replay_event_hw_programming already set in the first place; with
per-stream bookkeeping that state is consistent again. Traces
(kprobes/fprobes on the Replay path, eDP-only vs. all-output DPMS) and
DPCD dumps are available on request.

 drivers/gpu/drm/amd/display/modules/power/power.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 2f9690e65ca9..d900be8cb5fc 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -328,6 +328,7 @@ bool mod_power_add_stream(struct mod_power *mod_power,
 		core_power->map[core_power->num_entities].psr_enabled = 0;
 		core_power->map[core_power->num_entities].psr_events = psr_event_vsync;
 		core_power->map[core_power->num_entities].psr_power_opt = 0;
+		core_power->map[core_power->num_entities].replay_events = replay_event_vsync;
 		core_power->num_entities++;
 		return true;
 	}
@@ -387,6 +388,7 @@ bool mod_power_remove_stream(struct mod_power *mod_power,
 		core_power->map[i].psr_enabled = core_power->map[i + 1].psr_enabled;
 		core_power->map[i].psr_events = core_power->map[i + 1].psr_events;
 		core_power->map[i].psr_power_opt = core_power->map[i + 1].psr_power_opt;
+		core_power->map[i].replay_events = core_power->map[i + 1].replay_events;
 
 		memcpy(core_power->map[i].psr_context, core_power->map[i + 1].psr_context, sizeof(struct mod_power_psr_context));
 		memset(core_power->map[i + 1].psr_context, 0, sizeof(struct mod_power_psr_context));

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.55.0

