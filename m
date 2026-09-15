Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2F9C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51210F447;
	Tue, 15 Sep 2026 11:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dEjnjHjN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEC210F447
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:54:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4552C43CEC;
 Tue, 15 Sep 2026 11:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8371F000FF;
 Tue, 15 Sep 2026 11:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473249;
 bh=rEaooNHHSzMvHYDvwYrru6UOPRcxabqKjG95OLRLlN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dEjnjHjNvNIuSaPYTHfj4KVcRdWnf0KMr5ngwYgP13UVEN4ixsOjP/LGTY00a1F7i
 SrECUFxW1WISw+Sb9e943yH6GxglJXZz6/98X328DvWbvebyYY0VweNP2I8cG1QByw
 Gji9eMFm2AAVp7PkwCHxT4RdIR9rAmD6kZzVeYGbasnMh8yVep7bz3ac2gDe5wmKNa
 E60wDWY0t8sIf7wr0+2mcu/fK44J9sYDVuZZ9raSVBw8fhzXy625/hIuVibz2cM1G1
 heryhbL45TCscgniXJxfFQxgFi5MNZtk5vPFvLwJbiB9YO/wiDhzcHs+qEgelm4u1w
 O3GQp5W8DIzZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 19/50] file: require the syscall exit hook from
 every architecture
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-gpio@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-sh@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-csky@vger.kernel.org,
 linux-hyperv@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>,
 linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, bpf@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:54:06 +0000
Message-Id: <20260915115407.5E8371F000FF@smtp.kernel.org>
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

> Every architecture now either uses the generic entry code or provides
> TIF_FD_SLOTS. The fallback that deferred without ever committing
> can go. Make it a build error instead. A new architecture can't grow
> fd_prepare() callers without the syscall exit hook.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D19

