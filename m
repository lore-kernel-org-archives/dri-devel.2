Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A6C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D963410E296;
	Mon, 21 Sep 2026 06:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d5Oq2jhz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673DC10E296;
 Mon, 21 Sep 2026 06:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789973663;
 bh=QEh0q3uEMIX1mo/52T36jIlKSddmIRSljaq9S029FCc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=d5Oq2jhzqSavoIa2/RuhNufR2OhSU0XML8V1G9HuyLNosd5/kiNPnlm/As6IpS0sw
 09jkeV3N3i1Xoa09zgttty2D0LpR/t3IOVGFqJvNckEAfTQxnJYJxwGp8VD5SeMZWA
 ZRdhmhuJaPK/hStrCodYFl66GUCrTsfSkwlOEFbMz35KLPI7z5/6niQI+Ha4E7YBAg
 5q9A/1dM3ApASyK3KWJfZJIMBAQJhifrllSJxCFeGRs28Phi/nvltPRIoiPZ+1geDa
 QeYy8DYjgJ5sDT8S2qpC6eP8owag8DDYRkkT06mUPT3Z+8bDWcdKb5bad/4gex1Bcv
 G535tqaamzuHg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A48B017E087F;
 Mon, 21 Sep 2026 08:54:22 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:54:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 steven.price@arm.com, liviu.dudau@arm.com, adrian.larumbe@collabora.com,
 kamil.konieczny@linux.intel.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t v2] tests/panthor: skip sparse VM_BIND tests
 before v1.9
Message-ID: <20260921085419.01a5699c@fedora-21.home>
In-Reply-To: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
References: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 20 Sep 2026 17:59:09 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Sparse VM_BIND support was introduced with Panthor DRM driver version
> 1.9. If a driver isn't advertising support for v1.9, skip the sparse
> VM_BIND subtests.
> 
> Use the advertised driver version rather than probing for EINVAL, since
> EINVAL may also indicate a uAPI regression rather than lack of support for
> sparse VM_BIND.
> 
> Add a shared macro igt_require_panthor_version() to check the version in
> case other Panthor tests would like to use it in the future.
> 
> The Panthor version macro wraps the igt_require_f() macro so that we can
> clear the last errno. The last errno is irrelevant to the version check
> but __igt_skip_check() will still print it like this:
> 
>   Starting subtest: vm_bind_sparse
>   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
>   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
>   Requires Panthor version 1.9 or newer
>   Last errno: 2, No such file or directory
>   Subtest vm_bind_sparse: SKIP (0.000s)
> 
> This makes the log noisier than it already is. So set the errno to 0 to
> suppress that line. Skipping the test will now print:
> 
>   Starting subtest: vm_bind_sparse
>   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
>   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
>   Requires Panthor version 1.9 or newer
>   Subtest vm_bind_sparse: SKIP (0.000s)
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Changes in v2:
> - check for version at each subtest
> - make version check available to all panthor tests
> - use macro to suppress printing the last error
> - Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
> ---
>  lib/igt_panthor.c          | 14 ++++++++++++++
>  lib/igt_panthor.h          | 18 ++++++++++++++++++
>  tests/panthor/panthor_vm.c | 18 ++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/lib/igt_panthor.c b/lib/igt_panthor.c
> index 11d8ec342..0f8c408d5 100644
> --- a/lib/igt_panthor.c
> +++ b/lib/igt_panthor.c
> @@ -385,3 +385,17 @@ void igt_panthor_free_bo(int fd, struct panthor_bo *bo)
>  
>  	gem_close(fd, bo->handle);
>  }
> +
> +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor)

Any reason for this __ prefix? Looks like a legitimate helper to call
if we ever end up with tests that need to do things differently based
on the driver version, and __ prefixes are generally used when you want
to reflect the fact some helpers are not meant to be called directly.

With the __ prefix removed, this is

`Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>`

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
> diff --git a/lib/igt_panthor.h b/lib/igt_panthor.h
> index ba4a9bf1e..626e5d525 100644
> --- a/lib/igt_panthor.h
> +++ b/lib/igt_panthor.h
> @@ -37,6 +37,24 @@ void igt_panthor_group_submit_simple(int fd, uint32_t group_handle,
>  				     uint32_t stream_size, uint32_t syncobj_handle,
>  				     int err);
>  uint64_t igt_panthor_get_first_core(uint64_t cores_present);
> +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor);
> +
> +/**
> + * igt_require_panthor_version:
> + * @fd: device file descriptor
> + * @major: required Panthor major version
> + * @minor: required Panthor minor version
> + *
> + * Require the Panthor version to be at least the requested version.
> + */
> +#define igt_require_panthor_version(fd, major, minor) do { \
> +	/* igt_require_f() reports errno through __igt_skip_check(); */ \
> +	/* clear it since errno is unrelated to the version check. */ \
> +	errno = 0; \
> +	igt_require_f(__igt_panthor_driver_version_at_least(fd, major, minor), \
> +		      "Requires Panthor version %d.%d or newer\n", \
> +		      major, minor); \
> +} while (0)
>  
>  static inline void igt_panthor_vm_bind(int fd, uint32_t vm_id, uint32_t bo_handle,
>  				       uint64_t va, uint64_t size, uint32_t flags, int err)
> diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
> index 9011df25e..bd8f14ecb 100644
> --- a/tests/panthor/panthor_vm.c
> +++ b/tests/panthor/panthor_vm.c
> @@ -293,6 +293,7 @@ int igt_main() {
>  		uint32_t vm_id;
>  		uint64_t map_size = SZ_4K * 4;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -306,6 +307,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -321,6 +323,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -336,6 +339,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -351,6 +355,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -366,6 +371,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -382,6 +388,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -402,6 +409,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -422,6 +430,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -442,6 +451,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -463,6 +473,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -483,6 +494,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -503,6 +515,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -524,6 +537,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -545,6 +559,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -566,6 +581,7 @@ int igt_main() {
>  		uint64_t map_size = SZ_2M * 3;
>  		const int INITIAL_VA = SZ_4M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -585,6 +601,7 @@ int igt_main() {
>  		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
>  		const int INITIAL_VA = SZ_512M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> @@ -599,6 +616,7 @@ int igt_main() {
>  		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
>  		const int INITIAL_VA = SZ_512M;
>  
> +		igt_require_panthor_version(fd, 1, 9);
>  		igt_panthor_vm_create(fd, &vm_id, 0);
>  		igt_assert(vm_id != 0);
>  
> 
> ---
> base-commit: 970700a95acd74bb987287d10147b5f23380519b
> change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
> 
> Best regards,

