Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2106C79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 13:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC2A10E35B;
	Sun,  6 Sep 2026 13:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YW1SB1Jl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4698F10E35B
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 13:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F03B600AA;
 Sun,  6 Sep 2026 13:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5931F00A3A;
 Sun,  6 Sep 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788700737;
 bh=lWPvpfMXPlnWiQN7mEAn4MklTWgtGgN38qTBOTGjkvQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=YW1SB1JllKEEzyM0SlwESPqi4536t1MUL33b3RoJOjeMXf6fI3Kpt3q6XmLAic2wu
 qITPAlU0cplNNnOgFolC5uXIAmx8RLY3fh7fmJVpR6EGJ72LmT8FB5lUD+bwAqMAqg
 qu64u+mKk6+kBDSjFMVH3vnkXbHc4rcIPLuj6PwPgUqOB/uXWMs94DTvCk8ijJvkds
 beSbMP8iV6gYHcz/tV81WZlC6V9ViYZMQ9ghdWUOEa6nDkupg4QKQZHIN1DK/6guZQ
 RUeRnvgBeh2bAwCTEVAiGQJW8lqUDVDJaFftYH1ZkpXXiRfbXS6jCLRT/5iXFK1+Qz
 Hz+teHfDBo+mg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 15:18:51 +0200
Message-Id: <DL89HO2ZTM44.1UR1ISN11D32I@kernel.org>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260903192248.2248560-1-dakr@kernel.org>
 <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
 <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>
In-Reply-To: <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>
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

On Sat Sep 5, 2026 at 9:24 PM CEST, Miguel Ojeda wrote:
> I see you fixed a few nits -- I pointed a few others in a couple replies.

All fixed up, thanks!
