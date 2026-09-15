Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65725C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B223910E5E1;
	Tue, 15 Sep 2026 12:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SQ3aDU0Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C9010E5E1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57C3740450;
 Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E91F000FF;
 Tue, 15 Sep 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474497;
 bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SQ3aDU0Q8GsPtoMGWFzUtgXPVhQk5j3tT2hP5/IYPK7pNnGp/W35LdJkurCxq/UDj
 jXECYSMyRfHDZKzN98Ln98DAG1rH6aAR4ISmzyGlU1rsDvw5Q93DNzrkBW2qSN7IRC
 YJr9cCfLCK65yz/lnkKU0h/88SazD0WGxzlXFRwUnZmmA1pIC11CPHPte6Jw/NVEZ8
 jp0yJWYB7+6Cgap52rqfdYHOC0u+j0XckjkUTQa+uZ9aKsrGomUpcl6BdIHpYiyzm/
 Rqj2wKLDgmWRUAKCkxgoX9x9LTH43+wakiVHy5v4VFxVPQvMYbRVfHWWmjs+K15B5a
 6EBFBzK+SsdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 34/50] sctp: install the peeloff descriptor when
 the syscall returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org, linux-mm@kvack.org,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
 linux-parisc@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-openrisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:54 +0000
Message-Id: <20260915121455.398E91F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D34

