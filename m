Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B7FC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC75910ED9B;
	Tue, 22 Sep 2026 15:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DvHaPb6g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFE010ED9B;
 Tue, 22 Sep 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790092482; x=1821628482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zzGlKHxcTakFHE6bN0IXmd82PFh7bNEfJjmu/WeXy7M=;
 b=DvHaPb6gzWbECGjYjqexEvf+G/MnXnw0GN7UNoHK1JSoMQ07Hd1NBYTh
 eO/wiqlQNCXJK5bIfShnf1e3QGvkzttF3H2LYGSP6tVf+z0qJeq65gVUb
 nWDnTJBo8oNwfmpa5Btd/AauoYk0W253+cUvdYF9D/fNIUcJYRBLEdpHF
 3fczixc5A2b/ZTEN+nGk+7EDh/4zffifT2nN+qyqedvNXIA2QhPcLHt2y
 W6ZkW8F64IPnpmG1EUOmbCnymZfajTaxzJlb164VLcGA3dJr+IoYiAsDw
 K6Q5AcLyG+2ZqlMRJeC1w1KBuUqowClR9XE1dwUcQy2T0e3BaODUm2XqJ g==;
X-CSE-ConnectionGUID: mz/K9gaKSzWfJ7KwPDs7Vw==
X-CSE-MsgGUID: zwtT+HrBR/Gqb14YBQDSAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="102062525"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="102062525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 08:54:42 -0700
X-CSE-ConnectionGUID: s/p1Mww5TU+nSRw38FTdyA==
X-CSE-MsgGUID: ds5k0qItQOKbAeE8zlCvwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281259670"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 08:54:39 -0700
Date: Tue, 22 Sep 2026 17:54:20 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t v3] tests/panthor: skip sparse VM_BIND tests before
 v1.9
Message-ID: <20260922155420.qguwviol3ugo52vq@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com,
 samitolvanen@google.com
References: <20260921-b4-panthor_version_sparse-v3-1-c0af288ca073@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-b4-panthor_version_sparse-v3-1-c0af288ca073@collabora.com>
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

Hi Deborah,
On 2026-09-21 at 20:05:37 -0700, Deborah Brouwer wrote:
> Sparse VM_BIND support was introduced with Panthor DRM driver version
> 1.9. If a driver isn't advertising support for v1.9, skip the sparse
> VM_BIND subtests.
> 
> Use the advertised driver version rather than probing for EINVAL, since
> EINVAL may also indicate a uAPI regression rather than lack of support for
> sparse VM_BIND.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Applied, thanks!


Regards,
Kamil

> ---
> Changes in v3:
> - change macro to function
> - move the helper functions to tests/panthor
> - add documentation for functions
> - Link to v2: https://lore.kernel.org/r/20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com
> 
> Changes in v2:
> - check for version at each subtest
> - make version check available to all panthor tests
> - use macro to suppress printing the last error
> - Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
> ---
>  tests/panthor/panthor_vm.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
> index 9011df25e..08a4b7f05 100644
> --- a/tests/panthor/panthor_vm.c
> +++ b/tests/panthor/panthor_vm.c
> @@ -7,6 +7,47 @@
>  #include "igt_sizes.h"
>  #include "panthor_drm.h"
>  
> +/**
> + * panthor_driver_version_at_least:
> + * @fd: panthor device file descriptor
> + * @major: required Panthor major version
> + * @minor: required Panthor minor version
> + *
> + * Returns true if the Panthor version is at least the requested version.
> + */
> +static bool
> +panthor_driver_version_at_least(int fd, int major, int minor)
> +{
> +	drmVersionPtr version = drmGetVersion(fd);
> +	bool supported;
> +
> +	igt_assert(version);
> +	supported = version->version_major > major ||
> +		    (version->version_major == major &&
> +		     version->version_minor >= minor);
> +	drmFreeVersion(version);
> +
> +	return supported;
> +}
> +
> +/**
> + * require_panthor_version:
> + * @fd: device file descriptor
> + * @major: required Panthor major version
> + * @minor: required Panthor minor version
> + *
> + * Require the Panthor version to be at least the requested version.
> + */
> +static void
> +require_panthor_version(int fd, int major, int minor)
> +{
> +	if (!panthor_driver_version_at_least(fd, major, minor)) {
> +		/* Clear irrelevant errno to avoid printing it in the skip log. */
> +		errno = 0;
> +		igt_skip("Panthor version %d.%d or newer required\n", major, minor);
> +	}
> +}
> +
>  int igt_main() {
>  	int fd = -1;
>  
> @@ -293,6 +334,7 @@ int igt_main() {
>  		uint32_t vm_id;
>  		uint64_t map_size = SZ_4K * 4;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -306,6 +348,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -321,6 +364,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -336,6 +380,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -351,6 +396,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -366,6 +412,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -382,6 +429,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -402,6 +450,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -422,6 +471,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -442,6 +492,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -463,6 +514,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -483,6 +535,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -503,6 +556,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -524,6 +578,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -545,6 +600,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -566,6 +622,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -585,6 +642,7 @@ int igt_main() {
>  		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
>  		const int INITIAL_VA = SZ_512M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -599,6 +657,7 @@ int igt_main() {
>  		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
>  		const int INITIAL_VA = SZ_512M;
>  
> +		require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> 
> ---
> base-commit: 520aba273f391e31e18b6fe98d71201eb505a683
> change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
> 
> Best regards,
> -- 
> Deborah Brouwer <deborah.brouwer@collabora.com>
> 
