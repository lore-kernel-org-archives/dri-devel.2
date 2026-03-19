Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DA1090223
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F14410EA0B;
	Thu, 19 Mar 2026 13:09:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2AA2B10EA0B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:09:43 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8AxjsOO9btpWq8cAA--.17791S3;
 Thu, 19 Mar 2026 21:09:34 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJBxLMKG9btp26dYAA--.36534S3;
 Thu, 19 Mar 2026 21:09:31 +0800 (CST)
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Qianhai Wu <wuqianhai@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
 <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <ff093d1f-5f94-bdd9-4bc2-9cb4432c4650@loongson.cn>
Date: Thu, 19 Mar 2026 21:02:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxLMKG9btp26dYAA--.36534S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trW5Kr4fuF1fKF1DWr13KFX_yoW8tF48pF
 s3Ga1akFZ7AFs7ArsIg3W7AFWUJ395JrZ8Grs0qas8ur90yF1rtr4qqayYga1DZrW0gF42
 ywn2y3409Fs8tFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDU
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

Thanks so much for recommending Icenowy to work with us on the driver. I 
learned that Icenowy's professional work in related fields. And Icenowy 
is ok with doing the job from his reply. So I'll submit v3 later, adding 
Icenowy as reviewer.

On 2026/3/19 下午3:54, Thomas Zimmermann wrote:
> (cc: Icenowy)
> 
> Hi
> 
> Am 18.03.26 um 10:23 schrieb Jianmin Lv:
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
> 
> Welcome and thanks for helping out.
> 
> Yesterday, Icenowy Zheng also volunteered to help with the driver. If 
> she's still interested, I think you should both co-maintain the driver. 
> Icenowy is already active in the maintenance of other DRM drivers and 
> can certainly do good work here as well.
> 
> Best regards
> Thomas
> 
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 96ea84948d76..4232039b7282 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8626,8 +8626,13 @@ F:    drivers/gpu/drm/lima/
>>   F:    include/uapi/drm/lima_drm.h
>>   DRM DRIVERS FOR LOONGSON
>> +M:    Jianmin Lv <lvjianmin@loongson.cn>
>> +M:    Qianhai Wu <wuqianhai@loongson.cn>
>> +R:    Huacai Chen <chenhuacai@kernel.org>
>> +R:    Mingcong Bai <jeffbai@aosc.io>
>> +R:    Xi Ruoyao <xry111@xry111.site>
>>   L:    dri-devel@lists.freedesktop.org
>> -S:    Orphan
>> +S:    Maintained
>>   T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:    drivers/gpu/drm/loongson/
> 

