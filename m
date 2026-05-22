Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468BBCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FFE10F535;
	Fri, 22 May 2026 10:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZKIrXamV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303A010F535;
 Fri, 22 May 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779444624; x=1810980624;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=A/nKx8le5WpP/UPsYHWE/Lqdy1vGRP72HEZXlvPUNJE=;
 b=ZKIrXamVBt0x7Xa/oRa3a6H9iTEEkyqe20Bx7/F3xDoWxutt5RwAW+sR
 R7r5M0iTFGCg9YpkjhdWjUh9YBOTNfviivrsTQwHypqrh06OUsVJFwZJF
 jShrDsKULAiHio5msN3JMGc+y5e4EdcT/O36RnXiQa2laZvfAB/06/5mL
 Zv7LENkseZlxmdYeSVvbPL1fg3Un39bifn1lOCTlD3sEsZNMiCqf+UWWs
 URrPx1owoipiMCMhWiCEzvJUKR5OeUybPeTRbcXvDY4nnIndH9JOqz93P
 rmPKU1tOIAbYY3e4eU3s+iqsfI1giToqPGOWl9jkeT2OVTsXGOraH7Zmq A==;
X-CSE-ConnectionGUID: 9yvkkgZ8QbOK3PjGNCWdTg==
X-CSE-MsgGUID: IUxMz02DQVSJJeICyiIISQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80494140"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80494140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 03:10:23 -0700
X-CSE-ConnectionGUID: OWtePTOCSsK7Od4F13P5aw==
X-CSE-MsgGUID: +Txj4uR9RJGE54VsG68aBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="244919803"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.22])
 ([10.245.245.22])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 03:10:21 -0700
Message-ID: <bf22b4d7-c86e-407f-8bf4-19a6f9d7fa1e@intel.com>
Date: Fri, 22 May 2026 11:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] gpu/buddy: Remove redundant condition in
 alloc_from_freetree() error path
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Arunpravin.PaneerSelvam@amd.com
References: <20260522092600.32818-1-francois.dugast@intel.com>
 <20260522092600.32818-3-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260522092600.32818-3-francois.dugast@intel.com>
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

On 22/05/2026 10:25, Francois Dugast wrote:
> The err_undo label in alloc_from_freetree() is only reachable via a
> goto from inside the `while (tmp != order)` loop, which means tmp is
> guaranteed to differ from order at that point. The surrounding
> `if (tmp != order)` guard was therefore always true and can be dropped
> without any behavioral change.
> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/buddy.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dac2027bb64a..9f6696f47f89 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -849,10 +849,8 @@ alloc_from_freetree(struct gpu_buddy *mm,
>   	return block;
>   
>   err_undo:
> -	if (tmp != order) {
> -		rbtree_remove(mm, block);
> -		__gpu_buddy_free(mm, block, false);
> -	}
> +	rbtree_remove(mm, block);
> +	__gpu_buddy_free(mm, block, false);
>   	return ERR_PTR(err);
>   }
>   

