Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDDDC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7810610E7AC;
	Wed, 23 Sep 2026 01:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mj9ZfRhI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD9E10E7AC
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790126826; x=1821662826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yuDOWL0/cplxp54nppQ9hNbmMzmYZt5ACoX2XP0SXz0=;
 b=mj9ZfRhIXr3rW/b2cpTQstixR6k8oXct5fpa7HMPC1OafyE8bmB5sr3M
 psyt0zAdASOGyGc/rB127+Chnuo83iYT6InQ1XOLSd/MbT23Fmw15tKcD
 mClBywprNXysPgJgNC0ICQK1ezs93cUBCDOqdeBe7z6fK/ktplLWFRL04
 oH7B3QL4fqYtF2YiPnbNT369o3y9pxfmTZ2mmN2am9teWW85s+1wlgX4H
 sc6hKpsqpwb91J4YYUcZIffhxCESBtxz5kxLBbPTJH+IWs49OGdouy2/y
 UARldA4WMyyMjQNe/g1tW5Ei90Yc1JIh+Lbs6uzF9Z/xQjJAPXhY4wMFX A==;
X-CSE-ConnectionGUID: tQKCboPLTSqSjhtV1Gbgvg==
X-CSE-MsgGUID: Q9X4OHQWRiO/4Xw0y+PHtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101368196"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="101368196"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 18:27:02 -0700
X-CSE-ConnectionGUID: 9V7oepDxTBWrNxDT9RjTIA==
X-CSE-MsgGUID: rUXtobNfR5OTfA1KoUunsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4671181"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa013.fm.intel.com with ESMTP; 22 Sep 2026 18:27:00 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: lyude@redhat.com
Cc: dri-devel@lists.freedesktop.org, David.Francis@amd.com,
 jani.nikula@linux.intel.com, Xiao Lu <xiaolu.xie@intel.com>
Subject: Re: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
Date: Wed, 23 Sep 2026 09:24:38 +0800
Message-ID: <20260923012438.331645-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a1a6f4726f715259e29951933ca2279edab16073.camel@redhat.com>
References: <20260920022144.2209244-1-xiaolu.xie@intel.com>
 <a1a6f4726f715259e29951933ca2279edab16073.camel@redhat.com>
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

Thank you for the review, Lyude!

I don't have commit access to drm-misc-next, so please push at your
convenience.

Best regards,
Xiao Lu
