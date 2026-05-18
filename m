Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79365CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD7D10E2FB;
	Mon, 18 May 2026 10:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yv4fNDnz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389B010E2FB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:06:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E29D60125;
 Mon, 18 May 2026 10:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4467BC2BCB7;
 Mon, 18 May 2026 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779098784;
 bh=KEg6Hi3hlNlYZ8PLaUPxZCx0yAZdeP8lxPT8W/F/GRs=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=Yv4fNDnzvQTTsMICDyydMPzGN6duSaXxxOe9DkC2Wyzrtki2wSExsdPqR/ndREnlF
 mPhb9+tNab2n1abKKuTd6JAyc43QGmEijX+gjdFw6iqDKm/K4UvgJ5vAO9G1eYbMXd
 xLe6DWvYHREE9mQfifaDbqxW/Yp2bVI7DnDiBi/f/CIdNQ+4EHohNYm06j28QGJM4v
 8TstbTnp43c+I61UNJE5Z1t3eCzjkpHIt2d3E9mVGCUXwTWBDt7e0K80dVpT+SpYXx
 ieYLVPGe6MnRjDXvjg0EkMzWee9YGjtqk9VqSBY54uaWr7Fdq2E8KxC4RF1kNwZHTP
 c73lR91L8tqPg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 12:06:19 +0200
Message-Id: <DILPVSCS20SE.2ZL1IK6KQH2CM@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 08/13] rust: drm/gem: add GEM object query helpers for
 debugfs
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-8-074badd18716@linux.dev>
 <DIHXMUSMRHYB.39N8PCC9D86KM@kernel.org>
 <9839e1fc-faa2-4e98-9f46-b6449bf0f35a@linux.dev>
In-Reply-To: <9839e1fc-faa2-4e98-9f46-b6449bf0f35a@linux.dev>
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

On Mon May 18, 2026 at 9:39 AM CEST, Alvin Sun wrote:
> A generic Debug impl for GemObject? Other drivers like Nova might need=20
> different
> output in a different style.

Why is any of Tyr or Nova special here?

There's already a lot of common debugfs code in DRM [1] (which is per DRM
device), including some GEM info.

If that is not enough, why can't we extend it / add another entry?

> How about a dedicated debugfs data structure for GEM Object instead? Say,=
 a
> get_debugfs_info() method that handles synchronization internally and avo=
ids
> exposing unnecessary interfaces?

It would need to be guarded with a debugfs config, otherwise we'd still exp=
ose
information a driver should never touch directly, which can easily become a=
 bit
messy.

But again, why do we expect any of those drivers to be special? I think thi=
s can
just be common code.

[1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/gpu/drm/drm_debu=
gfs.c
