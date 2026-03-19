Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8AD1090222
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDB610E96F;
	Thu, 19 Mar 2026 13:16:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0077B10E96F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:16:10 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8Cx58ET97tpta8cAA--.5176S3;
 Thu, 19 Mar 2026 21:16:03 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJAx38IK97tpf6hYAA--.37986S3;
 Thu, 19 Mar 2026 21:15:58 +0800 (CST)
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Qianhai Wu <wuqianhai@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
 <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
 <0f020c50e0ad4d8aa6097a1fac06b36955e3318a.camel@iscas.ac.cn>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <8c04428b-dd00-c3d2-b3b1-56fd94b26b04@loongson.cn>
Date: Thu, 19 Mar 2026 21:08:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0f020c50e0ad4d8aa6097a1fac06b36955e3318a.camel@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38IK97tpf6hYAA--.37986S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw48Gr18uFW5GrWxZFWDAwc_yoW5XFWxpF
 ZrGa4akF9rJrn7ArsIk3W7AFWjy395JrZ8ur4DJ3s3Zr90yr1fKrW8AayUGa1DXrWrGF42
 vwn7t34xua1YyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DU
 UUU
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



On 2026/3/19 下午4:51, Icenowy Zheng wrote:
> 在 2026-03-19四的 08:54 +0100，Thomas Zimmermann写道：
>> Hi
>>
>> Am 18.03.26 um 10:23 schrieb Jianmin Lv:
>>> I and Qianhai are GPU R&D engineers at Loongson, specializing
>>> in kernel driver development. We understand that the current
>>> Loongson GPU driver lacks dedicated maintenance resources
>>> because of some reasons.
>>>
>>> As Loongson GPU driver developers, we have both the capability
>>> and the responsibility to continuously maintain the Loongson
>>> GPU driver, ensuring minimal impact on its users. After internal
>>> discussions, our team has decided to recommend me and Qianhai
>>> to take over the maintenance responsibilities, and recommend
>>> Huacai, Mingcong and Ruoyao to help to review.
>>>
>>> And We'll continue to maintain it for current supported chips
>>> and drive future updates according to chip support plan.
>>
>> Welcome and thanks for helping out.
>>
>> Yesterday, Icenowy Zheng also volunteered to help with the driver. If
>> she's still interested, I think you should both co-maintain the
>> driver.
> 
> I am still interested, especially for MIPS-based Loongson systems. I'm
> okay to act either as a co-maintainer or a reviewer, and let Loongson
> folks to decide it.

Hi，Icenowy

Thanks for willing to join us co-working the driver，and I'll add you as 
reviewer in v3 patch, expecting a pleasant cooperation.

BTW, it will help me to look into and reply your patch if you can CC me, 
thanks.

https://lore.kernel.org/dri-devel/c6013f25-fce0-41ba-a275-96188a6647c1@suse.de/T/#t

> 
>> Icenowy is already active in the maintenance of other DRM drivers and
>> can certainly do good work here as well.
>>
>> Best regards
>> Thomas
>>
>>>
>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 96ea84948d76..4232039b7282 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
>>>    F:	include/uapi/drm/lima_drm.h
>>>    
>>>    DRM DRIVERS FOR LOONGSON
>>> +M:	Jianmin Lv <lvjianmin@loongson.cn>
>>> +M:	Qianhai Wu <wuqianhai@loongson.cn>
>>> +R:	Huacai Chen <chenhuacai@kernel.org>
>>> +R:	Mingcong Bai <jeffbai@aosc.io>
>>> +R:	Xi Ruoyao <xry111@xry111.site>
>>>    L:	dri-devel@lists.freedesktop.org
>>> -S:	Orphan
>>> +S:	Maintained
> 
> By the way, previously when Sui Jingfeng is in charge of this driver,
> the status is "Supported" instead of "Maintained". Does this change
> show any difference on Loongson's attitude towards this driver?
> 
> Thanks,
> Icenowy
> 
>>>    T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>>    F:	drivers/gpu/drm/loongson/
>>>    

