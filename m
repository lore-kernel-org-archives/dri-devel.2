Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A905606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urnxwq5n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B4C10E15E;
	Wed, 18 Nov 2026 02:07:32 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CC710E54B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:07:27 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-376a4059061so58312eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794967646; x=1795572446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i45bHZiP3wEgcVETQzoa65BO2wkAbHlegiGhDqMSTjc=;
 b=urnxwq5nHL/axMyLiEyRISKlypD+UrT8oM7Ni1tEKXoy/h+xvJzPFdx7GyHwQXPABZ
 loRXa/Mk2lrg7asbYDft9paUq3ArH0d4F1BUxVPjBHepMSza8AGZKKR8+pTeBsfl3F6v
 PYhY3KX3/u0Z8bY+gkHs3u0GZ6M7Yl5KCCbfj6P0a24kmGdTd4BgRN9goCvsRKjZKXTP
 Dgpln7Ue2jfIzApK3GOs6BQS4methlB9pLUr8qdJJcbKji850MCkrSgv1dngx+r/8fFN
 cOycbNpeWw2iZJ0aMdi5BgZdlCOGwSNuLzHaQDJMWZfVmG6Ry6sy1uddzEgio4YE7wn2
 3T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967646; x=1795572446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i45bHZiP3wEgcVETQzoa65BO2wkAbHlegiGhDqMSTjc=;
 b=UBbRwh3pX+sq00D809RoR8mOTwNl/coWLPxbMLM3UHItRisCq/wNXdS/163oa3Dd/2
 9sWnAsy/ianjWujuML37glce6I8IUdiXXsoNF6WPcC0/MTFPFanOphlUhKPpJqxgDfGj
 9iLAcO7DLEE3aXScohcA9aYyEYI0qg1BSFxbVlf+w79cLM8byYzsNDq/c7nB2LHeQrtc
 mfhf2XyZ0lBD8RTS9AaP/7cMHkHc1/KoyBPfy57ACWvaeRJz2ZuBXuS7ZQh2qkpV+U/p
 eTvMN+XSRf+vPT1OI49ObzxJOqMRQYgxnWOaOuo4Z7R6WoWMbWimdmhlwxGovAlsiREd
 verg==
X-Forwarded-Encrypted: i=1;
 AL+hErFiIPhKfSzooPxLZnPf5c/w7wkTwcDf47xzCE62/FKJb8ReNFBBq9UDJPUMnfQnIie0w4kalqegEtw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kLbBaM2oFnnyD+8zQV+TeDSKFu8NOJCYjIuMt4vQxnXpdaWSP
 KRmnk2o3KoSvcXyJpZn2hxzXUmt7MhR4/xP1ySueIWFa7lLYj3L/47il
X-Gm-Gg: AYBFou1BAYbjeYVe7i8s4pvRJyl0DwuVaCQGVRi4MdjmP9V3nZDOojRpO8hzTa8QXrl
 8tkq4qSoIGZjx3awOHRXsPPAGFfoLD7FDeflfpHREU99GWvuWmiBonlJGKljqbz4WxHNpF1RhdX
 JbA4QCvyArQGEeszG9i1H8vvheJwYHLpX3+kCOGjLLzDsoL6co0Gsh6k7NAOTCreSBcANkFe176
 d02w+MOwECfbi4tDw7MlcqL1BiyVxS5hr4NkOgQOuwvKyZrcWsVg8rsOq9SC+kuYvHRw3p6sFUg
 SbRpCfJGZLMO9VShHCYrQTMFziAbrK+RuKZeurO99id17pY3b055U/eY4DjqE77y2DMrJEgDvsg
 HV88vPlcL55ga6Z3BjFDIH4O2K3aHSDDAfE/m96E4q30GYGsosx5tcAGq9vOZXXuovwwSNyuRVM
 0n0wkTEnSl5ibh2cZX7Tbqg0Ib5UIHN/eHHREyusQQCqVDI5aPzSGv9pziR9M0R45BDtXAJvEle
 7OQBpBfd0skpp3vLjViWhuH21kbBR7CEnAesSUPnybOjZzC2ok982+umZJ3VBQ7jydXM6+SHdhb
 5efgMlziGaz5HaD+CPV7a02VAeoD+3CZk5NzkAD322ui/Nr/6sUlBwrB6H68jLwbxQ8LyUidd0L
 nPMlDSW8=
X-Received: by 2002:a05:701a:cc8f:20b0:1b5:4596:8371 with SMTP id
 a92af1059eb24-1b54596847cmr617949c88.0.1794967645989; 
 Tue, 17 Nov 2026 18:07:25 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:07:25 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v4 0/5] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Wed, 18 Nov 2026 11:07:11 +0900
Message-ID: <20261118020716.1698-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These fix what happens to VM_BIND jobs, queues and entities when the
file or a VM_BIND queue is closed while jobs are still pending, and
make the VM unusable when VM_BIND jobs of different queues apply an
unmap before the map that it undoes.

Patch 1 makes msm_gem_vm_close() wait for VM_BIND jobs, as it does for
submits. Patch 2 handles an unmap that finds part of its range not
mapped, or that comes before the map it undoes, like a failed map.
Patch 3 makes a VM_BIND job that the scheduler kills before it runs
apply its queued unmaps before it drops its references to the unmapped
objects, release its BO pins, and mark the VM unusable.
Patch 4 destroys the VM_BIND entity when its queue is closed, instead
of on the final put, which can come after the VM's scheduler has been
torn down. Patch 5 puts the queue last when a job is freed, as the
queue may hold the last reference to the VM.

Changes in v4:
- New patch 1, as Rob suggested: VM_BIND jobs add their fences to
  vm->last_fence, keeping the previous fence if the merge fails. Patch
  4 is still needed for killed jobs, which the scheduler frees only
  after it has signalled their fences.
- New patch 2, for the ordering problem across VM_BIND queues that
  Sashiko found in v3 patch 2, and that v3 patch 1 also made reachable
  through killed jobs. Unmap errors are now handled like map errors, as
  Rob suggested, and so is an unmap that comes before the map it undoes.
  A job that fails in the ioctl after updating the VMAs now marks the
  VM unusable as well.
- Patch 3 (v3 patch 1): uses the checks of patch 2, and describes the
  window that Sashiko pointed out in v3, where a job that waits for a
  killed job applies its updates before the killed job's unmaps.
- Patch 4 (v3 patch 2): changelog updated for patch 1, and a second
  Fixes tag, for the commit that added VM_BIND jobs.

Changes in v3:
- Patch 1: only apply the queued ops of a job that the scheduler frees
  after killing it, once its dependencies and the previous job of its
  entity are done. The error path of msm_ioctl_vm_bind() frees the job
  right away, so v2 could apply its unmaps too early and out of order
  (Sashiko). That path is left as it is in mainline, and the title now
  says which jobs the patch is about.
- Patch 3: rebased on patch 1, title adjusted.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

Review of v2 by Rob:
https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com

v3: https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
v2: https://lore.kernel.org/r/20261114081902.1669-1-arpe1618@gmail.com
v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (5):
  drm/msm: Wait for VM_BIND jobs in msm_gem_vm_close()
  drm/msm: Mark the VM unusable on out-of-order VM_BIND unmaps
  drm/msm: Release the pins and ops of a killed VM_BIND job
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job

 drivers/gpu/drm/msm/msm_gem.h         |   7 +
 drivers/gpu/drm/msm/msm_gem_vma.c     | 242 ++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.h         |   6 +
 drivers/gpu/drm/msm/msm_submitqueue.c |  50 ++++--
 4 files changed, 272 insertions(+), 33 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

