Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4F7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9891210E768;
	Mon, 31 Aug 2026 08:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gbDHipVr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150A610E768;
 Mon, 31 Aug 2026 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788165570; x=1819701570;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=0KKqHFw8XK+ve5kQMHK/088YUDcnJVKDJLDld/gQpi0=;
 b=gbDHipVry2PvNsrdPHjVohCAOLTPZawOKcGuVJdUQdAY8dz19uTF6cNQ
 I5HHfvnHO4TqZTx5/j1rU+CSLX6QgFT1dd/eQOLXr7X4tZk4ugLlxbIWH
 u6GuMxmdTKjPHgTtrwnQ6cHo3l5QpAvh23cUJv/mwNrjsbgzROJ+L6hV0
 TeM9Rr+fSoVxF3pcmnCS9si9qMi8yFbFbGNuKqMSZgHn2kgPlXOEPSllE
 OsitkY5zuR7lvq6aRsEcVFCeaSELsThRG1bs++RL1iwKsrq49fdatRFRA
 /aWjMbmp33HbJ9K6OioNVm05lw063s3jM+OcdCD1/Ti0XsdCpJYJoMO5d Q==;
X-CSE-ConnectionGUID: H34opy+lQgaEtObDriXdcw==
X-CSE-MsgGUID: eZlRBiRpSKW1rfwEHfQItA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88771513"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88771513"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:39:16 -0700
X-CSE-ConnectionGUID: YyVaJv3jQL6YcIPxuStXAw==
X-CSE-MsgGUID: MHQc5K9fTgC+UYEt9WH6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="306977554"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:39:14 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>, Krzysztof Karas
 <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 2/8] drm/i915/selftests: Use drm_* prints in live
 selftests
In-Reply-To: <apGtyDcru1fptbcX@kniemiec-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-3-krzysztof.karas@intel.com>
 <apGtyDcru1fptbcX@kniemiec-mobl1>
Date: Mon, 31 Aug 2026 11:39:10 +0300
Message-ID: <c554f44ecd6c481a7b061f6b729d22d62f5f8f7c@intel.com>
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

On Fri, 28 Aug 2026, Krzysztof Niemiec <krzysztof.niemiec@intel.com> wrote:
>> @@ -34,6 +36,7 @@
>>  #include "gt/intel_gpu_commands.h"
>>  #include "gt/intel_gtt.h"
>>  
>> +#include "../i915_drv.h"
>
> Is the ../ really necessary here? It builds for me if i just switch to
> #include "i915_drv.h", other includes treat driver/gpu/drm/i915 as the
> working dir. I've seen both styles used in the selftests but it just
> looks a bit out of place here.

Using ../ is generally just the plain wrong thing to do.

>> diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
>> index e9469e27f42a..d2a1a901d47b 100644
>> --- a/drivers/gpu/drm/i915/selftests/i915_perf.c
>> +++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
>> @@ -14,6 +14,8 @@
>>  #include "igt_flush_test.h"
>>  #include "lib_sw_fence.h"
>>  
>> +#include <drm/drm_print.h>
>> +
>
> Giga nit, but should this be before the "" includes?

It's not even a nit. That's the style that should be adhered to in the
driver.


BR,
Jani.


-- 
Jani Nikula, Intel
