Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34C606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WyxkJjy+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AC410EBF6;
	Wed, 18 Nov 2026 12:06:54 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCDC10EBF6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:06:47 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so7451415e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795003606; x=1795608406;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kp5w5RDq527SICD8D5Xw9eo93/nbQAeR3FOsszsY3AY=;
 b=WyxkJjy+Xj3e/Db6Vk3C79nFF9jQjXXTHczTO4gsKNgNaOy+49vZ69KLmBTvMTJMuy
 gesNInyu0wScrcLLOBOrWgHK1ECh0RBPbSB488p6nkkMSQxzd/Cuhtr1ikDkXfX2vKs9
 9+NubvYSZE/KaOPcY+eeKaKBFG1vCbCYaeA18YIrMkjzGWbp2Ukg31nHXm2Wy2G/4kGH
 9FyhrjfnHqosihAcAD4gfnoEcaSuiCVKTvFlPq2DdcPhSkF/eLp0nq10y0Tdo2l7o6Xh
 tvv9/8tKSAbSP4FFk/a7o58FWqurVd/JNuNxyCLWG3KffSlEkoBjKE0rHj7ViW8jrK1Z
 Axvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003606; x=1795608406;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kp5w5RDq527SICD8D5Xw9eo93/nbQAeR3FOsszsY3AY=;
 b=PvUf35nqaAxNskGBiiDec7JvV4qoN3vvNNz7QB3wodWtBbJLXDQ3fOaAcYS6hWTv3q
 czOGXw0Ekg56xmigC8wDS83setAcXpTHmxcwkNOLWA9KAyQcX0L4UU5+QzqIthJ5TEzC
 GrEi2YanaDULITjKvqe/mOwf59FrgW77aDMyjxs8WzI5/uAOtJH0WhAUJjf1NUSESW2F
 bHTYK+83m/Je2Or2u2AU5F4ZyqDXqdr30xki3ZDLAUSbne+7dHLrHzjfrpPlozRR4S57
 YVfq09LGHKeGOJJ2GIcDK/2eeQKm7Q+WI0bEJzsaa+uiID7KpNyOKVcyRAlJSwrbom4n
 lU1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGz2RK4buUFZAYpHq2ke0eIJRmgxG0As6uncLG4F/f2iO/AMidLKYKtSlD41it7uIir0hZv8Ry5VxU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8aRCS+1bWAzfClbEtcQI2u6ceX5504NzQT2f7zl8AvM+efnvrJ
 M+4ishlnwayHEdkjYo4caycXMFHzTk8OfJS8e/XWOTcIjKFQhIDhz2AnuG9JEANnCYyU/WfMVI3
 ubzjLtJeUAX/zYDglkg==
X-Received: from wmih2.prod.google.com ([2002:a05:600c:1442:b0:4ae:7292:22a7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4513:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb7da187c2mr43604775e9.16.1795003605603; 
 Wed, 18 Nov 2026 04:06:45 -0800 (PST)
Date: Wed, 18 Nov 2026 12:06:44 +0000
In-Reply-To: <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
Message-ID: <av2U1FflKT1mEotg@google.com>
Subject: Re: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
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

Do you want me to merge this now, without waiting for the other patches?

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
