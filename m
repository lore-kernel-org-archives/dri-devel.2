Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2D4C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDCE10E0AB;
	Thu, 24 Sep 2026 11:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZRBo/Zzn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A7D10E0AB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790248366; x=1821784366;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=l2zV8Bz/fIDjNe8zbxT6okixXdqVMPFO3GzQPtztSss=;
 b=ZRBo/ZznlrOktU2pxhb6SXNn5202F/83IKf5EHaSzy7cY3Jqs2j6n+c4
 iLsac6WsB4Z2cAKxMzoawVdNXinxizIbb0gKXz85K6zrXLXCieU+pe+Tx
 ND4ZVxGlLBVqoUHUnAXFv2FtNTwUs7UZggIdI4ymbKjp10tsmZT/qliSJ
 2YDIuNYHyUfNR/DL1/NRkx5h1zyBigIKl2xnrPRU4+cGzali/T4/kxeGS
 yF4af05yd4DflHBLJAtOLYYWmU8iMqRziYcZ3hbV06IFOfef9TsYpzjKH
 k91qBwrydc1xtqDbUe//y/tke+wOKaksT+gLcdmZDf740nEO0RmOvnP0B w==;
X-CSE-ConnectionGUID: ZhR20u5BQh+znb7gyoHGIA==
X-CSE-MsgGUID: lvWIMnqBTKKZRiTcStvJkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93734093"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93734093"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 04:12:46 -0700
X-CSE-ConnectionGUID: FAyI/UwAToqWoEfQy+9Dlw==
X-CSE-MsgGUID: GG/OzEtLQCS0lgqGzGa/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273134530"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [10.102.89.94])
 ([10.102.89.94])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 04:12:44 -0700
Message-ID: <cf0db8d5-1a88-4eb9-bf67-08585de9342f@linux.intel.com>
Date: Thu, 24 Sep 2026 13:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Make BO free helper NULL-safe
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com
References: <20260924105906.489378-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260924105906.489378-1-andrzej.kacprowski@linux.intel.com>
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

On 2026-09-24 12:59 PM, Andrzej Kacprowski wrote:
> Handle NULL buffers in ivpu_bo_free() so callers can use it as a
> kfree-like cleanup helper.
> 
> Use the NULL-safe helper to simplify error paths and teardown code in
> firmware, IPC, preemption buffer, and metric streamer cleanup. This
> removes redundant conditional frees and collapses unwind labels that only
> differed by which BOs had been allocated.
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>> 
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_fw.c  | 65 +++++++++++++++--------------------
>   drivers/accel/ivpu/ivpu_gem.c |  3 ++
>   drivers/accel/ivpu/ivpu_ipc.c | 11 +++---
>   drivers/accel/ivpu/ivpu_job.c |  6 ++--
>   drivers/accel/ivpu/ivpu_ms.c  | 17 ++++-----
>   5 files changed, 44 insertions(+), 58 deletions(-)


