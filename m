Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF11C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6DE10E41D;
	Fri, 18 Sep 2026 01:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XCTMtkHf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A8310E41D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789695164; x=1821231164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QtXTABXVuFlp8kqv3CDDbYStMc4vENXmXpxqU7pQE3k=;
 b=XCTMtkHfa82zWJBatzmwVZmKozWG7ZHonVIhn+K5TKhNsc7ADY0VTnvU
 fX/eeRHFYuXBhlfrzdT2kJdBtfLz3AXQ8j5eBM4j6oazOfsPjkNM9uUYj
 0Cr7t2/Erj63c4rEveDleH+WXz2ebBF8UsvGO7zQ0ihIodcJZp4yMwgyw
 LuUcS7+APxNlgYcZTezmqZmFZbCzwQdSple9amou6agsRsz2imnbYJaHi
 YkX7qmvpJoB9uOQ+NoPOhC/Q2LZIpnPxS+tw917t44LA0vlYR64qgkwzh
 vwARe/zcezB/GRJA871V0GYz+hcuzTe7E7Uj+z8h1II8D4RIoqJYrOgAs g==;
X-CSE-ConnectionGUID: zUqjo4mVTxmoQVWVAR/Bew==
X-CSE-MsgGUID: 0w46ypOgQr+y/JdAil+ojw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101518185"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101518185"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 18:32:43 -0700
X-CSE-ConnectionGUID: +T+sf23yRW2qqoWvIyBPpw==
X-CSE-MsgGUID: 6lmouXgIRLunhG3zet4wjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2329444"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa012.fm.intel.com with ESMTP; 17 Sep 2026 18:32:23 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: lyude@redhat.com,
	dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
Date: Fri, 18 Sep 2026 09:29:56 +0800
Message-ID: <xiaolu-reply-ddps-20260918@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c992e5468e2118440ab1b9c37fc64c7ab79aaaea.camel@redhat.com>
References: <c992e5468e2118440ab1b9c37fc64c7ab79aaaea.camel@redhat.com>
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

On Thu, 2026-09-17 at 12:49 -0400, Lyude Paul wrote:
> Are we sure this is a good idea? This seems like it could be a problem
> for compositors and just make things more complicated in general for
> userspace because now instead of a connector that can be plugged or
> unplugged, we now only have connectors on MST that appear and
> disappear.
>
> Is there an actual bug being caused by the NAK transactions here?

Thanks for the review. Two points to address your concerns:

1. We tested hot-plug/unplug on MST DFP ports with this patch applied,
   and the connectors appear and disappear correctly without any issues
   observed on the compositor side. When a device is plugged in, the
   hub sends a CSN which triggers a pdt change, causing mgr->work to
   resend LINK_ADDRESS. drm_dp_mst_handle_link_address_port() then
   creates the connector with ddps=1 at that point. The hot-plug
   lifecycle works correctly in practice. That said, if you are aware
   of a specific compositor path that relies on connectors being
   pre-created for all ports regardless of ddps, we are happy to
   investigate further.

2. The REMOTE_DPCD_READ to ports with ddps=0 is not just log noise.
   It causes a measurable lighting delay at link training time, as the
   transaction must time out or be NAK'd before the stack can proceed.
   More importantly, not all MST hubs respond gracefully to REMOTE_DPCD
   transactions on unoccupied ports. This behavior is also
   non-compliant with DP v2.1b spec, which states that REMOTE_DPCD_READ
   should only be issued to ports where ddps=1. Issuing reads to
   ddps=0 ports is the driver-side bug here.

Best regards,
Xiao Lu
