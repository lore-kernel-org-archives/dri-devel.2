Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B042C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28ED10E275;
	Tue, 15 Sep 2026 12:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="al7xG3Qx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92B10E275
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24A0A41B11;
 Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100B1F00893;
 Tue, 15 Sep 2026 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474714;
 bh=3Nr8gcCwi6DEWSLP9EN8/l4h5yq3GfGsy2oDZDwQTVw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=al7xG3QxpordB8FaZac1xk6QWAEGzphwDCGfy40ckeGGdeDP1tbwhbJklTqx5QQFT
 ODvPZmGs3Rku3J2uQB3ChHYQAriES6YPKKW/TWgpaSESxWFOwioknFfQIhOZdlb/lh
 RLkOhFE53P9jFChtaD6A2+vi4SogD6zm9+SM0eAaXOgGkYYLJJfSgO/RrU1jMf018L
 IsZndXI06LzsoDnaEX00kNg9+CSe+xR/UDoSJpVb9b2SoGOi1j19PuVJIg9jG4HZNR
 dl5cjIQ8g0S9+wNIlluWxOi9Rk+9A+i9qr4Dl8RqrHyi07ZG8WPpqBJZWgaHICrgtm
 ZwEgDuMch+DXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 47/50] iio: buffer: install the buffer
 descriptor when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Airlie" <airlied@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-openrisc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, bpf@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, kvm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:18:30 +0000
Message-Id: <20260915121831.6100B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D47

