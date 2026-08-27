Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12714C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D162810F169;
	Thu, 27 Aug 2026 19:08:26 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9B489622
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:06:18 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dce;
 Fri, 28 Aug 2026 01:06:16 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 0/3] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 01:06:05 +0800
Message-ID: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442fc4a603a1kunmddadd30e6f5a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhhDVkwdGUIdT0MaSk0aS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:08:24 +0000
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

Changes in v2:
- Split the three independent fixes into separate patches as suggested by
  Sidong Yang.
- Rebased onto the current drm-misc-next branch.
- Dropped incidental blank-line-only changes from the original patch.
- Added Sidong Yang's Tested-by tag.

v1: https://lore.kernel.org/r/20260813142059.151644-1-Naixumogu@whut.edu.cn

MoGGuU (3):
  accel/rocket: Validate BO handle counts on job submission
  accel/rocket: Collect job dependencies before arming
  accel/rocket: Propagate job submission errors

 drivers/accel/rocket/rocket_job.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 20331505df9c7d8b29f2f9309231607a41a74120
-- 
2.43.0
