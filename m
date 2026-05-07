Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7C3CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 12:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A08510E0A3;
	Thu,  7 May 2026 12:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hrz8wgSn";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BEE10E0A3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 12:50:57 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-488d8deb75fso6500045e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778158256; x=1778763056;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
 b=hrz8wgSnx8FTXOsYkJC7bHJUvne+4Poo7OJmdYcD/SAqkXHKIQC/mMfhlKbwRa0VQl
 QiUitEM6QqJrL7cE9SiApywkSThKsmz6Kp3l91aIHwyMBHg5TQhi+V5f0zoglXFV+Nv2
 R2KRsESjQI3i/21DFmUW9gh/oxVJTCqD+9sxrevuMqXg2K5gkk19hyGUkk0K5EcH3hwq
 FP56SPOdEy7yIl02QXPiuuGmwomVXWmZIK80DkuFluJBvUxzZYKgqE0trtIjhfFUVbCy
 +U3jBYYTa273HLyhWeD4njdp+Z72AtVXkvLD84zYZLDFcMLakYq3QLCrt64GHLs+hKBn
 xz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158256; x=1778763056;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
 b=nLyovZXZFlxeNxZ9giykmLc3/kUeBQb0zdB4U8oiyWFNBiBv3+mfhH4LPcYh2+qeWq
 KlmYOiDbiIe9DSPJHWg74HBMdVMvC97TtDkQBUkJb7hlGkhmDFnk7jsrPD0Fb8+MQ3QU
 R5x64Tp1BSpy1+z7/PPHdUtp+CilRya4phTm4Ml2acahKlMofOjcgK0ZW1MVr5U/vibj
 g9mUDvHjiu154sLPSfyHy127/AtlxyZJUy6bOJVZTOL8HXky/BpYqOU5j363ZjMNVwGd
 Ygmz50aAXYZzY3k1LWOANTdHoxgyx64Ax6ypShtOhmnH4QUV8g8Sr+sX0gr1SefEvL//
 +Raw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d+jVIjsSejvhsjaqwSPUAuXkuIpSdfuboaDpPvgX+SpXOnFeSn7+rQULXZETEBgJq2alLL8l6pkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiaTZuVEXuE7AmKRHp1SAFfKCtBuUN7f2hEt0ixjsnIhjYXKfQ
 PoUqxltXSze9tvwkpjkhgZ47ZIxYxoHITvAeMEDnU1+NO80DeYk0Wrv88NwEFeB6cOsuPPYSzkE
 8Oc/vDO5B/MdnOQYDpg==
X-Received: from wrpu17.prod.google.com ([2002:adf:f891:0:b0:43d:70b2:d297])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr127556795e9.8.1778158255465; 
 Thu, 07 May 2026 05:50:55 -0700 (PDT)
Date: Thu, 7 May 2026 12:50:51 +0000
In-Reply-To: <20260506215113.851360-4-dakr@kernel.org>
Mime-Version: 1.0
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-4-dakr@kernel.org>
Message-ID: <afyKqwxDxu3cT7U9@google.com>
Subject: Re: [PATCH v2 03/25] rust: device: generalize drvdata methods over
 ForLt
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
 bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
 robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 igor.korotin@linux.dev, daniel.almeida@collabora.com, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
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

On Wed, May 06, 2026 at 11:50:39PM +0200, Danilo Krummrich wrote:
> -    /// The type of the driver's device private data.
> -    type DriverData;
> +    /// The [`ForLt`](trait@ForLt) encoding of the driver's device private data type.
> +    type DriverData: ForLt;

Associated types support ForLt natively.

    type DriverData<'bound>;

Alice
