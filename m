Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0756610FCACE
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9C610E597;
	Wed,  1 Apr 2026 20:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LTR1wdXu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2C310E141;
 Wed,  1 Apr 2026 20:20:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 40E4640124;
 Wed,  1 Apr 2026 20:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01873C4CEF7;
 Wed,  1 Apr 2026 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775074815;
 bh=fxuj2SQ4zAFgYm8BZkUW2BKIyhMwt2J/siG8mDBm/IA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LTR1wdXuawTnvw8nOp6Xa+rFm153aVYzl4OjjF06Cn1dbV6j2+sSAMMz6WctWeSZw
 566U1GKU/F+CpngARrwDc4jmS5/pvcrfHmMxcg9tuYHPRZ+SDIvgqoTWSJGhffKnpW
 RE2SYMFnoFh+tKMNgpB0gIFgnEmBkfJKzJKsF6hX0g0M7wCwmNXueo1kSVWUGbTWKG
 j51LgIzcrI2xCq2yDzWzjOUWpYypTOrqyErp8rS6DAhIfri0CJ735ZfxTdIqtfDuRQ
 eoJhIik8gbG8UYDnvhA2ZUoX1WY3/6Iaw1Ntjxp+MdNPWhmRzXMbi0W7ZdueTy4Smu
 zcLJR3hJa9KSw==
Date: Wed, 01 Apr 2026 10:20:13 -1000
Message-ID: <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Waiman Long <longman@redhat.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
 Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
In-Reply-To: <20260401010739.1053192-1-matthew.brost@intel.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
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

Hello,

Applied to wq/for-7.0-fixes with the comment updated as below.

Thanks.

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1852,12 +1852,11 @@
 		if (pwq_activate_first_inactive(pwq, true)) {
 			/*
-			 * pwq is unbound. Additional inactive work_items need
-			 * to reinsert the pwq into nna->pending_pwqs, which
-			 * was skipped while pwq->plugged was true. See
-			 * pwq_tryinc_nr_active() for additional details.
+			 * While plugged, queueing skips activation which
+			 * includes bumping the nr_active count and adding the
+			 * pwq to nna->pending_pwqs if the count can't be
+			 * obtained. We need to restore both for the pwq being
+			 * unplugged. The first call activates the first
+			 * inactive work item and the second, if there are more
+			 * inactive, puts the pwq on pending_pwqs.
 			 */

-- 
tejun
