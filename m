Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA039C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5399110E8FB;
	Mon,  6 Jul 2026 11:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FnepgsF8";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97E910E8FB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:48:15 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-493b786d550so31039495e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783338494; x=1783943294;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SkCbYuGW3eqT8pRjM9jVxDre32BJW2V3ocHTz8lleCM=;
 b=FnepgsF83857FJve1yjqFCNXGckk4hVPPtdTdkerVUp474/571wrjxaosEGFNplgZu
 LsRtxu/vDD6ZWemGHG51h4v9iS+7tGmRAg8Huz7KpaYTmSr/1lhldm9sDduPG+/XfVY9
 o7ypfaT00E82UULru3KhqpLOTlzF0bF2S/HZ+GPr/t7YkZxqPCAEVLZQyT/q4oklmr9D
 RRRl4GJMjRDhfgSjEQ9/2ZNCZTmFsaKSts64eT3MPj++mrEolTxmTJj/P9BtRUIYaiv/
 wRdPAFof8Zzqp3O68C/Ljjs22y9J651njv9ygkikF27OdF+kKCrrbf0oE5C6Y6mM7zqe
 dj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338494; x=1783943294;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkCbYuGW3eqT8pRjM9jVxDre32BJW2V3ocHTz8lleCM=;
 b=Wu57YTziKnhRF3AZR/x2Td/qbSh+bc/SYK4nu5Af3hJZggUfnMthNT2r/ESPjode8n
 3Mzkw1fdgD9RdB+sr2mVs8OYBQ2yxILcdlCuj/cLSAamRacnw6EmWAXTFWya1E7oJ/Bq
 bXsOOs2jvfnVbgu5kJJ/ktV2rzRLBGKPE6pCGi5ihyrxhBaddfcLQDwovCkSLbGM8W15
 yMouWFBs+5IhcDueVHMaNF6CRfm+FJZfZoEajbDjhdgDZNzMeqHyDQCMfm/IVbjC3WFW
 U8QI9GRcvNwqauloIEVLY45k5BEwXk5LaxhGBEbJqd5UbBZOrSfJ9iuWntMRH5n663Zt
 J/ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMMbh0/hSKFI+AvD7CCjJx8YTWXRsHylsk2l4K51LLdOxdRGB6xknlu1JamVO7n+76gxN9WVYU0hM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxejzWEkuKuJ76o/clUKIFdYqpsBVgzulLmO8FTZHepSo+IqEcB
 Drk1TITk3aXebdgiTdWTlfgGSuL7H5hi5Uc8Blj8s6evMsufSCk6ACsdX1w0WWr7igl9fLOWPKx
 Q9logEkZc8bCb/kmcDA==
X-Received: from wmdd24.prod.google.com ([2002:a05:600c:a218:b0:493:bb1c:478d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b66:b0:493:a7fd:15d6 with SMTP id
 5b1f17b1804b1-493df08b4camr610775e9.9.1783338493893; 
 Mon, 06 Jul 2026 04:48:13 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:48:12 +0000
In-Reply-To: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
Mime-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
Message-ID: <akuV_GRAM4QPqf-o@google.com>
Subject: Re: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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

On Fri, Jul 03, 2026 at 07:16:03PM +0900, Eliot Courtney wrote:
> Add support for reserving of ranges of IDs, with a usage in nova-core
> for channel IDs. This entails adding the helpers+users of the C bitmap
> API for ranges of bits, then users of that in `IdPool`, and finally a
> user of `IdPool` in nova-core, `ChannelIdPool`.

If you need ranges of IDs, perhaps you want the maple tree instead?

Alice
