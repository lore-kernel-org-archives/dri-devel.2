Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB58CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 08:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEDF10E9D8;
	Tue,  5 May 2026 08:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dB1Uizk4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1C010E9D5;
 Tue,  5 May 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777969418; x=1809505418;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1nwZwcd0lw+L3LC6fBbFFthVGiDhYjKf43nqBs4UiIQ=;
 b=dB1Uizk4a+myIrMr+Lji+SzZuY1GOLmRdGvkl7JkMk+VW6NsPfOkdukN
 8NZvkK1QJnh6GNnHFmccAZHqvI3AgBP1qopN/knvoO3fN91BdK1ZJXjVf
 rg3AiypG+GbAMcp1nDDhhU5uwJiQUAwSQVR3wG7x/JxmpYvS2PulkkYEN
 3QfvdIZuBpYExuN809Bgihtz1X8LHsDPlI0uvD1kaQMVxUja0yDfVeXzp
 T50OAPN8S9JtnFodRFFkvDt/m/fXhfskUJGt0ymtIDTW7Z8LbT8ksqE/i
 wWICGgQ+jnzU9FIGyAvQxSTPJ9XK7/WK9rJqsjzHFaRc3e4o1dWncfMXF A==;
X-CSE-ConnectionGUID: c0YdLRH1TdmoiiNhsEnE3g==
X-CSE-MsgGUID: X5hk4aljRoarNvfeAM9Gpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82686152"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="82686152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 01:23:38 -0700
X-CSE-ConnectionGUID: 5ydEHKiiTBy6ySr5CnKKdg==
X-CSE-MsgGUID: Jx0TBBiIQjSA/SI2YNKlvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240728858"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.5])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 01:23:32 -0700
Date: Tue, 5 May 2026 11:23:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
 michael.brooks@intel.com, heikki.krogerus@intel.com,
 michael.j.ruhl@intel.com, thomas.hellstrom@linux.intel.com,
 michal.winiarski@intel.com, anshuman.gupta@intel.com,
 jacob.e.keller@intel.com, maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, mika.westerberg@linux.intel.com,
 singaravelan.nallasellan@intel.com, kelvin.gardiner@intel.com,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, james.ausmus@intel.com
Subject: Re: [RFC PATCH 1/1] xe/xe_mctp_mailbox: Add support for MCTP
 transport over mailbox
Message-ID: <afmpAXjwU16J0RG5@ashevche-desk.local>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
 <20260504193420.1232842-4-badal.nilawar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504193420.1232842-4-badal.nilawar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Tue, May 05, 2026 at 01:04:22AM +0530, Badal Nilawar wrote:
> Add support for MCTP transport over the Intel vendor-specific mailbox
> protocol to enable in-band firmware updates for GPU/AMC via PLDM

...

> +#include "xe_device_types.h"

Why is the location of this inclusion is here?

> +#include <linux/netdevice.h>
> +#include <linux/jiffies.h>
> +#include <linux/workqueue.h>
> +
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +#include <net/pkt_sched.h>
> +
> +#include <uapi/linux/if_arp.h>
> +

The above doesn't sound like more generic than linux/* ones. Move it here.

> +#include "xe_mctp_mailbox.h"

...

> +static void mctp_mailbox_rx_handler(struct work_struct *work)
> +{
> +	struct xe_mctp_mailbox *mctp_mailbox =
> +		container_of(work, struct xe_mctp_mailbox, work.work);

> +	struct net_device *netdev = mctp_mailbox->netdev;
> +
> +	if (!netdev)
> +		return;

This is bad style from maintenance perspective. Use

	struct net_device *netdev;

	netdev = mctp_mailbox->netdev;
	if (!netdev)
		return;

> +	dev_hold(netdev);
> +
> +	/*
> +	 * if (mctp_mailbox_rx_ready()) {
> +	 * Get data over MAILBOX
> +	 * Allocate skb and copy rx data to skb
> +	 * Queue skb to upper layer
> +	 * netif_rx(skb);
> +	}
> +	 */

What is this?! If you want to put a nice comment, format it accordingly.

> +	dev_put(netdev);
> +
> +	if (mctp_mailbox->running)
> +		queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work,
> +				   msecs_to_jiffies(XE_MCTP_MAILBOX_RX_POLL_MS));
> +}

...

> +static void mctp_mailbox_netdev_setup(struct net_device *dev)
> +{
> +	/* Populate netdev structure */
> +	dev->type = ARPHRD_MCTP;
> +	/*
> +	 *	dev->mtu = MCTP_MAILBOX_MTU_MIN;
> +	 *	dev->min_mtu = MCTP_MAILBOX_MTU_MIN;
> +	 *	dev->max_mtu = MCTP_MAILBOX_MTU_MAX;
> +	 *
> +	 *	dev->hard_header_len = sizeof(struct mctp_mailbox_hdr);
> +	 *	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	 */

Even for RFC these should not exist in this form. Always add the respective
FIXME/TODO/et cetera to explain the commented out code.

> +	dev->flags = IFF_NOARP;
> +	dev->netdev_ops = &mctp_mailbox_netdev_ops;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}


-- 
With Best Regards,
Andy Shevchenko


