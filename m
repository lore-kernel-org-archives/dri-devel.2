Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C268C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE7C10E7AE;
	Mon, 13 Jul 2026 07:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oWV+lxgp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tnvfqeok";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E56710F88C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:25:56 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gxTzP41pYz8v03;
 Fri, 10 Jul 2026 13:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783682753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0uz5babyG4/oQLV6nAdjfq8AhBJHI5AOEGqYXsv/GxI=;
 b=oWV+lxgp4uoANkcuAxOdkLasnGg+dncuePZvRe8/cImduXjFSZ+aiZmpdcW5Z9vHDWk5v/
 W8dMISEUtxm1UWfC532KeY57K39Es7Zo/RR+UWrOOZbC3fQKDwJrB+8PX71sKnSCk+5vZZ
 G3LlxLwlLe3fnQI3y2P7tlRFSItunp77W7bxc4Nw7gHUd8u9qMATEucKhUO1AcQAhi5uHt
 2EaU3q8bUJcN5OzEzs+/nSwDk8DZY64OiF0XbltlpX6rlvZdYajbKtLXaW3258aZNgVRFZ
 IU1NN8CSPQKm5cPy1Ph23Qr5YUH2WCMfscOls8bcDhp+1KDqvHO0JNZZ+jQpHg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Tnvfqeok;
 spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783682752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0uz5babyG4/oQLV6nAdjfq8AhBJHI5AOEGqYXsv/GxI=;
 b=TnvfqeoklTGgCwb4tBJpnuzCAlSZi2PTzrg5YbdxIAnu621cr0KJLNseQbpJCOhgP7XIf1
 g8JJpMJQb+pU/EMnHzQgi4GNn0tY9JkQ5eCfTZZcP6kRGpROQ/+RAGWmI2Jg5mNHx+Ytal
 Lrgf3p4riKN9SUmasnZ4a0/5p0JHQRnf+IJfXyfoV4nK3G9ZuqPuqsdg3oi22TLAipQ3pQ
 z1hgyqJRUItGSo95SToRaMjCEGEyRd32fUfCnMl5POiQLfBrJtD9khd2Cd3I/YFMsXJUMX
 ObXf4JmB+O6UL7qtAccvT/OtTPZBR+6Klo9UM66YSwLS/+ZB0I8oZCHKv4yiuw==
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Add missing bracket
Date: Fri, 10 Jul 2026 13:25:29 +0200
Message-ID: <20260710112529.435341-2-manuelebner@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d5d2bf97b39b8497b5e
X-MBO-RS-META: z3t9u4zxmwjo8gncp63cad6mxet444dn
X-Rspamd-Queue-Id: 4gxTzP41pYz8v03
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Add missing '};' to code.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/devicetree/bindings/leds/backlight/88pm860x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/88pm860x.txt b/Documentation/devicetree/bindings/leds/backlight/88pm860x.txt
index 261df2799315..9e17807d2ce5 100644
--- a/Documentation/devicetree/bindings/leds/backlight/88pm860x.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/88pm860x.txt
@@ -13,3 +13,4 @@ Example:
 		};
 		backlight-2 {
 		};
+	};
-- 
2.54.0

