Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFFBC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28CA10EFCA;
	Thu, 23 Jul 2026 07:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZS6YHDwQ";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653F310E3D4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:47:26 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-9693bbb962eso1464324241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784681245; x=1785286045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rAT02ZEvTL+fIOJG9k/2WuB4ZPnqd54oAdj5bUVg4l0=;
 b=ZS6YHDwQB9x1Xs5i/3Ie+phd7Wmnm2sLUECK3nD1QSSkJSNqldZm59CepG/fNWitL4
 KZyy+JoBFwAiooSQR8K1M2re9qOh1e0wYUq5KzAiUxJlUvX1BhWraHsXRfTByaNrxwhA
 jPYBlKh6fHX/qeYjwZtAPx+rjbTaTPxzqU7UIxCJKD35QUBHq8SYV3RrLwF43nsOYw2b
 4j0daUnNkVqv4Uqpb+CBzyT6WmpxCVBH1w4/h+Zz1QuL/F0WKyxvL+55WZQfrpNtyH/H
 L9pMrKbFy73PzYAWA6wPWcIhW9L3mzkCfKQmmzc9Oqn8XDtt3D9Hak9KHftav+ApsALZ
 0rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784681245; x=1785286045;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rAT02ZEvTL+fIOJG9k/2WuB4ZPnqd54oAdj5bUVg4l0=;
 b=CQ8v0J8jI6/9keBkqG3ju7ULUsVScNi04J41/CfX31zEftBRZcKoTLGEu4Rc17PBP9
 udK0a4kbsWl+B0HCCC8X1u/zqZJrcQFSf1xjoDXSWgvCkVKhdBsVh7B50G+9qsVBHXb0
 Ihv1iJvmIQ7FzuFWzztA6U+nel5rtVhJX8OME0ZPYnlKhHKqxWlb//Rn3Yw7vfK0UXtL
 jGRq/CGLSuOdCJDnVv3n2rpbsCG7+PlcnpSkYFF37RmnzbSEcQCMGxe3MsF23ZPnpFaN
 3YXvc4nw6CcZHbL6LSkP/XdhT22k99SKZBS0r6KGuly/GfCioNQ+0nAtPJuCmNRX/gLi
 nwIQ==
X-Gm-Message-State: AOJu0YzZsh6DeidWuc5Hwhbqr6REJlK74l/+Q2VfUCyhM9DcYtmycW63
 ebmB8GWAV3dl8m8JS48eIW3SZJR06w6TWmn4Tz0RhMc52qxjBgXOlJ29
X-Gm-Gg: AR+sD124Id4TArZDP7Cu4pkHk0ka+SFq6r+AivcuaVLpQJXYS6ututLOQAdBK9wk40q
 ZteL3yfpQRLhT478Abu4Od2nrqcs6CbMDZzF1A2O5whvtqs8TS1q4XCj8uuR07qKaRgdMqtsKIi
 gVbvW3akPlh5hukgVJYc8bAkVE/CTgctBJCt5eGjSwN3s8oPzd3WCmPNQtLHpQWVQv/4PyrGq7E
 zR8JPExVypMQAjmnnv1ZBCpuK2S7DNwnxXU5YSRlfFcjKd29bCNrNxxBALxe1yDsT50bV7KUbxQ
 +OPLcD03P8wSCbamEhHc0vdWDNfN95594k8bMkGfjPpP3nJg2+h8nioASzjPJxk9WEFQiM6/4nn
 i6o/LD0TBJVJRkj1/m2SN4vw8+mq9Ja50+wKNlXFc+2K63EjGxbtUV4EeD+ch9bcN/yGfjpZ58o
 nTpNylo383BBrfWRUPqeyesV1EWDbZpYCBGVxNgj1V7uujheyyufxn1ZTJKvXhiLWiS3KkHVudG
 3RRvcbh
X-Received: by 2002:a05:6102:3f55:b0:736:e4c0:cddf with SMTP id
 ada2fe7eead31-747534657damr8579782137.6.1784681245064; 
 Tue, 21 Jul 2026 17:47:25 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.222])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-74ad31c215bsm1346505137.2.2026.07.21.17.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 17:47:24 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v1 0/4] drm/xe: MCR semaphore and TLB invalidation timeout
 fixes for ARL
Date: Tue, 21 Jul 2026 21:46:50 -0300
Message-ID: <20260722004654.744249-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

This series addresses two issues observed on Arrow Lake laptops (two
ASUS Vivobook S 14 S3407CA units, Core Ultra 5 225H, iGPU 7d51/ARL-H
and 7dd1/ARL-P, GuC firmware 70.53.0), reproduced and bisected over
several weeks of daily use with instrumented kernels.

1) MCR steering semaphore held across resume (patches 1-2)

On s2idle resume the first MCR access finds STEER_SEMAPHORE still held
by firmware. The current code waits only 10us while spinning inside
the mcr_lock spinlock and then fires a WARN with a full backtrace:

  drm_WARN_ON_ONCE(ret == -110)
  WARNING: drivers/gpu/drm/xe/xe_gt_mcr.c:697 mcr_lock

Patch 1 ports the i915 MCR locking model: wait for the hardware
semaphore (up to 100ms, sleeping) before taking the software spinlock,
hold GT forcewake over the lock/steer/unlock cycle (Wa_22018931422),
and demote the WARN to a rate-limited GT error. Patch 2 ports
intel_gt_mcr_lock_sanitize() from i915, releasing an orphaned
semaphore at GT resume before the first MCR access.

Testing: before the fix the semaphore WARN fired on nearly every
s2idle resume. With patches 1-2, zero occurrences across dozens of
s2idle cycles (including several of 10+ hours) on both machines.

2) TLB invalidation fence timeouts / GuC ack latency (patches 3-4)

Under CPU load, TLB invalidation fences intermittently time out:

  TLB invalidation fence timeout, seqno=N recv=N-1

Instrumented kernels (logging the GT C-state at request and timeout
time, the G2H CTB occupancy at timeout time, and the ack arrival time)
show, across 26+ events on both machines:

  - the ack is not sitting unprocessed in the G2H CTB at timeout time
    (CTB head == tail, zero pending dwords), and
  - the GT C-state does not matter (events observed both with the GT
    parked in C6 the whole wait and, with forcewake artificially held,
    in C0 the whole wait), and
  - the ack arrives 5-475ms (median ~22ms) after the timeout handler
    runs, i.e. right after the handler's forced G2H drain and register
    traffic.

This looks like a GuC-side stall posting the ack (a separate report
with the full data is being prepared), but the host side can still be
made more robust: patch 3 fixes the timeout-recovery paths, which
flush a G2H worker that was possibly never queued (flush_work() on an
idle work item is a no-op, so a lost/coalesced GUC2HOST interrupt
turns the flush into a no-op too). Queueing the worker before flushing
guarantees the CTB is actually drained, and with it the fence-timeout
message becomes a reliable indicator of a genuine GuC-side stall.

Patch 4 (RFC) raises the driver-internal TLB invalidation deadline
from HZ/4 to HZ/2. All observed request-to-ack latencies cluster just
above the current 250ms deadline (2.5s only because the fence TDR
rounds up); HZ/2 keeps the WARN meaningful while not firing on
latencies the hardware demonstrably recovers from. This one is a
band-aid for the firmware behaviour above, hence RFC — happy to drop
it if the GuC stall gets fixed at the source.

Series based on drm-tip, compile-tested there; runtime testing was
done on 7.1.3 plus backports of these patches (kernel package
"linux71-comm" of the BigCommunity distribution, in daily use on both
machines).

Tales A. Mendonça (4):
  drm/xe/mcr: Keep GT forcewake during MCR steering
  drm/xe/mcr: Sanitize steering semaphore on GT resume
  drm/xe/guc/ct: Queue G2H worker before flushing it in timeout paths
  drm/xe: Raise hw_tlb_timeout to cover observed GuC ack latency

 drivers/gpu/drm/xe/xe_gt.c            |  7 +++
 drivers/gpu/drm/xe/xe_gt_mcr.c        | 90 ++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_gt_mcr.h        |  1 +
 drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++-
 drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  4 +-
 6 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.55.0

