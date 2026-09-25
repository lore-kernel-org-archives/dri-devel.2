Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A29AC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9E510EA1D;
	Fri, 25 Sep 2026 12:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ezensvnA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DB410E90C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 001C1403CF;
 Fri, 25 Sep 2026 12:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B491F000FF;
 Fri, 25 Sep 2026 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790339422;
 bh=fp1uhQ/h6oTzerH42grRNe6hGWnXk5DjXQNeLzmskQY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ezensvnA7m8JCdNb7qfa93sdRrP+DjUCv4c/7mG1xWtgnCsPDpx8gwfkhGXvVr8rU
 lQV/mld9G+fA/ECncNbqhcpKRRkReIwN8zg58bHcL2g++r9uHWvuKJvgUaOdS7Z11k
 RSS6UOEA4M80SmFDRep19Dht/dUeRKOIPLeu1bfn1ANY90V+hFZNRhf0hyWVduScuq
 P93Ys2X6IfnEmELvbTOOBaDSfYSFDtmkJCh4df+FrcMFlUtZhn5Gs5Wzfd8IYInwrs
 ylXMDMK9LeOVoUfJFE/wlgUD/qFu+VNfunpg0W8oyjHubIhi1ELL+nRdeIrgSCoQvv
 LV0NVx4gJr+1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 14:30:17 +0200
Message-Id: <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
Cc: "Philipp Stanner" <phasta@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
In-Reply-To: <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
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

On Fri Sep 25, 2026 at 12:26 PM CEST, Gary Guo wrote:
> On Fri Sep 25, 2026 at 9:19 AM BST, Philipp Stanner wrote:
>> Replace the warning print with a dev_warn!(). To do so, have the
>> FenceContext carry a reference to a Device, protected by the already
>> present lifetime.
>
> Add a lifetime just to do this a print doesn't sound ideal. You could use
> `ARef<Device>` instead?

Yes, that's what I recommend in general.

Another thing to consider for the DMA fence context specifically, there's t=
wo
kinds of users. The absolute majority are drivers; there are very few non-d=
river
ones (e.g. drm_crtc), which will remain to be C code for at least quite a w=
hile.

I think it wouldn't be unreasonable to keep the API driver centric, and in =
this
case it also wouldn't be unreasonable to add the lifetime, as the T will mo=
st
likely carry it anyway, and even if not it wouldn't make sense for the fenc=
e
context to outlive driver unbind.

That said, we can also use WARN_ON() instead, which avoids the device depen=
dency
to begin with and still provides enough information to find the "offender".

But as I mentioned previously, I don't consider this that bad of a conditio=
n in
the first place. Signaling with ECANCELED on drop() seems perfectly reasona=
ble:

When a driver does a teardown of the channel (or more generically the execu=
tion
context) it will follow the RAII pattern, so it will be very natural to jus=
t
drop the Jobqueue, which will drop all jobs and hence all DriverFence objec=
ts.

IOW, driver will likely invent a new type that does the same thing on drop,=
 just
without the warning. :)
