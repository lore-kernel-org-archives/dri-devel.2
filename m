Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4367606A339
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q08v406y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B5B10FC70;
	Wed, 11 Nov 2026 16:22:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C91A10FC76
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:22:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AC3663E38;
 Wed, 11 Nov 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794414161;
 b=ByNQdC/EqbSzhaAJ38QhFeeBItwVbLOXQjUw1E1+pTB4ENy98bTQWcOsIvkf2hYFlYs8
 MmNVZ/FC3pxM9/5rQ6E60wxX5xMslItKnotEjoOy75pOQtGWL/uFb/TfH7kvRs+bJBT0h
 F4twscc1P1+dfdQTJoOpHMpf76227nR3gW1fI0bJGVKnVFk9oAVhl71vMGez5odIbX8lL
 E7R2/ZlATqfYp8G32bJJkR+GZZNULNLasBYz1NBIbw2XBOmes0OR5XYzyXK5+ZRaXcVo9
 9YF0ibT87/n+RiEtkwWnqGVT4/JYGrbhfW9En7jEwgFoBkr6plG53qpypTCaewSA8Qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794414161;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Or8nTk9ZVbnrA4q914nXGUz7qMvSQv0pWk+CqcMXwjs=;
 b=MuldGOrQa4m3dio/LCKKeOpODtAcAM00vJVO3kwx/BdkW1wVvX0inkPMqZ5tgBVY3+KK
 KK3CILlwC8PPhMhSTdwlsJrvXg5OQU5N34miu9dkIwGTQHKbn7m6hBmN8Vs91M2K+euWl
 MPvr0iJ0yGS7UXLqSXfbBX8xLr6Ap96ab+BCHr3O5D2rBaojLHQ8/tvJI3hzZBQP31QKN
 kKaZT7INP2mrEciqalLOtQSFQ8LOnuadWF2PRTySJfennQK7M7dYIhk3SbmECHSY7PbHm
 /dDaF6Fzl9kWo/DW5oFGZ5GNmdwOTMwKvhC8A/y9S7oABcj35iKN0kVAkCdXnZtU25A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3C6011F00A07;
 Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794414161;
 bh=Or8nTk9ZVbnrA4q914nXGUz7qMvSQv0pWk+CqcMXwjs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Q08v406ybvKmpgk6WUkix9yHXCBI7SXdsFN8x8vFEuT/7r7MqXnISqLOZahZWdpLR
 k/JLyctbWHsjRESICChCnBg2FGBKpnZw2uXWD1jYdPI0dMThCAni36/CipzBBjqtNy
 bHS81FUSnkyqyjKZBP1t5jbsOdsfoqmiOJX9lJUE4/cnLMZ1TC5+HG7SUoUGHerIcx
 TB/ribWc7yV8LqlJTaz6gfSzm6GmGMOrx9zbOCJ4frsSU4vocdOp3KbvDRdDaTYcsE
 IewA5TOz2FTyeoXLcsNLK4YDSP7UpfobKsWBadibAHKys+0xhxzKi7nm/S3MgW7aq3
 jmMVeLww4UgyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BC15749033;
 Wed, 11 Nov 2026 16:22:40 +0000 (UTC)
From: Michiel van Beers via B4 Relay
 <devnull+michielvanbeers.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:21:41 +0100
Subject: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>
References: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
In-Reply-To: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794414160; l=1951;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=cVMp5TfdJqEv4/BLWzYSV7umn1bMpBqTXaN1LwgWfA0=;
 b=sKRGK7iQM4/JTa7sbXtUPCIl83y0BsZndAyrc2ZqLpu30HlBCBHiNfTmmr5Ca16CUyCW4pKJC
 4mZbHc/UG1lCDNOsiZWu8H137CPjB7L/RUE5JJ6KxfoXzMkQS5NB4+h
X-Developer-Key: i=michielvanbeers@gmail.com; a=ed25519;
 pk=C+lOje7u3+2x3o2NLMXrwz2veP2++eXfIi9MtYsUo4k=
X-Endpoint-Received: by B4 Relay for michielvanbeers@gmail.com/20261107
 with auth_id=1444
X-Original-From: Michiel van Beers <michielvanbeers@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: michielvanbeers@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michiel van Beers <michielvanbeers@gmail.com>

The LM3630A has a full-scale current setting per control bank, from
5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
for less than the chip default of 28.25 mA have no way to describe that
limit.

Add the common led-max-microamp property to the led@0 and led@1 nodes,
and reference leds/common.yaml from them, where that property is
defined. The property is optional, so existing devicetrees remain
valid.

Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
---
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 6393cbf3afdf..92a7236eae1b 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -42,6 +42,7 @@ required:
 patternProperties:
   "^led@[01]$":
     type: object
+    $ref: /schemas/leds/common.yaml#
     description: |
       Properties for a string of connected LEDs.
 
@@ -77,6 +78,14 @@ patternProperties:
         minimum: 0
         maximum: 255
 
+      led-max-microamp:
+        description:
+          Full-scale current of the LED strings driven by this control bank.
+          The LM3630A sets it from 5 mA to 28.25 mA in steps of 750 uA.
+        minimum: 5000
+        maximum: 28250
+        default: 28250
+
       ti,linear-mapping-mode:
         description: |
           Enable linear mapping mode. If disabled, then it will use exponential
@@ -112,6 +121,7 @@ examples:
                 label = "lcd-backlight";
                 default-brightness = <200>;
                 max-brightness = <255>;
+                led-max-microamp = <20000>;
             };
         };
     };

-- 
2.43.0


