Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C247CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 18:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA51410E1B1;
	Tue, 26 May 2026 18:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pe7dnKTW";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A69F88FBD
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:49:29 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so908186eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821368; cv=none;
 d=google.com; s=arc-20240605;
 b=PyaP2j8DUzaTWqaU93KyRIIbQq4Xq+ZlFX6eKLCj3lAcsxRepZeTExxx9RwLogqFtx
 UnV4yYHlORcbfnjLRS9RGNnYEs/ye4nwk/9Kb1qG0dsz00fBznsWxbAh81720VqJwI7Q
 VDUX83rtiU3kzarTi1a4QrR/nEx8WW6zPcqZG8kzakufJfMSYfrCCGJB6f9AZaGccptx
 G6CY+Ba6iIJ1XWR5IGsQgK0m5b4fNqhlEU7Vls78H9iRmTldsy4rOxRq3flCqbn6WF8E
 XSqEdqwb1G9+afCRY/sJQkP6T8u7LJo+ek9wSTep/JYQ26aACTcnvOMaoi/u+17dxb7t
 hMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
 fh=jTBaayff3jpWPvGL9ABJFLJQUuGRKsWPW9oqWIrG2E4=;
 b=PNjFyIwMsWaYygKEv2MR0qyX+Ri+cFRCRF8EEIT4xewXjbnf+D6KwZ9ncQqowrSJmJ
 BQpYLq6eJUT1kdjiqYNP8LOaDVDlHaISq+Rncmk9xa3j74pUOeBPMATdgkoDs1u56kzw
 fSAViX1NFc0v7zfi6b6Q0yq7DPeDb2K0aw8qhnRPf8N7RKGcZIdZEm3e1DQ0+Zn8RmtD
 hNMMiwf0FaKdNItWMXCyPMoSdHrvcbOFpkjKmvgJnAQa0w2rShPcYyr5cgJ9xs+uVS9i
 4C0f7MCjCbcmjMbcYKNtW7psg6X29Qsy4vg6f5ke3E/iEXlt8OEVGzbGj1H1982cQS2M
 wQIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779821368; x=1780426168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
 b=Pe7dnKTWgSP0glhMuFeHeV0s5XgK8P29DHFlObWowtkHRRAC0KBeLDIVabyDKZYp2P
 PEOpyZ8rNFJs1vhVnDTgWAVhD0O4y5eLaFzZZ2p84m9C6NleCTCrKyY0obVI6BwGHV8I
 5sbvJLSp9bvfuKhnhve1nAace3+Q9o1+l9iv1OblGNlyKgsYtuK/eMp+L99oXdyxated
 trmaCDPI0f7k0jamLK2vKzl5gsWJ6SWM73rRzmhWnXrn6JJGaW9YjYRrjr56hMpIPNIH
 awnbbs/WwI29wTOOJa2xg7CxTFs1Hgq2Ewk6zgpTzE41FFgHZVk+qh6BOadPp0BYzkbA
 Pwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779821368; x=1780426168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
 b=ggQQz1yp6vwglTWh5NqBgpuziXmehmpY7dKFrpLcitzhjvIUKDZfU/avCWNbOhOmPX
 Z31YJ/pD6FOAK+KDt4Ug5yHiaqmh+zGP9q/POo2IUtbjlcZS55WuuRyh/RoSULvwv0p8
 2lh68m9POPuAtCVOQujf9/HVTqcmpancgvMNAsQCya1kpXwEEfUi4i+gbERjoBd0n2bP
 BseFJb+ZMdFSBVAQSk4YcQNl2oSxXbxLCmV9B1ELqiPKgQiMzcMG115XEL+VIyw7OrEN
 CUnjrX9ItYx03L7lPJVznKX4z9RtgrBoznW4GGjTguKeKcUe4rfXAGzh6dc5GTlBDROk
 zaZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WEE690lq0TvlCIZPdITXQouSEYr9JvT+KiBOSzs1BxvzkwfnSwczXhOBcKVwhYUQ3Cxwn36wV3J8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdpyPvfj+QEm3sOUwUOzoNlMhMqCiJlWw93mc8mBQEijZYeqik
 Z4t3XdIXA6F8Gr4kqtOfJw0hUFI7sSGIMa7wqcj6SQ/MFfdIzC1xscN8kGjbeStkNA9iaVjrzbR
 yw7tXQifFNLtiASllUiIwgMlkhKt0Wzc=
X-Gm-Gg: Acq92OGa/aBiPuYZQGuc/hS5UvshNsQUAaJoJiYBicR7tnGuNZ5OqcFdongNHYiXdIQ
 28zwamRMyr7tn+pXDFnCI0VeldBmElEIFx66rWmWOrar/ztb8UBrG1hPHUp0zvmnwjICDVwvUgl
 E3pcDwcrEm0fi06XqaaRhOUeKLnGvAO7DHpw4Js7/XadqYAkMjk2tS/14nBsOdlGHrY6TdJd6gk
 2R0kfAm2zWrrF3FFexR6EGAPWOafJtphalFSqTWZj18FDV7htpXxqgZT2CU05ah62xkRKf+xffY
 p3C/i0PFrtTTQHMZ6GwpbSR9E7lJ+jQSW6E970azyyg31z+ZfQv+5mEO6Blub0WetXBZT5Oiu20
 h1SMzc6PRxP5srFIgyYVwgLI=
X-Received: by 2002:a05:7300:5711:b0:2dc:e799:934f with SMTP id
 5a478bee46e88-30449099a11mr4340063eec.3.1779821368216; Tue, 26 May 2026
 11:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-23-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:49:15 +0200
X-Gm-Features: AVHnY4LynmVmerdJFsxXUCWY1urLy48wQB7u14V2mO2sDmYd9U9x9x1s6x7Cz50
Message-ID: <CANiq72=iLUncNw35tpRinUt15W0aqsEiNn+rMcjC3VGq0gx0Rg@mail.gmail.com>
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
 pcolberg@redhat.com, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
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

On Mon, May 25, 2026 at 10:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +/// Representation of types generic over a lifetime.
> +///
> +/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> +/// can be soundly shortened.

I wonder if we could keep some of the commit message around here -- it
was a well-written one!

> +/// The full syntax is
> +/// ```

Nit: we are not fully consistent treewide about this, but please add a
newline before (and after) examples/code blocks.

> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`

Nit: please end comments with a period (most in the patch are already OK).

> +        // https://github.com/rust-lang/rust/issues/152489

Linked to:

  https://github.com/Rust-for-Linux/linux/issues/355

and tagged the issue with our label upstream.

> +    // Currently the Rust compiler doesn't check this, see the above Pro=
veWf documentation.

Nit: `ProveWf`

> +/// Obtain a type that implements `ForLt` for the given higher-ranked ty=
pe.

Nit: [`ForLt`] like below.

> +/// Please refer to the documentation of [`ForLt`] trait.

"of the"?

> +#[allow(non_snake_case)] // The macro shares the name with the trait.

We normally put comments on top of attributes, but if somehow that
messes up the formatting or similar, please ignore it.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
