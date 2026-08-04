Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1FFC55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E2210E069;
	Tue,  4 Aug 2026 03:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YYzf9VYS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BBD10E069
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785812632; x=1817348632;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zBgFjVb0u5RrsyB4ut0G9ucJzEJ84Bcty56oUypQ3tQ=;
 b=YYzf9VYS2/jKWevgXctwyIoXGxFJNMWedGNrXW0PIARNLdJ2CH5NjbMz
 JvJIdZNdz4HQVzXVh/5+y3czjHWNMQaEOFPXB2Yqv57jhuMQU0F3RrvDg
 U3IyQFAgnmeZkIYW8SQcaqUCW2FkIGY4RB2uSd/n7qTU+qHGmVvTfpAWR
 LBNcq/n8q682xki7Sl62a5Q+Gqo1FNBjGOS35NkM/JxTik/6bPUdS8GrA
 oShXirvAz3c9/3U2HU3UTt61aTPFgR/sGNin4dvraieTn3o858EBaYZid
 2CKkl97A2VZYk5RYOoHSSxGXW4RDwQNVt9N9LL25drtJ/NFVjiqhNCq5I Q==;
X-CSE-ConnectionGUID: 5AUzKXMbQJGPEH/8Ljzqcg==
X-CSE-MsgGUID: VkKszymQSk+cdrrN1cJkrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103759410"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103759410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:03:51 -0700
X-CSE-ConnectionGUID: elwemsHdRtW2OaL5SIIscg==
X-CSE-MsgGUID: A0PJ4RCnSXWj4FGXoQdkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="260139919"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:03:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v3 0/3] backlight: aw99706: DT parsing and blank state fixes
Date: Tue,  4 Aug 2026 11:02:52 +0800
Message-ID: <20260804030255.1934470-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

The driver reads its tuning properties under names the binding does not
define (patch 1), the validation paths accept values the binding forbids
(patch 2), and update_status() ignores the blank state, leaving bl_power
inoperative (patch 3).

v3:
- patch 2: reject 0 for awinic,sw-freq-hz (reserved-slot marker
  collided with it); add Fixes tag
- patch 3: add stable tag
v2: only patch 1/3 reached the lists (outbound mail failure):
    https://lore.kernel.org/all/20260803141310.1379194-2-junjie.cao@linux.dev/
v1: https://lore.kernel.org/all/20260701133918.33487-1-junjie.cao@linux.dev/

Junjie Cao (3):
  backlight: aw99706: Fix DT property names to match binding
  backlight: aw99706: Validate all DT property values consistently
  backlight: aw99706: Honor the core blank state in update_status()

 drivers/video/backlight/aw99706.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.43.0

