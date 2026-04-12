Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDABF3ED6D
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 04:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861F210E11B;
	Sun, 12 Apr 2026 04:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SB+LKMgH";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA1110E1EF
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 04:39:49 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso4673783eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 21:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775968789; x=1776573589; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kRdR1dc5/UfNuJsTk7iiKeGwmqYxW3GpWumyMvQ9lak=;
 b=SB+LKMgHXGkveG5Q1oEfx5JIj5q6ru45/+0WlJ66mtPjwbR7kUDyZ7R/+nnRnqVV1d
 ZhYtTjz4I3QjX4WCUE59KfcLKh+NRiH1oRw8QK1gONmsT4G8w4VIvIEzQDC4+kByLQkX
 YlX6zioCFWxifvuh9clQGNswBfnhTvFlY6SDMpKhUKvh4ifyYGGhTKWoQgI6W6VI77qY
 bnlOuFEq5SC2ACtmr6qCb3oFgdW2e6L7F37nUQhamZ34F7BHLCPu2WaNVQlV0kfPwG1F
 FmbRhHeQ8pOOXsBsnXTufjslh04mq+52USYkSGvsvJjyNY1+qaIbYHWoCo03hEGGmIt6
 hTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775968789; x=1776573589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRdR1dc5/UfNuJsTk7iiKeGwmqYxW3GpWumyMvQ9lak=;
 b=H2bJuYDZHuCI7pLTuGmZoqyICfsYwOuZiavXkRgGWRhxxJcF9Vm74cQIlIf+6D2rCi
 uBqy4PefWTNBpk9aSbcxmzxBrxtz/WZDXW1089lXfw9w1dUX+AzIWuDplrrE9w7kbrUS
 7qmBtFcqhRWtWbL8M8u+Cjt1idH+X1UjDruSGLyWBTdamRw7YEyhwSN8omo/doxBAHG6
 mIt5iUpVAJkIQSLflhKToI9vGhk5jcFux93oyqvUQOgblezPdkpuGX10CehNSA6P2wRk
 EiCF6wl/I488TBnrQSL2BvnyZcDDcydygVvHuDC7PnXbULHJXiixkJa/16HUU05K3B0n
 RHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/L+jA1e2dwWiNfS7OAGPJ2LKFdZ2CW1/ONEB0r0eY8WXWEknmr1fRMqvxP6tYCqTjQaz3B4YIueE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy959vuQuZO/qLsU2qPrvv47CBNnSg9kIU+jRUKyGL3phpa3AoA
 F3VqIJauvdFPUCN9I6bHpQQLMiZmkds8G9kegkZQP1Z3bLIxhUn4ue6LT9o6RA==
X-Gm-Gg: AeBDiesWz50S7UvxDN7vuJ9xt2X4Hz98qSSLf1Pss42xM5y4SS8n225noWnGmMtkU7U
 lSxXVYife0nLeJd4F6uiotyybkd/BcVdqT8Ov4skNjhL1qOnWifLFTqR9qsRtWsfyPACUPMdOB/
 RG9oRVgtlLi7sTnOpooKkvUPag9yf5oW7kblofGKeCa84D2tFA4Wpmz2aPZgpYnMBMmdtENn8DG
 bQp3YAZzby4ZZw8frb0uiQsO6k16lU5uQbMm6WE2b/AbyBxhTJCn8I4V2cnBpFBviUcfadJmWxC
 Ua2e08H14mLCKZr1lmakFQSTowo1/usMcpG8UTwuZ6+DQMQpAck206bftkkz3wn5boFuXulb4gO
 r0EUhZBhPTeF6gdVUeYA4ot4BJ2QZw1QHAz+EdGa1KZsYq2bMZttvX5FsmqIJc3JE6DHWkE0Xd4
 4y8XEP95hcNV0fLi/KYcZBBrBLMVmfHiMNO2K3
X-Received: by 2002:a05:7022:517:b0:128:dab3:f528 with SMTP id
 a92af1059eb24-12c34e892c2mr5118834c88.8.1775968788704; 
 Sat, 11 Apr 2026 21:39:48 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90::f8b0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde70csm13449412eec.15.2026.04.11.21.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 21:39:48 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:39:45 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zone_device: Do not touch device folio after calling
 ->folio_free()
Message-ID: <adsiEY671D8mFZao@fedora>
References: <20260410230346.4009855-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410230346.4009855-1-matthew.brost@intel.com>
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

On Fri, Apr 10, 2026 at 04:03:46PM -0700, Matthew Brost wrote:
> The contents of a device folio can immediately change after calling
> ->folio_free(), as the folio may be reallocated by a driver with a
> different order. Instead of touching the folio again to extract the
> pgmap, use the local stack variable when calling percpu_ref_put_many().
> 
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

With the cc-stable:

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>

> ---
> Stack trace:
> 
> [  631.875165] [IGT] xe_exec_system_allocator: starting subtest threads-many-new-prefetch
> [  632.282992] Oops: general protection fault, probably for non-canonical address 0x900000000000000: 0000 [#1] SMP NOPTI
> [  632.293469] CPU: 8 UID: 0 PID: 59267 Comm: xe_exec_system_ Not tainted 7.0.0-rc7-xe+ #281 PREEMPT(full)
> [  632.316023] RIP: 0010:free_zone_device_folio+0x149/0x240
> [  632.339782] RSP: 0000:ffffc90023d1fd00 EFLAGS: 00010206
> [  632.344947] RAX: 0900000000000000 RBX: 0000000000000001 RCX: 0000000094472d4d
> [  632.351991] RDX: ffffffff8155c76f RSI: 000000006f2213bf RDI: 000000008e84943a
> [  632.359042] RBP: ffffea0ff4030001 R08: 0000000000000000 R09: 0000000000000001
> [  632.366094] R10: 0000000000000028 R11: 0000000000000000 R12: ffff88811828e400
> [  632.373145] R13: 0000000000000000 R14: 000fffffc0000000 R15: 0000000000100073
> [  632.380194] FS:  00007f2f0fdfe6c0(0000) GS:ffff88890a7e7000(0000) knlGS:0000000000000000
> [  632.388186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  632.393870] CR2: 00007f2f002e90f8 CR3: 0000000106708002 CR4: 0000000000f70ef0
> [  632.400919] PKRU: 55555554
> [  632.403605] Call Trace:
> [  632.406039]  <TASK>
> [  632.408131]  do_swap_page+0x146d/0x18c0
> [  632.411938]  ? __pte_offset_map+0x3e/0x190
> [  632.415994]  __handle_mm_fault+0x6e8/0x8d0
> [  632.420053]  handle_mm_fault+0xbf/0x250
> [  632.423855]  ? lock_mm_and_find_vma+0x41/0x6f0
> [  632.428256]  do_user_addr_fault+0x168/0x690
> [  632.432399]  exc_page_fault+0x74/0x200
> [  632.436117]  asm_exc_page_fault+0x26/0x30
> [  632.440092] RIP: 0033:0x5587554ff70d
> [  632.462142] RSP: 002b:00007f2f0fdfc970 EFLAGS: 00010246
> [  632.467308] RAX: 0000000000003fc0 RBX: 00007f2f082e1fc0 RCX: 00007f2f12b3287d
> [  632.474355] RDX: 0000000000000000 RSI: 00000000c048644a RDI: 0000000000000003
> [  632.481404] RBP: 00007f2f082e1fc0 R08: 00007f2f0fdfc958 R09: 0000000000000066
> [  632.488450] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [  632.495495] R13: 00007f2f082de000 R14: 0000000000c00002 R15: 00007f2f1319e000
> [  632.502547]  </TASK>
> ---
>  mm/memremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ac7be07e3361..053842d45cb1 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -454,7 +454,7 @@ void free_zone_device_folio(struct folio *folio)
>  		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
>  			break;
>  		pgmap->ops->folio_free(folio);
> -		percpu_ref_put_many(&folio->pgmap->ref, nr);
> +		percpu_ref_put_many(&pgmap->ref, nr);
>  		break;
>  
>  	case MEMORY_DEVICE_GENERIC:
> -- 
> 2.34.1
> 
