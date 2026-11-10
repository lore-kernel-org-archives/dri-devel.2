Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13772606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FScHa5AC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED9410E056;
	Tue, 10 Nov 2026 02:34:14 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DCD10E056
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:34:07 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso1902483d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 18:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794278046; x=1794882846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1B2U2TuVq4N1W00mA+TK0e56v5CSnlPbZ2+KI+KYFME=;
 b=FScHa5ACiL8sPbvlHsjQ70fyAWnuHK5TJaM3RNcrTleWHRoHPD13qeaaXIcLL3OPer
 htUnk2QRunTHFyr6Di15hl3awRTTmEzfwnDFK8HjSk9/o2TED49/lbDZjWBjHp5g9hft
 unCd/LBHdrllV/9WQM7y2nzx/8QNbRYChOAH0G40l6uHVP2rGFpjK/AthC5dHQVIdn8G
 vHj78LGGcHDCDTuQ6srF+LdicBvLgCgftyJvIRVs3KOaYNe2lpS2jCU2KZlLJDhLAQZM
 xWMD7MSILkRHgwVTWVa7dFyt8aA9wIhJRo6xiKiFUmVZn7jgtAYbl0SToj5rg2eoeR9q
 NIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278046; x=1794882846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1B2U2TuVq4N1W00mA+TK0e56v5CSnlPbZ2+KI+KYFME=;
 b=NWqd3tkTHHl2sRwI9RzyWsh/92hPfZEi6cLbfmHux0KgLIoYdPIjTlS9nNiP1RveYt
 VoZ3ENoIQ8PUK6i2glngFOlU2U+Tcy8CkrzWe5kXSW/ceSZP1QwdJePK9wdcoo7nLSfA
 r8Uh0Y/8A9eyEDhWfDow3KwtT0dbqG7O9wJhPF77Jm9rnHZirIs1+f1vXMXekJJN93ef
 UXpPV1AHHdrKxtqOFIQ7cV/UVfB18Ljq8oejn1jcKsVtIfXKICB0lmlndXzzyI/Yxrn9
 LJ9ri72qGT0m1S1uwhNKaevopNgOMBc9nUAFpq3UrCWcHrQOo+V9bNoSbP+zjfjqyuw5
 lrsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH2OPBft8nyIPJs/PH3rrXtiPCv9ZsPVJPQjqa17n4RYsYUUBn75kouduOYChTZXSwOQfA6foEeYPA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8d4aVMqQUlsUviD0e5SQ5w0xaUfqeG020tklKPdtZavM8IM97g
 BDuZ+HJaN1j9Hjz428opOVN+vpk69jBqKuDtXHRG1Vbgz3I6WTVIPvnX
X-Gm-Gg: AYBFou2uPcTn3o2WZ3gyb6hAUqj9uPtuXa/boglaef5PLHiEEakmcnTSCLJYtNkK9xd
 aEinq2UzNt3XogRHNcBVLYiiZ9+MiUAAyJ8cAIB6o2xrMqYWxsSjFCMu9PPQ5NqNxckGlwH5Y32
 3mCVnPOy1CSWjFCmPNjJ9r4XTgzg85iu/a8BOGvEMk+ipj4upUZneWv0e+84Dh48hKrVs8VqdzK
 fOsJZRGBabONYujJc5OusuKnSIHxjg7vCu/dIX8Nj8JFv2w8+gpkV6b5wRXGDR0w5vzABydf+nf
 SwAb8/z7+UcOMsI3wCAGEuKzLKJJ4TkcHAL944ojNEz3Tor25AjWjuwHJZNfoQcxR4SqlB8+hAB
 KhhSQ12Qu7nsMozYFqIBfbsa1wXU7ds6S+G57CupZ4LRCwX6+u8KUa+3vi7uoUA/aXDpgGKrfNk
 ocU4q5Ee9+Pu93q/fpIQ0Sc2/bfpFxOS3kMwB7bxPd1FcauCIhxEka/BnmuzlpO1YT9n7igxVW8
 dJlokAgix5tozt3dVJMalZUsdzlmEJ5R4KGjW7OUy56nPr2asWSKefO10n3Q8jyjOeNRQ6PCS8w
 miqfQeTGsehC9cnfAwxs2xaTBA0O5bIdE2P3Sb/+7/eNcVPYXH+MeN3mWfb3+kHZev60iDi13CM
 r98RvPQBNvJuxYsFvctjhW2LuMBUvtMPPBU07S5acU5BD
X-Received: by 2002:a05:690e:b87:b0:67c:ace:30f0 with SMTP id
 956f58d0204a3-67c56791a84mr736072d50.40.1794278046287; 
 Mon, 09 Nov 2026 18:34:06 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a802:b7f6:9a06:df51:6e93:24d0])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c589a229csm763960d50.5.2026.11.09.18.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:34:05 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: p.zabel@pengutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] dt-bindings: display: imx: Document fsl,pcr
Date: Mon,  9 Nov 2026 23:33:59 -0300
Message-ID: <20261110023400.319579-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Some i.MX25 and i.MX27 devicetree display nodes contain fsl,pcr, but
the property has no schema type. As a result, dt-core.yaml reports
its raw bytes as an invalid property:

  imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr:
  b'\xf0\xc8\x80\x80' is not of type
  'object', 'integer', 'array', 'boolean', 'null'

Document fsl,pcr as a uint32. The property belongs to the display node
referenced by the display phandle and is not valid on the LCD controller
node.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Explicitly forbid fsl,pcr on the controller through allOf, addressing
  the Sashiko review, while retaining its uint32 type for decoding the
  property in legacy display nodes.

 .../devicetree/bindings/display/imx/fsl,imx-lcdc.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
index 84610b5690c4..450f95098c99 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
@@ -65,7 +65,17 @@ properties:
     description:
       LCDC Sharp Configuration Register value.
 
+  fsl,pcr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      LCDC Panel Configuration Register value used in the display node
+      referenced by the display property.
+
 allOf:
+  # Define the type above for decoding, but forbid it on the controller.
+  - properties:
+      fsl,pcr: false
+
   - if:
       properties:
         compatible:
