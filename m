Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7E5E8537A
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3944C10EF45;
	Fri,  3 Apr 2026 17:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SWTrcwWe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC0210EF45
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 17:37:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3571660123;
 Fri,  3 Apr 2026 17:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE2C4CEF7;
 Fri,  3 Apr 2026 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775237861;
 bh=j5Lg+DOCGLuJzSedXBQFy1M5HS8GXHosnGnLzNSWDic=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=SWTrcwWe8frx7pOV00HJEAe4tjyaVxdgruJZUCuNgbBFc/fJaYKEYnyhOMYIpojb3
 w4FX4yPkZc6CuAmvxOdCLG/g/WuaxtVEkuN0ROW90tfGqwhzEW0kQhon/8RY31E8Ie
 UkBDQ3KVOc+mwNE4aDuFJfpA/gXXA0RNObFrNIwtDjMfuB+pxZW8nfDwqsdlIm4/cE
 GRsdKGWLJAihdbLCbfXArOT59YIgBc4HJtyTN1oiY2CWSQtJotqZvtc6BPc1HZH7VQ
 DYRA1TPXtiwtotxGf7Mio8l8TEbxZtkefNfV1C0oziN9ZXnWCpIGJkDHsOm1Ly0HwE
 vmfT4iRO7OKYw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 19:37:37 +0200
Message-Id: <DHJPAT57O4B5.27NTSV0S1Y2TI@kernel.org>
Subject: Re: [PATCH v4 0/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
In-Reply-To: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
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

On Wed Apr 1, 2026 at 4:29 PM CEST, Alexandre Courbot wrote:
> Alexandre Courbot (2):
>       gpu: nova-core: gsp: inline methods providing queue range invariant=
s
>       gpu: nova-core: gsp: fix undefined behavior in command queue code

Applied to drm-rust-next, thanks!
