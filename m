Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF5BC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4DD10E469;
	Tue, 22 Sep 2026 08:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kUCZ9Ly3";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A407B10E469
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:29:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97D3C1595
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:29:25 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E64273F632
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790065769; bh=pTVSfmAHkgkC++b7Zn9jFzccEX8Y3zHT9/8yNncMd7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kUCZ9Ly3n+ukvrypt2xHxV9opS9zEqKN0iKz7GltfzAAtduNWT+vutQR4uUlrx5/Z
 lwjvUu/igCb1LS3D9hKbWXxcHRn0rO+P6ND9Vyep0+uN+Zjw+1u42biZdlcPNfQ7iP
 qRZYCUzCnfdQvdIMflVwSiuOB/IQa7+6Ook58fjM=
Date: Tue, 22 Sep 2026 09:29:26 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 adrian.larumbe@collabora.com, kamil.konieczny@linux.intel.com,
 samitolvanen@google.com
Subject: Re: [PATCH i-g-t v3] tests/panthor: skip sparse VM_BIND tests before
 v1.9
Message-ID: <arI8ZszbxqnMetN8@e142607>
References: <20260921-b4-panthor_version_sparse-v3-1-c0af288ca073@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Mon, Sep 21, 2026 at 08:05:37PM -0700, Deborah Brouwer wrote:
> Sparse VM_BIND support was introduced with Panthor DRM driver version
> 1.9. If a driver isn't advertising support for v1.9, skip the sparse
> VM_BIND subtests.
> 
> Use the advertised driver version rather than probing for EINVAL, since
> EINVAL may also indicate a uAPI regression rather than lack of support for
> sparse VM_BIND.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
