Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBCAC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88FB10E55D;
	Fri,  4 Sep 2026 18:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gzrd3W6k";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F70510E55D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 18:53:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hc5Fl4n4Cz8sYS;
 Fri, 04 Sep 2026 20:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788547995; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr3Kv+LHhp95pfYfELeLm48GZwMxkYNQyW4lFOFt+q4=;
 b=gzrd3W6k2RuiKSuND+PRDC8buQZlbR1cP4WavEIzF9mlXMJUYXPGyeHckuqvp9ooJFzAnh
 DSviYF2l+f1PGrjrU7GXhd4QXekMkhSwGuBhz1SK3/twoX6yjbEjuBgymGiW0fLi7xaJdU
 TndyzWPY0E+pOlXSVjRhkNK+oCSAjwl5gVP9zCArpz6w2zStwUz0dSQsXpKNmg5DMGNTwr
 K/1vEQng/pFVVTKCD01odRCQ3Yf0DSQf1D6V1qppjG8MgZJ8aJ13swB5fqCeeeaDd0CTxi
 nQb4CDLI1xVGDGr8CVkpnoqVcYZ4w/fQ+gCGyuII5A34lqsgfWVWFFmLPh684g==
Message-ID: <5916d336906e4918a379178eca5699c2f7506ce8.camel@mailbox.org>
Subject: Re: [PATCH v10 1/2] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Yury Norov (NVIDIA)"	
 <yury.norov@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>, Burak Emir	
 <burak.emir@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes	
 <joelagnelf@nvidia.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Fri, 04 Sep 2026 20:53:08 +0200
In-Reply-To: <DL6N387CE2AT.1LU4TDUB8QBIU@kernel.org>
References: <20260812072217.1971807-2-phasta@kernel.org>
 <20260812072217.1971807-3-phasta@kernel.org>
 <DL6N387CE2AT.1LU4TDUB8QBIU@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: a760c3afe94aa3b1690
X-MBO-RS-META: wkjb6zde95iimj5t19xjiu1myszgxdfe
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

On Fri, 2026-09-04 at 17:32 +0200, Danilo Krummrich wrote:
> On Wed Aug 12, 2026 at 9:22 AM CEST, Philipp Stanner wrote:
> > Add abstractions for dma_fence in Rust.
>=20
> I was about to pick this up, but ended up with too many things to tweak.

:(

>=20
> =C2=A0 * Fix checkpatch.pl warnings,

I get two, one of them being obsolete

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#114:=20
new file mode 100644

WARNING: line length of 101 exceeds 100 columns
#158: FILE: rust/helpers/dma_fence.c:40:
+__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fenc=
e *f, unsigned long *flags)


>=20
> =C2=A0 * use Opaque::zeroed() instead of __GFP_ZERO,

That's literally what I had originally, but Alice objected and wanted
GFP_ZERO, AFAIR because it's more efficient.

Maybe you two want to get to an agreement on what's better.

> =C2=A0 * use kernel vertical import style.
> Here's the diff I suggest for a v11:

Thx, I'll take it into account.



P.
