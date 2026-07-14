Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A83C44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8740E10E0BC;
	Tue, 14 Jul 2026 19:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="crNHWEd1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8EB10E0BC
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784056622; x=1815592622;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gVE45JI2u55JH1T5FFCgHRknhGi34AOmMRt18ggclzw=;
 b=crNHWEd1yysYW7MmMidFWuj8U6RSkwtm1IF1y+2LybO3BuU4eE93xj2E
 8j0YRMYoziVhih6pgfdC6Sazdvy5jilgtzgdbP/LD2wm6yR6L87B2s0T1
 8N//+yPIQBpi0cApiOWifHi9DPZ2ZoAmbqNL77U7QQYyZBKK8SnyQQvE4
 xZgHucZZQ1uWR/4xX5MSwwVawAqkj9Tc8+ynUr/FN/Ey1zCNgUpcOnkWB
 bzHqIA8tJpcWPzdJsaK8zzN3bjot7FXnfi8yaNj/rPi2/q3U1OecNcd6p
 /Of7OVHSxwwvvoS2/gM3PA7QyEcI+9fJ93sinopwoQh+SCOzUpUQDJc88 A==;
X-CSE-ConnectionGUID: 3U2gPPj9TxW9FJA2M1GxuA==
X-CSE-MsgGUID: i3f52EQXTSO9Nr6B4cM3fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84732451"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="84732451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:17:02 -0700
X-CSE-ConnectionGUID: aw7kamuERVWCCBxZN8oMFQ==
X-CSE-MsgGUID: d9WJvSGSRD+kfBTsNTQBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="259786742"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.44])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:17:00 -0700
Date: Tue, 14 Jul 2026 22:16:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
 tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging/fbtft: Align arguments to match open
 parenthesis
Message-ID: <alaLKv95e0KmKX_3@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
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

On Tue, Jul 14, 2026 at 10:09:41PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch warning for alignment in write_reg() call to match
> the open parenthesis, improving code readability.

NAK.

-- 
With Best Regards,
Andy Shevchenko


