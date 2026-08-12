Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA82C5CFEE
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA8310EF9E;
	Wed, 12 Aug 2026 12:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="LstrPoPt";
	dkim-atps=neutral
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A687F10EFA0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:28:07 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786537339;
 bh=jEFtY4BE7ooYreKyTH/v4fdDdAxYs+I4+HtSuYvGZMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LstrPoPtmKcqnQx6EDZdoAsnHPqeoC+CAjTsyQxxelsDPo1UPBXz5Kk+NmIwXaXz5
 fG6rLSBI/Ho0WNVCC274oRhtPuRj4bNar7g0oXu/+plWburEYpTnpQKNxbG4N5XfwX
 ChsBixMVyXowLvkhQg90OFrTOYIGMgpg8rkxKJKLBR04MLVkd1J8eBfojk1g3YYqUP
 voWmHzrNSHHgH3Ck7DUK7+BXK8dIbEWTre9LDwtaEusG8uSoFZhRUfxuxehrKkydNx
 aV1eqkUC/IUpQ0DXtabdcV3onv+bRCDP1r3BZXmY9XthEJhTsAd6VVgA04o763l9CV
 SeIAi3jpQj7Dw==
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH 3/3] ALSA: hda: allow direct complete with a powered-off GPU
Date: Wed, 12 Aug 2026 14:22:06 +0200
Message-ID: <20260812122206.193680-4-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812122206.193680-1-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
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

Hello everyone,

The HDA controller normally needs different WAKEEN settings for runtime and
system suspend, so azx_prepare() prevents direct complete. For a switcheroo
audio client whose bound GPU is already runtime suspended and switched off,
however, the controller is physically inaccessible and cannot signal wake
events.

Resuming the HDA function during system suspend also acquires its runtime
PM supplier. This powers the discrete GPU back on only to suspend it again
and can expose failures while restoring an otherwise unused GPU.

Direct complete is now allowed when the bound VGA device is both runtime
suspended and reported off by vga_switcheroo. Active GPUs and HDA
controllers without a switcheroo binding retain the existing WAKEEN
transition.

This was tested as part of the MacBookPro15,1 hybrid graphics series on
both the 2018 and 2019 revisions. The discrete GPU remains powered off
across system suspend when it is unused, and suspend and resume complete
successfully.

Thank you for your time and consideration.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 sound/hda/controllers/intel.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 28c55c5..20ddcc5 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -334,6 +334,7 @@ enum {
 #ifdef SUPPORT_VGA_SWITCHEROO
 #define use_vga_switcheroo(chip)	((chip)->use_vga_switcheroo)
 #define needs_eld_notify_link(chip)	((chip)->bus.keep_power)
+static struct pci_dev *get_bound_vga(struct pci_dev *pci);
 #else
 #define use_vga_switcheroo(chip)	0
 #define needs_eld_notify_link(chip)	false
@@ -1016,6 +1017,28 @@ static void __azx_runtime_resume(struct azx *chip)
 		display_power(chip, false);
 }
 
+static bool azx_vga_is_powered_off(struct azx *chip)
+{
+#ifdef SUPPORT_VGA_SWITCHEROO
+	struct pci_dev *pci;
+	bool powered_off = false;
+
+	if (!use_vga_switcheroo(container_of(chip, struct hda_intel, chip)))
+		return false;
+
+	pci = get_bound_vga(chip->pci);
+	if (pci) {
+		powered_off = pm_runtime_suspended(&pci->dev) &&
+			vga_switcheroo_get_client_state(pci) == VGA_SWITCHEROO_OFF;
+		pci_dev_put(pci);
+	}
+
+	return powered_off;
+#else
+	return false;
+#endif
+}
+
 static int azx_prepare(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
@@ -1025,6 +1048,10 @@ static int azx_prepare(struct device *dev)
 		return 0;
 
 	chip = card->private_data;
+	/* A powered-off dGPU cannot signal HDA wake events. */
+	if (azx_vga_is_powered_off(chip))
+		return 1;
+
 	chip->pm_prepared = 1;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
@@ -1183,8 +1210,6 @@ static const struct dev_pm_ops azx_pm = {
 static int azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
-static struct pci_dev *get_bound_vga(struct pci_dev *pci);
-
 static void azx_vs_set_state(struct pci_dev *pci,
 			     enum vga_switcheroo_state state)
 {
-- 
2.55.0
