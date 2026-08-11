Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503E0C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A2410E2B5;
	Tue, 11 Aug 2026 09:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bPoPBMcL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000D810E1F6;
 Tue, 11 Aug 2026 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786440705; x=1817976705;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=VqO9snPY1kO7ANxAZxt5rrsRvBARfe7y+xHpx2h2ci4=;
 b=bPoPBMcLApFvX45ujPX9yrPOu1Ll9ng0XRx2CdJH91tpeZO41qAVO0/u
 QlxnjtaXPsUiVl78+X9XsKH5vF4l90dDD1dXiSFwpYVSLeJsP1apt7Jl/
 BY1uuMG5m3vhm5+P8iRrcAceJ/0XNUNIR/HxkK++AYmM0w/wiuiqCH5Rf
 gg7PDFPy9Iy3Z9QRsbXh29+BpYg/kFGdSvrOvjhHFAHvQ5xEl7RjLmHe6
 tq11di+uNHKCel5hpFXhfhOd9b9g6luSfXLkW6ruLy3OcX8hS+7mWYDUc
 3yztu8kgrISg++UaDVVxEV9FHdCsVg+U4oHPDQYzf34Mn9Vo2VEvUjZEw g==;
X-CSE-ConnectionGUID: seCt/7wsT72wwfxxkGiEpQ==
X-CSE-MsgGUID: LogUZBzuRLSvyYaE8Ss5YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86978948"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="86978948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:31:45 -0700
X-CSE-ConnectionGUID: 1/Aid0EDS0iIQg7RbjOdFw==
X-CSE-MsgGUID: /wEw9L/KSzKGKoltvUUvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="266774530"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.254])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:31:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, Deepanshu Kartikey
 <kartikey406@gmail.com>
Cc: joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 chris@chris-wilson.co.uk, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
In-Reply-To: <w3p7i7btvl6b7o5puofyxcjm362ni3mtcfmog2plm6h5wxk3an@dflvwud5t6zf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260809090430.20577-1-kartikey406@gmail.com>
 <w3p7i7btvl6b7o5puofyxcjm362ni3mtcfmog2plm6h5wxk3an@dflvwud5t6zf>
Date: Tue, 11 Aug 2026 12:31:37 +0300
Message-ID: <cf0f4111c04ec71ae979b71c95fa1158c5e68a8a@intel.com>
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

On Tue, 11 Aug 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> Hi Deepanshu,
>
> On 2026-08-09 at 14:34:30 +0530, Deepanshu Kartikey wrote:
>> pci_match_device() can return the dummy pci_device_id_any entry
>> when a device is force-bound via sysfs driver_override, in which
>> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
>> struct intel_device_info * unconditionally and dereferences
>> intel_info->require_force_probe, causing a NULL-ptr-deref.
>> 
>> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
>> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Fixes: 42f5551d2769 ("drm/i915: Split out the PCI driver interface to i915_pci.c")
> This "Fixes" tag should point to the commit that breaks stuff,

In general, agreed...

> I believe, so what you are looking for is
> 7ef5ef5cdead ("drm/i915: add force_probe module parameter to replace alpha_support")
> since this patch introduced that unconditional dereference.

...but that didn't introduce the unconditional reference. I think it was
always there. We've always expected .driver_data to point at whatever we
have specified in MODULE_DEVICE_TABLE().

I'd just slap a Cc: stable on it without Fixes.


BR,
Jani.

>
>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> ---
>>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
>> index 82415af47d54..2f03f95945f1 100644
>> --- a/drivers/gpu/drm/i915/i915_pci.c
>> +++ b/drivers/gpu/drm/i915/i915_pci.c
>> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  		(struct intel_device_info *) ent->driver_data;
>>  	int err;
>>  
>> +	if (!intel_info)
>> +		return -ENODEV;
>> +
>>  	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
>>  		dev_info(&pdev->dev,
>>  			 "Your graphics device %04x is not properly supported by i915 in this\n"
>> -- 
>> 2.43.0
>> 

-- 
Jani Nikula, Intel
