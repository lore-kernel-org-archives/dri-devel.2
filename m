Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30599C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598110F479;
	Tue, 15 Sep 2026 12:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JM7MUu1K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF1110F479
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:11:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B5A9600D1;
 Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DCB1F000FF;
 Tue, 15 Sep 2026 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474283;
 bh=pymhjA3IHUvfc7ZhMmvcj6PWvzmH+JOQJc7von1cOC0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JM7MUu1K3sK0BfbZuufGSUMTjcYng5dpse/wo3EWLf21O2gUgw322DSgVB01AFTtW
 t52UvxD3bLuUqeuFrp1OK6t6wHAM7ouPbrca6pE9eJrANghgkKMIS9n0Gf/wy0wloB
 LbU8P8uOHsEx8fNW9Woaznh5JHxhxpBoxXgSLs2p/Y+nXpZgm4aiuBP11/FKE+6Agh
 dOG9FMxrGVQ/eMMAs/LGH2WwzJPb1jSL8PT90CSvhiLFlxbJWRZR7M9jUUHoxVSb0a
 49DnQM0TYsO0aM6hSLHh3aoQiYMzGZw+8DgpMeFwYhEfOeLW9W3pCge4KeYSBScMZG
 GXoCvsjJhnAaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 21/50] io_uring: commit fds per request
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, sparclinux@vger.kernel.org,
 linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-sh@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-snps-arc@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-hyperv@vger.kernel.org,
 linux-hexagon@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org,
 "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org,
 linux-csky@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:20 +0000
Message-Id: <20260915121121.62DCB1F000FF@smtp.kernel.org>
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

> io_uring requests don't complete on syscall exit of the task that
> submitted them. They complete:
>=20
> - inline from io_uring_enter()
> - from task_work on any return to userspace
> - from io-wq workers and from the SQPOLL thread
>=20
> The CQEs are visible to other threads before any syscall returns. So
> commit the reserved descriptors before the completion is posted. Commit
> them after ->issue() based on the request's result and before every CQE
> they post.
>=20
> Nothing reachable from io_uring reserves yet. Once SCM_RIGHTS is
> converted this keeps IORING_OP_RECVMSG working from io-wq workers and
> the SQPOLL thread.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D21

