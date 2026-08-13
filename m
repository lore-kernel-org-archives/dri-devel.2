Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CF2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CFB10F2B6;
	Thu, 13 Aug 2026 10:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OpfjxN0c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DF210F29B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF3A04082A;
 Thu, 13 Aug 2026 10:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D401F000E9;
 Thu, 13 Aug 2026 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786618567;
 bh=aWlrS+4xxmEiEVx+PtCe15f5FXxI0/nGpNI0TJWQmFs=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=OpfjxN0c1LVRbGxyZr80QT7zpz9wsWqb5B325j6WFKxpVU/9xBggEmqKtmhGblnKR
 MpeFc9u2PAEwllykhqpcO1xAZDPGAyA05n0XZOvCZUhaghv+btZlAvOctd5JW07Xj0
 k6docWHSaO/WlaYTurttQD8Pk7AQfO5FD0pBh8hJucmayc5EJoIJdUQLD4A+I6bwUn
 sE4wbH57bZhu6rNMfuYpGLYM7SIrxI3ZI48i1efVGY7RF5a9uVhoaIqNdkhhTCMUIV
 iPx2s2scBSTW6nh80qlnUfjskQYPNSAK0n/3rEm06AuaLI2o46XX4Q/cu3uSBcOTm/
 kZ6JPrbZA+nOA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:56:02 +0200
Message-Id: <DKNRF8W502AE.VFY7PMSK7T1H@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5] drm/tyr: add Job IRQ handling
Cc: "Laura Nao" <laura.nao@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>, "Deborah Brouwer" <deborah.brouwer@collabora.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20260728-tyr-irq-v2-v5-1-59fd9dea952a@collabora.com>
 <05F30B5D-B353-4AE3-933C-B42FBD35CA4A@collabora.com>
In-Reply-To: <05F30B5D-B353-4AE3-933C-B42FBD35CA4A@collabora.com>
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

On Thu Aug 13, 2026 at 3:22 AM CEST, Daniel Almeida wrote:
>> - Renamed JobIrq lifetime to generic 'a
>
> Why?

Please see [1].

[1] https://lore.kernel.org/all/DKAINVQDNE79.3JRKZDQJCSX9@kernel.org/
