Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2665C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A5D10E8E0;
	Tue, 15 Sep 2026 11:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QZ2fNNJC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED4910E8E0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:47:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65AF9600D1;
 Tue, 15 Sep 2026 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06AB1F000FF;
 Tue, 15 Sep 2026 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472824;
 bh=1FXL4Jf8yBVgDdd94W09xM8udoaJZ5UUF8s2j4f47FI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QZ2fNNJCuZ/sDU9+NThrbq1C/6AJLSLjjYgkUbk/7nyMpmrJulfwzYoTCnnUhGe1L
 CM809wjln9o8pUKvHaoaakBSdFe1J5tqURNyqgIGcIuV6TRA8iPD7jKUcKFqitGx8q
 oytUrD66lpaS6duQZikdiD0MeK2wDhNbj/m9eIQI7ZfsqhvaTsVLdZ3ePpFdtQU9w3
 reft3HQkQjN4ISX6sjFZlRkikFCalaD/JcuYF22HxwucYna7hJWQtoxtZdruPzMFDI
 MwYt7lw+eOd2EaBTBnZye65X6XApTnuMpo5CD8CFs/K5wRHgdlLP4ZJrnz4u511/Ze
 ZevBo3IdlwroA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 07/50] csky: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-mm@kvack.org, "Ingo Molnar" <mingo@redhat.com>,
 virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Peter
 Zijlstra" <peterz@infradead.org>, "David Airlie" <airlied@redhat.com>,
 linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "Jan Kara" <jack@suse.cz>,
 linux-hexagon@vger.kernel.org, kvm@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-7-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-7-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:47:01 +0000
Message-Id: <20260915114701.C06AB1F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it after the untraced system call has
> stored its return value. A task that reserved descriptors joins the
> traced path, where syscall_trace_exit() commits them before audit and
> the ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D7

