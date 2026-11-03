Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D80606EE9F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnHwT8Oo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8D810F4F8;
	Tue,  3 Nov 2026 11:05:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CAE10E7EE
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:05:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso35676425e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793703927; x=1794308727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h5PxuAlAW6HHJw+w6VONBfKxYmNAlUHhklYCRR6Yodw=;
 b=JnHwT8OoEwo6IVZC0oT0MjIc0HboXE/rzQpSVzwpEX4dPsS9soaRLXclB+q+FLf+MF
 KaN9HyXkOmVQR1qY+eNpZVdKxxXqw+0VCo94k6OLyaehHjOBFejvPk2pGN9FVdHCZ++Z
 wJ9qdC087D9BA6xNgcQfUUFfnfedEAq9FEpnIQTp6oRVfaE2AcMrtzZR9achyeVBXt2p
 fCDCtwLtQYFWNw38CzVPoJ0xf+1bBEIXcBkBPFii2YoGZUpfuMjO5ypqaT4u9EwEHx6R
 NWynyfjjtptIVzmtB93xXTAooA0ozwMuNEnEzJywyFySKd7Eb7pJrTZkUJdmOsmGSfhn
 4BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703927; x=1794308727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h5PxuAlAW6HHJw+w6VONBfKxYmNAlUHhklYCRR6Yodw=;
 b=WC2ggmd8al2sixMaVyhba8fRuY7eSjsOfoiP1/28dD9thVsDZbkpqAPc6FbRbn/W8S
 Fr7mgEWx/1KNBz9nLcnurfgTyzMMfL/SFfCKWAkOI0l7QmhjvOyrw8QUXlD5cL+vDbOv
 AplGkoNqOaBlhnhpeLJMjW3IYRw+4PcPmjSmkGm4FBipW1JtbN4BY+K4+217GE2njZEi
 RzE7932eg7bZwXUFRR0M4P9Lc6NvFPMSNA5NFDpEVttdPjdUy5sOEMZPHcdrsAxZVcvV
 zBNraizYxlGaFhsLtm0RfM0+mDhy2ylZpYi0NmAuMX1YQG0avQ2OfYyTdhu8q+HF1Yc3
 bD2g==
X-Forwarded-Encrypted: i=1;
 AKwUvByArYxitJntnU3OcZ77ldCrkQgYTdb3MpUK3zu81M3y+MVx4sYzaZM5W6YoDYdF1Y+H8hltzwohhsI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9eMCgCXskiBuemcmqxAImf6cY9D8nKBSQnZCzKsGC0k477V1SQ
 B4XSNX8c2S+jCYLbCSN1gv6BZRNjJA39cHhp8PnIv5qo4Ree2l9kH9oj
X-Gm-Gg: AYBFou2AJjXgzEqU6nElObYCUN2hJf5gy87ve0XppMjuTBI5liOjEsamB19yRjuV1zX
 o0MdsV/KPEiefJiNWkYRptEXpbRyYXH7taLIIwAATEIwkriJqRmae5Y26eutYe1djWQjwG2+rt4
 4rksED0/Lv3X9WcqZmV9sKg7BC6Ty4dhN2d2Cji4QmZ2wXsZiBmA+w/80w7dvjsnjhReWDCPAco
 0dE0fa9ua4gSEidVNJrQDn2sj1Q2aM47UnwAMfie3/u0fdMPoTktMSb/UGEj4wrmdVJ54lfqYD5
 ixz2mJxQwzf0xmbCY90tFR2miRkodEQ75sCyoptFGtX2lRMMt0rVHYXv4bbtafHDYcTsk1nwKnQ
 MS3GJh/oJnM377BDR9eDRUl4eGN/Z0iyQMXK2Sh+vkaJFkQmLvZagA/PLCBCmxPCCxp1+PabEDT
 joRNb0+pwZU9agljCoqo3Wu4N1dNAavBZshvYadFvaF9WiDBoUzQ4npq8x2ZRDpNGDZJYFpl2jK
 h2MeAwSqnlLk0Z5BP+D2TwlofepZQYIm0Ol5Xp3mX7QRnrmCxqO/FhWrW5ZCH3f8Pavsv4noVz4
 7kkKAQ4N7mib3gIYJuW+625Nwsd+nlUgdnfKvzbH3tJlbeLS3tWHBCuRgf31SDfctjt1DoS/hkR
 79Imy9+dpwgawmwFW6gakXQW3KoqwvwNKwch9rOqhB16RHQ==
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4ac17b2cdc2mr290564575e9.27.1793703926851; 
 Tue, 03 Nov 2026 03:05:26 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:14ec:7986:30c8:6bc6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm53218155e9.4.2026.11.03.03.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:05:26 -0800 (PST)
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
Subject: [PATCH 2/4] dt-bindings: display: panel: ilitek,
 ili9488: make the port optional
Date: Tue,  3 Nov 2026 12:05:22 +0100
Message-ID: <20261103110524.2812831-3-romain.tisserand@gmail.com>
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

The panel is a MIPI-DSI peripheral, a child node of its DSI host, and the
driver does not use a graph port. A port is only needed when the host
links its panel through the graph; other DSI hosts, such as the Allwinner
sun6i-a31-mipi-dsi one, link the child node and have no output port to
point at. The PinePhone panel is described that way on the same host,
without a port.

Keep the port allowed (panel-common) but no longer required, as for other
DSI panels such as ilitek,ili9881c.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
index ea7449273022..016a573893b7 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -32,7 +32,6 @@ required:
   - iovcc-supply
   - reset-gpios
   - backlight
-  - port
 
 unevaluatedProperties: false
 
-- 
2.43.0

