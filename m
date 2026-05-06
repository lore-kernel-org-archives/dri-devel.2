Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8409FF8855
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FB310EDAE;
	Wed,  6 May 2026 13:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q8VZAc1j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FEE10EDB9;
 Wed,  6 May 2026 13:42:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E3D4144278;
 Wed,  6 May 2026 13:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DFCC2BCC4;
 Wed,  6 May 2026 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778074955;
 bh=YMBtIgkv/0vd1T2Q/REmFWl7B9kwD1JjOym1CYgrerA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=q8VZAc1jKjhYkUce5aTh0zexq4y8C1u0/kYwDMq/fi4b5/BGgGyEcabyeYJr2ikps
 tbpHkK4690619IA7Seo//dI++5K1FUI3MmCTv0/vzsBwZEXPOqSrLvrdbiVu7Mx8gh
 6yKGnfFXcHTtCbFFKM/SjKiOJJvhnL8mk4DfpMTNViV3MWj0ZemPBcQT4+6rZv3khS
 3oY/zdjZjDFl89TJNF69XmL51iMVurwGfhOUV6G88SCgKYU99B7tsnIhky3MMB8qLU
 nWnHmzlT8Dy78VVc2SxQV8y/kc8NqAZVOezC+KtmDYUdzgjp6Da2lA63wKF4f7Z+je
 qJzoK1/Nxy0PA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 06 May 2026 15:41:57 +0200
Subject: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
In-Reply-To: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100; i=treding@nvidia.com;
 h=from:subject:message-id; bh=59LKaPbdXc/3cXqAypoqqQT4hvZBv70PYCPPUxuHdSE=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBp+0Uwjf/7ylsfyp/FAMe7OvIMjXJRmECcGvqVZ
 UdgOe3ty+OJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCaftFMAAKCRDdI6zXfz6z
 oUr/D/oDRCFAmlPpPBjksDR0c4WYjTIIgAxZyXVTwR/BZIayR2+hDUes+Ers37L4X+dcwam6dP1
 Mh/NYLYivVsc8JPA2s4Sh8AnPMZDnR73dmYHAkjioFdvHKQ9kCPf6VDL9LuJ8iHM5ml+5lNy1Cd
 LEE9AWIbrzoUTUxwgy4XQVyUOomYhY3vukCkUqteP4y4BGfUhevwYGzQFbHCV4vyZAT4+urTydX
 2b2k1jShmK+uEkkYXm7WUTIF5BUVdAn6d/IKzSBt21YmXtDXpaX6Tzn+8a17jB3R6wsdi2kNpnH
 MLP4k1/ipPn21FyY5bWaNkTBeOkW+rF3KSSf7E99TqvZQCJHFEvtGMeDxq112bFWeAu6Vim9TIP
 JivdrWQUbK2iZb+US3DF3Hiey/aSvj1ttSAQPOoMG6CdRr19XJZKfufMvYkjowSHTfwbwhNMeTj
 RDh7pJoTmia0m+gfXVGJyvu/1iWbTk0kWTQWuPqAwsCmQUJaArldYdeLColaKSwzr4p14oLhGeE
 +9jWHeQtlhstICfUV296Vsv9hYdp7inn9h/qimHAe24rzHd8Zszs7xDWkcgxHPZkNIUOna/FwXp
 +7hy6gArw+JwkdIuoFtay+dwoxXVMNRoYw+h/Nta0GmCYAqeutmeXlwpl2+fAHui33MG3YOA3iE
 pWK00Z5pZRkvs6w==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1
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

From: Thierry Reding <treding@nvidia.com>

Currently the kernel relies on a global variable to reference the PMC
context. Use an explicit lookup for the PMC and pass that to the public
PMC APIs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index d2214d309e96..122b711929ef 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -292,6 +292,7 @@ struct tegra_xusb {
 	struct reset_control *host_rst;
 	struct reset_control *ss_rst;
 
+	struct tegra_pmc *pmc;
 	struct device *genpd_dev_host;
 	struct device *genpd_dev_ss;
 	bool use_genpd;
@@ -1188,20 +1189,23 @@ static int tegra_xusb_unpowergate_partitions(struct tegra_xusb *tegra)
 			return rc;
 		}
 	} else {
-		rc = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBA,
-							tegra->ss_clk,
-							tegra->ss_rst);
+		rc = tegra_pmc_powergate_sequence_power_up(tegra->pmc,
+							   TEGRA_POWERGATE_XUSBA,
+							   tegra->ss_clk,
+							   tegra->ss_rst);
 		if (rc < 0) {
 			dev_err(dev, "failed to enable XUSB SS partition\n");
 			return rc;
 		}
 
-		rc = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
-							tegra->host_clk,
-							tegra->host_rst);
+		rc = tegra_pmc_powergate_sequence_power_up(tegra->pmc,
+							   TEGRA_POWERGATE_XUSBC,
+							   tegra->host_clk,
+							   tegra->host_rst);
 		if (rc < 0) {
 			dev_err(dev, "failed to enable XUSB Host partition\n");
-			tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
+			tegra_pmc_powergate_power_off(tegra->pmc,
+						      TEGRA_POWERGATE_XUSBA);
 			return rc;
 		}
 	}
@@ -1228,18 +1232,21 @@ static int tegra_xusb_powergate_partitions(struct tegra_xusb *tegra)
 			return rc;
 		}
 	} else {
-		rc = tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
+		rc = tegra_pmc_powergate_power_off(tegra->pmc,
+						   TEGRA_POWERGATE_XUSBC);
 		if (rc < 0) {
 			dev_err(dev, "failed to disable XUSB Host partition\n");
 			return rc;
 		}
 
-		rc = tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
+		rc = tegra_pmc_powergate_power_off(tegra->pmc,
+						   TEGRA_POWERGATE_XUSBA);
 		if (rc < 0) {
 			dev_err(dev, "failed to disable XUSB SS partition\n");
-			tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
-							  tegra->host_clk,
-							  tegra->host_rst);
+			tegra_pmc_powergate_sequence_power_up(tegra->pmc,
+							      TEGRA_POWERGATE_XUSBC,
+							      tegra->host_clk,
+							      tegra->host_rst);
 			return rc;
 		}
 	}
@@ -1733,6 +1740,13 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				err);
 			goto put_padctl;
 		}
+
+		tegra->pmc = devm_tegra_pmc_get(&pdev->dev);
+		if (IS_ERR(tegra->pmc)) {
+			err = dev_err_probe(&pdev->dev, PTR_ERR(tegra->pmc),
+					    "failed to get PMC\n");
+			goto put_padctl;
+		}
 	} else {
 		err = tegra_xusb_powerdomain_init(&pdev->dev, tegra);
 		if (err)

-- 
2.52.0

