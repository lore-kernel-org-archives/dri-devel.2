Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BDFC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B95810E920;
	Tue,  4 Aug 2026 08:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NWo0K3YC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDE810E917
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4607443389;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D720C2BCF4;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785833764;
 bh=HXOiia6kvh0ZrH9ueHxWeVpGai2uVznQFbdZS265ors=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NWo0K3YC+ck9e5IWmXePCzGqIQWQmu2j8ikFVunva71OMYmBbJGWaN3w82CdY6ZTw
 P63nJ8Nlu+SBydItk1GClakx4djzta8QcwVCzKYEHVTMxM4oYA7t16rKYdZzaCujNe
 4sB8XIFP6/o2bFWpk5knvOGv1+zYCuBIUqA1ySsFLan5d4YQre8FstsGeLRHdAwp/r
 D1/5df/yMDVUl+REcM9wKYfiRof+lFVwb91DA9SKcweIycDzWXYRhf84jgoF9jjlCQ
 ZEnSwpRMabpjo4SOIRmz4tEpOick7BOIakkJHdeIr472PwU8A2covHhIquixJkHvcy
 T+fiyiAAXc0vA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F176AC5518F;
 Tue,  4 Aug 2026 08:56:03 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Tue, 04 Aug 2026 10:55:55 +0200
Subject: [PATCH v2 1/3] dt-bindings: display: panel: novatek,nt36523: add
 the Mi Pad 5 Pro 5G panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-sm8250-xiaomi-enuma-v2-1-9dd0486f1155@dawidwrobel.com>
References: <20260804-sm8250-xiaomi-enuma-v2-0-9dd0486f1155@dawidwrobel.com>
In-Reply-To: <20260804-sm8250-xiaomi-enuma-v2-0-9dd0486f1155@dawidwrobel.com>
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
 =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=K3PgfeiNwX67+Qu2eA93ZAIdcx9wFeJuCrMiBI+GtWU=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWQVrlR6e6Ama9rh0Oe/0i/+nJP1sdXy5ap3gUo3knIcb
 SL6jtnJdJSyMIhxMciKKbLopQXtsQp++f3di9/hMHNYmUCGMHBxCsBEYjoYGZp6ZgR/Nn3f96mH
 nfvprfUvPK/xbqnIYw7RcOr0TrJO38/IMKOl+cHdWNUfH3/t2C635sKZ9TwLls+/KriiwGT50cr
 JbzgA
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


