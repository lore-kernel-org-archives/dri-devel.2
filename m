Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06038CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE9110EAC3;
	Fri,  9 Oct 2026 18:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MrSmUbNc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F24B10EAC3
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:25:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD22C6020C;
 Fri,  9 Oct 2026 18:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E61F000FF;
 Fri,  9 Oct 2026 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570339;
 bh=MK7Nr2Nu7uvhQn31gvJdVwUygXMsiFq2UzEOYgc5v2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrSmUbNcQHbTnB89UHYRAjVu6CmoeldVEIyixJx8+kLiVxlBDw/wNHZP7cTJ420PW
 Rs4mZ9xpkxGWFBPmun0PvJkmc9/Gq+Da5OFDw0Ryv0OVRZjInTEQ9XTxVuz8WmmMBO
 NVTO/4AZZIjMrCaCdmJD6iLUPLv/BrlkWqqfYr70BZduAwqXQpTd2M6zD84iCyk+BM
 asriG8bekDwJp0jBg/3kUizUb33UvKseso6yel9/BoO9c9BXBbfIrz6qLNNRKwl8nU
 8x0v2t4WmSF5NtltNNTDchpDbKMpRgPt2rPJbr1NombtPrOilnexI5YvK4EzKAckt+
 roOAyMZ7VyKuQ==
Message-ID: <sashiko-outbox-165942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/38] mm/vma: only allow mmap to clear
 VMA_MAYWRITE_BIT if not mm-managed
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-usb@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-rdma@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, linux-perf-users@vger.kernel.org,
 selinux@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev,
 linux-scsi@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-15-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-15-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:25:38 +0000
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

> For ordinary files the only way the VMA_MAYWRITE_BIT flag is cleared is if
> the underlying file is itself read-only.
>=20
> This means that mprotect() cannot mark a shared mapping of a read-only fi=
le
> as read/write, as doing so would violate the read only attribute, and
> permit writes.
>=20
> In general, we do not want file systems to be able to do this for
> read/write files.
>=20
> Doing so would violate fundamental user expectation of file attributes and
> likely break userspace.
>=20
> However, drivers pose a tricky problem here - the /dev/xxx file may be
> read/write but provide access to a resource which is fundamentally
> [ ... ]
> As no driver which clears VMA_MAYWRITE_BIT establishes an mm-managed
> mapping, no functional change is intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D15

