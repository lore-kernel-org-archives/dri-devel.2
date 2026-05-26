Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACC7CD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E180710E4A4;
	Tue, 26 May 2026 06:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ktf1rbNI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6276710E475
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779775586; x=1811311586;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=jSQ2/6HZxVPvd7ej0vQenXuyViIh2JUb5nln9NM0vtg=;
 b=Ktf1rbNIq7jymOKVa/iLBsmTxQood3hJH/kxcAvDBq35fH94bWfbgI9e
 2swmd81wI1VcCQ30zw1Rg/H8ccUkQZ7FAhJrPx5Clgr/6iYzfkIbQo5/5
 yTMiPI6nI86gEqi5aXAXTUDbNyzCUXfmQIl5egLqD0uPZV7swekA6e0P0
 CcG4MtrS2YuKx+qeeqKBhevOA+0gn7xJlx/GwoIzlfLvGgS/jKMxqNM2U
 a+3fnWGkU2nfiq9yU+He+JG5xCIrqsYMZZ5da7KgmvWvC09frMcC0rehL
 hm1/oZ8O5HjTVzDJnchm7khTjlxwVvrq3hkgfqekHg8E5RbrD+0corDGZ Q==;
X-CSE-ConnectionGUID: YMYtHbd2T0Wkk6El1gZImA==
X-CSE-MsgGUID: 4+/gmj7jTcKI1x3mt9O4AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="98008246"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="98008246"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 23:06:26 -0700
X-CSE-ConnectionGUID: 7z48n7yZRdylXMGq7pWGmA==
X-CSE-MsgGUID: YgoCyO9aSvOAGXut+qHEiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241988971"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.37])
 ([10.217.180.37])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 23:06:23 -0700
Message-ID: <764ba649-9a96-44c4-95f2-8dcf2f425133@linux.intel.com>
Date: Tue, 26 May 2026 08:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: prevent uninitialized data bug in debugfs
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Dan Carpenter <error27@gmail.com>,
 Karol Wachowski <karol.wachowski@intel.com>
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ahP24m6Mii9EDL7Q@stanley.mountain>
 <9a6b239c-d970-4ec3-abf0-6b900b786279@linux.intel.com>
Content-Language: en-US
In-Reply-To: <9a6b239c-d970-4ec3-abf0-6b900b786279@linux.intel.com>
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

On 25-May-26 9:25, Wachowski, Karol wrote:
> On 25-May-26 9:14, Dan Carpenter wrote:
>> The simple_write_to_buffer() will only initialize data starting from
>> the *pos offset so if it's non-zero then the first part of the buffer
>> uninitialized.  Really, if *pos is non-zero then this code won't work
>> so just check for that at the start of the function.
>>
>> Fixes: 320323d2e545 ("accel/ivpu: Add debugfs interface for setting 
>> HWS priority bands")
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>> ---
>>   drivers/accel/ivpu/ivpu_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ 
>> ivpu_debugfs.c
>> index 189dbe94cf14..dc20bc73c6ed 100644
>> --- a/drivers/accel/ivpu/ivpu_debugfs.c
>> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
>> @@ -450,7 +450,7 @@ priority_bands_fops_write(struct file *file, const 
>> char __user *user_buf, size_t
>>       u32 band;
>>       int ret;
>> -    if (size >= sizeof(buf))
>> +    if (*pos != 0 || size >= sizeof(buf))
>>           return -EINVAL;
>>       ret = simple_write_to_buffer(buf, sizeof(buf) - 1, pos, 
>> user_buf, size);
> 
> Thanks for submission.
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Applied to drm-misc-fixes.
