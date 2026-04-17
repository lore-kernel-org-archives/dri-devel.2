Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BBAF436B5
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918510E2C5;
	Fri, 17 Apr 2026 14:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gC8VDLKC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5435110E2C5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:59:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CE7A644007;
 Fri, 17 Apr 2026 14:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B2AC19425;
 Fri, 17 Apr 2026 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776437948;
 bh=jEI6+xx49hEv/4C8YdVfp0QhsA+wg2iHesx7rFPUQns=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=gC8VDLKCp7mzvnwChzSMA8GaOnvXzWYl6iaWBVNIQmMlf5AtLL76enCpsg1CI8u3p
 FZIroQwFfa8+gycJu9QWF43LGrPztV7kLzYIz2sGRvdJyI1aeDNQ6YInutx8+gp48b
 Te92qo6iAPqjduymFd/Sad1z+w9Hn9FNAWrvNHVPhicGhbFUNAJO+EQIkuSatFUwKY
 pME3UgqkOo3ucmL8YZ2IMS3QHk9LiyBAk5nquVjEOVKAiavfqadwugFZhLgftwwGsl
 G5Om7nlz5vddi5tqpSA/FW/E5hXdw0gJ/DiEkMT16IWsQEbSGGB3YnhMHzenD870a5
 CTdx4VbmHKQKA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 16:59:02 +0200
Message-Id: <DHVIP0L7RFCP.38KEXAROGM3Q9@kernel.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
Cc: "Mark Brown" <broonie@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
 <DHVEWDBHYKQF.XBXZ704CMXCF@kernel.org>
 <CANiq72mNP4J_czVo25d1yRdWxBNFKaT9OPOC7k5EDzZ9YmdEww@mail.gmail.com>
In-Reply-To: <CANiq72mNP4J_czVo25d1yRdWxBNFKaT9OPOC7k5EDzZ9YmdEww@mail.gmail.com>
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

On Fri Apr 17, 2026 at 2:21 PM CEST, Miguel Ojeda wrote:
> On Fri, Apr 17, 2026 at 2:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> This all builds on the assumption that we don't have a process in place =
that
>> covers this.
>
> It builds on what happens today. From what I saw, Mark merges
> `drm-rust-next`, which is why I mentioned it, i.e. to help prevent
> something unexpected around `linux-next`.

We're not running the new process yet, so the current state isn't relevant.=
 The
for-linux-next handling will be in place before anything changes for Mark.
