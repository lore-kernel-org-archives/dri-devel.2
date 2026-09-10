Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9370C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 05:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B1210F16F;
	Thu, 10 Sep 2026 05:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vi7Ey26v";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC8010F16F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:46:12 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc439bfb2d8so4418571a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019172; x=1789623972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lE5bmYQSEcccsYl1AnANvihWUXVywi9TBbBYgSROwSo=;
 b=Vi7Ey26vZcf1ghLbGCV4N0H2e65XoUs6flTICc2Bop4AL0QjQu5VnFrMwSwg/djM9s
 9r4DUblYRDTkONQYYc56DhnuaXioms4jTYc2gPrmf9QB+82bI8klH2ukQ2KE2TH5rgxy
 JDlfydHQeFbKr1D55Etb4dXJg2qBkLuDRLZhq+OApNfsb+b/ICzdAdEBBTz36RpKrIAk
 m3b3CwTOlQK3X+TAaQvpXtHGyFlU2xnMCDahMDhg8TskwnwTNP6OGr4DcwhsIYpE6dSp
 8leF6Kd2UCHyExLmSkRDdDFIlJcb/XbVA6L4YOY502Y4st6oy/TAdMPUDV0EijtaOz1B
 i34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019172; x=1789623972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lE5bmYQSEcccsYl1AnANvihWUXVywi9TBbBYgSROwSo=;
 b=UHTdQ0RGSgaP3BvEhHAGKDb0S0GV98Y4lF7bukYMGbz2xZP2Zv9EFPasrkWUgMDD3L
 OdIXnGZmEH0WhAbdODJarZNhJMJUrzKwB/U8Zzr+G9lZDA3yzJ0N+rowU22HXyY6MVD3
 EtXEfs+dMrKzNguC82wURsgppZyR7/AsoALf1fpb8cjd/EISE6tZ7xzfV9NQkoxOPEr2
 1GGJVEHO+yPfkSETmUuGz7tIu1ykJresOfDIDx46GED6t82Tj9j//QAZxsfduO0wLNVx
 V+3SD7xaRPtTTRtyBP9KL0611lBD8TuozMnQiXj1McNJwJ02coD/L3ln2vVOslQLIsjS
 neuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoQfWTEdbMsdQ5Q1KUi8S3wB7NJuZ/Zsjrxa6XibS9dz3gPMlPLxOrU0GGNxvXIutcOjAhyrMAfkg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n4EvuoWu/Mb1JlqPHmjvTf3QMQ/BWgGHmUpn5NqlUPOw6hUkb2
 Io0NMNzY4NCQZ8m1qxL4Jn6cxw4jpDVW0ddCXgie3RmRCxh8rpWVgn4=
X-Gm-Gg: AYBFou3HZCLuFygoQbUD2VTA73Og52UKChgASFQ8xWm+2pbGWql2GZMnv1HgaZ4MePh
 luBw2a4wIP04kN3ppN/+XIcxLrfw9WRsvPeXn39B4qT4LqGEsFgnmuCjPRa23gWUv9RdCpqlgrV
 Ydeid17WJ/oF9GETJeRa1Q42wc6/p4CnrCibQvN4qYSMMeai3HbEbr/S4mfCKaSR3o+Zl3CenNG
 K4i2kPKO+1MvXgodNXOHrW6n5QZnBgN/L8kr20mYJYV07qM/Pv/4eF1YbT1BfjAbnnCbBDJVsi0
 8ukBHNY7er6rO06uDTKo+rr7G2/8okGXCrXhw8LoBWeBqA2eay7frzvfHzj8siuHJnrQHCHgkhF
 98SjI4PCwRPzLZ282LPlzzd7MzygNadc/lIx5IWgVeccmtYv5XztIaRAEcy1GaZth74hLuviBjq
 Wsrse5GXPNxtckhAK7CgIFs3VhrAk21dfLEgfawEMVs+jWICjaCg8xVuuhCC4jvGahSy1gfubWO
 r28h8tNLxbckCcuelOgxNljsw==
X-Received: by 2002:a05:6a21:6487:b0:3d4:52bd:b89d with SMTP id
 adf61e73a8af0-3da3a0b2671mr57967347637.23.1789019171857; 
 Wed, 09 Sep 2026 22:46:11 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455451b46sm7572279a12.18.2026.09.09.22.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:46:11 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, donggeunyoo.kernel@gmail.com
Subject: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
Date: Thu, 10 Sep 2026 14:46:05 +0900
Message-ID: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Hi Philipp,

drm_sched_fini() frees the run queues above the two steps that wait for
users of them:

	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
		kfree(sched->sched_rq[i]);

	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
	wake_up_all(&sched->job_scheduled);

	/* Confirm no work left behind accessing device structures */
	cancel_delayed_work_sync(&sched->work_tdr);

4827d6d83f07 ("drm/sched: Remove racy hack from drm_sched_fini()") did not
change that ordering - the kfree() was above the wakeup before it as well,
and has been since 56e449603f0a ("drm/sched: Convert the GPU scheduler to
variable number of run-queues") made the run queues separately allocated.
But with the loop body gone there no longer seems to be anything holding
the free up there.

A KUnit case that keeps the TDR inside timedout_job() while drm_sched_fini()
runs, with the callback calling drm_sched_increase_karma() as amdgpu does:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2b/0x40
  Workqueue: events drm_sched_job_timedout
   drm_sched_increase_karma+0x138/0x3e0
   fini_uaf_timedout_job+0x4c/0x140
   drm_sched_job_timedout+0x1b4/0x620
  allocated by drm_sched_init+0x49c, freed by drm_sched_fini+0xec

Moving the loop down beside kfree(sched->sched_rq) silences it, and nothing
between the two positions reads the run queues. Is that the right fix, or is
the intended rule that the TDR can never still be running at that point?

Resent: the original did not reach dri-devel - I was not subscribed at the
time. Apologies to those seeing it twice.

Thanks,
Donggeun
