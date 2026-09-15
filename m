Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD5C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B7D10E5A0;
	Tue, 15 Sep 2026 12:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T+YTN+mc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0621610E5A0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:17:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8E1F43247;
 Tue, 15 Sep 2026 12:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00241F00898;
 Tue, 15 Sep 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474664;
 bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T+YTN+mc0FREo7pxVue32qEB7jpbaic9tPuOqusrLGz+h61wQ9mk1jbsp4T4uum+o
 PyFcrywxhBL6lkrZRNcnpslokzefZeAzR3ILqmBsMGWMqYv8jIXs9vvVcxYbK2/0GC
 eaxftvggM2rbYvLpD33hv5D2hCTVmB4HxTZAux7lFOj7n37ELzTfsQdzy7w4+7zax2
 OOhtkPuMszdn+0PFv34fTrYHBBJ5CYYMe8NNjn6CDmjHaFQhZDHc4EM+U9KZ+/UGbq
 UKCjWQKVffzLeaWI/mu8BEh57NXEGpdr4xo0iEchfSB7vEOpEOZ5gcwVOziN4Vzm0b
 J0urwnVYa8Mjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 42/50] drm: stop unwinding descriptors by hand
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, linux-openrisc@vger.kernel.org,
 "Ingo Molnar" <mingo@redhat.com>, linux-csky@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-alpha@vger.kernel.org,
 kexec@lists.infradead.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 "Jann Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:17:42 +0000
Message-Id: <20260915121742.F00241F00898@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D42

