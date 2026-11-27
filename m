Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ODRjKCOG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3169D112845;
	Fri, 27 Nov 2026 08:29:26 +0000 (UTC)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E635A10E3FE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:13:26 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 909534C979;
 Fri, 27 Nov 2026 19:06:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795766815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+4WWMGxQZEZwgmCm5Go6TCy3m3YHuZQuM4Z32rUfXE=;
 b=ODRjKCOG8mpFQk6IQDfrwcfRKrp4wvILiOuH4J9F74evzSwb5hfcIz4XfvDBq6m9YbdYa5
 a+80zMmC1UlgjtpoLfYwCU8xOsXBiB13CIUHlwHPvDofuIM0mjWdbm0V3/RaXwDFN/C8oZ
 hl+D4QbmkvxduyDrWzPDiSbGU8IdIsJVEXfLw7c568UaGVI2431JtpAIo+wsFtpRiWumzQ
 yyaE+GXf3XAuRx7OlkkIYVgpq+bP1ShPfQ5Vx9x6VZ1cWEBJYzJS9tMwmWI6tDERyifZDK
 Bn3ZPZFI1LR3AdQQr9A5y5h0XDxgzrkupigLw1O+dE+2NOdz2JMnE6eZgRJ5gw==
X-GPT-Reason: This is a legitimate personal/professional communication.
 The content is a technical patch submission (Linux kernel style)
 for a display driver, which aligns perfectly with the personal
 mailbox (alastair@d-silva.org) and the sender's identity
 (alastair@d-silva.org). There are no phishing indicators, no urgent
 scare tactics, and the message lacks any marketing or malicious
 links.
From: Alastair D'Silva <alastair@d-silva.org>
To: Hans de Goede <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 1/3] dt-bindings: display: simple-framebuffer: Add Allwinner
 DE3.5 HDMI pipeline
Date: Fri, 27 Nov 2026 19:06:47 +1100
Message-ID: <20261127080649.1982883-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127080649.1982883-1-alastair@d-silva.org>
References: <20261127080649.1982883-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the de0-tcon-tv0-hdmi pipeline for Allwinner A733 DE3.5 HDMI output.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index c627ec088434..350cb075f055 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -131,6 +131,7 @@ properties:
   allwinner,pipeline:
     description: Pipeline used by the framebuffer on Allwinner SoCs
     enum:
+      - de0-tcon-tv0-hdmi
       - de_be0-lcd0
       - de_be0-lcd0-hdmi
       - de_be0-lcd0-tve0
-- 
2.53.0

