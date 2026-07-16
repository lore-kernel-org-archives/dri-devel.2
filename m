Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E60EC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A6110E2ED;
	Thu, 16 Jul 2026 07:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wtk+3yoC";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEFA10E2ED
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:00:37 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h13pV5sr4zMlFm;
 Thu, 16 Jul 2026 09:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784185234; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1xQ7+H8jCxVMgR3DzOqWh/rhmWTnisPBf7Ii4iYwyk=;
 b=Wtk+3yoC+pP5dW9/kQwriOudsuK5RaOGT0paxpM7/qbeYtjsWw1o4IT5oz5s17CfB2VmQP
 y9CvAz00vx+hFFXAFzuy3f+D/q3t8nPSx4MsX6FASpG676RlB4y2h+CqlyFC3VXwVjBla9
 6apFlJLMcXHx1hSGX2ds8/V9ZhRfvT7P8rwn4imJaq3e++BQ4/+sioEZYKmYjPBJgVmg7P
 XaICzjyVtAqUW7kR97UaGbrkzlABqvysBUBuJeS7QkMqpcmcKUfTYytl2tcBfwMc6TqmCL
 SspXzOz8VJ3yMatzTPuIptMAkwKh4NqtLlmT9NECZGHD2G3GN8SmfZ+/dZKqRg==
Message-ID: <d75e18a4bccd53ec0e2853923374eb5cde3b1a5b.camel@mailbox.org>
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Philipp Stanner
 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Sumit Semwal	 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Asahi Lina
 <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,  Lorenzo Stoakes	
 <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Alexandre Courbot
 <acourbot@nvidia.com>, Krishna Ketan Rai <prafulrai522@gmail.com>, Tamir
 Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis	 <alistair.francis@wdc.com>, Shankari Anand
 <shankari.ak0208@gmail.com>, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org
Date: Thu, 16 Jul 2026 09:00:21 +0200
In-Reply-To: <20260715200036.46182-1-work@onurozkan.dev>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
 <20260715200036.46182-1-work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 6d4420cebe1a82b94ce
X-MBO-RS-META: wzu5jussqj8sw67xadr3ykcz4xgy6b6i
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

On Wed, 2026-07-15 at 23:00 +0300, Onur =C3=96zkan wrote:
> On Fri, 03 Jul 2026 09:31:40 +0200
> Philipp Stanner <phasta@kernel.org> wrote:
>=20
> > +}
> > +
> > +#[allow(unused_unsafe)]
>=20
> Why is this needed?

Relic from copy pasting around and sorting. Will remove.

P.

>=20
> > +impl<'a, T: Send + Sync + FenceCtxOps> FenceCtx<T> {
> > +=C2=A0=C2=A0=C2=A0 // This can later be extended as a vtable in case o=
ther parties need support
> > +=C2=A0=C2=A0=C2=A0 // for the more "exotic" callbacks.
