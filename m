Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDFEC982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B8D10E6B0;
	Fri, 18 Sep 2026 10:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iQXhn9Pr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C4710F2DA
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789727787; x=1821263787;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=/rflJoTU73NXxRJVa50UB44grA9fGd6zBzEscmFxxA0=;
 b=iQXhn9PruQICMVP3o/Fvoo/H66+t7EzsxeH1tFEwTuGi95YZ/1dJwVqL
 rfd2OjpjjBM2r2dJFjmX/XiDg2TA6KBEqrciziyhWI7nK+rdYjlaIQHZl
 l+Qv0BkQw/nms11KRPyKcdfShflYsMT2n1Z25rbd+d7paS+1PPU773v7R
 QDJJKzzESWCmi8K8VqJs1U31+FsZzEs7OrkoEmFJ837PD7/ltX9oewvL9
 WU5cX5v4+8V7KOm/biYwpvGga4QCHVAxPJNAHcNqPVO0N1+TSZ7nZeYU4
 P9rXbTLIztBGR14ujmJmhBNd/zMpukLB8CrXDOuMf3rw8LosUrdcQkIfc w==;
X-CSE-ConnectionGUID: 9aQbwTEsTmyJ3M9JohLn1w==
X-CSE-MsgGUID: dEeSMH20TiCm2gz8eTTcdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90091447"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90091447"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:36:26 -0700
X-CSE-ConnectionGUID: zilTZcrBRSuEcplQFejYYw==
X-CSE-MsgGUID: c378QXDnRp+ZKhIHFAc7PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2757136"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:36:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: joao 222 <joolucas64@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [BUG] drm/edid: Samsung display reports 1360x768 as preferred
 instead of native 1366x768
In-Reply-To: <CA+irm5xWBnH=2VwWz-YTsWc_kMK7x9tskdNYzmQjejn21fQnnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <CA+irm5xWBnH=2VwWz-YTsWc_kMK7x9tskdNYzmQjejn21fQnnA@mail.gmail.com>
Date: Fri, 18 Sep 2026 13:36:19 +0300
Message-ID: <9dd8ef8b38327059b3354e7665058aaff310c179@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 17 Sep 2026, joao 222 <joolucas64@gmail.com> wrote:
> Would this display be appropriate for an EDID quirk to correct the
> preferred mode, or is there another preferred-mode handling mechanism
> that would be more appropriate?

It might be, depends on how clean the quirk is. All we need is for
someone to do the work and submit that patch for review.


BR,
Jani.


-- 
Jani Nikula, Intel
