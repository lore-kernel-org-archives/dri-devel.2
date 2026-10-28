Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC987606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53C711202D;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0126510FA45;
 Wed, 28 Oct 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1793175638;
 bh=gVqyFTfbEx0Cy541rHtX1s3lHEBCWasBv5wrEWGFtiI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=zSnSDJrh8lBPc+WJwkieuUvYZceHyW7Vo/Rgps/0sKKYfp+K8gQiq+VtATPCk1zcM
 2R2y4VPojBg1miUzjCPiX1c/WXoMhA0i7UdNieYWkQzNjxxQaVUfA0XDy7P6CuqIG8
 6OdZZd54748+SoGV6+XeC+xLbbD4RuBe2dmrjidY=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id 232FBFBD1C;
 Wed, 28 Oct 2026 08:20:38 +0000 (UTC)
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
Subject: [PATCH 10/10] checkpatch: suggest nonnull attribute conversion
Date: Wed, 28 Oct 2026 08:19:49 +0000
Message-ID: <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
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

The kernel provides the __nonnull_args() macro as the preferred form for
marking pointer arguments as non-NULL. Add a check suggesting the macro
over the raw __attribute__((nonnull)) spelling, consistent with the
existing attribute conversion suggestions.

Examples:

  WARNING: Prefer __nonnull_args(1, 2) over __attribute__((nonnull(1, 2)))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:230:
  +__attribute__((nonnull(1, 2)))

  WARNING: Prefer __nonnull_args() over __attribute__((nonnull))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:283:
  +__attribute__((nonnull))

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9840f5219c2..e696fcd02337 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6856,6 +6856,7 @@ sub process {
 				"no_caller_saved_registers"	=> "__no_caller_saved_registers",
 				"noclone"			=> "__noclone",
 				"noinline"			=> "noinline",
+				"nonnull"			=> "__nonnull_args",
 				"nonstring"			=> "__nonstring",
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
@@ -6876,6 +6877,8 @@ sub process {
 					if ($curr_attr eq "format" && $params) {
 						$params =~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
 						$new = "__$1\($2";
+					} elsif ($curr_attr eq "nonnull" && $params eq "") {
+						$new = "$new()";
 					} else {
 						$new = "$new$params";
 					}
-- 
2.53.0-Meta

