Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750ADC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931B910EFAD;
	Wed,  9 Sep 2026 08:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n5Ofbhy0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5F510EFAD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 16D1C43881;
 Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1C09C2BCFD;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941524;
 bh=vl0FAXftj3v3iwR+iZ/e3dE2FsQHyA1iRkNqch8OoDg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=n5Ofbhy0s+CvDdc4k07+/eYHZrMh9hj1LXIbdJGAT930N7pFT1EmnWuxeEE3oT36C
 HyYbEIt9277tHEVP7dcQCcDCvcw/R81bTW/VPyT2igV22YXnAdnyUo1iOlkIsG0vja
 WApFIDBgq2QrPnRtEWaElLWLgE7413OqN5moCNMsD8eejm1lR4AOWQesXO0adyP7kM
 UqS2ym4CjzlshLIiv+a4E0iAclPlWewj3wWs8R0F+rZGK3DGqzM2ksvVwE5AiIdT46
 efQ8N/L7CPJCayuV70WRUv705qMK2Pn6bvnTWmjCxcGMrUTa1biJ06hEKukncR+PuR
 vIRI563R5Xapg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C61F3C79F8C;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Date: Wed, 09 Sep 2026 01:12:01 -0700
Subject: [PATCH 3/4] dt-bindings: display: panel: ebbg,ft8719: update Joel
 Selvaraj's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-update-email-address-v1-3-94a240f9469e@joelselvaraj.com>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
In-Reply-To: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941524; l=912;
 i=foss@joelselvaraj.com; s=20260909; h=from:subject:message-id;
 bh=9NSve4XIc6DX1T3YVP+A0UkXTxGHu31A3Erg3TEI1SQ=;
 b=EYlG4vgmN24PmUjGG0Vl1NAmxTzJ9EVzEfD5FnUB/rnw3bZBi5xkg1arMEB6ZA7fUcmgwu4y6
 Hh0zgYkiRHfDs91XqK2oTF41uYnuHUr7PqskhSMJnjjLlsHDb7A0AAi
X-Developer-Key: i=foss@joelselvaraj.com; a=ed25519;
 pk=UUJ1v4UQJ/nljqj3NjsWt5H4mphWQ7etpQ4Z7JiR2yo=
X-Endpoint-Received: by B4 Relay for foss@joelselvaraj.com/20260909 with
 auth_id=1018
X-Original-From: Joel Selvaraj <foss@joelselvaraj.com>
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
Reply-To: foss@joelselvaraj.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Joel Selvaraj <foss@joelselvaraj.com>

My jsfamily.in address is no longer active, switch to my current one.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
 Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
index 80deedc01c7c5..5a7f2ff40fe0e 100644
--- a/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: EBBG FT8719 MIPI-DSI LCD panel
 
 maintainers:
-  - Joel Selvaraj <jo@jsfamily.in>
+  - Joel Selvaraj <foss@joelselvaraj.com>
 
 description: |
   The FT8719 panel from EBBG is a FHD+ LCD display panel with a resolution

-- 
2.55.0


