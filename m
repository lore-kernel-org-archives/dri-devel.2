Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE071606A333
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoOsPABh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E4710F249;
	Mon, 16 Nov 2026 15:11:10 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068BC10F04F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:48 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c50604721c8so578647066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841846; x=1795446646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RasVRzt5BSAwU9nANSyfsH3MNXe+l8Z8yVQSBiyQGz8=;
 b=FoOsPABhC2Zn8Nk4pRhtTVkuRF/Wn1qv0SZluP0BHDdMQQBmictq4jJtd20/KBzyh0
 ojvmribG6r+AktfVHW4Fe5pE1yHS1G7STwkfKCGXqz1J6QmBOpI3IPpmijHFUFDu8ehk
 SL4Tzx0/FFi27p08uQCo8qSvByNUChGe6PIhaUKEWB4IEj8brwSN1cm0v8D9urIUfZlv
 5cPBxxmck6gw4NH21+6BWDerrHdW9xYg+X3PwCN2lCWW4rh2NInvT0X/Z+mnb+5xFK0t
 tEvCINeOdBfBJLpq7Cl4MoYSgW1B8RgYQD6oS/HANBWfXfu78E9rKw8lOVOqXLCV0YkM
 xegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841846; x=1795446646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RasVRzt5BSAwU9nANSyfsH3MNXe+l8Z8yVQSBiyQGz8=;
 b=2ZtWNBh0EHXg57dMSB0zkUpwJ8+8/qJ9YIuq7Lu4nUh18qVZPfjar3BVjTXw/1h5Ns
 4Rh9C4elmtGEf1NbAT8XmvmWM0g0ii7dFXPN+MFJ1aRYj/PqnU94D1yLaxqkHwIRKtiu
 jDk/aTbmwpEMZ3zcZS4bYpcqMdXndRkH6SbdEMVbkPCc3pwVScvKb32WFEY8J1dzjh24
 4vDrTLLewhKTtdvyWgzl1OvTR2eC6St/np279vOoSXCbSCfX5R9LZAvK+T4Tg8cRQ0Je
 7Mch5V2g7GU4Bg72EBo9q6FPeTorDM7GhM1VM/u/GSRwZIlPOgn73Zm6hLAhy/PrK6rE
 JqJA==
X-Gm-Message-State: APuU4Z8/fKnllVH2aP7ojxkb6ipv5PknfnkoHmKq9eSj4gSfcampjpXY
 wQGOnyiVhhopMiUAMPj7X9DcpTwRCjKXMw33YE143HB5AT7S5b7bMcpr
X-Gm-Gg: AYBFou3U7snXxt3hO5/WqEUn3a2Evwxwd5PFYqwx9sV9InGjj6FUSN58giExZBBxVjN
 za5CeZjfNGH9f4hK6uas3RMCjJzBEQ2YgwYZRS3zKpaH16qUBqKGJ/mk6JRhg2UFsneyWrTgpgr
 afGb/z2KHpDNPrUttyUWO1rh5iakuuyq6hEs2CvWLAY5b7PKhIJpI2VZNUgO1kzRTRdLKHrgmBL
 cyqhpemi1rUQ18RE3TojvuZ/OTPVk47vawHyRXqMQcZf4Ze5oRR5rlC4TSTzcxZjXtmtn68ENpF
 LbCyplwvqVxClaujPCGbvYxSRbngfnMLUnW0BBdEWod3IsZkqYCayLO9rFemLvEY9MSP3NByVJj
 YZCxd9+Hxu3sGDRFVr0EKzGFF35R76L/J+6Mrpu8dVMM7ZayuUyTVhlgF5/1GtRnX97cOy5EBx5
 7EzKcpjiNeD3PskOY7cA8VgoJRCRBbTBo9eFbfSZDgxmtBLrYO75J3+96dcphypYo3eMRIk9TmY
 Cm8Zwz8+JovG+xMMNrQpwzmDOC3vwi65+bhR7zQk+A7X9kus3sPq+30SIZfcygljqqC9/P0oC4y
 +VIxyNguz2Thp/aRTqTWCiUfbsnuxci8pPzrGojmUKKo/JzMtPJ+JhoQ0+FlRfCPYDFA13/wLXo
 KZ3RjFHFnuQ==
X-Received: by 2002:a17:906:7955:b0:c37:8c7c:a840 with SMTP id
 a640c23a62f3a-c50963aeccamr886718566b.18.1794841846300; 
 Mon, 16 Nov 2026 07:10:46 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:45 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] dt-bindings: display: tegra: Document Tegra20 DSI
 port
Date: Mon, 16 Nov 2026 17:10:12 +0200
Message-ID: <20261116151017.274764-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the optional port node, which is required for correctly modeling
a dual-mode panel.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-dsi.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
index 59e1dc0813e73..0f4837648d179 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
@@ -83,6 +83,12 @@ properties:
       gang up with in order to support up to 8 data lanes
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  port:
+    description: specifies the connection port for the dual-mode panel
+      and is required only when the panel is operating in dual-mode
+      configuration.
+    $ref: /schemas/graph.yaml#/properties/port
+
 allOf:
   - $ref: ../dsi-controller.yaml#
   - if:
-- 
2.53.0

