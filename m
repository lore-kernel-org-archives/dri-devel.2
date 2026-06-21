Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B498CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 16:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD2B10E3CA;
	Sun, 21 Jun 2026 16:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7c334XW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5E810E3CA
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 16:15:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1019402D6;
 Sun, 21 Jun 2026 16:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4211F000E9;
 Sun, 21 Jun 2026 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782058551;
 bh=FnccYtdEdPQjx5ZnmFW2ZFJKkZGpf+bLt65KbDy9AMc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=J7c334XWQR3fL9pKYutLwMDh/LxIKZUTPcjnj4ixACmnr98zz7XIx5jmoEUOwp6yG
 EKmPb8aj8WQ6/l9vaCaeMdhwhN2u9jf/EZw4rqZz/ZMTGTWi2lwjCRcnafDWFQI3KZ
 Hj9vRZXTJVcaJG19oFNeai0ITnRyQ50fUv3R9F4wxX8u/sI2czmcRW5IppgcxVTTY1
 uDUYJeelioFvN6Zbu1c/shqSCZ6IG2/QTp89Ixor0ZQZvRuGf0tHx2t6TlJGcyYWuc
 XadNxx0EBN70AHDH32eLKaIM7F29LqAgg4xx6OgmPWuIOEvacS9H5Ffwx0PkkCBKGN
 Xp3NRaxwBNrNA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 18:15:45 +0200
Message-Id: <DJEV166T78O2.22Q1ANXGBZNU7@kernel.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
 <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
 <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
In-Reply-To: <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
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

On Sun Jun 21, 2026 at 5:41 PM CEST, Gary Guo wrote:
> On Sun Jun 21, 2026 at 10:17 AM BST, Alexandre Courbot wrote:
>> As you can see, this lets a 32-bit access be done on the upper half of a
>> 64-bit register, which sounds like it should not be allowed? Similarly o=
ne
>> could change register types, and so on. This might not be "unsafe" in th=
e
>> sense that it is still aligned and in bounds, but it lets the structure =
set
>> by the type system be bypassed. It could also potentially be a violation=
 of
>> the hardware contract if the access width is relevant for this particula=
r
>> address.
>
> I see no reason to prevent any of the case, this can be done by `try_cast=
()`
> API as well. If we need to take access width restriction and other
> restrictions into consideration, then a lot of API cannot be exposed at a=
ll.
> E.g. it is not okay to add `copy_read`/`copy_write` like the patch 19, be=
cause
> it uses memcpy_from/toio which is possibility doing byte-width access.
>
> in my opinion think people should be able to type casting without reachin=
g out
> to `unsafe` if it's not UB. Similar to the logic on why we have `zerocopy=
`
> that allows casting between to types, these are "bypassing the typesystem=
" as
> well!

I think this is fine as-is. The natural, ergonomic path through the API
(io_read!/io_write!/io_project! macros, IoLoc-based accessors, etc.) leads =
users
toward correct access widths.

Whether through io_addr() or a custom IoLoc implementation, reinterpreting =
the
access type requires explicit, deliberate choices: picking a different type=
 and
computing a byte offset. This is not something anyone would do by accident.

So, as long as the API doesn't provide a subtle way to do the wrong thing b=
y
accident, I don't think we need to add restrictions here.
