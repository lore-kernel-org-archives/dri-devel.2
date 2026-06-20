Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E394DCD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 08:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A37B10E1A8;
	Sat, 20 Jun 2026 08:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nml/Tj2q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D225010E1A8
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 08:31:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CCC24430F
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 08:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E366C2BCB0
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781944297;
 bh=p2g2IlPItUmrNWO9rCAQWFs3VVA75c10K1nrmbVv24c=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Nml/Tj2qzuWyQ6Ez+febf47YME7PRsEqUaHFHTzFPDM1usU0aC4X1ksWRVcJO4nqx
 qu5YECcTU3LQB1XFhCO5tSADxTqZpXjaujvlK8/gq615MveRFQqJn3Ycv42L1stP0z
 hCiNBNsBZYKL2XEd2v8H1uRbj9fS6vNJv2ebTWhZslEJTcPcdDp0H9mKVa4T6ku4a6
 J1sJb2WCLq4rZPAJGlnWiCDS3BsGg9uhRj6b9SDN421wnUlf6FjSXApC/Jz2OpfS8D
 S/NfhCt/2/IEV0csaSjJNSfT/Bx4ngPW06tHzj1Iu1pqEP3v5gtFDYzaNKpy1fZa7t
 YebK45fEOOaEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 74BCAC4160E; Sat, 20 Jun 2026 08:31:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 60533] CVE-2013-7445: Remote web page triggerable DoS in Linux
 DRM graphics
Date: Sat, 20 Jun 2026 08:31:36 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: dri-devel@lists.freedesktop.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-60533-2300-MA2Qcp8N1l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60533-2300@https.bugzilla.kernel.org/>
References: <bug-60533-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60533

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--- Comment #44 from Artem S. Tashkinov (aros@gmx.com) ---
Further testing narrows this down substantially.

With Chrome started as:

```
google-chrome-stable --disable-gpu --disable-gpu-compositing
```

the reproducer crashes only the offending tab. It does not trigger a
system-wide OOM and does not kill unrelated browser processes.

With normal GPU acceleration enabled, the same workload rapidly causes a gl=
obal
OOM, kills unrelated Chrome/Firefox processes, and leaves memory exhaustion
that is not explained by ordinary Chrome process RSS.

This strongly suggests that the catastrophic failure depends on the acceler=
ated
graphics path:

```
Chrome =E2=86=92 ANGLE/Mesa =E2=86=92 DRM/GEM =E2=86=92 xe
```

I do not yet claim that xe alone is necessarily at fault; this could involve
Chrome, ANGLE/Mesa, shared DRM/GEM code, or xe object
lifetime/accounting/reclaim. However, this report appears to belong on the =
DRM
xe GitLab tracker rather than kernel.org Bugzilla.

I have opened the corresponding report here:
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8393

The issue must affect i915 similarly but I'm not sure about amdgpu.

(In reply to Eero Tamminen from comment #43)
> There's now DMEM cgroup for limiting device (e.g. GPU) memory:
> https://docs.kernel.org/admin-guide/cgroup-v2.html#dmem
>=20
> But I guess this bug is only about iGPUs i.e. when GPU memory is shared w=
ith
> the CPU?

`dmem` is clearly relevant, but I do not think it makes this purely an iGPU
question.

My reading is that `dmem` limits allocations in registered device-memory
regions. That is an obvious fit for dGPU VRAM, and perhaps for explicitly
exposed iGPU regions such as stolen memory. It is less clear whether it cov=
ers
the host-RAM-backed GEM/TTM allocations that are often involved in UMA path=
s,
or dGPU objects that have been evicted/migrated to system RAM.

So there seem to be two related but distinct failure modes:

1. Device-local-memory exhaustion: a dGPU process consumes VRAM. `dmem.max`
looks like the intended containment mechanism.

2. Host-RAM exhaustion induced by GPU objects: buffers, imported dma-bufs,
staging allocations, page tables, shmem-backed GEM objects, or migrated BOs
consume ordinary RAM. This is especially easy to turn into a global OOM on =
an
iGPU/UMA system because =E2=80=9CGPU memory=E2=80=9D is ultimately the same=
 DRAM pool as
everything else.

The second manifestation may indeed be mostly visible on iGPUs, but I would=
 not
call the underlying problem iGPU-exclusive without checking where the relev=
ant
allocations are charged. A dGPU can still consume host RAM through
system-memory placements and migration paths.

The useful question for this report might be: does the allocation path at i=
ssue
appear in `dmem.current` for the offending cgroup, or is it only charged
through the normal memory cgroup / not attributed usefully at all? If
`dmem.current` stays flat while host RAM is exhausted, then `dmem` does not
address that particular path.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
