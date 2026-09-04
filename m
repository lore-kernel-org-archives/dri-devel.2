Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51DBC79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5012D10F8B7;
	Fri,  4 Sep 2026 07:19:50 +0000 (UTC)
X-Greylist: delayed 526 seconds by postgrey-1.36 at gabe;
 Fri, 04 Sep 2026 01:57:43 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE50610E1D8
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 01:57:43 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8DxUNGEI5pqtX8IAA--.24519S3;
 Fri, 04 Sep 2026 09:48:52 +0800 (CST)
Received: from [10.20.42.172] (unknown [10.20.42.172])
 by front1 (Coremail) with SMTP id qMiowJDxxMyDI5pq26AaAA--.28969S2;
 Fri, 04 Sep 2026 09:48:51 +0800 (CST)
Message-ID: <b935c544-3def-4f56-a503-3226751e20d4@loongson.cn>
Date: Fri, 4 Sep 2026 09:47:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] drm/loongson: Move hardware reset to CRTC
 creation
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
 <a09ac5c8-8f78-4714-bf3c-1dbc6093761f@suse.de>
Content-Language: en-US
From: wuqianhai <wuqianhai@loongson.cn>
In-Reply-To: <a09ac5c8-8f78-4714-bf3c-1dbc6093761f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMyDI5pq26AaAA--.28969S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyrZFW5Cw47XrWfGF47WrX_yoWrGr4xpF
 s7AryUKrW5Zrn5G3yDJF4UCa45Ga15tasrJr18Ja4Y9rWktrn0qF48ZrZF9a1UXrWxGry7
 trnrtrnxZF129abCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
 0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
 14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
 JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

Looks good.

Reviewed-by: wuqianhai <wuqianhai@loongson.cn>

在 2026/9/2 15:10, Thomas Zimmermann 写道:
> 
> 
> Am 31.08.26 um 17:34 schrieb Maxime Ripard:
>> The loongson crtc reset hook performs both atomic state initialization
>> using __drm_atomic_helper_crtc_reset() and hardware-level register
>> writes to reset the CRTC.
>>
>> The hardware reset is not related to atomic state initialization, and
>> the reset hook is being converted to atomic_create_state which only
>> deals with state allocation. Move the hardware reset to the CRTC
>> creation path instead.
>>
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Looks good now.
> 
>> ---
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>> Cc: Jianmin Lv <lvjianmin@loongson.cn>
>> Cc: Mingcong Bai <jeffbai@aosc.io>
>> Cc: Qianhai Wu <wuqianhai@loongson.cn>
>> Cc: Xi Ruoyao <xry111@xry111.site>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_crtc.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/ 
>> loongson/lsdc_crtc.c
>> index 16b8f36a4071..7cca574e3b6a 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
>> @@ -388,12 +388,10 @@ static const struct lsdc_crtc_hw_ops 
>> ls7a2000_crtc_hw_ops[2] = {
>>       },
>>   };
>>   static void lsdc_crtc_reset(struct drm_crtc *crtc)
>>   {
>> -    struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
>> -    const struct lsdc_crtc_hw_ops *ops = lcrtc->hw_ops;
>>       struct lsdc_crtc_state *priv_crtc_state;
>>       if (crtc->state)
>>           crtc->funcs->atomic_destroy_state(crtc, crtc->state);
>> @@ -401,13 +399,10 @@ static void lsdc_crtc_reset(struct drm_crtc *crtc)
>>       if (!priv_crtc_state)
>>           __drm_atomic_helper_crtc_reset(crtc, NULL);
>>       else
>>           __drm_atomic_helper_crtc_reset(crtc, &priv_crtc_state->base);
>> -
>> -    /* Reset the CRTC hardware, this is required for S3 support */
>> -    ops->reset(lcrtc);
>>   }
>>   static void lsdc_crtc_atomic_destroy_state(struct drm_crtc *crtc,
>>                          struct drm_crtc_state *state)
>>   {
>> @@ -935,18 +930,28 @@ static bool 
>> lsdc_crtc_get_scanout_position(struct drm_crtc *crtc,
>>           *etime = ktime_get();
>>       return true;
>>   }
>> +static void lsdc_crtc_hw_reset(struct drm_crtc *crtc)
>> +{
>> +    struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
>> +
>> +    /* Reset the CRTC hardware, this is required for S3 support */
>> +    if (lcrtc->hw_ops->reset)
>> +        lcrtc->hw_ops->reset(lcrtc);
>> +}
>> +
>>   static const struct drm_crtc_helper_funcs lsdc_crtc_helper_funcs = {
>>       .mode_valid = lsdc_crtc_mode_valid,
>>       .mode_set_nofb = lsdc_crtc_mode_set_nofb,
>>       .atomic_enable = lsdc_crtc_atomic_enable,
>>       .atomic_disable = lsdc_crtc_atomic_disable,
>>       .atomic_check = lsdc_crtc_helper_atomic_check,
>>       .atomic_flush = lsdc_crtc_atomic_flush,
>>       .get_scanout_position = lsdc_crtc_get_scanout_position,
>> +    .hw_reset = lsdc_crtc_hw_reset,
>>   };
>>   int ls7a1000_crtc_init(struct drm_device *ddev,
>>                  struct drm_crtc *crtc,
>>                  struct drm_plane *primary,
>>
> 

