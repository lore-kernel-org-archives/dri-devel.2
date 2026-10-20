Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9E606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jyboQ6nH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6918210FCC9;
	Wed, 21 Oct 2026 08:52:03 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0505310E0EC
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:25:09 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so11062105ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792509908; x=1793114708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bUA6vcWC10RvotCLCwifG5C/36iFK81MbK3iijRE4Q8=;
 b=jyboQ6nHX0fTosDLyFIQKlaL05+RCyduvr4MV51A93YE8s6dYCDFI7M+Zxin3ZwqKD
 SINUTQXks6lL2H++zCK/TgwXZir8HXTosz6aBrArGbRA0I1ndZ5Mbj75tRVaBXJUi+Ei
 5mtqtpChwjEb8dzDkfRcDWgskBz+yJbREdmrU/Zpke+jFJLwT7I67Sbdw/Ss9dq1L9vl
 TLSjo/HrAcmjMS3sgWj03D49cKrjywoW4Yl2DMWxYOM09t5IW/YWUgWljNK+zHW0tMAS
 SnfPUoF58SteE2HkheInofiOovwnNU2iiJnWGxXf9tzPVPYtSHczPCWPC+U50r5f/XMo
 JVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509908; x=1793114708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bUA6vcWC10RvotCLCwifG5C/36iFK81MbK3iijRE4Q8=;
 b=xf6/mBFmPUBRk2XYj9Ad5Osvxk8ZxYS4Ws6X626gor57cbekzO5ZsK+cOmr1h8KMX8
 MLdV+m/5b7GhFWBcEupDD0LEqcWR7SQwC6uMMPeHh8BL5yHrT/dMEr7NnJB32LpF/6sr
 Y5Xgsq3fV4hSQxA+tHogk41H8Oj3RBdRL0ZiRM8UfAZB7C+BcmN9XT0Nm5igvbfPRGJ6
 3nXbRdDaj3Iq9RGiPwDsN+PKDHGRw4P9wlL3KkN7D2JrRKEJr+K+Y1pheaDRnYCSsM2e
 wIBtjw940d+u0tLZNivjoNwEFhXdmOItFxy5gG+NwO4m5yYM4/gnsFw577QR8GMojCdy
 6WVA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHZYi3CqwNpC0WrQ+FEg1q7H/Rzr7Fct0nwl2Eb6PgUT3qNN6ERuLBytixwjB+GCNbK6aB35lEYS4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL0blVAO1JUPJEh/quc4NQVb5qPEtifZlkLiI5zymyWPtfz/Ute
 Z7DP7IxAugOf0lulG3AFGKkt/Og2sfIWDNic++cxMSTJIsVXlDn+uJ80
X-Gm-Gg: AYBFou2hEYK6w0FvAjMn10Ld828pti6bN8OWUTlosBqR+0uKoh+dvoolBbYFD7Nzd2U
 tPR3CsxfnmqhNHfOeKG2+Vbxfjoy3snK3L+P7MPlWnj8S2g9tZA75OXSy31cYtq7CMLeP58p1ha
 CCVj9oqBC1TRWC+l5opMEeGI0KPOOQzHXSwZTMC1Wm2RRapOvY9T5qN6nUE/A+HUtNxYwGWE94w
 od5fgOmlz3tf2CCYiYzq4hsoNaoXiWYGTfVzGK/e20Go5L/lxcYrD9MjDVmGNEOgIV0rkz5Nj9j
 DPdRK4ToMDOxR1BmnoGrPSAddh1TLIVODxEAO3MWxMPQUo+adXEV21jJdnoiGHIO2LP/m7jDcl8
 FVIV/hwd4e/6PygWxmIQhCtWqSxZ2kt9uE5wUoRTFUMs/93YzYnlNTP8pljljRLlOgHF6rTYJbM
 /uVMV/EhLHEe7HKOwG3vXthQO99qNktLmfdUbdeNj/bNuGgotlvuroSCVlnbxRplTfzIRMhfSUJ
 YozA6mylZ1S296OU96PrS3C2cpxlIprcTscl8zLi9qhp5v2
X-Received: by 2002:a17:903:1a2c:b0:2e9:8794:8ce7 with SMTP id
 d9443c01a7336-2e9a6e4cd25mr89322775ad.43.1792509908295; 
 Tue, 20 Oct 2026 08:25:08 -0700 (PDT)
Received: from air ([2601:602:580:a250:62eb:81a:51d8:6bf6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b486970sm625895ad.62.2026.10.20.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:25:05 -0700 (PDT)
From: Joel Winarske <joel.winarske@gmail.com>
X-Google-Original-From: Joel Winarske <joel.winarske@linux.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Joel Winarske <joel.winarske@linux.com>,
	dri-devel@lists.freedesktop.org
Subject: [BUG] drm/panfrost: GPU fault cascade ends in kernel memory
 corruption on Mali-G52 (RK3566)
Date: Tue, 20 Oct 2026 08:24:26 -0700
Message-ID: <20261020152450.2901040-1-joel.winarske@linux.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On a Mali-G52 (Rockchip RK3566), a run of job timeouts and soft-stop
failures ends with the kernel taking paging requests at corrupt
addresses, and an oops on the next fork(). The machine does not panic:
it keeps running and keeps routing packets, but every process that
clones a VMA dies, so it is unusable and needs a power cycle.

I have ruled out the obvious candidate before writing -- details below
-- so I am fairly sure this is not the 2019 per-slot reset race.
Happy to be told otherwise.

The sequence
============

Captured over netconsole, because everything on the box stops before it
can write to disk:

  panfrost fde60000.gpu: Soft-stop failed
  panfrost fde60000.gpu: Soft-stop failed
  panfrost fde60000.gpu: gpu sched timeout, js=1, config=0x7300,
                         status=0x8, head=0xd73cf480, tail=0xd73cecc0,
                         sched_job=00000000317fe955
  panfrost fde60000.gpu: Unhandled Page fault in AS0 at VA 0x000000001E0C2900
            raw fault status: 0x664003C2
            decoded fault status: SLAVE FAULT
            exception type 0xC2: TRANSLATION_FAULT_2
            access type 0x3: WRITE
            source id 0x6640
  panfrost fde60000.gpu: js fault, js=0, status=DATA_INVALID_FAULT,
                         head=0xd496dfc0, tail=0xd496dfc0
  Unable to handle kernel paging request at virtual address 3f87ae4e3f41d124
  Unable to handle kernel paging request at virtual address ffff3a2c0129b997
  Internal error: Oops: 0000000096000004 [#1] SMP
    EC = 0x25: DABT (current EL), FSC = 0x04: level 0 translation fault
  CPU: 0 PID: 1 Comm: systemd Tainted: G        W  O
       6.1.84-10-rk2410-nocsf #10
  Hardware name: Radxa ZERO 3 (DT)
  pc : anon_vma_interval_tree_insert+0x90/0xb4
  Call trace:
    anon_vma_interval_tree_insert+0x90/0xb4
    anon_vma_clone+0x110/0x144
    anon_vma_fork+0x30/0x134
    dup_mmap+0x2c4/0x4bc
    copy_process+0xa84/0x1314
    kernel_clone+0xb0/0x288
    __do_sys_clone+0x68/0x9c
    __arm64_sys_clone+0x20/0x28

Four separate paging requests at unrelated garbage addresses precede
the oops, which is why this reads as corruption rather than one bad
dereference.

Worth noting the GPU's own faulting access is a write the MMU blocked
(TRANSLATION_FAULT_2, access type 0x3: WRITE), so it should not itself
have reached kernel memory. That is what makes me look at the recovery
path rather than at the GPU.

Why it is expensive: networking never clones a VMA, so the box still
answers pings, while sshd -- which forks per connection -- dies at
kex_exchange_identification, before authentication. No credential can
get in, and journald is gone for the same reason, so nothing about this
survives on the machine.

What I ruled out
================

The per-slot reset race (two timeout threads racing in the reset path,
the T820 problem from 2019) does not apply here. The serialization is
present in its modern form: panfrost_job_init() does

  pfdev->reset.wq = alloc_ordered_workqueue("panfrost-reset", 0);

and passes that workqueue to drm_sched_init() for every slot, so an
ordered workqueue means panfrost_job_timedout() cannot run
concurrently for two slots. I had reached for that explanation first,
because the log shows js=0 and js=1 faulting in the same window.

This is also not a vendor divergence. The board runs a Rockchip BSP, so
the next question was whether it had dropped something. It has not:
against upstream linux-6.1.y, this kernel's panfrost_job.c differs by
nine lines, all DRM scheduler API signature adaptations
(drm_sched_start, drm_sched_init, hw_rq_count -> credit_count), with no
logic changes. So the above happens on a stock upstream 6.1 panfrost
path with the serialized reset in place.

A question about HW_ISSUE_8408
==============================

  "Repeatedly Soft-stopping a job chain consisting of (Vertex Shader,
   Cache Flush, Tiler) jobs causes DATA_INVALID_FAULT"

That is close to word-for-word what the log shows: repeated soft-stop
failures on js=1 (vertex/tiler), DATA_INVALID_FAULT on js=0. But it is
declared only in hw_issues_t600, not for G52. Is that because G52 does
not have it, or because nobody has had cause to flag it there?

Against that, HW_ISSUE_9435 is in hw_issues_all -- the compute
endpoint's 4-deep task queue means a soft stop cannot complete until
all four tasks do -- so "Soft-stop failed" on its own may be
unremarkable, and I would rather say so than lean on it.

Recoverable vs fatal
====================

Two cascades on one boot, with identical DATA_INVALID_FAULT counts:

                          recoverable      fatal
  span                    3 s              14 s
  gpu sched timeout       6                10
  DATA_INVALID_FAULT      3                3
  Soft-stop failed        0                2
  TRANSLATION_FAULT_2     0                1
  outcome                 GPU recovers,    oops
                          display restores
                          at +4.4 s, ~70 s
                          more rendering on
                          the same boot

So escalation tracks the driver failing to stop the hung job rather
than the number of faulting jobs. Given HW_ISSUE_9435 that may be
correlation rather than cause.

What I do not have
==================

- A mainline reproduction. It is a vendor kernel, though as above its
  panfrost is upstream's to nine API-signature lines, so "vendor
  kernel" is not by itself the explanation. If reproducing on mainline
  is the precondition for looking at this, say so and I will see what
  I can arrange.
- A minimal reproducer. The trigger is a full application rendering a
  large scene.
- A devcoredump: the driver logs "failed to allocate devcoredump file"
  at exactly the moment one would be most useful.
  panfrost_core_dump(job) is called from panfrost_job_timedout()
  immediately before the reset, so that may deserve its own look.
- Determinism. Five runs in an identical environment gave one cascade
  and four clean runs.

Environment
===========

  Mali-G52 r1 MC1 on Rockchip RK3566
  mali-g52 id 0x7402 major 0x1 minor 0x0
  [drm] Initialized panfrost 1.2.0 20180908 for fde60000.gpu on minor 1
  features: 00000000,00000cf7  issues: 00000000,00000400
  kernel 6.1.84-10-rk2410-nocsf #10 (Rockchip BSP), aarch64
  taint G W O -- out-of-tree panel_mipi_dbi, gpio_backlight

Userspace is panvk (Mesa 26.3.0-devel), which needs
PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1. A separate userspace problem on
the same hardware is filed as mesa/mesa#16595; this report is only
about the kernel turning a GPU fault into memory corruption, which no
userspace submission should be able to do.

I have the full 301-line netconsole capture -- the above trimmed from
it -- and can send it, or anything else that would help. If you want
instrumentation run on this board, I can do that; each fatal
occurrence costs a physical power cycle, so a targeted request beats a
broad one.

One note for anyone reproducing: raise /proc/sys/kernel/printk to 7
first. At the default console loglevel of 4 none of these panfrost
messages reach any console, netconsole included, and a run that
faulted looks clean. Four earlier occurrences here produced no log at
all for that reason.

Thanks,
Joel
