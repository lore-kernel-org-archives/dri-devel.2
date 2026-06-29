Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D272C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7F510EB34;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aS6H8ltw";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CD810E832
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:38:12 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-37d82f3a244so1287981a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782733091; x=1783337891; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TePgk28pw9nEpIK9yqXWWcC9xjXv9gsRt+7mXvf+SgM=;
 b=aS6H8ltw9nmWaooP8ipCpMcAsP32aq+4O7cCxtl033VUG16kAKK8f/Kp+p3Mma5445
 FqGlLtcZvCnTH2913tEBDkGKjTRxxQAmC5fC66029UPoabVSK76u7UrvVRqqEDAPhlYb
 FJ6QO/LqeAVwuQdYykZDgbTC1JhjyATVJfz1gXF+QV00YUrIwoeTsNC8xmNbFGRGGdqV
 bi8DmVo5anpfI7aLzG/zNnsvUf1RiWeHxUH8zjjD4PgR89cvTHD3+UfoF7vViCWMi6Ro
 Y3r55bmnFcndC4wlingELt0z3owrrIWBrMU7OU2RrV3UFmvHh1QkuGEF0QAugTuwlRQ8
 c0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782733091; x=1783337891;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TePgk28pw9nEpIK9yqXWWcC9xjXv9gsRt+7mXvf+SgM=;
 b=JeyNyTW+FYqYVmTZnJc3EQYz/UhPkIRjjFx0RtsZustG62+S+QIJkHAF+49JGZ7ztr
 BG2qX5Fj48koaJLLRx8q+KHNrPktHrCEh4WIKIriWMIXAILfzD5EpY8oa84oARovRO2y
 YIw3HsCV71zNtrjMVFrl0qk4DIcr7CK78gO9Hi+/dkcfWp2eCGZsBgJNrU1euCt1CPUe
 FlR/RvwiHSjBU5y5/tGEMqm366TIh6BeEE7rKglcXTba+ALCj3V8IB+rC+RjMy4g/hoP
 RTg7ehW193T+EIR71sNcjPCKWMiO68CjDFD22MAvTfxg+VtFW/9jSKchfebiQDcIIOgo
 ITLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL6/7wCB9WY6YadlOU07j6dAhvGejgwwmOdgiEbJgztV/QUNJarZXO2rOfKPptrOuzsXBh3Bf5uVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf8TV3aDZxrlnxDO7gLXokJIeme6M9RJ+RWAywP5VQky2jUy0J
 oKtFXLjoav/TGEdmMHjJBCSoBfZt8ku4w2FDRM2iLfMumGwyHA+IM9tY
X-Gm-Gg: AfdE7cnH9unoeVW/zPF/3mtqnKMsqM92I5lhbRXqrewAcTMzGXu+MWG3FRpFUB70PJ/
 XUUikyYQxGniRRM3kDN2l2+D5IeLtuqA3nGEkYGhqPnIFgWG8pQx1t20soTbtw3S4oy9hqNOEQe
 UMiYYb8SKwxqbOg0H/GA85XiNhPdX6f12LNo4ATR4mvDab/aTE9AfdefSSA6gli8LBEWs4xq0Ga
 9nYZtZ6JueJBEBke9rCI3QDVnvltbOj3EkNKF/Lnm8QCKAb/2JXCS0rfE4dwRO2QD2UK8JZvvVd
 sVNkPBTRO5pNbcwOWkh+kmFjelt6rXe6zVs9/8yXRCSL/j+eSl44rOaliXWHxS1ea15z1UgnL8m
 aKWY9ibx+iIMhqNu9snWI4489LevZ9GkxKYUKYnN7J8oY4kMziJjr6ilsPC4C0Dnr/8/BtdbmLn
 By0IBILHPqXYwxnxuK3kWfRS2xC5QVZINNcG6Bua6Et/ODUYIYOI8s62fpU9Us4XMHiBLB7Rg+u
 M4DtzfrbIEMHLc8U3+LtcNkFIOfDslq0dOGKiWM
X-Received: by 2002:a17:90b:560f:b0:37e:1cac:d2f7 with SMTP id
 98e67ed59e1d1-37f7a557912mr8306827a91.6.1782733091454; 
 Mon, 29 Jun 2026 04:38:11 -0700 (PDT)
Received: from localhost ([143.248.188.236]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e24b13458sm5549594a91.13.2026.06.29.04.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 04:38:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 11:38:04 +0000
Message-Id: <DJLI4X05N1Y9.322KEILB5Z6RG@gmail.com>
Subject: Re: [PATCH RFC 0/4] rust: dma: bridge zerocopy-derived types into
 the transmute byte-safety bound
From: "SeungJong Ha" <engineer.jjhama@gmail.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
 <apopple@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "SeungJong Ha via B4 Relay"
 <devnull+engineer.jjhama.gmail.com@kernel.org>,
 <engineer.jjhama@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
 <akIpejFWuKZ61n_v@nvdebian.thelocal>
 <DJLEQ0UIBOQ4.2AQ93XKMH49X0@kernel.org>
In-Reply-To: <DJLEQ0UIBOQ4.2AQ93XKMH49X0@kernel.org>
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon Jun 29, 2026 at 8:57 AM UTC, Danilo Krummrich wrote:
> On Mon Jun 29, 2026 at 10:20 AM CEST, Alistair Popple wrote:
>> I think the context is in the description for patch 1. It's not directly=
 related
>> to the bindings generator. Basically the problem is that these bindings =
are a
>> little bit unique in that we access them using the dma_write/read macros=
. In
>> other words we use these with Dma::Coherent which still requires the tra=
nsmute
>> rather than zerocopy trait bounds to be implemented.
>>
>> That said I think the correct long-term fix here would be to fix Dma::Co=
herent
>> to make it work with the zerocopy traits. Not sure if anyone is looking =
at that
>> or not.
>
> I think it can just be done short term, please also see [1]. We can just =
convert
> the DMA code right away, no need for the proposed indirection.
>
> [1] https://lore.kernel.org/all/DJLEHDNJCUD0.38PFZ5773D6BX@kernel.org/

Same here [2], It'll be better to make full transition from transmute after=
 the new
version of zerocopy[3] and auto derive is merged.

Best Regards,
SeungJong

[2] https://lore.kernel.org/all/DJLHOQA5UAP4.340P2TKXGMME5@gmail.com/
[3] https://lore.kernel.org/all/20260625231919.692444-1-ojeda@kernel.org/

