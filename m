Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B701C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BE310E662;
	Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQz6quij";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1AD710E366
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 20:06:52 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so31551535e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786133211; x=1786738011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DcvzOP3DsrMH8W1cQwtr2Rj2FiH385dungW6zjf9cLs=;
 b=eQz6quijIbyZ7+f+iX9O1nJmuWZtyAGFYzZl4wTR6Uh1vQKwzaqtA2D43QkEpOLsBP
 evfOpzMJl2M0dTbHN+GG5elmpkdKc5iBvJULwk9O4+gv5mLD2Cf+QHymCtFXY8gdgV+a
 BQK306NMF25QQv/Lg1CsHaAx2i/XEXiERrTbALuTWrbXxdpFGwwyDopvPplomlrQ2Z5a
 ZETyps/UF1zBNkwzxx/XcvSw2VoQcMGuE+Iu2UMLlGfWpSqZJtqzdxUz87Hrepeb2RM1
 gExPFex0/GvoENHeBpL+gcV0xXbVvso8X4ukkEX2JgCPnu2LOY1dJlySukX04C5zYHvE
 QJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786133211; x=1786738011;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DcvzOP3DsrMH8W1cQwtr2Rj2FiH385dungW6zjf9cLs=;
 b=jg4klncZ8ySmU+FWRIsM6Rbss50A6h+8ip6S2Uuv9i0SdhJU8MexER5eoD5DEOYp/Q
 PZ6MbF6NZlzLSewiRTBqG7LERRX8YhMSYLA/HMhL/AA5ie60xPX2TtSg7Ks6I+5/+rf3
 HTOxikkylkYtJPXorE1J8li6gG66U41IjPchzzcmv09EoLWc7bYVTn6jIPIh3S8SBUly
 8nnS/vTl5ecf1P3cv3WhrdQWgyaZnxKqY6tjpNOEi469KT5zDuYyH/SS65hjzbNc6Qwy
 nlExzSRM6nWbNmLkTscVGm2WeOfvvNTKJhnEaSP5hb5Rqnq64RuIhgKz4MgrA2iAyuM/
 ZECA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrO2xlSPnK27T2rIiUCVPm7OLguAguce2xTlrL85M0E1yHUHz4OzzLz4vw6v60/YPtRglQod0WgJsk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwurRME8v7IRfyA/gEbg58mBqccnGaMybdUHtNG4pHQSxZdtmVT
 2UtPSmddF8FebipZpiKUpcb8AWd4DeayqMU1QGMX3QuLEokN15iIJa29
X-Gm-Gg: AR+sD12V6Sy0A77uwmRXufnEUN5rBEECPodYKC2cLNa0Pu4gOO230RSrKYSC+ACo5iH
 6IVpMsJOX/LM1wQUfUTiSgFuDM4xl2dIIe+PEJSDHUH+cwkmpGXi90fqllRNY0K1pJccvxlz93z
 OBKtjQ34y0Hb3EHjsD4aLOk5dNyJIHk1ewNp9UiQYkr/qnrGciKLVEt10AXXt3VPidKzsXZkU8f
 F/z75vwJXj/qBsEH+4wU1O3bBGKAvFCJXQvksBElHK8y543sufXVNNGXgq/dxMMYJWQFAT28ube
 OesxvOSJRlsTsna0N8TwtHhfmDo079pZv0eGl88uBC7szRZevQzPLMgb2lN7539vEWv2VGyBrHt
 thPhZ182ZlQt61XG2cWl90TBgRoprrE8+zwRsI5/jGPqEc64oknt97iK8hg343VsWFF1MATf7FF
 lwXrlw2rdITYzPQyKWIXl7RiTSUI9dlXIdWtIYIaTrn+AQ64pF/Tk4lYa2dZwqpsjYJUGSdRBE5
 nFP8yGkms6IxbmziZ0f
X-Received: by 2002:a05:600c:1991:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-4994e7448d9mr312485465e9.2.1786133211126; 
 Fri, 07 Aug 2026 13:06:51 -0700 (PDT)
Received: from christian-ThinkPad-T470..
 ([2a03:4460:170d:5700:848a:c270:b637:504d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9eb1a0sm67283895e9.5.2026.08.07.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 13:06:50 -0700 (PDT)
From: =?UTF-8?q?Christian=20Melendez=20Nu=C3=B1ez?= <chrismelnu@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
 skhan@linuxfoundation.org,
 =?UTF-8?q?Christian=20Melendez=20Nu=C3=B1ez?= <chrismelnu@gmail.com>
Subject: [PATCH] PCI: vgaarb: Remove stale "not implemented" notes from docs
Date: Fri,  7 Aug 2026 22:06:39 +0200
Message-Id: <20260807200639.172487-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

The vgaarb kerneldoc and Documentation/gpu/vgaarbiter.rst both
describe "unlock all" and "target default" as "(TODO: not
implemented yet)". Both are actually implemented already:

- "unlock all" is handled in vga_arb_write() via the "all"
  strncmp branch, which releases both VGA_RSRC_LEGACY_IO and
  VGA_RSRC_LEGACY_MEM.
- "target default" is handled in the same function via the
  "default" strncmp branch, which resolves the target to
  vga_default_device().

Drop the stale disclaimers so the documentation matches actual
behavior.

This is my first submission to the kernel; happy to take any
feedback on the patch itself or how I should be doing this.

Signed-off-by: Christian Melendez Nuñez <chrismelnu@gmail.com>
---
 Documentation/gpu/vgaarbiter.rst | 9 ++++-----
 drivers/pci/vgaarb.c             | 7 +++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbiter.rst
index d1e953712cc2..c3a728130b54 100644
--- a/Documentation/gpu/vgaarbiter.rst
+++ b/Documentation/gpu/vgaarbiter.rst
@@ -65,8 +65,7 @@ write
         unlock <io_state>
                 release locks on target
         unlock all
-                release all locks on target held by this user (not implemented
-                yet)
+                release all locks on target held by this user
         decodes <io_state>
                 set the legacy decoding attributes for the card
 
@@ -74,9 +73,9 @@ write
                 event if something changes on any card (not just the target)
 
         card_ID is of the form "PCI:domain:bus:dev.fn". It can be set to "default"
-        to go back to the system default card (TODO: not implemented yet). Currently,
-        only PCI is supported as a prefix, but the userland API may support other bus
-        types in the future, even if the current kernel implementation doesn't.
+        to go back to the system default card. Currently, only PCI is supported
+        as a prefix, but the userland API may support other bus types in the
+        future, even if the current kernel implementation doesn't.
 
 Note about locks:
 
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c360eee11dd9..4ae96ae60d8b 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1008,10 +1008,9 @@ EXPORT_SYMBOL(vga_client_register);
  * poll         : event if something change on any card (not just the target)
  *
  * card_ID is of the form "PCI:domain:bus:dev.fn". It can be set to "default"
- * to go back to the system default card (TODO: not implemented yet).
- * Currently, only PCI is supported as a prefix, but the userland API may
- * support other bus types in the future, even if the current kernel
- * implementation doesn't.
+ * to go back to the system default card. Currently, only PCI is supported
+ * as a prefix, but the userland API may support other bus types in the
+ * future, even if the current kernel implementation doesn't.
  *
  * Note about locks:
  *
-- 
2.34.1

