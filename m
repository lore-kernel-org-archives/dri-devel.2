Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3210C982C3
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EEF10FBD0;
	Tue, 15 Sep 2026 11:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XT+DfR2f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B996110FBD0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7623741342;
 Tue, 15 Sep 2026 11:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973821F000FF;
 Tue, 15 Sep 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472892;
 bh=+hCyRfdYxaDHjUjrbC2f1l+hk2nsMICX165AMlBJOFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XT+DfR2fI9lSDVHTRxc8fxOJ84VdAucgEp1D7Rsg22J1SRRtMEiE19TvXZrbO4lIZ
 TxJ/l2gehvn5l2kdO5dHi1/HiNiTrodHb341ROtDKEQB4TK5qE077C+sr6m2ZRGq1A
 YhT5vOmSLIZn+aB2D2xVS3UmQD+O73OuHKWdb/9Q6SJtudR7Vr4EWHcVJIUSGq4wWb
 EwguAAzu7/EG5DnE1SXHjXkeQUDSQ1mouWrUTfOdgFhzkd3ZU0wbFF/c3Yr6mjzm+T
 iHVYaDYddqfXs43IVkcTAt+29bmm0zSxlyvXzfaYtnXgwc/VcrMwi/snt2mFoFeFgS
 xEBfPHquaOhWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 06/50] arm64: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "David Airlie" <airlied@redhat.com>, linux-parisc@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mips@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, dri-devel@lists.freedesktop.org,
 "Jens Axboe" <axboe@kernel.dk>, linux-um@lists.infradead.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-snps-arc@lists.infradead.org,
 kexec@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, io-uring@vger.kernel.org, kvm@vger.kernel.org,
 linux-hexagon@vger.kernel.org, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-openrisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:10 +0000
Message-Id: <20260915114810.973821F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work bits. el0_svc_common() rereads
> the flags after the system call and takes the trace exit for any of
> them. So a task that reserved descriptors ends up in
> syscall_trace_exit() which commits them before audit and the ptrace exit
> stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D6

