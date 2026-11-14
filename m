Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F4606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xBq0VdF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF66B10F04E;
	Sat, 14 Nov 2026 16:25:32 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CFA10E090
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 15:36:37 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36ca32a0faeso217759eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794670597; x=1795275397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dcf1VprQ5tReiauPDZRL2T+Bt75/dPprqyKIItbhiW4=;
 b=0xBq0VdFe2edgng+skJNh752B/lbS3WTlPAIPU+aeZl3WqZtHlsW3np+Y9WidHXpco
 phmTTkVxEmmnd/o7Yhzt6LeyPdFjubqwFNBL8wHowVkXWpQk5css1lS97zosAf4fMMQr
 yYJEBYM1HehzwZRZqFTCj64gYBmsxRDRx/NTmPrAeEc5d5es99hTF77xkx90t+7lqEgW
 WvM7Qd1ulqoPWpaUOSxEiGedFSQv+FUMnaPROf1v7khnmpOeXiL1G1Kzn0L4JKfixZTL
 53nao7ahB9n8prg9KDTxV3gkAWccireCWpYq/jNJUP0i4pvgC3DothzJAPLrjEY8fe3k
 pw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794670597; x=1795275397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dcf1VprQ5tReiauPDZRL2T+Bt75/dPprqyKIItbhiW4=;
 b=V7+ehpkSSNNsnjoJUQA1qwfkPOxmLjLhv53xZ4FNrjzEOr0/j6BNuAakZ4PiRDFDaS
 Yh7j7MCnKO+9qZbQE0qef/8HB28uR6q+kRKTrfiY1FUN2UAndnhT0aI/t2HzH8VLnL2m
 3Qr8X0eS6w5I7rO/KnVlXRn9HWjwUnBCtwHRgWAE5BiO8GgqnsLGZOsm09JVZODNM88J
 p6rjVIPjuPVKGye9f0Ge/lFdIOgd70Yp1GNkzphzK96txBCpcW6PoMEnMjDUuAjEmlOp
 gXNHYd4BUQGL0eCykjoZT/8CSV3VTskkljt0XHhfiBA8BTiG6qH143pJ0bEkU7Cj4+Kw
 VsSA==
X-Forwarded-Encrypted: i=1;
 AL+hErHOwAx1DXqmmryrXdCBUN3MZXN2ZawDrie2OD5S89CLntSLWwvCUAsCOQHzXpYcvSXiO8QiYWsfbGU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/37wcSgiQuSY4fB5ZpxuxwDM2dEXgvjRcqwrGrXeu9NYLkIJQ4
 TJsc7CusNOYjpKKmw5vKj5URkXa2ulpfYKHYIfwe4mRCCY5qR6wfa82o
X-Gm-Gg: AYBFou241lnSTJrHX9vAXeCEST8BUJJs8e0k0fqVRafcL+dSJ6cv2qZn5C8XBqKIgKk
 QEvrEgIwNB2u4Ukz2JcS8qzH0WC1laz7naftDKtMG7dAp4OIEqpaiNoEDPJfqUQ2OAXm9vhL7Fy
 QuIFwrtYDlEABe0yoAOTwF6GhdspMu8bIJRAPHFkRGwMukSVAF/zotqsRtW9qGGqd8hstFuj0ro
 hKZjc3jDUW3qkKyWyVrvPLsTmjtxQZZnnvsA5DmuBeGVp5NpYzFbRqV8mnSBLCEVagcv6mcZ3qh
 5x4lZ2BMkhc9IEp9/EiRpYWz3tkIRFr+ZjC5SZiYtWD6R8p/HPY3AT9fhNMpKz4hWOSc9TLcSCv
 tri/Rc7/9LlXOi/yssUo11Bs60rVxvA78nq3YTBGs+zJBNbu4pVPBg3urNdyYR0dYctSswau4Ui
 5snZOFL99Ine0faj/oVZ0Ee/sZYmCp8GEVeS0xKnr7BCbk+oLrYuOKM4xFSWYpxvPTuSNsX6c9y
 B2kfRlSaBWGBWVOTG9V02hZOcxg05dkHeVGX83pjzBlh8z5NZ0O5RFULWRa/NgWWhEo+UwamoEO
 mG0z1ePu4/LnW2CLjZG9EWCwn0Rk2jOyymtFl5MSKUZEIY3WO7qPdaNLhT3r6CJtic/ICXtzWmU
 83ns=
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-379652f16f8mr8568423eec.2.1794670596552; 
 Sat, 14 Nov 2026 07:36:36 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379508762a5sm17527126eec.0.2026.11.14.07.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:36:35 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job,
 queue and entity lifetimes
Date: Sun, 15 Nov 2026 00:36:22 +0900
Message-ID: <20261114153622.148125-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
References: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 7:03 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> msm_gem_vm_close() waits on vm->last_fence which will be signaled
> after msm_vma_job_run() returns.

vm->last_fence only collects the fences of GEM_SUBMIT jobs, in
submit_attach_object_fences(). VM_BIND jobs don't add theirs, so
msm_gem_vm_close() waits for a VM_BIND job only if a submit depends
on it.

> My expectation is that if thread A is in midst of a VM_BIND ioctl,
> perhaps not having created/updated last_fence yet, while thread B is
> racing it closing the device fd, that file_operations::release will be
> called after thread A's ioctl call returns.  Is this not the case?

It is the case. (The vm_bind_closed check in patch 2 is only for
MSM_SUBMITQUEUE_CLOSE, which can race with a VM_BIND ioctl on the same
queue in another thread.)

The problem is a job that the ioctl has already pushed and that is
still waiting for its in-fence, e.g. one from another device or
drm_file, when the file is released:

- If the queue was closed with MSM_SUBMITQUEUE_CLOSE first,
  msm_submitqueue_close() no longer sees it, and nothing waits for the
  job. Otherwise drm_sched_entity_flush() waits at most
  MAX_WAIT_SCHED_ENTITY_Q_EMPTY for an exiting task, and kills the
  remaining jobs only on SIGKILL. Either way, the job's reference
  keeps the queue, and so the entity in it, alive.
- msm_gem_vm_close() then calls drm_sched_fini() on vm->sched, which
  frees the run queue that the entity still points to.
- When the in-fence signals, drm_sched_entity_wakeup(), which the
  scheduler registered on it, uses entity->rq->sched;
  drm_sched_entity_kill() leaves that callback in place. A killed job
  is freed then too, and the final put of the queue calls
  drm_sched_entity_destroy(), whose flush reads entity->rq->sched
  again.

Patch 2 destroys a VM_BIND queue's entity when the queue is closed,
by MSM_SUBMITQUEUE_CLOSE or on file close, so always before
msm_gem_vm_close() tears the scheduler down.

This comes from code review (see the note in the patches), and I have
not reproduced it.

v3 is at
https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
and its patch 2 is unchanged from v2.

Separately, Sashiko's review of v3 found an ordering problem that
predates this series: the VM_BIND queues of a VM update the VM's VMAs
at ioctl time, but their pgtable updates are not ordered across
queues, so an unmap can reach the pgtables before the map it undoes.
That does not need a queue to be closed, but v3 patch 1 adds another
way to get there: the unmaps it applies when freeing a killed job are
not ordered against other queues either. (Its other point, that a
killed job's fence signals before those unmaps are applied, I'll
address in v4 as well.)

For v4 I would make a job that unmaps a VMA wait for the job that maps
it. The other way round, a map that overtakes an unmap of the same
range fails or gets undone, which breaks that VM but doesn't leave
freed pages mapped. Ordering all VM_BIND jobs of a VM would be
simpler, but turnip uses one VM_BIND queue per device plus one per
Vulkan queue. Would that be the right direction?

Thanks,
Jiwoo Kim
