Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE0CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257A710E84F;
	Mon, 22 Jun 2026 18:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GIXMY0rG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39D910E7DB;
 Mon, 22 Jun 2026 18:20:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 584D8601F3;
 Mon, 22 Jun 2026 18:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFAF1F000E9;
 Mon, 22 Jun 2026 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782152407;
 bh=dBA6CnCEo0EHydNW5LEGvdxXZC1r75DUROE1Y8OSRFM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=GIXMY0rGiQbGwjpvuQpD/nu9ZldK6puGkCbteExIqgf+fCPzK1y3cpulX5njQouje
 L0u7RoSujFJsw0IdYXi+Pnf10rvYzhAJDfGpBvAAUh1Z3KiNfTd2XOB628OnaYcKVG
 Rk9h98p/egOG0TT8twNAAG5S6XLfZ/YKeCXM1Txh+sAYwKSUWMZlM2Xn4O85LcTTXW
 7DbFXllR0ZngNAcFrPs5yCATpPyyAO8OYIBiDXzSziuhjKUj8Rbc0te3aH2SdsZzd6
 f2jEriE0wAeaR/DBbYbB3ghEQlu8p8uoSMl0AWx+QF7hw7ssQB1D5BQtbSeiAYtwvo
 VPMhU7/A4gMOg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 20:20:03 +0200
Message-Id: <DJFSAVPR4EE0.1L3AWTWLI9CE2@kernel.org>
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
Cc: <phasta@kernel.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>, "Lyude Paul"
 <lyude@redhat.com>, <nouveau@lists.freedesktop.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boris Brezillon" <boris.brezillon@collabora.com>,
 "Dave Airlie" <airlied@gmail.com>, "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
 <DJEU27KUZRNN.3R1F8AL6UL30S@kernel.org>
 <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
 <cf9f4a62-ed02-46d6-9560-481ceda2d1a3@amd.com>
In-Reply-To: <cf9f4a62-ed02-46d6-9560-481ceda2d1a3@amd.com>
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

On Mon Jun 22, 2026 at 2:17 PM CEST, Christian K=C3=B6nig wrote:
> Maybe an idea how to generally tackle this for all drivers: Never let the
> dma-fence framework call dma_fence_signal(), that should only the driver =
do by
> itself.
>
> This way we don't run into the issue in the first place that the driver n=
eeds
> to install some callbacks *and* the driver also knows when the installed
> callbacks are finished because that is when dma_fence_signal() returns.
>
> Does that sound valid to you guys? If yes I will be sending out patches t=
o do
> this.

I think that's a good idea, as it would get us rid of having to rely on API
internals to synchronize struct dma_fence_cb callbacks without doing the fu=
ll
RCU dance, which can be quite cumbersome (as described in the nouveau case)=
.

It still leaves us with the full RCU dance for struct dma_fence_ops callbac=
ks,
but that's a different topic.

Thanks,
Danilo
