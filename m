Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE37606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAiu/p+e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610FE1127BF;
	Fri, 13 Nov 2026 20:26:35 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B661127BF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:29 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8b3a332105bso13473507b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601588; x=1795206388; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACtBojgkJYvWFPbdR17zwfA0g6+tH3oTHvApRUpv8tg=;
 b=iAiu/p+enFfeUhBB5ttPA680Hj6ARZ960XZCoHx510AKveOtI4DiKUnDSptnfYBj6q
 hZIOPIPFFvgTM3QbbLnAJIM8qQKiA813eV/mZo/ao6mOlwrainFJibQVm85eAfbXbpGM
 AZoGfsjd1U/6pZJEWhxfJS0DQl1qVBQMOmkWvwBtXUNAA6vkgkjyoROdLYTMwi1RQMMM
 k1wdra578WEx21N3PLB8MV/RqGt/iiYlWNRJd9y0AvKm9jJPs3muoMDa48YbZSfNcowl
 NazYHgNqZwbFu4mgH3Wc2D/rwM5/pUQQkA8btj9YEU6/cGXA7knmCzt6udzUaTZkiiVU
 SwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601588; x=1795206388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ACtBojgkJYvWFPbdR17zwfA0g6+tH3oTHvApRUpv8tg=;
 b=pS7j3z61JU+xWF+/mHta/DZs79b4i687RG4fK8rDWFPRsH5CWuhTXXcsuOUj+n5XIM
 vZesOkQM8+X4Imt2YL5toSOpic3OSFHCMjIunpubDFxgTkrp59jAcNxgwN89DirpIPa9
 x1S+rT5VIe3Nuo21WO8jiXqCgW2cCgwyqlxu7Y2xx9wU3T2/4kELiBU2jjW+OFAH9tgn
 wiH2DWZAyOhDNJKUCYNxv31HTFL9FmN87swQoX02/wjPxJu+mLlQXkZ0BJBfI+P8lzYT
 /IpIZdw79QXT5UI9Yg07mlpnYUlHDEJtaqI0tBbTkaGxXMCPv4vt6L9YWazURPvaAe+4
 AZpw==
X-Gm-Message-State: APuU4Z8ENPGeFfoqe3N5G4wTUvq0bT2JBMucvEFpyZOlvX6IeC6oAls5
 FGlN+GB77NAszVcBe5i2QZ90lFWkpLYiJsmuWGmDAQnigETqehYW3Nb7EbSpRWPvxTA=
X-Gm-Gg: AYBFou0hOVXZN6mvDdHAHBck93hGQqnBEnSNLoyiqFG+Ubw8YZ+anlaxqgtQFIu66dD
 IMMI+es9zxH3XnQhY+fLA6mMywn5gurCFNFS3PewH4Y142V09sy/YPyE3Ky0tK0AqwdNGyZCh6d
 DhRFC9P4KboPlKn/EkYL4PYOESX1X0ah7S3RZEUvxvwGTmRwsYN1AfwgpX+UjNHCTnUIj2nz6c8
 kg7KaqNR+VC7/sPMNAgHzaNAW8k/zHvsUixP57Xs5VePFXisSVo2c2SprYv99833tI2mlZaNXCT
 8UY7vRpi93Ex6FyynmheXdLSpr+NlvTYTMSf3+4a8/TOlc2XCcoMZeoWsc7zXkN/TY/4rYjV7Kh
 zV+HnuZO+b+zcWqMnfWxIFvidTAdBOGNsNwTI1kdrVXZXL3qPbeqqlgUdIwHzyGMpTHHAbXg6S7
 hUlR7qe21PccYZxrR3TjRUSTpb/N7MhIHIoFPclxqoGwR+4qE7pY0FJxe1FcdtYxrAKlM7psx7c
 waz33YWnnNoMQYgM+B+8Yvb+HUYKOeIvANaXDUbWYEcOqokDqq2Os3Qfz1MNe8ndB7kL+cgW/ja
 CjK4g7LBntKmtsUZ3n+WHFKsjdxDxnzHbSB2Xn+gfHcs0AqXm2ur97iv5qPW2JD8/CE=
X-Received: by 2002:a05:690c:f15:b0:8b0:a01e:2ce2 with SMTP id
 00721157ae682-8b3bb1a2e7bmr43823437b3.15.1794601588157; 
 Fri, 13 Nov 2026 12:26:28 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8ea7c4sm29068767b3.10.2026.11.13.12.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:27 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 6/10] drm/gma500: remove the stolen MMU mapping at its load
 address
Date: Fri, 13 Nov 2026 17:26:23 -0300
Message-ID: <20261113202623.15569-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Load maps stolen pages at gtt.gatt_start, but unload removes them from
mmu_gatt_start (0xe0000000). Unless these happen to match, unload visits
an unrelated range. Use the same GATT start as load. The independent
removal-hole fix also prevents allocating tables for absent mappings.

Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d17cb5b4a4bf2d80e8fa0e83dd09cabff5b20fe1..4102b6de69a2c5b15e74a67676190a8f13c6031d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -189,7 +189,7 @@
 		psb_mmu_remove_pfn_sequence(
 			psb_mmu_get_default_pd
 			(dev_priv->mmu),
-			pg->mmu_gatt_start,
+			pg->gatt_start,
 			dev_priv->vram_stolen_size >> PAGE_SHIFT);
 		psb_mmu_driver_takedown(dev_priv->mmu);
 		dev_priv->mmu = NULL;
