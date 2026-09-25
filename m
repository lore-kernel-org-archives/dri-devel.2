Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785C3C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FE910E539;
	Fri, 25 Sep 2026 16:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmheRZQj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D8510E3AA
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:00:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CF1A60230;
 Fri, 25 Sep 2026 16:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1AC1F000FF;
 Fri, 25 Sep 2026 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790352031;
 bh=ywbxnRCzIpxZKcKA4407lYkAqXuRPUNreym6wXcGaS4=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=bmheRZQjozopfrBYggaWB3DB6Wc6c8qJSjI5FAbid7Q8XlDH4jWun8/xfVeQsZOa1
 0LekADVIjGA/2jD8QqVB6550Jmzu4LENyLmdrW0dPFkP+7SjdjRdA0dIPL103D+Aek
 XoWv0oLq1IZpdeuaENP4VYY50WxskNsPFR46ZSxqmOleeXjgNxsKSUaYU6wGXRFuZp
 4VQAsZa7kTzNl2VFG9xtnREZaiuzYwctfcav729Od0h1QZuArQRk6gEmuyUnpJVZWq
 mVz2p84rCmhLPNg4gmE6WTclK0w7i4xe3srzy1geMBNLqUSTDvt9T1wRohumLs3lNJ
 PAQkAnbNBRB3A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 18:00:25 +0200
Message-Id: <DLOITQ94Y374.2HQ1HVK4G8D40@kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
Cc: <phasta@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
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
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
In-Reply-To: <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
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

On Fri Sep 25, 2026 at 3:08 PM CEST, Philipp Stanner wrote:
> On Fri, 2026-09-25 at 14:30 +0200, Danilo Krummrich wrote:
>> On Fri Sep 25, 2026 at 12:26 PM CEST, Gary Guo wrote:
>> > On Fri Sep 25, 2026 at 9:19 AM BST, Philipp Stanner wrote:
>> > > Replace the warning print with a dev_warn!(). To do so, have the
>> > > FenceContext carry a reference to a Device, protected by the already
>> > > present lifetime.
>> >=20
>> > Add a lifetime just to do this a print doesn't sound ideal. You could =
use
>> > `ARef<Device>` instead?
>>=20
>> Yes, that's what I recommend in general.
>
> Weren't you super opposed to refcounting wherever it's avoidable?

Well, a device by itself is already reference counted (which is fine). The
lifetime constraint does not come from the lifetime of a struct device, it =
comes
from it being bound to a driver for bus devices; for class devices the life=
time
constraint comes from the device being registered.

I'm opposed to refcount stuff that has a bounded lifetime that is defined b=
y
some scope it must not outlive.
