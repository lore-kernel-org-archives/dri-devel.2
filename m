Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B04CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CDE10E682;
	Fri,  5 Jun 2026 16:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mc+3rdGX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9943310E67C
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hnvvVCR0Enh2ELAD0tJBh2ZERdurc9FCrV3pmCIwm/k=; b=mc+3rdGXxAJIsuvZ6HGl+65iKQ
 R9OMwGNEVSeE0uBOKFqETvtGZ42xkm3sYfRg+43vOSjEF3a7Wo4RO0Y/cqr7rIdbLTSVQEYz2eJC6
 dwre9nM9HUr7VEoQbed55cO/23As9505tm1pnzs9JuC064gaVRBmxokdXC2N94SRFjc4pHcRHCven
 X2BRCo97sFqBC8K1jPqgpgaUp0Kx29gx4XG+Jb+gJ1srlMcOtxNsAoPb+M2+lnMYGTD4o59xWbvj1
 SiEbLkQrlbxOPtkx/NYvMh826EiGA2a7tWc7T63hgC+hWvGv9AALTdw6BeAMG9GZCrylvNn7swVg5
 1GXNKEXA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVX4g-00DGUE-9P; Fri, 05 Jun 2026 18:07:10 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/3] drm/rocket: Stop submitting hardware work from the IRQ
 handler
Date: Fri, 05 Jun 2026 13:06:57 -0300
Message-Id: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxG4atI1gZqQYtzlcGF1d8xClYSEUG8u
 2WW3+K9mwwqMPoUNylOMUlbRlUWNMz99gPLmE3e+cY1rmZNw4qDdygfva28pGgcQxumAB8rtJT
 TXTHJ9d9+u+d5ATcKklBmAAAA
X-Change-ID: 20260605-rocket-per-task-jobs-b797f7e2b1e9
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Rob Herring <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=+dLReW5bN4H+/8BZC8wvlrX/SjLQGuusaGgUYXvzkUA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIvQlnMfoVghNH8tOGO8dns3YbX3rUwTBVMBo6
 czFolzBWUaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiL0JQAKCRA/8w6Kdoj6
 qvoiCAC3+/8KRElL/aApyXarq5xGHmGwspnwMXgShXS32cBSrEKOEgLOa/rGqdbWpChk+Do/rye
 DQDgBuLqo9hhTyWQEEPzZDbo9AAX80f2mlfNHQaqoHq992gaVed660jp+OvuGKiv/CbLgjvwADS
 qnBsoc9pRQ5dbL61H3mBXUfiX28u4dOhwxUKnUIDMECbQccDeQ0Ut5WAqUTvU+se+wykNxNtkee
 Y/D5BfgEU9VdgxOW4fWQs12o9OlSbIV6G+tGM3Nv8qjQGAXdbuC9hu/wVZlJTmmTNTZ4A9rEyt1
 lBAIqkt23t+GCXrk43wBM+m2DRZK+nfDS7CIuLCPKTn3qyxA
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

After Rob mentioned to me that Rocket could have a similar redundant
job_lock just like Ethos [1], I decided to take a look at the driver to
see if we could remove this lock. However, as I was reading the code, I
identified that, more than the job_lock, the issue is a bit different. The
job submission procedure in Rocket breaks the DRM scheduler's design in a
fundamental way.

Currently, a job spawns further hardware work from outside the scheduler.
The function rocket_job_run() submits only the first task of an inference;
every subsequent task is submitted by the threaded IRQ handler, which calls
rocket_job_hw_submit() directly.

The scheduler expects all of a job's hardware submission to happen in
run_job(). Submitting jobs from the IRQ handler instead is completely
invisible to the scheduler, which can cause some issues, like:
drm_sched_stop() only synchronizes the scheduler's workqueue, not the IRQ,
so the reset path races these IRQ-driven submissions. This creates the need
of a job_lock mutex and the reset.pending flag, which exist only as a
workaround to that self-inflicted race.

Considering the current status of the driver, solving this issue is quite
simple: don't consider the whole submission as a DRM sched job, instead
consider a task a DRM sched job. With that, the driver can comply to the
DRM scheduler expectations and get rid of some locks, flags and indexes.

Having said that, this is only "compile-tested", I don't have this
hardware. I was just driven by Rob's comment to take a look at Rocket's
code and the design looked unusual to what I would expect from a DRM
scheduler-based driver. I'm also CCing some scheduler maintainers to check
if they agree that the IRQ handler shouldn't spawn further HW work.

Apart from that, this series also has some clean-up patches.

[1] https://lore.kernel.org/dri-devel/20260516144623.2582427-2-mcanal@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (3):
      drm/rocket: Remove unused reset worker
      drm/rocket: Submit one drm_sched_job per task
      drm/rocket: Drop the dedicated reset workqueue

 drivers/accel/rocket/rocket_core.h |  10 +-
 drivers/accel/rocket/rocket_job.c  | 282 ++++++++++++++++++-------------------
 drivers/accel/rocket/rocket_job.h  |  26 +++-
 3 files changed, 159 insertions(+), 159 deletions(-)
---
base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
change-id: 20260605-rocket-per-task-jobs-b797f7e2b1e9

