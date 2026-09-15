Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223A5C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FABE10F490;
	Tue, 15 Sep 2026 12:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cuq2lBlL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9553310F46E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3B4360261;
 Tue, 15 Sep 2026 12:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E9A1F000FF;
 Tue, 15 Sep 2026 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473876;
 bh=J5fP9X9CyVcuvKEYfpMseQ+In05Wp0Z5tRJ1lE5PSRA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cuq2lBlLoUw0Y72t9bFSWoR4MpMhbFj50xeEgbG3mMkdmknSMptpwSK3xFErl6Es+
 ul9rPuaoVaEF1rSc09McY1HCQ8/KvrsXmDJngtm2g8pGOkK8SksKn5c2XZu2qd6neC
 /n8PpaNv6M0cIf41/P5ePeN8jF4tTMI4A5SgldO4z9TVfn+pUHuseWjwq3FPjMZVL+
 /A1Dp6mNtF0UCTI50gLLUPpKDrqKyRhLmvgM/WajGKJ4JWHsivD3qdtc0trmEiG9AU
 uvPQ8IW2ncEh1yY23HCpFM+zP/B5XadcfTF+40CtiH7dhqHPX0XUxaPv0A3g/x9nid
 zNRhKlOBXH0Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 28/50] drm/msm: install the out-fence descriptor
 when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: kexec@lists.infradead.org, io-uring@vger.kernel.org,
 "Peter Zijlstra" <peterz@infradead.org>, "Jan
 Kara" <jack@suse.cz>, linux-hexagon@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-mm@kvack.org, linux-csky@vger.kernel.org, linux-um@lists.infradead.org,
 "Ingo Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org,
 "Oleg Nesterov" <oleg@redhat.com>, linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, dri-devel@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org,
 linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-m68k@lists.linux-m68k.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Jens Axboe" <axboe@kernel.dk>,
 linux-snps-arc@lists.infradead.org, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-28-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-28-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:04:34 +0000
Message-Id: <20260915120435.28E9A1F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D28

