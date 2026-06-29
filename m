Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C6AC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B91A10E092;
	Mon, 29 Jun 2026 10:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JRt5q7p7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684E910E092
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782728816; x=1814264816;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=LLnFYXp11vlHjc2JhLXWGsdV2adwnb847wZ90jKFlok=;
 b=JRt5q7p7TGPqRLR9BlhVfFAKmEkGkFVgbLVtNJKfqEc48TihHZueuUy7
 m5X2EFxJ4zFMrE+F/CuLvl0XjUKb6kJZKim+Nx9Gx6LGRkQyM0U3JYzug
 pxNfOjq5RWHv6bHNkrTf5qsjLRriLKkRNVVk+LSDqbD7j51rsEFUctIrU
 o6umijNABTAlZUGgPlc9L7WjMGuHh6TVrdCNnUQKPmtEYTOV16V64W1z/
 pTEW9KsbQ2Y6r59sb67DcYqZrU9kI0gzZ6DIG/zLozUrjlt2MgcDL622u
 +mW6o/XqcQ55Mx8sOwhijwJt744TqQUFlRbYtbZ0e98k1I2Xvxx1lN2E8 w==;
X-CSE-ConnectionGUID: jprv5jKrTLOaEMHX2DR8iA==
X-CSE-MsgGUID: D3SNhtyyQCG0cXmcC/p8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83502936"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="83502936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 03:26:56 -0700
X-CSE-ConnectionGUID: kGXHeZoNR2m3ch57AQpCyw==
X-CSE-MsgGUID: MKx6NBcYQ4WBkHanQSlhCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="253822147"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.253])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 03:26:54 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Helge Deller <deller@gmx.de>, WenTao Liang <vulab@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/video: __screen_info_pci_dev: leaked
 pci_dev references in pci_get_base_class loop
In-Reply-To: <c9c60382-e6eb-4ff8-8756-a48a39924d46@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260627034428.59479-1-vulab@iscas.ac.cn>
 <c9c60382-e6eb-4ff8-8756-a48a39924d46@gmx.de>
Date: Mon, 29 Jun 2026 13:26:51 +0300
Message-ID: <bfeb8e783cd749e4439a4a82546c7bfe63e9a3d8@intel.com>
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

On Sat, 27 Jun 2026, Helge Deller <deller@gmx.de> wrote:
> On 6/27/26 05:44, WenTao Liang wrote:
>> In __screen_info_pci_dev(), the loop uses pci_get_base_class() with a
>> non-NULL starting device pdev. Each iteration returns a new device
>> reference but does not release the previous one. When a non-matching
>> device is found, pdev is overwritten and the previous reference leaks.
>> When no match is found, all acquired references are leaked.
>> 
>> Add pci_dev_put(pdev) for non-matching devices before continuing the loop.
>> 
>> Cc: stable@vger.kernel.org
>> Fixes: 036105e3a776 ("video: Provide screen_info_get_pci_dev() to find screen_info's PCI device")
>> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/video/screen_info_pci.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
>> index 8f34d8a74f09..c821101e9304 100644
>> --- a/drivers/video/screen_info_pci.c
>> +++ b/drivers/video/screen_info_pci.c
>> @@ -123,6 +123,10 @@ static struct pci_dev *__screen_info_pci_dev(struct resource *res)
>>   
>>   	while (!r && (pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
>>   		r = pci_find_resource(pdev, res);
>> +		if (!r) {
>> +			pci_dev_put(pdev);
>> +			pdev = NULL;
>> +		}
>
> Have you tested the code?
> If pdev gets assigned NULL, doesn't that introduce an endless loop?
> And, similar code is in amdgpu*  and google's framebuffer-coreboot.c files, so if
> this is correct, don't they need fixing as well?

More specifically, pci_get_base_class() decrements the passed in "from"
refcount if it's not NULL.

BR,
Jani.


-- 
Jani Nikula, Intel
