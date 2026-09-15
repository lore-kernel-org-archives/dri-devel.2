Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E592C88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC9F10F46B;
	Tue, 15 Sep 2026 12:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a4ZZV63E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5844A10F46B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:09:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF82C600D1;
 Tue, 15 Sep 2026 12:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464481F000FF;
 Tue, 15 Sep 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474190;
 bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a4ZZV63EloWFTnOUlHK58XwOK2rkeCsu03ufhBV72Tiipl5qWiGg8pKw75jRnalat
 Px+Ej4QbTLpchvWen5UHVg+abfR3qMIoHWKRq5zOfC+6fvUdhpGBml50Plsl14BxoA
 MD9L1UkPG2s8tttZuNhCrGp0Ac838MyFzPadcw7MIZBEqZ9CQQXdlYMZFCITTIwQVR
 e8ZVbA+QeVGcVPqWoOLbEKnwhY2HpmkZP6Db2SJHGUaetI9dgl3FBXgJQQpNHkGFqv
 7oyl/HjPvr3DAOtUTzbk2i14RAaCiMZAvTqJbij4737kik3jJY1RQy1e4vJFFsF6gN
 uDBgNLmQTLN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 32/50] liveupdate: install the session
 descriptors when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>,
 linux-gpio@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org,
 "Jens Axboe" <axboe@kernel.dk>, virtualization@lists.linux.dev,
 linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-alpha@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:48 +0000
Message-Id: <20260915120949.464481F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D32

