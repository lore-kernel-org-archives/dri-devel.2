Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C16C624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 02:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B57210F08C;
	Thu,  3 Sep 2026 02:49:44 +0000 (UTC)
X-Greylist: delayed 520 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 02:49:41 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id BF27C10F399
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 02:49:41 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8DxUNE73phqYQkIAA--.22985S3;
 Thu, 03 Sep 2026 10:40:59 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJDxDc853phqbfYZAA--.24237S3;
 Thu, 03 Sep 2026 10:40:57 +0800 (CST)
Subject: Re: [PATCH V2] drm/loongson: Create blend mode property for cursor
 plane
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>,
 Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org
References: <20260902132152.3170934-1-chenhuacai@loongson.cn>
 <c321d3ea800e6754cb8a904a87f432d17ab3d21c.camel@iscas.ac.cn>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <436e6744-8649-133d-17a7-e90332027269@loongson.cn>
Date: Thu, 3 Sep 2026 10:27:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c321d3ea800e6754cb8a904a87f432d17ab3d21c.camel@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDc853phqbfYZAA--.24237S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF13Xryxtw4fCF47Zr17CFX_yoWrJw1DpF
 4vyFy0krWYkF4ktryjqwn5Gay3Xw4fG3s2qryfJa9F9r1ayFnFvF10gr9I9rWUJr48Gw1a
 qr17Crn8uF48CFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
 6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUU
 U==
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



On 2026/9/2 下午11:29, Icenowy Zheng wrote:
> 在 2026-09-02三的 21:21 +0800，Huacai Chen写道：
>> After commit 860e748bddcc929 ("drm: ensure blend mode supported if
>> pixel
>> format with alpha exposed") we get warnings at boot:
>>
>> loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
>> format with alpha exposed but blend mode not setup. Please fix.
>> loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
>> format with alpha exposed but blend mode not setup. Please fix.
>>
>> The reason is the cursor plane supports color formats with alpha but
>> the
>> driver doesn't create blend mode property, which triggers the warning
>> in
>> validate_blend_mode_for_alpha_formats().
>>
>> The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
>> a blend mode with "DRM_MODE_BLEND_PIXEL_NONE |
>> DRM_MODE_BLEND_COVERAGE"
>> for cursor planes.
>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_plane.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
>> b/drivers/gpu/drm/loongson/lsdc_plane.c
>> index bea42215796d..969b2aaa4fd0 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_blend.h>
>>   #include <drm/drm_framebuffer.h>
>>   #include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_print.h>
>> @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct drm_device
>> *ddev,
>>   			       struct drm_plane *plane,
>>   			       unsigned int index)
>>   {
>> -	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>>   	int ret;
>> +	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> BIT(DRM_MODE_BLEND_COVERAGE);
>> +	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>>   
>>   	ret = drm_universal_plane_init(ddev, plane, 1 << index,
>>   				       &lsdc_plane_funcs,
>> @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct
>> drm_device *ddev,
>>   
>>   	drm_plane_helper_add(plane,
>> &ls7a1000_cursor_plane_helper_funcs);
>>   
>> -	return 0;
>> +	return drm_plane_create_blend_mode_property(plane,
>> blend_caps);
>>   }
>>   
>>   int ls7a2000_cursor_plane_init(struct drm_device *ddev,
>>   			       struct drm_plane *plane,
>>   			       unsigned int index)
>>   {
>> -	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>>   	int ret;
>> +	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> BIT(DRM_MODE_BLEND_COVERAGE);
> 
> I think code needs to be present for setting up PIXEL_NONE blend mode,
> if it's exposed.
> 
> Personally, from my copy of 龙芯 7A2000 桥片用户手册 V1.0, I can find no
> information of a PIXEL_NONE blend mode -- there's no bits controlling
> the enablement of blending (except for completely disabling the
> cursor), and the format has no option of XRGB8888 instead of ARGB8888.
> 
> Thanks,
> Icenowy
> 
Agree, COVERAGE mode is internally fixed in the chip with no register to
control.
>> +	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>>   
>>   	ret = drm_universal_plane_init(ddev, plane, 1 << index,
>>   				       &lsdc_plane_funcs,
>> @@ -790,5 +793,5 @@ int ls7a2000_cursor_plane_init(struct drm_device
>> *ddev,
>>   
>>   	drm_plane_helper_add(plane,
>> &ls7a2000_cursor_plane_helper_funcs);
>>   
>> -	return 0;
>> +	return drm_plane_create_blend_mode_property(plane,
>> blend_caps);
>>   }

