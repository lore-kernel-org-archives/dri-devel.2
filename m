Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38031C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F65710E199;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="spVu2AlP";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9EF10E53F
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:26:30 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so1287320a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789856790; x=1790461590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6R3voHmBzh4lvqv8peZSsVk4sFxcqioiBA0aCjPm9Mc=;
 b=spVu2AlPSCIk1GA5TO4+eYnwcnGKpp8ugI/9mKKYtZEzSFtF3eL3sqQpAKCww1avaw
 bvyNObAVxqU/tncxWsBW/5x5dJhQf4GqUSdhpTRVfYURZuIdxkSsN/C791q8U/ZADVql
 F+Du+pKO+OK1YrlPILohTUAY3uaCbHjFRzjCzmO/xdU3idxOVZRikNTB3ZLqCIicMTOu
 IVZ/5m4721oawzpilu8n8kgqAbf919rhAIiZOKuvllnBvHUgzy0kaQDpDhBpoA2wzWij
 aLrvBUsOVpY2KXu3nVSPZx5lBfHFBP3RtcAya3umj5extC4vXfWW/YK89VOJ2cNE5Wf3
 6wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789856790; x=1790461590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6R3voHmBzh4lvqv8peZSsVk4sFxcqioiBA0aCjPm9Mc=;
 b=AmhejtpZDtgDu0USOO/lvvjmAhx610klW0S5o6gCnRf654Ipgi1/XVVKqJG+yOsaHF
 396eeyWbop9dln1rIeecEiiBWSI51PyozNhqTkZ9bdlgVw+oD8tUkJtPPs7i8Jgmsj/I
 oM0YB10UpstGKcvNw4UhYbArdIQOWOzJDTBEs38+XHFF36wgBqB4RsnHh0xPsf3aJUWp
 ypQGdPmM+ja7aBMriRfhAeFHEWgxbaFcARMtAoXlRuwLJZkZSQBIE54Wf2SnJaAGsuI0
 GlHzMkWKbGzNIRDdaG5j9Gf7VtInCgKc5iuKMPTHZLxFg5G+vXzCfHSIrwaJHMOfGyKV
 36Cg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMAbR6MKjxorLNnLZhjaWXE1finEyGqmPcuxlPQQYG5ED5pr+gPMi+44MrVElNjQpK+9ZVuxg89Mg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kkBVPB6O6ZXxmkGeHBto+XCG/XBwRG6UCx6YlKksLIerpSfhQm
 MtB2K7fUFPekta4/lcRI7iqSJOnnNcwD1EgR5egl8QbHWw4Fv+FCA+lE
X-Gm-Gg: AYBFou39xQDf2bmqRzGgzmmOUwJpOlPBGaEHSminJcwgmG/5EKdhuez5pnnFtnVCcPW
 beTUjOzr7YBfG/nUacs7LeXK/yx4AtMmM7oMSB2XEs3aCpXyVPdU8vUAWHqw+mwT9dpmkHSaxI0
 WKagQSnKylDWt/Pz1SEaUvoX0m0LiT9dxEU923cZ8L6YpIkXqpZllaqBOgm80bFyxRc1vMifTMT
 D07nnnhCkJjCKh/M3UPWXHx2eoGeNFeBctfZscouXcaTYNFPIuy63HQU6J/2eKVsnUhiz9caLDW
 78Q6tjf2VQiohPtG3YGEsls08v48tRwSwsK42ksY4eflWpWwi4TenRBgXdgryiqZzf8sERhRK49
 XBXmWSCoGihB/3XBrN+VC7kz5uQfk0tc+cVnnYhtuRsBdYE2AiaKQOYUKRe+cB+HWLxtUxtzxYi
 mQdhE3Zt0/CsFisakusnI0eik+klDm2Mbp5QHsEvCl65cbKpfN54c7JETSafuOaMIfxvkjtcD0Y
 jFvRylY6tfyklhufs1i/KGD6faySJYTS4rhT8Jd4vHTxFYa7uXOY2lRgjiVPi7VcRfx7vZKSTtg
 gs2/dnX/AA==
X-Received: by 2002:a17:90a:cf0c:b0:39e:6c6a:20a1 with SMTP id
 98e67ed59e1d1-39e6c6a22aamr3921834a91.66.1789856790138; 
 Sat, 19 Sep 2026 15:26:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6ca4ef3esm6351460a91.1.2026.09.19.15.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:26:29 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: bhelgaas@google.com,
	airlied@redhat.com
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and clear
 removed pci_dev
Date: Sat, 19 Sep 2026 22:26:29 +0000
Message-ID: <20260919222629.3798073-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Fix two issues in drivers/pci/vgaarb.c:

1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
   returns 0 on success and a negative errno on failure, so checking if
   (!vga_tryget(...)) is inverted and skips unlocking on success.
2. In vga_arbiter_del_pci_device(), clear any open vga_arb_user_init
   priv->target references pointing to the removed pci_dev so subsequent
   writes or close() on /dev/vga_arbiter do not dereference a freed
   pci_dev.

Fixes: 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to drivers/pci")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3de05aee7859..4f13e542505a 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -818,11 +818,33 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	return false;
 }
 
+#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
+#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
+
+/* Each user has an array of these, tracking which cards have locks */
+struct vga_arb_user_card {
+	struct pci_dev *pdev;
+	unsigned int mem_cnt;
+	unsigned int io_cnt;
+};
+
+struct vga_arb_private {
+	struct list_head list;
+	struct pci_dev *target;
+	struct vga_arb_user_card cards[MAX_USER_CARDS];
+	spinlock_t lock;
+};
+
+static LIST_HEAD(vga_user_list);
+static DEFINE_SPINLOCK(vga_user_lock);
+
 static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 {
 	struct vga_device *vgadev;
+	struct vga_arb_private *priv;
 	unsigned long flags;
 	bool ret = true;
+	int i;
 
 	spin_lock_irqsave(&vga_lock, flags);
 	vgadev = vgadev_find(pdev);
@@ -845,6 +867,21 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	wake_up_all(&vga_wait_queue);
 bail:
 	spin_unlock_irqrestore(&vga_lock, flags);
+	if (ret) {
+		spin_lock_irqsave(&vga_user_lock, flags);
+		list_for_each_entry(priv, &vga_user_list, list) {
+			if (priv->target == pdev)
+				priv->target = PCI_INVALID_CARD;
+			for (i = 0; i < MAX_USER_CARDS; i++) {
+				if (priv->cards[i].pdev == pdev) {
+					priv->cards[i].pdev = PCI_INVALID_CARD;
+					priv->cards[i].io_cnt = 0;
+					priv->cards[i].mem_cnt = 0;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&vga_user_lock, flags);
+	}
 	kfree(vgadev);
 	return ret;
 }
@@ -1025,27 +1062,6 @@ EXPORT_SYMBOL(vga_client_register);
  * the arbiter.
  */
 
-#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
-#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
-
-/* Each user has an array of these, tracking which cards have locks */
-struct vga_arb_user_card {
-	struct pci_dev *pdev;
-	unsigned int mem_cnt;
-	unsigned int io_cnt;
-};
-
-struct vga_arb_private {
-	struct list_head list;
-	struct pci_dev *target;
-	struct vga_arb_user_card cards[MAX_USER_CARDS];
-	spinlock_t lock;
-};
-
-static LIST_HEAD(vga_user_list);
-static DEFINE_SPINLOCK(vga_user_lock);
-
-
 /*
  * Take a string in the format: "PCI:domain:bus:dev.fn" and return the
  * respective values. If the string is not in this format, return 0.
@@ -1168,7 +1184,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		}
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1215,7 +1231,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		}
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1266,12 +1282,12 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		 */
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
 
-		if (vga_tryget(pdev, io_state)) {
+		if (vga_tryget(pdev, io_state) == 0) {
 			/* Update the client's locks lists... */
 			for (i = 0; i < MAX_USER_CARDS; i++) {
 				if (priv->cards[i].pdev == pdev) {
@@ -1335,7 +1351,8 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		for (i = 0; i < MAX_USER_CARDS; i++) {
 			if (priv->cards[i].pdev == pdev)
 				break;
-			if (priv->cards[i].pdev == NULL) {
+			if (priv->cards[i].pdev == NULL ||
+			    priv->cards[i].pdev == PCI_INVALID_CARD) {
 				priv->cards[i].pdev = pdev;
 				priv->cards[i].io_cnt = 0;
 				priv->cards[i].mem_cnt = 0;
@@ -1366,7 +1383,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1429,7 +1446,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 	list_del(&priv->list);
 	for (i = 0; i < MAX_USER_CARDS; i++) {
 		uc = &priv->cards[i];
-		if (uc->pdev == NULL)
+		if (uc->pdev == NULL || uc->pdev == PCI_INVALID_CARD)
 			continue;
 		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
 			uc->io_cnt, uc->mem_cnt);
