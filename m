Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3CEF34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3B010E48E;
	Mon, 13 Apr 2026 14:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BMrSQ46A";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A44810E48E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:00:47 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8a4b8c3a30bso49961136d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776088846; x=1776693646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=17vzIRu9LWKDoVYHul0BINcHWZhdKsnTwSxfRfb16Bs=;
 b=BMrSQ46AIgy8oWdu7J68/1Jf3anLofsFAUeK2gaoNi9KJaBkVdcaEBsOAz1JxiZk8P
 R1m8XxfAnp2aOsZ5UnqDzemiapcLJgxyslb6sltBqXc+7QrsXSopXDSJr4VustxgZc81
 WqPB+G5nGKuiJjw1HGs5gb21RY09D4wY7D/RwNZbBC4DlbffRgsbcalrAPd6bRAo67pZ
 RiFX0i5qXNO6CWxx2cffpPUhH5BJgVznwrL4vnOx3Xc3XrCDHGrXT59lzuiogywOMeta
 xjZv6u/tGI2k/5ZV4xdJ6qKKE12DPTJBh3dwHfi6S0c59wvvG/7OTc2Y8iBfY5AmD8dg
 uYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776088846; x=1776693646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17vzIRu9LWKDoVYHul0BINcHWZhdKsnTwSxfRfb16Bs=;
 b=aX0iPH5VmAMeQvqyijSvomT97EZNiaadV25QUzdAhPiLJpqoWNtcG3c37+QaNslVUt
 Ef+Ag5BmeEltSpIpiap9qBfzUnH3W1RXd6lnFSqdEbIaUL3WqHptRzZtivPikNzm2zKv
 TNnR5HH7GwWh6otAPMxXgULV8tz7QXUc9axlFPmE+6FY7Nn6srvajXfWA0boBEXcAQnT
 yxtyq23UEMbJ7iGtkECfqWOvZej+m8S1z50MkoK9awWm4jZ6xstW2QjXZCDsG9hjTAl/
 9UpDLt2t8z2TkHJ7ebGbF7R2KaH/4HptHCKxxrftCiX/AL3SrfCEpHv99WZhc4XwL3wf
 urPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6H2uZKHUHC6MJG61jb/wHZ9UtLdMut9W6eUw+J6ObP90KlkpZ450h9HjR7ZeooXP5Vg5Unef0dRY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXoFSrrxCnBikslp+t/3acaHm/3l6nYaUd86eqixWqnjpzhcHp
 c41ovQKD9oLGWGF7tJf5WbmcredxqAVbhQ0SAsSyYvx1Q3aWyXtVGSjK
X-Gm-Gg: AeBDieuJqsRzYpaNl/rewrs5S+rJUMCgNnG/pVymOrPteEONZIwhIAxdHWQGC7aPbMD
 RmR2FCHO+Xh8HkM7GNYOZzAKyLiewAUD9+9UxQIu+8gEWbRJfC8Dffltsqpo988+Ar4ka3aON2y
 3OKUOjHZdDlGFrLOcYQePlcv0vN20BKqmojVsQu/hRlLm+SgDol8TPWkL+k3k8fLz5/cqiPSXzb
 h3O3sjAG+wUHmNq1Mf81Yu5icsThO0GKkbM7lyAA/u80Qtk0cV9XbFICQ9DcGHKWf1aUTHnGuHT
 VMbi4wH7zjKK3qhx+wzxkWnxqnQtkZGNfPJFZAMERexJPv8AE9/FfPsIFz4shtC7ngkSGLg9Aj3
 PpxpYNx3aXXDGs9xtXG7MQkN3ZVYGqeneqiri6HrECbhFsWXI/NTcJ6TGzaoxgKbR1XKtdfbkJF
 +baImf5cSkvLjzOBQZk9F6cAwtnUxO0GW0AQJuPqV7OVG5FVs16Ba5nxI=
X-Received: by 2002:a05:6214:8004:b0:89c:5e33:2cc5 with SMTP id
 6a1803df08f44-8ac860f3799mr187437446d6.20.1776088845326; 
 Mon, 13 Apr 2026 07:00:45 -0700 (PDT)
Received: from [10.254.121.178] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac849db735sm117139006d6.2.2026.04.13.07.00.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 07:00:44 -0700 (PDT)
Message-ID: <6bf9b402-fa60-4ed9-9c36-7a1c783d0000@gmail.com>
Date: Mon, 13 Apr 2026 16:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: fix order of trace and fput
To: Andi Shyti <andi.shyti@kernel.org>
Cc: janusz.krzysztofik@intel.com, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 gaoxiang17@xiaomi.com, sumit.semwal@linaro.org
References: <20260408122437.1364-1-christian.koenig@amd.com>
 <adedTCplYHeJPVKP@zenone.zhora.eu>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <adedTCplYHeJPVKP@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/9/26 14:38, Andi Shyti wrote:
> Hi Christian,
> 
>> @@ -845,9 +845,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
>>  	if (WARN_ON(!dmabuf || !dmabuf->file))
>>  		return;
>>  
>> -	fput(dmabuf->file);
>> -
>>  	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
>> +	fput(dmabuf->file);
> 
> funny, I just found out I sent the exact same patch, just few
> minutes later :-) [*]

I liked your patch better since it has more accurate tags.

Just reviewed and pushed that one to drm-misc-fixes, should land upstream by the end of the week.

Regards,
Christian.

> 
> Andi
> 
>>  }
> 
> [*] https://lore.kernel.org/all/20260408123916.2604101-2-andi.shyti@kernel.org/

