Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F56DCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB05E11271B;
	Fri, 16 Oct 2026 09:54:56 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83779112726
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:54:50 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so3717261f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792144489; x=1792749289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JeX5qu0jqIGuN6Nb/UvF9AVHsIrlUZq1NMBeYBrcscU=;
 b=DJ4YrTrDWA+1IUbHxudptZfaZiI89+QrOzz9seVEf0B7cX8LpKUA2SIuCeCwz9Nn82
 2SzSB5G/vb7CvDUPCu/+f6QZr3SrsiP3RkuA2VS0voHLL+0Q/VWHmyxybcr9XbhkKdK+
 fUQKIWRyt4cq6Z8NR7m5RvzynJNHZW7c6sRNeSQqZgs8JiX/ObWjZlInY5aPb4h5kmwx
 jLvkjRFSLwvpsnjajSlNyo/M1oa89wuT8wSpkFkWptR7eKrd2qrewVGENzKXRjSpF5iA
 HEhF9TIuDimqZXiY03CaMOh1PpuHvFQgxbHbMVYnZ6ceNFGj6BwMhR/PnrCYF0ng5Znr
 iyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144489; x=1792749289;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JeX5qu0jqIGuN6Nb/UvF9AVHsIrlUZq1NMBeYBrcscU=;
 b=vW9q4EBjnRvoAJEeCgOsISQUk7YXd2oMm8rL7MbAKfi8J8KWz+YdwnD0dVP+zlNbRp
 OF0fcFxAsnzdEeQv8EFyF4ICeMgfaCPK6LDqamVmuSHnpJDB9+VcecN4IdTS1MGaQNin
 Jz541Sgf9LCes4fpdN22YafhwOXrdpV6IjOSpgsbVheLpLsQbIZyCCUqlUEZD3D8yAII
 ES+BPp9oqNc8g9M8gxtu8rXb0M6z3QRD/Ue9dIbZ+mDxQynS2x8I0HOdju/1vfCBr5YT
 n+aA3/QfrFbc27bQoTVYlwGuzVwyznnhYezlus5vvXphIeLaGrPEmPFNIpnvGrQnIir5
 XAeg==
X-Gm-Message-State: AFq9FYJVNRkHduMBSAwQEygRABL025qX3XcsxB4PGxrdO7EcJyV2ymEx
 kr5LBMljlMOZZnLk6fIZzgMemVey3FT4/eIfpwsN20Gk/fH5CaKaCatJuYeKkA==
X-Gm-Gg: AYBFou3EFF6ADynuIjQbFBY5+VGlogpiweJPzIZFZvOvB04tUTZLGgF8ZwkVXkPlZur
 4EfobXBAMQW3nK9n8iDiF1k0fv8Janft+wqkpTEFPCFOWet64Sdu7Zrf7bPl+lmFNc9AKHhFbyd
 yQSKSaeh34DyY4tpLOSCCC748FO1AnIMkD2cSGC5zFBtAsDt1r5oIYn3RGQ+RLYeXZGv28/KMzx
 s4y82d8pv34RBvgKMExqNYT2nbpmQ4FdwGgQTyWYwSXgDycablUPRKclq1A4rprb7mryGyryRIM
 qkN5wDSYAGTj4avhR535u2TV1zSXPWFIIKgwY70v/1FYjE2H40HFRV03ABvNO5Rykl9FFRbnQwp
 VTBoic5+hu3ygETdmYFeI2QE3wJ0EP7Xcnd9qJrHw2luz/D+t4CbduK1BeZmBirI81y85V+lF5w
 wTYYd3SupmMaZfHvINigOLrsbNWVguapZgu13eGjwFLCLw0WpmLq3igRhu6ewoSs6VIuLr2L3zr
 VnvgaGOmD0HMOBNLUpdTcTmx4esqLMl9EK0DULxLGU3aI1vPAoG7cztl3LEhAeu5uCGlTnaUZTq
 MdOCVX89MepV5sIwPbgLgv+h7R25L1MnYRpHZ6BObfrd5AUJ
X-Received: by 2002:a05:6000:188a:b0:48b:b1a1:a002 with SMTP id
 ffacd0b85a97d-48dbacf561dmr47371303f8f.24.1792144488776; 
 Fri, 16 Oct 2026 02:54:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd409989sm4328469f8f.0.2026.10.16.02.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 02:54:48 -0700 (PDT)
Message-ID: <54387709-f72d-4e4e-aafc-8ebc61a62b52@gmail.com>
Date: Fri, 16 Oct 2026 10:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf-io: document dma_buf_io_init_map
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <cover.1792142927.git.asml.silence@gmail.com>
 <79e1cc681326365d2105203b318d8a27ed7e90d7.1792142927.git.asml.silence@gmail.com>
 <sashiko-outbox-174086@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <sashiko-outbox-174086@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/16/26 10:41, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dma-buf: incorrect return value documentation in dma_buf_io_init_map() kerneldoc
> --
> 
> commit b6debb4c02ab1cee94fc3f78293f8425b78664d4
> Author: Pavel Begunkov <asml.silence@gmail.com>
> 
> dma-buf-io: document dma_buf_io_init_map
> 
> This commit adds kerneldoc documentation for the dma_buf_io_init_map()
> function.
> 
>> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
>> index e432194a5dfc0..f724936e223b1 100644
>> --- a/drivers/dma-buf/dma-buf-io.c
>> +++ b/drivers/dma-buf/dma-buf-io.c
>> @@ -43,6 +43,18 @@ static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
>>   	dma_buf_io_map_release(map);
>>   }
>>   
>> +/**
>> + * dma_buf_io_init_map - Initialise the map.
>> + * @ctx:	[in]	dma-buf I/O context the map is created for
>> + * @map:	[in]	dma-buf I/O map
>> + * @sgt:	[in]	the backing scatter-gather table
>> + *
>> + * Importer's helper that initialises @map for the provided I/O context
>> + * and scatter-gather table. The importer should call it once for each map
>> + * on creation.
>> + *
>> + * Returns a map on success, or a negative errno code otherwise.
> 
> [Severity: Low]
> This isn't a bug, but the kerneldoc states this function returns a map,
> while the actual implementation returns an int (0 on success) and modifies
> the map argument in place.

Slipped through indeed.

> Could this be updated to accurately reflect the return value and use the
> standard "Return:" tag format expected by automated kerneldoc tools?
> 
>> + */
>>   int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>>   			struct sg_table *sgt)
>>   {
> 

-- 
Pavel Begunkov

