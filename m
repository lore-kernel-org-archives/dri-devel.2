Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C228FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9497C89CE3;
	Wed, 29 Apr 2026 08:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="oTcVMN2u";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B5389CE3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:05:57 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-48906aa28cbso4437165e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777449956; x=1778054756;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=S6Sri/DxWYhekkoJhKaFCAGZ5nRi8N5LN4MWLa1I+oA=;
 b=oTcVMN2uPTvjmhRk9EQ20BK5sS1sqg182dC8IwfETscoxGg1LfXvXVwC2xqtjKlPVj
 b0qbLw3pxl7k3uZkJkKdBT7V7h9odH3/ik0tU3qdAFEEETck1lAvhvMciMf6R26iZJAq
 d0xXlNLfgJ99vOdSeEBJh6VqbKyk3mpf8wPDdYgIbChfCCKEhTM3NXTGfLE36KABvtcM
 bV/ic4osYn7xr4m/dSdHC78Zyi6xbce/3hTJ1E9LyG0hNZKmlmkCR65REkyriX9ujwWf
 sL1OQuPguKfpuwutVpZAi9w9GJb0EklDPEmEG41wDvwsQLcjJ34aoNQNk5FMA9/4TWTX
 1eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449956; x=1778054756;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S6Sri/DxWYhekkoJhKaFCAGZ5nRi8N5LN4MWLa1I+oA=;
 b=kp1sQyCQiMZG9TV3BKW7SpLw9KmM5LYPJaFmpo6WKDtyP6vMIv7OIxWZultHAXVxdB
 /iIqq7nhGpMX3qSIvvnblmI3TmlEqrLlV0JMh9O5JTcc1ewStZLnBQdLQk+iy360pM8o
 e60Vw0qkZdUv9Kj+629Z3+DRqZBwBY3Xck8mjlz48un3oDTCi2TRhe5P3o5Rv2WDu0l3
 GsNf09fk7j1a/cywIhv6YymlqwclkLUKe6NSwM51MC9Ys2XVoWI8Q/mnWiV1+w5PIuQt
 HqLDdapi+mC1sYGdjJsD/VS8f5VMkK0Lf0mt2IIlpp7LCSJTpAoQZG0cYLYYlkWBFaJJ
 A34A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9olc8uqOSRN2FpNAR5uzByY37Nbnwh1iiSWUAW0W/HMI3mm56ows9YhnK9dSnFH5zGdMFD9dHNFOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcHjKJqy2WpPRXp0a0lHRWGmBj4ZguSd922dUzYgPBntZmA5Rw
 ZOoR+VRzodTsMuvO0ncHiYJmPftjYVfa2u/VMzZvytaUIaBMuOKgGNH7r5s/LHK/RqBkUPLEt8c
 FgSmV3SW4C6FGv7Wqiw==
X-Received: from wmkz21.prod.google.com ([2002:a7b:c7d5:0:b0:48a:5351:7e80])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8012:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48a7bfb4564mr34552015e9.10.1777449956055; 
 Wed, 29 Apr 2026 01:05:56 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:05:55 +0000
In-Reply-To: <20260428190605.3355690-2-lyude@redhat.com>
Mime-Version: 1.0
References: <20260428190605.3355690-1-lyude@redhat.com>
 <20260428190605.3355690-2-lyude@redhat.com>
Message-ID: <afG744xkGUZBgNth@google.com>
Subject: Re: [PATCH v13 1/5] rust: drm: gem: s/device::Device/Device/ for
 shmem.rs
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com, 
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 linux-media@vger.kernel.org, Shankari Anand <shankari.ak0208@gmail.com>, 
 Benno Lossin <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
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

On Tue, Apr 28, 2026 at 03:03:41PM -0400, Lyude Paul wrote:
> We're about to start explicitly mentioning kernel devices as well in this
> file, so this makes it easier to differentiate the two by allowing us to
> import `device` as `kernel::device`.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
