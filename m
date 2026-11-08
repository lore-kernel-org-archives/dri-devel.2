Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECE606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=jWTYr9CX;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PIT8mGoj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E446C10E38B;
	Sun,  8 Nov 2026 07:06:31 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABE210E38B
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:06:20 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 530771D000D0
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:01:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 02:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121272; x=
 1794207672; bh=N+9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=j
 WTYr9CXKRMZA1fvfN024XTZVHx1alJUmb/r59yzvhmrIk5g5g+6yvlFBpnZAuynU
 Nsad/BX5di33btUisIHPRcD3pUuwrrMhWkyaPA2uQiVsQTWhGqGwPkiSrY30DUO4
 p2lSTeG6ZzZh8zdd/TN4qPllskzUm9NQW2FODVOBfKq7P7Wz38blMTjCi4D+0zf0
 oArLYVd3I/WLgWTsjpu9Is0sjiUzkr7p7LNh8lqLWs8mWm5bWyU84IeGQnxzQ4J+
 nMUAAEOEM0/9rZgiCjUqkg4jj8V/eLZEkE6ejQiFQ+8Zrc0pO1tCujPsMAepiQe+
 0okDOcc4lAzdgmgmR7MzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121272; x=1794207672; bh=N
 +9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=PIT8mGojCfuQl9Pim
 of47EwlTMrH/f60cKunt9+JhQLiFY/tHOa0ovoV+R+FBzI6t9un3olX+snR5wR9Q
 czGDzoioHyd5/joC6OuLGzQlqTKqLSaAWV4tQ2MiahYZ4ADs9vG//bY1kqTAonhV
 q1278qMJN2CBxzd4QfDR6fTwnoiowzLKz+tsJGc5vDG1v3+pdzbstth3yzYmhiiD
 Or2/LHHV42xBlff9LWlKFU2I48V17Rt3VwHV4UyH33VHnaZ+0IwbJooDJkpA5/+b
 XJ8srtCM97k5PS9VjXWBRJkLDkcZ/k9p402GYkPY1xJ7Dp9TX2398gGJJMZf+Cdy
 EhCEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121272; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:V1YSq7dg5acapicEgXHXNDu0UwMK0t12qpiCA2QEhqcB6K9
 5Z5trmvIPJ7vRBBFTrRIJqk9YPAz3JotZeEAu1CG7tYRXTrfonpyYMkjLVLuwfRo
 3YJUD6h5X98Qx+TtS9etHKUdZ0nneVSnwowkv0TrGRvhQGXgwr+5A4HYHbiuFSeL
 LdrxxztqGep64c3x7F2d2pdZkXKE6WHDKn/0QDWNkYxnF31wlc4xSoY5kJ4/CqO+
 1eZ+8iaGEVkQ3mYL/iJF888S/4urHhCYEA041c55Tvu+2yco5LiI3PNGqFQFGGP6
 CCNUBAQv+7Pzle1RZpTRQ8gG6iKxdxQf4MsipKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1scFNwGuSYAYmAUwATI7ZJpUkxc2rI1XTCtVvC2JBFc=:E3QG1wpL1G3f8pPSmRg3P12/DKKK+lX4bpFVJJLsfbA=;
X-ME-Sender: <xms:Nx7wau8rXRV4f2OYAyfdxkJ7wMn7-FdvY6MmC7S4e3AY1zju61Cx-Q>
 <xme:Nx7waljUmDQEAAhdwNbHCBJ2r_QwUKtlXgJqNRWdAWGH2yS0h2KPAl2jAwDCR3cAu
 xlJstJdPsU2nM0pM6dHfHQG8pjDaumgA13kG5Sd5CtOWRYcsl59Uzk8>
X-ME-Received: <xmr:Nx7was8Ph6I-VgPqFNKMt2DER1_msVA-kiIFQjnv61MILVXusLc0xuuG3BdSxwWdE7YEu3SL>
X-ME-Proxy-Cause: dmFkZTGHsXxMaNMeFsRAYE+UNc2kpKTKBlmHNoeCpbjkaXBLqGWJuCPijPHPf+fPBOcL1e
 uJGqqoK8MabTfiMBZreujYrV+d+F5ZTA03trv5m4PBpbM2Rx88koviOciFZVud6RbtQ5y7
 aim1Oox9V5+z7Yx9Z0/gxPvGVuv48JVZMf/qHlBPaTlrPus2HUH85oS54uVXp46ALFvR2y
 KMVaHY4Ac7iOkw4xPwvFFJ2eSzLlA/UhQN00EZND9KeNyVoMyC35caaXutb0fAUo04DTM0
 W6UfgoQgWgCa6rIrWkrZYFfMWG/I8W0tygWQKfbX0rUrNO6ZQmLvI/XRj5DdZi86n5KqAl
 lHnzGyyHgMgeGnu+Qd42X34ltprILrbvo5Tf9pou/FpS3LQ9aqrwQu97TgtXOdnVMdijcf
 lO/fmyaA8CCcDen31l3Kv4yt+pFsMSbVga+MOhzdTfOVWSpDQ8xhblXAYS69uGgMt1PW8T
 ce4kEKiAq0yU4LhDYNOUU1/paGWkY69rdok7TkKJRpE7ZDu5LjMCg8mkR72ubfNWuy06hv
 M+APEvibJRQRY091gdEuAbbecGbpXEKGMfjaL52kE/J9QpdlyyBvASFfHb8P3F/Sni5JBM
 njcU0ZL2Uwcfr7RdXS+aRLjcu2oDINtFSoy2ss6M1QbgtFeGeBCITPP/ltQQ
X-ME-Proxy: <xmx:Nx7wapSAi7g0AJpZDY65n6HGQeaQR697BSPlMP51sf5grZb0Wy7WkQ>
 <xmx:Nx7wanc6C-koyJW1O7vkF4eCqZrXiy8qRmb1c4kMfl4VhCkHLPv9Nw>
 <xmx:Nx7wavE28cpUrzeS6v3FwQvGmyLXTMBb0UknpeYX9L_MdzQTOcIVkg>
 <xmx:Nx7walIn_c4ebM54b8KtT_2IhJ8KKc0g1vm6_XHiLRtCgL0wvskgUQ>
 <xmx:OB7walM5ERiwyiiehSQCUm-NQEcGe4-91fpFVVFi0-owGMoFdj1nmTOr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:02 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v16 06/16] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Sun,  8 Nov 2026 19:59:07 +1300
Message-ID: <20261108065917.135194-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RK3576 and the RK3588 use the same NPU block, with different hardware
resources.

The RK3576 has two cores. Each core needs six clocks, two more than the
RK3588 (aclk_cbuf and hclk_cbuf), needs only one reset, and has no
sram-supply.

Define the requirements of each SoC in allOf. The RK3588 still requires
sram-supply.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd..2eb9337819e6 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -33,14 +34,18 @@ properties:
       - const: core # Main NPU core processing unit registers
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   interrupts:
     maxItems: 1
@@ -54,9 +59,11 @@ properties:
     maxItems: 1
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ -75,7 +82,36 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+      required:
+        - sram-supply
+    else:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

