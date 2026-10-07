Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68978CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7D810E107;
	Wed,  7 Oct 2026 13:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oMaLe9yj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8752B10E58E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:09:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD8C1595;
 Wed,  7 Oct 2026 06:09:36 -0700 (PDT)
Received: from [10.57.75.203] (unknown [10.57.75.203])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596A73F66F;
 Wed,  7 Oct 2026 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791378579; bh=UTZVBvMKVq9bHDX2yhf6FOlhWljTZm8XMVowKeG9ev8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oMaLe9yjQREpK2+YoSuF0iz/+8bAYiu1vGiBIQTLnMVlcf5uBqgKl1Zy/SoIM3mdW
 tdTjJaVEAzRbhgnwjbxXi/sHjy6Se6ShriAlVDd2ltFfQimA5/h3EqxRs8QUa+iUsf
 26BYbCCvx/5SMBcm9i/X7ENeXCvI16xbNzXJC584=
Message-ID: <00bd53b9-c6b6-4d84-aaeb-aeade3ffb3fb@arm.com>
Date: Wed, 7 Oct 2026 14:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <179130511905.1018806.3717655233851799587.b4-reply@b4>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <179130511905.1018806.3717655233851799587.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
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

On 06/10/2026 17:45, Adrián Larumbe wrote:
> On 2026-10-02 16:14:38+01:00, Steven Price wrote:
>> On 29/09/2026 04:44, Adrián Larumbe wrote:
>>
>>> The GPU cache flush/invalidate operation is unnecessary. First off, the
>>> GPU doesn't read off the perfcnt sample buffer, only writes into it, so
>>
>> I don't think this is entirely true. The GPU performance counter unit
>> only writes the counters that are enabled, counters that share a cache
>> line but are not enabled are not written by the performance counter
>> unit, but if the L2 contains that cache line then the write can hit in
>> the L2 and dirty the entire line including stale data where the
>> unwritten cache line is.
> 
> From the perspective of UM, is it bad if offsets into the perfcnt buffer
> that stand for counters they did not enable contain undefined values?

There's two things to consider here:

* Does the UM care? The UM could write canary values to check that the
GPU has actually filled in the counters. Replacing them with "undefined"
values would break this behaviour. I'm not sure whether this is done -
but it can be used to check that the hardware is actually writing the
counter as expected.

* Is it a security hole? If the GPU cache was from when this BO was used
by another context then this is obviously bad. As Boris pointed out this
shouldn't be possible in the current driver if we're invalidating on unmap.

>> The upshot is that if the CPU has cleared a block of memory which the
>> GPU happens to have cached, then the "unused" counters may end up
>> showing the old data before the CPU cleared it (if they share a cache
>> line with an active counter).
>>
>> I have to admit it's probably somewhat academic given that Panfrost
>> doesn't expose the ability to control which counters are enabled...
>>
>> Is there a good reason for this patch (i.e. have you seen a performance
>> problem with doing the invalidate)? Otherwise I'd prefer we keep to the
>> safe route rather than trying to over optimise cache maintenance.
> 
> Like Boris said in a later reply, it was mostly about simplifying error handling
> in the perfcnt enable path. We saw this initial clean being done and thought it
> wasn't necessary.

I think we need at least a comment explaining why this is safe. It does
seem that as things currently stand we don't actually need it though.

Thanks,
Steve

>> Obviously in the fully coherent case the invalidate could be skipped (as
>> in the next patch).
>>
>> Thanks,
>> Steve
> 
> 

