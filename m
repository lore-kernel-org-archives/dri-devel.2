Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19C8C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6CE10F759;
	Tue, 15 Sep 2026 00:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MwdRbq3b";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7373710F759
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 00:52:52 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-93910ad20d4so332041585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789433571; x=1790038371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
 b=MwdRbq3bYHQ8zjY9M2Oo0uFqg3OasZxnFxAXDzA3S2sNHrqWx6LdkW9LpMFZd5TJWB
 g/JdYuDo4QO/wNWAf7m+h7ZeG5vVGRvuYbeIzT5AXBuK2fj6WGA9c2CikzfwnoUXM3fr
 ihImQFT3FJMMPpHljQ6uSmz3l50bdiyXyd/sHNn+vei0WvzcOS83npuE9j03y5PJU633
 To42OtaflPE5iOmh71nW+61hdoI4/mlaTVeIVSpMpFopwDGY199KJAZ2dtnjz/TRZrr0
 FDFK0S3L8tIStwyoBBQZzq3OFPuwi33vc2ypDy0/bhRJHRMxSUmnxS1JTf6i3ZAzES6B
 ySjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433571; x=1790038371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
 b=XSs6fZEZMQCkhJNJy/Uw7v+kk37JUJB6S2bSvaboqiAfwsiVNiBFG2VpD493dGolBy
 3a8A50uqIjSucOHT+wlda8ze0WSFwOo8vLVNoEbvRfqJdCR4jdxreKqNcAO4h6FN97/h
 oGdi98O2F5ui14dxWvucwyEV8kcDsiZCfVepKBptXJ0isLUzqJIQmJvN3Yusm3ZJyDX8
 hqeD0sk+8e6LD9zHCABdpGAG4+lwZTjLit23z3M8xse6umCvEA35qY6Esy4IATnT2LtY
 mbtm8WH5DPcftyWcy43XSX4lAeOfwp+hHyzUd1zx9j2j4moNsk95Nx4B7uTIXZ6u5V4c
 qi1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdKlpetozRuB22EdUlz2GHYqLjpA37RSzLG0tPkMwDSBZ89XZoezU80PeuLvNwq7RScA8hY+msLn0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nCj/XExp9ym7XG9yxMympyz/XxYggjeTlsIBb5JArbjfsT5FjS
 a3sh+wEGF3oCsd39Lltc5dFH5ozp3R3NGwYaoycEC6jhigRh6G31gAY=
X-Gm-Gg: AYBFou0duRLrTBqlGZ85Wz21aHxW7M1PWtJcYaRjR75jE1vimOGmmAFgbovsAxpST6T
 Qszzem8VBNulIKrimcMqmP/CokYu0oHybO3LbNRCtZNC0hVPvnobX+7XvENfyiAekHbxicC4v43
 OTtCJgAHGZAbGc1x0xyFh8unjYp3qEmuv86Pdtwuvodty2NDYmuZxRmJEnkAa653HIgrVUI7zdn
 HbOiS147n5ilWWae9lzgRZ1UO/QZIud4+XepTOccJ5QzWRzmlFKnP6wgm5qIWueGcseLYmhNpFR
 GV8zNSH6xP3OHixhq/oqS/ie/cDvBIotKufwtITwxJNcqH8+cSGpLz1H45GU16Cbvt8yVrtOjZQ
 xOhHcurQ/QW2pWIeVcUA0v3lZnLe8WrkScBULcfsHUIhP1iP4T9xaPCexzG/OYhwrCRRZ5TAEBO
 bKX7s9jFcBfON/UsZBhdT5wb3Ocdj8/uOuFmZKonfb2mxOW2BBse0ZEvy3S/Y0LZoPS0iNdaTSP
 XH75izwiyvNUkN4m1mnC05TCLADBJ9MH1BxCp6Il6jo8IdJn1OocZUa4SnS+bn135FJ81qNBI9F
 yDDv0IgGLwDkyUVysfMm2GuMumi/Fku/lhzjcblTBHQY3DDY8bk5n9eP12Wg93KG
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id
 af79cd13be357-93a29bbcd86mr667300585a.46.1789433571426; 
 Mon, 14 Sep 2026 17:52:51 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu.
 [104.39.213.233]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939ecea9f35sm1063205785a.7.2026.09.14.17.52.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Sep 2026 17:52:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] fbdev: kyro: Release WC setup on registration failure
Date: Mon, 14 Sep 2026 20:52:43 -0400
Message-ID: <20260915005243.51683-1-mhun512@gmail.com>
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

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -759,7 +759,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -776,6 +776,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.51.0
