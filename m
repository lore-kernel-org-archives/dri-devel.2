Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66981C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B6210E7DA;
	Mon, 24 Aug 2026 15:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="as7QEXIR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD0210E7DA
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787584940; x=1819120940;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uS2xIZbzLdsQ6jGYoq7awlY+R0+yW1/utnd6qsmgcdc=;
 b=as7QEXIR+U8m5nJg35RH6Viw6HYHEHjqrsjIiA6pKMK6sNAWtR+4KCYN
 odxrvfOpHfWLH/d3fMoLu1kkQV4f6xWxvNCT58fS1RA5KqLxudHROiR2w
 fUwFwSguyOE7UwSrIYzrK4JdBNQDs1/kTlQMwh/hjPF1oL1OlBbVBPQOW
 BdNNq/33meU34nKkooqSXQt5FDZOq4j2Ga/R7DVBvIB3J4xcRDkTknliB
 mLNNXpKnZft1SoX4qKLQXBCRnVu7pTGvbDkDpnLXPp1ydTrPYa7iAMvBa
 avFBdeDAP3x6yKWn75nUDoKfADebXKOpo/vhBQn37PIdCdh1t0agq671I Q==;
X-CSE-ConnectionGUID: Ez4xicACTdedjeRzgjvwBQ==
X-CSE-MsgGUID: A1WnPDapQ/qQ46kLfFZRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88241429"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="88241429"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 08:22:16 -0700
X-CSE-ConnectionGUID: JL6v4/tISb2nj8yZowLCVA==
X-CSE-MsgGUID: ub6DQ2ocR+y3ihV+537KRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="271238495"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.130])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 08:22:13 -0700
Date: Mon, 24 Aug 2026 18:22:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/6] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
Message-ID: <aoxhoqad_F99VtBL@ashevche-desk.local>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-3-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823111959.17029-3-amit.barzilai22@gmail.com>
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

On Sun, Aug 23, 2026 at 02:19:55PM +0300, Amit Barzilai wrote:
> SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
> Switch the SSD133X data path to RGB565.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


