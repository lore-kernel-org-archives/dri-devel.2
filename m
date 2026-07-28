Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBACC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C03D10E5F0;
	Tue, 28 Jul 2026 21:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AB8Hdtvi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A27910E5F6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:19:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C7AB60A5E;
 Tue, 28 Jul 2026 21:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD091F000E9;
 Tue, 28 Jul 2026 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785273576;
 bh=fxkDtK6W3BPwY9DO64uDltPIF0WLXh8u9Q1M77Uioz4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=AB8Hdtviz41ewwGNKiRl2gJ0RzpcaAA5D4RbEA94D+ZA8jxN9KBRnNnOSsNJ93Sp4
 wJx4Xu+VUsX+thUNBEc8SR2eHUFIJ+SW3izpLlnfbzG/F6Mz+Jyh9lXvri2Mql0H/9
 elSuWVNu5q6uokv5VZy83lIldOsJ0v8Mu1yXhAqsq5iwQGxZvsYfWDXlShfDd7UU2E
 Mv6YQjWfFKIx6sf6tVQ3d8ALrErk+eLiAQSCXdoICgTEnm2nvE/gt8F8L9ZqusZdzo
 gWD90ye2mK656HdbnnijuGz/EcWJBg7BIWDiWzg8JAAST9YR/o9nmxhQOwO73Bb/Gk
 dm6Gw4AKbCn/A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 23:19:29 +0200
Message-Id: <DKAINVQDNE79.3JRKZDQJCSX9@kernel.org>
Subject: Re: [PATCH v10 3/7] drm/tyr: add Memory Management Unit (MMU) support
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <laura.nao@collabora.com>, <samitolvanen@google.com>, <lyude@redhat.com>,
 <beata.michalska@arm.com>, <boris.brezillon@collabora.com>,
 <steven.price@arm.com>, <alvin.sun@linux.dev>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
 <DKAGDGAGBRXN.T20HFE198R5A@kernel.org> <amkSjDCt_P-TfXHD@um790>
In-Reply-To: <amkSjDCt_P-TfXHD@um790>
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

On Tue Jul 28, 2026 at 10:35 PM CEST, Deborah Brouwer wrote:
> On Tue, Jul 28, 2026 at 09:31:50PM +0200, Danilo Krummrich wrote:
>> On Tue Jul 28, 2026 at 8:39 PM CEST, Deborah Brouwer wrote:
>> > +/// Locked wrapper for carrying out virtual memory (VM) operations on=
 the MMU.
>> > +#[pin_data]
>> > +pub(crate) struct Mmu<'drm> {
>>=20
>> This shouldn't be 'drm, but 'mmu or just something generic like 'a.
>>=20
>> The rationale is that Mmu might be shorter lived than 'drm once we have
>> self-referencial pin-init. Currently it is straight forward, such as in
>>=20
>> 	struct Foo<'foo> {
>> 	    dev: &'foo platform::Device<Bound>,
>> 	}
>> =09
>> 	struct Data<'bound> {
>> 	    foo: Foo<'bound>,
>> 	}
>>=20
>> where the lifetime of `dev` really ties back to 'bound. However, with
>> self-referencial pin-init it could looks like this:
>>=20
>> 	struct Foo<'foo> {
>> 	    dev: &'foo platform::Device<Bound>,
>> 	    io: &'foo IoMem<'foo>,
>> 	}
>> =09
>> 	struct Data<'bound> {
>> 	    foo: Foo<'io>,
>> 	    io: IoMem<'bound>,
>> 	}
>>=20
>> Now Foo is not constrained to 'bound anymore, as this would be longer li=
ved than
>> `io`, so it has to capture 'io instead in order to still compile.
>
> Danilo, would you be ok with renaming this lifetime as a follow up
> patch?

Sure; note that I also said that I'm happy for this to be a follow-up in th=
e
previous version. :)

> Currently, if I understand this correctly, the mmu lifetime is still tied=
 to
> the DRM registration data, so the name is not inaccurate for Tyr at least=
 as
> it stands right now.

With the current implementation, the Mmu lifetime technically ties back to
'bound; the DRM registration data itself is shorter lived (it is dropped be=
fore
'bound ends).

The reason I mentioned not to use the 'bound lifetime name in the first pla=
ce is
that we agreed to not use the 'bound lifetime name on structs that may be
shorter lived than the device being bound, which is true for anything other=
 than
the bus device private data struct.
