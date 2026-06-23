Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAD1CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA85310E9A1;
	Tue, 23 Jun 2026 07:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkxzAY8p";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C2610E9A1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:53:14 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so4603636a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782201193; x=1782805993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZgAgjNrkl8Ay4q6R6GNuKVsTA4VTE1lITDaFE3IZhg=;
 b=QkxzAY8pZ//v8CsG2VtWR/Hm75GDjZZCai2tXUqZRS2Wf6wX7U0+Ky0gwd5961Q90X
 7qk0FpU7kyamwZ2574E7IQZRMXaGxcOurcPFo6n0/LnWK/eLwkBvLoje8C+BczjYTnW8
 gY7st66cnwcgaAGXIAgEylruHpd5l7PnFF0m1Hn5BkBX4GuW+xi1DNPb4hg/3QMYSgzw
 g+M+qmX1un/qnZwLJnlgBecsUDg2IMs6PeGjs0KIwC91hzwhUIOCSIJuWSNZQPrsPAw9
 wbm7NO9H6Z9t0dgRJ7f03f0qI5DqDNVHe8uPweA9xT2gxgYvM3qGkqhbiJOgo4Psuhd+
 izOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782201193; x=1782805993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZgAgjNrkl8Ay4q6R6GNuKVsTA4VTE1lITDaFE3IZhg=;
 b=hins8irkP1p/T5OILUXhjktiNwwilIGDcRVZA+v+U726JPRlEFH/mNTh0SssAKu5fB
 HWZHshviRN0xumjsJpe1m4Y6fI2QBoim/XZQY9kmClSc0/cJ2UH2UtQZWpNX/qvLmui/
 nRiqeHLQwxmMFLOF9aGWZGOE8osBCsvYPeQWijV6sRkqlVtAhykNbjAQfWPogKLhido9
 mpQsL+t65qb4pcGZ7UBk3fOX+WDNdlQ9bZbJjT22ltsVAdq2f4hFIsApQzMUQ9pRFDaW
 y31QgC9aUvnawvbPs9BWlzgECNl8BD/MsHmeT8S5raTsnDrwnwvlgmirr/PRH8bqGCy6
 BPVw==
X-Gm-Message-State: AOJu0YyOJFIk/G2BWnBTSQYelVFCcYI82jW8U0U3UPw470l8zq14UxCB
 Vkzt12dOyCje1KUQ+WZYwSztGsdK51mjS+jvGNOBgsTYm8bsN95sIEzUK0o6
X-Gm-Gg: AfdE7ckwgYkjoPpM3eah+kq0J0Oq/pTjYNasdoMxV2e5xH7xuRSrnBNmTX/TShzgOhV
 Ah9TN1IIvjCcvKGE1MJ9w1dFrY16gSy02WohSobgz1jj2jgNbnGjIlmGuZKmczzpZN41IVAisWi
 WbEUGpZ7OmXAgJqNOj8iuZdumccfkVaSDe1Rrhe6X7PFXP0vvUNY62avwq9xUJfmpwPPRAB7BNV
 DKLH+yemctgE9T9BF+QpdqCZ+4UAnMT/dXjSVwFELNGsvus5/j9awTNB6VHcfeoOdRntD11cw+9
 ogIXdyp1wzEnZfRv6w11xPnjRNhjCocr/elisAORJy0kjlBL3CfAEI5cHvw68PzYks2EXwNZZdc
 1WBod86b1ywQxFOi/bJOez3GCKO+miyQJsNmn9+3E3G5elJqCaj30/ZlyYWRz1DpXdX6jB6MHgt
 CjjSVcIWOFSQTu6vIHteJAkyBG/FvUZaFfrvAVryUte96FNNU+PKOAucvebsgk6icOACmM6cA8x
 A8=
X-Received: by 2002:a17:90b:5650:b0:369:7421:75c3 with SMTP id
 98e67ed59e1d1-37dd0db4122mr1941411a91.16.1782201193481; 
 Tue, 23 Jun 2026 00:53:13 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37dcf19ee47sm656298a91.1.2026.06.23.00.53.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jun 2026 00:53:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] agp: efficeon: Disable PCI device on probe failure
Date: Tue, 23 Jun 2026 16:52:46 +0900
Message-ID: <20260623075300.42474-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

agp_efficeon_probe() enables the PCI device before checking whether the
GART resource can be assigned and before registering the AGP bridge.  If
either of those later steps fails, the probe path can return without
dropping the enable reference.

Route the resource-assignment failure through a shared unwind path that
puts the bridge before disabling the PCI device.  Also check the return
value from agp_add_bridge() explicitly, disabling the PCI device on
failure while leaving the bridge cleanup to agp_add_bridge()'s failure
handling.

Balance the successful probe path by disabling the PCI device from remove()
after the AGP bridge has been removed and released.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 46cfc58a77de ("agp: efficeon-agp: do not use PCI resources before pci_enable_device()")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/char/agp/efficeon-agp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 0d25bbdc7e..03804b08ef 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -346,6 +346,7 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
 	struct agp_bridge_data *bridge;
 	u8 cap_ptr;
 	struct resource *r;
+	int err;
 
 	cap_ptr = pci_find_capability(pdev, PCI_CAP_ID_AGP);
 	if (!cap_ptr)
@@ -388,8 +389,8 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
 	if (!r->start && r->end) {
 		if (pci_assign_resource(pdev, 0)) {
 			printk(KERN_ERR PFX "could not assign resource 0\n");
-			agp_put_bridge(bridge);
-			return -ENODEV;
+			err = -ENODEV;
+			goto err_put_bridge;
 		}
 	}
 
@@ -401,7 +402,17 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_drvdata(pdev, bridge);
-	return agp_add_bridge(bridge);
+	err = agp_add_bridge(bridge);
+	if (err)
+		goto err_disable_device;
+
+	return 0;
+
+err_put_bridge:
+	agp_put_bridge(bridge);
+err_disable_device:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void agp_efficeon_remove(struct pci_dev *pdev)
@@ -410,6 +421,7 @@ static void agp_efficeon_remove(struct pci_dev *pdev)
 
 	agp_remove_bridge(bridge);
 	agp_put_bridge(bridge);
+	pci_disable_device(pdev);
 }
 
 static int agp_efficeon_resume(struct device *dev)
-- 
2.47.1
