Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33738CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438110E83A;
	Mon,  4 May 2026 19:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YLLQaob9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8AD10E82F;
 Mon,  4 May 2026 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777922609; x=1809458609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2PcAiHZvuzlXOrAPNoxt7VKMuWTJqscxowIzWExA4Dw=;
 b=YLLQaob9RnLreBBKRX6cwNNE+mYYqRUpRqxrQRhVEI3/Gc8NvUqA8VYA
 BvHyaFaY3zFPDTee7pqjHc6spWwMW0b0pK7BqNPjXtD9OuqKxxnDzWxwF
 21RplB0lJ6wqG4Qc4e+EXdNizS1PFF2HJb6ZHSlOkU8KFz6u0jcz6tBnY
 Ggir4UXSZHeSqROZSPCT0iJK2n1S5TyVfMBHP28ekEo7heT8sF3l2hO/6
 Uu1pkjRdHG29m6lJOoALlmKzBvtiwCDpdfVmp+ApXQllql2rizvZ5W8rH
 OCjOH1EYN+FZbiKmhMGpi1tpw9KzysMaq3ZKLHzZPSi6l2iAm/w/Mz70S A==;
X-CSE-ConnectionGUID: qp7kcK72RuqktauhmX3C1w==
X-CSE-MsgGUID: DC4qml4/S1uFNCWC/8AceQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89482126"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="89482126"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 12:23:29 -0700
X-CSE-ConnectionGUID: ry3rhN9xQV+cTSt7STEMFw==
X-CSE-MsgGUID: RHOHk/7dRsW3fJviYWTtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="239565881"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 12:23:21 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: badal.nilawar@intel.com, rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
 michael.brooks@intel.com, heikki.krogerus@intel.com,
 michael.j.ruhl@intel.com, thomas.hellstrom@linux.intel.com,
 michal.winiarski@intel.com, anshuman.gupta@intel.com,
 jacob.e.keller@intel.com, maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, singaravelan.nallasellan@intel.com,
 kelvin.gardiner@intel.com, jk@codeconstruct.com.au,
 matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 james.ausmus@intel.com
Subject: [RFC PATCH 1/1] xe/xe_mctp_mailbox: Add support for MCTP transport
 over mailbox
Date: Tue,  5 May 2026 01:04:22 +0530
Message-ID: <20260504193420.1232842-4-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504193420.1232842-3-badal.nilawar@intel.com>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
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

Add support for MCTP transport over the Intel vendor-specific mailbox
protocol to enable in-band firmware updates for GPU/AMC via PLDM

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_mctp_mailbox.c | 186 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_mctp_mailbox.h |  14 ++
 5 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 09661f079d03..d427152bc3fd 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -89,6 +89,7 @@ xe-y += xe_bb.o \
 	xe_late_bind_fw.o \
 	xe_lrc.o \
 	xe_mem_pool.o \
+	xe_mctp_mailbox.o \
 	xe_migrate.o \
 	xe_mmio.o \
 	xe_mmio_gem.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4b45b617a039..ebf456f580d1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -49,6 +49,7 @@
 #include "xe_i2c.h"
 #include "xe_irq.h"
 #include "xe_late_bind_fw.h"
+#include "xe_mctp_mailbox.h"
 #include "xe_mmio.h"
 #include "xe_module.h"
 #include "xe_nvm.h"
@@ -1065,6 +1066,8 @@ int xe_device_probe(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_sanitize_freq(gt);
 
+	xe_mctp_mailbox_init(xe);
+
 	xe_vsec_init(xe);
 
 	err = xe_sriov_init_late(xe);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 89437de3001a..9cfe70428c71 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -38,6 +38,7 @@
 struct drm_pagemap_shrinker;
 struct intel_display;
 struct intel_dg_nvm_dev;
+struct xe_mctp_mailbox;
 struct xe_ggtt;
 struct xe_i2c;
 struct xe_pat_ops;
@@ -500,6 +501,9 @@ struct xe_device {
 		struct llist_head async_list;
 	} bo_device;
 
+	/** @mctp_mailbox: mctp mailbox */
+	struct xe_mctp_mailbox *mctp_mailbox;
+
 	/** @pmu: performance monitoring unit */
 	struct xe_pmu pmu;
 
diff --git a/drivers/gpu/drm/xe/xe_mctp_mailbox.c b/drivers/gpu/drm/xe/xe_mctp_mailbox.c
new file mode 100644
index 000000000000..f1a81208a9a1
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_mctp_mailbox.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: MIT
+/*
+ * MCTP-over-MAILBOX transport for Xe.
+ *
+ * Copyright 2026 Intel Corporation
+ */
+
+#include "xe_device_types.h"
+
+#include <linux/netdevice.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <net/pkt_sched.h>
+
+#include <uapi/linux/if_arp.h>
+
+#include "xe_mctp_mailbox.h"
+
+#define XE_MCTP_MAILBOX_RX_POLL_MS 100
+
+/** @mctp_mailbox: Struct for mctp over mailbox */
+struct xe_mctp_mailbox {
+	/** @mctp_mailbox.netdev: network device  */
+	struct net_device *netdev;
+	/** @running: true while netdev is opened */
+	bool running;
+	/** @work: worker to handle mctp requests from firmware */
+	struct delayed_work work;
+	/** @wq: workqueue to schecdule mctp rx worker */
+	struct workqueue_struct *wq;
+};
+
+/*
+ * mailbox protocol is interrupt free so for receive path i.e. endpoint to host
+ * there is no irq available so rx handler need to be polled in worker periodically.
+ */
+static void mctp_mailbox_rx_handler(struct work_struct *work)
+{
+	struct xe_mctp_mailbox *mctp_mailbox =
+		container_of(work, struct xe_mctp_mailbox, work.work);
+	struct net_device *netdev = mctp_mailbox->netdev;
+
+	if (!netdev)
+		return;
+
+	dev_hold(netdev);
+
+	/*
+	 * if (mctp_mailbox_rx_ready()) {
+	 * Get data over MAILBOX
+	 * Allocate skb and copy rx data to skb
+	 * Queue skb to upper layer
+	 * netif_rx(skb);
+	}
+	 */
+	dev_put(netdev);
+
+	if (mctp_mailbox->running)
+		queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work,
+				   msecs_to_jiffies(XE_MCTP_MAILBOX_RX_POLL_MS));
+}
+
+static netdev_tx_t mctp_mailbox_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	/* RFC stub: send skb over MAILBOX */
+	dev_dstats_tx_dropped(dev);
+	kfree_skb(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int mctp_mailbox_open(struct net_device *dev)
+{
+	struct xe_mctp_mailbox *mctp_mailbox = netdev_priv(dev);
+
+	mctp_mailbox->running = true;
+	netif_start_queue(dev);
+
+	queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work, 0);
+
+	return 0;
+}
+
+static int mctp_mailbox_stop(struct net_device *dev)
+{
+	struct xe_mctp_mailbox *mctp_mailbox = netdev_priv(dev);
+
+	mctp_mailbox->running = false;
+	netif_stop_queue(dev);
+
+	cancel_delayed_work_sync(&mctp_mailbox->work);
+	flush_workqueue(mctp_mailbox->wq);
+
+	return 0;
+}
+
+static const struct net_device_ops mctp_mailbox_netdev_ops = {
+	.ndo_start_xmit = mctp_mailbox_start_xmit,
+	.ndo_open = mctp_mailbox_open,
+	.ndo_stop = mctp_mailbox_stop,
+};
+
+static void mctp_mailbox_netdev_setup(struct net_device *dev)
+{
+	/* Populate netdev structure */
+	dev->type = ARPHRD_MCTP;
+	/*
+	 *	dev->mtu = MCTP_MAILBOX_MTU_MIN;
+	 *	dev->min_mtu = MCTP_MAILBOX_MTU_MIN;
+	 *	dev->max_mtu = MCTP_MAILBOX_MTU_MAX;
+	 *
+	 *	dev->hard_header_len = sizeof(struct mctp_mailbox_hdr);
+	 *	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	 */
+	dev->flags = IFF_NOARP;
+	dev->netdev_ops = &mctp_mailbox_netdev_ops;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+static void xe_mctp_mailbox_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+	struct xe_mctp_mailbox *mctp_mailbox = xe->mctp_mailbox;
+	struct net_device *netdev;
+
+	if (!mctp_mailbox)
+		return;
+
+	netdev = mctp_mailbox->netdev;
+	if (!netdev) {
+		xe->mctp_mailbox = NULL;
+		return;
+	}
+
+	if (mctp_mailbox->wq) {
+		mctp_mailbox->running = false;
+		cancel_delayed_work_sync(&mctp_mailbox->work);
+		destroy_workqueue(mctp_mailbox->wq);
+		mctp_mailbox->wq = NULL;
+	}
+
+	xe->mctp_mailbox = NULL;
+	mctp_unregister_netdev(netdev);
+	free_netdev(netdev);
+}
+
+int xe_mctp_mailbox_init(struct xe_device *xe)
+{
+	struct xe_mctp_mailbox *mctp_mailbox;
+	struct net_device *netdev;
+	int ret, err;
+
+	netdev = alloc_netdev(sizeof(*mctp_mailbox), "mctp_mailbox%d", NET_NAME_ENUM,
+			      mctp_mailbox_netdev_setup);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, xe->drm.dev);
+	mctp_mailbox = netdev_priv(netdev);
+	mctp_mailbox->netdev = netdev;
+
+	ret = mctp_register_netdev(netdev, NULL, MCTP_PHYS_BINDING_VENDOR);
+	if (ret) {
+		free_netdev(netdev);
+		return ret;
+	}
+
+	INIT_DELAYED_WORK(&mctp_mailbox->work, mctp_mailbox_rx_handler);
+	mctp_mailbox->wq = alloc_ordered_workqueue("mctp-mailbox-ordered-wq", 0);
+	if (!mctp_mailbox->wq) {
+		mctp_unregister_netdev(netdev);
+		free_netdev(netdev);
+		return -ENOMEM;
+	}
+
+	xe->mctp_mailbox = mctp_mailbox;
+	err = devm_add_action_or_reset(xe->drm.dev, xe_mctp_mailbox_fini, xe);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_mctp_mailbox.h b/drivers/gpu/drm/xe/xe_mctp_mailbox.h
new file mode 100644
index 000000000000..318ae173aaa1
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_mctp_mailbox.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ *
+ * Copyright 2026 Intel Corporation
+ */
+
+#ifndef _XE_MCTP_MAILBOX_H_
+#define _XE_MCTP_MAILBOX_H_
+
+struct xe_device;
+
+int xe_mctp_mailbox_init(struct xe_device *xe);
+
+#endif /* _XE_MCTP_MAILBOX_H_ */
-- 
2.54.0

