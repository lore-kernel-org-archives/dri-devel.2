Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C88606A324
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koy7EHnX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15BC10FAFE;
	Wed, 28 Oct 2026 09:52:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5D610FAFE
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8540940785;
 Wed, 28 Oct 2026 09:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85751F01825;
 Wed, 28 Oct 2026 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181132;
 bh=wwlPlgPGmdzUnY9DyWcVDvc91PU4r5RUUdi9kkWGnN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=koy7EHnXpZjBQMfDksFXDcrAJDmNwN9sWdStt4BoFRIHpqA0UMjJAWAOf06n/245k
 VAg8oJaion9xMRPdx5sTn7oqUsot8hH8lsnulAOheoj5Y9/yzEc66NHGbjvAji5WWG
 BIiCPG3NDS4p6Wcw6nbWJ66N5klsJNgtbJjwGWRJ/d5fP/oIH3fN+MGCvj2+LOQMkC
 k5PUQnZ4ZOfBt4/CsRHHulxeYbPmDsar394PGPQLLKIdOqlENY4z3xtwilmj9evlq6
 yyGSo8vVE3n7NS13aoXmBqPthojc7RtOzCXPUZxFehV6G72SJEcETpt4hW8HCbTVXN
 jg15Szgg+onJA==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: display: panel: novatek,
 nt36672e: Document the reset GPIO polarity
Date: Wed, 28 Oct 2026 11:51:44 +0200
Message-ID: <20261028095151.1682096-2-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028095151.1682096-1-vz@kernel.org>
References: <20261028095151.1682096-1-vz@kernel.org>
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

The reset GPIO of NT36672E panels has been described as active high since
the binding was added, also see the example and the QCM6490 IDP board
device tree, however actually it serves as the active low signal, also
panel-common.yaml expects active low reset GPIOs to be described as such.

Document the active high description of the reset GPIO explicitly as
the exceptional deviation from the actual signal polarity, any new devices
will use it in the same way as the existing ones.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../bindings/display/panel/novatek,nt36672e.yaml         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
index dc4672f3d01d..45743376995b 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
@@ -24,7 +24,14 @@ properties:
   avdd-supply: true
   avee-supply: true
   port: true
-  reset-gpios: true
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the reset pin of the panel. The GPIO must be described
+      as active high (GPIO_ACTIVE_HIGH), the asserted state releases the panel
+      from reset. Note that the RESET_N pin is in fact an active low signal,
+      the inverted description is kept for compatibility with existing device
+      trees, while it deviates from the convention of panel-common.yaml.
   backlight: true
 
 required:
-- 
2.51.0

