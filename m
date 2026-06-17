Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC02DCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F79E10E2F4;
	Wed, 17 Jun 2026 15:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5NNf34a";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7919E10E2F4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:17:42 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bd960e807so57906eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781709462; cv=none;
 d=google.com; s=arc-20240605;
 b=ZBfGIpqNTJTmvwWoa0wIFl/uS04X5uhbvk5FJzBY5Qb1GcxFmwyEXz3cIzXqCa7bg8
 4wnfS0W6oobAtFJbrQYNxIpwNikn/z6cXu1vtrRlseFI4SsVV8/PepsJRxFB/Slfxhtj
 kcDUzLCXC5JTVASdbwI4hI59g9jHKLgz5C2XOwiw36jIcedTCTAndZ/pjiIbNYc/IVPs
 qIGDnzx+GQAcslik2OnhuFI5AjwL8NnrCVArLlpy/Y3fEssU5kKvIFgugpFfilBvxUsK
 EqR3PH6S3AnAk6E9ZLUwiwBEJfzw6nBpvY41IVLKlksor73QcxlmvPPJibpVSnE8ZFMU
 8chA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NZ4Sy4JQrTP/q+p8S8QsQ6CBhK9DKzA2TcsezRmBCVM=;
 fh=NIKAJTkRJYo3PEM0Nru/6R8f0EPI9+QWZZsBblW102o=;
 b=Gfc0pl0FpTI20SM/7+6d1FVEeKQtCW00so1Cn18S97lAiQCCQLmfVncquDISYgLnFQ
 GK/beRb+K6bJ6tY0K0rCauXJDCLXfKb3sTPd5i3kkg5nKkhJ2zk2Dd8anfudSnhBas7D
 UQvq6uZvBFxCf6/elECzP+YGS7K4apZ1Ytbf210ATAErJDXTzu1oQ5a6pG35rjbuyy+K
 qRsJFcBj5LLcyp0DV2sfpFtBgFquWTPMuxLkGFIrVcnrABLeQ0AiHhXErQDuYtPtPBj4
 YRtV+AMZDfmW1u604eugHfTmWU+IrUMBII7vJi6IkNCQboNXSWOeEOAQpkK6qBYi1tRA
 njdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781709462; x=1782314262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ4Sy4JQrTP/q+p8S8QsQ6CBhK9DKzA2TcsezRmBCVM=;
 b=l5NNf34a5+5NiR+lONwfnJFeI3IwT37V5zKpGa+4rVVpT9PWlHHQ+IXEwXqXMXGywC
 jjbj7l5yFgzT2SpsPYJpCaCRrGiU55AobMU+GOHxLopSat+Oa9XQSXsMGKeE6MoEajE+
 QOfPhK2HwkaaxCZO1XC00Vb0VU/igc/LjtYUum5TiohkPgCohRo8lClOVgZCPftwfOCA
 PnX1gRXQ4IoL/vChceCyeq6/Trgah7AiKA0o8ff3rmjschrf9p3IukIIbJxeYOFQ53hF
 1HFB6GbtjINvd0xOFq/PT9vz1UCXR55TvYDmaGyP+32yN1xUFGYZmydIUkj0Mx2P7egU
 ZzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709462; x=1782314262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZ4Sy4JQrTP/q+p8S8QsQ6CBhK9DKzA2TcsezRmBCVM=;
 b=F/vPOz/86oZqlEdZ8YxD5X9QjF6i9hF8dQvvl4yzJzf3jH/nGPe7jAZhZdCk9l1h6n
 SdAfUxJ6udYh1lZt3caeZblPQ8/AVIu4OFnYbQZQjtIrEtUeAfFxJzvfSvfuBZVXzq49
 b0aqvhf0EkOrZiPkwFaslmqIm4RqykTp1xDFOAtiEELJXgI5sFK2PT4eDFjOm8EVU0WN
 CsxWZXfBueCDQAQ+hHJMJeERV58sf80n5mlJzAZbogvTb5sPyyZJTjAp3q6FDGBZMc5Q
 iXk6vkAVLoSmJUKJSecuLLjlJIll5lDD4XY18YuJ9ItYQe1LzL4uS70nr5gsFo8UFa8G
 kV0Q==
X-Gm-Message-State: AOJu0YyNjXHdYDW2pQrXMjNzckxHBAzAxjXXg41tCq0HERGWQ00e8DX1
 b2kalVxEnnu+8/LIjraOSi1GSoJzyXbnS9SayBd6Q2aeUrSsG2Jgp+fPdVwzYSO35UwZLEF/Plw
 fxjN1KI+a/CpwEQq9lwT7dlCLwhfiBdw=
X-Gm-Gg: AfdE7clf4Dqxne4i73F/i6AhNTaDulVxMO1VA7p6GGeGCf30wBmz8xklaEh4ChTraws
 8Ho+PgCQrL0oKktScjB0QJtkxCo3KmVvUYC0gmTqmViwxDdZ+FGTOwjWKbpmt1Ms6oqtIc2Esv9
 iMbZtjN9kMGXSGgBrD0xUhKHvvq1LdpzbB/HtOIr3lesCQcknqmIdLn6Q2mdU1kOpr3fpHsAa54
 eC6GV1pOR8c6R4gRHzXTW0WrP1chnexRUW/tngeNHQ8IA4jp7UH1q32KUzpvg8TGZjNRt1XueST
 k8PaQDuYInDT3+jtf+evhNgRwB3jMMN46AYQebt05mqcY37yGb2VcJNtccoD5d/6xEDeaixiTaI
 YY7qhl4qQ6v9v
X-Received: by 2002:a05:7300:818c:b0:304:d700:1e90 with SMTP id
 5a478bee46e88-30bca0cee9emr994355eec.3.1781709461303; Wed, 17 Jun 2026
 08:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-2-mike@fireburn.co.uk>
In-Reply-To: <20260617151249.2937-2-mike@fireburn.co.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jun 2026 17:17:28 +0200
X-Gm-Features: AVVi8CdpchNqwZLZnXkatbCgAOWgn89zdy44pTjmHVnT8YGKMWGaXgvqWfIOA04
Message-ID: <CANiq72kG56RV7X=UZ0WRJN1t-Ttkd7pCdcg6ibx29uoitLiuMg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] drm/vino: add DisplayLink DL3 dock skeleton and
 plaintext bring-up
To: Mike Lothian <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 17, 2026 at 5:13=E2=80=AFPM Mike Lothian <mike@fireburn.co.uk> =
wrote:
>
> Vino is a clean-room, in-kernel Rust DRM driver for DisplayLink DL3 USB
> docks (Dell Universal Dock D6000, 17e9:6006), a native replacement for
> the out-of-tree EVDI module plus the proprietary DisplayLinkManager
> userspace daemon. It is built on the in-tree Rust USB, crypto and DRM/KMS
> bindings (posted as their own prerequisite series).

Ah, so this is the user for all those series. Is it then something you
plan to finish implementing and upstreaming?

(I would suggest linking this series and clarifying those questions
for future versions of all the related cover letters, so that there is
no confusion about it.)

Thanks!

Cheers,
Miguel
