Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B629606A896
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=hmFJBlo1;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=02oCrzVs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB2110E1EA;
	Sat, 14 Nov 2026 03:06:59 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B50E10E1EA
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:06:48 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.phl.internal (Postfix) with ESMTP id 9B3801381A42
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:06:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 22:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625607; x=
 1794632807; bh=N+9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=h
 mFJBlo1z252QPnZhveWFXdEwvah8nHxZD86blxjM2ZZOV8D1MY9ZFxAcYdDNWPKD
 lrVlltL4N0t8k/kI1zgDn79W2OaPHUjuM0PantmGbC7KZk1g08lWmoBvyGYgPSZ5
 wILqZPLZzXUq2OUwRGWW4IFn/L5ysj9NyQnlNVMd9KISPn8lwaY5V2gd7iQkqZWF
 h5Vl/rEfLQu9pTtWHqrTRVpE2xvexSw05G3QpssqXsZQL6DI1lUl+UiSZOTpqTxx
 Mq7RZsA4CMhQT67fc7PGBFQcp1EydmdUhA0ICdhxhP0QFM0tjNvfXnlL5GuRa/pE
 yP7+IukD01isOeasRU84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625607; x=1794632807; bh=N
 +9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=02oCrzVsPHFU0PiH8
 woZAbQuY5YOEAqPsWc6K167EgqRbUCrrWVBKj8k73THjgy9qwEKrhVjZtWOPoPw3
 0zu7PhBN9+qmHgTQY4/U/loWisUeVU3Cwed+Zam3wrbZEX07q3h6tFZqWinRj40y
 XnlPeoosVDhEtnx6PKor9Dau39xZ/7KmNsTmg1IaCMs+m+BNVm8tK+IvTG1O9Vht
 dSDgyaa9eVTulk2vjzPdiV4Tyj/hcp7HEQc3Og7naFtdIkyjnhPPPzJGqTOhcbMc
 dbtIF61k+fo/dwzKNaOycvwNJjZNP26BnTy3NxLan/PK0FtMSh+UDfPLfCRr2zXb
 kSV2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625607; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:i5JDK9XXOldMMfM3yTBcNjbl5y7TwbFW6k6dPa/RHR3S2JE
 zqWhDFODmH9sWlsNbjg0acKJ3KQzouamD7x4mhzs8MclasdnP47CxUr0NU91t4Cu
 SsmDxSP1xT6cp7XFaze9XcJDMgrmZCx8pHphTX/k9STslvkFVjcYRieLFRsTLxsQ
 f+rCL+ZeJFAHYbUJ3QceLJLqCnGXXJ97mUhBnlSDfsxhXNB03GeozOGpAPgPg/JU
 jNYTj19G+BX147dPQIp7yNABmJ+xAq0cMRv7WwqnxP7b8ilyZQFlB6480cTxADQ8
 fM0MH6qA2oq+VyAO8j2OU+Wtv0qWuWDAhk85IeA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:G0rMrLQgBxn4OAvwTRlSphgqx9ONQzzqiiQi5Btpnrg=:E3QG1wpL1G3f8pPSmRg3P12/DKKK+lX4bpFVJJLsfbA=;
X-ME-Sender: <xms:R9D3ao4GXcVrBtILyChglSVcmY-nwVOlE2UZAOotYsYxYlP-NrrZaQ>
 <xme:R9D3amCpRdbEJTU-BU0RfXPxqr0kRdfZe5MD4TkundRlTk10xlrNHkfiNsTlRsZfZ
 7ac8hlcXjdX1snS99bjCHWj_ECEpl3jGtQIxMhPUyeHFC51k6d7UWcZ>
X-ME-Received: <xmr:R9D3agt6qvPfKvr8UPxiW5Ni1XCm7nSxgKCMumkJZ7Y-PYFFrhElxE3qCwFk_MHKts6p6QKx>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
 q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
 QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
 L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
 RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++UMJ
 HNGti+0chsjtgHUFHERda/e1esdxvF/MLapAIbUuAA8i/5FCjBkAcw5N369Zb1h1zT9bJ5
 6m7RBUUXtquxt0RqeHkHOekFzPQ77KqUX4LxLzfAJN6IjAPwHnrvYt1MpX9r/enJ2nOEql
 bVS6HYaFJdTO5LnsW/AjFKyK0zv1VoUA5EtHmfilWRIc6TWsAZHvV6/FKjBUFjB34AyCqV
 As7v0V2ObOmVe8tSCaESH6Uh0AXx7IsFxmAIh94XZFQD2nV6GGyw+HfzGwCwltht78VCM/
 NeqYAotcOPiXJvEbQzwmLaKDYwUt1GYeDCnzXCwXhJU+QCtmjewixHGi/suQ
X-ME-Proxy: <xmx:R9D3asM9Q0m49OQPHsJ7heQWwbeqZlQW2FOL6veyn0aSVqa8lP8C0A>
 <xmx:R9D3agV1YvvBbE7Ef3wX4DvRZdJTVBP5fqdZLnNznZb5xe4P7q3ZMg>
 <xmx:R9D3avRFjImoTT6eWnfx8DGeVfZzMGP7WaiVqUfFW1Lki2nsVgRZvQ>
 <xmx:R9D3aoaDTU4LJunbR6TnjFVryxsIxtLqyJAoELuSVbP-v41H14Y1UA>
 <xmx:R9D3agw4r_dvEpyT0t3EpwPTpr23kA2D80R1Sz_25EalAwRsI1xvvFD4>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:06:38 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 06/12] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Sat, 14 Nov 2026 16:05:23 +1300
Message-ID: <381d2bc99486ca312e1d02f482eccd37def29831.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
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

