Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA1606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S8nDQccA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C1710FCC0;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D4210E28E
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:00:14 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso23867217b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792512011; cv=none;
 d=google.com; s=arc-20260327;
 b=osaT3acLHlZt6w2MJE9ZRzDQnrvFaUlcwM3JXQ3bpmkd14p/ssCuHH/BVFsvORHesi
 EdVe0qSL7/TwRM3k9xEbclWo50jV9L5tp6DOAGFii7zgv7ABAO6ThHsExR+tFY/IfQ2O
 SCn/Pq+c9PujRAdsbiB+zAJlvgGklW0Zk21TeafBk1SsoUVPttLLCurucNUuLO8ETomj
 dBfMOHBqhTTBBS00hUCqtHjXJJLvG+RHrY9Y4lnb6G7rIcsy5JOEk8dpKpa0E354Zii0
 E/y60Q6HPRjtQzsW0HT3HU93YjoG4IudS6Hq6wQj4BttKD1ZIIJI1ud/o35jqfHEbqBd
 pFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UwQ2ePWD/2PDKXdrkMpb45Q1uj7j0zJmLSabyhzAG/E=;
 fh=eS7/reLhs3W4Jo3RItuqVnazBA+1rckMWSsgWcwuWlc=;
 b=rSY6g8DcLKCIvenmaQuTKAd0INyvi+Ua37pBBKT2J3tfdzKW9JoKogxkrDZnorqNYF
 1ids4rrouu0khdJeYpResSUMFhhXq9m674wxcqNzykuD7A9JhAoYUWzySNcrfraiL+CY
 JbocLvPvxOeuDWca90Qs8G8a4Z68jdxCbHkX7AXU7yWsnl4jlpQEpzDTXkxkxsm1/v9P
 qaFVt4i6k2euMHj2fJC8eIjqcOc5DIordh1qlosYJFtfs8MILJNr49L8BlT4B7jcemZl
 2bkZKzTXFTpZFsOPrIgWZZo+VHl0/9+PB6HT6vN+7aaMb+CplKZd0agi1CyrTE2L8oUI
 kGWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792512011; x=1793116811; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UwQ2ePWD/2PDKXdrkMpb45Q1uj7j0zJmLSabyhzAG/E=;
 b=S8nDQccAz8nPU6u4EfNBS61rRTYscCHqMUjeSbKrYQz+1qEqbYjfxmUR5/p5CpTh8+
 SjocV6YlOlIid6NmH7pFYAXO+Nk3bf6k/d3Qg7mKsz1s4lp/Uc0lOsPWBjQGhyJhkg2e
 KW6WxhwJnhmz0XooxyED7Msc5VJCQZNoraNpVFhH2OYhpUoMzq3fGXSNVkxtlQBub2HI
 6WlcELnPbyXY8n4WkF1kgH5TNUIBykva8l6kbM5dwM9WUmp9kuKgEkR5E/OBoPR8K1uM
 8my3GS3Pajw5c6Wm6LFZPDxZZSRf/UJuW4vZTcdhc58ima+xLQjl7UWz4CkqZ/yIKc1w
 OsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512011; x=1793116811;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UwQ2ePWD/2PDKXdrkMpb45Q1uj7j0zJmLSabyhzAG/E=;
 b=MP7SR0Qb1Zz8xxAz7npNmXA9SBexOrRWr6sVFCCUzNHXFuGfPda4yG8BtQ5dXPXSAM
 WaHhEjugI8kylViJPQQ7TFNg33kiD54CJ/txcT4PNi3GvrF1Tmau0sGRA1Yz21IYn9kP
 NdRg4vgg3zgRYx8cXzKw2b9cTS4wvJHu0citMRUID5pkScf2RqSFXzVrHLalfORzD8Cv
 MevfMOTlv48DZApK2D1cBI/VS6EM8y0hFxpebbMxEU+XkxyKRo462wXPVys0vg7dUWQz
 V/H3UUByH1AVM4JGUH+/1XTC76nj5d3QFSHDBe4EkxpdowRGnktArS+MLf1brDXWJGUV
 DWFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO0iqr/4myJ4/dTA2K9EPPtLWFpf9kKew6q/l3qexUILyWBflWlhiMPQTL3/eSmxg2KJh4CPsTXOE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3pDnhvBPteX+Vs1NVVPFNvld79bL816telMnLDlwH3R9dP+Cm
 uJdRVlJU59kXgSM6b4DSe8Hq8TM2pl/m+sv+LL6C34YljEqtbsPM9EPdX9oEvZXGjaXAL/XQHtv
 gLoDW87fIP9wKg5jX00n21jnqJO23AkY=
X-Gm-Gg: AYBFou0jVJENVig8qh/pktQJyd0hujNnnnr+pQxaD/VbnYoFqQUwsC8vQqvczEKunvU
 577ZDusVETi4Vc3Ene7A47/cA/u0eMyyJ/pxKPvYx2j4IhRw0M9cI+/AbebZ5EEro8xRbSEY9P1
 iJ8AG15CLlXXYJggZ2cNVcCpjmh/35U+fSNlSiB4KjYGp0RJI7n+ex4sMlHLtUJoikVvx2s+Sj0
 gHYhEHUPCyLFLe9RcQod1RtIFVCh4ylAGUMIVzh8XNnvHqcZemuB9H1tvP5DO86kUZ8NmOUkkrD
 xzc1IocFwUxYxGoDLuKrf5xtOXvz7N2aMSbJQ9d8psJZlWyPZvyBdRVFrvFD4Iqrd6pY/dVaGxl
 Hq9LAYlf5a8vS+o1sIn220NdZnhgazuqpmz0WGF+xGaEa2ARYEJZElDEWfCwKQ3T7RA==
X-Received: by 2002:a05:690c:e0dc:10b0:8b0:e7a0:ac55 with SMTP id
 00721157ae682-8b0f21ac71bmr28163797b3.45.1792512011065; Tue, 20 Oct 2026
 09:00:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020152450.2901040-1-joel.winarske@linux.com>
In-Reply-To: <20261020152450.2901040-1-joel.winarske@linux.com>
From: Joel Winarske <joel.winarske@gmail.com>
Date: Tue, 20 Oct 2026 08:59:58 -0700
X-Gm-Features: AclHuK92eCLYdUoMjTBts_r7lsD-xeQBx2O_5ACzFK7Q_CpKBJiOMGd1VbrWa8E
Message-ID: <CABKMkPKso1jXCQ3zPyBXixNrQBbBcbCRCW1eNE1gQKa9+-y1KQ@mail.gmail.com>
Subject: Re: [BUG] drm/panfrost: GPU fault cascade ends in kernel memory
 corruption on Mali-G52 (RK3566)
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Joel Winarske <joel.winarske@linux.com>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000acddf1065e47b90a"
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000acddf1065e47b90a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to mention that the AI drafted this report, which I reviewed and
sent.  I'm happy to re-send a condensed version.

Also I left out "Assisted-by: LLM"

Cheers,
Joel

On Tue, Oct 20, 2026 at 8:25=E2=80=AFAM Joel Winarske <joel.winarske@gmail.=
com>
wrote:

> Hi,
>
> On a Mali-G52 (Rockchip RK3566), a run of job timeouts and soft-stop
> failures ends with the kernel taking paging requests at corrupt
> addresses, and an oops on the next fork(). The machine does not panic:
> it keeps running and keeps routing packets, but every process that
> clones a VMA dies, so it is unusable and needs a power cycle.
>
> I have ruled out the obvious candidate before writing -- details below
> -- so I am fairly sure this is not the 2019 per-slot reset race.
> Happy to be told otherwise.
>
> The sequence
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Captured over netconsole, because everything on the box stops before it
> can write to disk:
>
>   panfrost fde60000.gpu: Soft-stop failed
>   panfrost fde60000.gpu: Soft-stop failed
>   panfrost fde60000.gpu: gpu sched timeout, js=3D1, config=3D0x7300,
>                          status=3D0x8, head=3D0xd73cf480, tail=3D0xd73cec=
c0,
>                          sched_job=3D00000000317fe955
>   panfrost fde60000.gpu: Unhandled Page fault in AS0 at VA
> 0x000000001E0C2900
>             raw fault status: 0x664003C2
>             decoded fault status: SLAVE FAULT
>             exception type 0xC2: TRANSLATION_FAULT_2
>             access type 0x3: WRITE
>             source id 0x6640
>   panfrost fde60000.gpu: js fault, js=3D0, status=3DDATA_INVALID_FAULT,
>                          head=3D0xd496dfc0, tail=3D0xd496dfc0
>   Unable to handle kernel paging request at virtual address
> 3f87ae4e3f41d124
>   Unable to handle kernel paging request at virtual address
> ffff3a2c0129b997
>   Internal error: Oops: 0000000096000004 [#1] SMP
>     EC =3D 0x25: DABT (current EL), FSC =3D 0x04: level 0 translation fau=
lt
>   CPU: 0 PID: 1 Comm: systemd Tainted: G        W  O
>        6.1.84-10-rk2410-nocsf #10
>   Hardware name: Radxa ZERO 3 (DT)
>   pc : anon_vma_interval_tree_insert+0x90/0xb4
>   Call trace:
>     anon_vma_interval_tree_insert+0x90/0xb4
>     anon_vma_clone+0x110/0x144
>     anon_vma_fork+0x30/0x134
>     dup_mmap+0x2c4/0x4bc
>     copy_process+0xa84/0x1314
>     kernel_clone+0xb0/0x288
>     __do_sys_clone+0x68/0x9c
>     __arm64_sys_clone+0x20/0x28
>
> Four separate paging requests at unrelated garbage addresses precede
> the oops, which is why this reads as corruption rather than one bad
> dereference.
>
> Worth noting the GPU's own faulting access is a write the MMU blocked
> (TRANSLATION_FAULT_2, access type 0x3: WRITE), so it should not itself
> have reached kernel memory. That is what makes me look at the recovery
> path rather than at the GPU.
>
> Why it is expensive: networking never clones a VMA, so the box still
> answers pings, while sshd -- which forks per connection -- dies at
> kex_exchange_identification, before authentication. No credential can
> get in, and journald is gone for the same reason, so nothing about this
> survives on the machine.
>
> What I ruled out
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The per-slot reset race (two timeout threads racing in the reset path,
> the T820 problem from 2019) does not apply here. The serialization is
> present in its modern form: panfrost_job_init() does
>
>   pfdev->reset.wq =3D alloc_ordered_workqueue("panfrost-reset", 0);
>
> and passes that workqueue to drm_sched_init() for every slot, so an
> ordered workqueue means panfrost_job_timedout() cannot run
> concurrently for two slots. I had reached for that explanation first,
> because the log shows js=3D0 and js=3D1 faulting in the same window.
>
> This is also not a vendor divergence. The board runs a Rockchip BSP, so
> the next question was whether it had dropped something. It has not:
> against upstream linux-6.1.y, this kernel's panfrost_job.c differs by
> nine lines, all DRM scheduler API signature adaptations
> (drm_sched_start, drm_sched_init, hw_rq_count -> credit_count), with no
> logic changes. So the above happens on a stock upstream 6.1 panfrost
> path with the serialized reset in place.
>
> A question about HW_ISSUE_8408
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>   "Repeatedly Soft-stopping a job chain consisting of (Vertex Shader,
>    Cache Flush, Tiler) jobs causes DATA_INVALID_FAULT"
>
> That is close to word-for-word what the log shows: repeated soft-stop
> failures on js=3D1 (vertex/tiler), DATA_INVALID_FAULT on js=3D0. But it i=
s
> declared only in hw_issues_t600, not for G52. Is that because G52 does
> not have it, or because nobody has had cause to flag it there?
>
> Against that, HW_ISSUE_9435 is in hw_issues_all -- the compute
> endpoint's 4-deep task queue means a soft stop cannot complete until
> all four tasks do -- so "Soft-stop failed" on its own may be
> unremarkable, and I would rather say so than lean on it.
>
> Recoverable vs fatal
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Two cascades on one boot, with identical DATA_INVALID_FAULT counts:
>
>                           recoverable      fatal
>   span                    3 s              14 s
>   gpu sched timeout       6                10
>   DATA_INVALID_FAULT      3                3
>   Soft-stop failed        0                2
>   TRANSLATION_FAULT_2     0                1
>   outcome                 GPU recovers,    oops
>                           display restores
>                           at +4.4 s, ~70 s
>                           more rendering on
>                           the same boot
>
> So escalation tracks the driver failing to stop the hung job rather
> than the number of faulting jobs. Given HW_ISSUE_9435 that may be
> correlation rather than cause.
>
> What I do not have
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - A mainline reproduction. It is a vendor kernel, though as above its
>   panfrost is upstream's to nine API-signature lines, so "vendor
>   kernel" is not by itself the explanation. If reproducing on mainline
>   is the precondition for looking at this, say so and I will see what
>   I can arrange.
> - A minimal reproducer. The trigger is a full application rendering a
>   large scene.
> - A devcoredump: the driver logs "failed to allocate devcoredump file"
>   at exactly the moment one would be most useful.
>   panfrost_core_dump(job) is called from panfrost_job_timedout()
>   immediately before the reset, so that may deserve its own look.
> - Determinism. Five runs in an identical environment gave one cascade
>   and four clean runs.
>
> Environment
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Mali-G52 r1 MC1 on Rockchip RK3566
>   mali-g52 id 0x7402 major 0x1 minor 0x0
>   [drm] Initialized panfrost 1.2.0 20180908 for fde60000.gpu on minor 1
>   features: 00000000,00000cf7  issues: 00000000,00000400
>   kernel 6.1.84-10-rk2410-nocsf #10 (Rockchip BSP), aarch64
>   taint G W O -- out-of-tree panel_mipi_dbi, gpio_backlight
>
> Userspace is panvk (Mesa 26.3.0-devel), which needs
> PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1. A separate userspace problem on
> the same hardware is filed as mesa/mesa#16595; this report is only
> about the kernel turning a GPU fault into memory corruption, which no
> userspace submission should be able to do.
>
> I have the full 301-line netconsole capture -- the above trimmed from
> it -- and can send it, or anything else that would help. If you want
> instrumentation run on this board, I can do that; each fatal
> occurrence costs a physical power cycle, so a targeted request beats a
> broad one.
>
> One note for anyone reproducing: raise /proc/sys/kernel/printk to 7
> first. At the default console loglevel of 4 none of these panfrost
> messages reach any console, netconsole included, and a run that
> faulted looks clean. Four earlier occurrences here produced no log at
> all for that reason.
>
> Thanks,
> Joel
>

--000000000000acddf1065e47b90a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I forgot to mention that the AI drafted this report, =
which I reviewed and sent.=C2=A0 I&#39;m happy to re-send a condensed versi=
on.</div><div><br></div><div>Also I left out &quot;Assisted-by: LLM&quot;</=
div><div><br></div><div>Cheers,</div><div>Joel</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Oct 20, 2026 at 8:25=E2=80=AFAM Joel Winarske &lt;<a href=3D"mailto:=
joel.winarske@gmail.com">joel.winarske@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On a Mali-G52 (Rockchip RK3566), a run of job timeouts and soft-stop<br>
failures ends with the kernel taking paging requests at corrupt<br>
addresses, and an oops on the next fork(). The machine does not panic:<br>
it keeps running and keeps routing packets, but every process that<br>
clones a VMA dies, so it is unusable and needs a power cycle.<br>
<br>
I have ruled out the obvious candidate before writing -- details below<br>
-- so I am fairly sure this is not the 2019 per-slot reset race.<br>
Happy to be told otherwise.<br>
<br>
The sequence<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Captured over netconsole, because everything on the box stops before it<br>
can write to disk:<br>
<br>
=C2=A0 panfrost fde60000.gpu: Soft-stop failed<br>
=C2=A0 panfrost fde60000.gpu: Soft-stop failed<br>
=C2=A0 panfrost fde60000.gpu: gpu sched timeout, js=3D1, config=3D0x7300,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0status=3D0x8, head=3D0xd73cf480, tail=3D0xd73cecc0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sched_job=3D00000000317fe955<br>
=C2=A0 panfrost fde60000.gpu: Unhandled Page fault in AS0 at VA 0x000000001=
E0C2900<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raw fault status: 0x664003C2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 decoded fault status: SLAVE FAULT=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exception type 0xC2: TRANSLATION_=
FAULT_2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 access type 0x3: WRITE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source id 0x6640<br>
=C2=A0 panfrost fde60000.gpu: js fault, js=3D0, status=3DDATA_INVALID_FAULT=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0head=3D0xd496dfc0, tail=3D0xd496dfc0<br>
=C2=A0 Unable to handle kernel paging request at virtual address 3f87ae4e3f=
41d124<br>
=C2=A0 Unable to handle kernel paging request at virtual address ffff3a2c01=
29b997<br>
=C2=A0 Internal error: Oops: 0000000096000004 [#1] SMP<br>
=C2=A0 =C2=A0 EC =3D 0x25: DABT (current EL), FSC =3D 0x04: level 0 transla=
tion fault<br>
=C2=A0 CPU: 0 PID: 1 Comm: systemd Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=
=C2=A0 O<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A06.1.84-10-rk2410-nocsf #10<br>
=C2=A0 Hardware name: Radxa ZERO 3 (DT)<br>
=C2=A0 pc : anon_vma_interval_tree_insert+0x90/0xb4<br>
=C2=A0 Call trace:<br>
=C2=A0 =C2=A0 anon_vma_interval_tree_insert+0x90/0xb4<br>
=C2=A0 =C2=A0 anon_vma_clone+0x110/0x144<br>
=C2=A0 =C2=A0 anon_vma_fork+0x30/0x134<br>
=C2=A0 =C2=A0 dup_mmap+0x2c4/0x4bc<br>
=C2=A0 =C2=A0 copy_process+0xa84/0x1314<br>
=C2=A0 =C2=A0 kernel_clone+0xb0/0x288<br>
=C2=A0 =C2=A0 __do_sys_clone+0x68/0x9c<br>
=C2=A0 =C2=A0 __arm64_sys_clone+0x20/0x28<br>
<br>
Four separate paging requests at unrelated garbage addresses precede<br>
the oops, which is why this reads as corruption rather than one bad<br>
dereference.<br>
<br>
Worth noting the GPU&#39;s own faulting access is a write the MMU blocked<b=
r>
(TRANSLATION_FAULT_2, access type 0x3: WRITE), so it should not itself<br>
have reached kernel memory. That is what makes me look at the recovery<br>
path rather than at the GPU.<br>
<br>
Why it is expensive: networking never clones a VMA, so the box still<br>
answers pings, while sshd -- which forks per connection -- dies at<br>
kex_exchange_identification, before authentication. No credential can<br>
get in, and journald is gone for the same reason, so nothing about this<br>
survives on the machine.<br>
<br>
What I ruled out<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
The per-slot reset race (two timeout threads racing in the reset path,<br>
the T820 problem from 2019) does not apply here. The serialization is<br>
present in its modern form: panfrost_job_init() does<br>
<br>
=C2=A0 pfdev-&gt;reset.wq =3D alloc_ordered_workqueue(&quot;panfrost-reset&=
quot;, 0);<br>
<br>
and passes that workqueue to drm_sched_init() for every slot, so an<br>
ordered workqueue means panfrost_job_timedout() cannot run<br>
concurrently for two slots. I had reached for that explanation first,<br>
because the log shows js=3D0 and js=3D1 faulting in the same window.<br>
<br>
This is also not a vendor divergence. The board runs a Rockchip BSP, so<br>
the next question was whether it had dropped something. It has not:<br>
against upstream linux-6.1.y, this kernel&#39;s panfrost_job.c differs by<b=
r>
nine lines, all DRM scheduler API signature adaptations<br>
(drm_sched_start, drm_sched_init, hw_rq_count -&gt; credit_count), with no<=
br>
logic changes. So the above happens on a stock upstream 6.1 panfrost<br>
path with the serialized reset in place.<br>
<br>
A question about HW_ISSUE_8408<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 &quot;Repeatedly Soft-stopping a job chain consisting of (Vertex Sha=
der,<br>
=C2=A0 =C2=A0Cache Flush, Tiler) jobs causes DATA_INVALID_FAULT&quot;<br>
<br>
That is close to word-for-word what the log shows: repeated soft-stop<br>
failures on js=3D1 (vertex/tiler), DATA_INVALID_FAULT on js=3D0. But it is<=
br>
declared only in hw_issues_t600, not for G52. Is that because G52 does<br>
not have it, or because nobody has had cause to flag it there?<br>
<br>
Against that, HW_ISSUE_9435 is in hw_issues_all -- the compute<br>
endpoint&#39;s 4-deep task queue means a soft stop cannot complete until<br=
>
all four tasks do -- so &quot;Soft-stop failed&quot; on its own may be<br>
unremarkable, and I would rather say so than lean on it.<br>
<br>
Recoverable vs fatal<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Two cascades on one boot, with identical DATA_INVALID_FAULT counts:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 recoverable=C2=A0 =C2=A0 =C2=A0 fatal<br>
=C2=A0 span=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 3 s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14 s<br>
=C2=A0 gpu sched timeout=C2=A0 =C2=A0 =C2=A0 =C2=A06=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10<br>
=C2=A0 DATA_INVALID_FAULT=C2=A0 =C2=A0 =C2=A0 3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
=C2=A0 Soft-stop failed=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
=C2=A0 TRANSLATION_FAULT_2=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
=C2=A0 outcome=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GPU recovers,=C2=A0 =C2=A0 oops<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 display restores<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 at +4.4 s, ~70 s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 more rendering on<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 the same boot<br>
<br>
So escalation tracks the driver failing to stop the hung job rather<br>
than the number of faulting jobs. Given HW_ISSUE_9435 that may be<br>
correlation rather than cause.<br>
<br>
What I do not have<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
- A mainline reproduction. It is a vendor kernel, though as above its<br>
=C2=A0 panfrost is upstream&#39;s to nine API-signature lines, so &quot;ven=
dor<br>
=C2=A0 kernel&quot; is not by itself the explanation. If reproducing on mai=
nline<br>
=C2=A0 is the precondition for looking at this, say so and I will see what<=
br>
=C2=A0 I can arrange.<br>
- A minimal reproducer. The trigger is a full application rendering a<br>
=C2=A0 large scene.<br>
- A devcoredump: the driver logs &quot;failed to allocate devcoredump file&=
quot;<br>
=C2=A0 at exactly the moment one would be most useful.<br>
=C2=A0 panfrost_core_dump(job) is called from panfrost_job_timedout()<br>
=C2=A0 immediately before the reset, so that may deserve its own look.<br>
- Determinism. Five runs in an identical environment gave one cascade<br>
=C2=A0 and four clean runs.<br>
<br>
Environment<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 Mali-G52 r1 MC1 on Rockchip RK3566<br>
=C2=A0 mali-g52 id 0x7402 major 0x1 minor 0x0<br>
=C2=A0 [drm] Initialized panfrost 1.2.0 20180908 for fde60000.gpu on minor =
1<br>
=C2=A0 features: 00000000,00000cf7=C2=A0 issues: 00000000,00000400<br>
=C2=A0 kernel 6.1.84-10-rk2410-nocsf #10 (Rockchip BSP), aarch64<br>
=C2=A0 taint G W O -- out-of-tree panel_mipi_dbi, gpio_backlight<br>
<br>
Userspace is panvk (Mesa 26.3.0-devel), which needs<br>
PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1. A separate userspace problem on<br>
the same hardware is filed as mesa/mesa#16595; this report is only<br>
about the kernel turning a GPU fault into memory corruption, which no<br>
userspace submission should be able to do.<br>
<br>
I have the full 301-line netconsole capture -- the above trimmed from<br>
it -- and can send it, or anything else that would help. If you want<br>
instrumentation run on this board, I can do that; each fatal<br>
occurrence costs a physical power cycle, so a targeted request beats a<br>
broad one.<br>
<br>
One note for anyone reproducing: raise /proc/sys/kernel/printk to 7<br>
first. At the default console loglevel of 4 none of these panfrost<br>
messages reach any console, netconsole included, and a run that<br>
faulted looks clean. Four earlier occurrences here produced no log at<br>
all for that reason.<br>
<br>
Thanks,<br>
Joel<br>
</blockquote></div>

--000000000000acddf1065e47b90a--
