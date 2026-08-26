Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40217C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6743910ED38;
	Wed, 26 Aug 2026 15:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="Dv7urfOT";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD5910ED38
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:10:28 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=d2dkc2VgO6Vsi1QGyFR9lYOel1edyti+iZtYMf2G1W8=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787757026; v=1; x=1788361826;
 b=Dv7urfOT8Qqn5yRs/Jt/ojVzJfg+r5Pi/Lxgo8JEmwQVo9QgYySErb7ftbCGdjtUhwDA7rL/
 gVuBe8nCnAlYZv63NPp9gUTd3nj9hEhh96l/o+3UnncQLpWo6pvul3V1BileMAmHFPdzWQVLAlC
 uEPfUzyqyGkBg8uQhnyYfNY3MweDn24Wu94NgkcfSt0SvlTWIBuSJlE0pLoutky5X2c6M47gmam
 pUgizgVuUEYdx1r+koooCe7F+aWEmmHOUnVsx4/Vf+SqSYR5ovLJ2MJSp9s7R4TqAM4c2BG5atp
 532Edp1v29gk2k7MiJbPelG5shI+DXij5zrmgJqxEe/Fw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 1bdcdb4aa60672b5;
 Wed, 26 Aug 2026 15:10:25 +0000
X-Mizu-Trace-ID: 1bdcdb4aa60672b5
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/amdxdna: make the debug BO command wait
 interruptible
Date: Wed, 26 Aug 2026 18:10:16 +0300
Message-ID: <20260826151016.126822-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826150726.126296-1-taimuraz@kaitmazov.com>
References: <20260826150726.126296-1-taimuraz@kaitmazov.com>
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

This makes the wait survivable but leaves the lock cycle in place: both
callers hold dev_lock across aie2_cmd_wait(), and aie2_sched_job_timedout()
needs that same lock before it can force the fence to signal.

The wait itself does not need the lock. aie2_cmd_get_out_fence() already
returns a referenced fence and drv_cmd is krefed, so the sequence could be:
submit and take the fence under dev_lock, drop the lock, wait, retake it.
Nothing after the wait touches hwctx. amdxdna_pm_resume_get_locked() and
amdxdna_update_heap() already drop a caller's lock this way, so the shape is
not new to this driver.

The alternative is to change the op contract instead: have hwctx_config() and
hwctx_sync_debug_bo() return once the command is submitted and let the ioctl
do the waiting, which keeps the lock discipline in one place.

Which of the two would you rather see? I have not been able to reproduce a
debug BO command that does not complete, so I would rather ask than guess at
the invariants that have to hold across the unlocked window.

Taimuraz
