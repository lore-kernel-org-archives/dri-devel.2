Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C6FCD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DF2112E07;
	Sat,  6 Jun 2026 12:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.b="U/b7KfRB";
	dkim-atps=neutral
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BC3112E07
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=Je3mjrvYOWu9
 deYnlGw2ANZVN9EPnvpXPBYaxgEAgJk=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=al2klimov.de; b=U/b7KfRBZ8LvE4hmGKrAIkGVP9PBobUG
 BwQS4bFK3kLyJxQyXHn0oK/KKAEtKffGsQkoJvWUHBSW1YmHru+I3fuU3O61CyH6b8U6m/
 pGps6NMuwaSYmjrdHsHZ9upqJtWo37z9vXBgmu1+ZLxIPOgooA2+16h7AIJ2e3VscHFhkA
 wIHMSYnbcB8m/VTombkQzlIBsE90610JqF+8KadlqvmDm9Ze0Uo5LTptG+EMYnOGlp/XGr
 DuL0pRmV0kkWi70k8xcPKL8cN+q7eF/Hoe//InC2LpXyzARqFcsJPCsFLGbnnznXbLSqGL
 peHR7mR+QbgF72BwqS7hpszKNlNt3w==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
 by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id cc8e2e05
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Sat, 6 Jun 2026 12:38:26 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: 
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 llvm@lists.linux.dev (open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH v3] drm/vc4: fix krealloc() memory leak
Date: Sat,  6 Jun 2026 14:38:10 +0200
Message-ID: <20260606123817.37222-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e1edeadb7c161580a5cd5c7e642dc1b28db8ee86.camel@perches.com>
References: <e1edeadb7c161580a5cd5c7e642dc1b28db8ee86.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Don't just overwrite the original pointer passed to krealloc()
with its return value without checking latter:

    MEM = krealloc(MEM, SZ, GFP);

If krealloc() returns NULL, that erases the pointer
to the still allocated memory, hence leaks this memory.
Instead, use a temporary variable, check it's not NULL
and only then assign it to the original pointer:

    TMP = krealloc(MEM, SZ, GFP);
    if (!TMP) return;
    MEM = TMP;

While on it, use krealloc_array().

Fixes: 6d45c81d229d ("drm/vc4: Add support for branching in shader validation.")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Declare the variable explicitly
 v2: Instead of void *, use u32 *
 v2: While on it, enhance variable name
 v3: Use krealloc_array()

 [✓] scripts/checkpatch.pl --strict
 [✓] allmodconfig compiled (i686, LLVM)
 [✓] localyesconfig booted (IBM T43)

 Note to myself: use --in-reply-to=e1edeadb7c161580a5cd5c7e642dc1b28db8ee86.camel@perches.com

 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index d48cf76983c0..66502a6a4a8e 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -290,15 +290,16 @@ static bool require_uniform_address_uniform(struct vc4_validated_shader_info *va
 {
 	uint32_t o = validated_shader->num_uniform_addr_offsets;
 	uint32_t num_uniforms = validated_shader->uniforms_size / 4;
+	u32 *offsets;
 
-	validated_shader->uniform_addr_offsets =
-		krealloc(validated_shader->uniform_addr_offsets,
-			 (o + 1) *
-			 sizeof(*validated_shader->uniform_addr_offsets),
-			 GFP_KERNEL);
-	if (!validated_shader->uniform_addr_offsets)
+	offsets = krealloc_array(validated_shader->uniform_addr_offsets,
+				 o + 1,
+				 sizeof(*validated_shader->uniform_addr_offsets),
+				 GFP_KERNEL);
+	if (!offsets)
 		return false;
 
+	validated_shader->uniform_addr_offsets = offsets;
 	validated_shader->uniform_addr_offsets[o] = num_uniforms;
 	validated_shader->num_uniform_addr_offsets++;
 
-- 
2.54.0

