Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1448DC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4560E10E18F;
	Tue, 15 Sep 2026 08:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FXL9se3Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F4310E18F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789462015; x=1820998015;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xHWuLM7Gg0pomoQY7ULq0+gtG3sd6YXRuEnG+NZlu+U=;
 b=FXL9se3QP4Rrw04p8lfdtMgf6uaoLhCltj2U4Gp9pmAI8W7IltJBKBSz
 sVoTiz9JqC4GS8/nuoHCFcy1DxYbHZyaeiKcSmH06TsasDfcojl7VmcFW
 kdDHywjgavuOH3JIN0s2+EDb23OTXT3B/AdIGv7BtfQo/h2MgoNh02SQl
 8a7jIE3uQxifqCjgbAciAabGCag/dqfOlgn+DxEIoyslGoLu3PnkH2nL+
 jVHxeuiT1X5ZSVFtgsKisu040p6z+Unv+T2walE4jEFLlyQ0hVrQ15lzr
 40prb3vCHNqRr5LDVtwy1U3bp/BEwRIaFByW2XJWiieomaeCwGPamfH94 w==;
X-CSE-ConnectionGUID: V+wQtEPmTS2y1aGi6wNEcg==
X-CSE-MsgGUID: e89nD0TrSNG3UYd6QQ73NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100483698"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100483698"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:46:55 -0700
X-CSE-ConnectionGUID: UFf1zISqSLO7j9MARCpDAw==
X-CSE-MsgGUID: hFELR6tlS8eJQhkzZZkRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271081565"
Received: from bahr-mobl1.ger.corp.intel.com (HELO [10.94.251.7])
 ([10.94.251.7])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:46:53 -0700
Message-ID: <c90719c7-ce9f-42f5-a182-82e00eaaeb31@linux.intel.com>
Date: Tue, 15 Sep 2026 10:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Synchronize context abort work with device
 reset
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jozef Wludzik <jozef.wludzik@intel.com>
References: <20260914083006.892645-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260914083006.892645-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026-09-14 10:30 AM, Karol Wachowski wrote:
> From: Jozef Wludzik <jozef.wludzik@intel.com>
> 
> Acquire pm->reset_lock in ivpu_context_abort_work_fn() to prevent it
> from running concurrently with a device reset. If the lock cannot be
> acquired immediately, skip the abort work to avoid racing with reset.
> The device power management is disabled during reset.
> 

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Jozef Wludzik <jozef.wludzik@intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_job.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
