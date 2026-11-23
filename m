Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62396606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SEdzguaJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C019910E7BB;
	Mon, 23 Nov 2026 10:24:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5969D10E7BB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795429470; x=1826965470;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=TqNoA060W2lRmNnqBpL5QXrmHquA1gM//0fflBCC4nc=;
 b=SEdzguaJNKGl231AIq2TsYmpJQR8IzHVVSPQT1I9czbb1m+fbyw+SlPK
 /ch2ZZgAA2m2pTM7Q6GOGNg2BzovQ4NLPYO4BDo/flkLWnsG7aEGgM+oQ
 klPxIQ1E2SZu67OMwCDb+rUwbsi9XqAdZ2a5RO0gg4SV9RScOPYVxkJfU
 zupZUtu/EQ/Dulriz3rE413GGIlSC/WVqm6Ndy6NFFJ2GoDsC46dXuccT
 dxH5GDX6NxViUsAStVY/A2fMsM5ILORwOqDaZcW82bPwQbwUvbYuaBI5j
 5HFzDc+qvLWfItSWEjjPzgLVZlf3PwDTRds81QzvPv81sFqPLmFY3L/Pj g==;
X-CSE-ConnectionGUID: V7s/8kDIQXiOUrTuN2w3gA==
X-CSE-MsgGUID: WL12JQ8iRAWZ+ceqOX6rmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4266612"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4266612"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:24:30 -0800
X-CSE-ConnectionGUID: uZQv6RrqQvatVCkeaSP3Ng==
X-CSE-MsgGUID: bSK2vtM3Qhu0kMYutWNIWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11162801"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.38])
 ([10.217.180.38])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:24:29 -0800
Message-ID: <1e8f647b-c294-447e-82c3-93b3d577b197@linux.intel.com>
Date: Mon, 23 Nov 2026 11:24:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Allocate a scatterlist per userptr dma-buf
 mapping
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20261123085935.623564-1-karol.wachowski@linux.intel.com>
 <sashiko-outbox-228935@kernel.org>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <sashiko-outbox-228935@kernel.org>
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23-Nov-26 10:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] accel/ivpu: invalid commit SHA c0b3fef87069 in Fixes trailer
> --
> 
> commit 4be7b1f71890e3b0656af1c546014270a1bde777
> Author: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
>> accel/ivpu: Allocate a scatterlist per userptr dma-buf mapping
>>
>> The userptr dma-buf DMA maps the same sg_table on every map_dma_buf(),
>> so a second mapping would overwrite the DMA addresses of the first one.
>> It only works today because ivpu is the only importer.
>>
>> Build a new sg_table from the pinned pages on each map instead.
>>
>> Fixes: c0b3fef87069 ("accel/ivpu: Add support for userptr buffer objects")
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> [Severity: Low]
> The commit referenced in the Fixes tag, c0b3fef87069 ("accel/ivpu: Add
> support for userptr buffer objects"), does not exist in mainline git
> history.  In mainline, that commit is 57557964b582 ("accel/ivpu: Add
> support for userptr buffer objects"), so the tag should be:
> 
>    Fixes: 57557964b582 ("accel/ivpu: Add support for userptr buffer objects")
> 

I will send v2 with the fix.

Karol
