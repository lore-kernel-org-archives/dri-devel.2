Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71861606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=NlD+OZHp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CB310E2D3;
	Sat, 21 Nov 2026 12:29:20 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D97210E2D3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1795263912; x=1795523112;
 bh=OMJUqx2DQ3BhmM2pBkud0YM/8aXiQ465Qxorf67Y66o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NlD+OZHpJ0nC5UIQ/VqY+yPMhtgzft/2SpP6Mtl7A1Kp4wsy5uXZZQ166yubGSebY
 m6tFz8Q9FUdYdGjJWaZpt/MzSTb0+4s6js6DuS1nAADnJSR0eR7ot5ET17tp8GoHC5
 Hy5GoQQYbFPet7Zj8lGMt4h7g2QCKfQi0g31d03hnfTjd5dg0gJmERPSfnIpmeTY4Z
 JWsM/MhQl1Wo44tSnSNqdacW+gWqJ391AYCzuoKumME3BjPUDa0irZmznXR8uQ/u/Y
 4tOOGeFhS8TL9QWY7SdNLfK15rTN5exXSp1LRPO4eAOC4FAPJ7YT8ODV9+47T933dy
 S8U1e02kT5ftg==
X-Pm-Submission-Id: 4jWrxx4yJtz1DFSv
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 boris.brezillon@collabora.com
Subject: Re: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
Date: Sat, 21 Nov 2026 15:25:06 +0300
Message-ID: <20261121122508.20705-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <B56A0B7A-A0DC-4BCC-8556-F7BC105B991F@collabora.com>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
 <av2U1FflKT1mEotg@google.com>
 <B56A0B7A-A0DC-4BCC-8556-F7BC105B991F@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 10:07:49 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> =0D
> =0D
> > On 18 Nov 2026, at 09:06, Alice Ryhl <aliceryhl@google.com> wrote:=0D
> > =0D
> > On Fri, Nov 13, 2026 at 05:32:26PM +0300, Onur =C3=96zkan wrote:=0D
> >> Previous reset may leave the reset completed IRQ set which can make th=
e=0D
> >> poll return too early.=0D
> >> =0D
> >> Clear the IRQ first so the driver waits for the current reset to=0D
> >> complete.=0D
> >> =0D
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> >> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>=0D
> >> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > =0D
> > Do you want me to merge this now, without waiting for the other patches=
?=0D
> > =0D
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>=0D
> =0D
> If Onur is fine with this, I think we should merge what we can.=0D
=0D
Sure, I am fine with that.=0D
=0D
Thanks=0D
=0D
> =0D
> =E2=80=94 Daniel=0D
