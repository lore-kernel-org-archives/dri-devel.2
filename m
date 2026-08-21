Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42327C5DF9C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA11310E480;
	Sun, 23 Aug 2026 09:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGvqwr1d";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AAB10E2F7
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:49:02 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so7154815e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787323741; x=1787928541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RySDzNgFwOZt+mpqx8aHwP46Unuo6yoVJSd8AB2W69Q=;
 b=MGvqwr1dUrnU2YfAWRain/LptCn2BaE0ux5bm1H8SLSiSzGTiSeRygkYnU2VIDXkOe
 5uEotn7paoVgqkMy13RtBUaEhfDtjNtYU/leZJMJXasHvF1BRkhNjjzXxWRiLUCx/G29
 vKFkVUXrOogoAbLfy7j54ql1Bd895JikokbrYUBcIGW1/MoTLj9pn/rFmxdx5Oc0PcKK
 /7tNM+eSEk5MUIe0nkaXiL54LNk56TIJ25GPkTEY/u++0s/CNlwdQo0VWxF0lpCRbvux
 P9wzkNqSP2Re0smCLRFA5YwzrjXW9lpDEY+g+FuNvautqlmuJu5UxfDbMndfHqGkKvJO
 7ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787323741; x=1787928541;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RySDzNgFwOZt+mpqx8aHwP46Unuo6yoVJSd8AB2W69Q=;
 b=Yn3xD1bIp4xlEf/xRHjVpsI0cqiQiC2K4DnkZY2qDQ4rRA+PTt34iiuB4xS9tFO3kw
 maAZ8pNPXqOMZZ4V7LUJkWEv9lATzy+JT+xnc0st1P5WXRnUZanLy0mIK4i7NDW5urP0
 DmpzkSB1QlwSVeeERUlC1Gbn6qpjtcsnY9pnDXF4QIHhyVB+eOpfzcfD77fSOoT9QEBF
 5gOQKOnSpNXwYstoKqA3qDc/geFdcvkntnlmCM7wImZuYBGozB+cDthJyb0urOt/ReUk
 ZvnhOYlpl3eeQmIowypvwtXbKgAUasiMIm0qc7uJ5YS7Y66QLADyyRA5QEnMgo6cw+wE
 eanQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5r+cOf0M0Q4aJmi6YgxhECdYdPZE1+utd4EXMI53T9TDO/WDCcv7NVI/M7zmcjQhIflUP1dc+x5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmInrZX/Z0y/CHZz9rmrxZDYNJZwGCowXm4Ejb3xmY3f4kzlok
 2bur4xffqR2k5r98TqI7bBSdr+7s24gyBReCfmEJ8IE4Ibm+78x6USAe
X-Gm-Gg: AR+sD10q9PZWoUMVyl+PwtyNG9dSU84vZneXIpTwXkfklrQbEa4ruq5t0AjSTltXkEr
 HNOpNgCwp+2iBSvQCL3z6Df+K6OE+HsBLmvzr69sdH/DOXdoegD+d4hncGnuua2d2oXWYm3hspl
 pmK8pPOs0mwLwPL2j9fJxpuiXpvtwXeqJx+405Buwkyi5P+WskzHq4Q9pmAMgRWf1eZqwyYwOYj
 /hONJPFsP/RdBUSoseSoCQ0ISU5uAKclQcSz0EC9ceZqAIfoUTcur4ej7Scx+n/srwl7p8ZQzap
 jRkPnSCIbS1yRD7BTekGjVICppg/Gq6o7JpPeAIDr6hEfF4+F3ywDakqEHneDTa0vQir1NTainK
 yGOG8IZ/7be8Nr3WJsu4WFqwUZhvgrGUuOxKRSo94iB4nwyju76W+CBlIj1XPwA31fipm0wVM4e
 RNt1CJP7Cf6dvRzg6v9kvVmIBndZHevmu7g4RAALlBzl3CLGIzBNLVbxGvgr4dvXMyYq9b0fkhJ
 iHWWGSHkBiRMdbcScD8yP0dJw==
X-Received: by 2002:a05:600c:4f87:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-499b830d220mr94399405e9.3.1787323740952; 
 Fri, 21 Aug 2026 07:49:00 -0700 (PDT)
Received: from [192.168.1.10] (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499be3a3e2esm10640175e9.1.2026.08.21.07.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:49:00 -0700 (PDT)
Message-ID: <3b85e6e2-29d0-43ea-abe2-246f1148939a@gmail.com>
Date: Fri, 21 Aug 2026 16:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Memory leak error in qxl unbind
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
References: <20260809165326.164763-1-megia.oscar@gmail.com>
 <2026080941-edge-lurk-2146@gregkh>
Content-Language: en-US, es-ES
From: =?UTF-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
In-Reply-To: <2026080941-edge-lurk-2146@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

On 8/9/26 20:19, Greg KH wrote:
> On Sun, Aug 09, 2026 at 06:53:14PM +0200, Óscar Megía López wrote:
>> I discovered an OOM after run the script below
>> (I updated it and added a sleep to allow enough time for the cache to
>> recover):
>>
>> while [ 1 -eq 1 ]; do\
>>    i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
>>    if (($i%1000==0)); then\
>>      echo i=$i; free;\
>>      grep nr_free_pages /proc/vmstat;\
>>      grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>>      sync; echo 3 > /proc/sys/vm/drop_caches;\
>>      echo 1 > /proc/sys/vm/compact_memory;\
>>      sleep 10s;\
>>      free;\
>>      grep nr_free_pages /proc/vmstat;\
>>      grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>>      uptime;\
>>    fi;\
>>    echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
>>   done
>>
>> The OOM isn't just a simple leak; it's a refcount corruption which renders
>> the list_lru fix dead code after the first mid-init failure.
>>
>> Here's the chain:
>>
>> Bug 1: ttm_pool_type_init() does not check return from list_lru_init().
>>
>> Fix: Check the return value from list_lru_init() and propagate the error.
>>
>> Bug 2: ttm_pool_fini() does not destroy list lru with list_lru_destroy().
>>
>> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
>>
>> Bug 3: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
>> and does not free pool if returns error.
>>
>> Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
>> pool types and shrinker if non-zero and return error.
>>
>> Bug 4: ttm_pool_mgr_fini() does not destroy the list_lru.
>>
>> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
>>
>> Fixed check for an empty shrinker_list.
> Why is this not 4 different patches as part of a series?
>
>> This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
>> qxl_irq_handler on PCI"), link [1] below.
> That's not going to age well in a changelog text :(
I'm a newbie. What's the best way to add a patch it depends on?
>
> thanks,
>
> greg k-h
