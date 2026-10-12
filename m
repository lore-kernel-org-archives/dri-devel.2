Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA7CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A6110E424;
	Mon, 12 Oct 2026 10:44:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3904C10E424
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791801845; x=1823337845;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SEfVN1rMBwlOMLLWu/ddqvpFErAo20J4CQ/BN9sU2Fk=;
 b=dlmpTX2073JNdIoiCySxVc29UU1gApfAtGH0aaPy26iYTk3YuJsGpEH/
 q43+n4m69docT5OZ8b508KpJSYYpJqWuPyGlIw2BqznoKUA4XXf8V51Nk
 SajgMi6NXe85e0Eo6eD7AvGRMVJ/PtGln1u9tKgz7ZYGMjwsjV1quvDC6
 +xAkYt8FeHtNt5/OJsA5uiWMOLDaj/OuCAPCPfdvSthPBDDANSrCZ28GQ
 fehCnDA4GDBDJqFsGtsR/guwuPaxDks0fP6QZUkR6AUdWk9z26MOayzqM
 0RptgOgIIy6nZafroxrz6kq1UEUYEau5Odun0FksqOpS7EFAZIqYdJi3n g==;
X-CSE-ConnectionGUID: mtqTCzD3RxmlU7/HQTmoYQ==
X-CSE-MsgGUID: oGeX25jFRJmhbzn28geTnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="406881"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="406881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 03:44:05 -0700
X-CSE-ConnectionGUID: wVO4WcRLTOmZVta0HRohYQ==
X-CSE-MsgGUID: 65RyuMVCSnS3IWDVjxTFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="944650"
Received: from kklawa-mobl1.ger.corp.intel.com (HELO [10.245.114.183])
 ([10.245.114.183])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 03:44:04 -0700
Message-ID: <dbf828c1-d801-465d-9f8c-d81cd78fcb81@linux.intel.com>
Date: Mon, 12 Oct 2026 12:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/ivpu: Merge register headers and extend tile
 fuse config
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
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

On 2026-10-12 10:37 AM, Karol Wachowski wrote:
> This series removes duplication between the per-generation register
> definitions and code in the ivpu driver, and adds a debug test mode.
> 
> Patch 1 adds a test mode that enables the buttress FREQ_CHANGE interrupt
> and stores the buttress interrupt mask in struct ivpu_hw_info.
> 
> Patches 2-4 merge the 37xx/40xx IP register headers, the identical 37xx
> and 40xx IP functions, and the MTL/LNL buttress register headers. There
> is no functional change.
> 
> Patch 5 extends the tile fuse config field to 7 bits.

For the series

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> 
> Karol Wachowski (5):
>    accel/ivpu: Add test mode to enable the FREQ_CHANGE interrupt
>    accel/ivpu: Merge NPU IP register headers
>    accel/ivpu: Merge identical 37xx and 40xx IP functions
>    accel/ivpu: Merge buttress register headers
>    accel/ivpu: Extend tile fuse config to 7 bits
> 
>   drivers/accel/ivpu/ivpu_drv.h                 |   1 +
>   drivers/accel/ivpu/ivpu_hw.c                  |   5 -
>   drivers/accel/ivpu/ivpu_hw.h                  |   7 +-
>   drivers/accel/ivpu/ivpu_hw_40xx_reg.h         | 195 ---------
>   drivers/accel/ivpu/ivpu_hw_btrs.c             |  32 +-
>   drivers/accel/ivpu/ivpu_hw_btrs.h             |   2 -
>   drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h     |  83 ----
>   ...u_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} |  84 +++-
>   drivers/accel/ivpu/ivpu_hw_ip.c               | 396 +++---------------
>   drivers/accel/ivpu/ivpu_hw_ip.h               |   3 +-
>   .../{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h}  |  69 ++-
>   11 files changed, 232 insertions(+), 645 deletions(-)
>   delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
>   delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
>   rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} (58%)
>   rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h} (73%)
> 

