Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA92C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE47510E12C;
	Mon, 24 Aug 2026 19:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4W2HNCG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6489C10E12C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44CF66011F;
 Mon, 24 Aug 2026 19:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDA91F00A3A;
 Mon, 24 Aug 2026 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787600099;
 bh=M3z8xXoUo6x2nI4A38ePuDoTy/O0zxphQa3MwxelIRM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=U4W2HNCGTwnrMGY6kjL9RMAaw1dbXpfkdFuN+Lx8rQMPjTQVtG1tx5ijguR2xJqLT
 HWzd5SF47GMjriJ285nqc0ky956TiMw7K/EiMo3pmhpSscsMrzYMZjVvMT0nAUL/sY
 zcVeMgYvdxP+haDztlxoOGDyISseqYSg2RbvNWfzYacz7ZomegdjDJxdyJnD00aslM
 kaZK4IvvNEyaDwT5M1lW8bu5T843J8KKtTWCOCOUx+ex5TGCmqlGRAHyQZAfvDP2a9
 HtZDAKDoIxXNA7dbSIknAxj08HLr11Pa4hEzxykrys2uoJXRMwgSegsQwGZRuRWMZy
 Uz+CjJQDbIdUQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:34:55 +0200
Message-Id: <DKXFCIT7WHBE.1MJV6UKAJ5VEU@kernel.org>
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
In-Reply-To: <20260811050657.646799-5-apopple@nvidia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
>  include/uapi/drm/nova_drm.h    | 27 +++++++++++++++++++++++++++

Btw. I think it would be nice to have project to play around with and write
tests directly on top of the uAPI before we can run the big test suites.

When I implemented the VM_BIND uAPI for nouveau I used IGT for this (but di=
dn't
enjoy it too much). It turned out to be very useful to test and benchmark t=
he
implementation before being able to complete VK CTS.

When I sent the first nova-drm skeleton, I also submitted [1]; maybe we can
extend this further accordingly?

I'm also open for other ideas, but I'd really like to have something like t=
his
as we develop nova-drm.

[1] https://gitlab.freedesktop.org/dakr/drm-test
