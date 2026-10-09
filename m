Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A597CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6E10E358;
	Fri,  9 Oct 2026 18:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nneO5/se";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95F710EABA
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:19:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB5E56020C;
 Fri,  9 Oct 2026 18:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7BD1F000FF;
 Fri,  9 Oct 2026 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791569943;
 bh=FGR6IAJ22ppjXpr5xm080mWSWuyxnEDDo+UtB4ySOG4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nneO5/seF62iUijhFLoCsBQRM40H/nOYcsQEmtzn+cCnYDeEQ35uMbOtfkMvTDefL
 IbBBEOHhiaFI2mWG5Bq0c+JTLa52QcZzJIblpYUGky+GglszQAmqRau0D8oxMj4xIy
 heQDk+waRR1wHju3wr+dj40lB2cV7w8FR+swYFWowEK1P9wG0TstZCuwh+szuxXuVl
 S/AcScP9ZozJy6LUFGVJeL6v2Jrs8IILKE6He8jUP3drbmwQ0139GxUx405PBggsBp
 LRBH0iRdi2PBivM+TKmomOojKiLXYs9ApEdg7Wh9G3nt6Tcw9z5BXLM65ia+RwzcAf
 Xx83zN0dh6Upw==
Message-ID: <sashiko-outbox-165929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/38] docs: filesystems: update mmap_prepare docs
 for discontig kernel pgs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, bpf@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev,
 "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 selinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-usb@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-8-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-8-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:19:02 +0000
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

> Describe the newly introduced discontiguous kernel page mapping mechanism,
> detailing how to use it sensibly and how the API looks.
>=20
> Explicitly detail the various discontiguous actions available and how to
> use them.
>=20
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D8

