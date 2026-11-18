Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D660A262C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=EdUk8q0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7C310E7F7;
	Wed, 18 Nov 2026 14:47:37 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CF610E825
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795013248; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OosozSG/m/6BH6LExb9WEQA9mQQDkOxmd2Y8kPDeXNAZWleSLQhMtNY2+uI8KhawaXUHYr47f8oAZn0N964ZgBYyXGCiT02s/Z74UIIxHA+2ECCTad4PExBsP1KYPsM1p9d/LWebw8uDaFCDFSfC3n7dR4fPjhnjaVOjF4NtA3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795013248;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6zB/RMHWdIa7W8+VTnT+QTtr7Bbpj33D57C4R1EDlas=; 
 b=cqe8Ny8ZQEg4ksL1wtnrt586k9283grpoxwjSmD4McSWu3wPIRDkuHOA1YRK5ZfamqOnqyNI78DibXRqLPs819yV6gD11Jo/arIUzj9zNJTH1COBGfE2j8gwXErFqQhmzCI9MFRRYLnAAbL6QecoLNE8t7leM49RtAMFWWbX1HM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=EdUk8q0VINosLxs21gOjRZn+nKLBqNq/iD5Npp0a0jH8Z7xTEQiaI5c3FegTTZMmf/wb4MixKQZxLGUPje7g1RDUnmXE3pAolvscDKNbqpVN641LJ1RB8Sh+t8DmYbQwsHocvRaTHw2a1WuFiaFP/IhlYOQog8lN6H29wfWIJUM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=6zB/RMHWdIa7W8+VTnT+QTtr7Bbpj33D57C4R1EDlas=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795013246789416.0565019034008;
 Wed, 18 Nov 2026 06:47:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v6 5/7] rust: clk: add devres-managed clks
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DMYELN5M09W3.1SYPKW7DZ70E1@garyguo.net>
Date: Wed, 18 Nov 2026 11:47:04 -0300
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Maurice Hieronymus <mhi@mailbox.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <189F36A9-D1C1-478A-A195-F94D037E4376@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
 <DMYELN5M09W3.1SYPKW7DZ70E1@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 18 Nov 2026, at 11:24, Gary Guo <gary@garyguo.net> wrote:
>=20
> On Tue Oct 13, 2026 at 6:07 PM BST, Daniel Almeida wrote:
>> Many drivers only need a clock running for as long as the device is
>> bound and never touch it afterwards. In C, devm_clk_get_enabled() and
>> devm_clk_get_optional_enabled() cover this case.
>>=20
>> Add devm_enable(), devm_enable_optional() and
>> devm_enable_optional_with_rate(), which wrap the C helpers. They =
return
>> no handle, so the driver keeps nothing in its data and cannot change =
the
>> state of the clock. The clock is disabled, unprepared and put when =
the
>> device is unbound.
>>=20
>> This mirrors regulator::devm_enable() and devm_enable_optional().
>>=20
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> Given all the device resource lifetime changes, do we still need this =
now, or
> would putting a guard in driver private data to be dropped =
automatically upon
> unbind be sufficient?

I think we should still provide this. Many drivers only care that the =
clock be
enabled at a given rate, and do not care about the handle. I think this =
has
little to do with C or Rust and should be supported in Rust too.

=E2=80=94 Daniel=
