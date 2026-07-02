Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A91BC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1F510F1E6;
	Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xhjs+j3L";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0988210E3DB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 00:05:11 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8398925e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782950710; x=1783555510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnNqoGul2fI1Hsw0bLrxAsFJTLtPg4A4vHqpqXU9hkk=;
 b=Xhjs+j3LvODV029CDKlIB02IfjSut6UPaoDMniJcL1/EtRIDh8JTWzQ79WqZEFKBps
 otcQCGXkvfqAhdOQnje1ZuT3aDJfjEEh7RdqjaGyVmnW+oLr+ORtKt2tRWn+7DRufRgC
 gZlrDJ8i3dRzLkM33dsLhDNaVm4qU+KyivZdA5xhTYlRWuZkvdrsBVSV1kPj04Waqm+6
 +bOU4uCRXAr7rizuwDT8MP+2YSFUUfR/tRqkee7X8ZmeX3XMlS1si9fCewYdtCUiBDnO
 vxfqx4/ZkomEoLAG0oz8Ig5jDa1ZChE9hhEj++wVHSzNL9ZxQf7aibB7A2We97yVbCJn
 az8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782950710; x=1783555510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnNqoGul2fI1Hsw0bLrxAsFJTLtPg4A4vHqpqXU9hkk=;
 b=Ty80PkcpUk1FR+YlVKyE0SBIyikBidkXiSqle9L9ByYpM5CqB01DnhiQYuSQK2+Qmu
 3++XinWR64S+9fL+rdWibqJZmK5GAEwg9uU49hnUY/wsq0MB2Q+6S/XNFxu75/4/xau3
 46NtFzMZM9xnmsT9MrhWnXKaq+jX04gfD3srj4aJT8Ypq0sFN3xTl16m77HUiWZocQuh
 Gl9phtVXh0m2Kh2tf57dq4O0gIFOVKFO5GNlvkUNEFh7rJjJUThqMtFKGidfNHuOrsEu
 fnV/naX11paEJCI2GkNJHt1Ure3adIwSxKC1MqdEAWNM2qSX04B/MzZrrKbkbn2BsTqF
 xUmg==
X-Gm-Message-State: AOJu0YxS2m6ykeGlwQHMVcQN08INQiCpSMJsQPulU+crNpgEtOIBN5EF
 h0ypWCoYqGduvZrQJRCZPmHKFjdRnhAVZMFwx37dE6WelQfgz+FbWJnEUtMQynBjbVM=
X-Gm-Gg: AfdE7cltxieC2xbBvwsxPFR55fkupoRfH2PtbUH1n1E9NvXbhUtVyq646kvrPRiYweE
 S8x3Ajrr919OwnW7go7PWRIt5A+6CcaJ9i/yGTF1h5M1ajbjJky14rAyK4oFyJd2IgKgDxyz6EU
 nNeLAS+swDrlpQX2g08tDK/cJVFYj/D+H6r0TGMASB56RmIehtW5+O4YP281ijQVTqDv7qiYfwf
 IA8rQdaE2anA4j8VE3Pl4gM9HbgLlop4Eb5px17Lzkk1NwEBFFcB9KUoi1CsWEyKKUCwkrOTvTH
 X08eXdpkyH9C6J/9Qn5cN04OUN4QeybH50FK/s+Hjuv+ULiPUBtf6TxG5GJfZR7n58oOqBldUBv
 fp7SQpLFj6+4efw7P9dosQW31VsALDwB3YtDlFb1IhGDZWS7ru6j+KWheImXcPWORWX0zPShSqG
 qv/9z3npuZSnwlD4X51HeTH6rgtHH1u98DeX02gNTcFbNxMsa758m1jln1/5/RWwvC9sd6wmjoj
 yqldq2WNoAv+1Sj1ktPPDllN2ZpjiFa5F9UZqT5
X-Received: by 2002:a05:600c:35d0:b0:493:c3cb:409e with SMTP id
 5b1f17b1804b1-493c3cb42d9mr47575555e9.15.1782950709759; 
 Wed, 01 Jul 2026 17:05:09 -0700 (PDT)
Received: from [192.168.0.173]
 (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c8ccsm4004253f8f.21.2026.07.01.17.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 17:05:08 -0700 (PDT)
Message-ID: <ed2aab61-acb7-470c-98c9-c55493e43197@gmail.com>
Date: Thu, 2 Jul 2026 01:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fbdev: serialize mode sysfs access with
 lock_fb_info()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
 <20260701234248.236023-4-mlbnkm1@gmail.com>
 <20260701235659.E48441F000E9@smtp.kernel.org>
Content-Language: en-GB
From: Melbin K Mathew <mlbnkm1@gmail.com>
In-Reply-To: <20260701235659.E48441F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

Thanks for the review.

I think these are broader pre-existing fbdev sysfs locking observations 
rather than blockers for this focused series.

This series addresses the mode/modelist lifetime issue and the mode 
sysfs output bounds issue. The modelist lifetime paths touched here are 
now serialized with `lock_fb_info()`, including `store_mode()`, 
`show_mode()`, and `show_modes()`, and the `FB_ACTIVATE_INV_MODE` 
deletion path clears `fb_info->mode` before deleting a matching mode.

For `show_modes()`, `lock_fb_info()` serializes against `store_modes()` 
replacing and freeing `fb_info->modelist`. I do not see fbcon itself 
mutating `fb_info->modelist` in the same way `store_modes()` does, so I 
am not adding `console_lock()` there unless maintainers prefer that 
locking discipline.

The other `fb_info->var` accesses in sysfs store handlers look like a 
separate wider cleanup, which I can look at as a follow-up if 
maintainers prefer.


On 02/07/2026 00:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] show_modes() iterates fb_info->modelist without holding console_lock(), which is required to protect against concurrent list modifications by fbcon.
> - [High] Sysfs store handlers (store_bpp, store_rotate, store_virtual, store_pan, store_blank) bypass lock_fb_info(), risking torn reads and concurrent driver execution.
> --
> 
> commit 52388e2c8c0d0f6bb72f9bedf44a38f798ee348d
> Author: Melbin K Mathew <mlbnkm1@gmail.com>
> 
> fbdev: serialize mode sysfs access with lock_fb_info()
> 
> show_mode(), show_modes(), and store_mode() access fb_info->modelist
> and fb_info->mode without holding lock_fb_info(). This commit adds
> lock_fb_info() in these functions to serialize with store_modes() and
> avoid data races.
> 
> Cc: stable@vger.kernel.org
> 
>> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
>> index af21dc5052df3..d3d60c555bb86 100644
>> --- a/drivers/video/fbdev/core/fbsysfs.c
>> +++ b/drivers/video/fbdev/core/fbsysfs.c
> 
> [ ... ]
> 
>> @@ -137,12 +164,15 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
>>   	const struct fb_videomode *mode;
>>   
>>   	i = 0;
>> +	lock_fb_info(fb_info);
>>   	list_for_each_entry(modelist, &fb_info->modelist, list) {
> 
> [Severity: High]
> This is a pre-existing issue, but show_modes() iterates fb_info->modelist
> without holding console_lock(), which is required to protect against
> concurrent list modifications by fbcon.
> 
> Can concurrent VT switches call fbcon_switch() -> fb_set_var() ->
> fb_add_videomode() and modify fb_info->modelist under console_lock()
> without holding lock_fb_info()? Would an unprivileged user reading
> this sysfs attribute risk a torn pointer or out-of-bounds access
> since console_lock() is missing here?
> 
>>   		mode = &modelist->mode;
>>   		i += mode_string(buf, PAGE_SIZE, i, mode);
>>   		if (i >= PAGE_SIZE - 1)
>>   			break;
>>   	}
>> +	unlock_fb_info(fb_info);
>> +
>>   	return i;
>>   }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but other sysfs store handlers
> (store_bpp, store_rotate, store_virtual, store_pan, store_blank) bypass
> lock_fb_info(), risking torn reads and concurrent driver execution.
> 
> For example, in store_bpp(), store_rotate(), and store_virtual(),
> fb_info->var is read locklessly before activating it. In store_pan()
> and store_blank(), driver functions like fb_pan_display() or
> fb_blank_from_user() are invoked without taking lock_fb_info().
> 
> Does this bypass the mutual exclusion that drivers rely on in the
> equivalent ioctl paths? Could this result in applying corrupt
> configurations to hardware or concurrent execution of non-reentrant
> driver code?
> 

