Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65940C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F04910E223;
	Sun, 20 Sep 2026 22:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="goSrMxbk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C98310E223
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3586B42A86;
 Sun, 20 Sep 2026 22:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4791F00893;
 Sun, 20 Sep 2026 22:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944521;
 bh=m2m/eww0NJBC9VjmSRylYPL3dP0broMZbNA/WY8kWFs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=goSrMxbksaJG6FwEJKq4YQ5tFgxG9wYW60U02qLdPE6u3eovkDpKE7wanpaAi9bGn
 KLJfRHdS241AJQ9JaruMknvVtUkND+lbxBONu03WVm0qrXRPhdPA3NvCMZMU/v8OKs
 OjGghA69iVzt9+gwKPeCmdKjir31LFEipTFEKYnkoRA0QgdLRrEG7IuCiY5Lx+Hss1
 0tGVWA7oagXwrPH6h9meb/5GzQsmdg9Z7NfbT3EP5aVKEZfO0cuANwWx4/TcN05Pse
 QHCYtyl+NP8bj1vswa2FXqC33YNtA08Mk2FOxniENJFQ55pL6WsvVshZBNNFCMaf78
 qy4k008oIY2ZQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:12 +0200
Subject: [PATCH v3 06/18] pmdomain: st: ux500: Implement more power domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-6-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
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

This starts to implement the power domains that are just skeleton
implementations right now.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 127 +++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index c9129a3b1805..d90a563cd6f3 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -17,7 +17,7 @@
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
-#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+#define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)
 
 static int pd_power_off(struct generic_pm_domain *domain)
 {
@@ -43,14 +43,137 @@ static int pd_power_on(struct generic_pm_domain *domain)
 	return 0;
 }
 
+/*
+ * Apart from these voltage domains there is also VSAFE which is always
+ * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
+ */
 static struct generic_pm_domain ux500_pm_domain_vape = {
-	.name = "VAPE",
+	/* Vape_pwr */
+	.name = "VAPE",  /* 0.95 .. 1.20 V */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_varm = {
+	.name = "VARM",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vmodem = {
+	.name = "VMODEM",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vpll = {
+	.name = "VPLL", /* 1.8 V */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+/*
+ * CHECKME: as these are used directly by peripherals as regulators,
+ * perhaps they should stay in the regulator subsystem?
+ */
+static struct generic_pm_domain ux500_pm_domain_vsmps1 = {
+	.name = "VSMPS1", /* Also called VIO (1.2V) */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vsmps2 = {
+	.name = "VSMPS2", /* Also called VIO (1.8V) */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vsmps3 = {
+	.name = "VSMPS3",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vrf1 = {
+	.name = "VRF1",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+/* The following are technically children of VAPE */
+static struct generic_pm_domain ux500_pm_domain_sva_mmdsp = {
+	/* Vape_SVA_MMDSP_pwr */
+	.name = "SVA_MMDSP",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sva_pipe = {
+	/* Vape_SVA_pwr */
+	.name = "SVA_PIPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sia_mmdsp = {
+	/* Vape_SIA_MMDSP_pwr */
+	.name = "SIA_MMDSP",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sia_pipe = {
+	/* Vape_SIA_pwr */
+	.name = "SIA_PIPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sga = {
+	/* Vape_SGA_pwr */
+	.name = "SGA",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_b2r2_mcde = {
+	/* Vape_DSS_pwr DSS (display subsystem) */
+	.name = "B2R2_MCDE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_esram_12 = {
+	/* Vape_esram1_pwr, Vape_esram2_pwr */
+	.name = "ESRAM_12",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_esram_34 = {
+	/* Vape_esram3_pwr, Vape_esram4_pwr */
+	.name = "ESRAM_34",
 	.power_off = pd_power_off,
 	.power_on = pd_power_on,
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
 	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
+	[DOMAIN_VARM] = &ux500_pm_domain_varm,
+	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem,
+	[DOMAIN_VPLL] = &ux500_pm_domain_vpll,
+	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1,
+	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2,
+	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3,
+	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1,
+	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp,
+	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe,
+	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp,
+	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe,
+	[DOMAIN_SGA] = &ux500_pm_domain_sga,
+	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde,
+	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12,
+	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34,
 };
 
 static const struct of_device_id ux500_pm_domain_matches[] = {

-- 
2.55.0

