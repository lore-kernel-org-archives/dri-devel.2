Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28024E9380E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4833510E03C;
	Mon, 13 Apr 2026 03:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SfTroaC+";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C4910E03C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 03:58:39 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c742723c863so2551378a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776052719; x=1776657519; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fr/lzenYvIspGVOBd9qA8LexXmTvhf6tDNuKiRhUvmY=;
 b=SfTroaC+j7SEQ1oFB5vdKtiY8NWau2yK6wfpVJn77/Nny/mskBLNH0w+JUjN2bmn9S
 bxsDsKHVwcXV4wus574gDXuwDsU1/ULME3Y6bEG5b+bU5qZD5XOb8cWV/7Vfs21KVXrC
 lgmQg33GGQluCNvKA8f00E38j8VP52hkvnl4ZhLzCY2hWo069Utic8yFlJgOD84tpH0x
 RWqzX+6pXj0oZTvlQl80WE274QD399b9sjP+F/peJMCoBZSwxYz5J99Dnke27FXjbYyO
 Hx///CHqBUC/3y4JA0CpKJCiMQ+YzTMJ67sS/6ZT2aEH/4D6fKWifgHk/gADgE+agCQB
 SCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776052719; x=1776657519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr/lzenYvIspGVOBd9qA8LexXmTvhf6tDNuKiRhUvmY=;
 b=NKn3g5iM+1f/P0Supml6bPjRHcA6U3H4BmauG3S2S6MgLC5qnTMGRwmxbDLTpOfOxR
 GC5N+JHnIRz4yyLHRpdzWpIAq4nY07GfJDgkGhSye38MXeaPCcKmCXHLFvp+bZ9PlzRf
 5hnohk9FCVFfjF8Qe2Co+E5juATET2H6PtdMooKsVxmR7ET1HGq86+proRTZ6fSX93FW
 whdsirl1BcaI4DVQrp679x5KDouirxtiqm44bCKwWVtz41xlz6tdmrrbBiRFLxc3aiUX
 YvQ17876nJ/vKbggKs69CNIq7wPVKXlLtjSxJ27WjplsnxRZWSyndRWC811lohFprd6P
 f61w==
X-Forwarded-Encrypted: i=1;
 AFNElJ86J8kCvItraaErnOUEvJ3JuIkhz0kQYg3dLYdTVrDxd6C8+mXeAH1f8F30nhBkfUSynxqDlB1btHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcGl+zMkLC7kMJ1ejan9rVLHJ6+DWZCnzL6IU2q0aB2hAC/Zff
 VPF8i2kXhxMaSWWjCu/424s55BcmrXOYK2AfsfWWKbJiTK3CHlN9O0vaWpO6JRQ/oKg=
X-Gm-Gg: AeBDieuRjnz1B/bOi6LK0YEo/A2OARtzQU/xbTzXAW+D9Uj2yBzZCi+pksl8v5/KjNm
 opVYLs0A/aPDOUc7E5Hy/1xeWgP4A6EFYELzS+yvsiS7S6SGIRBQKAPBLQDOcZbfaETKZFfYHLD
 Giwh0xYbaFGa1+Hhu9ieAXP0cj6/svUdSa/TMavRjLXBbFzCecSiV729M5D/0YFLqgUQgZJ4tVJ
 ucKvCyRCs8jCM6hUYc3qOx+F0h60jSH/IV6E5LY5SuNgP4kmpwqpD5Gj5QgyqwS2Wwqm0rzJ9F2
 7OVW4WTfrtJdCO2UwVO/beFqT6qziafD07TrDfN/Cvnw+TCxgnHzrw4SJD3XbqQr1OICdciZ8Xc
 QEM7qPxXXB/Fr5t9JFkz+7vUjWjI+/deeD+yWvToIEKwbQ3aecSh+uMc2nG0NTpmSRhlptwRZyD
 Z74Ij2rNowJ4iNPj5/+D01A+mn
X-Received: by 2002:a05:6a20:3ca2:b0:39b:e138:e230 with SMTP id
 adf61e73a8af0-39fe3cf7579mr12869459637.13.1776052718668; 
 Sun, 12 Apr 2026 20:58:38 -0700 (PDT)
Received: from localhost ([122.172.81.200]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0f8a7501sm9627799b3a.50.2026.04.12.20.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 20:58:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:28:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: markus.probst@posteo.de
Cc: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/4] rust: devres: return reference in
 `devres::register`
Message-ID: <gm76z4ngcpgbi4f7xym25n423wmvdac3meou4lefd26hgqqp2p@aziculojtqan>
References: <20260411-rust_serdev-v4-0-845e960c6627@posteo.de>
 <20260411-rust_serdev-v4-1-845e960c6627@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411-rust_serdev-v4-1-845e960c6627@posteo.de>
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

On 11-04-26, 17:10, Markus Probst via B4 Relay wrote:
> From: Markus Probst <markus.probst@posteo.de>
> 
> Return the reference to the initialized data in the `devres::register`
> function.
> 
> This is needed in a following commit (rust: add basic serial device bus
> abstractions).
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/cpufreq.rs    |  3 ++-
>  rust/kernel/devres.rs     | 15 +++++++++++++--
>  rust/kernel/drm/driver.rs |  3 ++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f5adee48d40c..31bf7e685097 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1052,7 +1052,8 @@ pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
>      where
>          T: 'static,
>      {
> -        devres::register(dev, Self::new()?, GFP_KERNEL)
> +        devres::register(dev, Self::new()?, GFP_KERNEL)?;
> +        Ok(())
>      }
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
