Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E847CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4222710E002;
	Tue,  9 Jun 2026 00:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RCzEA1XY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE8E10E002;
 Tue,  9 Jun 2026 00:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780963727; x=1812499727;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=HjNCLKaSFoUeCYJx8BWxkyPNo9GgvwdwHzcyNfqgvYg=;
 b=RCzEA1XYg/8bEj36dDeUbEOu9pE2Hf7rHg3jyus/oZj6ZF4gdI/k11D8
 prlEQ8p+SJuAQsR7bIJROhGTO4xck70nw9yOZFhOQyR1imdn+yVdPVRtM
 1JL6YQZ0Ul2VyzyejVJAo2KQXjXaxhuqPmdWxtGY0LzuPhdWJmwKcChO5
 dcAfUH5pfSK5Zlpjt0HI86PI+DcqxU/FToisQaLRrCWIhkOUhCed0BA6r
 +sPdZa4R3azIAfKbkJwn76gYAosN9ilJQGQcB1oAKdLvtlComE71VCd24
 yRk3dUOaMl1WX6kaLi2QLz6LO7nJeE/NrXNA9IyfMGAGxMg1hJ+SUEYeX g==;
X-CSE-ConnectionGUID: zGYAa2O/Sz2DeithMsi6YA==
X-CSE-MsgGUID: iiyGtY0HT9CVdpWQwaPDFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81899639"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81899639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 17:08:46 -0700
X-CSE-ConnectionGUID: NsxhP8phRVi1/a3xO/1q9w==
X-CSE-MsgGUID: pnERySuGSY+H3GT5PuL8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="241254775"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 17:08:44 -0700
Date: Tue, 9 Jun 2026 02:08:41 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: check individual moved list instead of
 invalidated
In-Reply-To: <bb2adbe0-5962-4b33-a245-02a11c8cf64b@amd.com>
Message-ID: <413a738c-2f24-571a-b3bd-4be2131d2261@intel.com>
References: <20260512162711.51118-4-christian.koenig@amd.com>
 <20260608122316.3131299-1-michal.grzelak@intel.com>
 <20260608122316.3131299-2-michal.grzelak@intel.com>
 <bb2adbe0-5962-4b33-a245-02a11c8cf64b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-669222198-1780963725=:1544314"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-669222198-1780963725=:1544314
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jun 2026, Christian König wrote:
> On 6/8/26 14:23, Michał Grzelak wrote:
>> Checking `invalidated` field causes build to fail since it is absent in
>> struct amdgpu_vm. Replace it with &vm->individual.moved identically
>> as did commit 59720bfd8c6d ("drm/amdgpu: restart the CS if some parts of
>> the VM are still invalidated").
>>
>> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Fixes: 40396ffdf612 ("drm/amdgpu: restart the CS if some parts of the VM are still invalidated")
>> Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
>
> The field is renamed by a different patch so looks like a rebase/merge issue to me, could be that the Fixes tag needs double checking.

My poor understanding is that commit 40396ffdf612 ("drm/amdgpu: restart
the CS if some parts of the VM are still invalidated") got introduced
into drm-tip after amd-drm-fixes-7.1-2026-06-04 got merged into drm-tip
at commit 2aaaf5931b16 ("Merge tag 'amd-drm-fixes-7.1-2026-06-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes") which I
assume caused this build to fail. Meanwhile the commit should be a
backport of commit 59720bfd8c6d ("drm/amdgpu: restart the CS if some
parts of the VM are still invalidated") from amd-drm-next-7.2-2026-06-04
tag.

Thus I marked commit 40396ffdf612 ("drm/amdgpu: restart the CS if some
parts of the VM are still invalidated") in Fixes: tag from drm-tip
perspective, but I'm not sure if the description above applies nor have
clue how to properly tag it :(. Could you give any hints on which commit
should be actually put in Fixes:?

>
> But either way Reviewed-by: Christian König <christian.koenig@amd.com>

Thank you Christian for the review. Assuming Fixes: is corrected, do you
think this could be applied via drm-misc/drm-misc-fixes? Asking since I
don't have commit right to any of drm-* repositories.

BR,
Michał

>
> Thanks,
> Christian.
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 548a4f14a9f8..5d8f5848bc0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1323,7 +1323,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>>  		e->range = NULL;
>>  	}
>>
>> -	if (r || !list_empty(&vm->invalidated)) {
>> +	if (r || !list_empty(&vm->individual.moved)) {
>>  		r = -EAGAIN;
>>  		mutex_unlock(&p->adev->notifier_lock);
>>  		return r;
>
>
--8323329-669222198-1780963725=:1544314--
