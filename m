Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ECDCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB6710E419;
	Mon, 12 Oct 2026 10:38:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281110E419
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791801525; x=1823337525;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BBHi3B5wv4dSmVoyk1lhYI9kPg6KwLQaC+5HS3399ws=;
 b=cmlyrVOsvDJop6ooUdLWKzd6jJskge6WXJHKYeO902XyveKLIYXlfyuV
 WrJwXZVBZdZfPHj8yHQdL+tDFFXwpJuDkhfyq4VCgKQbJK1WW5P7qebbW
 EIZ/f4VUR1bY8+cW0H+Gro270qAK8VRQCF8EChCvVtoxztKr0hHRfBknp
 AktijNSq5X1JOjDFMiafYONGU04hR0OHbRNBaA25z2L+KMZfiW9XgFvvC
 YWRW1gW4BWqD22AR2teVVq6eBRWrVek4qHrYxkQLYLePT6mxHzYDLkFtl
 QxjM7sfKQ/9OpQtzygs8BPVRBlwDqyptKDJC3Cl33oAMh+wEYUAzM8RfD w==;
X-CSE-ConnectionGUID: ZMEdLPitTnKchc1w+8lU6w==
X-CSE-MsgGUID: NUnccm7lQ0ijjLfkVpH/pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="406407"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="406407"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 03:38:43 -0700
X-CSE-ConnectionGUID: HsLbJukWQoGETswxJpgf5w==
X-CSE-MsgGUID: HULMF8/WSqiBXn9oxDqbaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="943745"
Received: from kklawa-mobl1.ger.corp.intel.com (HELO [10.245.114.183])
 ([10.245.114.183])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 03:38:42 -0700
Message-ID: <1939c1aa-4ca8-409e-86a6-63c8bb5a99c7@linux.intel.com>
Date: Mon, 12 Oct 2026 12:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Cache FW API version and simplify API check
 macros
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261012080933.2771862-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20261012080933.2771862-1-karol.wachowski@linux.intel.com>
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

On 2026-10-12 10:09 AM, Karol Wachowski wrote:
> Copy the API version array from the firmware image header into
> struct ivpu_fw_info while the header is being parsed, and use the
> cached copy afterwards. This way the raw firmware image header is only
> accessed during image parsing, which is a step towards releasing the
> firmware image once it has been loaded.
> 
> Since the API version is now available in vdev->fw before the
> compatibility checks run, drop the redundant fw_hdr parameter from
> IVPU_FW_CHECK_API_COMPAT(), IVPU_FW_CHECK_API_VER_LT() and the helpers
> behind them, as well as from ivpu_fw_sched_mode_select().
> 
> Also make DRM_IVPU_PARAM_FW_API_VERSION read the cached copy instead of
> dereferencing the firmware image directly.
> 
> No functional change.
> 

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Co-developed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c |  5 +----
>   drivers/accel/ivpu/ivpu_fw.c  | 36 +++++++++++++++++------------------
>   drivers/accel/ivpu/ivpu_fw.h  |  1 +
>   3 files changed, 20 insertions(+), 22 deletions(-)
> 
