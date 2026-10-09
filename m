Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2067DCA9EC7
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB08010E7B8;
	Sat, 10 Oct 2026 11:45:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5115010FFF4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:37:26 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8Axj9HTtchqzxYUAA--.58651S3;
 Fri, 09 Oct 2026 17:37:23 +0800 (CST)
Received: from [10.20.42.172] (unknown [10.20.42.172])
 by front1 (Coremail) with SMTP id qMiowJDxg8zTtchqAWkqAA--.61825S2;
 Fri, 09 Oct 2026 17:37:23 +0800 (CST)
Message-ID: <be30e2f2-e126-4be5-910f-75d068526c87@loongson.cn>
Date: Fri, 9 Oct 2026 17:37:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/loongson: Fix double free on BO initialization
 failure
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Evanshenf <archwse@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
 <dce8506787ff72b5a9fac15571d4c59624348430.camel@iscas.ac.cn>
Content-Language: en-US
From: wuqianhai <wuqianhai@loongson.cn>
In-Reply-To: <dce8506787ff72b5a9fac15571d4c59624348430.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxg8zTtchqAWkqAA--.61825S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWUXw4rGr13JF47Zr1xtFc_yoW5JrW3pa
 n3Ga4jyrWDJFs2kr9Fy3WrAa40kayxWrWkWF45G3Wfur1jyw1kJFy3u3s0gFnrXFy7Cr12
 qanxG3ZxXF1qv3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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


Reviewed-by: Qianhai Wu <wuqianhai@loongson.cn>

The fix looks correct and the TTM ownership analysis is accurate.

Thanks,
Qianhai Wu

在 2026/10/9 16:42, Icenowy Zheng 写道:
> 在 2026-10-03六的 09:34 +0000，Evanshenf写道：
>> If ttm_bo_init_validate() fails, it drops the buffer object's
>> reference
>> and cleans it up through the supplied destroy callback.
>> lsdc_bo_destroy()
>> releases the GEM object and frees the enclosing lsdc_bo, so freeing
>> it
>> again in lsdc_bo_create() causes a double free on a synchronous
>> failure
>> path.
>>
>> Let TTM own the cleanup after initialization has started and return
>> the
>> error directly. Keep the explicit free on drm_gem_object_init()
>> failure,
>> which occurs before ownership is passed to TTM.
>>
>> Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for
>> one
>> selected dumb-buffer creation. The error reached userspace, the
>> destroy
>> callback ran once, and no handle was published or tracked BO
>> retained.
>> Normal buffer creation, zeroing, mapping, readback and release
>> passed.
>>
>> AI assistance was used for the ownership analysis, fix, fault-
>> injection
>> tools, build and test execution.
>>
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Evanshenf <archwse@gmail.com>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> index d7441d9..88536e2 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> @@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device
>> *ddev,
>>   
>>   	ret = ttm_bo_init_validate(bdev, tbo, bo_type, &lbo-
>>> placement, 0,
>>   				   false, sg, resv,
>> lsdc_bo_destroy);
>> -	if (ret) {
>> -		kfree(lbo);
>> +	if (ret)
>>   		return ERR_PTR(ret);
> 
> It looks like this fix is valid, ttm_bo_init_reserved() (called by
> ttm_bo_init_validate() ) will do a ttm_bo_put() operation when failure,
> which leads to calling the destroy callback.
> 
> ```
> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ```
> 
> Thanks,
> Icenowy
> 
>> -	}
>>   
>>   	return lbo;
>>   }
>>
>> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

