Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B3606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BO+mjVab
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F008110E85B;
	Wed,  4 Nov 2026 08:56:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859F510E85B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793782580; x=1825318580;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WEdnh3Um7RLyVQ8huXyPus5xQBPLH8vtUBUJSepuOP0=;
 b=BO+mjVab5YgIj25H2esws5VfMXuKu+IrdHJPGy7f+r767gi1Zd76MtLn
 wFsHDeOSh3UcJQkVANx+dm2yExwKEYNkCqwHz6ahn/+YA7ebuRHSQ/Q0v
 M61Pv4I+OXP4rtk5lwagd38mavUdcFbFbYqpwEscGuB4X4nu4s8yuHJog
 Ylne3u+KyvC9am1gJlCgq4nJ9ri0kSUZY96Edfg1PRdlLwb6F2F4/h1nX
 rhMcxn8qKq9/M5D6MKrqqlPLTTWXeUaiHl5SDWJkrLUP+ebRlIpIrN+LJ
 syyT/ccpCCw0bau8VN12bFeOqfr8+PhFftdNuzFiCgmUlx7TsUTWlJ3Vk w==;
X-CSE-ConnectionGUID: 8qStRYgwR1eAMvj6GTW5Pg==
X-CSE-MsgGUID: 9q8Ln4Z2QMS/Kgv8vZxz2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2416681"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2416681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:56:17 -0800
X-CSE-ConnectionGUID: /gOq8NuZS6ib1xsECxEouA==
X-CSE-MsgGUID: 6RQJzOOWQ9OH1ccyCgP24A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6515010"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.24])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:56:15 -0800
Date: Wed, 4 Nov 2026 10:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eileen Blessing Kabi <kabiblessing5@gmail.com>
Cc: outreachy@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
Message-ID: <aurzLD-baoebpE2N@ashevche-desk.local>
References: <20261103221142.45100-1-kabiblessing5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103221142.45100-1-kabiblessing5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 10:11:41PM +0000, Eileen Blessing Kabi wrote:
> Fix the spelling of "written" in the write_vmem() kernel-doc comment.
> 
> Found with codespell.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


