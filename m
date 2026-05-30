Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C597CCD6E4C
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 07:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010B310E41C;
	Sat, 30 May 2026 07:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TCqA/OdM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D0E10E412;
 Sat, 30 May 2026 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780125174; x=1811661174;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SERNN2GCxyjfcqCL9J8VPzF/r6mvZy/lSmf7ixI0kpU=;
 b=TCqA/OdM/mYqxWiNIvVH+MZ+LC5Au2tPD0pl6PKjFunD9ZMF8OhpVLQK
 C4pTff5TjoIk27jq6O7dOz6xJ/H8+UFEa3jNoVikWdhm80KHuKrNPUmtY
 lyApoqEgGXhOyJrx+pBSKjfgBcnXflaSCrYKWoShRvyyphK5KC6qAPYtu
 MVM1mEhIaqgYIp0ZNlQ++/N/2Dc/i+jFBfldrEwPpNPIF9pHfsozKHcgW
 1RM2++WPps5jIL9oWJvB7Cbgzvo2sR8HuK8G94XaPrMz2bz+HtDbiYBGa
 RS2pl46G9QtrJkGo+lnZxNkKaC5qzBHNHXQihdrXjO3vbzPof4wEcMlOQ g==;
X-CSE-ConnectionGUID: Vd5NajoZQG23u7xOn8kDWQ==
X-CSE-MsgGUID: qRWSjeAKQJmYS2TWpc5xQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92439257"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; d="scan'208";a="92439257"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2026 00:12:54 -0700
X-CSE-ConnectionGUID: tHr/vr9ERVWUz6ePOk37mQ==
X-CSE-MsgGUID: cmuU7zmDRZeZ5kCnC1Fodg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2026 00:12:51 -0700
Date: Sat, 30 May 2026 09:12:48 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Zhan Wei <zhanwei919@gmail.com>
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/hwmon: document DG2 fan speed reporting quirk
Message-ID: <ahqN8Esjz9SmGofH@black.igk.intel.com>
References: <ahm680G_8mf_cjG9@black.igk.intel.com>
 <20260529172449.41504-1-zhanwei919@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172449.41504-1-zhanwei919@gmail.com>
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

On Sat, May 30, 2026 at 01:24:49AM +0800, Zhan Wei wrote:
> On DG2 the driver always shows two fan channels, because the
> FSC_READ_NUM_FANS command does not work on some cards. OEMs decide how
> the fans map to tach channels, so two fans can share one tach line.
> When that happens, the second channel reads 0 RPM even though the fan
> is spinning.
> 
> Note this on the fan2_input ABI entry so the steady 0 RPM is not
> mistaken for a driver bug.

Fixes: 28f79ac609de ("drm/xe/hwmon: expose fan speed")

> Signed-off-by: Zhan Wei <zhanwei919@gmail.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
