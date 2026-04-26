Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B92CFF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0ED110E1C7;
	Sun, 26 Apr 2026 13:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d8FrH67h";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997710E1C7
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 13:30:58 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2daaab98000so557387eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 06:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777210257; cv=none;
 d=google.com; s=arc-20240605;
 b=E3kFR66UFWKxFMEaDiCMIq+oizIYKgGWLS4FkmKhNDmA9a+bZLnJfmmoWej4n4GKAS
 oV8/lr68tNIx1JZ0kHyDQj9bANUexqDon8QwsfYvpMsgT0hORkawgyYoqhcIYhUsWU0C
 ZU4oMuCSduMRXJGoqTGYIyPjSaEbprr1EkGWge1+56xSwbTQ1q8NCGbXlAnQf1WqHVZq
 w89DJKcDwhJJOCvm6vJaKCGXX7kazBX/+bZIHAzsUrI615W1ouvvn2mID+J0rvq+E+5S
 y6PhAD47HzfSSpYSosuhWq44rVSXt6+JmWrlREMu40M4xPr7MlpqC2GRVROC8Pmr5LYh
 3/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cJXGj63MEyCfqqwOxEXy8J3gwEUh1+Qon8MkHQWN0OQ=;
 fh=q+0633YUUpjdmj9eJK4XrgDiwAg3gpeBusEXT58ysqs=;
 b=EX2OZZHjbXBJhUXyEWnXsYoGrva2UR69BGlY9TneSSmsSD0WB545DCYwwFGP5a3OdY
 GIC334CTHe1Tfj7p/lv7mfjDinoKqxZJbZNhy5kiDG2vF1YRx5JtDlykcaywv9yWaf3e
 mdhUoaM4QPjetFaooaI7YzwMs2Bye49rRCgnDVI5YRLeoBlnI4lY/rENo9Jj3PfetuyX
 juNublnB0HBFvCQ1qygYZyR69+hdwC0dFRBG5zsowvEtS6OZ6LG7ET8xyRFlatPSuFtz
 XM+vU9WmfMe45A7uDgn+hym/UK81muAfAY9/OPYC6MndR4xIJryil9jvlNgrywDLUxwj
 7yPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777210257; x=1777815057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJXGj63MEyCfqqwOxEXy8J3gwEUh1+Qon8MkHQWN0OQ=;
 b=d8FrH67htBskNzyB+4Vg0Xt917UhkgpHt2B0z6Wy6XzrBIwutY+c6j9o3YBdZSUIs1
 QMSb94GVtg4K8x//MgKNILSG+C/CrJ7gL6e60P62zogepZW09WwekFQyqTHivVUawwvh
 ZHOTiv+Q1Dlbucs7hwAoqC4qXYdE0l+M5YIRjgatkyUFngafJ7LLY6xHLZZn/z3kaqG/
 2kxwIkinFmTAcUJ/boAhm2EvtBi1jHjQ5m4fhkVvQY2g3CDM9bKGqerDMoKZyRGWDt13
 uuc+v1naJ6FRDD2PG1rWW4jkLQLNXCpnHrxGwbnKuDJXq+7OE9my0okATUvfa9cHQ6hH
 Bk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210257; x=1777815057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJXGj63MEyCfqqwOxEXy8J3gwEUh1+Qon8MkHQWN0OQ=;
 b=pHxc4LNe2A/0LlMn/UL8StKDbQj0Err3MZhrGwcSGnOy5+QXMS0WT7Whp9qZhL+V4Q
 36yGTt4D23MTlHFVxyQQXZRZ1nmrsKZ6gzyFKVvEM43o+swVCGCvfHU4Bmahw7ZTI9F1
 AiHgUIdW7psa7xnsdBUMumuWLE7ikvN1uAbuv/ngNHWRKQXeZHKa7HrebJtwWbPzEqLi
 QFMQaeBNNtGld9xaJ8r51pH9DDN7qrnjFdaHgoW4HXK6QjO/0lB9RIooIgGA7SSQs3Ao
 670qVYCkWUzsZvzX6gDfbDbCLGFW+jf0ZscNif49tz0HXyfFjORPZ25Yak5ndlK/IAD3
 AroQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TSn/F36HuRz69ZrgQG/dmUXkG+AgPJgeSG6xOvdXlBczbWlgFFyiRb1V7RI7JiAySkKtaYANY2co=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxhp3llgIdzHKiY/h0r2aPQSVWyrxOIaW6naA4UdZYaS6VnprX
 IDP1ZFXyVsaZIegjJ3TWUFQBw0ZzhR6afwOXyz8xC0c2bvK3U4HZciJXihoYIwNCTePIGXRiO52
 7YWNBNq+aXk87P6Fsbs6UgayV4PKl5M0=
X-Gm-Gg: AeBDies9HRme5DBb9DGI7D2wOwbgCfOMyFA/2H1bI1igOZ1TEFi+WBXkTRLNfRcWPcU
 RRNhewNbHo1NjgRUqNCt37NRz+ADsnUvdZpvyBXJnCFInUQ+v40t/rqkmJYAOuEqX3+vJCt1eBk
 ft2jWtJzJJ95QVwHsrvYKhm/4QIB1SeU2Y0P4muHasGrux+im64BSsm3x90Nv027Wgj6LyIb4kh
 zgfkCVyHEiW4sMZBA7tmc1tUJYruhJCkUtzz2seqBHql937H/p8Pay8lUW5PCpMVnMIlGEC899X
 dI2bgmg6nuFRCjoOJ44P8LJbqqxj9cdBY9k6G8qoQiUDxidgxym1wdgub4ZQBrHrXwklWEEL8F0
 D9SZswtXZfqAhrvzeLzr4MS8zEVMgjUOxMg==
X-Received: by 2002:a05:7301:1984:b0:2d9:94b4:a1bc with SMTP id
 5a478bee46e88-2e479517ab5mr8193241eec.8.1777210257423; Sun, 26 Apr 2026
 06:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Apr 2026 15:30:44 +0200
X-Gm-Features: AVHnY4LsUneK3YH3oukvOXnA8etUJn6NPCzTeboNDm_V89hbH9h5xFq9uiWnoW4
Message-ID: <CANiq72=7u5O_58b6cnCwGz=j0D1tmf5+9Ntv1mkJZpACWXQpFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] rust: add warn_on_err macro
To: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
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

On Wed, Apr 22, 2026 at 3:41=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> While we already have the `warn_on` macro, a common usage pattern in
> Rust is to check whether a `Result` is an error. Add a helper macro that
> allows this.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I saw the discussion with Gary in v2 -- not sure if you are still
putting this in. If so, and assuming Gary is OK with it, I guess it is
fine as-is for now, but we should probably create at least a (good
first?) issue:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Not sure about Sashiko's report -- it may be nice to make the macro
more transparent, even if it would be rare to use it with expressions
where it would matter.

Thanks!

Cheers,
Miguel
