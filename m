Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ECACA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 11:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080DC10E246;
	Sun, 11 Oct 2026 11:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="tA1wBI90";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55C710E13C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9AcE5I7gEPtdZxBUpObkZgMjzsDlSCNMwcB5/AiuMOE=; b=tA1wBI90165XfKNaq+aD5rltDO
 qwqqQCGEdk4SsbgC0VwlfBflKjSABFZGIN1PDplWLB7Z5iRAmoE99hQGoOd1vswVoj53rIp69fFhW
 Q1Kd+nKyRW22cL6rGjEZL3Qv+nXGA2o415m4jUMIDsnRaRDRZgXHlarPod8zl2QYJ7ls=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1xFs8j-0000000GkAI-2l4j; Sun, 11 Oct 2026 14:54:54 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Date: Sun, 11 Oct 2026 14:54:03 +0300
Subject: [PATCH v3 2/9] dt-bindings: vendor-prefixes: Add Shen Chao
 Optoelectronics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-nt36672a-panels-v3-2-9ea238627f8a@minlexx.ru>
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
In-Reply-To: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Shen Chao Optoelectronics Co., Ltd. is a manufacturer of LCD
displays based in Shenzhen. According to description in [1],
the company specializes in the design, R&D, testing, and
manufacturing of TFT-LCD liquid crystal display panels. Its
products are widely used in the 3C electronic display field,
covering a full range of display products including LCD monitors,
laptops, and mobile phones.

[1] https://www.qcc.com/firm/5b0330df7040fba496dbb0bd5723f6be.html

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
v2: correct company name, expand description, add a link
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 7d0efe58d2766..82642bbcd97bd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1523,6 +1523,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shenchao,.*":
+    description: Shen Chao Optoelectronics (Shenzhen) Co., Ltd.
   "^shift,.*":
     description: SHIFT GmbH
   "^shimafuji,.*":

-- 
2.55.0

