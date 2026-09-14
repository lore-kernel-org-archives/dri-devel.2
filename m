Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AD3C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85E310E1D6;
	Mon, 14 Sep 2026 15:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HfT6yU8H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9482D10E1D6
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97EF06025A;
 Mon, 14 Sep 2026 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAAD1F000FF;
 Mon, 14 Sep 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789400422;
 bh=mBF6+D5851OP0+RBXASeBH5sGFKcTHTWtmvG0ev37TI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HfT6yU8HaojhFMvk9XASK5imu2bqOTKnurQmiy6//QQT9JnJ7A2OWp3WVyisKXRPv
 IHWD6mzbSvvf+AZtpY1n/Ir2562C0cezM64uGVgOAPtNBERHDGaZAwIenkhxf9Lp8n
 Ia3qK0dObEeCJSlRyG6Wq9BCJ96GbY1TSwp7JqDL5pCFwFcw2r1xRHU9R7J3iLDydA
 5G3b/iDTN6aXJTbk1/tGhU4ZOH4IF6Glt83ooxLVwQwuyOOlFUZLs2gliARgvgUw1Z
 4lTGTf8aXMaClZgcw6dPg08zoHhS8l29ysC7+MTm0m/utmYsbdoL1MynkbAJYB5XLt
 +T/mXIrITmMhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/40] mm/vma: fix mmap_prepare file handling, remove
 file_doesnt_need_get
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-scsi@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-rdma@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-1-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-1-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:40:21 +0000
Message-Id: <20260914154021.7AAAD1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D1

