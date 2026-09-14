Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0A2C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE05110E4BA;
	Mon, 14 Sep 2026 09:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="COgkSIU4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE3710E122;
 Mon, 14 Sep 2026 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789379740; x=1820915740;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=woFzfX/5eT3ItbU3nrwbkymcKwk3T+wmraBseHKL7Eg=;
 b=COgkSIU4OYKAksf5s+7n2qx+HMjm/OFm58J+AdNaoYqlEiqy8jyTapOc
 9gToLZqAFNZWstEbF/l0HOCGQNQSBsplwKBToOLOi+04LJ0qg0rudiD1O
 hEebOsSNyLp0kdtul9A+ZT5QCSFVlqlPrMUc9eJIlyT49cWVOpa20QT8K
 Su1Ydc+NI8l/PdyRQJ3zGeUua4AyS0h4KUYDLoUK1I16m5wgHOEkFZhTN
 2R1ViEZkPiyy+PHB4G0aNVaybZYDwynpfhIYwG6kD20e0msukYNonPdfp
 kE+ekaE8OOn3Q78qcT4twR2URm/T188tDeZuwXEdGu2bb8URR7i4XLzjT A==;
X-CSE-ConnectionGUID: hx3ltTQlQmWUFV65puUicA==
X-CSE-MsgGUID: uzTX8mDNSVaQXTEUkIJA6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89492817"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89492817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:55:39 -0700
X-CSE-ConnectionGUID: 9awhVaBsQXC3kEiDdfbAkA==
X-CSE-MsgGUID: vtXZ8eXgQ2uUjN01JUN2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="268918908"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.96])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:55:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: CJ <firefly0158@163.com>, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [BUG] drm/i915: general protection fault in i915_pci_probe on
 forced bind
In-Reply-To: <3c467f81.7d23.1a09f0874aa.Coremail.firefly0158@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <3c467f81.7d23.1a09f0874aa.Coremail.firefly0158@163.com>
Date: Mon, 14 Sep 2026 12:55:34 +0300
Message-ID: <c830d55e4e1ed88571b15fbedee63de1c6f1ccd3@intel.com>
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

On Mon, 14 Sep 2026, CJ <firefly0158@163.com> wrote:
> I am reporting a general protection fault in the i915 PCI probe path, triggered
> by a syzkaller reproducer.  The issue is reproducible with HEAD commit
> cee9395acd8043be0644b25c34bfa86623f2b935 (v7.3-rc1, Linux 7.3.0-rc1).

Try v7.3-rc2.

> The reproducer mounts sysfs, writes "i915" to the driver_override attribute of
> PCI device 0000:00:01.0, and then writes the device name to the i915 driver's
> bind attribute.  This binds the i915 driver to a PCI device it was never meant
> to drive.

Is that a sane use case, though?


BR,
Jani.

-- 
Jani Nikula, Intel
