Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24537606A331
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SGQG7tJm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0A010E799;
	Sat, 21 Nov 2026 14:13:02 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BAE10E799
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 14:12:53 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e011829easo1049989f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795270372; x=1795875172;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PuHKHlqLNR2MksId4LLRNrhrnwLo9yVhdzo1ZqEJWls=;
 b=SGQG7tJm/JoqGTbMh5F9K8zixDFUpuGtz8YNKOBk52bJCsaYTTiBPnxzcg921XBTP5
 JdfXorzshpV5Kr75dQm80dvUyi4qEGEgyP+eZDYklBpp2zdKAQ+X2WpqWbJIldsiG7MO
 XHg2PgGUCJH0LjSRXF3UTPbOWgM7CycbIf/VRuduSWGVBDc7NX5ax068UFvZii/vtPOl
 cLQ9/Gn6naq29GxObgMCpmtJmMfYZbro1YJmS6Y77RoajWDOkJlszrCXnqNO3LcZDfXv
 bvmGBCCN8Rj89842huilHGRoTaTZbmPQ6GiwwbfM7LVtXnHlYgF1fMOKQ39/8qDqHxCN
 Gm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795270372; x=1795875172;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PuHKHlqLNR2MksId4LLRNrhrnwLo9yVhdzo1ZqEJWls=;
 b=mugD4ESfzLeB+uuoWRK/31nqlYHNP1CqsBhkXRkECc/Wef8KZOeek1I86ZtJVal5Zx
 NheC1NW96hxNh2EqqFe31OzAzM2Gl/JbwDqrWFKBfA7eK3KPP1LzZF5Agth3EaGZ1cBy
 yLyyZvevfnXe3qtWSGZeywXG5xgXcJKf81gJQLB3qArXM/Hy92t4iMv6BjBiphGDHlFS
 gwU3cr4Qxt9fnrg+n1oaFAJSp5o4U/M6H96WQEv/LW24CUwP28NS2ucJiy/oUYsCEN+3
 UHrAyydvAlBUMoatHPMWk2zwKHNg87QXcIszASh/7PrEWjKA1HANoxxcv1qbaQOc3HMw
 QbvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFdlwwuh0jpyfSlISjShSGHCrhIltUOWRabliC8vV/tJSIbTlTKAih3W2TyiyM4Fact+IytFuWmz0g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+DPqXQwXGopFFqji5OZzMOSJjJ7LqC5A0RMV0coJwGl569LbIA
 Whi1ZOsKzVWab2IHgV0BOtiVMJUQnDcFJCEo7T+rgG0GxrS4J8Qkoyqf4bftpOanxUojrxXxICT
 Bcydjyuj6EpIeyzAQvg==
X-Received: from wmcz23.prod.google.com ([2002:a05:600c:c297:b0:4a1:e780:89af])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0a:b0:4bb:840c:72f2 with SMTP id
 5b1f17b1804b1-4bb889323a1mr136801365e9.25.1795270371975; 
 Sat, 21 Nov 2026 06:12:51 -0800 (PST)
Date: Sat, 21 Nov 2026 14:12:47 +0000
In-Reply-To: <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121141247.142001-3-aliceryhl@google.com>
Subject: Re: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
From: Alice Ryhl <aliceryhl@google.com>
To: "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, airlied@gmail.com, 
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 05:32:26PM +0300, Onur =C3=96zkan wrote:
> Previous reset may leave the reset completed IRQ set which can make the
> poll return too early.
>=20
> Clear the IRQ first so the driver waits for the current reset to
> complete.
>=20
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Applied to drm-rust-next. Thanks!

I added this tag when applying:
Fixes: 6ea52b6d8f33 ("drm/tyr: use read_poll_timeout")

Alice
