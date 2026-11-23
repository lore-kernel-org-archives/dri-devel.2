Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B13606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLlPyhnd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6282D10E3BB;
	Mon, 23 Nov 2026 23:34:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1957D10E3BB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95F9E43587;
 Mon, 23 Nov 2026 23:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C51F000EC;
 Mon, 23 Nov 2026 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795476886;
 bh=M049hmYuN5qF5uwfxWxXskRFqZo5GkBg0PYDvcM6N54=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=NLlPyhndXl2QTZXG5fFUgcyOQZxZ2wtIvkDr6ej1xKbwpAlAFSEJgUjcnrPtWThEi
 7Gx6OcP8YAWuud4a6WQ8eSWobD6kMGsZAp7bKkS6Q3/jWz6ytNWgwqz4Omsx2ew2ni
 DZMknCjhu13EWyZhR0q0cNNHd7KXKI9WhOAoamNacOWZDzJ0xkOxKsGIi1+uCqYK38
 l5Koe9esjm1/chHfSDWQUKYHdT4rOcRvVTnpnTx4itHFEN1H25+ERMU2rZ6/WlHH5x
 DbEWZm0hOEnZb0MkpsRYbnbElVp4klGAaEmEuTJooC9gGn/wFRVPWUGmB6TO+EoPuk
 YIAWZeto4B8CQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:34:41 +0100
Message-Id: <DN2ZFO94BZMF.2XTCCKEUDLZSB@kernel.org>
Subject: Re: [PATCH 0/4] drm/tyr: use pin-init self-referential support
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <084F476A-BD3F-4FAA-B47C-E875B542AA1B@collabora.com>
In-Reply-To: <084F476A-BD3F-4FAA-B47C-E875B542AA1B@collabora.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 23, 2026 at 11:20 PM CET, Daniel Almeida wrote:
> Hi Danilo,
>
> Thanks for doing this.
>
> I spoke with Gary about this topic at Kangrejos and again a couple of wee=
ks
> ago. What worries me is that we might introduce some restrictions that mi=
ght
> paint us into a corner. IOW: we have significant downstream work, and I w=
onder
> whether it will work with this series after whatever refactors are needed=
.

The reason for the existence of the converted reference counts hasn't been =
that
reference counting was needed as an ownership model, it just was that we ha=
ven't
had a way to express borrowing from sibling fields that are already guarant=
eed
to be longer lived in any case.

The distinction is between A having an independent owner that keeps it aliv=
e for
all B consumers, so the Bs can borrow A, and the Bs collectively owning A, =
so A
is destroyed when the last B releases it. Reference counting expresses the
latter ownership model. Both can still be subject to lifetime bounds.

In the majority of cases, drivers acquire device resources in stages, keepi=
ng
earlier resources alive until their dependants have been torn down. Where
ownership follows this hierarchy, borrowing can express those relationships
without reference counting.

> To start with, Alvin's VM_BIND ioctl series [0] will need some changes, s=
ince
> it keeps the VM pool in the file data. I think this is doable if we move =
the
> pool into the registration data and have each file hold only an index to =
its
> own entry?  i.e.: something like an XArray<Pool<Vm>> indexed by a number
> associated with the drm::File. Same for the group pool later. Is this wha=
t you
> had in mind?

No, the changes do not force XArray<Pool<Vm>> to be moved into the registra=
tion
data; drm::File private data can borrow from DRM registration data. It can =
(and
should) stay in the drm::File private data.

(I'm also working on a generalization of this, as it is a repeating pattern=
 in
drivers. We want driver private data associated with an ioctl, e.g.  VM_CRE=
ATE,
which is shorter lived than the drm::File data and hence shorter lived than=
 the
drm::RegistrationData.

Concurrent ioctls associated with a handle to this data, i.e. the VM in thi=
s
example, need to be drained on either VM_DESTROY or drm::File private data
destruction, e.g.  caused by unregistration through driver unbind.)

> Anything storing a KernelBo will also have to be outside of the file data=
,
> IIUC, since it now stores a &Vm. Also, downstream we defer KernelBo drops=
 to a
> workqueue, because they can happen in the fence signalling path. I suppos=
e we
> can keep doing that using ScopedWork/ScopedQueue?

I assume you refer to the Vm that lives in Firmware. If so, drm::File priva=
te
data can borrow from it, as Firmware lives in the DRM registration data.

The teardown has to happen in ScopedWork regardless, as they all carried de=
vice
resource induced lifetimes already and hence can't go into unbounded work
anyway.

Thanks,
Danilo
