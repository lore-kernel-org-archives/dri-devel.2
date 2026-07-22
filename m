Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED8BC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF26D10ED54;
	Wed, 22 Jul 2026 11:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="kS3ISGZX";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0686910ED54
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784718189; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PcT0EZ6+xXDwNt+rSSt4sdoqKnF49V9yYzT6fLrIhgs4+OVZEYi4HJMwfXyLTCj//9Fs4DfUyVR7L7FwmnaaZLmXnbYj9f7ZW7fll5lQBp063p6Cc1UsVAu+AWTK2rYEPV803Bp7qrWLvJ2Ke6pTnC5szhl7YLjBaTR9lqPD48w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784718189;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OGAYaNXWmxr7mNrGiACuBSj9G33y7xnZdK51aK8cklI=; 
 b=EPg3J/HHigHpafV8aaKIsODIk02mrTbD4Wj92c/WRKJ0Xi0hF7j5+YodA6sGs8YPOOZ8OdNjSeqbBq9PnsWww31XTtmzTRUHvklLYU1olkKnaKJ9joRo1Gaja4C+cNGWu0Icg3FR/aj877CCY2Yg0AO5z9Oy6t9ewxcnXZN/2EQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784718189; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=OGAYaNXWmxr7mNrGiACuBSj9G33y7xnZdK51aK8cklI=;
 b=kS3ISGZX1bztZbir0C//7se0iDx0nb6oAb9Gta5bBXnZdREcDUr5/6Q0CZSr0a0K
 w8OnzQiTcgD2VrPdnSKMYK04vzZShZm33PI4UL6yKVfPDSm9+7lCjdUIvahWwguMGUT
 fZTDyt/s30hVGHsLdXdtwGiCKYKPtKiRUrYPBNlg=
Received: by mx.zohomail.com with SMTPS id 1784718187703204.5553535598766;
 Wed, 22 Jul 2026 04:03:07 -0700 (PDT)
Message-ID: <f6a78f00-ae95-40d2-a8c3-12d31ac7a75a@collabora.com>
Date: Wed, 22 Jul 2026 13:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260717125750.62639-1-robert.mader@collabora.com>
 <IA0PR11MB718505780A8DBCAC7C9EC0E2F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <IA0PR11MB718505780A8DBCAC7C9EC0E2F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
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

Hi Vivek,

On 22.07.26 08:03, Kasireddy, Vivek wrote:
> Hi Robert,
>
>> Subject: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
>>
>> As udmabuf increasingly enjoys popularity - being used in projects like
>> libcamera, Gstreamer, Mesa, KWin and Weston - users more frequently
>> encounter cases where the current default size limit of 64MB is too low.
>> Examples include allocating video buffers at a 8K resolution - and even 4K
>> is affected when using non-subsampled video formats and high bit depths.
>>
>> In its current form the size limit for individual buffers does not seem to
>> provide any additional level of protection - such as limiting the amount of
>> memory a process can pin - as the later can just allocate multiple buffers.
>> If additional guardrails are desired, they would likely require some kind
>> accounting not limited to individual buffers.
>>
>> Therefor let's disable the size limit by default. Use the special value
>> of zero to do so, which prevously could be used to effectively disable the
>> interface. Using other means, such as file permissions, appears to be a
>> much better fit for that purpose.
>>
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>>
>> ---
>>
>> Please let me know if changing the meaning of the parameter value of zero
>> is considered a breaking change / not acceptable. In that case INT_MAX
>> might be a better option.
> Yeah, I think using INT_MAX might be better.
did that in v2, thanks!
>
> Thanks,
> Vivek
>
>> See
>> https://lore.kernel.org/dri-devel/20260711144814.8205-1-
>> robert.mader@collabora.com/
>> for a previous attempt to make the value configurable via kconfig - and
>> in particular
>> https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-
>> 2ca867ac2d41@amd.com/
>> for the suggestion and discussion to remove the default limit.
>> ---
>>   drivers/dma-buf/udmabuf.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>> index bced421c0d65..3509b690d8e2 100644
>> --- a/drivers/dma-buf/udmabuf.c
>> +++ b/drivers/dma-buf/udmabuf.c
>> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>>   module_param(list_limit, int, 0644);
>>   MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
>> Default is 1024.");
>>
>> -static int size_limit_mb = 64;
>> +static int size_limit_mb = 0;
>>   module_param(size_limit_mb, int, 0644);
>> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is 64.");
>> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Setting 0 disables the limit. Default is 0.");
>>
>>   struct udmabuf {
>>   	pgoff_t pagecount;
>> @@ -373,7 +373,7 @@ static long udmabuf_create(struct miscdevice
>> *device,
>>
>>   		subpgcnt = list[i].size >> PAGE_SHIFT;
>>   		pgcnt += subpgcnt;
>> -		if (pgcnt > pglimit)
>> +		if (pglimit && pglimit < pgcnt)
>>   			goto err_noinit;
>>
>>   		max_nr_folios = max_t(unsigned long, subpgcnt,
>> max_nr_folios);
>> --
>> 2.55.0

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

