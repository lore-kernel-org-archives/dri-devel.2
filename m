Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C8C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE95810E9EB;
	Mon, 10 Aug 2026 22:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DoyYYVzu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA05710E9EB
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:25:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 376AD6001D;
 Mon, 10 Aug 2026 22:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5822E1F000E9;
 Mon, 10 Aug 2026 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786400710;
 bh=qYaE3B7aOUmyA0TEQgnnYXSIII483soKiTQbsNWoDLk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=DoyYYVzuk6qp1L9JJMydpGXVcJW8KsPViFTJS7lsd0XSRsFFPN91NJJD47KuY2K3e
 XITR/e/4PFUqWr4XXeqML/TTelfmd17ei6tC1PpGGpQU/h1wGPkMmFtvmDvtuEk0L1
 B5XAeyud45ExxID6tWpBg+8b4VI4mCsbMZuUpqkx/u+4atExl/QUCUgzTL7l5/6mkI
 guWHUjRSUY7DQ6ve2DX5xT358fDtlgtOfaCC1BhpJcwGl4+jteTaXjP9T0GEaDUIq4
 10CVHzEisEQiGFHALgtdRUUAWInDOKk1KPO0FroBFS7SVlEpHiWUwSfI+Ox/AT23sR
 rhHOtt5onvHBw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 00:25:03 +0200
Message-Id: <DKLM760O3TCZ.25MJBWQR2JOCY@kernel.org>
Subject: Re: [PATCH v2 02/12] rust: num: reject Bounded::shr overshifts at
 build time
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com>
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

On Mon Aug 10, 2026 at 3:55 PM CEST, Eliot Courtney wrote:
> Make `shr` reject shifts of at least the type's bit width at build
> time, instead of panicking or masking the shift amount at runtime.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
