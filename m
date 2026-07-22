Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A941C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF4610EFC4;
	Thu, 23 Jul 2026 07:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pvN8QaBF";
	dkim-atps=neutral
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCC210E3D4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:47:40 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-97723f98735so1320202241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784681259; x=1785286059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQODMN13qmDTEaPxJlH5XqI9VKI8Jhu1kZxKvHl9BvM=;
 b=pvN8QaBFrDOUCIDPipffBmqANc7P3JQQ0fbuoeqjTe4Lv+jHzrLrjgeJueGjG4hV+u
 awfmH7JDuxXe+IDh6JjfwHGVHRJ6jcTpcyglPczG/XY90iaMZxacAR4n0L2KFgRwX1tc
 MUhwzBn3KQ0ssgy90HsaPvW6XdNktymNpqjnNYaZfVarHus0fhOJETK2a2OH9fA6J1ZG
 xB9f2kuGqqp7Bc2hNaPivowzdgg0MBHhiCy02+2ZPyE9n+lFIyzaVWJkWn+pzRYiT8KI
 fvZzgSKdqDKOTAkIff+yZ4+daQHwzNGli6IJCvPs8HGF3LmOaeTsy1EszVqjb9qdiRny
 IE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784681259; x=1785286059;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQODMN13qmDTEaPxJlH5XqI9VKI8Jhu1kZxKvHl9BvM=;
 b=Vyj/C17kxu7zfsKbpIriUNBDl9SdU1uQpDPL3bIBCuuOUgSnWkhbDbQqqdO27+5la2
 E8iwFxpLc2yiN71VazEcTjyJ/nSStavZWDtQWvmLiqlFAYyD8ZKiE6hQKzCg9QPIkUth
 BASUWQRMVrM0/VPYgO0+31rC4X4A6txNYzWlgBqU5OBBLiv3nZ6czifuJo6vDrKUbLIk
 vitA9ynVPeFl6swsGUvIvEPVrSJF3iHWnHuG33q6Rs4UKaHlo+oqmh/1SCzk5Qgto/Uu
 1X9OPbXGwDXstRnqKExYpSktWMjKXw1rU4TWaY1UGcvVofUXxeieK91fiPIfeLPbjeJi
 HiHQ==
X-Gm-Message-State: AOJu0YzibKysQTQIHEggkaCAtCcLTk+ER8Rapjivdy1o5QViDGpJ7hZs
 HkBj/69NgdGD6B64EZB4kve7siHlnm4P4MkQ5PQujSnoAAm4iReLlYCYVs2IUg==
X-Gm-Gg: AR+sD11W8TGP2VMyLjTW6lYd/j9dYN7PhFOH6zUB9r/7hJI6DIQHvYxcBVrQbCUagO2
 tsE5bIaCRUt0rXzQPVoLtVogfWP12XWEKd9XFzU+yBf+EUeTm6J9gRdC7rQ1G0ZOp+2r0wzlxEX
 zvcBa1Ilv+IrZwGpVdVi8BcDQx01itpcN03qu/h0STEDPn3kTfgmeXm3XGHPzEoQ9ZtQDKs9TOP
 6AYwiaiOkX6YF6Woj+QNx+3EJkOwyinR17eANYU7FPZnGlokGkkRW+Fcv7eg4WCmMQHpiTGQt+7
 fK4jzb5GrINuLtcdQN6KOFECJh61MP1felIaMLAhujKpLxpVSObGN+uBqSXH7u6ErDJ8UEXjRY1
 SUo9qAl4wyjMImRvO9p/e83szqdTS+1GIFc+cNpOKaDqNJ2vcdbbk7pxRs5jUXn3DBaMolibk5k
 HdIKgFHY+V1OYtvvJN2/82dI3b4BPkf2pvKiTxYXp9efMnPt+9AhKDG6HrscRFHzusJET5uA==
X-Received: by 2002:a05:6102:5092:b0:631:4cda:3ebb with SMTP id
 ada2fe7eead31-7475370e8b5mr8061218137.24.1784681259146; 
 Tue, 21 Jul 2026 17:47:39 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.222])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-74ad31c215bsm1346505137.2.2026.07.21.17.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 17:47:38 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v1 4/4] drm/xe: Raise hw_tlb_timeout to cover observed GuC ack
 latency
Date: Tue, 21 Jul 2026 21:46:54 -0300
Message-ID: <20260722004654.744249-5-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722004654.744249-1-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
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

On ARL-H (Arrow Lake-H) under sustained load, TLB invalidation acks can
arrive slightly later than the current fence timeout budget:

  tlb_inval_timeout_delay() = hw_tlb_timeout (HZ/4)
                            + 2 * xe_guc_ct_queue_proc_time_jiffies()

which with the 4K H2G buffer works out to 2.25s. When that happens the
fence is force-signalled with -ETIME even though the invalidation
completes an instant later:

  xe 0000:00:02.0: [drm] *ERROR* TLB invalidation fence timeout,
      seqno=15519 recv=15518

Local instrumentation that records the request and timeout times of a
timed-out invalidation and logs the deltas when its ack finally lands
measured, over ~24h of heavy use (kernel builds, 3 VMs, browser; ~311k
invalidations at ~7.4/s):

  - 34 fence timeouts, every one followed by its ack
  - request-to-ack: 2254-2355 ms (mean 2306 ms)
  - timeout-to-ack: 2-59 ms (mean 25 ms)

i.e. the ack always arrives, and always within tens of milliseconds of
the deadline - there is no firmware stall (nothing arrives seconds
late). A prior change guaranteeing a G2H CTB drain in the timeout path
confirmed the acks are genuinely not yet delivered when the timeout
fires, ruling out lost interrupts or an unprocessed CTB entry.

Signalling -ETIME on an invalidation that completes ~25 ms later is
worse than waiting a little longer: waiters see a spurious error for an
operation that succeeds. Raise hw_tlb_timeout to HZ/2, extending the
budget to 2.5s, which covers the observed worst case (2.355s) with
~150 ms of margin and eliminated all spurious timeouts in testing on
this workload.

Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index 91960dc4ba9..c5ceac5ab86 100644
--- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
@@ -335,7 +335,7 @@ static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
 	struct xe_guc *guc = tlb_inval->private;
 
 	/* this reflects what HW/GuC needs to process TLB inv request */
-	const long hw_tlb_timeout = HZ / 4;
+	const long hw_tlb_timeout = HZ / 2;
 
 	/* this estimates actual delay caused by the CTB transport */
 	long delay = xe_guc_ct_queue_proc_time_jiffies(&guc->ct);
-- 
2.55.0

