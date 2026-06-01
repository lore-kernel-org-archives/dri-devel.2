Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD5CCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C66113263;
	Mon,  1 Jun 2026 12:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOpEAz88";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B6D113263
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so29255535e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315499; x=1780920299; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5qzKyfnccgdjCAGXdsv8yWwGixxrImvsfnV142aaYI=;
 b=iOpEAz88P06kLqXI811XQp41FnxwYZTxx/liwSYAf08Mwv3LIQcRKV/aNEGKemHFin
 xiP5FirL+nuqBX+UwflE5Dv7vBD/7fIXZcGThdNt8CNBWFeO8dRRnDNO7Ie3/2cgnnwx
 vLVS5nbvjxAizCuIfNVUDxo8K3aN2oR+yDguBPlaMi9oBR27mCy5PWD4fGrEI4GG0Mly
 ADjOp4um757n2fXx3OHx2uBzD/p6bVM4vvuvUjs9YPIgLOlaG7AgKCactf1vn5MkPPSw
 bk3uVb8+R07J1ihW4hz9rWbMVTyB/+W6wxRN48nxvlrN00PW/eB/t6YS10AEkiiyLj4h
 pR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315499; x=1780920299;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5qzKyfnccgdjCAGXdsv8yWwGixxrImvsfnV142aaYI=;
 b=OTP7CsJJ3Za424BRud2xfGs8cXP75C8p9wKkhmg18Y6UcVBR3wgU1Ue28MGcH7XcZY
 RH1ramfEPPvvGnykMOlq52oPxf/vPD3zvn1f8gtgBM+HyJfMh9/Zf58lWmSeuHAcHKcU
 996zMDygOrLTSPOW7Tq55d9yCgeaUTvKBAGP/txfvFsIE9OXgEriUR+3h9dTMCikPvSj
 ZUe03J/gr4yhdj1veSm98irFex3Gt+y5TpWbQyUbjAWw4XIJHY0GiNPdj03tNsYr+F7U
 3NF6hz+aoozFb2LkPQjFYwtA+uoDIJrzXGSPxE8B9TnyJ5KrcPOiEs9sSx5HtaTZl38d
 5s5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YynBC1fG3vowMtwKMfRT8TRSd0uxoqbFn+/TYKEdkS3PSobqJMaLt/gfntu38VhhAQWhZgsf9vVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhK3VeDwJSck2PqIZqxT9qWBfc/rcLaWocuBArP4IBSCx/BYfG
 paiG1V2qwIcGXZr+sTSO0QN2E/5OwdezYejNFXfeu9OEq9lpNTwtiDBl
X-Gm-Gg: Acq92OE3IF1erQW+busThDmPOS+fbZzd53xe2SsBcWemnPO2BI+CxyLUjrB7VfrLABj
 XCyqpjEd8FELKOa7t/d7oZX69665iFBs6I900Bc5x+aFPCdgLGOmdGyhun+Mci1RcnK6AZ/3D6A
 weonri0z0i/92GySmCh53GydApmk1C/TIk3l9EL6yHbBFyvC58FvjMoMzjqMk5xVPxNeQmpn2iQ
 kY3P8At8/ItTqMdcDuz0XiiX8NrpohKOUgNNPPF+ZHye8Ot7cfkYflqe58+Wc/00LceoogZ54QJ
 lZmRagrO2+AB4zHLoX+uBGjgpBZnFGr1Z47oIfd6zJreAXiVmJhcIfuJNUk0qbMTygxVi64cgu7
 7hTmJqcafILJeXOsepjS64MSeL4I/81T5DNPfLtzzEJHB/E5Zsj1d9s9siCSGmjhWoIrLRFR2YW
 H13+LaEiv1NfXPXK1vyCjew7/2ucQfS3G/wOhzZS7nVw==
X-Received: by 2002:a05:600c:3487:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-490a2918103mr212890145e9.10.1780315498448; 
 Mon, 01 Jun 2026 05:04:58 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:04:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 00/24] dynamic-debug cleanups refactors maintenance +
 alignment fix
Date: Mon, 01 Jun 2026 12:04:46 +0000
Message-Id: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MwQrCMBBEf6Xs2ZV0Yxvryf+QHmIS2wWblKQEp
 fTfjQXBy8CbYd4KyUV2CS7VCtFlThx8AXmowIzaDw7ZFgYS1IqGarQWJ81+QULVmuZEQnUloBz
 m6B782mW3vvDIaQnxvbszfdufRv5rMqHAeyeVrElrcZbXoUzPowkT9Nu2fQATd1+rpAAAAA==
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=5739;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UexA6IlALDsQZOTV0hLwfWpaRW3TbsQLPhPBboqis4A=;
 b=lvmgQ8g7xkH604t4KBSwylbWD7BLSeGoj0N94EqFttk+uNoSZ34wsVJ4kCQjAP+56C7j9e8+r
 8/livVa5JYuDL7dtGrwkxv+mPMASsWpXe10/NQqoJFwX0pqQwFAG0+r
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

This series starts with 2 doc-only patches updating the current state
of dynamic-debug, they were posted separately here, without pushback.

https://lore.kernel.org/linux-doc/20260502-dyndbg-doc-v1-0-67cc4a93a77e@gmail.com/
    
Next 5 are a fix to a linker-script alignment problem in 32bit arches
causing a null-ptr scanning dyndbg-descriptor section on i386.  These
were reviewed by Petr Pavlu.

The remaining patches are cleanups, refactors in preparation for an
API change needed to fix a regression in DRM when it uses classmaps.
I split these out for easier review, I will follow up with the API
change afterwards.

The biggest revision vs V2 is the new patch: 25.  It addresses a flaw
detected by sashiko which is best described by example.

Dyndbg uses KBUILD_MODNAME to provide module-name, this works well for
loadable modules (module loader requires unique module names), but for
builtin modules, is effectively kbasename, and not unique.

So we get 4 modules named "main": init/main, kernel/power/main,
kernel/base/poser/main.  This ambiguity is visible in user-space since
the beginning of dyndbg.

Now suppose kernel/{,base}/power/main want to define classmaps to
categorize the various pr-debugs they have.  The current code finds a
module's classmaps by strcmp on modname, so init/main will match
against classmaps defined by both kernel/{,base}/power/main.

The current code will also map "main" classes to kernel/*/power/main,
so they will probably work at first, but 2 independent classmaps can
both use class-ids 0-N, but will conflict if they're both used by a
module.  Then we have classmap overlaps and unpredictable results.

patch-25 eliminates the ambiguity by using KBUILD_MODFILE to provide a
unique module-name, then adds matching against kbasename(modname) to
restore the legacy query behavior.  It *does* change the modname
exposed in /proc/dynamic_debug/control, but not the result of a query
like "module main +p".

OLDER VERSIONS:

V2 primarily revises:
 https://lore.kernel.org/lkml/20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com/
    
V2 addressed most of sashiko's feedback on V1:
 https://sashiko.dev/#/patchset/20260504-dd-cleanups-2-v1-0-6fdd24040642%40gmail.com
    
It dropped the pr-fmt patch, as not reproducible,
advanced the drop-NAMES patch to reduce subsequent churn,
and fixed the classmaps PARAMs to u64 to avoid 32bit flags on 32bit arches
    
For easy one-stop-shopping, V2 also included 2 smaller series:
    
1st fixes a section alignment problem, with Reviewed-by from Petr Pavlu
 https://lore.kernel.org/lkml/20260515-asm-generic-1-v3-0-680b273666d4@gmail.com/
    
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
    

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260523-dd-maint-2-v2-0-b937312aa083@gmail.com

---
Jim Cromie (24):
      docs/dyndbg: update examples \012 to \n
      docs/dyndbg: explain flags parse 1st
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules
      dyndbg: factor ddebug_match_desc out from ddebug_change
      dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
      dyndbg: reword "class unknown," to "class:_UNKNOWN_"
      dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
      dyndbg: drop NUM_TYPE_ARGS
      dyndbg: reduce verbose/debug clutter
      dyndbg: refactor param_set_dyndbg_classes and below
      dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
      dyndbg: replace classmap list with an array-slice
      dyndbg: macrofy a 2-index for-loop pattern
      dyndbg: Upgrade class param storage to u64 for 64-bit classmaps
      dyndbg,module: make proper substructs in _ddebug_info
      dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
      dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
      selftests-dyndbg: add a dynamic_debug run_tests target
      dyndbg: change __dynamic_func_call_cls* macros into expressions
      dynamic_debug: use KBUILD_MODFILE for unique builtin module names

 Documentation/admin-guide/dynamic-debug-howto.rst  |  55 ++-
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/drm_print.c                        |   6 +-
 include/asm-generic/bounded_sections.lds.h         |  32 ++
 include/asm-generic/dyndbg.lds.h                   |  18 +
 include/asm-generic/vmlinux.lds.h                  |  68 +--
 include/drm/drm_print.h                            |   2 +-
 include/linux/dynamic_debug.h                      | 133 +++---
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 501 ++++++++++-----------
 lib/test_dynamic_debug.c                           |  30 +-
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 294 ++++++++++++
 16 files changed, 736 insertions(+), 437 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

