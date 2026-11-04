Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29261606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEB510E874;
	Wed,  4 Nov 2026 08:58:28 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0814D10F988
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:05:04 +0000 (UTC)
Received: from [161.142.148.162] (helo=localhost.localdomain)
 by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <basti@sraa.de>)
 id 1xOQqT-00Akzf-Pq; Wed, 04 Nov 2026 03:35:26 +0100
From: Sebastian Raase <linux@sraa.de>
To: 
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Sebastian Raase <linux@sraa.de>
Subject: [PATCH 2/2] dt-bindings: display: simple-framebuffer: Document mono
 format
Date: Wed,  4 Nov 2026 10:34:50 +0800
Message-ID: <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a 1 bit-per-pixel monochrome format, with 8 pixels/byte.

Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 45ffdebc9d86..c627ec088434 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -94,6 +94,7 @@ properties:
   format:
     description: >
       Format of the framebuffer:
+        * `mono` - 1-bit packed pixels, 8 pixels/byte
         * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g, d[4:0]=b
         * `a2r10g10b10` - 32-bit pixels, d[31:30]=a, d[29:20]=r, d[19:10]=g, d[9:0]=b
         * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
@@ -106,6 +107,7 @@ properties:
         * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
         * `x8b8g8r8` - 32-bit pixels, d[23:16]=b, d[15:8]=g, d[7:0]=r
     enum:
+      - mono
       - a1r5g5b5
       - a2r10g10b10
       - a8b8g8r8
-- 
2.47.3

