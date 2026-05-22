Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1822CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7FC10E2C0;
	Fri, 22 May 2026 19:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fx8HNvoW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F75810E29A;
 Fri, 22 May 2026 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779479743; x=1811015743;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=jRlsy6gF1FngYaCDEJIkgmyAf/ftC04KNWvaWoDGUlA=;
 b=fx8HNvoWhHlaUsQ97Qol3kmy+xSIn10AtlVR1uDSfn4vJ8KsjPBgn27g
 O4UW9IZXyj6b9wKeVJTCQ2iNixnmUS3X1yXp26GctER6Fs+J49eEsXB8I
 OnMzzXSUwROsBYzyNiWpfr1GOO0pIARSP32GyQEHmUrUi/8/Un2JYc5S2
 hZEB6ywzFvwswsAea4LpL92ODZQUhPSpsImICvUBQaW1L0qUzL+cO/I1b
 r8jXRtQktEFHSPt37PpVx8LT2HK6R5Kx6lvNPgtnGmZaVoZhtdUsMU5MC
 tZewPVbpOSXe5+uWUvqqRCKUhzyY2O0QNvetKibAsUIYjxzIWM+fVy/cQ g==;
X-CSE-ConnectionGUID: TNRdypY2SR+BJ0l1SkF+2A==
X-CSE-MsgGUID: RDYNxLlHSQ2KpEwIkzfCbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="91525042"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="91525042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 12:55:42 -0700
X-CSE-ConnectionGUID: JIg6sEssTgK2ZOWPuQqIbQ==
X-CSE-MsgGUID: f5sZBsj5S4eWftcjrOuRPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="245290660"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 12:55:40 -0700
Date: Fri, 22 May 2026 21:55:38 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH v2 1/2] drm/print: describe 6th & 9th bit of drm.debug
In-Reply-To: <20260522135520.1862848-2-michal.grzelak@intel.com>
Message-ID: <26630a3e-7757-4fa4-1415-7ede60d98305@intel.com>
References: <20260522135520.1862848-1-michal.grzelak@intel.com>
 <20260522135520.1862848-2-michal.grzelak@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-369638617-1779479741=:1544314"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-369638617-1779479741=:1544314
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 22 May 2026, Michał Grzelak wrote:
> Setting 6th or 9th bit of drm.debug change debug logging. Meanwhile
> `modinfo drm` does not inform about it at all.
>
> Add info to MODULE_PARAM_DESC(debug, ...) about setting 6th and 9th bit
> basing on DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, ...). Match
> description of corresponding bits with enum drm_debug_category. Include
> 9th bit in the example with enabling all possible logging provided at
> comment at include/drm/drm_print.h.
>
> Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>

What should have been added here is R-B: tag provided by Chaitanya,
which currently is very much absent. The omission was not intentional.

BR,
Michał

> ---
> drivers/gpu/drm/drm_print.c | 4 +++-
> include/drm/drm_print.h     | 2 +-
> 2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index ded9461df5f2..86cef1a37678 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -50,8 +50,10 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
> "\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
> "\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
> "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
> +"\t\tBit 6 (0x40)  will enable STATE messages (atomic state code)\n"
> "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
> -"\t\tBit 8 (0x100) will enable DP messages (displayport code)");
> +"\t\tBit 8 (0x100) will enable DP messages (displayport code)\n"
> +"\t\tBit 9 (0x200) will enable DRMRES messages (managed resources code)");
>
> #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> module_param_named(debug, __drm_debug, ulong, 0600);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index ab017b05e175..2adc5ac688e1 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -87,7 +87,7 @@ extern unsigned long __drm_debug;
>  *  - drm.debug=0x2 will enable DRIVER messages
>  *  - drm.debug=0x3 will enable CORE and DRIVER messages
>  *  - ...
> - *  - drm.debug=0x1ff will enable all messages
> + *  - drm.debug=0x3ff will enable all messages
>  *
>  * An interesting feature is that it's possible to enable verbose logging at
>  * run-time by echoing the debug value in its sysfs node::
> -- 
> 2.45.2
>
>
--8323329-369638617-1779479741=:1544314--
