Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0C2CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BA810E249;
	Sat, 10 Oct 2026 11:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VU/Cfc5U";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id DD12010EEB8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [4.194.122.162])
 by linux.microsoft.com (Postfix) with ESMTPSA id D587520B7168;
 Fri,  9 Oct 2026 08:45:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D587520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791560740;
 bh=OPNpKz6OHklbJCYVRtqhmrTLvTXsKAqbS+7QlmXkvaI=;
 h=From:To:Cc:Subject:Date:From;
 b=VU/Cfc5UHkvAXTpc0qzynMKbbdWrmHeuiwj7u5CtcZeQPAZBCIaoxaWUQEj4lpnbH
 DBtbWkCFrIzuBS/pm+uOTba8GagA64Ib83AYYRdG/GCIFYXtx505DQr5wcnWR6ZfYI
 cyVn6H7UEGVkaeDHjdI1gwyZoFggp3CLsrza1Nro=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Cen Zhang <cenzhang@linux.microsoft.com>,
 Hungyu Lin <dennylin0707@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: update outdated struct fbtft_ops comment
Date: Fri,  9 Oct 2026 11:45:26 -0400
Message-ID: <20261009154526.43528-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

Correct struct fbtft_ops outdated kernel-doc comment: 1) update
field write_reg to write_register; 2) remove non-existing field
free_gpios.

Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 drivers/staging/fbtft/fbtft.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7afb0fd3943..40a7567df1eb 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -37,7 +37,7 @@ struct fbtft_par;
  * @write: Writes to interface bus
  * @read: Reads from interface bus
  * @write_vmem: Writes video memory to display
- * @write_reg: Writes to controller register
+ * @write_register: Writes to controller register
  * @set_addr_win: Set the GRAM update window
  * @reset: Reset the LCD controller
  * @mkdirty: Marks display lines for update
@@ -46,7 +46,6 @@ struct fbtft_par;
  * @blank: Blank the display (optional)
  * @request_gpios_match: Do pinname to gpio matching
  * @request_gpios: Request gpios from the kernel
- * @free_gpios: Free previously requested gpios
  * @verify_gpios: Verify that necessary gpios is present (optional)
  * @register_backlight: Used to register backlight device (optional)
  * @unregister_backlight: Unregister backlight device (optional)
-- 
2.55.0

