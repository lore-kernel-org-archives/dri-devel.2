Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D8CC5DF9D
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667EB10E0F1;
	Mon, 24 Aug 2026 08:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BogwYR/A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E7B10E0F1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787561978; x=1819097978;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xD3ZVhiv3S6/xvTY/hQeH/RBQov8u8bAVX39CY321XY=;
 b=BogwYR/A7umHBbbw1vfk6VYS00NBB9uMP6isQX3ZKZTlMjfGezMsp5j+
 gjVQBt43XjhxdjxR2cBNxQkC0QGVlyU0SZ6EktccuqhXLOH13RdJizGhj
 p8gudtZG87L3QXvhdWpkUjA9QckhtIUFZee8vOeyflb7SUV33QN9IJH0U
 +6TPLlcaZgkLTJ6NfXFhBcmDj+7B0vLNDW6uSyucu9QPRSyBtmniSgJj7
 t1+xG1rCf5i7IOQQi3elJX7OqpNV753H9TPySMLkBWfHFDIeU9f+1yqXM
 HPdj44XCoZs3rQSQyAZe+bDxPjaG+FSa91XtpOGHQ1YWhSv6um5Pt9lRb Q==;
X-CSE-ConnectionGUID: jzvAOF+uTeqsc9itn9AJEQ==
X-CSE-MsgGUID: NyyBE1F3S/iAgnhOz7o8fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88022794"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="88022794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:59:36 -0700
X-CSE-ConnectionGUID: Y7/NezxmSk60n3rVoTSsvA==
X-CSE-MsgGUID: RFwQHik+TO6IgBDv0RjAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="268904673"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.130])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:59:31 -0700
Date: Mon, 24 Aug 2026 11:59:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in
 fbtft-core.c
Message-ID: <aowH8YrNTzAJYRa9@ashevche-desk.local>
References: <20260820-fbtft-v2-final-v2-1-44d107b04634.ref@yahoo.pl>
 <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
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

On Thu, Aug 20, 2026 at 06:58:12PM +0200, Tomasz Unger wrote:
> Using sprintf has potential for buffer overflows if the formatted

sprintf()

> string exceeds the destination buffer size. Replace it with
> snprintf, passing sizeof() of the fixed-size stack buffers

snprintf()

> (text1[50] and text2[50]) so the write is always bounded.
> 
> An overflow is impossible here: even the worst case for the
> argument types (size_t for text1, three ints for text2) still
> fits within 50 bytes. Use snprintf() rather than scnprintf()
> since the return value is not used here.

Then why the patch is needed at all? Do you have any compiler that warns
you about something?

...

It looks like you ignored all my comments against v1...

-- 
With Best Regards,
Andy Shevchenko


