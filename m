Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1199FB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277C410E5D0;
	Mon, 30 Mar 2026 09:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HW+bM5/W";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C678B10E5D0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:52:41 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-66b2f6e983bso4562921a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774864360; x=1775469160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cn7BPueizG0aOaXVcVQhQ6g9SE/PtvAJOzX0fQc+gbI=;
 b=HW+bM5/W/+DEd7jQzYLILlo3fIo0M0O9TNrDLKfJTqmKp1BOzQd3ivaMZ2BuxjzFtT
 stx9SIstRiJpCObB5BgwI5MYQvdKE4z5KV+6WLqtEVNlI4oTKuBRhImfkMAeFYvLyHbD
 z+XzmVxZtj1uImth7A0kClbcusJ7ofcwKvnVKvr7Ym180kt50N06S66ClgJQXVezCrpo
 vI6EX5xuXVGgmnSXFtYDZhyCuVHV/pIcNs0rzZmD6loKEwIDA9Ru859ZltajSxLNpZOG
 RuAEHmMqZUwnhZWA4JHPRyoxAMa1izZchNRypP15ZOWtvZ+Q1kCn6rC/t8mDB3ucAEpo
 rELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864360; x=1775469160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cn7BPueizG0aOaXVcVQhQ6g9SE/PtvAJOzX0fQc+gbI=;
 b=lcEuXzy6yISlGzrneGcRuILqQxabZiYOGdB2NKlWj+nlHQU1R3QqQiPpe97OzS4fxT
 VIF+ul/JzUGNYgvR/Xgw8r8hqhFDEObMxV75GqYPiK6YUr7on5y3Hshs2aXpus2+GMSp
 EXSqiJbdKHaGx0KPzCZhsNxkeWtZgQBrIsW+Q8AA6BGV+ij1FB65QnhGfQEekTgQTauy
 s6BV7gJktS39gc7jV5Yb5eynHo1b26JHZ1TKYiy/4plzi0hrsA9sbF+bGgo2FTy1mbQf
 k05V7oqUaATvF4jFZvyT1weA5GO4Ism9HnBq1iNOOs5V2dm3NrMh3fPNbBIQNRMRMsys
 OyQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNUj11j7X86BmnuJogdc56P92+a2hcQVy05AQ1bIOXdRJZ1I/ZvwLLvbeSfcvJHRIyF6iKkQdlWM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvtZbO3F1nuEdzuk/V75n8j1xeNi+GA6Yp+l2Gz+9yY5pnR/tX
 n2SAn3t4t1SRdfzgPTX0sUPebhSwVdfLjWlybDFglm3O3om8VJWMT6Oj
X-Gm-Gg: ATEYQzyy79w1IiEzbNfpK3P1MWGLq67ejKnXpR9t0TivsFtrNnsyBDqt8hUbPHNCsyI
 zs9oQoHVO74Ylv6BnLRuXOXfXpRkp5BcSMr/ba5JHmjyi5FKgu1oYyOWuV+yAwtlX8qEmyDF1Dw
 fjShFVS9cE1GaDFwRzyM+Ln+5Tzs7UK8Mdtf4aD/3ZqWShBcFbUynyI1MNiUFr4MzPsCGADKYkj
 GvY3VkaCe72MM85eDWSIybi6m9Vi+lsUzh5AK0eBk7n1hI+D+Rtyyn1wxwRBVR8KbmeSCId9fbM
 4edUdOwW86wY0oB8wlt6tv+ok+uHMZqSLEK5iV1ilY4gugZ91kLt1YyiEvMaIqkpXQFA+NblmtT
 j8ulRA1C93lOXwuDek9WK9L6+Icxam+dm5WymPoxho5nh+uJh3e11CAmCRvWopcrvbOOqG1pXc6
 2y7Mtyu927SiQhv8PM3MXz51TaayIJsjnNyhhiybVHvcap
X-Received: by 2002:a05:6402:528f:b0:66c:12ad:d769 with SMTP id
 4fb4d7f45d1cf-66c12add9fbmr216280a12.7.1774864360007; 
 Mon, 30 Mar 2026 02:52:40 -0700 (PDT)
Received: from [192.168.178.84] ([134.19.50.110])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66b75ba970esm2306523a12.19.2026.03.30.02.52.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:52:39 -0700 (PDT)
Message-ID: <45754304-12c4-44b2-965c-fee97f839808@gmail.com>
Date: Mon, 30 Mar 2026 11:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Dereference correct dma_fence in
 dma_fence_chain_find_seqno()
To: Li Ming <ming.li@zohomail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260327-fix_dma_fence_chain_find_seqno-v1-1-60e80bfb43c8@zohomail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260327-fix_dma_fence_chain_find_seqno-v1-1-60e80bfb43c8@zohomail.com>
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

On 3/27/26 15:33, Li Ming wrote:
> dma_fence_chain_find_seqno() uses dma_fence_chain_for_each() to walk a
> given dma_fence_chain. dma_fence_chain_for_each() always holds a
> reference for the current fence during iteration. The reference must
> be dropped after breaking out. Instead of dereferencing the last fence
> as intended, dma_fence_chain_find_seqno() incorrectly dereferences the
> first fence in the chain.

Well once more: Absolutely clear NAK and please search the mailing list for similar changes before you send a patch out.

The existing code is perfectly correct and I can't count how often I had to reject that patch.

I think the functionality is obvious but it looks like we really need to add a comment here.

Regards,
Christian.

> 
> Fixes: 7bf60c52e093 ("dma-buf: add new dma_fence_chain container v7")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/dma-buf/dma-fence-chain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
> index a8a90acf4f34..71fa173aef13 100644
> --- a/drivers/dma-buf/dma-fence-chain.c
> +++ b/drivers/dma-buf/dma-fence-chain.c
> @@ -103,7 +103,7 @@ int dma_fence_chain_find_seqno(struct dma_fence **pfence, uint64_t seqno)
>                     to_dma_fence_chain(*pfence)->prev_seqno < seqno)
>                         break;
>         }
> -       dma_fence_put(&chain->base);
> +       dma_fence_put(*pfence);
> 
>         return 0;
>  }
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260327-fix_dma_fence_chain_find_seqno-7adea64efe01
> 
> Best regards,
> --
> Li Ming <ming.li@zohomail.com>
> 

