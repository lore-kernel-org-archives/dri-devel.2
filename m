Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1506AC4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C75310E0C4;
	Tue, 14 Jul 2026 19:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HKhKI6Di";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CF010E0BF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784056644; x=1815592644;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7oMSiFqzsngJQfhftA9zEgk1fk7cR0n1+K9qdFdbQLY=;
 b=HKhKI6DivQjWUoUl5o/izv8Ieg1s5Z04u5dQjoLEOkJK1uqj7SeSnq16
 Jo6RoLkss7tSGFdlBnWrdKwlI6VVDZG+HnlFobFiu1oqAdY8tJaFNPenq
 QxmckWM6+SzCP8V/cU+ZucZIPRcJ4Cc6P/RTNAhgP4M68AsBg2uXcsOHP
 mWSVei2xVasH1ReiURGdh3x9ZzNowlob/vBDt7+CnU6XlRmly7NPacgX7
 gd4zw1w+qPAc8q40ALTKB3Q8CKGYDW1Vm7DJL/27hn+6tMkg0dxKywbTc
 U6XoRyqxWq4NpYPooKD5aQHikMXHa4X/wfg9vVX5hijd4zbiNkkXm1Q3p g==;
X-CSE-ConnectionGUID: QW7xUvcqTmiPacksT/uuSQ==
X-CSE-MsgGUID: swuys4+nQuuX7LsVMlAzHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84571091"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="84571091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:17:23 -0700
X-CSE-ConnectionGUID: ZC1i3ojGT8G8KVTmVn6frQ==
X-CSE-MsgGUID: o9ZdukvkTd2+FbCv3zJ26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="280366155"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.44])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:17:21 -0700
Date: Tue, 14 Jul 2026 22:17:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
 tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range
Message-ID: <alaLPsPIfCxyGVPK@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
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

On Tue, Jul 14, 2026 at 10:09:42PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch warnings preferring usleep_range over udelay.
> Replaced udelay() calls with usleep_range() providing a reasonable
> upper bound to allow the scheduler to coalesce timer interrupts.

NAK.

-- 
With Best Regards,
Andy Shevchenko


