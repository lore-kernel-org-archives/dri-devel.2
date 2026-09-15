Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074DCC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393FF10E29B;
	Tue, 15 Sep 2026 12:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxoLtCbZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4416710E5E1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:13:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86C3F60261;
 Tue, 15 Sep 2026 12:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCF61F000FF;
 Tue, 15 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474391;
 bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mxoLtCbZ5g8NJT38V2nXx3kQMXq8zz7wa261boot03y/1mmOb8uEpnb4HgvVzXqbE
 Lc+BLr2MEwB+7zjlCcD9Q9qeYqKVACCOsKFW9yMVpHmTXMqtHVkiNOOQlElz6DH2cL
 qfBphOZ3delbUDrFqm1dV52+sHB7JppWyVGvQVAhcP+Vcr7mTyrRaVGoKVuRlWxgrA
 a0ZQjTcB9Fxaqpd6c2a/Z1vb/mAmnfz0/bCd8zDO3h3sznLEIo6QHFgrENGMHDk9qf
 flDXJ4YX6mmlM4kAG/dg8PRmGwgcbH40eS5i4n9wiRd9k9l8mEd5AlXPVBescbcVDo
 rqQ5leD9k9+dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jann Horn" <jannh@google.com>,
 linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>,
 linux-alpha@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 "Ingo Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:09 +0000
Message-Id: <20260915121309.7CCF61F000FF@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D36

