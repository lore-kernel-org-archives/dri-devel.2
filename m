Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F5C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345EE10F2F5;
	Tue, 15 Sep 2026 12:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A/LXiHVz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3E710F2F5
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:21:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3D32414DE;
 Tue, 15 Sep 2026 12:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCFD1F00893;
 Tue, 15 Sep 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474861;
 bh=vonrQofTMqh1TZ5f0j9SBLxkepNFIrQaGLKCiSWoy/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/LXiHVzihnaMdFTMhS3rVKx/wDAkjfj2gDEj8DTAYNjfOe6DG+9Ca/cCtFyPhPE8
 y77qZBSfSC9sS4k/RUcIcuvRnjcCwtLvS7YSZE1xN5GAlkblWsWACrRhYCN5wIFKor
 zT8EpjnA5d63Lul165thqtWkMhkC99tbZwqRFOqKxO0tRQPj3pAlGire6kQh45O8b2
 eS2NZ8W+DwDtB+jiWr5CwIe6sK7rjGmOKgcSbUdZiQO/XTHrxK9zTNOllt/wu/a1To
 v55MzO0WPliGPDb7kJyu1DDpQ4ZeGJMNQLBjGR50wccFbjBl7QsDZheHlcTEqD3nHg
 F55P5vgYAJ68w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 48/50] misc: fastrpc: install the dma-buf
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 sparclinux@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-um@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>,
 linux-hexagon@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, "Ingo
 Molnar" <mingo@redhat.com>, linux-mm@kvack.org, linux-gpio@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-openrisc@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "David
 Airlie" <airlied@redhat.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:20:59 +0000
Message-Id: <20260915122059.CDCFD1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D48

