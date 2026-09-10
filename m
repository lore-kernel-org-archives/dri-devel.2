Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8CC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4621410E280;
	Thu, 10 Sep 2026 09:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oK1H2GSa";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F07F8951B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:51:01 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d91ff7d9acso59652655ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789033861; x=1789638661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e0pNJdng574bxrNPyGtPZNhfKMoffShydr0b1ZjVxig=;
 b=oK1H2GSaKQhdNs9O1YZCmzrq5kwwbc0O+vwR4tGz+iT080ftiK99uhmiN/SIjrnoKi
 d3vnJKIRMA4JxNFKoU4g+2JC2PlP9Ax9NgdA57geX6nOLVc1XWfR8zyrknefCOvTbSQt
 vqkAs1ZD2aP8SgSc6qP6sHdLjvAscgNHKbwqXiaElqSYFMkvHGTg6WF8YC2eq10N7OBV
 wU5m9/+PTlfydPVFGJXKjMrXN4edjKfiWnMsFHpvfLk6LQs0+JkCDgkQIc1qbZbarBZZ
 mmv4/g54FjzWJAhsSjGTaARtKecnI3A4pJsdKqoieAFTGZk34wk9iZTwSbLHrYQU8KRa
 uaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789033861; x=1789638661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e0pNJdng574bxrNPyGtPZNhfKMoffShydr0b1ZjVxig=;
 b=VqzTbtLkscsk9/IR/ILL/5Z8FPZTA7EpQ3qzkmxFht8WXI/6HQ1Sw6KRPT92OPPai8
 xd15t4AbtMMoup5lg5jO/ugpHwm92CIBuw3+5LMtiY9Dhrsx6LrB0+qhrGxrM7U1YHU/
 ap6+kzAtC2uTkH8Uy3mczhdGJTzJmbV9sEkEGKU4P774J20dqYhUVACzBjhjSAX1EHXk
 +fXF0MpPJnDJRkzkk8gAw57FXcb/wIs3HgzJIMLvWXht1iJT08WCfn487bsEVHshsoFv
 B3uKdG6rZ5dY3YeGjE1tSV38X/EVFS6VVUbjLetZ3Sc1OLfkCUlnWC2UuX48hSYr+cUM
 pceA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOcWmImeAdNhtsA2R7L/rtaaJEAC1ky2xlDvCTTAtfJ/1kep9ubtOgsHrwBpfDrJAY2sjj7j2azXs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljYYV3oL5IXfZcya9sKhL8+jDXHzYVbYNsU7WUQII0ENGFDzeG
 6krlJVhvNUPCvxPbxLfK4EWk/lGqUeiQwvt7bqoVIG8nc9qbwTM45C0=
X-Gm-Gg: AYBFou32rvX2csV/dUhikk0JrBK38DmAvrMKGI+Ft/r3yarus5Q7PeJcTKxP2PxsrIQ
 2Usn23l6wqT+zwO/mDZYBX5UW/NSL3VkZMcCtqDsDDiLsqo70cKo6Tft/Kxhsf4z8q7zYc/M80L
 s9eVtj3mrYeEr6ABXdFcjK7Q+3HywME+cdSeBY7PjUOHRZkhFXni24CrNvWJt6Z7x26cNwXp0yF
 mp7CZKwSWwI3/H9KVJfesAK7MPu9FsbirRDGNNiAGgsqpeuqULx5eeAVm4HmguZVZA8/Q6z6hn5
 LaokexyLAx57GLkTXksUlZNBia0SES7Tf1IZ8OAh0BegYstGXPw0LRBHQAjrivY+aYTuyYaeAwv
 9iyZOPgDq2V1rjuvwZElIgeb/knoczZawmJY40+NSeRw/peANwyYZhTsP1sOdKbEWGRUSChdTQo
 4JsCuM+kmdZxgeqVJum6hJSrJw1+A9jtdjduV5wqtMEFpmvWVXTW6HYY78qxEiZOvdpZqnQRhXP
 Tv4S0qAB7OTGnh7fabFdHR4xA==
X-Received: by 2002:a17:902:f708:b0:2dc:fcfc:bdeb with SMTP id
 d9443c01a7336-2dcfcfcbefbmr143111565ad.22.1789033860582; 
 Thu, 10 Sep 2026 02:51:00 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm54346945ad.78.2026.09.10.02.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:50:59 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Philipp Stanner <phasta@mailbox.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
Date: Thu, 10 Sep 2026 18:50:53 +0900
Message-ID: <20260910095053.727808-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <608f03824420323f9c9d3bc29cfeb0bed714074e.camel@mailbox.org>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
 <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
 <608f03824420323f9c9d3bc29cfeb0bed714074e.camel@mailbox.org>
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

On 9/10/26 10:51, Philipp Stanner wrote:
> Which KUnit test case exactly?

A local one. It is not in the tree - I wrote it for this, which is why you
could not find it. I should have said that explicitly.

It is a mock scheduler whose run_job() returns a hardware fence that is
never signaled, so the timeout always fires. timedout_job() then sleeps
long enough for the test thread to get into drm_sched_fini(), and calls
drm_sched_increase_karma() on the way out.

> I kindly asked you to provide more details about how and where the bug
> occurs. Can you post a longer stacktrace and also run
> scrips/decode_stacktrace.sh on it?

drm-misc-next 0878e6053d01, x86_64, KUNIT + KASAN + lockdep, run through
decode_stacktrace.sh (dropping the "? " speculative frames and shortening
the source paths, otherwise as emitted):

BUG: KASAN: slab-use-after-free in _raw_spin_lock (kernel/locking/spinlock.c:173)
Read of size 1 at addr ffff88800198b420 by task kworker/0:2/27

CPU: 0 UID: 0 PID: 27 Comm: kworker/0:2 Tainted: G                 N  7.3.0-rc2-00228-g483f69ec8ca2-dirty #7 PREEMPT(lazy)
Workqueue: events drm_sched_job_timedout
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:595)
 __kasan_check_byte (mm/kasan/common.c:574)
 lock_acquire (kernel/locking/lockdep.c:5916 kernel/locking/lockdep.c:5899)
 _raw_spin_lock (kernel/locking/spinlock.c:173)
 drm_sched_increase_karma (drivers/gpu/drm/scheduler/sched_main.c:1263)
 fini_uaf_timedout_job (drivers/gpu/drm/scheduler/tests/tests_fini_uaf.c:99)
 drm_sched_job_timedout (drivers/gpu/drm/scheduler/sched_main.c:355)
 process_one_work (kernel/workqueue.c:3396)
 worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>

Allocated by task 28:
 __kmalloc_cache_noprof (mm/slub.c:5563)
 drm_sched_init (drivers/gpu/drm/scheduler/sched_main.c:1148)
 drm_sched_fini_frees_rq_before_tdr (drivers/gpu/drm/scheduler/tests/tests_fini_uaf.c:140)
 kunit_try_run_case (lib/kunit/test.c:454 lib/kunit/test.c:499)

Freed by task 28:
 kfree (mm/slub.c:6792)
 drm_sched_fini (drivers/gpu/drm/scheduler/sched_main.c:1214)
 drm_sched_fini_frees_rq_before_tdr (drivers/gpu/drm/scheduler/tests/tests_fini_uaf.c:167)
 kunit_try_run_case (lib/kunit/test.c:454 lib/kunit/test.c:499)

The buggy address belongs to the object at ffff88800198b400
which belongs to the cache kmalloc-128 of size 128
The buggy address is located 32 bytes inside of
freed 128-byte region [ffff88800198b400, ffff88800198b480)

sched_main.c:1148 is sched->sched_rq[i] = kzalloc_obj(*sched->sched_rq[i])
in drm_sched_init(), :1214 is kfree(sched->sched_rq[i]) in
drm_sched_fini(), and :1263 is spin_lock(&rq->lock) in
drm_sched_increase_karma(). Task 28 is the thread in drm_sched_fini();
the reader is the timeout worker on PID 27. The tree is -dirty because the
test case is added to it. I hope this is what you asked for - say the word
if you want the untrimmed log.

> If the bug only exists because someone does not signal all hardware-
> fences (that's what we call the ones returned from run_job()), then I
> tend to think that this is not a scheduler bug.

Agreed.

> Though for robustness reasons we _could_ nevertheless stop the timeout
> work item before releasing other resources.

Right, that's what my patch does: drm_sched_wqueue_stop(), then
cancel_delayed_work_sync(&sched->work_tdr), then the frees. The report is
gone and nothing else in the suite fails.

As you say, that is closer to a cleanup - or to making the teardown order
state its intent - than to a fix. Do you still want the reordering patch?

Regards,
Donggeun
