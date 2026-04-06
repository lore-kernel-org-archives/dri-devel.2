Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6BBF46C44
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3630810E25D;
	Mon,  6 Apr 2026 14:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMeehR+q";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A65D10E25D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 14:38:05 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bd801b4078so411744eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 07:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775486284; cv=none;
 d=google.com; s=arc-20240605;
 b=lW5Mpc+aaPCHzDBvq40WNhwrJG8vgDnon3qde97Nu6HUQpRAz3Whpo8dcJZf+ACq5k
 ifnkzzp98VGXYe2PoSFKoZhaoUnx7oRKSlNwIjP2y9pUT/VoX6VjnGsG+jO3KIRZQ90U
 hk9xkdDOoUoaF9jigbUejX0yr588lx8dnnlVmR72CKp73fyhrBpO6b+uBV6uSsyTksWQ
 yHT3n80rXKl/3jSvyeIdq+WxPxvukHLdxv6Mm9HWh1EyLDaLc1OxohTa76SFtO5gENpx
 CFOoDvkyOq/egHZvQ+Wjlq/VREG66Ba/DlAyktru9LTcdRzD69kpjeff9nd+2Ne2jE1m
 Uo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
 fh=TYCVJoPQ1MtIu8Y67AeiNJLETfuLiRJmBjTBISkPcgY=;
 b=Shjyo97sOwvPqIG8fNw3uWls1zSUCnsTV0iyoa3D38Qct7kbXdg9YuqKoQ8Y2rEptr
 bbLamwe/nQW27qln2otfydni+d1A+qTQdo6kXtZP3PlX0Gd5sRUzryIdg15TwHq2sFNz
 smH0pn++02vHEJmgNIY8nrIS2CfFdDCis5sl+KYaNQ4oFksC4nzf6CxlIQT2wgkYbZM0
 /G3qoSP0/pMl168b/3lo5HSj0LiUdpimBGskfpHMA5iJdXoJcaWUWkvYoKy5KGI+1Wb1
 MToDSqJgErJfYUZkyYu/uoSlTxejJEZtc4gSKDNE4KZkwVyTI0/AtZL5Y5AEQivI8Hmy
 19tA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775486284; x=1776091084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
 b=fMeehR+qalZQpVp3KTvGTubjSnHIdQW6PXCFXtCfyCIggZOWLKZWbZMUDlBRj3YRDv
 R7lg4xrai7ZsFgETc5y7MXkwCCunn8CXRKZatAlnQPFuCyUAjEYrB9IVLzhFZfz9xNNh
 MB9pP4F9JRM571uC9IAa8dloxKxC5qpXfmkv79rAbw6aJ84Q7NCq/fhbnnfW5V0LbqGg
 AiYtBdW5hvRrrhM20GxKkKceLH8khpSj62xwsmImuIFROuCwS9ujVPDBa53xXmmoXxPR
 mGFokFsXwr1p3sBnZkH5tM4/x+5c+kMllhtLZGA8DYEW6wBidOn4LAsoDbZw4WqkZGvr
 8bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775486284; x=1776091084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
 b=pnwb/vNxb0B63vYu2WlfnX08te5ZNuKlqURiHNuN23EXMS0sNdtIyn7QZ6M0/58tBB
 TwEm2NQphsgcrSLECC7CfL9U7ATBQxsrt/0YtTucf5IPXllGPxh4DYWNove+r/JYTDuh
 i1vGVM9zW9Zlw91nBLlX7F5aHk1k51MUQB0s4oNajJiWFK3+l5Gg/+rHsyy7hBPviWyF
 1gzboST4Saz1+5BHDQlc08F/GQIi4+z+Q2n7ufPNvDLHLXzIdEbfuJ/rV9uYzGJCPMNE
 97r5dMJLazhzxO15DrFZ+QccFfYrpl5SDpdHkknHj5TaPH1gIPajww0BLudOiCDyxISa
 nE1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRj9na11kbCGxNIKy6OEEcZJXfUYP6U5eGnwNJNCv17oHUtD4ka6QXwUEDNJNhPpeSTjoc18G/Et4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuDemFHXJtNU+/nSGPnp4zvfJx/CSIKyjZ3d/HIYAX8VVX6ObD
 OPrb7K9M3Txfj2B5CpOp+kS9I48Q9X6DCKw8g7Hp8FSN6R95jIqMFHTNnob7nCEy3tfkgBNqLRC
 rYYiQTz5ASp6kZF6HDsK6Ultv2jDYviE=
X-Gm-Gg: AeBDievRm66siZRQIM4zkB2uSl3ja0Sz6m66ndclZE1Y86msNnefIktcgFwnpKPMgBL
 S13jzYOiWzxK5iXvBF4MVm5lq8WqPdPcfbIoUUapvhXKo+wlZ6bs3d9JphAwJ3zMT8OziWZo2Vs
 jWLfxLYtwKe7ouFzLbKry/sLxZ89kT8RuBawd1PHdt+8Pa150P81NDrJ8KOHtdGHuANrjwaJ7cm
 dHCunSu7ux4ZZN+y7i8hWIk9ENUC5cgklj0XLQjLss9T/XmQM0r8kuApCW1cVaS5LvRtpu3AqYx
 kw6pJZPzmhoK7mZVkc+unlr2bGCafSLfNfQHsn5tMb1Us8FYV9T/C3rCzvUn4VlvEfo5hMxHALz
 Q9DzKI6yS6Dkid3TMbfeEOsYpa8KUProcZQ==
X-Received: by 2002:a05:693c:2c06:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2cbfbc7d828mr3020598eec.3.1775486284289; Mon, 06 Apr 2026
 07:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4>
In-Reply-To: <177548573697.95472.13544191227699996309.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 16:37:52 +0200
X-Gm-Features: AQROBzAshONAZRL6Bf4qdEX94VdiVWUdtgExWPcnxvz_Z_wjuLZH7VazFmpsU7M
Message-ID: <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
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

On Mon, Apr 6, 2026 at 4:29=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Could you add a reference to the upstream bug report [0] here?

Of course, thanks for the tags!

Cheers,
Miguel
