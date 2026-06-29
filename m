Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA0CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AD310E087;
	Mon, 29 Jun 2026 09:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e7QzJkXt";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107F710E087
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:21:37 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30ecd6e0eb6so45760eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724896; cv=none;
 d=google.com; s=arc-20260327;
 b=gxvuF5oeiCaMXSSuW9uaNv82RkpxTx62FPH5I/sUriu/SpuvZ8j7n3uJaq/U+WEeBB
 3QRRgs52jrv8KM92I1CR2h81I/PlO0uky4W4pRVc5cenfZPDnqTAP6+JIaK8IFcEo5sf
 Mn4W2dIqs705ze3oZLbpD9Gp9bOqPpYv7tL76Xv97XskU726oGrGDMAy1OUk0RhfJSK1
 uRh65gspGu5SsqIAMtL4xZlcBR5N46GWFnlkTzqn4GFq1IaJm19dDhevDwdWQJHu3t06
 jxhv/gRmxS5Q8CzvJhtE+czHGHgYHUGitujRPw0D4/xOoABdSO6MVAWjvReUWg0Zoe1Y
 YWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HR7GbZeu60bGAwyiYgMlNDYxabOGkfsb2xboCxpTnhQ=;
 fh=EemLm2uwD1yIMMEyybTwlI1ffQscGAXEhlwk3kC5TQ0=;
 b=CK9xF9ARn1SiasE9444dVna1rBUFQKV0DBfM4sTfxd9DdmUFf7Tf0kNZkd0T+9XMzX
 qfjVhErWd1VyGr31pQMlZXWTlVdNZDIS3zznvLEXhqXyBgUchw0VlN8mkFlsmQ2yKKCf
 BlhMwTuNVYPP2kEvU8lJ34xAky9x2WUdTGuxl+zaJ+1NgF2IKb6jzbG1jBS0mYCRkjgM
 0mLw8hmuUMbiM77qStDrnyJir1hYJanr8c75UCncNDcoi9mJnDgVUJdrwVP5yIafywN5
 dbLWTHRur66yeqrT+3PN5EeqaWyW4XXwHvtttK28me+iC2svF25FgGFTW6m92kJ1bMcj
 oX5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782724896; x=1783329696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HR7GbZeu60bGAwyiYgMlNDYxabOGkfsb2xboCxpTnhQ=;
 b=e7QzJkXtSXkaUa5TkKmqnmAC0iup/siCYypJBUDf2QbZYW3pgM3qHrNe67cAk1bH/8
 qvw5gUlgPS7qJ1UcIwreJoG+Vg1otBm0Efc7xzLjsbyXd9NcUd86ho0aYPYF5h8YpUNr
 u2COhZMMObtGKRHWdNRgKqQXHIf9vp14wyDT7yZtDTlrrNap1IkDqN1apxVIorxEq14/
 E6rruH26WubgKsl8QLv4J9KWyAkL6y4pop1T7Nn4ZJy0WqlkOcELrhD+jmhtYwGnvdnt
 V6JtmGGqvNEeLZsHwXUlXIQYiV2fvlBjgH4VpHeUGNdxGyNoCcFf723HU34m7oswngg6
 UnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724896; x=1783329696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HR7GbZeu60bGAwyiYgMlNDYxabOGkfsb2xboCxpTnhQ=;
 b=RgRjuYNUghEuU5HNZj+8JzYpewPihUSsb2og9WR1ELECRQwYpd4oy8nMaBuaxDSfAE
 Y+eSmbb1VlUJdk0W0BPLBIRBXj1CZIbcO5xihqCTUltjfUjWoKutwDrF+cBu3I9ivPGt
 hLNEt4o5E3YYKmNBBR3dWZKsEper9oUYSSrdntQCmO+i89+RWxKZ+5XfXTKal++o4IrL
 6CCb9XrX4erHDbp09j2yDph2dDkaeQBU4NrPt0ika4srGYOwgm50+yT7si5VgMz43KaK
 OES8qQ+KEg+WRJrmX+lFSDzYqTJ5rXWaXeVqIfgijKP5dntw4RUx4cYJwpJfCjSDOxDm
 XznA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaAdtdIIuTVaNf7MDgGBC+KzfnDXWORduQ0OrAC+mrB4j4Dxtf8YxJLYo5kZbMw4m1IQvyqgBpNDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJi0FOJ4Erg00VFBzvoFHTYv4NpyrHD07zY4fa8jIv22UqR3YX
 awwWc22LWatxAqcVKlQYcN9hBuG60T7pptNzMV2AioXuWKeGlpucnMTZ96QSHZsORf1dLtgIUxd
 bNlTq3IDtEMcXMSF8qyEJBcmD/9qaWDU=
X-Gm-Gg: AfdE7cm2oKi77yscxlMzxT3b9fFQuzTRqiJt6C9ki/8IfhVSyKS0fPTbcNDVihTWsqd
 +6Eq8QK6PFlKSr8KLsWNQ8KiiRQbModN/KJEShznzt1jSNYPMSK+GTuqkRFIsbmVlr2dvFdaNm0
 Ng7LJ4tS+THiIUC1ZJ1c48cUFtjVY0/e0S/93F4elKaqpBSSORtxs/5GiiEPOn7x5x4tqWyGKN0
 irta6iXxO+715dLk14W4FeQ/rHyeHBaaeKcClShOLaIoRtX/y+9GSVYzUXEstzm+IdLCTRkJGtZ
 Lbhqs9stCSTDeRBpXebsryeFVR0KjAJkIRDoWA/Zu+FDFn/S89vLoC6ZORGXkqBDfHulMUNvskD
 Kv1Hpzwp+2arv
X-Received: by 2002:a05:7300:7b8a:b0:304:f860:3ae3 with SMTP id
 5a478bee46e88-30c84b16f43mr6714746eec.1.1782724896211; Mon, 29 Jun 2026
 02:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <20260629025220.1935622-2-apopple@nvidia.com>
 <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
In-Reply-To: <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jun 2026 11:21:22 +0200
X-Gm-Features: AVVi8Cfm8aVYhfDJb3rjrr0wUTbEnV13F-DC2dvO8JHXzZNJoM_MaRoFaeMDg88
Message-ID: <CANiq72=CBpZ8qPRfNPq7sNQ-notJe5wHkP-ya+kxGv2MDZRvqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nova-core: Update firmware bindings to use zerocopy
 traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, 
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Pedro Yudi Honda <niyudi.honda@usp.br>,
 SeungJong Ha <engineer.jjhama@gmail.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.de
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

On Mon, Jun 29, 2026 at 9:37=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> This is the part my other email [1] was about: are we going, long-term,
> to replace this with a `#[derive(zerocopy_derive::most_traits)]`? If the

> This also might be something that will land soon through the Rust tree;
> Miguel, do you know what the plan is by any chance?

If you mean:

  https://lore.kernel.org/rust-for-linux/20260625231919.692444-1-ojeda@kern=
el.org/

Then yeah :)

Cheers,
Miguel
