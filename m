Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCF3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F0210FAEF;
	Wed, 14 Oct 2026 06:05:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D762F10FAFC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791957924; x=1823493924;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=YMAucHxdHSGVAFeQF8ao4zsU0v/4Skhs7vmldmyOxjo=;
 b=RrtZOp+3Cq/T4zh90VqArbEvKDlcnNcxP7i3Q7vJqYWmdHzWHohbxda/
 +8DoYOGycpRbUdtMlzTwOGQLGV+a26AHKqSRxgnlEzgxxYJUYOB2+JkdS
 Ok9PsuXnMKeMcNGF+1TwSwZMVGguCKByCelgBrbB6mzyLCR3PFaLnaVzW
 zCb3gWwqDWU5Qr7Gxu/g4D+DiOY1bnsgl9VZ6gCVyBqqeiiHeZmbjRX5Z
 KNWooP5kHFyLV6XHucc1U1fp3t7bm2I/cg6do2ErLG6PVZETf1hYWcIDM
 M4URIVrTnyfMQRFOiZpg4+GJawrlKtfApqHg7JcfsRR+RgqW8ayNeT/Ua A==;
X-CSE-ConnectionGUID: E8HDxHRZQgmX1L7RQGLlGQ==
X-CSE-MsgGUID: B4ymv+3qR1Wrj9JpV0ILKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="591203"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="591203"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 23:05:23 -0700
X-CSE-ConnectionGUID: 0lAli5nmQmqY8bZDBB1KcQ==
X-CSE-MsgGUID: aWqpl4bkT9OJ1YOseAYSBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1279362"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 23:05:21 -0700
Message-ID: <c9582ee0-2bac-49a0-a8f7-78fe1a7074f7@linux.intel.com>
Date: Wed, 14 Oct 2026 08:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/ivpu: Merge register headers and extend tile
 fuse config
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
 <dbf828c1-d801-465d-9f8c-d81cd78fcb81@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <dbf828c1-d801-465d-9f8c-d81cd78fcb81@linux.intel.com>
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

On 12-Oct-26 12:44, Dawid Osuchowski wrote:
> On 2026-10-12 10:37 AM, Karol Wachowski wrote:
>> This series removes duplication between the per-generation register
>> definitions and code in the ivpu driver, and adds a debug test mode.
>>
>> Patch 1 adds a test mode that enables the buttress FREQ_CHANGE interrupt
>> and stores the buttress interrupt mask in struct ivpu_hw_info.
>>
>> Patches 2-4 merge the 37xx/40xx IP register headers, the identical 37xx
>> and 40xx IP functions, and the MTL/LNL buttress register headers. There
>> is no functional change.
>>
>> Patch 5 extends the tile fuse config field to 7 bits.
> 
> For the series
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-next.

> 
>>
>> Karol Wachowski (5):
>>    accel/ivpu: Add test mode to enable the FREQ_CHANGE interrupt
>>    accel/ivpu: Merge NPU IP register headers
>>    accel/ivpu: Merge identical 37xx and 40xx IP functions
>>    accel/ivpu: Merge buttress register headers
>>    accel/ivpu: Extend tile fuse config to 7 bits
>>
>>   drivers/accel/ivpu/ivpu_drv.h                 |   1 +
>>   drivers/accel/ivpu/ivpu_hw.c                  |   5 -
>>   drivers/accel/ivpu/ivpu_hw.h                  |   7 +-
>>   drivers/accel/ivpu/ivpu_hw_40xx_reg.h         | 195 ---------
>>   drivers/accel/ivpu/ivpu_hw_btrs.c             |  32 +-
>>   drivers/accel/ivpu/ivpu_hw_btrs.h             |   2 -
>>   drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h     |  83 ----
>>   ...u_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} |  84 +++-
>>   drivers/accel/ivpu/ivpu_hw_ip.c               | 396 +++---------------
>>   drivers/accel/ivpu/ivpu_hw_ip.h               |   3 +-
>>   .../{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h}  |  69 ++-
>>   11 files changed, 232 insertions(+), 645 deletions(-)
>>   delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
>>   delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
>>   rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h => 
>> ivpu_hw_btrs_reg.h} (58%)
>>   rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h} 
>> (73%)
>>
> 

