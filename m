Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88887CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76EF10E517;
	Wed, 20 May 2026 11:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kqu6YLE2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7954510E409;
 Wed, 20 May 2026 11:20:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FB8D60121;
 Wed, 20 May 2026 11:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA201F00894;
 Wed, 20 May 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779276052;
 bh=UR8YaLfyNJTK2sII2DsNqJ1PeWNm2h21TvTZ8rrIw3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kqu6YLE2x1tz92HDazdRjYyh2dUd2nTtP8EBlbV6Rq0BiMCKz+Jb6P2Yjkpj4OcUk
 MWvofruGUUZIM/kTmbaV9ca8TDVMR/CuG8E4/YRYDePOhLsw7aQsAM5bAdAfC8KdT1
 HMJEBdUJU/brGl5Kf0329YdJhtV5M/k5f1M/pvA1VYHigiO/IVhxoLsc54fq3kk1rO
 u6lupFfqfezIJMuzzpZj3Y0i+HW++54oyPUUBfhbeOOwqqWMIwrjW2wOOKw19MKGRi
 cxXo4LccWs5KC8exjpBA8lF5mqoDH63lSJA/SCU09JXAShu4HqG8v7qDrO4Im5rHRe
 MFl+H0j1tALLw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Xiang Liu <xiang.liu@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] drm/amd/ras: Fix CPER ring debugfs read
 overflow
Date: Wed, 20 May 2026 07:19:19 -0400
Message-ID: <20260520111944.3424570-47-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520111944.3424570-1-sashal@kernel.org>
References: <20260520111944.3424570-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.9
Content-Transfer-Encoding: 8bit
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

From: Xiang Liu <xiang.liu@amd.com>

[ Upstream commit 6bbede02dc62a1021aeeae87ab243bd7a93c61d2 ]

The legacy CPER debugfs reader can reach the payload path without a
valid pointer snapshot. The remaining user byte count is also treated as
the ring occupancy in dwords, so reads past the header can copy more than
requested.

Take the CPER lock before sampling pointers. Resample rptr/wptr for
payload reads, bound the payload copy by available dwords and the
remaining user size, and advance the file position for each dword copied.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1e40ef87ffdc291e05ccdade8b9170cc9c1c4249)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase Records

Step 1.1 Record: Subsystem `drm/amd/ras`; action verb `Fix`; claimed
intent is preventing CPER ring debugfs read overflow.

Step 1.2 Record: Tags present: `Signed-off-by: Xiang Liu
<xiang.liu@amd.com>`, `Reviewed-by: Tao Zhou <tao.zhou1@amd.com>`,
`Signed-off-by: Alex Deucher <alexander.deucher@amd.com>`, and a cherry-
pick line. No `Fixes:`, `Reported-by:`, `Tested-by:`, `Link:`, or `Cc:
stable`.

Step 1.3 Record: Commit body describes two concrete bugs: CPER payload
reads can proceed without a valid rptr/wptr snapshot, and byte `size` is
treated as dword ring occupancy, allowing copies beyond the requested
read count.

Step 1.4 Record: Not hidden; this is an explicit memory-safety/user-copy
bounds fix.

Step 2.1 Record: One file changed,
`drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c`; one function changed,
`amdgpu_debugfs_ring_read`; roughly +13/-? surgical single-function
change.

Step 2.2 Record: Before, CPER locking and pointer sampling happened only
when `*pos < 12`; payload-only reads used uninitialized `early[]`.
Before, payload loop copied one dword while decrementing `size` by one,
although `size` is bytes. After, CPER reads lock before sampling,
resample pointers for payload, compute available dwords separately, cap
reads by `size >> 2`, and advance `*pos`.

Step 2.3 Record: Bug category is memory safety / bounds correctness plus
synchronization. Mechanism: debugfs `read()` could return/copy more
bytes than requested and could use invalid CPER ring pointers on reads
starting past the header.

Step 2.4 Record: Fix quality is good: small, local, no API change.
Regression risk is low; it only changes CPER debugfs reads. Holding
`cper.ring_lock` for payload-only reads matches the existing intent to
serialize with `amdgpu_cper_ring_write`.

Step 3.1 Record: `git blame` shows the CPER payload reader came from
`5a1428242952f2` (`drm/amdgpu: read CPER ring via debugfs`), first
contained by `v6.15-rc1`; the partial CPER lock came from
`8652920d2c0024`.

Step 3.2 Record: No `Fixes:` tag to follow. I inspected the introducing
commits manually: `5a1428242952f2` added the affected CPER payload
reader; `8652920d2c0024` added the existing CPER ring mutex but only
around the header path.

Step 3.3 Record: Related history includes `4d614ce8ffd75` adding the
CPER ring buffer, `a6d9d192903ea` adding CPER writes, `d6f9bbce18762`
fixing CPER ring remaining-size computation, and `93c19634f72fb` fixing
a separate uniras CPER debugfs user-buffer overflow.

Step 3.4 Record: Xiang Liu has multiple AMDGPU/RAS CPER commits in this
area. Alex Deucher committed the patch per the commit tags and is the
AMDGPU maintainer path in local history.

Step 3.5 Record: Dependencies are the existing CPER ring/debugfs code.
The affected code exists in this v7.0.y checkout and in tags `v6.15`
through `v7.0`; it is absent from `v6.14` by pattern check.

Step 4.1 Record: `b4 dig -c 1e40ef...` failed because the commit object
is not present locally. Web searches did not find the exact target
subject/body; they found related AMDGPU CPER debugfs patches and the
uniras buffer-overflow bug report.

Step 4.2 Record: `b4 dig -w` also failed for the same reason. Commit
tags still show AMDGPU review by Tao Zhou and commit by Alex Deucher.

Step 4.3 Record: No direct bug report found for this exact patch.
Related Dan Carpenter report verified a similar CPER debugfs user-buffer
overflow in `amdgpu_ras_cper_debugfs_read`, not this legacy reader.

Step 4.4 Record: Related CPER series context verified on freedesktop
archives: CPER debugfs read and CPER mutex patches were part of a v2
AMDGPU CPER series.

Step 4.5 Record: No stable-specific discussion found for the exact
target terms.

Step 5.1 Record: Modified function: `amdgpu_debugfs_ring_read`.

Step 5.2 Record: Callers are debugfs file operations:
`amdgpu_debugfs_ring_fops.read` and, for SR-IOV,
`amdgpu_debugfs_virt_ring_read`, which calls `amdgpu_debugfs_ring_read`.

Step 5.3 Record: Key callees are `amdgpu_ring_get_rptr`,
`amdgpu_ring_get_wptr`, `put_user`, and CPER lock operations. CPER
writes use `amdgpu_cper_ring_write`, which takes the same
`cper.ring_lock`.

Step 5.4 Record: Reachability is via
`/sys/kernel/debug/dri/*/amdgpu_ring_cper`, created by
`amdgpu_debugfs_ring_init` for registered rings. `amdgpu_ring_init`
registers rings in `adev->rings`, and `amdgpu_debugfs_init` iterates
those rings.

Step 5.5 Record: Similar pattern found: separate uniras CPER reader
overflow fixed by `93c19634f72fb`.

Step 6.1 Record: Buggy legacy CPER debugfs reader exists in `v6.15`,
`v6.16`, `v6.17`, `v6.18`, `v6.19`, and `v7.0`; not found in `v6.14`.

Step 6.2 Record: Expected backport difficulty is low for trees
containing the CPER reader. I could not complete a meaningful `git apply
--check` because my hand-built check patch was malformed, but the
current file matches the relevant pre-fix logic.

Step 6.3 Record: Related uniras fix exists locally, but it does not fix
the legacy `amdgpu_debugfs_ring_read` CPER path.

Step 7.1 Record: Subsystem is AMDGPU DRM/RAS driver code. Criticality is
driver-specific, not core kernel-wide.

Step 7.2 Record: Subsystem is active; local history shows multiple
CPER/RAS changes around v6.15-v6.19.

Step 8.1 Record: Affected users are AMDGPU systems with CPER ring
enabled and debugfs CPER ring reads.

Step 8.2 Record: Trigger is reading the CPER ring debugfs file,
especially payload reads past the 12-byte header or small/count-limited
reads. Unprivileged triggerability depends on debugfs mount permissions
and was not verified.

Step 8.3 Record: Failure mode is user-copy beyond requested read size
and possible invalid ring indexing from missing pointer snapshot.
Severity: HIGH for memory-safety correctness, reduced by debugfs-only
exposure.

Step 8.4 Record: Benefit is meaningful for affected AMDGPU debugfs users
because it prevents incorrect user copies and invalid CPER ring reads.
Risk is low: small, contained, no feature/API change.

## Stable Rules

1. Obviously correct and tested: mostly yes by inspection and maintainer
   review tag; no explicit `Tested-by`.
2. Fixes a real bug: yes, byte count vs dword count and missing pointer
   snapshot are verified in the code.
3. Important issue: yes, memory-safety/user-copy overflow from a
   readable debugfs file.
4. Small and contained: yes, one function in one driver file.
5. No new features/APIs: yes.
6. Can apply to stable: yes for v6.15+ trees containing the CPER debugfs
   reader; not applicable to v6.14 and older.

## Verification

- Phase 1: Parsed provided commit message and tags; no `Fixes`,
  `Reported-by`, `Link`, or stable tag present.
- Phase 2: Compared provided diff with current
  `amdgpu_debugfs_ring_read` implementation; verified `size` is bytes
  and old CPER loop decrements it as dwords.
- Phase 3: Ran `git blame` on the affected function; identified
  `5a1428242952f2` and `8652920d2c0024`.
- Phase 3: Ran `git show` on related commits `4d614ce8ffd75`,
  `5a1428242952f2`, `8652920d2c0024`, `d6f9bbce18762`, `527e3d40339b`,
  `93c19634f72fb`, and `a91d91b600479`.
- Phase 4: Ran `b4 dig`; it failed because the target commit object is
  unavailable in this checkout.
- Phase 4: Web searched exact subject/body; no direct target lore found.
  Fetched related freedesktop CPER series and Dan Carpenter uniras
  overflow report.
- Phase 5: Used repo search/read to trace debugfs fops, ring debugfs
  creation, CPER writer locking, and ring registration.
- Phase 6: Checked tags `v6.14` through `v7.0`; verified affected code
  starts at `v6.15`.
- Phase 8: Verified debugfs exposure through
  `debugfs_create_file_size(..., 0444, ...)`; did not verify system
  mount permissions, so unprivileged exploitability remains unverified.

This is a small, well-scoped memory-safety fix for code present in
stable trees starting at v6.15. It should be backported to affected
stable trees.

**YES**

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 +++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 4638a686a84e7..bebd72178cc13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -572,8 +572,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	uint32_t value, result, early[3];
+	u32 value, result, early[3] = { 0 };
 	uint64_t p;
+	u32 avail_dw, start_dw, read_dw;
 	loff_t i;
 	int r;
 
@@ -585,10 +586,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 	result = 0;
 
-	if (*pos < 12) {
-		if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
-			mutex_lock(&ring->adev->cper.ring_lock);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
+		mutex_lock(&ring->adev->cper.ring_lock);
 
+	if (*pos < 12) {
 		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
 		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
 		early[2] = ring->wptr & ring->buf_mask;
@@ -620,13 +621,24 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 			*pos += 4;
 		}
 	} else {
+		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
+		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
+
 		p = early[0];
 		if (early[0] <= early[1])
-			size = (early[1] - early[0]);
+			avail_dw = early[1] - early[0];
 		else
-			size = ring->ring_size - (early[0] - early[1]);
+			avail_dw = ring->buf_mask + 1 - (early[0] - early[1]);
 
-		while (size) {
+		start_dw = (*pos > 12) ? ((*pos - 12) >> 2) : 0;
+		if (start_dw >= avail_dw)
+			goto out;
+
+		p = (p + start_dw) & ring->ptr_mask;
+		avail_dw -= start_dw;
+		read_dw = min_t(u32, avail_dw, size >> 2);
+
+		while (read_dw) {
 			if (p == early[1])
 				goto out;
 
@@ -639,9 +651,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 			buf += 4;
 			result += 4;
-			size--;
+			read_dw--;
 			p++;
 			p &= ring->ptr_mask;
+			*pos += 4;
 		}
 	}
 
-- 
2.53.0

