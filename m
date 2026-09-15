Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC86EC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5860910F468;
	Tue, 15 Sep 2026 12:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ciTyjsYi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C3810F468
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:05:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 618BA60261;
 Tue, 15 Sep 2026 12:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4910B1F000FF;
 Tue, 15 Sep 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473927;
 bh=9fBEtIbr3AFyAksoQqS3Fbydy5vpB4nMaKZT39mGc48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ciTyjsYio6YcUd6U+CzkUXMFWJVI5JN8YpF3LWAF35D4RcZO6WNyNNLXWTcTNKx/k
 phMotj0kCSRJiLRwEB6PukDAqeOWTf+ZkB0jp+D5F2leVdFoUNkcjEaKJx1upIioCP
 CUcHsmrqrKX9GAlkCPX6E26buGa/rDYMQLBRn2YZpYiLqv6kE2OPMZp+B2G/43JgPY
 VQ3gvXiSdHMDyE74NA/AxGmidg9o/oGBR74v2qXcAt1S74qyth1DbIflVP8V9zvpQm
 0rcjVCp5RxoIduGdCiF4608I/waS+6ME56RhQGnLGMkkRdYNrNVYyQVY30p5DEkuKy
 JPaEc4INykdeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 25/50] file: reimplement FD_PREPARE() on the
 deferred fd_prepare() path
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-gpio@vger.kernel.org,
 virtualization@lists.linux.dev, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "David Airlie" <airlied@redhat.com>,
 linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-25-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-25-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:05:24 +0000
Message-Id: <20260915120525.4910B1F000FF@smtp.kernel.org>
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

> The FD_PREPARE() cleanup class allocated and installed immediately and
> required fd_publish() to be the last thing that could fail. Reimplement
> it on the deferred path. FD_PREPARE() reserves a slot with fd_prepare()
> and stages the file on it. The syscall exit installs on success and
> drops on error. fd_prepare_fd() and fd_prepare_file() now read the slot.
> fd_publish() is gone.
>=20
> Convert every FD_PREPARE() user since fdf.err can now become a simple
> IS_ERR(fdf).
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D25

