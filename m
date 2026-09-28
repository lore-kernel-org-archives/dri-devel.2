Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CBC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CFA10E8BA;
	Mon, 28 Sep 2026 12:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Gzdhd50o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD5B10E4F1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790598056; x=1822134056;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=h5hBrZUioMhLyvR/wRBHyoBt0kZaKfr1CiDzwhJ6mf0=;
 b=Gzdhd50oHoXov1T9hmWXr/RfiJt6jecQnbAomPZKIZyu9ruvEv+NMfqT
 jWBMK0ajGEhRNGI7Q2FXz9CCmgPgF45q+275U+oxIzJ1jrX6cTEhNUlAX
 kR54v2f0dVVjL2l42nJAjgAI1thYtSbThmLFJdc2XdaayiqZ8s9k/0d7j
 mNX6xTc2NDlGEWrwe0Wz/298ovBfLYajRM8JdcUwHFbALjxXC7uMqnJwC
 TZtGhewB3lbpxGNsI8thE0vOGrirRZmaWFqZd8yhP8ieUcrA44g3sQ5e0
 N15rJauc7C+mRnAlAALZoYVvdv9S9xQ1u8n+0L8WskvLQioDbe88uM0Hl Q==;
X-CSE-ConnectionGUID: SJGQGb9WR1eLrshg+iLGcA==
X-CSE-MsgGUID: zhk15140Q62JpVVXUT0v0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="95109728"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="95109728"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 05:20:56 -0700
X-CSE-ConnectionGUID: XWI2mfi6RVyPeKM0E82JsQ==
X-CSE-MsgGUID: KxaJK7rBQVaAA11SqfKn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="279765928"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.80])
 ([10.245.244.80])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 05:20:54 -0700
Message-ID: <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
Date: Mon, 28 Sep 2026 13:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Bill Wendling <morbo@google.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260925204423.80661-1-morbo@google.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260925204423.80661-1-morbo@google.com>
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

On 25/09/2026 21:44, Bill Wendling wrote:
> In 'struct gpu_buddy', the 'roots' field points to an array of pointers
> to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> by the 'n_roots' field.
> 
> Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> referencing 'n_roots' to enable compile-time and runtime bounds-checking
> via KASAN and '__builtin_dynamic_object_size'.
> 
> In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots' is
> subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> mm->n_roots)'.
> 
> Since the bounds associated with 'roots' ('n_roots') are fully set prior
> to any array allocation or access and remain invariant, this annotation
> will not cause runtime panics or false-positive bounds checks.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Would it make sense to also do this for *_scoreboard and free_tree, if 
we add a new field n_orders?

> ---
>   include/linux/gpu_buddy.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 2c36124bb696..d7249e500ab6 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -172,7 +172,7 @@ struct gpu_buddy {
>   	 * a power of two, with each root being the largest power-of-two
>   	 * that fits in the remaining space.
>   	 */
> -	struct gpu_buddy_block **roots;
> +	struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
>   	/*
>   	 * Per-order free block scoreboard: free_scoreboard[order] holds the
>   	 * number of blocks of that order currently in the free state.

