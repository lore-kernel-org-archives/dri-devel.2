Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359A3CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE6510E999;
	Fri, 12 Jun 2026 09:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BlcWJkn4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A6910E999
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:23:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E21D660052;
 Fri, 12 Jun 2026 09:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E99B1F000E9;
 Fri, 12 Jun 2026 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256188;
 bh=UZFcOIrMM2XkaCEtWkrlDnPijr29gtuwGAt5pLCcpsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BlcWJkn4TUrx9oqvSiNSTdmvA0F9RaC5R4iHoYrtzlplyG/5ObTjbKKt+zzeMLkhq
 RBylxE94Tb6unAYiK+pPO0woiDm3lXKX13tlIdXXlITWYCBC57oiGnKUgi5SELg+Xs
 GfQ4IfwiRQNgki0t+yN9akVvehiFGUHh11cUVagikghmhlSbJjvE2uSAQ1Boz3roNK
 dal77G7fgeJvFxo5HAQ1LfENWFkh3FJDwKXt+mhhA9LziGP1enWhWl/yGj+rzsmx1q
 gHhF80RFc3bYzWBQQQNFmg1ecAMvpCer1bM/POzpK0hh5TepIT6iDxNPPsPfO/WViS
 udI+wYZ+aBlzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-3-ray.huang@amd.com>
References: <20260612090928.29682-3-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:23:07 +0000
Message-Id: <20260612092308.2E99B1F000E9@smtp.kernel.org>
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
- [High] Missing Memcg Accounting in SVM Caches
--

commit c7235f541841c86e76bfeba1fd000ec628328f01
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: add SVM core header and VM integration

This commit adds the core header file amdgpu_svm.h defining the data
structures, public API, and caching macros for SVM integration. It also adds
an experimental SVM pointer to struct amdgpu_vm.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_svm.h
> new file mode 100644
> index 0000000000000..9884a1f834d67
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
[ ... ]
> +#define AMDGPU_SVM_ERR(fmt, ...) \
> +	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define AMDGPU_SVM_KMEM_CACHE_CREATE(name, type) \
> +	kmem_cache_create((name), sizeof(type), 0, 0, NULL)

[Severity: High]
Does this hardcoded flag value prevent proper memory cgroup accounting?

This macro hardcodes the flags parameter of kmem_cache_create() to 0, which
omits SLAB_ACCOUNT.

If user-controlled structures like the SVM memory range tracking cache
are instantiated using this macro, omitting memory cgroup accounting allows
a containerized process to allocate unbounded amounts of kernel memory with=
out
being charged to its cgroup. Could this bypass container resource limits and
potentially exhaust system kernel memory?

> +
> +#define AMDGPU_SVM_KMEM_CACHE_DESTROY(cache) \
> +	do { \
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D2
