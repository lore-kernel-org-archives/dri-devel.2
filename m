Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68358CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20B110F281;
	Thu, 30 Apr 2026 08:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ri6xiE5W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E958110F281;
 Thu, 30 Apr 2026 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777536364; x=1809072364;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=7YNg6apmvo6xBSJzxjSCBC+M+naWO62LB/rRkBOcVNs=;
 b=Ri6xiE5W3k87g1R83YjV7q51K36gdC1onSkO7Ia+eLNq14IyfsJ3ANbI
 Vsf2Ugfu0itggrS1DkaEDN8Hj9J7eg/qpPFBp0pmLLwPdgNmoNIfDVzj5
 vePrv8RMTGCnGqcA2tdu8uzZsJefr4U6yLTikSlKvG67ZD5flio1E4i7x
 0iRQqLwHdu5Yckv3QaKm9mpk+1w6QIDOy/8hM2XrwSvchsEp2VAr01P3Q
 O8YDHlziicEmCkE6tHbIHQ5zNdCaJ7TUT/w9whQY2FMUn66Z62mkwFPoB
 tOYxWRoxIyTBrDyhyrknvfgJmRL9/R+2y8BydjoTWh9jBsar2SICO+a66 g==;
X-CSE-ConnectionGUID: 7mpbjmDVQQ+1pMqUIaeV2A==
X-CSE-MsgGUID: tiG4L187SQWut9ekXbdJUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89855725"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89855725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:06:03 -0700
X-CSE-ConnectionGUID: +qEKrT6xT9+Z9KTAkgc5vw==
X-CSE-MsgGUID: MpZDVHlXS1mlxpCayATnBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234785849"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.68])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:06:02 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/atomic: prefer drm_printf_indent() over inline \t
In-Reply-To: <34ee3359-89e0-496d-be0f-e2baaf850091@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260408082211.3040194-1-jani.nikula@intel.com>
 <34ee3359-89e0-496d-be0f-e2baaf850091@intel.com>
Date: Thu, 30 Apr 2026 11:05:59 +0300
Message-ID: <4db5cc90006a00bdab50169703a796fbd7207d10@intel.com>
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

On Wed, 29 Apr 2026, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> wrote:
> On 4/8/2026 1:52 PM, Jani Nikula wrote:
>> We have a helper drm_printf_indent() for tab indenting the prints. It
>> makes the actual strings more readable, and highlights the indented
>> parts better in source.
>
> aah, you beat me to it :)
>
> On this, LGTM.
>
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

Thanks, pushed to drm-misc-next.

> Should we make the changes in xe/i915 too? I can take it up if you
> want.

Yes, I think so.

I've already got a bunch of changes for debugfs stuff, I'll just need to
polish the commit messages and send, otherwise please go wild. ;)

BR,
Jani.

-- 
Jani Nikula, Intel
