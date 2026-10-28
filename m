Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F76606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=scmphY3W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B436211206C;
	Thu, 29 Oct 2026 07:59:22 +0000 (UTC)
X-Greylist: delayed 567 seconds by postgrey-1.36 at gabe;
 Wed, 28 Oct 2026 08:30:02 UTC
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA6610FA15;
 Wed, 28 Oct 2026 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1793175633;
 bh=K5LKyQgYKwl4SQBjA15TdSBAX9bbXAc3tVQHLRXEih8=;
 h=From:To:Cc:Subject:Date;
 b=scmphY3Wunrsmp+34WEVPizPYNuER4OuyqQN+7wcAk8b243s6Ql6ZgZzt2Q3H2Zn3
 fwtCXvfv3lUFbjuEGdD5xIfcK8QirvUz/AoB8DzMfhdVnF9ZGl/3QyMwT3LvSHQOfV
 tYEhcDcVdgbtrWL1qNZRxMyUJGS6xrDDGVIAFe9A=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id E3225FBCE3;
 Wed, 28 Oct 2026 08:20:32 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:39 +0000
Message-ID: <cover.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the __nonnull_args() macro to wrap the raw compiler
attribute, keeping the attribute's quirks in one place rather than
open-coded at every call site.

This series replaces the remaining open-coded __attribute__((nonnull))
users with __nonnull_args() to standardize nonnull attribute usage
across the tree.

Each patch can be applied separately by the respective maintainers. The
only dependency is kernel-doc: the string and lib/list_sort patches need
patch 1 ("docs: xforms_lists: support __nonnull_args()") in the same
release, otherwise strends() and list_sort() drop out of the generated
documentation.

Latest Sparse release could not properly parse __nonnull_args() without
arguments. Fix was proposed [1] and merged, but until updated version of
Sparse will reach wide masses it might trip on __nonnull_args() without
arguments.

There are few more instances of __attribute__((nonnull)) usages left in
the tools subdirectory, they are perf related copied files and can
(should?) be updated separately after this patchset lands.

Build-tested allmodconfig with GCC 11.5.0 and clang 22.1.8.

[1]: https://lore.kernel.org/all/20261019175633.415493-19-bvanassche@acm.org/

Dmitry Ilvokhin (10):
  docs: xforms_lists: support __nonnull_args()
  string: Switch to __nonnull_args() macro
  lib/list_sort: Switch to __nonnull_args() macro
  xarray: switch to __nonnull_args() macro
  drm/i915: switch to __nonnull_args() macro
  drm/amdgpu: switch to __nonnull_args() macro
  drm/gem: Switch to __nonnull_args() macro
  leds: pwm: Switch to __nonnull_args() macro
  soc: aspeed: lpc-snoop: Switch to __nonnull_args() macro
  checkpatch: suggest nonnull attribute conversion

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
 drivers/gpu/drm/i915/i915_request.h        | 4 ++--
 drivers/leds/leds-pwm.c                    | 2 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c      | 4 ++--
 include/drm/drm_gem.h                      | 2 +-
 include/linux/list_sort.h                  | 4 ++--
 include/linux/string.h                     | 2 +-
 include/linux/xarray.h                     | 4 ++--
 lib/list_sort.c                            | 6 +++---
 scripts/checkpatch.pl                      | 3 +++
 tools/include/linux/compiler.h             | 4 ++++
 tools/lib/python/kdoc/xforms_lists.py      | 1 +
 13 files changed, 25 insertions(+), 17 deletions(-)


base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.53.0-Meta

