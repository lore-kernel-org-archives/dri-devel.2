Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49696606CD39
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6WCBBoa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA3610E247;
	Fri, 20 Nov 2026 18:16:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269B610E087
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:16:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD3E046837;
 Fri, 20 Nov 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795198603;
 b=YsewN1oc9NJj88r+yrxzo9lBxy43+Ike3gZLAkXgcB3Hq4I5/sY+J1jA33sDza+p01L3
 /b2WYV1llfQzFAp1K4pGDuOfzgDF8tdvN8Z9ZBijbzOolzH5ib4jj+57m/Q2VrfDG6/u6
 BuuXwz+zufd0LD/p5QplHKzWR+DlTwYqmeQO3SAawcA1Xei8q5VMH0X6lbvYLIAVJEHrt
 5etG54RLl09BVT4UotsE8ek7CXcxxlXC+lj8U4n1FeDw5w3RIwpEuAK0JowWmHz4ByhQc
 GRXX/OC4bYGNJ+BPO+U5FbOoToBdWXBcPo9d5fiT7BLX+z0OZHFag400R+ofwgNJyuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795198603;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
 b=MkSJczvOKZ43svAg9jpMJzTOnZsq6DlrBC3GkOBWZJZs6kPvB0nRWcFElwC5c79PnLr6
 nXBSeYClasHaY7JHxlZE77I6RCc9rk6hIBQv0wyW99CsclSkoP4BMpx1U88LJd4FBQoLT
 3wujODchD4J/+o4XghnvY5c/TXyeChc8DTc7W2et7i0Wkjnds/K4iFBVrKCNA5kU0f06M
 nMS2QL9UAg4jjipkRJ6clpItvAiarLP0SIjjkbzV93ilvMvKhzvd60Bqa0j6nO5POdIwE
 86GpmppgFvi38bjmy8Z/aYoKrrcSX2JbMwrKzOhiHrPEFLidYjevhJhNIq+1tqf3EVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 150321F000D1;
 Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795198603;
 bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=P6WCBBoaODogK1oiOfyknN0KQhTPIYA3HkXqA28oi7PE2MimBoPK0Jga13YHTS4Am
 UUXWSbsUWQkUeOuxK4r4lQVHTQ/tPJE5BTQcAhjixtGzSyVhZEhhRDLLQKGyyarqri
 reYeyZ9Bekv8lOgw0RQbcs+8Ji2D5BBgp53LqTHvkZEu8tuRoU2scXFo62RGK7/ZuK
 ZPXgVDJJQKyNBIPe9Va1OTfk/wFMFAqeOwiuC4e40vxhIqRFceyD3QpgL17mr9/xoM
 D3V/vl31VYH6LaY+vt0KuP8AJZej+mkrcSQolPoSML/6vjnsmuRU9wiorYEQ1iKG0a
 GUuEZUwrmEBQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 966B24B8E9;
 Fri, 20 Nov 2026 18:16:32 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:40 +0100
Subject: [PATCH v2 01/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Fix compatible matching in conditionals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-1-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=PVKFWIK5TVZ+BrIG2D/sPckomoO1CwEMBpgyzjwKon8=;
 b=kA0DAAoWKo0VA3vnMSIByyZiAGsAjl2gc+A73nw8nDiss0yhR7CCqM5seJvXwnFgTmkdi9zrG
 Ih1BAAWCgAdFiEEj505yO7Txcz1vCdkKo0VA3vnMSIFAmsAjl0ACgkQKo0VA3vnMSIbmgEA419l
 Bi3BwNS582iiCOSxaCIK1FyUDQq43Mu3N1MNqMwBAKyL4iW/6R2TxR5maW4SjF7i00AcnjWDoMk
 1yIbJO0IM
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
2.56.1


