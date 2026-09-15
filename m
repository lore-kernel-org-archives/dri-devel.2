Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E1EC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AE310F44C;
	Tue, 15 Sep 2026 11:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEA46w/j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEAF10F44C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:48:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 617DF6025F;
 Tue, 15 Sep 2026 11:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC01F000FF;
 Tue, 15 Sep 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472885;
 bh=EYRIdKp/FfwNNqSNi/pBExuEJpqL4OpkJpzESq5stW8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KEA46w/jL9NKEBXKdpDRVvgUVpdw6hOUBCW8wQyHI6NwDPC4Am8sCmr7j0WvoKK5v
 Bi5VQmzbc0sNbBRMKVoi5XBwnkMmxH9tNMHqDw3ItnBUybU4feNnNWv7cT2bB8AjBd
 dY6wMyYKrW4Ezf2ZF1yg1nT3JYwFHCkXSv5QxKi4ShZMZv5F2iT044OEtU+pEb+idW
 Tog3ab9yFoO5+qKuA6KwBgJKAx/c448Pa5xlXvcd0f4KIxP8erzSA5JNQBA/bgLLZB
 IGHhr6D+xE3ldAUlwnI0HynOJtRl8do+l5clEE47V/0XL01LM1u7vq8zJwzIFJqQrv
 ilAIi+rTQ2iFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 10/50] microblaze: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-openrisc@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Jann Horn" <jannh@google.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Jan
 Kara" <jack@suse.cz>, dri-devel@lists.freedesktop.org,
 linux-um@lists.infradead.org, virtualization@lists.linux.dev, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
 linux-gpio@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org,
 "Oleg Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:02 +0000
Message-Id: <20260915114803.44BC01F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work mask. The return path rereads
> the flags after the system call and calls do_syscall_trace_leave()
> for any of them which commits the reservations before audit and the
> ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D10

