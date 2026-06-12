Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D425DCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4B10EB5F;
	Fri, 12 Jun 2026 20:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1yCW4fQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2E810EB5F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:20:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F08960008;
 Fri, 12 Jun 2026 20:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD71F000E9;
 Fri, 12 Jun 2026 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781295633;
 bh=aGOD9nYl7XwUCvq5dGBRzDrHCjaAkfbwmgCdWRph2V8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=W1yCW4fQweO5jtjTzY2qWsuQONhmu3P9WEPQzhaRBMb28NYVbVRkUzWhnhykSvXTM
 zZNmunUG3gDcFtbeP+8VF/jtxtcK63PTaJ/9ILZflxH48/GwrJC1PYClMmGtjeG/ql
 tNuJmgMc8uKKX85+3Gz+sjhUJ4HLJCT3MQsgUyxMc8t3h+FWhlQg2VQb7d2fSqjUaH
 rULx7D7xylQgB5RJodxZP0xkIXVnAr5cGFz2HBkCc1TjpvDnTYPUTzdMnTIwsaRmMj
 1dX+gMG5H72iNmKYgeX7al9ZFSVVv01x00iNSRtvpwflIwSrslyxT+CRLDuexhARX4
 /rXkVU7fa/4+A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 22:20:29 +0200
Message-Id: <DJ7CLN3J37Q9.8G26CYOE2E4S@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: remove `#[allow(non_snake_case)]`
Cc: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260612123401.2684025-1-gary@kernel.org>
In-Reply-To: <20260612123401.2684025-1-gary@kernel.org>
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

On Fri Jun 12, 2026 at 2:34 PM CEST, Gary Guo wrote:
> This should be applied after the merge window when v7.2-rc1 is backmerged
> to drm-rust-next tree, so the pin-init changes are picked up.

Noted, thanks!
