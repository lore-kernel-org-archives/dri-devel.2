Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579EFCD4F26
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 14:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7172810E06B;
	Sat, 20 Jun 2026 14:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KVJvgP/V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AFF10E06B
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 14:26:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2E0C601E2;
 Sat, 20 Jun 2026 14:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474301F000E9;
 Sat, 20 Jun 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781965600;
 bh=uKoP3mE/mbENnzJpcGwFTZXlmjtVUFD2Jrk0YPULJDQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=KVJvgP/VzEKlJFxCT9S9o3ZDNmjjEdv+E+Q7aPDVtK3zeMMf2lTO8U+mcrlFYLDWg
 sWYW2x7RROMhixSb6BcriF+ZnBp+q2dh/YVd4NpYBDJvUs/zI/uWS4bqGMI7+qvkrp
 kJWYumWN1CPjAMwo78tLmbDZUUW783CKgcjcb+BPyBF4FVqkRFR2IzGLtU9MjnfShY
 fei1aJn81F/suSVhsNsR+7ETBget4GtvipcrxwTak5Rv2ilTA83eAg1mGLbHYwJ6BT
 nY13/64k6Zkf08mceIjyqo3/I4TGAcih724IjYc8Ih+l06JJFSPdAB7M0f6pIZPVm8
 +sPTxdsQoXRAQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 16:26:36 +0200
Message-Id: <DJDY31W202BF.4OHIYPH1MEDX@kernel.org>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
 <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
 <DJDXNDGXLZZY.8IEHLBTRKCQO@nvidia.com>
In-Reply-To: <DJDXNDGXLZZY.8IEHLBTRKCQO@nvidia.com>
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

On Sat Jun 20, 2026 at 4:06 PM CEST, Alexandre Courbot wrote:
> I expect that the users of the VRAM regions (i.e. the MM subsystem) will
> not be able to contruct properly if no region is detected, and that sound=
s
> like the right place to raise an error rather than making an assumption
> here that no VRAM region is an error. For instance, I am not sure what
> the regions layout will be on Tegra systems, although your comment about
> OpenRM seems to hint that there are regions defined for them as well.

Well, the question is whether it would just be an assumption that no VRAM r=
egion
is an error. I'm not entirely sure, but I think it generally is an error. I=
f
that's confirmed I'd rather fail early and with a clear message, and not ca=
rry
on with something we already know won't work out.
