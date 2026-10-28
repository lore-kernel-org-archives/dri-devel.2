Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16D606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=Jg8BLE8I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E011202C;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932C110FA3F;
 Wed, 28 Oct 2026 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1793175635;
 bh=ceexsp2t6/v12ItyH2pSPyV+syh2rxnTHvgHk3Ni1dE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jg8BLE8IZCB+yObRAAqiVmVgU9sigg/nFDUGFqQXhWnSUadRZwDKyR4LY8EpthVle
 pA/bIha5skUWK4mVY8+AIkx6NRdoOUTSd/zD45eghCBSekWpPyZ52q6p9FUlikkAVg
 i5iCn86ahK5MOiZH/P0BO+c07/rkr7dgAwZrsWjg=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id E1323FBCF2;
 Wed, 28 Oct 2026 08:20:34 +0000 (UTC)
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
Subject: [PATCH 04/10] xarray: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:43 +0000
Message-ID: <e2660c4c9f5e6f97be2ef7bd3752d259bce77d81.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:57 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the macro __nonnull_args() to wrap raw compiler
attribute.

Replace __attribute__((nonnull)) with __nonnull_args() to standardize
nonnull attribute usage across the tree and keep the attribute's quirks
in one place rather than open-coded at every call site.

tools/testing/shared/linux/xarray.h directly includes the kernel's
include/linux/xarray.h, which now uses __nonnull_args(). The macro is
not defined under tools/, breaking test builds.

Define __nonnull_args() in tools/include/linux/compiler.h.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/xarray.h         | 4 ++--
 tools/include/linux/compiler.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..cf7f8802da5b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -361,9 +361,9 @@ bool xa_get_mark(struct xarray *, unsigned long index, xa_mark_t);
 void xa_set_mark(struct xarray *, unsigned long index, xa_mark_t);
 void xa_clear_mark(struct xarray *, unsigned long index, xa_mark_t);
 void *xa_find(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
+		unsigned long max, xa_mark_t) __nonnull_args(2);
 void *xa_find_after(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
+		unsigned long max, xa_mark_t) __nonnull_args(2);
 unsigned int xa_extract(struct xarray *, void **dst, unsigned long start,
 		unsigned long max, unsigned int n, xa_mark_t);
 void xa_destroy(struct xarray *);
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 03ecf9086643..fad2c6131a80 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -68,6 +68,10 @@
 #define __naked __attribute__((__naked__))
 #endif
 
+#ifndef __nonnull_args
+#define __nonnull_args(x...) __attribute__((__nonnull__(x)))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-- 
2.53.0-Meta

