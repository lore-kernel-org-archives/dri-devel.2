Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F140CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB8810E229;
	Fri, 16 Oct 2026 12:10:52 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BEC10E229
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:10:46 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j5kKw0wrjzMkvn;
 Fri, 16 Oct 2026 14:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792152644; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2EOVYSWSibnwSbvmZ9Icl3P9UW6LIJ9IuDIZoFx5OQ=;
 b=BxhsRovexkzm/j03lF7h8T81J+DaEDb1vPJQtAM/gNEHwDsm5043EAIs2QqxTKLqu50co3
 PBv7W2zK06FB8aCQ+r+iii7RNBqV64XIhwz+phUXjB4W8oXOaLVnkOIL/gCmb8aXfslnmW
 7a4PdVrFg3q+s3+SYFpEbzcZnSWmsLPTQM1mjAFlcwEgEYTqX0ZQRLPiJ0VeXUiHrd7cvU
 lQZifTf11q6ZiAkCXmpLqcAVd5aDR+ETBDW7pZqSxUAFHnafbZtEEdDLgMRQGGDwA4sRuC
 86ZzN+NDLu5uJPYqOKryEi+/M08ekEcDs5wIJwptXbDGtm5KrF5dK1O40tSP+g==
Message-ID: <3cda8a87bb8c243f9409b260853c98de2ff78b63.camel@mailbox.org>
Subject: Re: [PATCH v2] rust: DmaFence: Remove static lifetime
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl	
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 14:10:38 +0200
In-Reply-To: <20260930122755.1657820-2-phasta@kernel.org>
References: <20260930122755.1657820-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-ID: be247911bdc56e199d3
X-MBO-RS-META: m7p3i7kbreozqwrixqa9tkw7omxdfiem
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

On Wed, 2026-09-30 at 14:27 +0200, Philipp Stanner wrote:
> A FenceCallbackRegistration can stem from another party than the one
> that has created a Fence. Should that party forget the registration
> object (for example through a refcount cycle) and then unload the
> module, a fence signaling would run into the unloaded module, causing
> UAF bugs.
>=20
> So far, this has been solved by demanding that the payload data of the
> registration object demanding static lifetime.
>=20
> It turns out, however, that this is harmful because the static lifetime
> bubbles up to all users, ultimately potentially causing a large amount
> of driver data to be static, which renders the lifetime obsolete.
>=20
> Solve this issue instead through an unsafe requirement which demands
> that the user does not forget the registration object. This is also the
> solution chosen by ScopedWork.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=20

Gentle ping about the merge since we need this to upstream
drm::JobQueue


P.
