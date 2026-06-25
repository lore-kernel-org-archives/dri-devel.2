Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9667CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E993C10E1E3;
	Thu, 25 Jun 2026 11:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MPWVywPJ";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728C710E1E3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:02:49 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30b6dad2382so3777967eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782385369; x=1782990169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzVXIO2M/zZGRMQrA3as78zSud+6/fQ7nehrf8i6Zh4=;
 b=MPWVywPJiOs0EqAiA/3nca1eN4x9XEP0QhuylbBETeZGr8cVbytUI5bDdOW3KeR9t4
 R2ouCW8X2yK6AqgI+fZYRBCCEK7pUcPzRdMSn4TzeyCPI/L+rLSA4mnIMt2e5uwi5ju9
 41Owi6YL0sqFDEiyH2ZnUJUYpYswV8P3gPKaEfwlrHzxn8HlJ21JG7h7sExvtN6NIYsU
 WKgsDxtV677yMl4cMt8/K80EqvbA/vfqxXCJ/A4fvR2xOBwcw+Y+8OtaBTSmkf7OTm36
 Il0qhYcrgwsZINgoZ1jkEASfIHID7KbzJjSbl1/EWjGk3eUrfy9K5KejRokFx/f6gTmv
 Wn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385369; x=1782990169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dzVXIO2M/zZGRMQrA3as78zSud+6/fQ7nehrf8i6Zh4=;
 b=PVABMsnYgUaZ7w6HJS0ZRu7uoBE9B2+KDsNij6eM2azVWrot9TCdQANBAlJPq6GfaC
 eS/UnWGINogPcfjLXjnQkExmpW3AHilSdKioH7UeBrKfEK1r2FTkFDrGC91BOjyA/rVm
 VsRSFRUd3VFxBLlSmVsLsvHs6pFxIKxlDdbMX16Cnr2ao7G7PYSzfp9YVjf2A/6O+eY7
 sbUydiGVC8PYmfaOkIMbsKDoIesvVOSY0LhcHNjn/S7jN4ADqNsD+571PTaayCXmnsxH
 UKYmPfPa+EzVan6atwl2QePUjRKEYLZotG6bGQqlrrrR63bAgrS5Zd47FldpTU9bsSk+
 4ONA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsixUHK4XhQjNjzrXXW/1DtfCIO/9ZWV9iUfVy/H72oKSywers0bTW+pdSHnQVoemXpHTJwnGuNVI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjfkt46U9cIIP5hljjvBDRvgUz/i4vSd/di0o3EvMkaDC8zEMB
 BppAed4nCc6mjtsCuuiTGnhGA2x3cscae4Lbi/vdUHQLMNHyHaY5euiG
X-Gm-Gg: AfdE7clR6H9ExQTWg+9/4rCO573u1uircBbFZNYyu/5688mcURwqFTt6KT9OOebTXnM
 GRO2e4u0MRQcGyIxP0xA89BstNRuwvH0Da7/pMEqleqYEuwZf31211j+AZVukKSoewJjyH+eyya
 Ppo6u8omG3dKv7yYVyM+PSPImY6MyaClXqnd0zRw++xcWLR76eTanGJ8IbLsHynnsdJubFpP8sj
 p2gXHN5pFA2j2hcTRctEd/yqnrI5f4jCohpk2yeGMrr/AKqnC4VwDaQn7MA2/Vgn3K+SbA+SLvW
 WnQCjpTDEjrQPp92ka0EH0TEj8HW5MzmeLB3lXDg2l4BLAnEPo3M/5piwXH3NoU6/YSWnhnDjt5
 QGiSem1VZpFQ4LDIl9JvIH5XMXrAqElo18UjFT82wtG+oxWT6tdZTlRpQN14pPB/lvpU4BuhnwY
 Zp0KQjN74Bbnxs+PVylgcKYt421E/VG7TGAeD+M6IYep2M
X-Received: by 2002:a05:7300:8606:b0:30c:5807:abc7 with SMTP id
 5a478bee46e88-30c84cac264mr2452317eec.17.1782385368531; 
 Thu, 25 Jun 2026 04:02:48 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca87caasm7229314eec.27.2026.06.25.04.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 04:02:48 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Date: Thu, 25 Jun 2026 19:02:37 +0800
Message-ID: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
References: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
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

fbtft_write_vmem16_bus8() and fb_ra8875's write_vmem16_bus8() offset
txbuf16 by one byte for a command/start prefix, then store 16-bit pixel
data via txbuf16[i]. On strict-alignment architectures this can fault
the same way as the write_reg path fixed in the previous patch.

Use put_unaligned() for these stores.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 3 ++-
 drivers/staging/fbtft/fbtft-bus.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..5b95b0095 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/unaligned.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -262,7 +263,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index cfcf4d7e7..fc3faab7d 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -158,7 +158,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
-- 
2.47.3

