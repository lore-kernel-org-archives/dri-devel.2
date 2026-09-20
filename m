Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4066FC982CC
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684F410E16D;
	Sun, 20 Sep 2026 02:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S1sCV5Hy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8181810E16D
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 02:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789871030; x=1821407030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qk1jpstCaJoknnUdv9CKj/FJNZ83y/39Ryp42s/MkK0=;
 b=S1sCV5HyiLAk3dKN5mtRfcTLcaIyfakUuy3D8gXTSHA2iNAReV2qMkNl
 95oVQ3ViKI7zd2fYaY6N3gEyNoQ24VjgUYlUcV5xk5M5PBxBJQNVF/Q4h
 cY20o/MJANUGOzVwbtqjs7XccNv0PTo5tBa13Hu6HoysbLBr48gS87X0q
 faOYU6OpaXGU5LaQNz2DeELKKPdzpA1EMqlv7yrH+0zkGGvjt6tuxMtwg
 HLMMkTKc9yzlEd8dv9IF7BMuP8TyJfDn7vOQfqL3igm/onoCc/VMy95p+
 ruu/qVLbFgCDHiH0T41ZZiSOg7yS/BbW6nf3gQSOMVdnrojTxg0BVZekp A==;
X-CSE-ConnectionGUID: 59ODwAbPRMmCo0Qb/459ng==
X-CSE-MsgGUID: LN6NdBvzSnOlAjNNosRpCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="90510458"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="90510458"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 19:23:49 -0700
X-CSE-ConnectionGUID: JAXDTFgNTviZCj0p0bLoZA==
X-CSE-MsgGUID: 5DOHv5SKTfSXmfY6T8q/5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271629536"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa007.fm.intel.com with ESMTP; 19 Sep 2026 19:23:47 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: lyude@redhat.com,
	dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
Date: Sun, 20 Sep 2026 10:21:20 +0800
Message-ID: <20260920022120.2208320-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
References: <20260917080126.1729898-1-xiaolu.xie@intel.com>
 <c992e5468e2118440ab1b9c37fc64c7ab79aaaea.camel@redhat.com>
 <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
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
> OK - yeah, I definitely agree then that we've gotta enforce that.
>
> This being said though - I do still think we want to keep the
> connectors around, in part because it does give userspace a more
> accurate idea of what ports are actually available on a hub - and it
> would be a bit of a departure from how we've exposed this to userspace
> for a while now. Dynamic connectors are already confusing enough to
> deal with in userspace as it is.
>
> Have you considered just keeping the connectors with ddps=0, and then
> just making it so that our code for performing remote DPCD reads/writes
> simply returns -EIO on ports where ddps=0? That way we still keep
> connectors around without delaying or breaking anything.

Thanks, that is a much cleaner approach. v2 adopts your suggestion:
connectors are now created for all output ports regardless of ddps,
and the ddps=0 guard is moved into drm_dp_mst_dpcd_read() and
drm_dp_mst_dpcd_write(), returning -EIO immediately for unoccupied
ports. This prevents the spurious sideband transactions without any
change to connector lifetime semantics visible to userspace.

Best regards,
Xiao Lu
