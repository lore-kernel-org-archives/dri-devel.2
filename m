Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B9CDE002
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABCB10E393;
	Fri, 26 Jun 2026 12:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="deEkf0Wg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F9B10E393;
 Fri, 26 Jun 2026 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782477111; x=1814013111;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=of9D+QDbplk76SptbJ/9PEF9tc3vwD6lqMoVlMFoRmY=;
 b=deEkf0WgZ/zT5CPcImZmOmE+ROc7gTOfxhuCSTrqkODhpzS3RHrB2wq6
 o2J2azB9RAnTdG7zZq3JXlzXxOaNfuYveBtdhFa4MGOeFtGoYigZT+k8r
 ncUO97aAZ9/D0cxMgKEorLBianm3dwPnigT4xTVSEyXkFicN1O9QlwI0G
 VuZqOcCFGdOAxo/+3JszrEKf+eBIFvoGbgFofCMDP1LRLJhw1Quc05k7J
 4GqewgNyizU9hjDYKyM5NeNvBKjOgqq89n1vGKDc+ZzxvdRD7thLaCqdN
 7hWpnwl6oy9eHj/B0N98m8CcpJkywvQI+FRaoSgZM/l1wutcGUPw8lriL g==;
X-CSE-ConnectionGUID: 5JhJf2gMSga3iM83Lept1Q==
X-CSE-MsgGUID: Cnkdr7U6SXGk+j0uNLaz5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93924827"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93924827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 05:31:51 -0700
X-CSE-ConnectionGUID: x4OkPwIWQxSYQC+zEXBj+w==
X-CSE-MsgGUID: f4x1A97GTyWq5FhmyP+BMQ==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 05:31:47 -0700
Date: Fri, 26 Jun 2026 15:31:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Dave Airlie <airlied@redhat.com>, Kees Cook <kees@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Ben Skeggs <bskeggs@nvidia.com>, Mel Henning <mhenning@darkrefraction.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/2] Revert "nouveau/gsp: fix suspend/resume regression
 on r570 firmware"
Message-ID: <aj5xMVbxOlzb2fyS@ashevche-desk.local>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625231252.89684-2-lyude@redhat.com>
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

On Thu, Jun 25, 2026 at 07:10:54PM -0400, Lyude Paul wrote:
> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> 
> It turns out this looked like the right fix on some systems, but it's not -
> as this causes runtime PM to actually fail on many a laptop.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")

> Cc: <stable@vger.kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mel Henning <mhenning@darkrefraction.com>
> Cc: <stable@vger.kernel.org> # v6.19+

Two times Cc to stable.
I also recommend to move the rest of the Cc list below cutter '---' line.

Will be something like this:

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org> # v6.19+
Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
---
Cc: ...
Cc: ...
---

This will reduce the unneeded noise in the commit messages.


-- 
With Best Regards,
Andy Shevchenko


