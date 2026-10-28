Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98284606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CFA112046;
	Thu, 29 Oct 2026 07:59:08 +0000 (UTC)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F068E10FA41;
 Wed, 28 Oct 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1793175634;
 bh=dWJJn/15+ghgzzIGKgM3IMULkpSh/eugDFHemmlBRb4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DeIiv9WXQV3gD55AucY67CXV5GytqfXEJkOIlH/p1vvpmEBa02wb0CiZ7FetKO8kp
 vKMP3WYwznobDJIR52jidVzMPZfhGDf6UWW8grvqXfGJ9aPtokciLL67F0nlp74wpP
 VCbSuHZCHz4d69J6NRvoiFKB6uqBPcC0poA2OXFs=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id DF86BFBCE8;
 Wed, 28 Oct 2026 08:20:33 +0000 (UTC)
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
Subject: [PATCH 02/10] string: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:41 +0000
Message-ID: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
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

Replace __attribute__((nonnull)) with __nonnull_args() to
standardize nonnull attribute usage across the tree and keep the
attribute's quirks in one place rather than open-coded at every call
site.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..1f1cb73514e1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -587,7 +587,7 @@ static inline bool strstarts(const char *str, const char *prefix)
  * Returns:
  * True if @str ends with @suffix. False in all other cases.
  */
-static inline bool __attribute__((nonnull(1, 2)))
+static inline bool __nonnull_args(1, 2)
 strends(const char *str, const char *suffix)
 {
 	unsigned int str_len = strlen(str), suffix_len = strlen(suffix);
-- 
2.53.0-Meta

