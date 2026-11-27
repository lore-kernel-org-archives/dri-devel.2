Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBFIoR2A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CE510E00B;
	Fri, 27 Nov 2026 08:14:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D17A10E00B;
 Fri, 27 Nov 2026 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795767290; x=1827303290;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JbdKHJMvuI3WgzWRgS4+aqFCX+dwqD0mKKl/apKbPv0=;
 b=kBFIoR2AHfM89773j+RFuPv2+9DgS3xsJPgj7SLVVOoQeiQOo5ajP0KT
 Vr3bbi4vQiW5rr9P7dMMHnhpa5K1PhH/7UFyVVTz/+zVh+giRbOZ7GdRV
 lUapHOARj6rFxXcywfYSrnXritydwhHL8Rl3sFp/VIlyWMEhox4Y9YmP0
 9HgMRIfPYPZjk43HIcI3wGuMUFeVwiPrf4S0s2T4vmWqb5c18GFeAxXIl
 hveVyLG30BUCRcdSXYUk58xoAZy3UQd6TwD8qMsHFAUQmPfZOOouVjWXX
 KB9zOpOcuSEsIXunGHxZ6q06Q8W6vfY7kKplZeSXmOj1qUPqxZzMoTlPK w==;
X-CSE-ConnectionGUID: 6RvUX0XiRFC4EAAYRa3kZA==
X-CSE-MsgGUID: uGv6GMzHQ9uqhSRlpFPvZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4583402"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4583402"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 00:14:38 -0800
X-CSE-ConnectionGUID: nDInN+M/TPqFlz+vU6S6Ug==
X-CSE-MsgGUID: VSrlwOSqTGWQWJlhD8bH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12772649"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.245.87])
 ([10.245.245.87])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 00:14:37 -0800
Message-ID: <d22a6663-4b0a-49a2-aa54-4008c64f4ce0@intel.com>
Date: Fri, 27 Nov 2026 08:14:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/ttm/tests: s/recrusive/recursive/
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>
References: <20261126164516.102435-1-michal.grzelak@linux.intel.com>
 <20261126164516.102435-2-michal.grzelak@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261126164516.102435-2-michal.grzelak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/11/2026 16:45, Michał Grzelak wrote:
> Remove typo from KUnit test case.
> 
> Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index e22a1335f1664..88902e15cb273 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -1117,7 +1117,7 @@ static void ttm_bo_validate_evict_gutting(struct kunit *test)
>   	ttm_mock_manager_fini(priv->ttm_dev, mem_type);
>   }
>   
> -static void ttm_bo_validate_recrusive_evict(struct kunit *test)
> +static void ttm_bo_validate_recursive_evict(struct kunit *test)
>   {
>   	u32 mem_type = TTM_PL_TT, mem_type_evict = TTM_PL_MOCK2;
>   	struct ttm_operation_ctx ctx_init = { }, ctx_val  = { };
> @@ -1200,7 +1200,7 @@ static struct kunit_case ttm_bo_validate_test_cases[] = {
>   	KUNIT_CASE(ttm_bo_validate_deleted_evict),
>   	KUNIT_CASE(ttm_bo_validate_busy_domain_evict),
>   	KUNIT_CASE(ttm_bo_validate_evict_gutting),
> -	KUNIT_CASE(ttm_bo_validate_recrusive_evict),
> +	KUNIT_CASE(ttm_bo_validate_recursive_evict),
>   	{}
>   };
>   

