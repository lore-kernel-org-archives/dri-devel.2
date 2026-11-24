Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA1606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoMPe4kj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF01510E25C;
	Tue, 24 Nov 2026 23:38:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3065210E25C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:38:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D617840AB7;
 Tue, 24 Nov 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795563522;
 b=F47Eue85tam9vsdEi7M83DdLuqwtk5b7hlZcmw//GP6YvO5fm6eb5YrLUURV7X0a3fYc
 8nzW8FTdHjnJ7YZPbPnEv8yyAxjsWVrXuW8ib2JS33q8KK2e1c/YIvizl1O1CLpq5dINS
 g/WWjSCuwSr5zckkYERq4lyPP1mgQzKh+wu1dCvtC1v3ma84v+UiAM8SlOb57E2RGmkdi
 1FZYhjs3zK7U++rVIWzCCfF5Q0wC9uHWoKW00MAiLuRSQkCD0nrrqiFImDEM9IkztfBDQ
 0iwTeVjkPiQGxnI9wWjhJX7eUcmzm3Iv79X9VGvVjaCaP4h2eqX5VgeMOd0Nlg8m3bA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795563522;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=UQt84HSZA94+ujWfeso/jFUoDNCEeSaih8Kb/OpiY8s=;
 b=cQnCXZvRNhB3PewKtUL+dZGARY76PxqC8r/8oZCVUX4sAKCSXmbBKcDPw8FAspoO5vcK
 MmanELBFDNPvDSPB/paxOlOzE6MRXiuHtiiFwcoiTBKjDHi8R0i0ei8Jqh+dC5OrQtGF6
 qDCYwujxyk0inLSX6lJSi9+rbqR9mB1h8HIFosBJxKGrW1pDyxPW27CpYiJDIXhUzftzh
 fqO1v54YZBVTde9RmgMkh2yL6Crg29M52MhEIk8K81gDtq8QGXpRg5AeX2OBGolEuf92X
 OOXWkZOWmYqxN2wpLLOe54N3wk3y71a9HxwM0WcZ/m15GKQ4oL8HS125IEid+sqevRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 98C451F000C4;
 Tue, 24 Nov 2026 23:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795563522;
 bh=UQt84HSZA94+ujWfeso/jFUoDNCEeSaih8Kb/OpiY8s=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=PoMPe4kjOXy6i4vsi0yR4ARQXxm7UQlpPAWXd2YUofxM1IpIl7R45Hawbx1BVmwEi
 QgSxAdycqEzZEQLZ0vu3rz2riDmMdUh+ut9thdPYjgcmyyyRU5DeBuiVpjLf8Z3s2z
 1GnXUtXL6RbX7Zlf1tkBjhn361Mye/XUDbZwlpgtpTkY3KTLIBjgeyIO5pvCRnmybB
 fkUvH427jSo9tG/JdljOn4/llu9Vm/aQsZtM2OHDBYXgBnNbOAtEH0vYLetO6wkRLa
 FmgoaUyBuTCLN7RBxa6XRzQOxITxSlDcojpWRAe52iJi/6CZKp0D/Zdcl7s6ebNpA5
 ivBtLw/i2Iu5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 001324CC5F;
 Tue, 24 Nov 2026 23:38:33 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] drm/print,dyndbg: __drm_debug __read_mostly,
 restore it to uint, printer fix
Date: Tue, 24 Nov 2026 16:38:32 -0700
Message-Id: <20261124-rd-mostly-v4-0-26d60beb6666@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/13MTQqDMBBA4auEWZuSjBp/Vr1H6UKTUQNqSiJSE
 e9eFFpCtw++t0MgbylAzXbwtNpg3Qw1yxIGemjmnrg1UDNAgUpUmHNv+OTCMm5cNdhpoY3qjIK
 EwctTZ9/X6/FMGAw2LM5v13qVZ/1eVHRZJRccy7YwhczIoL73U2PHm3YTnJcVf1JKFLFELnhZi
 lyRIYFN+S/TWMpYpqesqMhaTNuskrE8juMDuxeYdBYBAAA=
X-Change-ID: 20260925-rd-mostly-6a2fc0cd6fd6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luca Coelho <luciano.coelho@intel.com>, Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795563513; l=2697;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4UCbxxrKinpPTMCGiCL0XLcwvtLOOSiukBA+RJshUyc=;
 b=DxACAMOt+FgpZsUaHjYbUUKrmcIuwfXHdGJ8q/3WSUID/afBNTT5Gs5s45BY7C8VVCtGf9Z/B
 xLZXUirlnvbBXeu+MbnM3a6A/Ycqz7qZd8h76Fn4SVrzjJMtrq8Y598
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

This series improves __drm_debug placement/sizing and fixes a
drm_dbg_printer() bypass exposed when CONFIG_DRM_USE_DYNAMIC_DEBUG=y:

1. Mark __drm_debug as __read_mostly to move it out of the cacheline
   it currently shares with frequently written locks and structures. In
   a 12-vkcube test, its read rate is ~83 kHz.

2. Shrink __drm_debug and struct ddebug_class_param.bits from unsigned
   long back to (original) unsigned int, updating lib/dynamic_debug.c
   and lib/test_dynamic_debug.c callers accordingly.

3. Fix __drm_printfn_dbg() use of __drm_debug_enabled(), which always
   prints when CONFIG_DRM_USE_DYNAMIC_DEBUG=y, disregarding p->category.

NOTES:

drm and dyndbg are coupled on __drm_debug's size and type, so changing
the size requires coordination between DRM and dyndbg. The coupling
allows dyndbg to keep state in __drm_debug while letting drm use it in
cases where static-key drm_*dbg() macros do not fit.

Build-tested with BROKEN locally removed from DRM_USE_DYNAMIC_DEBUG to
cover both Y/N cases. That un-BROKEN patch is intentionally excluded
here as drm.debug still needs classmap fixes patchset.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v4:
- Replace unused-variable workaround with proper __drm_printfn_dbg()
  fix (per Sashiko review).
- Drop drivers/gpu/drm/Makefile and DONT_APPLY un-BROKEN patches from
  this series (deferred to classmap-inheritance series).
- Link to v3: https://lore.kernel.org/r/20261121-rd-mostly-v3-0-89e74b23b491@gmail.com

Changes in v3:
- dont need both ccflags-y and subdir-ccflags-y, latter covers former.
- Link to v2: https://lore.kernel.org/r/20261120-rd-mostly-v2-0-88056ede02a8@gmail.com

Changes in v2:
- Add subdir-ccflags- propagation in drivers/gpu/drm/Makefile (patch 2).
- Add unused `category` warning fix under CONFIG_DRM_USE_DYNAMIC_DEBUG=y
  (patch 3).
- Add __drm_debug and ddebug_class_param.bits shrink to unsigned int
  (patch 4).
- Link to v1: https://lore.kernel.org/r/20260926-rd-mostly-v1-0-28b7d714ed2c@gmail.com

---
Jim Cromie (3):
      drm/print: Mark __drm_debug as __read_mostly
      drm/print,dyndbg: restore __drm_debug to uint from ulong
      drm/print: fix drm_printer dynamic debug bit-test bypass

 drivers/gpu/drm/drm_print.c   | 7 +++----
 include/drm/drm_print.h       | 2 +-
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 8 +++++---
 lib/test_dynamic_debug.c      | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20260925-rd-mostly-6a2fc0cd6fd6

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


