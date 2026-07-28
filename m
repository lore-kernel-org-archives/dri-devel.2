Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C7FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6D910E9D0;
	Tue, 28 Jul 2026 18:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TuY3xn/o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0077410E9D0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:56:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4676A60A96;
 Tue, 28 Jul 2026 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADD31F00A3A;
 Tue, 28 Jul 2026 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264994;
 bh=2WiJKDeK2Vzyu/WLkFFx9UUxHT2Nh9XVMNUlUceYbbg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=TuY3xn/oFJ2MtFjSY8HTXL5wh5FePxvdq+RTUWR27pehxQi+tiQ7CjhjHtHHUViHb
 1B+fGpY62mDuvKggftWi72MFev1JkfERHvTMdkrbo9IAYkRZV9IpsMTas9SQ+nKXw/
 CnJQOziRclQxWJo0h3hiwwFb45ZrescgQ42Ln+XGup+qQlNByMoVMpnQk4Do2nXB59
 yI44XzbG2jhwDh7ydLbq3VS+U1e94D+qLumLKwrtpzBTQp7InvUah/oXC+wLKvnKjH
 TZy9HvuHMMESrWa1xwR90bX9a5gaPxBgabU5KuB6dFwxhbOU3mBJVwkX6f+z616Jq4
 iQ5wLh2gh+ewA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 20:56:27 +0200
Message-Id: <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
In-Reply-To: <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
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

On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>> I may have a slight preference for a separate subregion() variant for th=
e
>> purpose of working around generic_const_exprs, as it probably is a bit c=
loser to
>> the final solution, but trait methods are fine with me too.
>
> I am not sure that's the final solution that I want. I want arg-position
> const-generics which would syntactically look more similar to `build_asse=
rt!`.

arg-position const generics would be great, but that's just a syntax differ=
ence
and not related to supporting expressions involving const generics?

In any case, I think my point about being closer to the final solution hold=
s
regardless.

> Personally I think most issues with `build_assert!` can be fixed by havin=
g
> lints, which is on my radar.

I think it can be improved, but in the end it relies on compiler optimizati=
on
that may or may not happen as expected.
