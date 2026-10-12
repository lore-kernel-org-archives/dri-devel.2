Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC32CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B379210F3D9;
	Mon, 12 Oct 2026 22:41:08 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DB910F3ED
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:41:02 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33e6279a1d7so1175779eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844862; x=1792449662; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qxontQZzrTk9qBhbXlFgxD/XPImDShMGjHOsGhmy3JY=;
 b=qyXPbI1dmF/fibjjK/wdnxLyBARD+E0hHjzJ5UTpgQfMt55AC98A/LwYEyO88lbLVp
 T0cgTubuIdyECDe/LFVGT/EGwOmR0RxUu8DJse1LF/KO2Cbh8QWdoh3kYaV/jVqRx92z
 f3VSvzk67FUmRnVpVxRukrgkX7ye+pq04my1jEjhUT164h/KWtK6f1k0hV1oOjcAhHoE
 PUo3Q+ITlSgu+XvuNG2mIdeoVTTaMhAOgsGAutVVD40TZzRikVtONSxRVrfvXz1trBh7
 YK+cDlsMD5EMA3t/avs8drARvw4XRiGun0nQAZuPW55oEBi99NJNUBtkD8TLWpVCJKQv
 LVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844862; x=1792449662;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qxontQZzrTk9qBhbXlFgxD/XPImDShMGjHOsGhmy3JY=;
 b=CMqDu7uh/w5SS68oaiIvduarn5iX2a2Uc1bjtCuqD9Hf9eo7sq4yCLrwZ2SdSiqZnI
 pNMrT2spxfw47Xf7CLVfNjDyGL045d6RGSQFiwDOBxC9ZpXbb+VhHHeGcjA3KKzUtyrj
 0yt+OH+Qd3VoCL+CuYcwVqjtIc8tX180tJTgjZnPd2ueFMRRMUIYqsXQ4n9U+q4r7FfP
 B3wV2uXj7MeA+1BccjIMl4BXCNCtYTrZAV/ThEhVWB2deOCbuRJLz2yMAd5P2jLoUH3j
 lOrF1Ik4FY3ojAlv5724bt+deyCF5lj1p1+61h2askPWXIbeMXmqy+mlXK0bLsleL2ju
 mm6A==
X-Forwarded-Encrypted: i=1;
 AKwUvByvNwDu0cfvVgQ5giGiqMtuDFSf/3NrJqZ3FfO2gDk8MZXjLrRe2Vn6oMuhUKn80UNFCBG52ZclZOY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMKaT0lJShGiWXi2HWLjCavSg7p5FxaxJ2tX0UBS3mnAg+DWXu
 xU/kNoFLtqEweG6AwlnNS12mFPL048Gnv4P/CBqDvjsKiLV3ZD1Zy9k=
X-Gm-Gg: AYBFou3mqSy4FuJjrSCk57BlznP7M66WpXBfYbTOxViFhWYHbuPj+/TPmpNzFBlvfAJ
 /ujRO5Jo7/k30Q0eKmq4Nd1x2LGjAaHWo1gVsaVv/1DxrhOcO0aTHwQcGiMlHvckwqRi2htv32N
 CsQV6ME0+oAeMmAvU8Ug+sQA650Efrk0/P4GtiK5ybOJmM6y4kHQGRwlEnKA6n2xfgrGJmCPjMB
 tkbKCy8aHfbP8xQWJIWjauHRCrc8DWyq/UWQUcbLKFgCfwOr6Dxmi4iEsKxn185hDJhhp9rIqBH
 glIA1lAneMnLpr7Qdg3qOKlln5BzXb11xu3sFwX97kR+zhVRH/1XX4A4NHHG5yiRkFySD/dzSua
 Qb0Gm1sk3DjeFCqDye+ud4AEgGd71eTuDnODvactCqgBsv3bGnFAfLsQ0dobbdo0czaUfSfr+ND
 iqyFQ2rJBlaDizhh+vslaBg5T1qQKkIZiZBYjAj6UUv0BKqO/DhSmPPEsxFsxzr4WwfBfw/aT25
 Re+li7ib9gSOf7iKdNYyk/qbDYzqcWa7Q==
X-Received: by 2002:a05:7300:7aa2:b0:351:a9b1:73c with SMTP id
 5a478bee46e88-3537deccaffmr15649614eec.2.1791844861473; 
 Mon, 12 Oct 2026 15:41:01 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca7133asm44925838eec.14.2026.10.12.15.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 15:41:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 19:40:56 -0300
Message-Id: <DM37ZN988OJH.3URFWJTSYD4SN@gmail.com>
To: "spidermana" <xuyiwen14@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: ioctl: wrap `Device::from_raw` in an
 `unsafe` block
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
X-Mailer: aerc 0.20.0
References: <20261007211751.2428111-1-xuyiwen14@gmail.com>
In-Reply-To: <20261007211751.2428111-1-xuyiwen14@gmail.com>
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

Hello! some nits about the patch body

On Wed Oct 7, 2026 at 6:17 PM -03, spidermana wrote:
> `declare_drm_ioctls!` generates an `unsafe extern "C" fn` per ioctl. Insi=
de
> it, four unsafe operations are performed, while the call to `Device::from=
_raw()` relies on the enclosing
> `unsafe fn` body instead.
>
> Both forms are legal, but the kernel builds all Rust code with `-Dunsafe_=
op_in_unsafe_fn`, which asks for the explicit block.
> The lint does not fire here because the macro is defined in the `kernel` =
crate and expanded in the
> driver crates, and rustc suppresses lints for code coming from another cr=
ate's macro.
>
> The patch is to wrap the call in an unsafe block, keeping the existing SA=
FETY comment. No functional change.

The lines in the message are usually wrapped at column 75 [1]. One thing
I do is writing it in vim and if I see that the paragraph exceeds the
limit, I put the cursor over it and type in normal mode gqip. This
auto-wrapps it.

>
> Signed-off-by: spidermana <xuyiwen14@gmail.com>

Normally, a full legal name is used for signing patches [2].

If you are going to re-send the patch and nothing changes, you can use
[PATCH RESEND] tag.

Hope that helps!

Regards,
Nicol=C3=A1s

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-p=
atch-format
[2] https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin
