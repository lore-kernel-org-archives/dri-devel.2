Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwbsSEGS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B78A10E2FB;
	Thu, 26 Nov 2026 16:47:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1C410E2FB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3B3943969;
 Thu, 26 Nov 2026 16:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBF51F000C4;
 Thu, 26 Nov 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795711663;
 bh=OPyhiLuvaz7fWLByy/7xp+zcD6om0vncqH1lu9yD1QM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=JwbsSEGSuDUbdeGbYrF3Iq8qSdMKqQ2MtsTfSl+/l4/UaARiVByGhY8i+Hu1r2fog
 XG86xtnpCdDdSuhKKqH1Ia5/K0QGREDEuKYuOCZ6h9UAANiEfzk7n2KA/DF/k8dWGn
 E47BujKXFKpf0k/MfJeCjJ4dLP9G0NhfpKvpWtWP2kyi9ZrpyM9C2o+eH1mswJeDDP
 7spQ/PCuY0nsoL1FLkjsdOjKuU/Pmii9p01EapSR3Tgxv/jpEWaMTFq6Bp+6zrRfNj
 LsPjOIlA16BW+T5C7zpTqs44xVo2P/7PvW2puGvbaJVNjoeVTxomgGzH9DaGJlLhPN
 DnDVP4eknj/wg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 17:47:37 +0100
Message-Id: <DN5ANMVV3IBA.1Z2USNB5M8X3M@kernel.org>
Subject: Re: [PATCH] rust: drm: enable standard fdinfo for Rust drivers
Cc: "Janne Grunau" <j@jannau.net>, "Gary Guo" <gary@garyguo.net>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Asahi Lina"
 <lina+kernel@asahilina.net>, "Lyude Paul" <lyude@redhat.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
To: <peder.bergan@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
 <20261124185427.3821700-1-aliceryhl@google.com>
 <nh-b28a5938-34e4-4077-822b-71fae5f4773b@google.com>
In-Reply-To: <nh-b28a5938-34e4-4077-822b-71fae5f4773b@google.com>
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

On Wed Nov 25, 2026 at 8:57 AM CET, peder.bergan wrote:
> Danilo, I=E2=80=99ve prepared a v2 against drm-rust-next with the callbac=
k in
> UnregisteredDevice::FOPS. Would you like me to send it?

You mean UnregisteredDevice::VTABLE? Yes, please do.

Thanks,
Danilo
