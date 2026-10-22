Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4660A5BFE
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=glS3jXzv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248EF112645;
	Thu, 22 Oct 2026 13:45:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3D8112656;
 Thu, 22 Oct 2026 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=t6uW6uDKvsP/OAqrFmFfBgrWI1GkSAhYnNlMw0+dLW0=; b=glS3jXzv/FdEekVAOoP0ZVsm2y
 XUsALtnAj2uXYQuw6puYvMANxneyffKvuLrGSo7ud36Ctk6lpfiqD0QKcevAAsLu51oFwq/3rRhQu
 wq/dtmcPF5S6HFcm76G++PrLppRVoZ1T18TOb9lflIM95a0Qw3OMZbGN0p3URlCKqmiY/YikM3MLH
 HTzLC7r/QFJhmlhHUJWjecOKDX2TmTw2uF8WygP2bRY3W4kEU5fy0jDD157zzuxswkxEHQtQmZsIu
 hccheBLjX3qKdZqQxKJ19Uc/tkGoZsaAC5W8JcoLZb3McXDSi9s+N9qijmbRCGl5QB/KoRry9mWbX
 gPVNiRYA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJt6q-006qdh-Gc; Thu, 22 Oct 2026 15:45:32 +0200
Message-ID: <859844d2-2852-4dd5-9bd0-55bb1d67667b@igalia.com>
Date: Thu, 22 Oct 2026 14:45:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 1/9] lib/igt_cgroup: add cgroup v2 and dmem
 controller helpers
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 kernel-dev@igalia.com
References: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
 <20260923-dmem_max-v7-1-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-1-194ea47bbb4d@igalia.com>
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/09/2026 21:44, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> Add igt_cgroup, a library module providing helpers to create and manage
> cgroup v2 sub-cgroups from IGT tests, with support for the dmem
> controller that governs device memory (e.g. GPU VRAM) limits.
> 
> The API covers:
>   - igt_cgroup_new() / igt_cgroup_free(): create and destroy a named
>     sub-cgroup under the unified cgroupv2 hierarchy, enabling the dmem
>     controller automatically.
>   - igt_cgroup_move_current(): move the calling process into a cgroup.
>   - igt_cgroup_dmem_set/get_max/min/low(): write and read dmem.max,
>     dmem.min and dmem.low for a named device memory region.
>   - igt_cgroup_dmem_get_current(): read current per-cgroup device memory
>     usage.
>   - igt_cgroup_dmem_get_system_current(): read system-wide device memory
>     usage from the root cgroup.
>   - igt_cgroup_dmem_get_capacity(): read total region capacity from the
>     root cgroup's dmem.capacity file.
>   - igt_cgroup_dmem_regions() / igt_cgroup_dmem_regions_free(): enumerate
>     all registered device memory regions.
> 
> All public API functions that can fail use igt_assert internally rather
> than returning error codes, following the IGT convention.
> 
> cgroup names embed the subtest name, allowing an exit handler to be used
> to remove them all at the end of the test.

I do not see that subtest name is relevant for the exit handler so 
perhaps just clarify this statement here.

> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   lib/igt.h        |   1 +
>   lib/igt_cgroup.c | 685 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   lib/igt_cgroup.h |  56 +++++
>   lib/meson.build  |   1 +
>   4 files changed, 743 insertions(+)
> 
> diff --git a/lib/igt.h b/lib/igt.h
> index 173ca70bff28..d8e5de7dcd2f 100644
> --- a/lib/igt.h
> +++ b/lib/igt.h
> @@ -27,6 +27,7 @@
>   #include "drmtest.h"
>   #include "i915_3d.h"
>   #include "igt_aux.h"
> +#include "igt_cgroup.h"
>   #include "igt_configfs.h"
>   #include "igt_core.h"
>   #include "igt_debugfs.h"
> diff --git a/lib/igt_cgroup.c b/lib/igt_cgroup.c
> new file mode 100644
> index 000000000000..7ada1e2efed5
> --- /dev/null
> +++ b/lib/igt_cgroup.c
> @@ -0,0 +1,685 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2025 Intel Corporation
> + * Copyright © 2026 Valve Corporation
> + */
> +
> +/**
> + * SECTION:igt_cgroup
> + * @short_description: cgroup v2 helpers for IGT tests
> + * @title: cgroup
> + * @include: igt_cgroup.h
> + *
> + * This library provides helpers for creating and managing cgroup v2
> + * sub-cgroups from IGT tests, including support for the dmem controller
> + * which governs device memory (e.g. GPU VRAM) limits.
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "igt_cgroup.h"
> +#include "igt_core.h"
> +#include "igt_fs.h"
> +
> +#ifndef CGROUP2_SUPER_MAGIC
> +#define CGROUP2_SUPER_MAGIC 0x63677270
> +#endif
> +
> +/**
> + * struct igt_cgroup - Opaque handle to a cgroup v2 sub-cgroup.
> + * @dirfd: File descriptor for the cgroup directory.
> + * @path: Absolute path to the cgroup directory.
> + * @parent_path: Absolute path to the parent cgroup directory.
> + *
> + * Allocated by igt_cgroup_new() and freed by igt_cgroup_free().
> + */
> +struct igt_cgroup {
> +	int dirfd;
> +	char *path;
> +	char *parent_path;
> +};
> +
> +static const char *cgroupv2_mount(void)
> +{
> +	static const char *path;
> +	static const char * const candidates[] = {
> +		"/sys/fs/cgroup",
> +		"/sys/fs/cgroup/unified",
> +		NULL,
> +	};
> +	struct statfs st;
> +	int i;
> +
> +	if (path)
> +		return path;
> +
> +	for (i = 0; candidates[i]; i++) {
> +		if (statfs(candidates[i], &st) == 0 &&
> +		    (unsigned long)st.f_type == CGROUP2_SUPER_MAGIC) {
> +			path = candidates[i];
> +			return path;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Move every PID listed in @cgroup_path/cgroup.procs to
> + * @parent_path/cgroup.procs.  Silently ignores individual failures
> + * (a PID may have exited between reading and writing).
> + */
> +static void drain_procs_to_parent(const char *cgroup_path,
> +				  const char *parent_path)
> +{
> +	char proc_path[PATH_MAX];
> +	char parent_procs[PATH_MAX];
> +	int parent_fd;
> +	FILE *f;
> +	int pid;
> +
> +	snprintf(proc_path, sizeof(proc_path), "%s/cgroup.procs", cgroup_path);
> +	snprintf(parent_procs, sizeof(parent_procs), "%s/cgroup.procs", parent_path);
> +
> +	parent_fd = open(parent_procs, O_WRONLY);
> +	if (parent_fd < 0)
> +		return;

FWIW it not only ignores the individual failures but the "complete" 
failure as well. Lets see later if that matters.

> +
> +	f = fopen(proc_path, "r");
> +	if (f) {
> +		while (fscanf(f, "%d", &pid) == 1) {
> +			char pidbuf[32];
> +			ssize_t len = snprintf(pidbuf, sizeof(pidbuf), "%d", pid);
> +
> +			write(parent_fd, pidbuf, len);
> +		}
> +		fclose(f);
> +	}
> +
> +	close(parent_fd);
> +}
> +
> +/**
> + * igt_cgroup_free() - Destroy a cgroup and release its resources.
> + * @cg: The cgroup to destroy.
> + *
> + * Moves any processes still running inside @cg back to the parent cgroup,
> + * removes the cgroup directory, and frees all associated memory.
> + * After this call @cg must not be used.
> + * Called at exit time by an exit handler installed by igt_cgroup_new.
> + * Should not be called by a subtest, otherwise, might lead to a double
> + * free.
> + */
> +static void igt_cgroup_free(struct igt_cgroup *cg)
> +{
> +	if (!cg)
> +		return;
> +
> +	drain_procs_to_parent(cg->path, cg->parent_path);

Could take cg as the argument but whatever.

> +
> +	close(cg->dirfd);
> +
> +	if (rmdir(cg->path) < 0)
> +		igt_debug("Failed to remove cgroup %s: %m\n", cg->path);
> +
> +	free(cg->path);
> +	free(cg->parent_path);
> +	free(cg);
> +}
> +
> +#define MAX_CGROUPS 32
> +static unsigned int cgroup_cleanup_count;
> +static struct igt_cgroup *cgroup_cleanup[MAX_CGROUPS];
> +
> +static void igt_cgroup_exit_handler(int sig)
> +{
> +	int i;
> +
> +	for (i = 0; i < cgroup_cleanup_count; i++)
> +		igt_cgroup_free(cgroup_cleanup[i]);
> +}
> +
> +static void igt_cgroup_install_exit_handler(struct igt_cgroup *cg)
> +{
> +	igt_assert(cgroup_cleanup_count < MAX_CGROUPS);
> +	cgroup_cleanup[cgroup_cleanup_count++] = cg;
> +	igt_install_exit_handler(igt_cgroup_exit_handler);
> +}
> +
> +/*
> + * Write "+controller" to @cgroup_path/cgroup.subtree_control to enable
> + * the named controller for children of that cgroup.
> + */
> +static int enable_controller(const char *cgroup_path, const char *controller)
> +{
> +	char path[PATH_MAX];
> +	char cmd[64];
> +	ssize_t ret;
> +	int fd;
> +
> +	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
> +	snprintf(cmd, sizeof(cmd), "+%s", controller);
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	ret = write(fd, cmd, strlen(cmd));
> +	close(fd);
> +
> +	return (ret < 0) ? -errno : 0;
> +}
> +
> +/**
> + * igt_cgroup_new() - Create a new cgroup v2 sub-cgroup.
> + * @name: Name for the new cgroup directory.
> + *
> + * Creates a sub-cgroup named @name under the system's unified cgroupv2
> + * hierarchy.  The dmem controller is enabled in the parent's
> + * subtree_control so that igt_cgroup_dmem_set_max() and friends take effect
> + * immediately.
> + *
> + * Return: Pointer to an &struct igt_cgroup on success, %NULL on failure.
> + */
> +struct igt_cgroup *igt_cgroup_new(const char *name)
> +{
> +	struct igt_cgroup *cg;
> +	const char *mount;
> +	int ret;
> +
> +	mount = cgroupv2_mount();
> +	if (!mount) {
> +		igt_debug("cgroup v2 not found\n");
> +		return NULL;
> +	}
> +
> +	cg = calloc(1, sizeof(*cg));
> +	if (!cg)
> +		return NULL;
> +
> +	cg->parent_path = strdup(mount);
> +	if (!cg->parent_path)
> +		goto err_free;
> +
> +	if (asprintf(&cg->path, "%s/%s-%s", mount, igt_subtest_name(), name) < 0) {
> +		cg->path = NULL;
> +		goto err_parent;
> +	}
> +
> +	/*
> +	 * Try to enable the dmem controller in the parent's subtree_control.
> +	 * Ignore EINVAL which the kernel returns when the controller is already
> +	 * listed (i.e. already enabled).
> +	 */
> +	ret = enable_controller(mount, "dmem");
> +	if (ret < 0 && ret != -EINVAL)
> +		igt_debug("Failed to enable dmem controller in %s: %d\n",
> +			  mount, ret);
> +
> +	if (mkdir(cg->path, 0755) < 0 && errno != EEXIST) {
> +		igt_debug("Failed to create cgroup %s: %m\n", cg->path);
> +		goto err_path;
> +	}
> +
> +	cg->dirfd = open(cg->path, O_RDONLY | O_DIRECTORY);
> +	if (cg->dirfd < 0) {
> +		igt_debug("Failed to open cgroup dir %s: %m\n", cg->path);
> +		goto err_rmdir;
> +	}
> +
> +	igt_cgroup_install_exit_handler(cg);
> +
> +	return cg;
> +
> +err_rmdir:
> +	rmdir(cg->path);
> +err_path:
> +	free(cg->path);
> +err_parent:
> +	free(cg->parent_path);
> +err_free:
> +	free(cg);
> +	return NULL;
> +}
> +
> +static void igt_cgroup_move_current_to_fd(int fd)
> +{
> +	char pidbuf[32];
> +	ssize_t len;
> +	int ret;
> +
> +	len = snprintf(pidbuf, sizeof(pidbuf), "%d", (int)getpid());
> +
> +	ret = write(fd, pidbuf, len);
> +	close(fd);
> +
> +	igt_assert_f(ret == len, "Failed to write PID to cgroup.procs: %m\n");
> +}
> +
> +
> +/**
> + * igt_cgroup_move_current() - Move the calling process into a cgroup.
> + * @cg: Target cgroup.
> + *
> + * Writes the calling process's PID to @cg's cgroup.procs file, transferring
> + * it into the cgroup.  All threads of the process move together.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_move_current(struct igt_cgroup *cg)
> +{
> +	int fd;
> +
> +	fd = openat(cg->dirfd, "cgroup.procs", O_WRONLY);
> +	igt_assert_f(fd >= 0, "Failed to open cgroup.procs: %m\n");
> +	igt_cgroup_move_current_to_fd(fd);

A bit funky fd ownership convention and prefix of 
igt_cgroup_move_current_to_fd but nothing seems broken at least.

> +}
> +
> +/**
> + * igt_cgroup_exit_current() - Move the calling process out of cgroup.
> + */
> +void igt_cgroup_exit_current(void)
> +{
> +	int fd;
> +	char parent_procs[PATH_MAX];
> +
> +	snprintf(parent_procs, sizeof(parent_procs), "%s/cgroup.procs", cgroupv2_mount());
> +
> +	fd = open(parent_procs, O_WRONLY);
> +	igt_assert_f(fd >= 0, "Failed to open cgroup.procs: %m\n");
> +	igt_cgroup_move_current_to_fd(fd);
> +}
> +
> +/*
> + * Parse a single dmem interface file line of the form "region_name value\n"
> + * where value is either a decimal byte count or the string "max".
> + * Returns 0 and writes to *out on success, -EINVAL on parse error.
> + */
> +static int dmem_parse_line(char *line, const char *region, uint64_t *out)
> +{
> +	char *space = strchr(line, ' ');
> +
> +	if (!space)
> +		return -EINVAL;
> +
> +	*space = '\0';
> +	if (strcmp(line, region) != 0)

Looking for a long region name on a short line can cause out of bounds 
read here I think. Not sure if out of bounds for the whole buffer, but 
definitely outside the current line.

> +		return -ENOENT;
> +
> +	if (strcmp(space + 1, "max") == 0) {

On the unlikely case dmem controller is returning something unexpected
space + 1 could already be out of bounds I think. This one is probably 
not worth guarding against though.

> +		*out = IGT_CGROUP_DMEM_MAX;
> +		return 0;
> +	}
> +
> +	errno = 0;
> +	*out = strtoull(space + 1, &space, 10);
> +	if (errno || *space != '\0')
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Read a dmem interface file opened relative to @dirfd, searching for
> + * @region.  On success writes the region's value to @out and returns 0.
> + * Returns -ENOENT when @region is absent, or a negative errno otherwise.
> + */
> +static int dmem_read_region(int dirfd, const char *file,
> +			    const char *region, uint64_t *out)
> +{
> +	char buf[4096];
> +	char *line, *saveptr;
> +	ssize_t n;
> +	int fd;
> +
> +	fd = openat(dirfd, file, O_RDONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	n = igt_readn(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (n < 0)
> +		return (int)n;
> +	buf[n] = '\0';
> +
> +	for (line = strtok_r(buf, "\n", &saveptr); line;
> +	     line = strtok_r(NULL, "\n", &saveptr)) {
> +		int ret = dmem_parse_line(line, region, out);
> +
> +		if (ret != -ENOENT)
> +			return ret;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/*
> + * Write "region_name value" (or "region_name max") to the dmem interface
> + * file @file opened relative to @dirfd.
> + * If @nonblock is true the file is opened with O_NONBLOCK, causing any
> + * eviction triggered by the limit change to be skipped rather than waited
> + * for; the write still succeeds (returns 0).
> + * Returns 0 on success, negative errno on failure.
> + */
> +static int dmem_write_region(int dirfd, const char *file,
> +			     const char *region, uint64_t bytes, bool nonblock)
> +{
> +	char buf[PATH_MAX + 64];

I don't see a connection to PATH_MAX, and then with +64 it's even more 
weird. The read has a 4k limit for the whole region list so perhaps 4k 
for one of the lines from that list is also enough.

> +	ssize_t len;
> +	int fd, ret;
> +	int flags = O_WRONLY;
> +
> +	if (bytes == IGT_CGROUP_DMEM_MAX)
> +		len = snprintf(buf, sizeof(buf), "%s max", region);
> +	else
> +		len = snprintf(buf, sizeof(buf), "%s %" PRIu64, region, bytes);
> +
> +	if (nonblock)
> +		flags |= O_NONBLOCK;
> +
> +	fd = openat(dirfd, file, flags);
> +	if (fd < 0)
> +		return -errno;
> +
> +	do {
> +		ret = write(fd, buf, len);
> +		if (ret < 0 && errno == EINTR)
> +			igt_debug("dmem cgroup write interrupted by signal, retrying\n");
> +	} while (ret < 0 && errno == EINTR);
> +	close(fd);
> +
> +	return (ret < 0) ? -errno : 0;
> +}
> +
> +/**
> + * igt_cgroup_dmem_set_max() - Set the hard device memory limit for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name (e.g. "drm/0000:03:00.0/vram0").
> + * @bytes: Hard limit in bytes.  Use %IGT_CGROUP_DMEM_MAX for no limit.
> + * @nonblock: If true, open the file with O_NONBLOCK so that eviction
> + *            triggered by the limit change is skipped rather than awaited.
> + *
> + * Writes @bytes to dmem.max for @region inside @cg.  Allocation attempts
> + * that would push usage past this limit fail with -EAGAIN in the kernel.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_set_max(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes, bool nonblock)
> +{
> +	igt_assert_f(dmem_write_region(cg->dirfd, "dmem.max", region, bytes,
> +				       nonblock) == 0,
> +		     "Failed to set dmem.max for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_set_min() - Set the hard protection threshold for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @bytes: Hard protection threshold in bytes.  Pass 0 to disable.
> + *
> + * Writes @bytes to dmem.min for @region inside @cg.  Device memory below
> + * this threshold is never reclaimed regardless of system pressure.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_set_min(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes)
> +{
> +	igt_assert_f(dmem_write_region(cg->dirfd, "dmem.min", region, bytes,
> +				       false) == 0,
> +		     "Failed to set dmem.min for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_set_low() - Set the soft protection threshold for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @bytes: Soft protection threshold in bytes.  Pass 0 to disable.
> + *
> + * Writes @bytes to dmem.low for @region inside @cg.  Device memory below
> + * this threshold is only reclaimed when no unprotected memory remains.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_set_low(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes)
> +{
> +	igt_assert_f(dmem_write_region(cg->dirfd, "dmem.low", region, bytes,
> +				       false) == 0,
> +		     "Failed to set dmem.low for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_current() - Read current device memory usage for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @out: Receives the current usage in bytes.
> + *
> + * Reads dmem.current from @cg and returns the usage for @region.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_current(struct igt_cgroup *cg, const char *region,
> +				 uint64_t *out)
> +{
> +	igt_assert_f(dmem_read_region(cg->dirfd, "dmem.current", region, out) == 0,
> +		     "Failed to read dmem.current for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_max() - Read the configured hard limit for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @out: Receives the limit in bytes, or %IGT_CGROUP_DMEM_MAX if unset.
> + *
> + * Reads dmem.max from @cg for @region.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_max(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out)
> +{
> +	igt_assert_f(dmem_read_region(cg->dirfd, "dmem.max", region, out) == 0,
> +		     "Failed to read dmem.max for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_min() - Read the configured hard protection threshold for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @out: Receives the threshold in bytes.
> + *
> + * Reads dmem.min from @cg for @region.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_min(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out)
> +{
> +	igt_assert_f(dmem_read_region(cg->dirfd, "dmem.min", region, out) == 0,
> +		     "Failed to read dmem.min for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_low() - Read the configured soft protection threshold for a region.
> + * @cg: Target cgroup.
> + * @region: Device memory region name.
> + * @out: Receives the threshold in bytes.
> + *
> + * Reads dmem.low from @cg for @region.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_low(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out)
> +{
> +	igt_assert_f(dmem_read_region(cg->dirfd, "dmem.low", region, out) == 0,
> +		     "Failed to read dmem.low for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_available() - Check if the dmem cgroup controller is available.
> + *
> + * Probes the cgroup v2 hierarchy for the presence of a dmem.capacity file at
> + * the root, indicating that the kernel dmem controller is compiled in and at
> + * least one device memory region has been registered.
> + *
> + * Return: %true if the dmem controller is available, %false otherwise.
> + */
> +bool igt_cgroup_dmem_available(void)
> +{
> +	char **regions = igt_cgroup_dmem_regions();
> +
> +	if (!regions)
> +		return false;
> +
> +	igt_cgroup_dmem_regions_free(regions);
> +	return true;
> +}
> +
> +/**
> + * igt_cgroup_dmem_regions() - Enumerate all registered device memory regions.
> + *
> + * Reads the root cgroup's dmem.capacity file and returns a NULL-terminated
> + * array of region name strings.  Each name can be passed directly to
> + * igt_cgroup_dmem_get_capacity(), igt_cgroup_dmem_get_current(), and the
> + * igt_cgroup_dmem_set_*() / igt_cgroup_dmem_get_*() family.
> + *
> + * Free the returned array with igt_cgroup_dmem_regions_free().
> + *
> + * Return: A NULL-terminated array of strings on success, %NULL if cgroupv2
> + * is unavailable or no regions are registered.
> + */
> +char **igt_cgroup_dmem_regions(void)
> +{
> +	char buf[4096];
> +	char *line, *saveptr, *space, *name;
> +	char **regions = NULL, **tmp;
> +	int count = 0;
> +	const char *mount;
> +	ssize_t n;
> +	int dirfd, fd;
> +
> +	mount = cgroupv2_mount();
> +	if (!mount)
> +		return NULL;
> +
> +	dirfd = open(mount, O_RDONLY | O_DIRECTORY);
> +	if (dirfd < 0)
> +		return NULL;
> +
> +	fd = openat(dirfd, "dmem.capacity", O_RDONLY);
> +	close(dirfd);
> +	if (fd < 0)
> +		return NULL;
> +
> +	n = igt_readn(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (n <= 0)
> +		return NULL;
> +	buf[n] = '\0';
> +
> +	for (line = strtok_r(buf, "\n", &saveptr); line;
> +	     line = strtok_r(NULL, "\n", &saveptr)) {
> +		space = strchr(line, ' ');
> +
> +		if (!space)
> +			continue;
> +		*space = '\0';
> +
> +		name = strdup(line);
> +		if (!name)
> +			goto err;
> +
> +		tmp = realloc(regions, (count + 2) * sizeof(*regions));
> +		if (!tmp) {
> +			free(name);
> +			goto err;
> +		}
> +		regions = tmp;
> +		regions[count++] = name;
> +		regions[count] = NULL;
> +	}
> +
> +	return regions;
> +
> +err:
> +	igt_cgroup_dmem_regions_free(regions);
> +	return NULL;
> +}
> +
> +/**
> + * igt_cgroup_dmem_regions_free() - Free a region list returned by igt_cgroup_dmem_regions().
> + * @regions: NULL-terminated array returned by igt_cgroup_dmem_regions().
> + *
> + * Frees each string in @regions and the array itself.  Safe to call with
> + * %NULL.
> + */
> +void igt_cgroup_dmem_regions_free(char **regions)
> +{
> +	int i;
> +
> +	if (!regions)
> +		return;
> +
> +	for (i = 0; regions[i]; i++)
> +		free(regions[i]);
> +
> +	free(regions);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_capacity() - Read total device memory capacity for a region.
> + * @region: Device memory region name.
> + * @out: Receives the total capacity in bytes.
> + *
> + * Reads dmem.capacity from the root cgroup and returns the capacity for
> + * @region.  This reflects the maximum allocatable bytes, excluding memory
> + * reserved by the kernel for internal use.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_capacity(const char *region, uint64_t *out)
> +{
> +	const char *mount;
> +	int dirfd, ret;
> +
> +	mount = cgroupv2_mount();
> +	igt_assert_f(mount, "cgroup v2 not available\n");
> +
> +	dirfd = open(mount, O_RDONLY | O_DIRECTORY);
> +	igt_assert_f(dirfd >= 0, "Failed to open cgroup root: %m\n");
> +
> +	ret = dmem_read_region(dirfd, "dmem.capacity", region, out);
> +	close(dirfd);
> +
> +	igt_assert_f(ret == 0, "Failed to read dmem.capacity for region %s\n", region);
> +}
> +
> +/**
> + * igt_cgroup_dmem_get_system_current() - Read system-wide device memory usage for a region.
> + * @region: Device memory region name.
> + * @out: Receives the total system-wide usage in bytes.
> + *
> + * Reads dmem.current from the root cgroup for @region.  This reflects the
> + * aggregate device memory usage across all cgroups on the system.
> + * Fails the test via igt_assert on error.
> + */
> +void igt_cgroup_dmem_get_system_current(const char *region, uint64_t *out)
> +{
> +	const char *mount;
> +	int dirfd, ret;
> +
> +	mount = cgroupv2_mount();
> +	igt_assert_f(mount, "cgroup v2 not available\n");
> +
> +	dirfd = open(mount, O_RDONLY | O_DIRECTORY);
> +	igt_assert_f(dirfd >= 0, "Failed to open cgroup root: %m\n");
> +
> +	ret = dmem_read_region(dirfd, "dmem.current", region, out);
> +	close(dirfd);
> +
> +	igt_assert_f(ret == 0, "Failed to read root dmem.current for region %s\n", region);
> +}
> diff --git a/lib/igt_cgroup.h b/lib/igt_cgroup.h
> new file mode 100644
> index 000000000000..5115c60427da
> --- /dev/null
> +++ b/lib/igt_cgroup.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#ifndef __IGT_CGROUP_H__
> +#define __IGT_CGROUP_H__
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +/**
> + * IGT_CGROUP_DMEM_MAX - Sentinel value meaning "no device memory limit".
> + *
> + * Pass this to igt_cgroup_dmem_set_max() to remove a previously set limit,
> + * equivalent to writing "max" to the dmem.max interface file.
> + */
> +#define IGT_CGROUP_DMEM_MAX UINT64_MAX
> +
> +/**
> + * struct igt_cgroup - Opaque handle to a cgroup v2 sub-cgroup.
> + *
> + * Allocated by igt_cgroup_new() and freed at exit time.
> + * All other functions in this module take a pointer to this type.
> + */
> +struct igt_cgroup;
> +
> +struct igt_cgroup *igt_cgroup_new(const char *name);
> +
> +void igt_cgroup_move_current(struct igt_cgroup *cg);
> +void igt_cgroup_exit_current(void);
> +
> +void igt_cgroup_dmem_set_max(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes, bool nonblock);
> +void igt_cgroup_dmem_set_min(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes);
> +void igt_cgroup_dmem_set_low(struct igt_cgroup *cg, const char *region,
> +			     uint64_t bytes);
> +
> +void igt_cgroup_dmem_get_max(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out);
> +void igt_cgroup_dmem_get_min(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out);
> +void igt_cgroup_dmem_get_low(struct igt_cgroup *cg, const char *region,
> +			     uint64_t *out);
> +
> +void igt_cgroup_dmem_get_current(struct igt_cgroup *cg, const char *region,
> +				 uint64_t *out);
> +void igt_cgroup_dmem_get_capacity(const char *region, uint64_t *out);

All igt_cgroup_dmem_get apart from _current work on igt_cgroup. I get 
it.. capacity is system wide by definition. Just that it briefly threw 
me off together with the igt_cgroup_dmem_get_system_current below for 
which I thought is it system memory, surely not I thought. Would 
renaming it to igt_cgroup_dmem_get_system_capacity make sense? Or 
s/system/total/?

Slightly related question - how are multiple GPUs of a same model 
handled in dmem? Are the memory region lines prefixed with some sort of 
a GPU id?

> +void igt_cgroup_dmem_get_system_current(const char *region, uint64_t *out);
> +
> +bool igt_cgroup_dmem_available(void);
> +char **igt_cgroup_dmem_regions(void);
> +void igt_cgroup_dmem_regions_free(char **regions);
> +
> +#endif /* __IGT_CGROUP_H__ */
> diff --git a/lib/meson.build b/lib/meson.build
> index f3e6d96693a1..df5f13efac56 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -19,6 +19,7 @@ lib_sources = [
>   	'i915/i915_dp.c',
>   	'igt_collection.c',
>   	'igt_color_encoding.c',
> +	'igt_cgroup.c',
>   	'igt_configfs.c',
>   	'igt_facts.c',
>   	'igt_crc.c',
> 

In summary, I think the only things which I would like to addresses are:

1. Commit text
2. PATH_MAX + 64
3. Potential out of bounds strcmp or whatever it was.

With those r-b.

Regards,

Tvrtko

