Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD5B1088E66
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB6B10E7EB;
	Thu, 19 Mar 2026 02:06:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id A4F5310E7E9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:06:00 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8DxNMEHWrtpooocAA--.35157S3;
 Thu, 19 Mar 2026 10:05:59 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJBxLMIEWrtpDT1YAA--.35964S3;
 Thu, 19 Mar 2026 10:05:58 +0800 (CST)
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Huacai Chen <chenhuacai@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Xuefeng Li <lixuefeng@loongson.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
 <CAAhV-H5hcnGAE2xYU-eKuWWCyJkW5mfn_wyS49_MTpz5K+8zEw@mail.gmail.com>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <16f3d7c5-d87c-e415-5efe-975d417e14d1@loongson.cn>
Date: Thu, 19 Mar 2026 09:58:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5hcnGAE2xYU-eKuWWCyJkW5mfn_wyS49_MTpz5K+8zEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxLMIEWrtpDT1YAA--.35964S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw45XFy7Cr1DGrWfCry8Zwc_yoW8Cw4rpF
 s3G3WakFnrtr4fAwsI93W7ZFWjq3yrJrZxWrs8t3sxu3s0yr15tr4jya1Y9a1DXFy8KF4I
 ywn7AFWIkan8JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
 AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
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



On 2026/3/18 下午5:42, Huacai Chen wrote:
> Thanks for the invitation and will try my best to help, too.
> 
> BTW, please spend some time to review this patch:
> https://lore.kernel.org/dri-devel/c6013f25-fce0-41ba-a275-96188a6647c1@suse.de/T/#t
> 
Ok, I'll look into it as soon as possible.
thanks.

> On Wed, Mar 18, 2026 at 5:31 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
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
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@kernel.org>
> 
> 
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 96ea84948d76..4232039b7282 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8626,8 +8626,13 @@ F:       drivers/gpu/drm/lima/
>>   F:     include/uapi/drm/lima_drm.h
>>
>>   DRM DRIVERS FOR LOONGSON
>> +M:     Jianmin Lv <lvjianmin@loongson.cn>
>> +M:     Qianhai Wu <wuqianhai@loongson.cn>
>> +R:     Huacai Chen <chenhuacai@kernel.org>
>> +R:     Mingcong Bai <jeffbai@aosc.io>
>> +R:     Xi Ruoyao <xry111@xry111.site>
>>   L:     dri-devel@lists.freedesktop.org
>> -S:     Orphan
>> +S:     Maintained
>>   T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:     drivers/gpu/drm/loongson/
>>
>> --
>> 2.20.1
>>

