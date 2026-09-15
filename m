Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D08DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CD510FB44;
	Tue, 15 Sep 2026 09:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nw5t4M2/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DEB10FB3C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789465574; x=1821001574;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g0K9A3toXigBI62aNpPDa1/PMxKe35NY2orLSoU0er4=;
 b=nw5t4M2/wI+eWDw6eG1/8ZZDW+G5erzM5GSIY7hjIDBoInQQOnZgw94i
 1ExjaPntGxrYrK6Zv3khdWTtV46CVavoANafKhq95q7Py9GmSGCyCWkZK
 czJI/+vULMnfvWz4Rnf5NZgFfsTha4h7YtTo3/+0lbOFg2fopYquIKKjP
 AR2cUtmrkUx2zyjJm3Q9dsLKnnGrF9sREJvnYP4wzbtycygXE0yDX0udN
 N/jAhUMgymlKaqEDT2NMSPJQgo1g3SkFTJx8epzJoQgJjwf/qqX9af5AV
 f0XXTOYDxILlDBLZV1Fyd0O5DU5ZpqWyD2t/MJQvwO9k+fy/hotH/+DR6 Q==;
X-CSE-ConnectionGUID: TZER89yyQUSeOX1N3XAUjA==
X-CSE-MsgGUID: dpppu8XdTx6WoQ/u4rYjew==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112592233"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112592233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 02:46:13 -0700
X-CSE-ConnectionGUID: wTeylYXATAazoda1Q0uuZA==
X-CSE-MsgGUID: fFaTlMeHQD+sn2nGNSZMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273466161"
Received: from bahr-mobl1.ger.corp.intel.com (HELO [10.94.251.7])
 ([10.94.251.7])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 02:46:10 -0700
Message-ID: <b0c7d83e-84d5-4340-9e8a-252e6377b6b8@linux.intel.com>
Date: Tue, 15 Sep 2026 11:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Move register poll timeouts to
 vdev->timeout
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
References: <20260915083651.950890-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260915083651.950890-1-karol.wachowski@linux.intel.com>
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

On 2026-09-15 10:36 AM, Karol Wachowski wrote:
> From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
> 
> Use the vdev->timeout structure for register poll timeouts. This allows
> adjusting those timeouts depending on the platform type.
> For FPGA set MMU timeouts to 10x.
> 
> Register poll timeouts are expressed in microseconds and are passed to
> read_poll_timeout(), which disables a timeout when it is 0, unlike the
> millisecond timeouts that are disabled with a negative value.
> 
> Also initialize state_dump_msg in the IVPU_TEST_MODE_DISABLE_TIMEOUTS
> branch, which was missed when the field was added. Unlike the other
> fields, it is a fixed delay passed to msleep() rather than a timeout, so
> it has to keep a finite value. It is only reachable with this debug test
> mode enabled, so there is no need for backporting.
> 

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
> Changes in v3:
>   - Address Sashiko AI review comment: disable the microsecond register
>     poll timeouts with 0 instead of -1. read_poll_timeout() treats 0 as
>     "never timeout", while -1 is converted to 0xffffffff and results in
>     a finite ~71.6 minute timeout
>     Review: https://sashiko.dev/#/patchset/20260914082649.891871-1-karol.wachowski@linux.intel.com?part=1
>   - Initialize state_dump_msg in the IVPU_TEST_MODE_DISABLE_TIMEOUTS
>     branch, it is a fixed msleep() delay and has to remain finite
>   - Explain the timeout semantics in the commit message
>   - Link to v2: https://lore.kernel.org/dri-devel/20260914084503.895042-1-karol.wachowski@linux.intel.com/T/#u
> 
> Changes in v2:
>   - Add Signed-off-by: Karol Wachowski
>   - Link to v1: https://lore.kernel.org/dri-devel/20260914082649.891871-1-karol.wachowski@linux.intel.com/T/#u
> ---
>   drivers/accel/ivpu/ivpu_drv.h   |  3 +++
>   drivers/accel/ivpu/ivpu_hw.c    | 22 ++++++++++++++++++++++
>   drivers/accel/ivpu/ivpu_hw_ip.c |  6 ++----
>   drivers/accel/ivpu/ivpu_mmu.c   | 12 ++++--------
>   4 files changed, 31 insertions(+), 12 deletions(-)
