Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BF1C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF42110F47C;
	Tue, 15 Sep 2026 12:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CvwdtYpl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4895510E5F8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 108AF414E2;
 Tue, 15 Sep 2026 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2741F000FF;
 Tue, 15 Sep 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474439;
 bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CvwdtYplEMqh0mXb9UtTtEzUPZjlErl5BgHWZ3BUuzKN64/50zHMmE8tVi+y1B3X3
 tAYkfuPSB1IfE0nhCXR7lcqXNSl51VqpY+L+oymG9YPh17XOrUi8G3/Aa+dnQeYFRj
 NcQX+8avtvTCjCij+9TYtbgkkb7afe60hNSTSaGvh1L3t7pyiz8fuqxatGkMKmaKvM
 8XOgUv1cgX6wWpD+3GvwOhIJtw3OnoMVeiRhGh4LZXzdsV358kdYIG5GabAq3BtAXs
 I7hVAiVBYRClyrA05Lt47fHM9pl9LGtyPE+6dxCTPgbrcsy0AbO5y7C+JwxLWRY8kE
 FeK/23S/8IuyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 35/50] ALSA: compress: install the task
 descriptors when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, io-uring@vger.kernel.org, kexec@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org,
 linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org,
 "Oleg Nesterov" <oleg@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, linux-um@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:57 +0000
Message-Id: <20260915121358.1C2741F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D35

