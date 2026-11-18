Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6447606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE9910FCCE;
	Wed, 18 Nov 2026 13:47:16 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358B110F89F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:47:46 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36caa19b0ffso264209eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995265; x=1795600065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CbDs64JMZjyf/45RioLIm4bTkzQSeHkjB9Cgx05r3SY=;
 b=gqYLZGTemtauJY0JRj0px++mqlqEI5AC4uwHF1mtQ+zTiVY2kKr+tbs1LJe4+oUlzm
 J1Q5o5Kti3GrtnUFerv1437vL4LG1clbqQkfjMFi4HgPDFlDKBvY6Cuk1cnhmM3RYxpA
 vMbtU5ZlMR72BqCtU2lPFp8UZMp20wlCqZAGf00c0SoqZz5yko4qni1nYost9EGKsjPq
 57BD20oRRKT4tIueiWNWNYrRbCxExSLe+ksxyV103olVVXUz02L4I8Nrg4lkB7OEXbax
 X7aKnaCBTXmI8rxnUMm4I4lgrsaH1xACLaitErer4Fmv0NLOcldkajwbaot7W/gyOsAg
 oo+g==
X-Gm-Message-State: APuU4Z9Ra5TsCwjdqlSfSpTayA2DnF67gRpJaeyXs/WB1jhqaD0SOUi4
 BdJFM1W/XLciGS7I1DW4RjNuZC5Xl0a8XIzctz+hBhSQQznE64YUmAeC
X-Gm-Gg: AYBFou27h9/lLmgyY/WLwDumb57i4nctwVmXDZXhc+SU4OO+5PhsQ+gzhmXtp4/VYYj
 P+u+K0mPz1loa/VIMzzO4N8yS1RJdnIYZ4UyR5yfvjcB8YrRvuJk+QYGw8PAlxmZBYpxP4HJt82
 vXw9V/Htc1LPRatkbplB6C9atNRmVPIK6XYMA02dvLDVS4/gQYd7emQU7awxiK3L51gKnylGNzN
 VEO3z/hRocOrk0lYFkxlkdG9ylhzD3xkdz4pfOA2KKtj2bQXTA/x02jvYDx+W+bAdGqzl3PhJvM
 XHB79oKvc0xzQTAFyV1zTMHHotWvQgNkdOMmqYO5c9ge3fSdGK1Jwfe7DeErovSzjVExjb2DmuK
 vBwjH2jVmkS1POKZL56QwcokxV7kuNoAXRJRhsDTPeGpeuIP80Q8kbi8CxAg9qxKu7wDpZD9viM
 t06wgcsTgr01eperSyLbhmujogy1GUcI0X+MgLS57A3zxgZiRqnIwtwpl4kKthJNT7VxcXnbKpu
 EsciDOuHnV9zuGz393Xmcg3Qtd5K9YHs4EVSvWawccYGdEo7y2sxUNjfopQzmVV0qIhP7ftDh7P
 qT7dKCA62fHPFXaUvFNYaoYv7xVj9JiQqQJZSA4zDerOS7I=
X-Received: by 2002:a05:701b:21c5:b0:19d:6484:869f with SMTP id
 a92af1059eb24-1b543d09abfmr1957614c88.7.1794995265224; 
 Wed, 18 Nov 2026 01:47:45 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784017sm5326510c88.4.2026.11.18.01.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:47:44 -0800 (PST)
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: ilitek,
 ili9881c: add Industio Purple Pi OH panel
Date: Wed, 18 Nov 2026 17:47:19 +0800
Message-ID: <20261118094720.110127-3-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118094720.110127-1-147148383@qq.com>
References: <20261118094720.110127-1-147148383@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Purple Pi OH is shipped with an ILI9881C based 800x1280 MIPI-DSI
panel.  The module is marked ZC-700010BH and has a 94x151 mm active
area; the vendor device tree only describes it as a generic
"simple-panel-dsi", so no panel-vendor compatible is known.  Add a
board-specific compatible with ilitek,ili9881c as the fallback.

Signed-off-by: pjh456 <147148383@qq.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 42e35986fbf6..cafa85aaefbb 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -20,6 +20,7 @@ properties:
           - bananapi,lhr050h41
           - bestar,bsd1218-a101kl68
           - feixin,k101-im2byl02
+          - industio,purple-pi-oh-panel
           - raspberrypi,dsi-5inch
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
-- 
2.56.1

