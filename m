Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C63C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4487D10EC42;
	Tue, 14 Jul 2026 08:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="TOb0j1Sn";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A409410EC42
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:02:58 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so363865f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784016177; x=1784620977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZQs/lndaQfLqx30aI5NP0RL8O4A11HHgmOQfnkQqBC8=;
 b=TOb0j1SnnMhq1NsW8GUSWBsojvFqH1xMDaGACyt63+G2+1/0UjisMiF4GpdWxfJy+D
 9EJCyWlX5PQqlLe+W4b9uQiJHCKQhrUKAEyYQYWCH2/juPG1YGSCJi4sGPx7K07CG/aW
 SMXbyNjxAYEpErRet1TKFKb8+eYxAYmxQFdxGfPd8KrconLfp/d4wkb9l+xl0rHuvicc
 kCcJGOp6uVIzImo7ZQJPteHP+7BqLcneRoa+AXnL1vdHjM/IFvSK6xrN80zf8Ou0lo/o
 Xvyksa8EGIU3uAH2bjVOggQuq6oD4Pxz1GssfZxWqMf3UnTyWgQ5Kz4hGiKudUhx2gp5
 soYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016177; x=1784620977;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQs/lndaQfLqx30aI5NP0RL8O4A11HHgmOQfnkQqBC8=;
 b=IQgTr9HX68ZJXaB0wYDt13Ua1HOAWB0uEJ+XvlLmAZR16Xi/+HEUpxJu7HU+L56ie+
 HrmctkxUhWO4XJQZ67nFLLizLn72RhGA8ejtcfmgicLbmKcrDF6++93YFFtTTzBaX5mI
 S6I9NUNpPSTCJozYfq0c7NV+SH/W10EYJH5yHAmSCKktNUfYZbWVTPot9ax0At8pO9b9
 30gbP7DX3/jXsDl6ysJWiYneN/7gN9OMp1JUdWevW2FlHuTpAi6RKKXZgKsrVQTSAREu
 y9mP9fMjDRf4w9TfQYlKmMmRfPrfj4dK9SkuooGLlJ5ebL+SKtmLjaSQsE6q0mBJag33
 G3lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPSzJlPg/UCXjnmZxWevnz4zuDwjaATHcyF55OZYGDdohE2jHFvGxFtPy6Xf63hvCT5mY3ESw+HFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxGtfPHSW1DDV2eJJyoY95lGywg/vV/qCdQweWqLDSvoOPJiWx
 Xhjv3bkG8gD+KQbnR4kuzfn+344rfEm4NDIOgW7Zs+x+41mcQe20SYsA+TXYqebOED4=
X-Gm-Gg: AfdE7cl///6q/blfQ2YxHbXcYmD9qg/smUrzYqB+5RjOKYll4seFfaVMxrmcNn43dXi
 qnEARcfcLcH3WUs79cg+T3L3XW0UxtGMaFDSw6JRVD+Pb4odqyBRdo+az+Kn9yEeRlIwGyqj7HE
 XpB5U58NzNMYDS8DR0IVBk69BgIk8iCEqHaULi038no4zGFGCaNWU3I5xkvzu0vMd/90T5UlJqZ
 LiHct6fQjEDNQzlP7I/xnK9qE/O/I3hro1wMGLOriq42DVeBZvPaO0TcpMw240SOFyaYZKrF2RM
 mQqpGl6ZhpBnsiVKQhWg5X9J0//ED7/i4uHGUK1gWTx4MjcwyqFOP0RtvBAImJn6jowzpWF1wXp
 YhH1NocaNk2Nyw+xuzE3m4Ih1pyNPQbGxbJ37getnxzmQ3cjeEGay52I0zm2LMfXE4HweRGcRwl
 ZUlixjoLVLerzrUfQq43L8x9hygx85NZR4A1WAQZWEmBp3
X-Received: by 2002:a05:6000:2004:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-47f2dc9bf61mr13935562f8f.22.1784016176473; 
 Tue, 14 Jul 2026 01:02:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c25b2sm6460345f8f.30.2026.07.14.01.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 01:02:56 -0700 (PDT)
Message-ID: <3e109b17-539d-49be-a096-bcd669fed5ae@ursulin.net>
Date: Tue, 14 Jul 2026 09:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260714073903.3646544-1-nichen@iscas.ac.cn>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260714073903.3646544-1-nichen@iscas.ac.cn>
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


On 14/07/2026 08:39, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index ce1d08f112a8..c5cde42333d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -211,7 +211,7 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>   
>   	default:
>   		return -EINVAL;
> -	};
> +	}
>   
>   	switch (args->in.operation) {
>   	case AMDGPU_BO_LIST_OP_CREATE:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

