Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE31CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438D710E095;
	Tue, 13 Oct 2026 16:29:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115B110E095
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:29:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E242040864;
 Tue, 13 Oct 2026 16:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEF01F000FF;
 Tue, 13 Oct 2026 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791908962;
 bh=2MSKGWi5sSTXPxshy0khHGQFOGEaARrsUzF69RTi9us=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nh5lZUsI00aE3cPEz2OT/FZEYPg4h6SI/G9fLd8I8GbBxvGn7Uy+G0t/Y5HnPvih5
 SD5sDhB85Itm65IyDanL2L6ix/6sThqZYZim+pOR7Tf8IZbsbKOQazjDnDHzZiZUu0
 Pb0JRbMPuunzrsBVAtuztHOBCcafuATGlv8iUze9mWAfF82adDnhQElQDj5FWrf59v
 Quwnc1vGch6JEZ3OSp2xEg7STFPr5ZsdAvcTM8aZ3OofM5bseGmWVBrqSgDxNbt1cD
 AjK4u117W1bn2hBBK9uXbKgxDektLa785Jnaywiz/gekeuhP4MAtvxX9YBQkbjoh30
 z1XaVUdGNVjSg==
Message-ID: <sashiko-outbox-170114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/39] mm: add mmap action for discontiguous kernel
 page mapping
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-8-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
 <20261013-b4-mmap-prepare-vma-flag-sanify-v6-8-1aa3c9b139f9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:29:21 +0000
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
- [Medium] mm: mmap_action_finish bypasses error_override for compat tasks
--

commit 21d3d0c977ac349611c733fc3c288ae67e5f71a1
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm: add mmap action for discontiguous kernel page mapping

This commit introduces discontig_kernel_page_ops and a new mmap action type
to allow drivers to map discontiguous arrays of kernel pages into a VMA.
It updates the compatibility layer via compat_mmap_action_abort() to proper=
ly
handle VMA teardown on mmap action failures.

> diff --git a/mm/util.c b/mm/util.c
> --- a/mm/util.c
> +++ b/mm/util.c

[ ... ]

> @@ -1412,12 +1421,13 @@ static int mmap_action_finish(struct vm_area_stru=
ct *vma,
> =20
>  	/* do_munmap() might take rmap lock, so release if held. */
>  	maybe_rmap_unlock_action(vma, action);
> -	/*
> -	 * If this is invoked from the compatibility layer, post-mmap() hook
> -	 * logic will handle cleanup for us.
> -	 */
> -	if (!err || is_compat)
> +	if (!err)
> +		return 0;
> +
> +	if (is_compat) {
> +		compat_mmap_action_abort(vma);
>  		return err;

[Severity: Medium]
Does this bypass the error_override logic for compat tasks?

When an mmap action fails, the mmap_action struct provides an error_override
field to allow drivers to replace the internal error code with a user-facing
one. Later in this function, non-compat tasks return=20
action->error_override ?: err.

By returning err directly here when is_compat is true, it seems 32-bit comp=
at
tasks might receive different error codes than 64-bit tasks, potentially
breaking ABI consistency.

> +	}
> =20
>  	/*
>  	 * If an error occurs, unmap the VMA altogether and return an error. We

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-mmap-pr=
epare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org?part=3D8
