Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10B6C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0AB10E055;
	Mon,  3 Aug 2026 15:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="HUvSbXQS";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C9A10E055
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785770042; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oCaI8PPCNmnAUupEKPJo6syVSVrpVbuvkG3cZRePPr5UhmXHaENatQDOpuD7TO95SL0XfviY653qo10CT2NaeOxxiUHd1tTm4MBw1uG5Oe6zcwYg3hWGwozOhUKwRehudWcYkhcHylZOSSs7PsAZHsw4YYIubV5botr6+QNQmEI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785770042;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FnbfQALBD3h4ZQNwo4mkB5QnOpg6gXZJ9qBC7x/dy9U=; 
 b=TZ+A/dyrdEkJX3idCH++87FzTZn5Vkv+g+PfcRlLkKlFMgIjS6tHk2L6BwKlwrwEnxtpoX3iVXtLzvYf6XvKyIfZBOgWHxbxU5br3wMbvwJa6iCFfIL+oxMY1QHUXc7yBpSmhpDtYtPPvWje4IF1K2I6kyKKQclASxI2DSHwGsw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785770042; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=FnbfQALBD3h4ZQNwo4mkB5QnOpg6gXZJ9qBC7x/dy9U=;
 b=HUvSbXQSHiPyJNqMBcnhXoMr2qgglSEuDagLORDIo7LrgvC5RLAghMVuS98a/W2O
 1VFAelqVR3YJ+u2ZfmwMqVYVScxYhp2ySeE0yrXXyd4typKi69NQpW/SE55I7A/z4I+
 G8h4xroBglyTCJqXxFmNKG1ahrEkx/rKZYXai/4A=
Received: by mx.zohomail.com with SMTPS id 1785770041557295.06067408977685;
 Mon, 3 Aug 2026 08:14:01 -0700 (PDT)
Message-ID: <e0129e0c-9157-4ddd-a54b-37d09135160f@collabora.com>
Date: Mon, 3 Aug 2026 17:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260722110145.36641-1-robert.mader@collabora.com>
 <IA0PR11MB71859E0D17C2959DCBA7CF3AF8CB2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <IA0PR11MB71859E0D17C2959DCBA7CF3AF8CB2@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 28.07.26 22:20, Kasireddy, Vivek wrote:
> Hi Robert,
>
>> Subject: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
>>
>> As udmabuf increasingly enjoys popularity - being used in projects like
>> libcamera, Gstreamer, Mesa, KWin and Weston - users more frequently
>> encounter cases where the current default size limit of 64MB is too low.
>> Examples include allocating video buffers at a 8K resolution - and even
>> 4K
>> is affected when using non-subsampled video formats and high bit
>> depths.
>>
>> In its current form the size limit for individual buffers does not seem to
>> provide any additional level of protection - such as limiting the amount
>> of
>> memory a process can pin - as the later can just allocate multiple
>> buffers.
>> If additional guardrails are desired, they would likely require some kind
>> accounting not limited to individual buffers.
>>
>> Therefor let's disable the size limit by default by setting it to the
>> maximal possible value, INT_MAX.
>>
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>>
>> ---
>>
>> Changes in V2:
>>   - Use INT_MAX instead of 0 in order to not change behavior otherwise.
>>
>> See
>> https://lore.kernel.org/dri-devel/20260711144814.8205-1-
>> robert.mader@collabora.com/
>> for a previous attempt to make the value configurable via kconfig - and
>> in particular
>> https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-
>> 2ca867ac2d41@amd.com/
>> for the suggestion and discussion to remove the default limit.
>> ---
>>   drivers/dma-buf/udmabuf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>> index bced421c0d65..639e93704924 100644
>> --- a/drivers/dma-buf/udmabuf.c
>> +++ b/drivers/dma-buf/udmabuf.c
>> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>>   module_param(list_limit, int, 0644);
>>   MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
>> Default is 1024.");
>>
>> -static int size_limit_mb = 64;
>> +static int size_limit_mb = INT_MAX;
>>   module_param(size_limit_mb, int, 0644);
>> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is 64.");
>> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is INT_MAX.");
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> If there are no further concerns/questions from anyone, I'll push it to
> drm-misc-next soon.

FTR., we already have a first duplicate :P

https://lore.kernel.org/dri-devel/20260803144120.11524-1-xaver.hugl@kde.org/

>
> Thanks,
> Vivek
>>   struct udmabuf {
>>   	pgoff_t pagecount;
>> --
>> 2.55.0

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

