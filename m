Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53DAC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B7910F465;
	Tue, 15 Sep 2026 12:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TYtZVg6I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516DD10F467
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:00:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 389B141B2F;
 Tue, 15 Sep 2026 12:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE4C1F000FF;
 Tue, 15 Sep 2026 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473656;
 bh=MldQSLt+lfDM6akgn8f71Sps4Op9V02KPlLk0XcZRhc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TYtZVg6I4Bh2MSIVyOp4GLsBjyldHMWNSOFvEULmB/p14azRXWqSnww77YB7+TPqN
 ScvufVzu/TJTXHoXtbu6nkMmHWq4H4dMpP1MqQSi0Nmrto4rdEsiZifxC0Gp3ctWOs
 gVm0pQG3DVlsqt2P+zJAnwEEyISNTbCWqNK7nqDQbAM5w/PqbddR2Jr7q9aHUm+QFp
 3CM71ghQDVb22etuVzHNdfC2YmQHMxeMwBg3BFoQVgyoGYCR1SeIZz2CuWCHLj4qhZ
 TcgsJSPylBVRit7lOZeS75JIgRGNA5o89jEC9Doqt4/emxXQvDifGb95FahnRJnIlz
 1NumvA/sq5Uew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 23/50] file: open-code receive_fd()'s immediate
 install
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-openrisc@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>,
 linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org,
 sparclinux@vger.kernel.org, kexec@lists.infradead.org,
 linux-gpio@vger.kernel.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 "Jann Horn" <jannh@google.com>, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, io-uring@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 bpf@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:00:53 +0000
Message-Id: <20260915120054.5AE4C1F000FF@smtp.kernel.org>
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

> receive_fd() cannot defer to syscall exit as SECCOMP_IOCTL_NOTIF_ADDFD
> installs into the target task and hands the number to the supervisor
> and IORING_OP_FIXED_FD_INSTALL runs from an io_uring op. Open-code the
> get_unused_fd_flags() + fd_install() it did through FD_PREPARE().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D23

