Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3B1C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAFD10ED74;
	Tue,  8 Sep 2026 20:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WB6J2sE2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1F410ED74
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9744340A38;
 Tue,  8 Sep 2026 20:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849E21F00A3A;
 Tue,  8 Sep 2026 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899784;
 bh=HVCGLoPkn126rN0odc8hwsZOlqSwM04IzYk3VuN3iB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WB6J2sE20seCrJUdHDGgLIlfMQlUur2DjkJVyDDLKkqm+uw9oDyxq/f7jpRCRAZAK
 ZNUwEsHjOJkzPA5V0RyuVZLyPdc2c5W4KAkAff7M0Xc+sUsYkmtZvpqvdYhbfbTIe8
 L9ulDhYQ/ekCUvBkFq3wuA3b2qj/NJOSMv98MR0JEGcXdZ16q7G7TFXJ/o8HJ828LA
 JAeAUCKGBtmIj4LdvDmd+koX9VzNJ9VaD+fAOt22S+l6i2hgDpJcCe1Faw7MF34eag
 KAC8aCz+BZdj5MdZx2hDVZCQcY2Q14WNvYh0DSPwybS2QW7lzS0zymLlAfi4BoF+6G
 tQlWmsfz8VN5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/39] HSI: cmt_speech: convert mmap hook to
 mmap_prepare, refactor
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, selinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org, kvmarm@lists.linux.dev,
 "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-19-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-19-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:36:23 +0000
Message-Id: <20260908203623.849E21F00A3A@smtp.kernel.org>
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

> Use the mmap_prepare in favour of the deprecated mmap hook as part of the
> work to convert one to another.
>=20
> Since this is simply a refcounted kernel page that has been allocated, it
> should not be marked VM_IO and should be inserted using the kernel page
> insertion mechanism, so convert it to do this instead.
>=20
> Use the VMA descriptor's private data field as a scratch buffer to store
> the page in - this stays valid throughout the kernel page mapping
> operation.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D19

