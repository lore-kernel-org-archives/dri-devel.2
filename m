Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F372BCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6A110F3AB;
	Fri, 12 Jun 2026 09:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RLEq+htg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E351810F3AB
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:23:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97611402D3;
 Fri, 12 Jun 2026 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD6B1F00A3A;
 Fri, 12 Jun 2026 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256194;
 bh=P+zbAqDEVjmROPPW19dJI3prwX8o8M+iqHumN9svYcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RLEq+htgm3S5r91qz1VobELN7sq8R16PDiKxb6j5gyMu23YRQX6EuaOGOHNAav6d5
 MBKR6m3Mo1FB4JZxIXv9EI60Rit4O6zB5JlsF7SsF1tYR1/Ecb6lRboxGd2n2/PheJ
 ay/KsGRf9gvfnZaAePyHzn65dTreDmGy5DUA9xqsRA2EW+4IZVMDuIS/Bz19/qpaec
 c/feu3ybij8j/lJlb1HavA9gy9xSFPlT0V1UMD3texb7fnY6ZjbZNY/ahEhde4TbEv
 j5cnkVtJOe+uBQiEL1mkyvL3Mx/UF+q+hCZUpGcPJpCVJ8uIWmG7afXarY9kJdl/GZ
 Z5h6LUwcjchiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/18] drm/amdgpu: implement SVM attribute tree and
 helper functions
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-5-ray.huang@amd.com>
References: <20260612090928.29682-5-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:23:13 +0000
Message-Id: <20260612092314.5DD6B1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memcg accounting for user-controllable SVM attribute range=
s allows container memory limits bypass.
--

commit f35c005d13717cede67aa4978b72564791769d8e
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: implement SVM attribute tree and helper functions

This commit implements the foundation for the amdgpu SVM attribute tree,
including interval tree operations and slab cache management for the
attribute ranges.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_svm_attr.c
> new file mode 100644
> index 0000000000000..ba09aa3c3fe4d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c

[ ... ]

> +int amdgpu_svm_attr_cache_init(void)
> +{
> +	amdgpu_svm_attr_range_cache =3D AMDGPU_SVM_KMEM_CACHE_CREATE(
> +				"amdgpu_svm_attr_range_cache", struct amdgpu_svm_attr_range);

[Severity: High]
AMDGPU_SVM_KMEM_CACHE_CREATE passes 0 for flags, which omits SLAB_ACCOUNT
during the creation of this cache.

> +	if (!amdgpu_svm_attr_range_cache)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

[ ... ]

> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
> +			   unsigned long last_page,
> +			   const struct amdgpu_svm_attrs *attrs)
> +{
> +	struct amdgpu_svm_attr_range *range;
> +
> +	range =3D kmem_cache_zalloc(amdgpu_svm_attr_range_cache, GFP_KERNEL);

[Severity: High]
Does this code allow a container to bypass memory cgroup limits?

Since the cache is created without SLAB_ACCOUNT, and the allocation here
uses GFP_KERNEL without __GFP_ACCOUNT, these amdgpu_svm_attr_range objects
are not charged to the caller's memcg.

If userspace fragments the SVM attribute tree on a per-page basis by
applying alternating attributes across a large virtual memory area, could
this exhaust host kernel memory by forcing the allocation of millions of
unaccounted range structures?

> +	if (!range)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&range->list);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D4
