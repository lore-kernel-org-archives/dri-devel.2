Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7A6CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9674010E993;
	Sat,  3 Oct 2026 17:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SD8empGI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4585B10E993
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE1AF60DB1;
 Sat,  3 Oct 2026 17:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A4E1F0089D;
 Sat,  3 Oct 2026 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050222;
 bh=24nrbL8RIT+6/KLDj30o4CAiwcbrAadW3J9zkkSxsCU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SD8empGIK8fMk6UVsAjJz2csSq3tQn4bap5f1F3rd17UrwIlxmr00kWyE7OTQCzIN
 UlbSgQk7jF2M3KHONAxFA7+MVSIE4L97Kj0tmJ3BevJ51OzG1zNiUFMXCkQmNj2pm5
 OZ65oeeRCfg4es7p6mBUxsHC2qQ4Lq6koytKDe5QE4T+/AXiMfHcnDlx3VQmerqJZe
 xHwhBJctidB6a9GTdanQEDhi8OoXXnl/Z8ZkDgV/+IzqKtAbOne0+ahgbIa4dqycLX
 w+lQiPWIYMHA/js2/omiLZQrTcboeorX3+zswGIkNiE52AF9zSTdQ1yD7z9ZhDU9CH
 rJoRXJMWEOHMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/38] mm: consistently validate VMA state after
 mmap[_prepare] hooks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, selinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-3-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-3-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:01 +0000
Message-Id: <20261003175702.05A4E1F0089D@smtp.kernel.org>
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

> When the f_op->mmap_prepare or deprecated f_op->mmap hooks are invoked, t=
he
> driver might have done something crazy that is not permitted by the kerne=
l.
>=20
> Currently we check for three such cases in __mmap_new_file_vma(), but only
> if the legacy f_op->mmap hook is used:
>=20
> * Did sparc ADI result in invalid flags?
>=20
> * Did the driver alter vma->vm_start?
>=20
> * Did the driver make a file-backed mapping on a read-only file writable?
>=20
> Generalise these checks for both mmap_prepare and mmap and apply to all
> invocations of mmap_file(), the f_op->mmap and f_op->mmap_prepare handling
> in the core VMA code and the mmap_prepare compatibility layer.
> [ ... ]
>=20
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D3

