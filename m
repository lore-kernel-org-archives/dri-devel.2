Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A6CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C2F10F2CA;
	Thu, 25 Jun 2026 14:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q/N7acC+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A899A10F2CA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396000; x=1813932000;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H+7DugO4QPsYK+5l9G86Mtbq1kKJwp90ZGLt7miTQJ4=;
 b=Q/N7acC+WisoU9ttoY3GCP5/+98/NavKoqMGgZyYbRhxHp9IoRAnz9th
 igAkfnHIQkmxK45mFlotMJI0Id5bUNfGPxO0DJuy6NssfCVzHMMpDLDId
 ohl9PmigPJFzH7bWAU83ydcZZl+/wKCPU1JEmimxT39RlOnSQbaANhh81
 dUWuf7kECCnIYogH+XJryHzBdfG7jJW+uy+otRokL5gyiRhQxBP0s4jgk
 ONUP2AHsSORxu+wLJ7uUoIvjjn1LzCDEm/Ci3b1SXve82ybN+vfv3kzUj
 wvhPUu9gEsEOR6g844mgSPLmdIGRe39XtN4l9DRVF3tC/ZKrT6YY+iMnn A==;
X-CSE-ConnectionGUID: x/ANr5oPQwqAP9HhlFUD/w==
X-CSE-MsgGUID: KT4p+K9rRM+/HWZq/akfOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82156379"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82156379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:59:59 -0700
X-CSE-ConnectionGUID: FUXGyTl8SKqiZbGKsj3rlA==
X-CSE-MsgGUID: chE6dVCaSNC1bwlI3PARCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="246351708"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:59:57 -0700
Date: Thu, 25 Jun 2026 16:59:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Message-ID: <aj00W8sbiqsYDH7b@ashevche-desk.local>
References: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
 <20260625110237.304435-1-suryasaimadhu369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
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

On Thu, Jun 25, 2026 at 07:02:37PM +0800, suryasaimadhu wrote:
> fbtft_write_vmem16_bus8() and fb_ra8875's write_vmem16_bus8() offset
> txbuf16 by one byte for a command/start prefix, then store 16-bit pixel
> data via txbuf16[i]. On strict-alignment architectures this can fault
> the same way as the write_reg path fixed in the previous patch.

.write_reg()

Can you provide a real world example of the failure?

> Use put_unaligned() for these stores.

Sounds like a fix without Fixes tag.

> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>

Use your name in accordance with your official documents.

...

> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>

>  

You should move this blank line to be...

>  #include <linux/gpio/consumer.h>
> +#include <linux/unaligned.h>

...here.

>  #include "fbtft.h"

...

>  #define DRVNAME "fb_ra8875"

Are other drivers also being affected?

...

> +++ b/drivers/staging/fbtft/fbtft-bus.c

Also needs linux/unaligned.h.

> +			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);

-- 
With Best Regards,
Andy Shevchenko


