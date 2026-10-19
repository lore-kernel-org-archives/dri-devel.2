Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A6CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DAD10E8FD;
	Mon, 19 Oct 2026 09:21:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B09D10E8FD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792401657; x=1823937657;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DcmCQr+wPZOsTvW7Bqt3y8moIQ64eG6w0LecBO0EAFA=;
 b=EjHjQvm3wrm1gEvk6q5UjhuvCDkvUOJJsKX5dfY+e1goDLaO3ZGeP+EP
 X5vrdbve7kaW0t2PA9Zm0P/u+NFquuLY/504kr4Olx32YzaxNizsDOiku
 9FZ9aYEbk/KVIaCGblt+O4HgPc6xI64jVi1Em0kaS98dqSIDADL6xE4/7
 dT6kgugc66FLqq4ZIXBk9pVjuxkzgR8/TWLb1evNywN27OcXpn9MRS28H
 7Eg2jCpNHZOJlRDXPqKwFou6t48tNrqVoj+vhW6RBHhlbYi9rum6nzL0x
 rrRnpEgPt9weN8wnsTy28UwidUMSUghEXMIVKnlMf4WTfZyKEFwMhsft3 g==;
X-CSE-ConnectionGUID: 6nhdhfQAQbGhqY74YFk4IA==
X-CSE-MsgGUID: G37iKy9xTTiwiT7jKq580w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1089952"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1089952"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:20:56 -0700
X-CSE-ConnectionGUID: OEcLK07XT8CtbkY6p1I1lA==
X-CSE-MsgGUID: kKuZ3vV3S+Cvly4mnFZsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2909163"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:20:53 -0700
Date: Mon, 19 Oct 2026 12:20:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: wrmfwv@163.com
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 gtl-m <admin@micronull.cn>
Subject: Re: [PATCH] staging: fbtft: fix syntax errors in macros
Message-ID: <atXg85m8ukjFuok_@ashevche-desk.local>
References: <20261018085345.17619-1-wrmfwv@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018085345.17619-1-wrmfwv@163.com>
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

On Sun, Oct 18, 2026 at 04:53:45PM +0800, wrmfwv@163.com wrote:

> checkpatch.pl reported errors regarding unnecessary commas and spaces
> before closing parentheses in the fbtft_write_reg macro definitions.
> Remove them to strictly comply with the kernel coding style guidelines.

NAK.
It's your homework to understand why.

-- 
With Best Regards,
Andy Shevchenko


