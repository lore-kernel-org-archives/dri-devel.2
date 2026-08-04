Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3793C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379B410E917;
	Tue,  4 Aug 2026 08:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcvouOnn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE7D10E91B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A3A3434D5;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D0A2C2BCF7;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785833764;
 bh=/qCplaRm989TtzwzIBzQPJl8+Gzjt2gzMB/hddzhOEg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bcvouOnnpxVMwiDNnpkHEr8DtAS4N6kMo8eCVqCQjBvq0nQvn7jsoRwDXVnOIfD+A
 6UPDoLLZg2eEihYzkOmcZCyVS3jDl5pin13zh5dFOOmHQvkuoMqTUigAFQU7fG/iIT
 atGrrwlPcRMQYvW18x1iNLPHg5EUJTR0aziY28++3aDg7JD6aAIEXyBnlw+fEGzMWn
 fMT+TBbOEDV7PkAFUM9sbYgaXDNk0XwuCIfJ/GQDjCzvL6keCyejQs2VcnlKfwurm0
 CBMqeDLSf0F2UDNjkcsoQWRuDy4bHXPAU6fxUSVlC56xnMZ3v4yBImPjqq6hYQx5yx
 cBy4yCKNTWm7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA06C55ABA;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Tue, 04 Aug 2026 10:55:56 +0200
Subject: [PATCH v2 2/3] dt-bindings: arm: qcom: add the Xiaomi Mi Pad 5 Pro 5G
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-sm8250-xiaomi-enuma-v2-2-9dd0486f1155@dawidwrobel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=VKOKUifl/qc4XSjPi5WUGY6k+HMU1nN0lqDnr/zWX4M=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWQVrlT6z7Di4eo7a8Mlwle+Wn/WeKfN/s2MT29avZI6H
 1m+sbTlekcpC4MYF4OsmCKLXlrQHqvgl9/fvfgdDjOHlQlkCAMXpwBMpE2T4X96f0JCm2qHxs9D
 y8T3dTGub9iU4fvXde9h/bWRPyZeMnNnZHh11Gnx5F2O4Ycur32Vaha7b+57/gst61/NMqzkXbW
 xqYALAA==
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


