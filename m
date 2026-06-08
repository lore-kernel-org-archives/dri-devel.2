Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE7BCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CC410F8CA;
	Mon,  8 Jun 2026 18:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JerpZAoU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CED610F8CA;
 Mon,  8 Jun 2026 18:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4088D40173;
 Mon,  8 Jun 2026 18:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE231F00893;
 Mon,  8 Jun 2026 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780944626;
 bh=HjZFDO402ZDsm7mMfRjPVjHrawSFxpu7iqkTSYlsac0=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=JerpZAoUcN8RRH6FY2mqcHqv3G9EBFHXMREWaesJnn/P9WJewz66UROs393HxHyNT
 ur6WEDzFmvjKrRgJiyAQdlQ0h9LJ5XksGmmcDUeqAI/TOG2eh2omxxjcb7fftns4vf
 mNAu6qSjSuHJopkqS1bpoAnoghSHEJZF7XlHAlCc361Ux8P9Dx1DumrofMHOjm99xB
 1vuwNzws+r24uxhfZjPVHQlarkTbXD/ZQOKrM+eCfXEClU2U0+JP2cYzIS4lxsBSkh
 DgTkOvD5ooFE6SdVaRMsaubs0F/Rwmf73eQTkCpX8dEeBQdn+hQI236VVWJw2SDkiA
 E0kApa1eeJWTQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:50:20 +0200
Message-Id: <DJ3W6FP39GZZ.3988HCMO7NN86@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v19 0/4] Rust bindings for gem shmem
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <driver-core@lists.linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Simona Vetter" <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Benno Lossin" <lossin@kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Asahi Lina"
 <lina+kernel@asahilina.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
To: "Lyude Paul" <lyude@redhat.com>
References: <20260608183057.2001376-1-lyude@redhat.com>
In-Reply-To: <20260608183057.2001376-1-lyude@redhat.com>
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

On Mon Jun 8, 2026 at 8:29 PM CEST, Lyude Paul wrote:
> Lyude Paul (4):
>   rust: drm: gem: shmem: Add DmaResvGuard helper
>   rust: drm: gem: shmem: Add vmap functions
>   rust: faux: Allow retrieving a bound Device
>   rust: drm: gem: Introduce shmem::Object::sg_table()

Acked-by: Danilo Krummrich <dakr@kernel.org>
