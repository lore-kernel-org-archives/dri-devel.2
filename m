Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94550106ACEF
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D086010E305;
	Thu, 12 Mar 2026 21:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MZddNuAS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0038610E305
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+mkbco2DYpLYIg6W0/gxXvZBYfuan5aT8DY6Oq7vk00=; b=MZddNuAS3xkEribzB1lOgfihEh
 As2RkO47FakZb9QC92IG5wWB9t2fpkqMt+xm+GD1qRX6WpoBqZzRPLdSRmqbLjGJRmNfG6miy4jbC
 KOVMOg8DKBYU54NMWJLOgOISKfACrwWGPyMPhdigQ/2daWzNfZN2N6BZeaq3KEw2B2TvSnLQF0i6e
 92rQyUJkf4IoO7TUQKVZilortrby1ElMVW8zkPyoTVgbMWN+ywAez+rWRkKgpLP6eL7+j9Q3sPGRx
 bDySr3Uvd5A8hBniO9emE5W13Ij6nWDZMzLWTt3wiX/BY6Rk+LjSDLk0yyQKdui18aG2uVbsdBpl3
 jk5YdsyA==;
Received: from [189.7.87.203] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0ngH-00ElyQ-Fp; Thu, 12 Mar 2026 22:34:57 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Mar 2026 18:34:24 -0300
Subject: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Chema Casanova <jmcasanova@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=euqSfLBmeaCLZHWPklfYFKyXd9/jNfEqOAD7t8grm+8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpszFr76DUXmoAsyJGsXd/N9TtDJyMFCabSqnNX
 F10hpKOuLSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabMxawAKCRA/8w6Kdoj6
 qj2DCADAlWnt1dBmx5rDtgiehKMjC3M22RREyzbuB2SQps4zINZ0KPZnq6bmm02OwNmAQ/7ssES
 fqFDltfhMdukQo0X4s5RRzCCoS0AevB+l0EizpPkRPOqETx0OFq4Exm46qbuvvhr2ktYfNMs9Mz
 6lWqTRviy15/peur+G5BZonMhWAydDYwAvnCk+dPPQOnppSs/ZAsHPAbiJXQ4ySjaKPDrRXfFdT
 B6YjxiTQCBgCArL6lFVcHgJcuZydO1HF7TPZPd5qk6RVx40HP9v8HnCiN8Z1BIJotOlZuJmEu8K
 VkIeA5jzXH5lVrDzNSE2vsX+XqxByfZ/hXYb3sa/EofZiBUo
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The bcm2835_asb_control() function uses a tight polling loop to wait
for the ASB bridge to acknowledge a request. During intensive workloads,
this handshake intermittently fails for V3D's master ASB on BCM2711,
resulting in "Failed to disable ASB master for v3d" errors during
runtime PM suspend. As a consequence, the failed power-off leaves V3D in
a broken state, leading to bus faults or system hangs on later accesses.

As the timeout is insufficient in some scenarios, increase the polling
timeout from 1us to 5us, which is still negligible in the context of a
power domain transition. Also, move the start timestamp to after the
MMIO write, as the write latency is counted against the timeout,
reducing the effective wait time for the hardware to respond.

Cc: stable@vger.kernel.org
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

---
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Ray Jui <rjui@broadcom.com>
To: Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e314402f1cc9897c57dcb 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 		break;
 	}
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	if (enable) {
 		val = readl(base + reg) & ~ASB_REQ_STOP;
@@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);
 
+	start = ktime_get_ns();
 	while (!!(readl(base + reg) & ASB_ACK) == enable) {
 		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
+		if (ktime_get_ns() - start >= 5000)
 			return -ETIMEDOUT;
 	}
 

-- 
2.53.0

