Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB1606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B525C10E871;
	Fri, 30 Oct 2026 09:13:03 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E388825E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:47:06 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.183])
 by gateway (Coremail) with SMTP id _____8AxdvCIWeRqm8caAA--.11783S3;
 Fri, 30 Oct 2026 16:47:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBx6c2EWeRqxGgxAA--.13118S3;
 Fri, 30 Oct 2026 16:47:02 +0800 (CST)
Subject: Re: [PATCH] vga-switcheroo: Allow VGA_SWITCHEROO to be enabled on
 LoongArch
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 chenhuacai@loongson.cn
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 wuqianhai@loongson.cn
References: <20261029013618.3558115-1-zhaotianrui@loongson.cn>
 <5e547172-ac10-4a28-a584-9a385dbe2b80@suse.de>
 <5141c98f-4595-c29e-14b0-8bd324bf8949@loongson.cn>
 <2790b59c-9b8f-43f9-a4a8-53106906bf98@suse.de>
From: zhaotianrui <zhaotianrui@loongson.cn>
Message-ID: <186e26e9-da23-72e4-9464-18e9608ca8ea@loongson.cn>
Date: Fri, 30 Oct 2026 16:39:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2790b59c-9b8f-43f9-a4a8-53106906bf98@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBx6c2EWeRqxGgxAA--.13118S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr47XF1xXw1rZF1fKr1ruFX_yoW5WF1xpr
 yvgFyjkFZ7Jrn5Xw1293W7Wryjy3ZxGFWUWF15J3WDu390yFyfKr4jgryj9FyDCFs3Ar4U
 JrW0qryxuFyDAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


在 2026/10/30 下午4:17, Thomas Zimmermann 写道:
> Hi
>
> Am 30.10.26 um 08:04 schrieb zhaotianrui:
>>
>> 在 2026/10/29 下午4:16, Thomas Zimmermann 写道:
>>> Hi
>>>
>>> Am 29.10.26 um 02:36 schrieb Tianrui Zhao:
>>>> LoongArch systems with hybrid graphics (integrated +
>>>> discrete GPU) can benefit from the same GPU switching
>>>> mechanism that x86 laptops use. Relax the dependency
>>>> to allow VGA_SWITCHEROO to be built on LoongArch,
>>>> consistent with the existing dependencies on ACPI,
>>>> PCI, and FB=y.
>>>>
>>>> Change-Id: I84d38fdfe5e1591495fb3681474a7f1f64281fa8
>>>
>>> Internal change ids should be remove before submitting patches.
>>>
>> Thanks for your review, I will fix this.
>>
>>
>> Best regards
>>
>> Tianrui Zhao
>>
>>>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>>>> ---
>>>>   drivers/gpu/vga/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
>>>> index bad4bcee313..89edd1211aa 100644
>>>> --- a/drivers/gpu/vga/Kconfig
>>>> +++ b/drivers/gpu/vga/Kconfig
>>>> @@ -1,7 +1,7 @@
>>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>>   config VGA_SWITCHEROO
>>>>       bool "Laptop Hybrid Graphics - GPU switching support"
>>>> -    depends on X86
>>>> +    depends on X86 || LOONGARCH
>>>
>>> I'm a bit skeptical if that's all there is to do.  Does loongarch 
>>> really work with the existing handlers in the graphics drivers 
>>> as-is?  See [1] for the interface that implements the actual switching.
>>>
>>> [1] 
>>> https://elixir.bootlin.com/linux/v7.3/source/include/linux/vga_switcheroo.h#L93
>>>
>>> Best regards
>>> Thomas
>>>
>> Thanks,  I will carefully check whether all these 
>> vga_switcheroo_handler callbacks are supported on the LoongArch 
>> platform.
>
> Switcheroo used to be required for x86 notebooks from ~2010. Those 
> systems had two graphics cards, but only one set of output connectors. 
> That design is become rare, I think.
>
> So I'm a bit surprised to see it come back. Which loongarch systems 
> are there?
>
> Best regards
> Thomas
>
>
Hi Thomas,

Thanks for your reply.

On the Loongson platform, we don't have the "two GPUs but only one set 
of display outputs" scenario you described. However, we do have systems 
where an integrated GPU and a discrete GPU coexist.
We would like to use the vga_switcheroo interface to switch between the 
discrete GPU (DIS) and the integrated GPU (IGD), and to configure the 
default VGA device.
Would this approach be feasible? Do you have any suggestions or 
recommendations?

Best regards
Tianrui Zhao
>>
>>
>> Best regards
>>
>> Tianrui Zhao
>>
>>>>       depends on ACPI
>>>>       depends on PCI
>>>>       depends on FB=y
>>>
>>
>

