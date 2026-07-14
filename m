Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A6C44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B27010E0BF;
	Tue, 14 Jul 2026 19:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J/zn2hIY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15FA10E0BF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784056724; x=1815592724;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GfOYDJlWg3IZFciu0wTO8HAj2UD1NUueTFeDJjUZDeQ=;
 b=J/zn2hIY/P5rE0lkozeKdpsqIc/alIB7VUb01eByA2tJMG7YSHMJE6oS
 WtDQMELiePGJWDOQ9eDOweMdqFVZA6TfR+jO0o9bVFnbUvf7R2yqvh3us
 bRGrI4IcFsu8hD5OJA1bRXZpE+p2eL8hJGT32ew6h5d374Zka5/jTuglD
 5H/3BYSxG5J3yV1owiubRGt4NWrBIHUt0aa/W/Z6kciqQj3wz8cT63Ys9
 NzKkyrDvJ9EOXeRzsePs5l8M5HLwFNq2tjrQZgrXi815ZeXetV0HeFzCg
 Ry4aCyBOym7zC76pyXnpmQA2PC8HVNGXWg+38xRYTJ6C43QFALOaQeVQb w==;
X-CSE-ConnectionGUID: JmJcKcHYSomhkTWXRRZ5xg==
X-CSE-MsgGUID: hyg7dXLYQwCrjdrulStwZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72211824"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="72211824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:18:44 -0700
X-CSE-ConnectionGUID: 9jbTOM19QO6MueOyBhvGoA==
X-CSE-MsgGUID: QKTFd/3vT42zxW848QgXAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="254826846"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.44])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:18:42 -0700
Date: Tue, 14 Jul 2026 22:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
 tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging/fbtft: Minor cleanups.
Message-ID: <alaLj25guWgLapBE@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
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

On Tue, Jul 14, 2026 at 10:09:38PM +0300, Panagiotis Gravias wrote:
> Solved some style errors,
> parenthesis spacing, aligning arguments, replacing udelay() with
> usleep_range().
> 
> I hope this makes future checks with the style script cleaner and more
> helpfull.

To understand the resolution, read the mailing list archives for
the last ~6-9 months against this driver.

Also read and understand README in the folder of the driver.

-- 
With Best Regards,
Andy Shevchenko


