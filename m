Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC132CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 20:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074E110E6E2;
	Tue, 26 May 2026 20:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.b="E2+WgkMg";
	dkim-atps=neutral
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Tue, 26 May 2026 18:48:14 UTC
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F2C10E1B1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=hsjJM5DVrK8F
 bkWTeJwhjpPNr/BYyBjDu24U6AurzbY=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=al2klimov.de; b=E2+WgkMgMWzEuC8idw43CBXl/EmfM3iT
 vMpNxOUrM6FQuy1SGnFMCQz+3ADtebTHez0D025CeQHUg9DvwY646e7J617Pg3I+RmGM+x
 hrqBfLdaeKmnhj8CadNagc2pS3fs8rv/+JBrAqC1hBA4cGgtv5A/B/eUGJXv13ZOSbnyIR
 66jCLMMNe5TA2HXGBYMWOtCG5/3WDJHhWEksrGFYCAKowQeUqP5hhrXHtwVmDhm5nc5ly4
 O7W5Bn5d3C41xAwdruN+l3zpRzMnO0YjHSJEM40Z/mwNgyugtdvjfw/mYFViFmWMww7rJl
 cuWiEwCd/wmY2Adc1OZ+GXUXHi+qxA==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
 by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id c57fab13
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Tue, 26 May 2026 18:41:32 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] drm/vc4: fix krealloc() memory leak
Date: Tue, 26 May 2026 20:41:00 +0200
Message-ID: <20260526184105.18962-5-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526184105.18962-1-grandmaster@al2klimov.de>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 20:30:45 +0000
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
 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index d48cf76983c0..af48758592f9 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -291,14 +291,14 @@ static bool require_uniform_address_uniform(struct vc4_validated_shader_info *va
 	uint32_t o = validated_shader->num_uniform_addr_offsets;
 	uint32_t num_uniforms = validated_shader->uniforms_size / 4;
 
-	validated_shader->uniform_addr_offsets =
-		krealloc(validated_shader->uniform_addr_offsets,
-			 (o + 1) *
-			 sizeof(*validated_shader->uniform_addr_offsets),
-			 GFP_KERNEL);
-	if (!validated_shader->uniform_addr_offsets)
+	void *mem = krealloc(validated_shader->uniform_addr_offsets,
+			     (o + 1) *
+			     sizeof(*validated_shader->uniform_addr_offsets),
+			     GFP_KERNEL);
+	if (!mem)
 		return false;
 
+	validated_shader->uniform_addr_offsets = mem;
 	validated_shader->uniform_addr_offsets[o] = num_uniforms;
 	validated_shader->num_uniform_addr_offsets++;
 
-- 
2.54.0

