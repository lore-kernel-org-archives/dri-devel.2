Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DD606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmM8JJqa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B590D10EB89;
	Mon, 16 Nov 2026 08:58:47 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A0F10E139
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:18:03 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36d1b3b9974so168438eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794676683; x=1795281483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4oitWDULEpM5/hVJgOh4m6V8xx8F+2jtGn7i+dhJCug=;
 b=lmM8JJqaCYVbMf+UIRYdrbkWNXictWwF0SawMgYxXK7fB/H5QtdJzwJzKEOlvVGzVT
 jqIWdM0hM512n3C753TPEh0Z8nxUUI2w6pUWGlyf9NjqBVHeWG14C4WsJpgepZHiXWX7
 n7VVQtK7LqIEhVuP42N7mB6GhukVVGAH28hVsAHWrYdTNmScuFYhy1NJ8Hd3sbHYFZQE
 duWLLw2QwmCz4ptQSR0R/LqeSwAEVqg2/APC8nsnq1eYXgpDcYjyTRqmKPfH9muHkhoX
 Fa8bR3k9DCnVOZ9v6wm0BAB0MAs4m/DmapPzGBBPinF6lJa5jV2UFhaehh6M7JiUMfty
 0T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794676683; x=1795281483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4oitWDULEpM5/hVJgOh4m6V8xx8F+2jtGn7i+dhJCug=;
 b=lJbJsaKk+ibFdCcuspWjaIppcWoTKknv2/hQuH4KYxo0gJv7UHjIObj3QztKeiVaHr
 gEAYOXWA6EbuO6g+iwWneMe6Hal15LaNC7sW/S7P0ZQRitmQt4G70dkpw3P0OCJtY9Cs
 4ui592JM7MiOF4Gj0vUCh1/PzSBm3vlJetF97ud3iGdHOe5I0rPAv36LVBqVteEuTiwy
 HKUPA4GgMiQAJJuC4RGJ8HFXEztbKCNkbOYL1GxSFzhg6npGctct01ACaGWEoAGKReSs
 IvyuBjbxyuQkGPTh1TLOJG1rxpEazl7OAyd5xtekNkmbBM7f3+FMTbfLIHLmYKLST1L6
 qvig==
X-Forwarded-Encrypted: i=1;
 AL+hErEq6jxq7uNE9buQoWgmBmuhihcYZICsBPrdD1arUvVn0f6OzwlCwS3fJQcJpCCkSbTpyive8iZkuyU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+yejiaLHOyjnwOBCwZ+gDEPTd8zbwCmcNMI37MbQ96jd/hwHMq
 +TYDCVA3G1xRUda4FLiClwajxMgU0zAKLBuV5CUHJMxJLfCUsr8N22fW
X-Gm-Gg: AYBFou2dIpDtB+VG6EBN/AjWxmhIcpSTuF0s81Y7A635m2kZeflygBZePOGHugaR7RN
 0tLI/DUdG31JzmYLdbqoypYoZr5iaQueZUrrAVzrurBEpZPAP/rdxLf8jLhwnVsKfSnEs2xdS7I
 AiwhX5hOzlRQvxWP5b5aru6XXhjT8CT8jcthriHLpWP99Dl9N7tHgMpfkuZn/gHbD4/bwNBmIAl
 z7EDY4GLViW5aq8tCOe+WF/HpMC1zLEFKrvrSgTi/5LlcbvRmuaNApAGdqebgJW98jre/oPOaJI
 OKxIkYkGb4NoneKKVZ0VrXuCX0xuMIREFe7u29dyUdrUBvYvNGhutlxIy9U6sqWcuPGOd5hiY1h
 1gvieJyYkN9jaKCLxWZs6bCYFwBOG/a0J0iuH/8pBoGeilZmGunDt1KUxNYKXwzERSBqpzpGTNZ
 8LH28xK0/ahDyXGXg12BJDd5Nwj6aLrFNiSTaA3deAbrQwWEgmB8Lbp6lA7ov8rfq99eQo8XLqw
 2Ovop0rKCrSs3JSpDhERic9p6dwapCF26M2iuNEqkG+3zrpsQchJsBOTLMbFEW2Jog/ovSJfj1v
 zmvAE7PqKfBHXnCJetICXXvg4oJ2g814l3es32TaTtV2l3GE0U4omtvU31uVsDpD7mg8yYfGkGW
 +1XU=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id
 5a478bee46e88-379651ecb3emr9803831eec.1.1794676682696; 
 Sat, 14 Nov 2026 09:18:02 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0c40sm19492548eec.28.2026.11.14.09.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:18:02 -0800 (PST)
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
Date: Sun, 15 Nov 2026 02:17:52 +0900
Message-ID: <20261114171752.972-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com>
References: <CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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

On Sat, Nov 14, 2026 at 8:40 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> Oh, right.  We should probably just update last_fence for VM_BIND in
> the same way.  (Ie. using dma_fence_unwrap_merge() to deal with the
> case that the current last_fence is on a different timeline.)  I
> overlooked that.

Will do in v4.

> I think if last_fence is also accounting for VM_BIND jobs, this should
> ensure that all VM_BIND jobs are also finished.

It covers their fences, but not the free of a killed job:
drm_sched_entity_kill_jobs_work() signals the finished fence and only
then calls free_job(), which can drop the last reference to the queue
after msm_gem_vm_close() has torn the scheduler down.
msm_submitqueue_destroy() then calls drm_sched_entity_destroy(), whose
flush reads entity->rq->sched from the run queue that drm_sched_fini()
freed. Jobs that ran are freed before drm_sched_fini(), by the
scheduler or in drm_sched_stop(). So I'd keep patch 2 on top of the
last_fence change.

> Yes, userspace must use fences/syncobjs to synchronize VM_BINDs if it
> is using multiple VM_BIND queues with overlapping updates.  An error
> would mark the vm unuseable, and the kernel will stop accepting
> SUBMITs and VM_BINDs.  But maybe we should also handle errors in the
> UNMAP path as well, as that also indicates that userspace is doing
> something wrong?

Yes, I'll do that, but it only catches an unmap that finds part of its
range unmapped, not one that runs while the range still holds the PTEs
of an older mapping, e.g. one whose own unmap is still queued on a
third queue. The early unmap then succeeds. If the map runs next,
before the third queue's unmap, its PTEs belong to no VMA, so nothing
keeps the BO alive for them until that unmap removes them, and none of
the three ops fails.

So instead of making unmaps wait for maps, in v4 I'd also track
whether the map of a VMA has been applied, and mark the VM unusable
when its unmap runs first. The jobs of a VM run one at a time on
vm->sched, but v3 patch 1 applies the unmaps of a killed job from the
kill worker, and msm_vma_job_run() reads vm->unusable before taking
mmu_lock, so a map waiting for the lock would still be applied. The
check has to move under the lock, and the flag has to be set before
the unmap path drops the lock.

This is all from reading the code; I haven't reproduced it.

Thanks,
Jiwoo Kim
