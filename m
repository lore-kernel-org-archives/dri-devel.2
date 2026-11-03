Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC5606EEAC
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d135htvX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A894710F4F0;
	Tue,  3 Nov 2026 11:05:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8BA10F4F0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:05:29 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso25540705e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793703928; x=1794308728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2peUJ98OgTSEIArQaXah+YOCOAD/R5kMNJb0El9Mbi0=;
 b=d135htvXcpGQLrRMr2OZxmWCBgmK2U+VG3YcMIBPUq9PA5VWnBqOwlNMr7KPSM7fkJ
 wKj1BneeJJ5+Z1ydwsdubr7dFkhyQv7ipXNAGo4QU4jcF1HgEifnkrBEvLDHVK0YDd5x
 Ur+fWf8VEUw0sC5c4N7cYtVXe2UtN7D1UBBsMNtFFOH/zqikIwjVHFh9LXGfkguC7YOe
 7E8wUUsfXM40mUGI0BObKGWSBBHz+farRSpmXu68l4FEfRJu3cA2MKUKxOFwasIc8fON
 1oGQGge4f0APVlJbxFeN/x3Bg0X1tooP7ZtQpi/+rmD9Fy/0Yj709ePPIcFfe34TSxSv
 LEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703928; x=1794308728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2peUJ98OgTSEIArQaXah+YOCOAD/R5kMNJb0El9Mbi0=;
 b=pozlQjlVUIdIoUjWHTE5YtLHw2woww9NMz37t/78OPeLmU/lbSXfWJo+qA+kVXoRTK
 wQVBnnR29I7yIIk5DV5lx2yvODV6gtsYfv44Qc7YyKO7ZVlicyQf1ZtPVYA1kpBkED6l
 FVFHcW8UYPY34NeETglNONO399RKwwr181V+42QEFImlJ9iN3aDwXtOHDYbkKf/ONTo5
 hTO73FxTDReVRTuKBKlInkglG/b3aHtyQIKPwAr0YSRjnzxsHPLWWDDj+wXur8iBzAXT
 togG10wYFW/aqBAXbXGGokPZIt+hFH7nwFs8t+2OjhZ5IH4fAWkMxHONFe4j0WZzt9xl
 Kt+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1VVUcpewD7l425NRgByVf8umnBxZgO1jXGm+v+qZYSMfTSLcLW08R5NmINl++TBwFZ/EkWnrlnkU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hQTK9VtRAg4sCAAeqJX7bd8fJ8kwb2bofnkmJ4SndedUJ9R/y
 ZCLEEQ0MiuYgfOxRN0Hh4TJBcw3k959tdanJNtTlef1BlfJ568Lqe6Tt
X-Gm-Gg: AYBFou1CHGI8U2De8I5nrYOBIdS3dva2RUZgmPbW56cGF63nnANDFHUDCIFJUrqBSMZ
 6HqMI8Jf/g9+NKTqtu5NH3RmDiTNFn2VX4XyhPgS+MHUUY5BK1ZnpbFRuN+VQOwe2qbtit1oUV1
 b9Lck5FKEST7u2wgyEg4ora9WZBMK7nk4edZTthZjJ6fobvSpIVGNa7nvIS+vcilP31OZ1oUZVm
 7qtdd+Fye0DFZWqstnuCoJX64ZNxJgdEva7iP03xR76nD7nF9i5k9mzMAcQvtOSY+u5wyRTB+mI
 s/cIOO5Y3Eg8L13Fuu4S9KObzjJXhTMaJUugU/4piIhzhs/jBtwWgnaQyAptRdcwnNP0/d16TnF
 11T4awulgngxeAS5KSkFDlAiOxQFlgUB6fCyfn+gviOkwh9xe4xLq+Qg3v/V2cKTk4cenvk732u
 oC8B1sjT2a+9WQFkzoS7i+dcZr7FVgOpcPjRaOJMtR1e6hplKxf0NEdUtiqCLNAIDX8UQKE0N94
 ucQNoSIm33LYe8jAArchQTVCBUQ8e9Co3YA0sGE7XwS7k61kGoeaa4tUnF7xcI0BlOnpWERzJly
 Mnop425w9Sqv3X0ZaVONZ92nTmwpXmdcQLs5J5J70OExWAw/+pHAm7j92G42GL2nFBP52KBKimQ
 +QsyqqpZWzz/jJ5gD+eFysAHCgcvXsj1LdKooBse6W1GJIA==
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4ac18a8911amr292299845e9.34.1793703927676; 
 Tue, 03 Nov 2026 03:05:27 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:14ec:7986:30c8:6bc6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm53218155e9.4.2026.11.03.03.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:05:27 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH 3/4] dt-bindings: display: panel: ilitek,
 ili9488: add the PocketGo S30 panel
Date: Tue,  3 Nov 2026 12:05:23 +0100
Message-ID: <20261103110524.2812831-4-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103110524.2812831-1-romain.tisserand@gmail.com>
References: <20261103110524.2812831-1-romain.tisserand@gmail.com>
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PocketGo S30 handheld has a 320x480 1-lane MIPI-DSI panel built
around an Ilitek ILI9488.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
index 016a573893b7..27f9aaa81582 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - focuslcds,e35gh-i-mw800cb
+          - pocketgo,s30-panel
       - const: ilitek,ili9488
 
   reg:
-- 
2.43.0

