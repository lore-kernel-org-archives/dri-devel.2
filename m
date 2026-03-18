Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29EAFCD0D2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1856610E744;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8F30F10E0BF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:58:13 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8AxDMMLW7ppED8cAA--.16548S3;
 Wed, 18 Mar 2026 15:58:03 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJBxacECW7ppzJ1XAA--.22267S3;
 Wed, 18 Mar 2026 15:57:58 +0800 (CST)
Subject: Re: [PATCH] MAINTAINERS: Update GPU driver maintainer information
To: Huacai Chen <chenhuacai@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org
References: <20260318071307.3682-1-lvjianmin@loongson.cn>
 <CAAhV-H7PmqY_cbU7Kp-DOL+H_urD45-8CR1kJsXXUoJ4DXgtqg@mail.gmail.com>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5bf210fa-3f8a-ab4d-f23a-e9fccc4b660c@loongson.cn>
Date: Wed, 18 Mar 2026 15:50:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7PmqY_cbU7Kp-DOL+H_urD45-8CR1kJsXXUoJ4DXgtqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxacECW7ppzJ1XAA--.22267S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWfCw15Aw1fCw4UWF17urX_yoW8CFy3pr
 Z3Ga4akrsrJF4fAwsIqa47ZFWYq3yrArZ8Wr4Dt3s3ur90vwn8tF4UJa15Ka9rXFyrKFW2
 ywn2kayIka13GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
 6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUU
 UU=
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Ok, I'll re-submit it later, thanks.

On 2026/3/18 下午3:40, Huacai Chen wrote:
> Hi, Jianmin,
> 
> On Wed, Mar 18, 2026 at 3:20 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: lvjianmin <lvjianmin@loongson.cn>
>>
>> I and Qianhai are GPU R&D engineers at Loongson, specializing
>> in kernel driver development. We understand that the current
>> Loongson GPU driver lacks dedicated maintenance resources
>> because of some reasons.
>>
>> As Loongson GPU driver developers, we have both the capability
>> and the responsibility to continuously maintain the Loongson
>> GPU driver, ensuring minimal impact on its users. After internal
>> discussions, our team has decided to recommend me and Qianhai
>> to take over the maintenance responsibilities, and recommend
>> Huacai, Mingcong and Ruoyao to help to review.
>>
>> And We'll continue to maintain it for current supported chips
>> and drive future updates according to chip support plan.
>>
>> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
> Congratulations and thank you for inviting me as a reviewer, but
> please re-submit the patch on top of upstream repo.
> 
> Huacai
> 
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 837db4f7bcca..b4d7c4089e95 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8626,9 +8626,13 @@ F:       drivers/gpu/drm/lima/
>>   F:     include/uapi/drm/lima_drm.h
>>
>>   DRM DRIVERS FOR LOONGSON
>> -M:     Sui Jingfeng <suijingfeng@loongson.cn>
>> +M:     Jianmin Lv <lvjianmin@loongson.cn>
>> +M:     Qianhai Wu <wuqianhai@loongson.cn>
>> +R:     Huacai Chen <chenhuacai@kernel.org>
>> +R:     Mingcong Bai <jeffbai@aosc.io>
>> +R:     Xi Ruoyao <xry111@xry111.site>
>>   L:     dri-devel@lists.freedesktop.org
>> -S:     Supported
>> +S:     Maintained
>>   T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:     drivers/gpu/drm/loongson/
>>
>> --
>> 2.31.1
>>

