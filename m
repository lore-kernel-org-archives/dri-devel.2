Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D3C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B14210F2A3;
	Fri, 28 Aug 2026 07:44:58 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9544010F26C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:42:07 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4baa740d6;
 Fri, 28 Aug 2026 14:42:04 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, Greg KH <greg@kroah.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 14:41:49 +0800
Message-ID: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0471aa93003a1kunmd9ea7a958c2ab
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0tNVh8eTU8YHU5MSEtJHVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
 xVSktLVUtZBg++
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

Several independent error paths in the Rocket job submission ioctl can be
triggered by unprivileged userspace. This series validates userspace BO
counts before passing them to helpers with signed count parameters, collects
implicit dependencies before the scheduler job is armed, and propagates the
first per-job submission error to userspace.

The series was tested on RK3588 with zero task counts, invalid task pointers,
invalid BO handles, and oversized BO counts. The requests returned the
expected error codes without warnings or errors in the kernel log.

Changes in v5:
- Replaced the nickname in the author identity and Signed-off-by tags with my
  real name, as requested by Greg Kroah-Hartman.

Changes in v4:
- Added Sidong Yang's Reviewed-by tags, using the corrected email address.
- Dropped Cc: stable from patch 3 because propagating submission errors
  changes userspace-visible ioctl behavior.
- Rebased onto the current drm-misc-next branch.

Changes in v3:
- Kept the individual count checks before GEM lookup, but changed bo_count to
  int so check_add_overflow() rejects combined counts above INT_MAX, as
  suggested by Sidong Yang.

Changes in v2:
- Split the three independent fixes into separate patches as suggested by
  Sidong Yang.
- Rebased onto the then-current drm-misc-next branch.
- Dropped incidental blank-line-only changes from the original patch.
- Added Sidong Yang's Tested-by tag.

v4: https://lore.kernel.org/r/20260828061916.20405-1-Naixumogu@whut.edu.cn
v3: https://lore.kernel.org/r/20260828050805.38548-1-Naixumogu@whut.edu.cn
v2: https://lore.kernel.org/r/20260827170608.39511-1-Naixumogu@whut.edu.cn
v1: https://lore.kernel.org/r/20260813142059.151644-1-Naixumogu@whut.edu.cn

Haoming Gao (3):
  accel/rocket: Validate BO handle counts on job submission
  accel/rocket: Collect job dependencies before arming
  accel/rocket: Propagate job submission errors

 drivers/accel/rocket/rocket_job.c | 32 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)


base-commit: f9c2f70ee41544717b3c209083073db1e21f919b
-- 
2.43.0
