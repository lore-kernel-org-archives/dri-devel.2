Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBFCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7E410F2EB;
	Thu, 25 Jun 2026 14:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Plo7PGzq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2F310F2EB;
 Thu, 25 Jun 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782397810; x=1813933810;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GfEwlZIV8S62vB3Rmcqn5RV50vxb9nuEJ062kbqrins=;
 b=Plo7PGzqaC6AnEYdLplPNdESxoez4e49FGFAtMXRoXEzPciIjibEl1/j
 woerGcUpztSEQxfsKGAorJXEBwIQxmjfdcSXjDRrwcgEEBiAgejEKDx4T
 ZXtqyK9/F+8iwoEICwRVvXCl3MV6lZyKI4nO7iYCLrZA2S146xWoKMSJa
 hF5hHTYlEBVGvvSFIyIPEIhTP/Jq/zGVid2DX7hM9byMmuYJqAB4OYVvD
 ufYq09dx3YvbFc5RZgmFeXTRfZSlRhpa1GmC4UPk8v2UlLPwMoCKi7Rp9
 rwdiHUU3ZBEYi81ssdCxWhYB17SVMkE0zWojMvhzEsH+3SDDLEgqW9w3x g==;
X-CSE-ConnectionGUID: 1rHxymLPTbypj7b1TOPsQA==
X-CSE-MsgGUID: 6FXQfQD8Ty29HFiFf45PFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83364154"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83364154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:30:10 -0700
X-CSE-ConnectionGUID: ZkUYfC9ARH6XCkoLifHRPQ==
X-CSE-MsgGUID: bZaDGQ/VS4OEMO1ld3+cNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="250388012"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:30:06 -0700
Date: Thu, 25 Jun 2026 17:30:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andi Shyti <andi.shyti@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] i2c: designware: Global register definitions
Message-ID: <aj07bEjP6EQCXXq_@ashevche-desk.local>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125939.429078-2-heikki.krogerus@linux.intel.com>
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

On Thu, Jun 25, 2026 at 02:59:37PM +0200, Heikki Krogerus wrote:
> Moving the register definitions to a global header file
> include/linux/designware_i2c.h. That removes the need to
> duplicate them in the adaptation layers for this driver
> outside of drivers/i2c/busses/. There is at least one of
> those in drivers/gpu/drm/xe/xe_i2c.c.

OK!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


