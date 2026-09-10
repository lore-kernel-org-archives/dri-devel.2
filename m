Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52378C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FF910F410;
	Thu, 10 Sep 2026 10:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTQJo7WZ";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAB010E0A3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:12:58 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed9866so9878845ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789017178; x=1789621978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vWZ9MY/he+iOdU7sp8KwPR4BW00q3+d2WWzt1qSCeEs=;
 b=bTQJo7WZQQnlEdLrSaxs7lviklfYTnXoUXWGeEodC77Sj0jA/tTCSxAyOK8W7EL9bn
 5fWbGMbs4Ryq3I/ZoDMFN0TG32A1k/PI+z/CJcIlpA6Zgk4w7gQBR7/c4aB1pOJQ1rET
 u4uPo/PrfFoufK/wYLBwSmpLnllaCQqz+n3tO2gR59MPvVH+mZXXRd3MIf5N72YMU6vf
 eCMmK35vdpHnHaeIgxIE1cAPmsWlkcbznL+IAWgj5kKaxyPnonO1koE3vdFkGcp1Ga3R
 gY8oHK5lB+k4rFAtXvhRfhgjFlg2iYv8FHK33lE4SxGUa0QYogHm/cclVP4ZdLQMI9gW
 6SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789017178; x=1789621978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vWZ9MY/he+iOdU7sp8KwPR4BW00q3+d2WWzt1qSCeEs=;
 b=i9GkVjxk6xqagl67L8mkiXoK5G9hWbLkgjU+aI1sJpgOXO/sK32JHAMhl32dCJCBC6
 VfxFaUs2Do3kYp/SOJ3mEXkwcly3bmVkP472KDvPr0dZ0QU9nbUhgibrMqZ4nZE6vwsk
 bZej2GqgkFtl5mHoPs2wKEHRhBx5b7MTLUl4CNgxzoXpseGV13DHGxTqGTxM5Loh0/1i
 8WnV71BKrUbCZMRmEgjJaqrJjkNOoL55VXQxrCsNaWb1UY1hLb3h3WFezBJeSN3S5vvg
 rKShjkjGpKIBP2QmA7wGvmsWjMbLHc/O/KOH7uCYdSQ+5jXrvemQfMU+Sut7ISSr8kJz
 eXJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyGIjqoCK0bGuFN2APB7COdj8BtknvJX36mjBX0J3v0x9zhR37Wsc0+xfEn63sVpbLScOGoXuDJbY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nBweVq9Bbi1lLoqT9YuBEZLePEJIG+vEQzwp/bhDPgdSC3dvIe
 m3dM/0D3zISlaGJzYnVF6Qn6zsIjCQ/3sRDjTDE1neTJ16Bh3993pms=
X-Gm-Gg: AYBFou0pzHcy9f0pxNga3q42LQJ5/bbN+VRt3qfKm1gNmG+G2HREXN9asxfOUo6V1M0
 /X7AlLBAYKdKx8PZJ9pWz1XuhmGqDShRDWKFU/2icx+RcFaepyWfOEVbLaIFb69lVWJeFDLmIJE
 nKV5CAEK1D08tfccZESKAMVhxMKg6pjYAuDxKfwSpd42D0N71Kk0+TeCL23JLUxdOGN0WmpoSbd
 /n0FoGpxNuSXOU2P6TtUijGN95gQEp78LaZzDImr1IdEaEgyk/QA8/5hnsjJKivYqurn8tsm3i7
 XF22aYfxWB+w/anZ9soXFSW4AMubi6AI4xOAY2BA/mCATHz7EvBdaGwOhaGAZznRos95vzKqcWj
 NHB4SRNkMoFRKW6dwbhfzNA4w/jd2/Vpgr6GFqNg3IAsiG7UfRSapR4ptZoP1YzWOz73lk0jh3r
 pBSU9ljJvrSXetwS5gSrrYKA1R24QLFF88+k05P0425VgBDrJYBfhR1cLB6PP2Jdt6hw7iaIiEE
 iPzpPcKNhk8LVInT0N4xdzlUw==
X-Received: by 2002:a17:90b:1a86:b0:398:ba96:1afd with SMTP id
 98e67ed59e1d1-39d709dfda5mr7432511a91.8.1789017176754; 
 Wed, 09 Sep 2026 22:12:56 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e776192sm1972397a91.4.2026.09.09.22.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:12:55 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 donggeunyoo.kernel@gmail.com
Subject: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
Date: Thu, 10 Sep 2026 14:12:49 +0900
Message-ID: <20260910051249.625794-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Thanks,
Donggeun
