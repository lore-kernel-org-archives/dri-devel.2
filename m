Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF38EC61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3701210E601;
	Mon, 31 Aug 2026 06:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S3ed8VSb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8BD10E601
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788156181; x=1819692181;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ckR49b4cSnyelIC4fonjdugoze5c2ilGOFGL2lgtGD0=;
 b=S3ed8VSbpw+8vuuR7oONdRilKfQa/cWBYRZ7EX+CcM8TMxaXCp9dL3fQ
 U5zksvtd1UHhMUqa5DjwAEiM5+r0kPlBNwWQWyFZR6TuSNO8q3d/X6jxN
 aeda1hW3Y9wHUFSAPBZiWCYwvd6kU05Qd2mJdS4towTsSg50myKBHNCeq
 nN2fKEu0fRoDRqkZLOhUEOb1blc6yVgVooNSKHWE12dnUOFwGBc38XFI3
 K2C7ppDw4rTK92JbpVnNcRvD7vLpO+vL2HbgDlNZ267bvPgnvUF2IQoJ2
 LT/iJaT9HfAk1qoDsa8jfiNOwG68n77e8uCSL6Un3ZAA+RtPwQd+o7vOM w==;
X-CSE-ConnectionGUID: uPndDh99QbC5kOpfBFkOWA==
X-CSE-MsgGUID: 9k/Tp/63RsqDzqOlJOYUmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88677625"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88677625"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:03:00 -0700
X-CSE-ConnectionGUID: ztLeTm1HSs6yeqq09YvLfQ==
X-CSE-MsgGUID: rMYvAMvQR2i1qQ0SLUAxQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="265467730"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:02:59 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH v1 0/2] udmabuf: Add mlock accounting and fix syzbot warning
 issue
Date: Sun, 30 Aug 2026 23:00:29 -0700
Message-ID: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

By increasing the default size limit from 64 MB to INT_MAX, commit
44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
has left open the possibility that an unpriviledged user-space
process can pin an unlimited amount of memory through udmabuf.
Syzbot was able to trigger a warning trace by trying to pin a large
amount of memory through udmabuf.

Fix this issue by first preventing the warning trace from showing
up in the log and then add mlock accounting to udmabuf to prevent
unpriviledged users from pinning an unlimited amount of memory
through udmabuf.

-----------------------------

Patchset overview:

Patch 1: Fix for syzbot warning trace issue
Patch 2: Add mlock accounting to udmabuf

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Robert Mader <robert.mader@collabora.com>
Cc: Xaver Hugl <xaver.hugl@kde.org>

Vivek Kasireddy (2):
  udmabuf: Do not warn when pages/folios array allocation fails
  udmabuf: Add mlock accounting for udmabuf pages/folios

 drivers/dma-buf/udmabuf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.53.0

