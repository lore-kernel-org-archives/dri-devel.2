Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC6C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7544E10EF4D;
	Tue, 15 Sep 2026 12:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ea1sJwsB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FBD10EF4D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:18:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2BA5602C4;
 Tue, 15 Sep 2026 12:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6111F00898;
 Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474716;
 bh=vrVAobJMjM7S9OZZMwIDwvr8ty2bA0kqwagLpHQp40w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ea1sJwsBr/Nvel740b29/2lnm8kv13L85FditgVsIEu95cKYPQZU0Zm86Po1jnZNR
 WHN070goKjNpVo1FRyPViEa8NGr0QNUX2ucQBNO5lGEpXDGQD7U7BclSRhluMnxtKP
 ATnOY9YQY/9J5OJE6jroQgQS5sfBOnMZtK6e3d1b5IYszHnQqLJX4JE1tZ1dgWaKGz
 MVf3djXQJIyElXt0yrKwDYp8btcu88OnDKD8ru7wqrjSAcI7zj25kTBGPYQCXOGFwa
 RfYXn1Lwzeg0QAuqyZ/UnU7T5x+37hRI9c8kwg/0XtOV9Mo2i3dXkFawFgls2HqTB0
 kguWCX48YbslQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 45/50] accel/habanalabs: stop putting the
 dma-buf descriptor back on failure
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-alpha@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev,
 linux-mips@vger.kernel.org, kexec@lists.infradead.org, bpf@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jan
 Kara" <jack@suse.cz>, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 "David Airlie" <airlied@redhat.com>, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Jann Horn" <jannh@google.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:18:34 +0000
Message-Id: <20260915121834.8E6111F00898@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D45

