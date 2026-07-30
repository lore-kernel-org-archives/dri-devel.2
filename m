Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19286C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E2C10E07C;
	Thu, 30 Jul 2026 21:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m9c7vw7Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F35A10F0B4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B6F343EBC;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCBFC2BCF7;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785448337;
 bh=N364PIoVWuH6cDGXXPM9/j7iB6vbHjElNnY5IAQZcD4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=m9c7vw7Q4Q512J7Q+jBGFt6kwIbQtXjnlt6xzaE5MP3RFkF0A/UlFh6XWEfVYCYjm
 bk8qZXqDWCnQTALeaJ1ikuwLXTm+GqK7gk8/iXrXnq5oOBz6VRZKkW8cyW8QJ6Zuoc
 aM3spqQT+BIKrxTSJ4eWUJw/Arfi4BwBQ1gq13hS2DKqwZrM1jR16LPj/6t61d7+v2
 68sICCxhxEzl6uXvZVacGZqm7kytkkuHV1tfi/p+VoyuUMKPRUt2+18H0wQhKWg82F
 dq4iTfkz/37EE+gw1KWfb76L9jll5yHK0Wb6W+gQYUrUgeFn0hqOb6dDjtAOLTt14O
 UM+S2SUMEWBGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EE74AC55162;
 Thu, 30 Jul 2026 21:52:16 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Thu, 30 Jul 2026 23:52:00 +0200
Subject: [PATCH 1/4] dt-bindings: display: panel: novatek,nt36523: add the
 Mi Pad 5 Pro 5G panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-sm8250-xiaomi-enuma-v1-1-ed6d8fb99668@dawidwrobel.com>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=HLBHIFL7Bhy2H/xHi+CSj5nPkTSnPI1C32w3QZKtKr8=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWRlH++XM91l8LFvVpKjuqHynx+HStJ/Lny+Z8+7fU6nC
 vL3X2ON6ChlYRDjYpAVU2TRSwvaYxX88vu7F7/DYeawMoEMYeDiFICJqGow/OGfLPUuN9Fijcmd
 b1fNm3xv3vi+2bn7YKj31/yLUf90S94z/NMu43G/+q5zqffCggP3zH+UO1zh+8ARZxR26Pz5fHH
 WgwwA
X-Developer-Key: i=me@dawidwrobel.com; a=openpgp;
 fpr=B64A778E0E64049A70C831C8B7B81FA12B282A92
X-Endpoint-Received: by B4 Relay for me@dawidwrobel.com/default with
 auth_id=901
X-Original-From: =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
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
Reply-To: me@dawidwrobel.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Dawid Wróbel <me@dawidwrobel.com>

The Xiaomi Mi Pad 5 Pro 5G (enuma) ships the same CSOT panel as the Mi
Pad 5 Pro (elish), so it falls back to the elish compatible. Give it a
device-specific one in front, so a later difference does not need a
device tree change.

Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index b9300a1f2646..2f3f34d08f29 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -22,6 +22,10 @@ properties:
               - xiaomi,elish-boe-nt36523
               - xiaomi,elish-csot-nt36523
           - const: novatek,nt36523
+      - items:
+          - const: xiaomi,enuma-csot-nt36523
+          - const: xiaomi,elish-csot-nt36523
+          - const: novatek,nt36523
       - items:
           - enum:
               - lenovo,j606f-boe-nt36523w

-- 
2.55.0


