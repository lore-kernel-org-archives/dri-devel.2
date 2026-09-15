Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ADEC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A8F10F958;
	Tue, 15 Sep 2026 12:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ngAb15T/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B08310F7B3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C1CB60261;
 Tue, 15 Sep 2026 12:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D50C1F00893;
 Tue, 15 Sep 2026 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474549;
 bh=xCl8jNs77PZZdSIvmzClNS4N5YJKQYnamGutVTepnCk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ngAb15T/yAkTwE1+YE6SOVKj8Rli4aHVUkDtOhNqgXnslknQomnBjXDhGUUHHgw5c
 t1KNN6ZH3zr5Gtf1iBmlLvi1+EedRg6qAtTNkQ7kQMdZyxrotp61A/kxMP1IsoWP3Q
 0HPEwAzkXmBRniukPUCUyctzd9pxcukzIZA+ewzHxw/boCKe1Jar8qJFg1/aKtu5I/
 dpLp1T084yx8feJuPVTuB36srOvPtJerVeDd4qv1zFiywDAW7LoZnflX7kr4TjuMev
 HM37MdMxXfwNOlWakuuKYP5RXCJcKz7vv76rj0gWBeGPIn4OJc58aAB53O2zHvFgkb
 1XTJ0zBTt12SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 40/50] KVM: stop putting descriptors back on
 failure
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org,
 dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
 "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org,
 "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:47 +0000
Message-Id: <20260915121547.9D50C1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D40

