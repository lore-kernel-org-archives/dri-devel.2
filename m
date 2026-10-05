Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02FACA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111B710E594;
	Mon,  5 Oct 2026 07:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cXSGsj+g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5142710E594
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791184140; x=1822720140;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zWF7iaHlUi+g2LHIgaEMvTQKtRlI8B0ZJGX2nECp3iY=;
 b=cXSGsj+gwDeJgwKREOggyR0LG9AQZznPEkLYi4jr5qjcC0WocamQeDz8
 b1PasutMGDEWAimczQi2L5m56L1gzAvImbhYUVoV9XNJ5RpoZ4ggw7TYG
 3XqZgbJS344NE1eeN4TglRK20xmdAgifvZK1Xvl7YFO/ZAiPMqgIgWZiA
 8SdHjDotgkxECT3gCSTA7J69hkLA5MoYlcIlZmy2BhG75urNs3W1Yv0MW
 3E5WHIz2fpCt/lPzFFZbuCt92h3Rwcl+ySIAk92W+NGdhlCJfTfBoN1ce
 Ujd5+KIqznFsiQS9RSLH3A+cC3MkMoyisVC47/vppQDvnbKJzkBLPvlQX A==;
X-CSE-ConnectionGUID: MmKsFVuTSOeCjk1FFIq3EA==
X-CSE-MsgGUID: M+VLOscwSpy2a4eV7cfCWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="108225221"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="108225221"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 00:08:59 -0700
X-CSE-ConnectionGUID: 2bByORPmQN+fimoQkQEcXw==
X-CSE-MsgGUID: qLiJvYR4RnOLOSg+wJQzGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="273143290"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 00:08:57 -0700
Message-ID: <df9d2be3-6b75-4640-8a98-8a131889cc8d@linux.intel.com>
Date: Mon, 5 Oct 2026 09:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] accel/ivpu: Rework HW IP generation detection and
 dispatch
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
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

On 01-Oct-26 13:03, Dawid Osuchowski wrote:
> This series reworks how the driver determines the HW IP generation and
> buttress version, and how it dispatches on them.
> 
> Today ivpu_hw_ip_gen() and ivpu_hw_btrs_gen() run a switch over the PCI
> device ID on every call, and an unknown ID only triggers a WARN() while
> probe continues with an undefined generation. Patch 1 resolves both
> values once during device init and fails probe with -EINVAL on an
> unrecognized device ID.
> 
> With that guarantee in place, patch 2 changes the stored values and their
> accessors to the real enum types and drops the default: labels from the
> switches that dispatch on them, so -Wswitch flags a generation that is
> added later but not handled.
> 
> Patch 3 splits the remaining per-generation dispatch in
> ivpu_hw_ip_soc_cpu_boot() and pwr_island_delay_set() into helpers that
> return directly from each case, removing the locals that were left
> uninitialized on the path past the last case.
> 
> No functional change is intended beyond failing probe on an unknown PCI
> device ID and logging the SOC CPU boot mode even when the boot fails.
> 
> Andrzej Kacprowski (1):
>    accel/ivpu: Improve HW IP gen and buttress version checks
> 
> Dawid Osuchowski (1):
>    accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types
> 
> Karol Wachowski (1):
>    accel/ivpu: Split HW IP generation dispatch into helpers
> 
>   drivers/accel/ivpu/ivpu_drv.c   | 69 +++++++++++++++++++-------
>   drivers/accel/ivpu/ivpu_drv.h   | 65 +++++++++----------------
>   drivers/accel/ivpu/ivpu_hw.h    |  1 -
>   drivers/accel/ivpu/ivpu_hw_ip.c | 86 ++++++++++++++++-----------------
>   4 files changed, 117 insertions(+), 104 deletions(-)
> 

Applied to drm-misc-next.
