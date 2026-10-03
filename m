Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B8CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B590310E951;
	Sat,  3 Oct 2026 17:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byV1soFd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A33910E945
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C40360D9B;
 Sat,  3 Oct 2026 17:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075EB1F0089C;
 Sat,  3 Oct 2026 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050204;
 bh=RYdqFs86tT71ewTmb4rZyWnUGDIEu2rWKZQtH7+F13Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=byV1soFdeo+3Eu4FFFjYLc3DDrzMkuvXdQv66VoS4PIe5WYo5djLQBLrRA4EyXdP7
 OUt6dC77pKTctff3rtjz9LUIosJdZriTnRgVTMDFK12wbznTcENGcmjYAHVt8AfIYC
 28hAk2SosnN+kKBvlvr7tWFj/Fjtwtm9bxmc45HCIfP6D160S8seAvLBJ0FMGRE/EN
 oJkD6lwkui+8kfpllwpmJv7WyDNV6n7gMg+mva0Trs69dqdBGn/aD6+rpApfQd82ov
 l1jV6WRsG2Wrafrp0JKXRoDtEaq2Q2x1gBXs0AOSsBEWjCVts2+Lm22tyiyP0dkYJz
 a8d2nprs/hfvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/38] mm/vma: fix mmap_prepare file handling, remove
 file_doesnt_need_get
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, selinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-rdma@vger.kernel.org, linux-perf-users@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 bpf@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-1-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-1-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:43 +0000
Message-Id: <20261003175644.075EB1F0089C@smtp.kernel.org>
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

> The map->file_doesnt_need_get flag is confusing and the existing
> implementation has holes.
>=20
> Drivers are permitted to change the owning file of a mapping. If they do
> so, they are required to take a reference on that file.
>=20
> The mmap() operation which ultimately invokes __mmap_region() is guarante=
ed
> to drop the refcount for the original file the mapping was made under, but
> this is not true for the replaced file.
>=20
> This has been addressed so far by tracking map->file_doesnt_need_get, whi=
ch
> is rather poorly named and unfortunately fails to correctly track whether
> or not an additional put were needed in a number of cases.
>=20
> Make life easier by removing this flag, and instead drop the reference for
> [ ... ]
> No in-tree driver is impacted by the incorrect implementation of this
> currently (no driver that does this is mergeable for one), so this does n=
ot
> need to be a fix.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D1

