Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C898606A332
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TQ7OSXO/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B8810E635;
	Sun, 22 Nov 2026 17:14:32 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9150210E4C0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:34:30 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so17149755e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 01:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795340069; x=1795944869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+M8KBpgpfD4+bhslMdu9R1fB0Prfsa9U9mKWKKMZPo=;
 b=TQ7OSXO/karqhVQvvyXAB7hM1Hxay3U89Z7U9SMnyqxG7x0rdiI1xf8mW/FE2uFEDX
 VNi/zNbfcSzyF+1D46wPzVyP5yWjdo16mQRbVYAsCnve7jeTfZ/jr5iyMGlL4RXZwTlb
 8ywV24jlD9qT8Yi+lnyaO/H7Z6dNDwRQQeS69Axz3QSeBOeYYqbEgBw2sySUTBMhzsuN
 TtR+40XVu+T8Wcy52N3V0pj6bO+mR4hvIAE5qukAxfxrb1FOAV/IoUmBd4ZPypOWtsoO
 w/wzbIIvJuoS64M+gEvQMXH1OLBBvkpK/NQXAcYI+RIqgtQwf8vRpf7Z9tL+wnx1uNd8
 5v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795340069; x=1795944869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+M8KBpgpfD4+bhslMdu9R1fB0Prfsa9U9mKWKKMZPo=;
 b=zh6k7kHDAKD23ZPOkn1OZ9vurBmCJ29rqJlO79/0MMVNj03JKJ5Puyeoh4JyHDLxrR
 KVgE7pKVaaD+Bdk08UE/Cd7lJV6+EH+ZVzzuRjg8ERLqICgiv+bxz4jGRTe1/VPMnwFK
 7EkWsg0KyJXZJLE+QbuG9oT+ApZgyxANjU6ioRymwbjiczj5IE821pJXQStcEaT+gG01
 8yS6DYCXfQyr3cB1pM0crTr+rZJxsFXgrCpZk/29ko+LlDW8VWIC9M+SiODXuuJnMFPX
 4AZOySDdoxUw1ywkScR9pAs03M+LhruzUUQ6DXLTfEfxXKM2rHesuv4UBEEdJGZ2diFr
 x2Qg==
X-Gm-Message-State: APuU4Z/F/Rpd3gX3uRCa8H4ojujujKiuKFo0KBJrXV/Nt+DmCPgnigJ2
 K2JxLAqITdjCq2MDHY5RyTuttMzXEFKIv2rSSTSzpBPokZRUl1rQ5lkJMH0Qdj4HlvA=
X-Gm-Gg: AZFdTZeugQ1qlv2tOeAladfxcwbtzd2r7U+n6hU/XQLQx2+rYwDeeknRRJIpaOhgxeP
 kWQgS73jPOOYL07zMA8UrEFyQsIPtfHQn4Ay7HMjs3EgKPDSwwvdHK1D+nNyPfBSLfS521RRTBi
 pXOiWv1PlCnZr1+GyXOfO/TXxH1uj6wOZda2YxdSQB7VG5H09Y5WXz/oWi964pQ+zvp5ck7HI7o
 zFlcY/J2STCmO1TORfS6VK/RBaMt+r6KszNQlvqSpVMOOnHd9csM9IuqWTZ9cyLyyCY9NBDZeMB
 uWqqVbmwrMBWi3Efo+XYNoZYhKctE56wtCRj2gMMNKf2vTdvk/Y7ZJOxby4bXgMHvHW1Yg2wSbo
 ZNYD5Nup8TpArvheaCAiiMRLg+Ch92/DlegzcV3ZFUz9w3juavrB5ciQd8CUlgU62frJgRk0ViS
 cg7D96r88e7a1zETcEzINLBmg22JU07PDHgiEBilS7FcKgWQ3nJxZFA9nLby5LH/OUqU9N5rFHC
 rwBQpXRgClucdTn1A/APRuIeqFwKQlC+CjLjtKaH7q8h6QzRbsO72QigXHK3hnvKiBBbJBmKKyu
 pBf/CJ81xYsO+siRR7u2PoL6mZvE8fwiR0z871rBeSDvo2o5Ag84gMHksk4nuJJBDmqfRcd8ipd
 xSm3ivdn1pwM=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id
 5b1f17b1804b1-4bb8882672fmr187579805e9.6.1795340068842; 
 Sun, 22 Nov 2026 01:34:28 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm16355673f8f.31.2026.11.22.01.34.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Nov 2026 01:34:28 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: display: sharp,ls010b7dh04: Add LS013B7DH01
Date: Sun, 22 Nov 2026 10:34:26 +0100
Message-ID: <20261122093426.72677-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LS013B7DH01 is the 144x168 Sharp Memory LCD of which the LS013B7DH05
is a thinner revision. It is obsolete, but still used in products.

Both are electrically the same, taking the same SPI commands and VCOM
signal at the same resolution, so the LS013B7DH05 compatible can serve
as a fallback and the sharp-memory driver drives it unchanged.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---

Notes:
    Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.

 .../bindings/display/sharp,ls010b7dh04.yaml   | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
index 8097f091c2a5..e6ebfea50ad1 100644
--- a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
+++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
@@ -17,17 +17,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - sharp,ls010b7dh04
-      - sharp,ls011b7dh03
-      - sharp,ls012b7dd01
-      - sharp,ls013b7dh03
-      - sharp,ls013b7dh05
-      - sharp,ls018b7dh02
-      - sharp,ls027b7dh01
-      - sharp,ls027b7dh01a
-      - sharp,ls032b7dd02
-      - sharp,ls044q7dh01
+    oneOf:
+      - enum:
+          - sharp,ls010b7dh04
+          - sharp,ls011b7dh03
+          - sharp,ls012b7dd01
+          - sharp,ls013b7dh03
+          - sharp,ls013b7dh05
+          - sharp,ls018b7dh02
+          - sharp,ls027b7dh01
+          - sharp,ls027b7dh01a
+          - sharp,ls032b7dd02
+          - sharp,ls044q7dh01
+      - items:
+          - const: sharp,ls013b7dh01
+          - const: sharp,ls013b7dh05
 
   reg:
     maxItems: 1

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

