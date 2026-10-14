Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58509CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02DA10FB02;
	Wed, 14 Oct 2026 06:05:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C2F10FB02
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791957951; x=1823493951;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MN4TpmrE/nMnH1AFHNqcM8Uf4Fcfi+BG068BkqwH6Hs=;
 b=fsJI4SbkRSRPPJXK4Xf1Z6zzP//Espy6nuIxVaBlDD07Ikf0BxIB8CAk
 VETBiW6ccu3zv6Zr1N3O65HyNAA+rRbQjLrtyDpqSmdETilGU0sClF45M
 nR7cUlkfGQWYhOr9JPTYEmikXaMgZjSqiPGhhtzraF08qJts1rbttb/rN
 yao9HtHeKoBlo/+EgkKpuVehLVCck+8UnwUc3pzlsh9hllsFi9i1KGqL4
 2PKq+6OCBYQQDV/KmedNk8jQvH1GPyEsb3ljgJ00d/z40sqCKqOrCpP+w
 jPtvfawTO1UD6gyuA1OsuEh8ATPEtSpB6r6yQFV3Ycb+j7gPuKT5rV8EC g==;
X-CSE-ConnectionGUID: N0aWuNVVT3GMY9ttg/9VQw==
X-CSE-MsgGUID: RhxWJ0F1QcO+4Zbmyz5nrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="591234"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="591234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 23:05:39 -0700
X-CSE-ConnectionGUID: hDx/uvZtQkWuIYIwh3fB0Q==
X-CSE-MsgGUID: zrBcPoPOTA68WlYf8fZETQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1279380"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 23:05:37 -0700
Message-ID: <638bc116-bdcf-4872-97bb-59d50fe6457b@linux.intel.com>
Date: Wed, 14 Oct 2026 08:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Cache FW API version and simplify API check
 macros
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261012080933.2771862-1-karol.wachowski@linux.intel.com>
 <1939c1aa-4ca8-409e-86a6-63c8bb5a99c7@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <1939c1aa-4ca8-409e-86a6-63c8bb5a99c7@linux.intel.com>
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

On 12-Oct-26 12:38, Dawid Osuchowski wrote:
> On 2026-10-12 10:09 AM, Karol Wachowski wrote:
>> Copy the API version array from the firmware image header into
>> struct ivpu_fw_info while the header is being parsed, and use the
>> cached copy afterwards. This way the raw firmware image header is only
>> accessed during image parsing, which is a step towards releasing the
>> firmware image once it has been loaded.
>>
>> Since the API version is now available in vdev->fw before the
>> compatibility checks run, drop the redundant fw_hdr parameter from
>> IVPU_FW_CHECK_API_COMPAT(), IVPU_FW_CHECK_API_VER_LT() and the helpers
>> behind them, as well as from ivpu_fw_sched_mode_select().
>>
>> Also make DRM_IVPU_PARAM_FW_API_VERSION read the cached copy instead of
>> dereferencing the firmware image directly.
>>
>> No functional change.
>>
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-next.

> 
>> Co-developed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_drv.c |  5 +----
>>   drivers/accel/ivpu/ivpu_fw.c  | 36 +++++++++++++++++------------------
>>   drivers/accel/ivpu/ivpu_fw.h  |  1 +
>>   3 files changed, 20 insertions(+), 22 deletions(-)
>>

