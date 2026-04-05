Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE41E9D804
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 15:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB76C10E140;
	Sun,  5 Apr 2026 15:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SWWYoy2x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A14C10E140
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 15:15:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 79268600AC;
 Sun,  5 Apr 2026 15:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED0AC116C6;
 Sun,  5 Apr 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775402144;
 bh=usJcO5sq1mo/2yNi7ckHKPTcHqyv8RKBCvpEEKy2yl0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=SWWYoy2xaX53hGutTPUdf+V+4ogjzXoH1B4wyKTurlUsUKQWLkv+EQxFRVk4ndfJI
 +PkFSf6+PEbzPJGiXVpbj+GX6oQUaTMYxUlwN81VyxBMza+zAg4tlwCjm8fa0zcLT1
 SN/gk3gZZ6e2WXsPJnbuEYRxe92Zc/EWiQRoHKCQ3OqxX6/GqvdpU2V5BvJsKyHuIt
 BOa7++29NVhI1ba/7m8QOnerca396gAMXMZLGcWz5qx5Of8gq8Xc47VEdueula0ZN9
 XmBVYqIaqaYNAChr9B9K3GN+7Y/c01egERetp2zhtdXeRLcfsTtpLlB/m5IVByZFVB
 oEaDCv21XMyyg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 17:15:39 +0200
Message-Id: <DHLBJ7FDJHZ8.XHEA93HJA53B@kernel.org>
Subject: Re: [PATCH v5] gpu: nova-core: gsp: fix undefined behavior in
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
References: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
In-Reply-To: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
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

On Sat Apr 4, 2026 at 7:04 AM CEST, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read or write access, respectively.
>
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them, even if never accessed, is undefined
> behavior.
>
> Fix this by making these methods create slices to valid regions only.
>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org=
/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Applied to drm-rust-next, thanks!
