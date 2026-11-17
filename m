Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D59606BD8C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuE/NPpm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5F310F8DB;
	Tue, 17 Nov 2026 19:33:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6A310F8D8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17800409D2;
 Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944015;
 b=vY8WuBodXDcU+B42H6RWJWY3svgZ/F8F1qn3bqbQ8lMv4HaavagL2riskuKa8k7FBVHF
 FBIE4idypg44ZSeQSzAf8k+3LO5eyaS4Bh4PxlxYKc4RehXdlZ/PYsgyZuKbO9Nk82Lfa
 1Np8cQYc1JKO7mu0Ik2nY6cRg53H3zZMjZf09ktPbU3TY8+yPQAizyD9tORktiH84Nfbr
 5264w7q8SbGnnwjHJFe87tuH/Q6d9M9fyoBKDkiBH9yww431koyWJALvO1MYsVMRjOynA
 EcZLz5tprafJP7JiNzEYrP63Pm2LLj14wScziXTyG6QoF/+sijzqi16D36JJXn5k2MQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944015;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=pi02oACzfdxXr2T3FmhOigKXGph09mYpGwByVOMN+iA=;
 b=pNN1YMvPW0xCdAoMXIPvf8B4s0hMFNxOTKqABF2WR5ZgwodBZzC0CLZo20Sflbv2S85l
 rpfRssT4qE6xXqi/DPYo83RMAuj/UXt6L6LV41FkkewyJ7dGbz8FBASR3BmQYvyIEglYq
 LwxrteJI14b37zWe8t4aQs50o23dzhJKuOa42iu1pIBlllAo3SnjS/3cNOCRtDN9dsYar
 X1CIRGgIF42GSfvzSpA1XfkecxgQ+Vg4J+w6woEo1FlNATw/so93DGyCKke/07uNtrIIv
 wKHwIMwv4CZs31A/tkh2ohXCRC8fupIEPVFjBbfIaZfbYEF5GvKPIez5CjGks5Aj2xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 52F2B1F000C5;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944014;
 bh=pi02oACzfdxXr2T3FmhOigKXGph09mYpGwByVOMN+iA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=EuE/NPpm0JbsCfiQB4W8YZN/Zqr6e+/6FKO1NgP/WspzEc/M6pBDiVitgnJE5grc5
 lhiBvf/W0GbvfeRQZpKDPcQZ7Fglnzy32VCDHxRVE+DGhx1QFJ+FjPbP7ggMOXXdZV
 y+Eu1c0I7BFK92bFFWnjjBHxaNJC7WSw0IImVtaTXlJ8nd8sE8KTnD9Q5Ml277RqRc
 CFHckku0k+qFaWKDM5NTG525UEYt/ugQY2hJBshSPtwc0BoU+tCP4hv3e4iTxjUNvS
 //HuefQ2wevv0Q1Skw2uQ7vX6kQTS4yWxXRn7Pc3KxP5lmzcJR7XvAw+cdlLQHKA6h
 TgkRZ0BZEYRAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CE16C4AA76;
 Tue, 17 Nov 2026 19:33:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:06 +0100
Subject: [PATCH 01/10] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix
 compatible matching in conditionals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-1-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=x0gAaIsGyNXcvLzc+ccXQ6Xun/9RxOJpIfK6iHxxYkw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9af1X+FP0QstiwV5zUz3THZc8LbKLuUecJZs17bBPDtt
 jdNOP69o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiIzztGhnk3lXjfneNo9WAt
 0BE5uk7sseMrM85F8bL2agZvXRocfBgZ/hvdlCzYsenNohvTX6/3Z3ZXvKYwYYqhdDLr4T/zer8
 dYwIA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Content-Transfer-Encoding: 7bit
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
Reply-To: linux-kernel-dev@aliel.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The conditional schemas select on "compatible" with a bare enum. On a
list such as:

  compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";

an enum applied to the whole array only matches single-entry lists, so
the if: blocks never match as intended and the per-variant constraints
are not applied reliably.

Wrap the enums in "contains" so that the conditions match on any entry
of the compatible list.

Doing so exposes the "phy" child node of "amlogic,meson-gx-hhi-sysctrl":
it was forbidden (phy: false), but some DT legitimately describe an
"amlogic,g12a-mipi-dphy-analog" PHY node under this system controller,
which resulted in dtbs_check warnings such as:

  system-controller@0 (amlogic,meson-gx-hhi-sysctrl): False schema does
  not allow {'compatible': ['amlogic,g12a-mipi-dphy-analog'],
  '#phy-cells': 0, ...}

Allow the phy child node for amlogic,meson-gx-hhi-sysctrl by referencing
the amlogic,g12a-mipi-dphy-analog binding instead of rejecting it.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 32 +++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index f3a85c67ce8a..285edac4c082 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -40,8 +40,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -53,9 +54,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -67,9 +69,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-ao-sysctrl
-            - amlogic,meson-axg-ao-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-ao-sysctrl
+              - amlogic,meson-axg-ao-sysctrl
     then:
       properties:
         clock-controller:
@@ -81,17 +84,20 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
     then:
       properties:
-        phy: false
+        phy:
+          $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
 
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         phy:

-- 
2.43.0


