Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DB8CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DED10E635;
	Mon, 22 Jun 2026 12:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KPl9Yn5Q";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D20D10E635;
 Mon, 22 Jun 2026 12:45:30 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gkSbV48k3z9sWm;
 Mon, 22 Jun 2026 14:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782132326; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkMwbTC6310DHTrZdoptKKXWD1KIfX8Jfo4LzUqTcgs=;
 b=KPl9Yn5QwOD6AnheCc8UlrorIpnP+dvN9KCfUVMCk9RAOmgsewVSWfVpYrMZ2Y6u+8+JI1
 Ox+zeoe5LNoMfmZhfGv+M+cbWksOT4kLVe9rDso6qG8eObXLqycmhckfBTjpUPIVqVGAdw
 LJfhVXNUSEE4Cv42K2lL7/LW16yQq4wfGl/uNYPYEu/A7WnZV3hK+ktNw3G9eWP/7CB3f4
 GPn/KiPeCKwGc+O/N39dlhpOfxVpU5ANZDLx7LJ6S5Imrq/6Jn2f7lRxsj0HbI0hnn76h8
 9zuKYdLgty5Sp3qhtCTLrYz32RjCjRh5IoWY5sehncvfdTb+GUqJ7KF0LAIo8g==
Message-ID: <8c5ff6db6ab8c29c3e7addd969c4642e9d82c524.camel@mailbox.org>
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, Lyude Paul	
 <lyude@redhat.com>, nouveau@lists.freedesktop.org, Alice Ryhl	
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
 Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>, Daniel
 Almeida <daniel.almeida@collabora.com>
Date: Mon, 22 Jun 2026 14:45:19 +0200
In-Reply-To: <cf9f4a62-ed02-46d6-9560-481ceda2d1a3@amd.com>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
 <DJEU27KUZRNN.3R1F8AL6UL30S@kernel.org>
 <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
 <cf9f4a62-ed02-46d6-9560-481ceda2d1a3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: zwxpr4yr7cu81hodh86wfpmdpue1g5x6
X-MBO-RS-ID: e546aff977dc697f06d
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

(+Cc Daniel)

On Mon, 2026-06-22 at 14:17 +0200, Christian K=C3=B6nig wrote:
> On 6/22/26 10:57, Philipp Stanner wrote:
> >=20
> > The issue Dave addressed was a UAF within Nouveau itself, where the
> > driver put() its own fence while its own callbacks were still
> > executing.
>=20
> Yeah that's exactly the reason why I have been rejecting the idea
> that drivers install callbacks on their own fences.

I remember we had that discussion when I discovered that signaled
fences can temporarily remain on nouveau's "unsignaled fences" list and
wanted to do the removal automatically via callback.

>=20
> Maybe an idea how to generally tackle this for all drivers: Never let
> the dma-fence framework call dma_fence_signal(), that should only the
> driver do by itself.

About the framework I'm not sure, but what we do enforce strictly in
Rust is that only the creator of a fence can signal it. We achieve that
by two fence types, of which only one implements a signal() method

I remember seeing some parties signaling the GPU scheduler's fences, so
such things definitely happen. And since you likely can't enforce it in
C, you would still have to take the possibility of a third party
signalling your fence into account.

>=20
> This way we don't run into the issue in the first place that the
> driver needs to install some callbacks *and* the driver also knows
> when the installed callbacks are finished because that is when
> dma_fence_signal() returns.
>=20
> Does that sound valid to you guys? If yes I will be sending out
> patches to do this.

Hm. I suppose that would be an improvement?

Maybe let me ask differently, too: why is it that the framework is
signaling fences in the first place? If I understood you correctly last
time that is partially related to the locking problem in the callbacks.


P.

>=20
> Regards,
> Christian.
