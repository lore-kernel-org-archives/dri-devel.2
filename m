Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D7CD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 19:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6C3112C14;
	Sun, 31 May 2026 19:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.b="KlI1Nk1I";
	dkim-atps=neutral
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD53112C14
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=ZoukwfSF8bc4
 T0zOTYJl0C8sMTVJuamWQpd1iB8O5oY=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=al2klimov.de; b=KlI1Nk1IOl7Xplg+KLj9PasHUyKo26zW
 v28XKYaCn9XtSp0HAIfaO8UMXsl8cxjmvHwqi0u8PcTsJcxgNE71K0HH9jp2oL6YY/k7QP
 FUb70eJWpnX1Q0tCl+UsGKhhGtcBrmX42C4Xto3lpk4Y1d9HGGocI197vR9Rlekqxy745Y
 NNq2qmcLXwccal2GtxXAcjIFrtopqKgBYZL3V7QstMMtTKzeD6MjwbRlUyBGqdOFva5EL+
 zZAviDp1BtEppsXVYgs+V2Bv6FUkjz4ze7G4hx/xzLeYKo3lj1nTcByka5O630M2hyO18C
 HD5SodwmJhkiySidSSxQgoeT59YxVg==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
 by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id e9e32a2c
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Sun, 31 May 2026 19:55:34 +0000 (UTC)
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
Subject: [PATCH v2] drm/vc4: fix krealloc() memory leak
Date: Sun, 31 May 2026 21:55:10 +0200
Message-ID: <20260531195515.99623-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2b602ec6-d563-4fa0-a0c5-89b97a46abf9@igalia.com>
References: <2b602ec6-d563-4fa0-a0c5-89b97a46abf9@igalia.com>
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

Fixes: 6d45c81d229d ("drm/vc4: Add support for branching in shader validation.")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Declare the variable explicitly
 v2: Instead of void *, use u32 *
 v2: While on it, enhance variable name

 [✓] scripts/checkpatch.pl --strict
 [✓] allmodconfig compiled (i686, LLVM)
 [✓] localyesconfig booted (IBM T43)

 Note to myself: use --in-reply-to=2b602ec6-d563-4fa0-a0c5-89b97a46abf9@igalia.com

 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index d48cf76983c0..6f52b4db9cc9 100644
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
+	offsets = krealloc(validated_shader->uniform_addr_offsets,
+			   (o + 1) *
+			   sizeof(*validated_shader->uniform_addr_offsets),
+			   GFP_KERNEL);
+	if (!offsets)
 		return false;
 
+	validated_shader->uniform_addr_offsets = offsets;
 	validated_shader->uniform_addr_offsets[o] = num_uniforms;
 	validated_shader->num_uniform_addr_offsets++;
 
-- 
2.54.0

