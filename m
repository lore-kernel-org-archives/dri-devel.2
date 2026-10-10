Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6EDCA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9179C10E8A7;
	Sat, 10 Oct 2026 11:45:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E262410E213
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 01:35:52 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8AxX9N0lslqdVoUAA--.59203S3;
 Sat, 10 Oct 2026 09:35:48 +0800 (CST)
Received: from [10.20.42.172] (unknown [10.20.42.172])
 by front1 (Coremail) with SMTP id qMiowJAxX89wlslqoq4qAA--.24714S2;
 Sat, 10 Oct 2026 09:35:46 +0800 (CST)
Message-ID: <5857a47f-5101-4bea-9060-d4c72362245d@loongson.cn>
Date: Sat, 10 Oct 2026 09:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Evanshenf <archwse@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
 <79d0e9e21b47551b73413b6938c403a5af5f6bb4.camel@iscas.ac.cn>
Content-Language: en-US
From: wuqianhai <wuqianhai@loongson.cn>
In-Reply-To: <79d0e9e21b47551b73413b6938c403a5af5f6bb4.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX89wlslqoq4qAA--.24714S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw17JFy7Jw18ZF1UGF1kCrX_yoW5WrykpF
 WDKa40kr4kJr4Iy39FgF4rXFWfua1fWFyxKF98Gw109ryYyr1xZrW7Cw4DWr47ZrZ7W342
 vr42kF98tF4vyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
 0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
 14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
 JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU
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
  
  

  
  
  

      The fix is correct. 
  
  

  
  
  

      Thanks, 
  
  

      Qianhai Wu

在 2026/10/9 16:33, Icenowy Zheng 写道:
> (Cc'ing drm-misc maintainers)
> 
> 在 2026-10-03六的 09:00 +0000，Evanshenf写道：
>> An asynchronous cursor update swaps the new framebuffer into the live
>> plane state. However, the driver reads both old_fb and new_fb from
>> the
>> live state before this swap. When an enabled cursor changes buffers,
>> the
>> address-update condition is therefore false and the hardware
>> continues
>> scanning the previous buffer.
>>
>> Read new_fb from the new plane state before swapping the framebuffer
>> references. This updates the hardware address when the framebuffer
>> changes while retaining the existing behavior for cursor movement.
>>
>> Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64
>> legacy
>> cursor updates. Callback counters and read-only register observations
>> confirmed the asynchronous path, the stale address before the change,
>> and the new address afterward. Same-framebuffer movement and cursor
>> disable/re-enable also passed, with the primary framebuffer and mode
>> unchanged.
>>
>> AI assistance was used to investigate the existing report, prepare
>> the
>> fix and test tools, run the build and hardware comparison, and draft
>> this message.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Evanshenf <archwse@gmail.com>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
>> b/drivers/gpu/drm/loongson/lsdc_plane.c
>> index bcc0ffa..7b9c65c 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
>> @@ -230,7 +230,7 @@ static void
>> lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
>>   
>>   	new_state = drm_atomic_get_new_plane_state(state, plane);
>>   
>> -	new_fb = plane->state->fb;
>> +	new_fb = new_state->fb;
> 
> This change looks okay, although I don't know whether the
> atomic_async_update() hook should be implemented at all now.
> 
> ```
> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ```
> 
> However, please wait for further clarification of the function itself
> from drm-misc maintainers.
> 
> Thanks,
> Icenowy
> 
>>   
>>   	plane->state->crtc_x = new_state->crtc_x;
>>   	plane->state->crtc_y = new_state->crtc_y;
>>
>> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

