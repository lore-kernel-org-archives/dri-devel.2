Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE78606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573D71126A9;
	Fri, 30 Oct 2026 09:13:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F24112668
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:13:03 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.183])
 by gateway (Coremail) with SMTP id _____8AxntJ7Q+RqZ8EaAA--.11981S3;
 Fri, 30 Oct 2026 15:12:59 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxKs55Q+Rq4mMxAA--.13206S3;
 Fri, 30 Oct 2026 15:12:57 +0800 (CST)
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
From: zhaotianrui <zhaotianrui@loongson.cn>
Message-ID: <5141c98f-4595-c29e-14b0-8bd324bf8949@loongson.cn>
Date: Fri, 30 Oct 2026 15:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5e547172-ac10-4a28-a584-9a385dbe2b80@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxKs55Q+Rq4mMxAA--.13206S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4kKryfCryfCFWfGrWUJrc_yoW8AFWfpF
 Wv9ryjkrZ7Ar95X3ZFg3WxWa43Zw1DGFWUWF1rKas8ZrWDAFyxKryDWrWjgFyDCFs7Zry7
 JrZ2gr17uF98JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
 UUUUU
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


在 2026/10/29 下午4:16, Thomas Zimmermann 写道:
> Hi
>
> Am 29.10.26 um 02:36 schrieb Tianrui Zhao:
>> LoongArch systems with hybrid graphics (integrated +
>> discrete GPU) can benefit from the same GPU switching
>> mechanism that x86 laptops use. Relax the dependency
>> to allow VGA_SWITCHEROO to be built on LoongArch,
>> consistent with the existing dependencies on ACPI,
>> PCI, and FB=y.
>>
>> Change-Id: I84d38fdfe5e1591495fb3681474a7f1f64281fa8
>
> Internal change ids should be remove before submitting patches.
>
Thanks for your review, I will fix this.


Best regards

Tianrui Zhao

>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> ---
>>   drivers/gpu/vga/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
>> index bad4bcee313..89edd1211aa 100644
>> --- a/drivers/gpu/vga/Kconfig
>> +++ b/drivers/gpu/vga/Kconfig
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config VGA_SWITCHEROO
>>       bool "Laptop Hybrid Graphics - GPU switching support"
>> -    depends on X86
>> +    depends on X86 || LOONGARCH
>
> I'm a bit skeptical if that's all there is to do.  Does loongarch 
> really work with the existing handlers in the graphics drivers as-is?  
> See [1] for the interface that implements the actual switching.
>
> [1] 
> https://elixir.bootlin.com/linux/v7.3/source/include/linux/vga_switcheroo.h#L93
>
> Best regards
> Thomas
>
Thanks,  I will carefully check whether all these vga_switcheroo_handler 
callbacks are supported on the LoongArch platform.


Best regards

Tianrui Zhao

>>       depends on ACPI
>>       depends on PCI
>>       depends on FB=y
>

