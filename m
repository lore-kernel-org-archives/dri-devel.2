Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C70C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C95410F95D;
	Tue, 15 Sep 2026 12:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CNterPT/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C09710F95D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:16:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1B07602A8;
 Tue, 15 Sep 2026 12:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99711F00893;
 Tue, 15 Sep 2026 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474576;
 bh=NXoYVTwqvD2Mc3uJ8C8rBTgBxVVEvgW7tv7MPPRhfTM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CNterPT/ZD51jedu2KNQ9rOU/4D4o9j+Aviy118d7ID4ZpJ7DN5B0QTVxpbOLDEcp
 WjkOW+IygybTEM7hIhEUp9B9F8q2tKZJbdjojW7c1kYBcsALaPVXdNvNpseaoF6sxz
 d08hoYd15gcHpNwA06y/3FcZ6xOwqFvsocjr/EGRM5cC9tuus0kDJdaqEQg3Qm4M18
 ZeSXiq47TwxgervFWeMWsQkRc5DykbFskWfeoeMxtxMfVCAG1jD+nF5Voy10SVLA4z
 9vITY1nHgUqKUhmEPiCFbTS/22e9+k7WoslJgfuFNfW4pirOY8jtykHYXqI9jsapd+
 +JW1ZdYPtifnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
 descriptor back on failure
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "Jann Horn" <jannh@google.com>, linux-sh@vger.kernel.org,
 "David Airlie" <airlied@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org,
 linux-parisc@vger.kernel.org, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-hexagon@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, kexec@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:16:14 +0000
Message-Id: <20260915121614.A99711F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D41

