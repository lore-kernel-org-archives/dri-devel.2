Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615A60A2617
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXfA6lNZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812AF10E063;
	Fri, 20 Nov 2026 17:19:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451D10E023
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:18:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE2AE433FB;
 Fri, 20 Nov 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795195136;
 b=atzpBexBIAINow/6DsY4HM5oUjPA6ofzy8giGa9ZN7Smgp7w1i/w4brAOOdFVIv88gKf
 7k7RB7L1voYKxwZXM5Zzi0nCQVweiJBeWtTrDEYCRVtvMgTmbLdvp84hiwRTHVKm+0WLg
 rK+SN/OsPckZye/i1kXqd/z9FuUsCba9sMjmkM8IdxF5Onth4LOJ9niJMeKkbrVY/POQ3
 pScAtHjtHGR1Bf/FMPjNZPWI6Hzr+F1Xt4r1rUc4oVUkuS0bFhSc4XWAVbOYkI8P3Vpyx
 E00WgHWywcAMJcscMvQ0ED+HicBRlC3RKMJECAiErmsTsRxLpvt5tPNI0Ug+1u74F5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795195136;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=j5aeOlXPwsIGKiT8rzKAsAdFcc8q5YgjF0Yn6AZf5ME=;
 b=OlB138q9jCIkCUUaY0zFL6pAfxSJer0sRd6t+4hJkifyuYqyYBAZ/iBLV3n0eZNHxvL5
 OT+WFQ1pCxR31/anZFOa+QqycDfuKoCRQnc0uPG2OY0weufP/nWUx5+5IBC9J2XWq/ZAx
 dpxD/UAjjY2uElwSK0iOpvx/rA0KXQzKSKBra7mSFySK6SDwcvDA9teuz73Z2Wqys+3JQ
 LLIW8ANcWb/0yamj/yozJ90tbClOqZTRf/tYtr2wLFXB4FiKurwWzfAjAr+vdZnP8aWKN
 KlVt/k9+wvK5hBExdZPBtg2crnh9zaJ/uWg/pENCo5Ps7qK0Mea0sLHROGx5ydXFZkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B03CF1F000EC;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195136;
 bh=j5aeOlXPwsIGKiT8rzKAsAdFcc8q5YgjF0Yn6AZf5ME=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=eXfA6lNZZtYJM0dI5pFb2p+6a3IcHb26UqY1Vee3RA0z4TwfHbtjuq1p9XvzjvQrz
 Qu1GvcTxkjX2/SooM8sdLz9vJaDhwqbap+J8truluGxC+HYXR3sU+q9QGukqsPmsoX
 YQY4kgQAbXjP833s6ngKT7Q4CxRQHj2NyJp3I8b7ZebvpLw3UzFtOYt8ZUt1HqgW/J
 WJG7rKbT7vBrG0auTwy0Iq5FAziej+6EXX4USZBQWbhvAjHp6QG2/qW06Y1pwrW64o
 +t5TkETDPiSoy5PuxwWUMEODJUcBqAxh0FBDLfEl7DjdLwdmPFYD12HTywOwrowIWM
 hidqj7o/z1fBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0DB004B871;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] drm/print,dyndbg: __drm_debug __read_mostly, uint
 shrink, build fixes
Date: Fri, 20 Nov 2026 10:18:27 -0700
Message-Id: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/03MSwrDIBAA0KvIrGPRoTWtq96jZGH9JAMxFg3SE
 Lx7aaDQ7Vu8HYrP5AtotkP2lQqlBTTDjoGdzDJ6Tg40AxSoxA0vPDseU1nnjSuDwQrrVHAKOga
 v7AO9j+sxdAwmKmvK21FX+dXfov6WKrngeH32rpdn79Dex2hoPtkUYWitfQD7VkXjogAAAA==
X-Change-ID: 20260925-rd-mostly-6a2fc0cd6fd6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795195125; l=2782;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xnRH0qB/GwHqK1xzuiISEJFJ6H/0x3SoHlEN19+4id0=;
 b=ZVbV5T5CdTJSA9L2enICkZVUo5maRNjASt3co0FrgQPrH6ymN3NTcqDsl0ZT5yL1axpG0Nk/l
 Zt59NE/PumvAGV24WCPaSGeLwxbz0XVkfFC7tZIwFtVfskxxrzOoTMA
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series improves __drm_debug placement/sizing and fixes two build
issues exposed when CONFIG_DRM_USE_DYNAMIC_DEBUG=y is enabled:        

1. Mark __drm_debug as __read_mostly to move it out of the cacheline
it currently shares with frequently written locks and structures.  In
a 12-vkcube test, its read rate is ~83 kHz.
    
2. Fix CFLAGS- -> ccflags- spelling error in drivers/gpu/drm/Makefile
to add -DDYNAMIC_DEBUG_MODULE when CONFIG_DYNAMIC_DEBUG_CORE=y without
CONFIG_DYNAMIC_DEBUG=y.  Also add subdir-ccflags- so DRM subdirs
(drivers and helpers) get the -Dflag too.

3. Drop the unused `category` local in __drm_printfn_dbg() when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y expands __drm_debug_enabled() to true.

4. Shrink __drm_debug and struct ddebug_class_param.bits from unsigned
long back to unsigned int, updating lib/dynamic_debug.c and        
lib/test_dynamic_debug.c callers accordingly.               

NOTES:

drm and dyndbg are coupled on __drm_debug's size and type, so changing
the size requires coordination between DRM and core.  The coupling
allows dyndbg to use the var to keep 'state', and allows drm to
continue using it in a few cases where drm_*dbg doesnt quite fit.

Because DRM_USE_DYNAMIC_DEBUG still depends on BROKEN, patches 2-4
were build-tested with that dependency locally removed. That un-BROKEN
patch is intentionally excluded here, as modular DRM probe-time
drm.debug support (and external users like drivers/accel/) still
need the separate/pending classmap fixup series.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v2:
- Add subdir-ccflags- propagation in drivers/gpu/drm/Makefile (patch 2).
- Add unused `category` warning fix under CONFIG_DRM_USE_DYNAMIC_DEBUG=y
(patch 3). 
- Add __drm_debug and ddebug_class_param.bits shrink to unsigned int
(patch 4).
- Link to v1: https://lore.kernel.org/r/20260926-rd-mostly-v1-0-28b7d714ed2c@gmail.com

---
Jim Cromie (5):
      drm/print: Mark __drm_debug as __read_mostly
      drm: Fix incorrect CFLAGS-y spelling inside Makefile
      drm: fix config dependent unused variable warning.
      drm/print,dyndbg: restore __drm_debug to uint from ulong
      drm-dyndbg: drop BROKEN on DRM_USE_DYNAMIC_DEBUG for testing (DONT_APPLY)

 drivers/gpu/drm/Kconfig.debug | 1 -
 drivers/gpu/drm/Makefile      | 3 ++-
 drivers/gpu/drm/drm_print.c   | 7 +++----
 include/drm/drm_print.h       | 2 +-
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 8 +++++---
 lib/test_dynamic_debug.c      | 2 +-
 7 files changed, 13 insertions(+), 12 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20260925-rd-mostly-6a2fc0cd6fd6

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


