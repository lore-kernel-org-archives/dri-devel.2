Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E8CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67874113126;
	Mon,  1 Jun 2026 09:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q858CoPL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E007113126;
 Mon,  1 Jun 2026 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780307846; x=1811843846;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=pTjlChPJzgavu9HtH3HlamrUFdRzFwSEgvot7/KhuHc=;
 b=Q858CoPLviP//uVL0PUjDcTZhzJmI0+NcXFyxzKdOv8jxlTjfr3cfeFx
 oYpnk9Zs3bpECpjp5lZCX6blQ5Df4Q6hFmpLg1Bo6Fb7Zkfi03Jiy0Uhm
 8TKlIpoHTtydYTzUS75NgKOsl6KOJKPzOUdHP01m9YnOcik3qye6LGlc4
 V5mScLYDFuyAAxLwHuf/uipNUzu/ojB1YC7cGzY9PN7OUb/RA00hskB/K
 Y64Jdq4rUUlWa7hZPQvxKH4g2Jxwh7RXPF+NpH3EWUBZiRxVDCwpD41eJ
 r5ip8MTWapoZck0MHvuruFDMwuGPqDgOaP/h7QGDFIo8hhmXsprxS4sHr Q==;
X-CSE-ConnectionGUID: PMPcr+ygTQCjgLHeXpdvQg==
X-CSE-MsgGUID: SNcYg1nhQ9+Wq78UouPh1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92177776"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="92177776"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:57:26 -0700
X-CSE-ConnectionGUID: hezSgFZWSDO5j5nynBW03A==
X-CSE-MsgGUID: GnaJcyPdS1mT8OZUAUAaYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="248448162"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.121])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:57:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kunal Zodape <kunal.devanandzodape@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Rahul Kumar <Rahul.Kumar1@amd.com>, Prateek
 Gupta <Prateek1.Gupta@amd.com>, Kunal Zodape <kunal.devanandzodape@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use ACK polling for page-write completion
In-Reply-To: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
Date: Mon, 01 Jun 2026 12:57:19 +0300
Message-ID: <3206d5c3e94f694b4f0a5b5db4dc1ebaaa86aac9@intel.com>
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

On Mon, 01 Jun 2026, Kunal Zodape <kunal.devanandzodape@amd.com> wrote:
> The EEPROM write path currently waits a fixed 10 ms after each page
> write to cover the maximum write-cycle time.
>
> Replace the fixed delay with ACK polling so the driver can continue as
> soon as the EEPROM finishes its internal write cycle. Since the SMU I2C
> adapter used for these EEPROM accesses does not support zero-length
> transfers, poll readiness with an offset-only dummy write.
>
> Keep the existing 10 ms timeout as the upper bound for the polling loop.
>
> Tested on MI200 (ALDEBARAN) with ras_eeprom_reset confirming clean
> write/read-back with no I2C errors.
>
> Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 28 +++++++++++++++-------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 8cd69836dd99..53be5a31c40c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -153,15 +153,27 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>  			break;
>  
>  		if (!read) {
> -			/* According to EEPROM specs the length of the
> -			 * self-writing cycle, tWR (tW), is 10 ms.
> -			 *
> -			 * TODO: Use polling on ACK, aka Acknowledge
> -			 * Polling, to minimize waiting for the
> -			 * internal write cycle to complete, as it is
> -			 * usually smaller than tWR (tW).
> +			ktime_t timeout = ktime_add_ms(ktime_get(), 10);
> +
> +			/* Poll for ACK to detect when the self-timed
> +			 * internal write cycle has completed, as per
> +			 * Acknowledge Polling described in the AT24CM02
> +			 * datasheet, Section 7.4. The SMU I2C adapter
> +			 * used by these EEPROM paths does not support
> +			 * zero-length messages, so use an offset-only
> +			 * dummy write to probe for the ACK. The address
> +			 * pointer update is harmless because each real
> +			 * transfer reprograms it before use.
>  			 */
> -			msleep(10);
> +			do {
> +				r = i2c_transfer(i2c_adap, &msgs[0], 1);
> +				if (r == 1)
> +					break;
> +				usleep_range(100, 200);
> +			} while (ktime_before(ktime_get(), timeout));
> +
> +			if (r != 1)
> +				break;

See poll_timeout_us().


BR,
Jani.


>  		}
>  	}

-- 
Jani Nikula, Intel
