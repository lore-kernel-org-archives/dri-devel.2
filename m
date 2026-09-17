Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D7C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BA710EF9F;
	Thu, 17 Sep 2026 16:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="clqzp/xY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC8810EF9F
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:05:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD1F4414DD;
 Thu, 17 Sep 2026 16:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFF1F00893;
 Thu, 17 Sep 2026 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789661132;
 bh=IGKd4mxaJkTbM81PlwDOYE8Y2FA4C8RC6QzH+gNbGk8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=clqzp/xYwAASEtGawNdAnON3o9f3PU32+u8r+I3eoL7TNbn7o4soVpmWT14tiGTfi
 72PAermIFMtvBiJ41KDvMmw2faYMaXLlTTeGuLsLVXf9s1y7GvTCiiHtxiACyEdOmG
 lS4oLqy8whY4FttHvPr1GKp5ZwjUCbqDBb9kZLJinopB4sgHdijq114pUyfCREk9m1
 ne/ZplqQqGnaFVRaSQAnG7teJYQS/FvO0FRb84j5WU8WhduHRd9cqCz0jfCxkDeOn+
 FT6C99GnKoXxnKawAdHG4J1BlzVEN2f6nxDpp3BJRtcw4JDz7+/PcPK2OEMl355BgI
 yCFUQHBHMnRNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO
 faults
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917154920.1872289-1-lizhi.hou@amd.com>
References: <20260917154920.1872289-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:05:32 +0000
Message-Id: <20260917160532.8FFFF1F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] amdxdna: stale VMA permissions cache in hmm_range_fault breaks mpr=
otect()
--

commit bfad63cfebe7db959de532304657044547acec26
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults

This patch updates aie2_populate_range() to check the VMA flags and
set HMM_PFN_REQ_WRITE when the VMA has VM_WRITE. This ensures that
handle_mm_fault() requests write permissions instead of populating CPU
page tables with read-only PTEs.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 5a1a2ee261b76..df8e76b5f38a0 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -429,6 +429,8 @@ static int amdxdna_hmm_register(struct amdxdna_gem_ob=
j *abo,
>  	mapp->range.start =3D vma->vm_start;
>  	mapp->range.end =3D vma->vm_end;
>  	mapp->range.default_flags =3D HMM_PFN_REQ_FAULT;
> +	if (vma->vm_flags & VM_WRITE)
> +		mapp->range.default_flags |=3D HMM_PFN_REQ_WRITE;

[Severity: High]
Does this statically cache the VMA write permissions during mmap?

If userspace later downgrades permissions via mprotect(PROT_READ) and
submits a job, could hmm_range_fault() fail with -EPERM because it still
demands write access on a read-only VMA? Conversely, if userspace upgrades
to PROT_WRITE via mprotect, it seems the driver would fail to request write
permissions, which might re-introduce the IOMMU faults this patch intended
to fix.

Since the permissions are permanently cached into the HMM range default
flags in amdxdna_hmm_register(), any unprivileged userspace application
mapping a buffer object and modifying its permissions could trigger this.

>  	mapp->abo =3D abo;
>  	kref_init(&mapp->refcnt);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917154920.1872=
289-1-lizhi.hou@amd.com?part=3D1
