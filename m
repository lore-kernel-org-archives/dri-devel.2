Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75A606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KCcQJpnr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9DE10E8FF;
	Tue, 20 Oct 2026 11:17:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC2610E8BD;
 Tue, 20 Oct 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792495056; x=1824031056;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fgKmmC114oVM2L5rtRPnA+9JSsDg5PbLD4MSLzg7Y1s=;
 b=KCcQJpnrkK4+FGh9jk/NnFwR1jLVV3g8brtJfdg8/KuKvgjTfTBSAZ0G
 jSHpHqJvsWzlmSjLE/+v+DgF4+NL9aru7XywxfKX4XNFdpOc4WUD8LHsi
 kEcFVSLSh2tWxUJyoabsgA+ZuP/NXsZEc5ZYV2bEsXykp1E10axl60RfP
 Pe5dc17J6QpiwBY7Q8BbGr4zjmPrsuEbaxtYAzMLQXoy3trdino4imbrj
 XsWxoONvRckFp0O2s/1Os/9G6jGM9EDlkbC3Sn0/PgcZRlK4iaH2yXNPi
 lrwlYNbCgdgxYW9Yq+kM4m6jDKPCp1khgYpM3jhvmVOo3F4xhRPDTZCiS Q==;
X-CSE-ConnectionGUID: xhs3Y6tqQ4mdyPldMBrjXA==
X-CSE-MsgGUID: e3OpuuihQXqlUE0c2iM6Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1068090"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1068090"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 04:17:36 -0700
X-CSE-ConnectionGUID: Ks5F5TPUTKifJ/Aj6zR3Yg==
X-CSE-MsgGUID: CWaC/wjeSNWU4C4R8SsSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4545192"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.166])
 ([10.245.244.166])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 04:17:33 -0700
Message-ID: <281c6c14-2692-40d4-b812-e41c3a2acaf5@intel.com>
Date: Tue, 20 Oct 2026 12:17:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Shashiko <sashiko-bot@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261006110706.1636971-2-matthew.auld@intel.com>
 <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 07:06, Paneer Selvam, Arunpravin wrote:
> AMD General
> 
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Thanks. I assume you will merge this?

> 
> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Matthew Auld
> Sent: Tuesday, October 6, 2026 4:37 PM
> To: intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; Shashiko <sashiko-bot@kernel.org>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; Joel Fernandes <joelagnelf@nvidia.com>; stable@vger.kernel.org
> Subject: [PATCH] gpu/buddy: do not pass caller list to __alloc_contig_try_harder()
> 
> If the caller passes a non-empty blocks list, __alloc_contig_try_harder() unconditionally frees it on failure or during retry.
> 
> Pass the local allocated list instead and only splice it onto the caller's list upon success.
> 
> Assisted-by: LLM
> Reported-by: Shashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d7
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/gpu/buddy.c                | 20 ++++++++++++++------
>   drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
>   2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index 2f2aaadafe35..a86f454fbb40 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
> 
>          if (order > mm->max_order || size > mm->size) {
>                  if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
> -                   !(flags & GPU_BUDDY_RANGE_ALLOCATION))
> -                       return __alloc_contig_try_harder(mm, original_size,
> -                                                        original_min_size,
> -                                                        flags, blocks);
> +                   !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
> +                       err = __alloc_contig_try_harder(mm, original_size,
> +                                                       original_min_size,
> +                                                       flags, &allocated);
> +                       if (err)
> +                               return err;
> +
> +                       list_splice_tail(&allocated, blocks);
> +                       return 0;
> +               }
> 
>                  return -EINVAL;
>          }
> @@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>                                                                  original_size,
>                                                                  original_min_size,
>                                                                  flags,
> -                                                               blocks);
> -                               if (!err)
> +                                                               &allocated);
> +                               if (!err) {
> +                                       list_splice_tail(&allocated, blocks);
>                                          return 0;
> +                               }
>                                  if (err != -ENOSPC)
>                                          return err;
>                                  goto err_free;
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index b75d32ca6ca0..2c6f1da1a6d1 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1235,6 +1235,15 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
>                                                              GPU_BUDDY_CONTIGUOUS_ALLOCATION),
>                                 "buddy_alloc hit an error size=%lu\n", 2 * ps);
> 
> +       /*
> +        * A failed contiguous allocation with a non-empty blocks list
> +        * must NOT corrupt or free pre-existing blocks.
> +        */
> +       KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +                                                      3 * ps, ps, &allocated,
> +                                                      GPU_BUDDY_CONTIGUOUS_ALLOCATION));
> +       KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
> +
>          gpu_buddy_free_list(&mm, &left, 0);
>          KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
>                                                              3 * ps, ps, &allocated,
> --
> 2.55.0

