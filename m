Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77E0C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF2510F7DC;
	Tue, 15 Sep 2026 00:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiuJyu5X";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE64C10F7DC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 00:38:47 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-93a0bf264a4so236875985a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789432726; x=1790037526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CB0/Ut2q4k6domqU+GFMH7n96krlT2PxA2EBOCoxQxI=;
 b=LiuJyu5XbLtCNSGXuxgaQ6tiQcIUCLq/4/2OL6awma0zzYnzYJ00aJ1bii+3hG5NrM
 RJbWIwojalJYsQAZMkxmsF2T1yurQjcv4gVYRsD7kqLHkUSb4cR0v5+bzbblDtM6/nY6
 Qq1Gz7R79E3ecfb0nuQtknnKUY47gU7HfkWGcxTqxUox5mLJir50H1TBJGhWvJ8MmlsF
 tfQoxAX4wB67GDO0qJnF7gjUZ+b+Y9p/nhZuwdbe9M3/+I+Ex9/fJ+1/i8KrqtleaVZs
 ZSFejrpd5AeD0QMU105oVOLa2idPIcsTlQ7ZxlyfddzOgIELWHqy9z6HaJB+Z7pCdBPl
 lhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432726; x=1790037526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CB0/Ut2q4k6domqU+GFMH7n96krlT2PxA2EBOCoxQxI=;
 b=HlpibSfdMydxwqzvsF95S983CZ2RtViYUdAirIWJmN62ic5zI1lsejsx2DFug9Fc9f
 sCs/afAAsUd9O4G4WJTH/5xF0yGUcIitd1uG/Pwi+6G7XC/f2jaP/SYa/b2PUC4go5UR
 opPlVf1bxy7ERR7WOHqpArKXhJe876qPeaLrd0I7hciXGYvP3oJDtoTxJ2CXl9bwAlMn
 uoiv7JouJV2x/Myh89pVcZfAZPDzuBwKjw7DlUNoJptd7DqnZ8/1vGXiccrCIk/M6/wn
 wnbThkM0nRRUMSDI7atuYiaWJJnA9lqcPmZWCPtLJmelixC5ZWCmrnq2UnIpR1AcVA7j
 7tRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT2U6enLwIQcyjg8rmyjvCOWN4vlPK8orK0ent5auwoanguptbM+h1uRHUmEcOhic3WlbEPCqYw1k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcb2LjYMY2WMNRazLzk18uAbjprKG/ecMzBEDtZs5CaYU5VALX
 WY6y+mopwiDW2KcAFqkzUAI7RVAsr06krVmNFFgx9U5UsaryRxx6XBA=
X-Gm-Gg: AYBFou3d/LOxSdxFLXfQ/v9VO6ElXllzTSbQWNh0S73/mY0Ih0CO25h1Ufj6AO6p6UI
 jBa1FJvmY4kK7wIR38aHMEyeNOkG6LfCR5lGO5UGu25LVS+/s9fnQrVKGHoe6Etyh4RovDx6J+3
 cZTpk0uIdDP15TDkbcJZpQ5A2U/wNALYEH4xWwUbTedu0CjRILAAzXuvGEJXqAUhDeoP57wT3aF
 5i82dit2CFYK2vENnywSZDajt2CxadX9zzDt10Z+COkmUIuO9Kj65ltFPhzgks8wDCitNxNUU/b
 hgNFh3ui0w99U1M7fJbc81swpNpcvZfnltViLB8DhQDpeWJqMNORgr5rY34fr0O9fTSVgH/rN1F
 SJKbdqYRFmZ40EXlMzTvYvNRckSvST3K/N9M4C1GzBsn2h1DL7yFpphppdH+uPHxxUDoXnA0oK9
 S6wsIf/6PRoCRrBUK3MhGt9jq0TLWirAlRA03t/AqEyhRoBrMqs90DpXpFwKiF0DVsV/sB3Sq6Q
 E5KIbdhoB/TksWV3z7o0IT82126lVh/GOzOPRo0cOvR3rn8bBRoleEgPd6A9mknruj9v7l7BAta
 GJZNXWLGlgMLj68NicWpY4Uo/yq6qmcZPJaS9wPBMem6wDtcOny50gxObcQc3UXTitcih3iDEEe
 NGxy9
X-Received: by 2002:a05:620a:890e:b0:939:710:536c with SMTP id
 af79cd13be357-93a29a11d43mr657586485a.43.1789432726516; 
 Mon, 14 Sep 2026 17:38:46 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu.
 [104.39.213.233]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a2db5f257sm247664885a.17.2026.09.14.17.38.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Sep 2026 17:38:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: gxt4500: Release WC setup on probe failure
Date: Mon, 14 Sep 2026 20:38:34 -0400
Message-ID: <20260915003834.49715-1-mhun512@gmail.com>
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

gxt4500_probe() adds a write-combining range before allocating the cmap
and registering the framebuffer. If a later step fails, the range is
not released. Add the missing cleanup before unmapping the framebuffer,
matching the successful remove path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 38fc4d45fae5 ("gxt4500: Use arch_phys_wc_* for framebuffer")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/gxt4500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -719,6 +719,7 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  err_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
  err_unmap_all:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
  err_unmap_regs:
 	iounmap(par->regs);
-- 
2.51.0
