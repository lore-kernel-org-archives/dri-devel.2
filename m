Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075FBC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630BC10E79D;
	Mon, 28 Sep 2026 06:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b1FRw62Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844710E79D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790576973; x=1822112973;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QlrvQxbqbJa0JGSGfbasE2pIKi6W8GB64gNFayl4kSM=;
 b=b1FRw62ZhVsQOricAwIYAHOiGt+4QKM9DR+gbVJAJDxfRfRvCCNA34C0
 FpjNbW1lt//PZV4p9J7SFJFIh9H8P1m3a5HiFzjLqf0purFiXYD7hMIUQ
 Xn1D5rjhmheEtcIBw0764aYRPA6OIwMsnQorRsXHwTIf0G6bmuAM9Tbmf
 FEHB6bAjEqB5T6aXoWk1LgV+bBxtZg4UWRngRrfSgBKQpVvNs0T+Bcu4k
 MJF9WWrlU37CcKODZuR04B4ENeY/Sqc133jba1obOYcigi6dTfk6noSIG
 BLM4jxiUftXfcgYpfesBqlKVjk2TgWv+ISyWgkpufmPJDrZPDVUez3ubM Q==;
X-CSE-ConnectionGUID: dQ8eYQsdScKgUwg1Vz1Ftw==
X-CSE-MsgGUID: ksnVAq4dRuaJA6Pu81IWhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101792558"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="101792558"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 23:29:13 -0700
X-CSE-ConnectionGUID: U1t4lqkNT+yb1ad2octtoQ==
X-CSE-MsgGUID: rkzFbqivQc2A22LSWgDqVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="273099370"
Received: from cphenegh-mobl1.ger.corp.intel.com (HELO [10.245.113.104])
 ([10.245.113.104])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 23:29:11 -0700
Message-ID: <e2696c84-6372-49a7-98a4-0744e084bf40@linux.intel.com>
Date: Mon, 28 Sep 2026 08:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Make BO free helper NULL-safe
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com
References: <20260924105906.489378-1-andrzej.kacprowski@linux.intel.com>
 <cf0db8d5-1a88-4eb9-bf67-08585de9342f@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <cf0db8d5-1a88-4eb9-bf67-08585de9342f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24-Sep-26 13:12, Dawid Osuchowski wrote:
> On 2026-09-24 12:59 PM, Andrzej Kacprowski wrote:
>> Handle NULL buffers in ivpu_bo_free() so callers can use it as a
>> kfree-like cleanup helper.
>>
>> Use the NULL-safe helper to simplify error paths and teardown code in
>> firmware, IPC, preemption buffer, and metric streamer cleanup. This
>> removes redundant conditional frees and collapses unwind labels that only
>> differed by which BOs had been allocated.
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Applied to drm-misc-next.

> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_fw.c  | 65 +++++++++++++++--------------------
>>   drivers/accel/ivpu/ivpu_gem.c |  3 ++
>>   drivers/accel/ivpu/ivpu_ipc.c | 11 +++---
>>   drivers/accel/ivpu/ivpu_job.c |  6 ++--
>>   drivers/accel/ivpu/ivpu_ms.c  | 17 ++++-----
>>   5 files changed, 44 insertions(+), 58 deletions(-)
> 

