Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C77606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=3u8FKVI/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=by/oM2OY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E60010E88A;
	Tue, 24 Nov 2026 13:47:00 +0000 (UTC)
X-Greylist: delayed 420 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 13:46:49 UTC
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3F910E88A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:46:49 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 32E731D0058D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:39:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 08:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1795527586; x=1795613986; bh=FFPocmiYjY
 4uBN7YtxnCPmj3gxT6Y3NraGib0JuLZOA=; b=3u8FKVI/enGiX4SpeOpEBmpEvX
 aBv8TvMxxzF4btN9FAYKThFHiu7X7N0FZR+cqUl8jyMkts9nZbxT+1e2+oKcJASc
 C8Zwd8cganVwj2OSt7VKiqWX5gKKUfKk87Hd9Lcwe2yqlyAsFKcCgqAqI98UIqL2
 2Spk3c0nkJhVTCcOkact54bH/2t16sdZCE/+P1BxhiIbxI+LmX4XVLl2AkJbvtBJ
 14cN0o8Idi8wgkCDgMD7o1na/dnGVZpXvUad7F4Itow13I0vmPjomIrE9clQIHMl
 dmIOXDWcIbfrhRGEyj3+K3ffDpS5K63GwT+E5dJx6Pect6KfjMf7qNXq42/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795527586; x=1795613986; bh=FFPocmiYjY4uBN7YtxnCPmj3gxT6Y3NraGi
 b0JuLZOA=; b=by/oM2OYQLK45eJq48XUNA1hX//hn3i5lbtoZY8KzPP9lcQxzgA
 e8W6F0880h/IxZNfg5BPLXhps1JS/5Ik8+GbsLQJMA8JFqU2fPTLuUzUfpMZEBy4
 1dlpnBLyTjK9g0AkM0WguaQiy9GGL8CMwVcT07NW0fc/Sqbme4Mh2ZO3f9Yt8Hd4
 MF+YmSZ9Jy67iJGfcuq/Dcs3Thv+vSnR8EjCnNbLsMIjkHd8je344Acu5IowkKxu
 Qgu7Qo63a5tnRjGS2VLfR+3nf7LlBL1+bmlJIsSt4Tqrf7VBiJr6xZ1ohCbjo1n0
 tHpQsVOQfjvjllYu5MQdVRmSL8169nN5fzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795527586; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:lgSxiI/EK2BEC631CEF3Atdbu18n2Yic3Uq8r/p/gZDrt9H
 nVK0R27zjK9kP6lsbM9Z9hHVCfOCKa5tORie3ClkfAoeKGZV55GXztDZsuszqG3O
 lApcYf3wgt1+WdNY1x4fOQxgTKb3xPAfBQG0xD1wH41PDLdnuJfN7tVrOSCgbYNC
 mbvysK6+HLfb5p3snSdVlmTsdnQ0kb8MtKHoPYxJ1LzYosSj3M6F7oMSKqJJAS0P
 wzIcYQfY5Juz7Yv4qfqv1gckdl5WTTNcX5q9SrR06plRQoiAiwspBHYkRg7fneP6
 4Sfe3G0RMVg9OF1+8BTxo7qOFDbRno0gEWAhwOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:+4ev4b6mxHnY25pdL20Nn41AxB3DfsjG2hFal/APdjM=:tuy7Q02L8EFGyAlb/RTajzDppwDejqGxKUsvjdBdGZs=;
X-ME-Sender: <xms:oZMFa67Ho0y6HXBSX3CJ2MosLcdKnQNDtwBPM34ltRrNfKhN7U5ToQ>
 <xme:oZMFa0Ug99pQyk5vvOOlsG6_V6eA4JzUhQirf0oGqfG0DfKnz9a34KSQdOkyh2A04
 3NXgCkjakrjmFwKBjYjdS-9PaPX6dxzIM9Bb-dXpS0k81ApSqU9Sog>
X-ME-Received: <xmr:oZMFa-7-kKzbsnjcJzV12ts_etvG3AxNbq7EAl-5vHGUs9sEsQf6RYrUjjz0xtfL1NbXtQlJvBMokCmJWRQIwrUqQHwkdpANxww>
X-ME-Proxy-Cause: dmFkZTESlBZ1BuWOe+JmUTVOFojllnFIlNcYBew5u3AEO/m5xTCbKEeFkRQF7OGVf/tX8T
 h/i9V7vfl+JMtQsvzqaD6jIwjRZ10u9k+PQYJC6AFKCtkCtwZuvqe5uDKGokPJylK4JKE7
 5nr4nOwn2m+UvTgT3l/15tMjM9IY8d4FwGd8NCK3NTpUv4186uhiAY3yrCk4autrjnKz9a
 qvREk+HSNuOK+UuyioWs8kYmt0XK8u5JbsuhHng1mHLFw78Nh6lrSdYQdign+ZCgIl+E+Q
 Ix3UENuWSWr9uY5l0yTToy1m0Gt30AKG9WklczbCNa59q6Tq6x8agtI+ZUvictJGlQYirB
 YLtmw3d2wtCb8oRlublfJ7zK/GEHEdwqHPSaOfeA0neCJaSquWzKyeTFIb6r7FcAU6etuh
 hNv1qIakJip8Xje33U6cLveSeSTufTRPV7cLpWSMKpB1apaUuxHFVFIRQs6ge0YKAXjHo/
 xxYbhJOBhYORFfvX8d6IX2cYHbb2ziSRg8dl2f5955xyUUPgH8jQnLfk3lzz9PutsvXC9v
 FGTFKYurFsyi7tEySux1IQpsn6xypNA4ZXS0JozfRqenLXQsUqcpxdAVQOoHJ7u6asIlqV
 xbVFz9L1Q2613VDJgHo5+dN9WbOD6oWExzCW2dCM218Ra0EHhTOrRyyILhYA
X-ME-Proxy: <xmx:oZMFa1G2ZjzOevGieoPIWUTRsyuZloqzmaMkNKT1EVyiymEZ1gt8eg>
 <xmx:oZMFax_f60edb8Y9k9tqrQdbmhOWIDFcbtRAdsTgiuVpHoxmO4sYew>
 <xmx:oZMFa3XhQDLyVB9KS1UzXyhgsNEcnVJa5rg0vg6OZtJBLmYEaf3Itg>
 <xmx:oZMFazECzWRr2ZG51ct7gAEukGErUWyrRpkr0Iwpzn8SIbbiYoZOMg>
 <xmx:opMFayrjv0nTLBIJkDe51obopTxGaE3jeJFYxqhPnmyhlZfod7IFXooO>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 08:39:45 -0500 (EST)
Date: Tue, 24 Nov 2026 14:39:43 +0100
From: Janne Grunau <j@jannau.net>
To: peder.bergan@gmail.com
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH] rust: drm: enable standard fdinfo for Rust drivers
Message-ID: <20261124133943.GA372978@robin.jannau.net>
References: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:48:47AM +0100, Peder Bergan via B4 Relay wrote:
> From: Peder Bergan <peder.bergan@gmail.com>
> 
> DRM monitoring tools use drm-driver and drm-client-id in procfs fdinfo
> to identify DRM clients. The common Rust DRM file operations leave
> show_fdinfo unset, so these entries are missing for those clients.
> 
> Set show_fdinfo to drm_show_fdinfo. The DRM core helper emits the
> standard client information and calls the separate driver statistics
> hook if the driver provides one.

None of the drivers (upstream and out of tree) set
drm_driver.show_fdinfo though as they can't yet so only drm-driver and
drm-client-id will be printed.

I guess this is ok and if a driver wants or needs opt-out of
`show_fdinfo` it can be made optional then. Note that most C drivers
don't set this either only the main GPU drivers and a few npu drivers.

Tested on Apple silicon system with the Asahi downstream driver.

Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>

> Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")

I don't think the Fixes: tag is justified. This is an optional callback
and the majority of C drivers (in numbers) don't set it. Even if it sets
it won't provide much useful information for any existing Rust driver.

thanks,
Janne
