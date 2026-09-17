Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB62C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A36889F5F;
	Thu, 17 Sep 2026 17:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jGrO2X/f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93B689F5F
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:27:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31CB36020C;
 Thu, 17 Sep 2026 17:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183BF1F00893;
 Thu, 17 Sep 2026 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666063;
 bh=jKZOZ0vCACLspHtlfXg4nPEC++KYAdALEYHNye3uvLk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jGrO2X/fGLfcGPgd+k144I7KKJWcyW5zLeF7F13DCffI84Z2PsZeTytXcB9iHnXG4
 z8H4SAbEotKAiyVXoPgfMu8NW3CFQyYTJ/i0nDkiMwfcM+Azdtr1N6DxNXAqnG1e/3
 73efvolGTy5l5BWgoUoq4lKxklwFjSBU5OdC1mJNK2RtI6B9gPSH1z+Ogn/W7lHB1q
 I9BI8LiiucPopUw7Qay2BKv/40OC6Dz7V/b16Fdh4JBfb6ZW4jGXdVa6zEF7GDE+XN
 cvv7MH41VE7zVG8GhsuoGSbAPBy1gwceeD+fwpxlcaIVHtzs+ZQR+KGNogMJrVQgMW
 CBj4JnE4Mbn+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/40] fbdev: defio: assert FBINFO_VIRTFB, drop
 VM_IO, add VM_MIXEDMAP
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org, selinux@vger.kernel.org,
 kvm@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-19-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-19-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:27:42 +0000
Message-Id: <20260917172743.183BF1F00893@smtp.kernel.org>
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

> Currently all drivers which use defio allocate system memory. All of them
> also set FBINFO_VIRTFB, other than ssd1307fb, however this driver allocat=
es
> system RAM, so simply failed to set this flag when it ought to.
>=20
> This patch sets FBINFO_VIRTFB on ssd1307fb probe, then drops setting VM_IO
> in fb_deferred_io_mmap() and instead requires FBINFO_VIRTFB to be set,
> erroring out with a kernel warning if not.
>=20
> The logic requires a page from the driver and since commit 1ecbc7dd2902
> ("fbdev/deferred-io: Always call get_page() for framebuffer pages") has
> always required it to be refcounted, so this was implicitly already the
> case.
>=20
> Finally this patch sets VM_MIXEDMAP, as the logic is mapping
> kernel-allocated memory so this is appropriate.
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D19

