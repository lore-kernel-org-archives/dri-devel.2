Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85887C982DF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E9210EB4E;
	Tue, 22 Sep 2026 03:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XrUA0xuq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C2D10EB4E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790047737; x=1821583737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVT99DjgM8ylvPESB/KJ0DYQfmq7aMiha88l6u4R/8M=;
 b=XrUA0xuqwtSD72Xka7hkRcPbcwUZqiRtFII6MmpKTigYQJzMWKIBOYpT
 ykkiCUzBR7w2dSuWubeYx1HUtt4VI6rwRA1X8qJRZ73SzA2tfzviJm16D
 yFXrsZixLzYWRpzRC1xpvB218AcPjgaObovwEdCiWMh1pRX5ecmDzqxJw
 Y2N8VgzTk6NcFKPgVjYb8NK+vqzwTqa94aozenwikY5K5CqdYcmBMsGdr
 Fxj9pEzGHaLqq+z8TlJhcT/v74XGZroda0CjASJamWnjvrjp7aX9j0SPv
 KOsjo2C66uXP1jAj01vMWB0JkY01aazzAPxveAjhOkjfw5nB+IF5t7g5w Q==;
X-CSE-ConnectionGUID: LLhoVN3PTmKQLP08px3BQg==
X-CSE-MsgGUID: S/9aa1U0Rc60cn4TjGsSWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1117721"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1117721"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 20:28:56 -0700
X-CSE-ConnectionGUID: 97ni5jysQjOmZ9IcwkNkFQ==
X-CSE-MsgGUID: NjXzVXSBR+2v1DOnYNIwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="300867727"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa001.fm.intel.com with ESMTP; 21 Sep 2026 20:28:55 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: lyude@redhat.com,
	dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: Re: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
Date: Tue, 22 Sep 2026 11:26:32 +0800
Message-ID: <20260922032632.1255353-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a854ea37b4329d767d04eb0ef7975492aeac0038.camel@redhat.com>
References: <a854ea37b4329d767d04eb0ef7975492aeac0038.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On ..., Lyude Paul wrote:
> I wonder if it's possible to introduce some sort of ddps check within
> drm_dp_send_dpcd_read/drm_dp_send_dpcd_write() that happens under a
> lock which we also acquire during CSN handling...

Thank you for the detailed explanation. I understand the proposed
approach — holding a dedicated lock around the ddps check and the
queue_tx call, with the same lock held on the CSN ack side, so the
ddps value used in the check always reflects the last ack'd CSN.

That said, after looking at this more carefully, I think the current
v2 change is sufficient for the following reasons:

1. The only paths that issue REMOTE_DPCD_READ/WRITE to downstream
   ports without first verifying ddps are triggered during connector
   probing in the driver's add_connector callback (e.g.
   intel_dp_mst_read_decompression_port_dsc_caps() in i915/xe), which
   is called from drm_dp_mst_link_probe_work(). This probe work fires
   when the MST hub UFP is first connected, on topology resume, and
   on each CSN reception. The race window — a downstream port gets
   unplugged between the ddps check and the actual AUX transaction
   during a probe — is extremely narrow in practice.

2. Our primary goal with this change is to eliminate unnecessary
   REMOTE_DPCD_READ transactions that cause lighting delay at link
   training time, rather than strict spec enforcement. We believe the
   vast majority of MST hubs already handle reads/writes to unplugged
   downstream ports gracefully. DP v2.1b Table 2-199 describes the
   DPCD_FAIL NAK with bad-param for such cases, and implementing this
   response in hub firmware should not impose significant burden on the
   hub.

In summary, this is an optimization to improve latency rather than a
correctness fix, and we consider the risk of the narrow race window
acceptable.

Best regards,
Xiao Lu
