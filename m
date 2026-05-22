Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3529CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A9D10F522;
	Fri, 22 May 2026 09:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RSSiPJ09";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294DC10F522
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779442340; x=1810978340;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ss07EqoOEgnt+ffV1eGslq5YP8Ithn3lmC7SElIeWec=;
 b=RSSiPJ09CWssXHVHLrMzytkN/BLoL1wGgQ4n1VbxUepl/ulk8fH53/al
 6am/udZsXMxZlL6370eTyZwFPATqGvDXcjZ0D7Mow3rs9s4KQ5tn/HC92
 rGnxMdvrEfU2927kXGPYRt1Ka+JSGoVW6TbFYu8GUrS1jNQnwH1jWLjyk
 KTaFGU2RWdSS09+U4BSvWLkL9DE3676JNPVIe/PaSvvFZlCapZnl9klBK
 t34sTWlg2P+iEiREBEHCVtpI7BsEfwCfqZCGOLaBbh5vWBlVseAq3kEyq
 t7oxEs59LFm8WQb36Jn58MkJhE9CkRX476YVFm8M6nH++0B49i+60lCCA A==;
X-CSE-ConnectionGUID: TVoghmL+R8KLVSVYS5MqFw==
X-CSE-MsgGUID: K2vPfgQZQVifUfH/Dk12jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91478618"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="91478618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:32:19 -0700
X-CSE-ConnectionGUID: k24i/wThS0SPhGSF7ssydA==
X-CSE-MsgGUID: 1/VPH5i+SY2djrHcDdTRnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="240029127"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:32:18 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 lizhi.hou@amd.com, Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Document why full JSM message size is always used
Date: Fri, 22 May 2026 11:32:09 +0200
Message-ID: <20260522093209.1169716-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

Firmware expects IPC messages to always carry the full fixed
sizeof(struct vpu_jsm_msg) size. Sending the full struct also
ensures unused fields are zeroed, which maintains compatibility
when existing commands are extended with new fields in the future.

Replace the misleading TODO comment with an explanation of the
actual intent.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..9f1ba0c57442 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -97,7 +97,11 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 
 	memset(tx_buf, 0, sizeof(*tx_buf));
 	tx_buf->ipc.data_addr = jsm_vpu_addr;
-	/* TODO: Set data_size to actual JSM message size, not union of all messages */
+	/*
+	 * Firmware expects full JSM message size regardless of the payload size.
+	 * Unused fields must be zeroed to allow future extensions of existing
+	 * commands without breaking compatibility.
+	 */
 	tx_buf->ipc.data_size = sizeof(*req);
 	tx_buf->ipc.channel = cons->channel;
 	tx_buf->ipc.src_node = 0;
-- 
2.43.0

