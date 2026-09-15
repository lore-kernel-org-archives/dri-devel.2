Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B1C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075AF10FBE0;
	Tue, 15 Sep 2026 11:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="or6y3CyS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFC510FC0A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF34F6025F;
 Tue, 15 Sep 2026 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB181F000FF;
 Tue, 15 Sep 2026 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472904;
 bh=snQOL0WONF4IRsaF3EIs3wlmLSFM44jqM+liurayMLQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=or6y3CySlL1bdxzm9++3Y5GlWLcEPN0LrDGjXv4IhxYT8SwPi7kInte+CrlQcFfkp
 1XQmoKBf113PXHQChs2avy8UGIIquFVuSvMCoCSNMtA9/3wH0G1HosQnaeUEIWka2B
 wWhLR1WkDA4HzYixhD6H1F5tbulUxFG0FnA5+hj8l5IA14GNeQQ0O/Dk84ZVAgSj+v
 HbNF4/Hpt5pQyZeE6+47+X/P7J02CVGZbdLDaKVKYgjpAgC0Jr6q5hx+PjdmH8SQ8K
 ZwTjgJT8b9Hr2cJYcHzxNGopiariE1M/El0VM6I8g6qSqO3peUD5vDy8v1Fyu9cVcC
 cthdt2i/NUkkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 04/50] ARC: commit fds on syscall exit
To: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org,
 virtualization@lists.linux.dev, "Peter
 Zijlstra" <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-openrisc@vger.kernel.org, kvm@vger.kernel.org,
 linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-um@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, linux-alpha@vger.kernel.org,
 "Eugenio Perez" <eperezma@redhat.com>, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Ingo Molnar" <mingo@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:22 +0000
Message-Id: <20260915114822.DCB181F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it on the untraced return from a system
> call. A task that reserved descriptors takes the tracesys_exit path,
> where syscall_trace_exit() commits them before the ptrace exit stop.
> The traced path already ends up there.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D4

