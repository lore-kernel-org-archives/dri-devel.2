Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE7606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0NfN++S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9527410E5B9;
	Sat,  7 Nov 2026 12:14:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E150F10E5BD
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 12:14:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8CE3601EA;
 Sat,  7 Nov 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794053661;
 b=04JBTkEQpjGkKWJf5vNARizGAnD6QZLmZRlcKh7g6roAgbfNbQSAbcf6sCe/3+3rkDAD
 l0sg3OExELHopFCh/xKTSmoU6evjMYTlQdPuIxeITJ0izHs9j8MUBKQ1nBhjvIeBiB6RD
 K1Q6T6b3piZVewJy+mqsxIjTmsrClBpYnBB8gWE+Q2nNRLZPB9FyH6WSxACBg0skZzhls
 s73WYH5fv9Sc/94ZAljYH8vvZrxShUZIXGCX09a+ZUxNpQkGrrQNxg8djFfaGLc2OxdxN
 vWCstuGMYJeE5kLT9SBHJ9+tuCsbcq+XtxzQxSbQVgmGg5EUfSwWvHOIdAX1dBdnOfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794053661;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Gwf2X9/Rg77kClVT3EvBgrSLkdU0go9KRyevqX6T++g=;
 b=tLm4WLreJH3LnGdHnqjz0lt2TFaw7vg8pjn/vait2BJNFuhIjfom+SVWhnG/Tha//5A/
 eIq8CmNbJozpjo6ps8fKLEhgRfHh76CMjUs61PFPyub49zZ7nMA2bzWl1SMilb2i+ZXBj
 QZACFQKN5AYpJQvn5EyzlpQm1J370Kmjhg4Lvl3iNCa+cM9PxtaHkh5U6YoalAWUbLIJ4
 cN2ommBLsYRlqkLPgr+WVHvUpMneMQBWTlNrPua9WKlo2m2FlBl/dFNGlree5GXvo8kDx
 zAS3Kk7NOufsK2KV1skYYbsjyx6+jiFAeebidinOvMlCuHX+fdwUvojiR5hGqJ4dnGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 11F501F008A5;
 Sat,  7 Nov 2026 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794053661;
 bh=Gwf2X9/Rg77kClVT3EvBgrSLkdU0go9KRyevqX6T++g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=R0NfN++SjFgZ6ziUqPMq82Z5959Anwx+nU/8H3V8NKA0Cmr2kzWntQScfXG6+CZiN
 K60A2HrorDoQRY4/u8M8bGgUzjFLaLaQO+vLiajitq+vER9RomUN+ZP2nLAeXuugdA
 lekGkuUXVTOFk7wcnwjh6tvUJmaNDdD3szBGZxhf0DBb8rBP6ohF1D84TnBs51ej6g
 HW+gdFyoj+K066/OPVcCOLZtLPyUTgZIN3AO58lnoWsUTMEIWWn8I1BoC3hmRgwes6
 3stId5YmOzxUZl2AqsyiLEXN0F8W10JNf+8EpKyczM3bLfN/d9GQU8r+p5YvzRSS8o
 CW9qLKsvzO2TA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7739F47BC5;
 Sat,  7 Nov 2026 12:14:20 +0000 (UTC)
From: Michiel van Beers via B4 Relay
 <devnull+michielvanbeers.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 13:13:54 +0100
Subject: [PATCH 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
In-Reply-To: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794053659; l=1673;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=U0pqMu8uqXgPZkbtID2FcYS33LaVbFy5/+tEgfo7Mus=;
 b=4xHPhDvtsA3W1B22S+Zw7XWK+Y7rNMjjZrPreUNRCyWsFbfIQ7bT7pvr7QuKz5nYLUAMBLL3Q
 CAIwNRmh1UnAfEvIQCISm1jQLVlQ8Yr/37RlxxFc+au1Knk4XmjZhaD
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michiel van Beers <michielvanbeers@gmail.com>

The LM3630A has a full-scale current setting per control bank, from
5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
for less than the chip default of 28.25 mA have no way to describe that
limit.

Add the common led-max-microamp property to the led@0 and led@1 nodes.
The property is optional, so existing devicetrees remain valid.

Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
---
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 6393cbf3afdf..a031679d5468 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -77,6 +77,14 @@ patternProperties:
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
@@ -112,6 +120,7 @@ examples:
                 label = "lcd-backlight";
                 default-brightness = <200>;
                 max-brightness = <255>;
+                led-max-microamp = <20000>;
             };
         };
     };

-- 
2.43.0


