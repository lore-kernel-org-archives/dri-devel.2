Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD9C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1E610F46E;
	Tue, 15 Sep 2026 12:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jH8MeFUt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378EA10F46E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:09:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3EE84096B;
 Tue, 15 Sep 2026 12:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED881F000FF;
 Tue, 15 Sep 2026 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474173;
 bh=UYzMflbMuPv9H/GLK1g6J9E5AwtdI+O/+Pdc0wsdGlQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jH8MeFUt+Ca90GijJLK5hVAYB41iBAVkHXhYxlgSQZsl+pyWmTzGkAYZ9RXqYBDbG
 rKZCB6pYmFyP5M1bk4Irpshq50uz2b5QkCnTtwMupHWy+yvoXlLhHmQpzBrkPJbweM
 DOJFaJK8kjjNY5ZP2iw190s62x+TzNavmrmqQj5YP/0STVvoLNJYJafDKfgf5ojLUP
 LuZmhYwmQV123gJgzbNrAwrP+hPwOyQBF3mK6DppyLtpzOvR8DpMm18peMtTYKiuPd
 RpvHgbF2jJw+E059MS7iRdmviODCKeE/Aiqyn0EbGm/VrErx286rEzup2WusNoTIC3
 +JC3oUetgOKKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 33/50] io_uring/zcrx: install the exported
 descriptor when the request returns
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, kvm@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, io-uring@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-gpio@vger.kernel.org,
 "Eugenio Perez" <eperezma@redhat.com>, linux-csky@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-um@lists.infradead.org,
 "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>, linux-mips@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, "David
 Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-alpha@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:31 +0000
Message-Id: <20260915120932.0ED881F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D33

