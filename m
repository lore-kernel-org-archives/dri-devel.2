Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F0606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp4Clq07
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BAB10EE53;
	Mon, 16 Nov 2026 10:16:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B6510EE53
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:16:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C18D41A66;
 Mon, 16 Nov 2026 10:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF81F000C6;
 Mon, 16 Nov 2026 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794824190;
 bh=xhOm1k28TVwjypTguaVYnEw+SHxoaZ9nytF6bokwZmQ=;
 h=From:Date:Subject:To:Cc;
 b=Sp4Clq07qqcT6dBdu6p/fAbn56W7lg/E/r2BFLf6WhsjFmbH8I4RZUoDvaBOAtBpj
 pOSevZxScwYl5maLReg10kmOQ/Zk3j4myV0xg5GZRTYVzEEb81QWQ/kN2xyofQOfbn
 j9QK/lp2LyMjppG3wqkrrr6P1Fq/bCpVcTUctdRN/H33tElF5GPtXXpLdfIVVSU61I
 OS55emC/3rClVpunTHG95dJ7Ls2Pb07CST+AWi7+hK4JtYbScyE/9f4/CLbdqhI54S
 wVnNIhYb+PASaIUOZ8zMzT6giBPqzrtEp9VcTIU7sRi28fwbKa5mbJ8jcY4dz3SPZw
 Pkg8NfCYxyKZw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:16:26 +0100
Subject: [PATCH] dt-bindings: display: ste,mcde: Deprecate EPOD supply
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-mcde-powerdomain-binding-v1-1-4f0f7ee280a0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQqDMAwA0KuEfBtonfajVxn7aJvM5cNUWjYF8
 e4D3wXeiV2aSscIJzb5addqGMEPgOWTbBFSxgg4ujF47wN9j9k5WgsLbXWXxnVNapTVWG0hl9j
 nx1ymkAsOgFuTtx538Hxd1x8BHuFQcAAAAA==
X-Change-ID: 20261116-ux500-mcde-powerdomain-binding-0ad1b35c46bc
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make epod-supply optional and mark it deprecated.

The MCDE should use its power domain instead.

Require either epod-supply or power-domains, allowing both for
transitional device trees. Reject nodes describing neither.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Deprecate the legacy EPOD supply and allow MCDE to use its power domain
instead. Accept either property or both, rejecting nodes with neither.

This binding-only change can be applied independently. The companion
MCDE driver and Ux500 DTS changes are submitted separately.
---
 Documentation/devicetree/bindings/display/ste,mcde.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index 05e7e4ebc882..e7978eca6f32 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -39,7 +39,8 @@ properties:
     maxItems: 1
 
   epod-supply:
-    description: a phandle to the EPOD regulator
+    description: a phandle to the legacy EPOD regulator
+    deprecated: true
 
   vana-supply:
     description: a phandle to the analog voltage regulator
@@ -103,9 +104,14 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - epod-supply
   - vana-supply
 
+anyOf:
+  - required:
+      - epod-supply
+  - required:
+      - power-domains
+
 additionalProperties: false
 
 examples:
@@ -121,7 +127,6 @@ examples:
       reg = <0xa0350000 0x1000>;
       interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
       power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-      epod-supply = <&db8500_b2r2_mcde_reg>;
       vana-supply = <&ab8500_ldo_ana_reg>;
       clocks = <&prcmu_clk PRCMU_MCDECLK>,
                <&prcmu_clk PRCMU_LCDCLK>,

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261116-ux500-mcde-powerdomain-binding-0ad1b35c46bc

Best regards,
--  
Linus Walleij <linusw@kernel.org>

