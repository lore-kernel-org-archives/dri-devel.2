Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E65CCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E9910F642;
	Tue,  2 Jun 2026 22:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mK+zlivW";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A09D10F642
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490a765d410so34379025e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440492; x=1781045292; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V9cvVq2UX5qs+A/PtNYPNl1ibkkw2juVOILs+9glAdc=;
 b=mK+zlivWnFR43exWpM4r7k/Ie9pqq8uQYxJCot79yWBxmzhj6fRnfCpyr2p1peM65I
 ab5GnjlybPdLegrhDSdRMrnhl58ZVu8T32R9JDvYF+UOJ3vDJRWGiOfxfTDPCA5zWi4V
 ROH/grK+FdIf0TL7fznx63Gj+n8B0higwPL+nij4VtHT2bxw2UROiTvH0ERXw7gcpQt1
 Z8FqWd00xp9T8ye0LF4p/ATbrKtndY1M7VtrN1zuRE5YDslYvhi46Wfj/AMLeDgyGZZL
 jTIHm790WPjdvLw5qptgiIvl7QBmG7F/FwcibDdrGwfd5FCN5F/nDpUfV40DaI8sLvN3
 GA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440492; x=1781045292;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9cvVq2UX5qs+A/PtNYPNl1ibkkw2juVOILs+9glAdc=;
 b=MwYo8FmHicgdRpgCXah7U+5dd2o22MM2dSLfVtUZZ0s3BWB89okTNnkL4LedYlk4tR
 2J3frxvUKW10dED0eAgkcDK7loji6p1LBCnIWlNad4EGJXdcLAU5tSErp9QQaTyuRDDV
 y16AlLGslRPLe4DdBfZNj0tBUizpw902QPxicjgRzm5O3famp5KLjGZ9L2sgD2DNt3qg
 X71pHBbtIKZCOQJ4TUF7P1icMWM2bKmk04SGYkdYuWU1alqrOTbk87Zaigjw/XF6xSCn
 VCsBTTaugkPDWwnZ9mc4bKUYlIsuSF60usIoFWZf/Qoqq2FTfkyzgE2f6EI3O8QD14vH
 /UZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eKOlpTQyjE4HCLUm8QG5+lcOfpwXhfp/oxq5Jmzc+EIELG178NMTdL6IV6kz+p0iofHD2PP0lAE0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2uufWvA0/v+Kjr1C+gQJe4QqF9x9P8KwZ7/tXlDzzHtbH5F3D
 ZDg8OcDqC/QD5zbsR5qkdCx/INGPWdAySKM2xgyLMQvtHnglGzhausD4
X-Gm-Gg: Acq92OGVUD1WWGT76Lu1jdaRc9FNlJdMhNFYMrtshNo3wzTUiEJzCKCcFfaOzR5d2JL
 X2Yir/673ZYgPsf0faNuvZfSEKp4YifXf8Iiiqe7dUtYrWlVzmT6CFlqWTJdKfgHUty92S9gw5j
 O8KrzXrudUkAKdqH8KaNINQkunKRQhkK1J2+l89AjXBTgT+7lS+WOM9+MwZEfhJQkxslTR+aKMR
 YnpxZhvMnOkZTLLrUhQbycJoirftZOreBI8e/wL+ICH6bRpDSmKvr8hCFqq2hZYHzWLvVBwKTW9
 rD9LlXKLDDtPji17ju2PIjvGyJu+T+bGsYUQaZcDM9v+zJqkGaaeLZlj9g88qUuZqKYPWDOxcH1
 +Iu6Xyc9BCrU4AugZOmUUrOLzaTuaOIFJT4quioMRyCmHZmTUz0t6lsWfX5g1TnfSmg5tfaAJcN
 PFbGts0kGWiPOTXcU+45NI2C+oIaDEPtbHyqx3uqYGww==
X-Received: by 2002:a05:600c:8712:b0:490:b106:4fe8 with SMTP id
 5b1f17b1804b1-490b5ed5d5cmr11883645e9.33.1780440491565; 
 Tue, 02 Jun 2026 15:48:11 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 00/25] dynamic-debug cleanups refactors maintenance +
 alignment fix
Date: Tue, 02 Jun 2026 22:47:57 +0000
Message-Id: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOwQqDMAxAf0V6XkebVp077T/GDrXtNDDtaKVsi
 P++KIy5S+AlvEdmlnxEn9i5mFn0GROGkUAfCmZ7M3aeoyNmIKASJUjuHB8MjhMHXle21CDqhgY
 j4Rn9HV9b7Hoj7jFNIb63doZ1+82ofSYDF7xtVK0kGCNO6tLR6XG0YWBrJqufWom/D7IiVRtZt
 qBl65Tdq8uyfABmofZ03wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=6217;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pvqZETCsYkC1jfFJFSdQMsi9nib/U911lUcWXFhah34=;
 b=c5JtxMZifQHPMyBgcfsCSWRGiDIiiRZIirFhHQsdyOt6nNO24F5i7nHlhST28dRSas2WCF5nq
 rwhKP25z64EDzaAC8kCEnvcwXRGPVK2kiFNaSe5XO62iU/o9DUJEclW
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

V4 of this series drops 2 doc-only patches in v3, recently picked up
by linux-doc, thx Jonathan

So new 1st 5 are a fix to a linker-script alignment problem in 32bit
arches causing a null-ptr scanning dyndbg-descriptor section on i386.
These were reviewed by Petr Pavlu.

V4 main change is addition and use of match_wildcard_hyphen(), which
allows that "i2c_hid" is same as "i2c-hid" wrt to modname comparison.
This addresses sashiko-dev's feedback on V3.

v3:

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

patch-24 eliminates the ambiguity by using KBUILD_MODFILE to provide a
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
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com

Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260523-dd-maint-2-v2-0-b937312aa083@gmail.com

---
Jim Cromie (25):
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
      lib/parser: add match_wildcard_hyphen() for agnostic matching
      dynamic_debug: use KBUILD_MODFILE for unique builtin module names

 Documentation/admin-guide/dynamic-debug-howto.rst  |  55 ++-
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/drm_print.c                        |   6 +-
 include/asm-generic/bounded_sections.lds.h         |  32 ++
 include/asm-generic/dyndbg.lds.h                   |  18 +
 include/asm-generic/vmlinux.lds.h                  |  68 +--
 include/drm/drm_print.h                            |   2 +-
 include/linux/dynamic_debug.h                      | 133 +++---
 include/linux/parser.h                             |   1 +
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 507 ++++++++++-----------
 lib/parser.c                                       |  58 ++-
 lib/test_dynamic_debug.c                           |  30 +-
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 343 ++++++++++++++
 18 files changed, 833 insertions(+), 454 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

