Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BF8CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2DE10E199;
	Wed, 27 May 2026 09:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JFfDgxQl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B8D10E199
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779873165; x=1811409165;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=eQqZ6XqDjSiSftV6e4tpn0cRmc5u10CpWKTWO4PJqpk=;
 b=JFfDgxQl007eD8DtQZxirRnlKAhnT6dWM++e2Red5LIS27R1YzWZw5aw
 2djcYvz2UTs60HzlbA8beJ9lV6n7e5k7AqjizI0UUVVauoFvv5IZ8plRR
 YMLc/7QVgcW5rbBuH0PKGIXfmkKJPmhNgSXIPYKFLlRnrGgIgzuvJeg15
 vFbIq1PMS9Z2ryxyIzoN6ZUgEHH+/ILV8z++n7VLiFQ8xRUnwgvdqS5Bo
 7vfpitqFlaEtNUXNc+HAJ5RJ4hiHjmo32dv/nHRWn5lMrqU6v8+aZSk4A
 ki62TKqrnmDANJOT/TTpTQ48gk1ek0pDMSQldESZ0oZ26E3PtZbhT2kxx w==;
X-CSE-ConnectionGUID: vhElJtimTuy9MqEaLw2vYw==
X-CSE-MsgGUID: 77zus8xcSQSbkV8sGvKrPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80757448"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80757448"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:12:45 -0700
X-CSE-ConnectionGUID: QypLTtc8SEOg7p8vgruReA==
X-CSE-MsgGUID: pIy1yNEOTJSd3T3RaFILJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="237749026"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.38])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 02:12:42 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: xlabai <xlabai@tencent.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: security@kernel.org, dri-devel@lists.freedesktop.org, =?utf-8?B?eGxh?=
 =?utf-8?B?YihNSUflronlhajlrp7pqozlrqQp?= <xlab@tencent.com>
Subject: Re: Security: handle_count underflow in
 drm_gem_change_handle_ioctl, leading to use-after-free
In-Reply-To: <61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com>
Date: Wed, 27 May 2026 12:12:40 +0300
Message-ID: <41ab502df7d9d13219bb297a44e38f6723109f4a@intel.com>
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

On Tue, 26 May 2026, "xlabai" <xlabai@tencent.com> wrote:
> We follow the security industry standard disclosure policy -- the 90+30
> policy (reference: https://googleprojectzero.blogspot.com/p/vulnerability-disclosure-policy.html).
> If the aforementioned vulnerabilities cannot be fixed within 90 days of
> submission, we reserve the right to publicly disclose all information
> about the issues after this timeframe.

You just sent the whole thing to a public mailing list [1].

BR,
Jani.


[1] https://lore.kernel.org/all/61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com


-- 
Jani Nikula, Intel
