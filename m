Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF4C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6645510F0B9;
	Thu, 30 Jul 2026 21:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vCdyzIgC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5FC10F0B6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:52:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 882B66011F;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BD63C2BCF4;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785448337;
 bh=7rEhVxZ7nNk8sJnrw/sTqbxNnY8YdaxE/JmM+BbsQWg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=vCdyzIgCiiaigU2U0uf/C5OBH4vYqenrcEUQtUoQu5fYlheYtpUqYjiNTciRifU5e
 dmm6NZvzwbET+G5lwD7Pcclg+QGywhFmKd0YE+kq5ek4RrNxD8IJey/0xw8LB+2h4Y
 VXAsrJQaNXVQu84DE18ivleFdKCzIPkBbAxm/mu3BW8NjDhotLZ9+0PAB9KHlseud5
 rA/v5FnMRRhNZwG3fDX1vkXaI7DPthdZcW0Vi7lxctphjfaCuESzytX+gjP9GDxzg1
 m/t6nHTc4AbVNg2CLvwPVvqkw0fVVQESwgRaMkqWkqY6iHvWIre2gek2okSUvJiN5w
 iRRDfKoisVQNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC0C55167;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Thu, 30 Jul 2026 23:52:01 +0200
Subject: [PATCH 2/4] dt-bindings: arm: qcom: add the Xiaomi Mi Pad 5 Pro 5G
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-sm8250-xiaomi-enuma-v1-2-ed6d8fb99668@dawidwrobel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=fLllZL12p66slp7ozlqH9iay8dnPtAgyjBfCTQiWkDo=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWRlH+8/t1D/yb5m883rz0Qq5rJPaOeUEkpTW/e1QnDLZ
 RGGs3kyHaUsDGJcDLJiiix6aUF7rIJffn/34nc4zBxWJpAhDFycAjCRhC2MDFvWqCSJKHr2TV8q
 fEGcm/lw/pkMNac27f1Vuaa3og5+ucLwz9T51qPiUIHzF2OlNnw+3rB7l6zcawn3RSbzH+glZUX
 e4gMA
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

The Mi Pad 5 Pro 5G (enuma) is the modem-equipped variant of the Mi Pad
5 Pro (elish) and shares its board design, so it falls back to the elish
compatible.

Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index f8c37096df46..a19d0146ae4b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1110,6 +1110,11 @@ properties:
               - xiaomi,pipa
           - const: qcom,sm8250
 
+      - items:
+          - const: xiaomi,enuma
+          - const: xiaomi,elish
+          - const: qcom,sm8250
+
       - items:
           - enum:
               - microsoft,surface-duo2

-- 
2.55.0


