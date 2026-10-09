Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578ECA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F77A10EAFD;
	Fri,  9 Oct 2026 18:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b3C9IS5+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9EE10EB17
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:39:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E618841980;
 Fri,  9 Oct 2026 18:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E41F000FF;
 Fri,  9 Oct 2026 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571178;
 bh=lnMo3Kn39v/IVV8tPmzh8JgGGAbd4XjAAc46euKx2Oo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b3C9IS5+kdMRuxlgydRVDid8tMgYuqta/oXLMR7oO2BvzlH+RMO9FhPtbMXeYsWWX
 WPHEx8jM4vdZbmjA3YOl08hEx0V0gLAXPhKZb70kvE8mqagwxko89Bgk+25uJG2aPw
 ouPNEdURStPMY+7KCdMvO65kWn5ewFzn1BgKdcoQkAU0GZJvgSeU9sLywf8a2dQ6rB
 jUJEPiNGuVTRceIjKq69wUwTb6hbLDIygaSqZfN13Dgbu0CY80h/8Ni7cP8OTOAffg
 e46b8U32cVMninybIkoWce9/PVKyAcmzbXgdDaol0dqgl9VjPaFL1pBQsTSDC3cIts
 nYYAFUGl4Jckw==
Message-ID: <sashiko-outbox-165959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/38] HSI: cmt_speech: convert mmap hook to
 mmap_prepare, refactor
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, linux-scsi@vger.kernel.org, bpf@vger.kernel.org,
 "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Oliver Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-usb@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org,
 kvmarm@lists.linux.dev, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-19-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-19-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:39:37 +0000
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
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D19

