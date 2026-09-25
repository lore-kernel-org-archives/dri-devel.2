Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592FC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9375E10E896;
	Mon, 28 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHlywOEA";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9AC10E281
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:48:12 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so5146575e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340490; x=1790945290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L4PIEXS1O+9+24VT1vn/XjTFXnHCWV+rBSZ2OYKFHlQ=;
 b=NHlywOEARJOIEqXEg2D1nwNS1DgATA7PkhlZEiOrZLmt2snHMHk9ZD2pL/BFMOcWn1
 KiYSVEnzr/k/E40I2fDh5mAD9j9bqkfozl3sM5o+ToV/3sRev0/FHzvZ40V/1QMNEJNC
 dqt0s/0Djv6YEOastuOevvJd/A99pdzyBFAiseDZcL0wduiOFa48/nZck+Pl+naDc5Wx
 oPZqCMhaM/95iR0bm+qa/xww2/+LNlFI38RpL+hCsdAE8gShTMwe2wK0Y+qJzKoyiHx/
 beqlu0KG18yVbJqTVMmjXACxA9MFboagXdqDYftsBYSMgGvwk8+wIP+Gp/lATO6irrPN
 owEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340490; x=1790945290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L4PIEXS1O+9+24VT1vn/XjTFXnHCWV+rBSZ2OYKFHlQ=;
 b=RPkp9ftSTIlpMqUdmbQap3IFOMSjYF+YrA+vXPCgl//XI2oBZOYcc/YWHMOGLnWbcD
 XW+m98IlzBPkhBCr216HKRY66RF2pSKFITjafZUtJWC6F/awXGGFX76gpqnF1MCTxAoJ
 9Q/3hAVSXmrbQv2oJ52mhJ87GpGQsiPHI/VKupftxLbv0OmNiPovZGrkQgBYE/kE64tG
 91Own8XSjWqzky+GvkwqGYCpuQeJ4Gy4sLulzn1y+OiaCav6KdJFvBMIo76BBEHPpjkM
 JOMUsxi7PsLCBnwaVKiWH9ud/1oAJvHatfO7ka9nIOWmQYcLplaRkBaLKbLn47C7YGtb
 U+jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFPcHGSx/pcXWO+FlOfxlChqwXjeINEIPDjXQ0+FbfMGqNfzZSZ8VLOQpKNgDssoYxdb1S5tSuvNA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lukbj6rv1EKbrRCdwI7TSiCTYZHopMftylCO45Ksdwac3YLcn3
 WPJkWf3fV6QE/Hfcow92AnN47ypXnao4WJtJ6PLClkWXCUAusr4DaI5TM/fbMw==
X-Gm-Gg: AYBFou2WZGYKUe3Tixs0TCHgeTHS7VBY1gTGwe+VQpNgBZJ4Zkl7WxC2+Nf6xPlbdZ9
 ZRRe6krGNxPeHgD2YfrR0j5bAfGz/Y1gX+fJXIHNKDzzC+Watv41XBJC15975Bx8idhXVhM7QDh
 QGl/dXTeua1A9B6lECS1Ew8Ri/gK69PDpNLfunEvOyeYGn5U5p8Ya24nB4o0URpNEuIqx6o7OBq
 fKshZJuT5RO0yq1ZWeVOgoOvU7J0aCV5k9uk31Ya7OmXgONiP+8jIvQIK+QTeLVdIPM4S24Mpit
 4hGRiaVcWLy8c8CprRyrlsF72MZP+/wGjMN2Y8xhHNCe7DtngimbBiH7w2wqLPbZrC1MBt0uXBM
 kAJDHVIdDaFt2d4fp/wAfD38LJMoY5F7axN3ciOhO/puD1x9I6VG0jZjZ2xQcNam7TAZ17pAOvk
 YCI14YbmV19L7cWxYddZZ5jjeqt6OoGH27o+rANEoxrMOMPvvtZlezQpRA7v8=
X-Received: by 2002:a05:600c:4f4d:b0:49c:dadb:18a7 with SMTP id
 5b1f17b1804b1-49fe66cbb21mr116104615e9.10.1790340490347; 
 Fri, 25 Sep 2026 05:48:10 -0700 (PDT)
Received: from fedora ([2a02:587:200f:d100:bf67:f785:caad:e278])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm6670499f8f.21.2026.09.25.05.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:48:09 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mail@taterr.org
Subject: [PATCH 1/2] accel/amdxdna: Replace create_singlethread_workqueue with
 alloc_ordered_workqueue
Date: Fri, 25 Sep 2026 15:48:03 +0300
Message-ID: <20260925124804.58808-2-mail@taterr.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925124804.58808-1-mail@taterr.org>
References: <20260925124804.58808-1-mail@taterr.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() to use the shared system workqueue

infrastructure more efficiently.

WQ_MEM_RECLAIM is added to ensure the mailbox can process

interrupts under memory pressure.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index cc8865f4e79c..05c3786de135 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -481,7 +481,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 		return NULL;
 
 	INIT_WORK(&mb_chann->rx_work, mailbox_rx_worker);
-	mb_chann->work_q = create_singlethread_workqueue(MAILBOX_NAME);
+	mb_chann->work_q = alloc_ordered_workqueue(MAILBOX_NAME, WQ_MEM_RECLAIM);
 	if (!mb_chann->work_q) {
 		MB_ERR(mb_chann, "Create workqueue failed");
 		goto free_chann;
-- 
2.55.0

