Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC911C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC81210F51C;
	Thu, 13 Aug 2026 20:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRvKzC+8";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C48710F51B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:20:38 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-ca53979f8e8so24661a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786652438; cv=none;
 d=google.com; s=arc-20260327;
 b=dPLUDRNfPt2wf6ghCtPhrdr8DVZ7fqhpBHs/SQIHQenoTSVOK7fYKJUNtx3ju0ao9d
 eP2pjJ6HkH8AfVXdf03W6usbxQANwbwz9E2upzDFVSNNEb0m1mr0plG3YWFCuzw1KjdS
 b9t4M+S23fZ9CJ1ZWNQlQf7QgxtYIxA5lrSsCPGjXBmLEp3TkgjD0DezOdh+nD8b5ny0
 i8QCS+/0QwLosPLQmQYK+4TfYu58/CrW7mZTbejIJ2CaAZRgCD690wjfGMvsAfhMES5z
 dQ33DubMTIKkRUbfYxIFCucforEo58VpZ0y4SK9yiNxfafY9CVASv3JedTkJYmcv667y
 gKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cehTam5I/PsI0xQ5rE+zJQchPnCweU4qjkmMXExiRUs=;
 fh=n9HQ8Imxo3rQZGVeAgvLa0y0dqgFd5usXDEhYMSwlyA=;
 b=dHABgRyybUpfMlzCSVvkOtyC7VufW6KyTJ7QS8fWPfEZVjcWqjll9zWgAsxCnvi17P
 SKLjd7iXYZ0IWsQaUVgV4LrYuhLyclxjEO7D6taSDT55NpZejXc49MHkauL7dhKmbK0H
 x+hz8JRiZHkuiZE2L2xuitwTshFxuwIIBJejtjWk2ot27HdQCDoQy6sdfk4p9QsdhW5f
 IRnXDzG2XXun7bpjMfKZmAYrN6q8T1QPVNa+B1Xq1EYdgG+qffm/GXYk6kiZDzyPhcw0
 5ta9WvC4RBQr7mhsma/66RMGHbvsubx7ADWLZ/Mw70MItQ7Ioj/WPZ7ol8G2FInlXYHM
 SJ7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786652438; x=1787257238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cehTam5I/PsI0xQ5rE+zJQchPnCweU4qjkmMXExiRUs=;
 b=SRvKzC+8CxnXIIw0v8tbfxsZQ54ffZMfPLMaC5szI6jg4mYzxrN7k6RyOi7gcJvr4z
 iSj48L2FOThSepxf8z3HRAhzfGaBdS+esufkvyGeu3VFf4qGRgDtw3ZFy5XOxohrkrYT
 HFAsAfJjiW6mkvnAPJJSJGsucy0q27GQz55BS1jcl14Z5AYBwbzm+/n5IfPBD6DLbmk9
 WBz0YjnWipUT6FcDWIEJAMlW0jGF3aqLWnFqXuzjXUhnIrrBcItJB+fiABtOgguQbBlK
 4ofHB1VLo93bnGqA3xqk1SARnJ/p957yKriXCmYVI3G+BN1tidB+MZ2g9as9gRgR4rRj
 ysKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786652438; x=1787257238;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cehTam5I/PsI0xQ5rE+zJQchPnCweU4qjkmMXExiRUs=;
 b=TJcytKurv2Y/IqUPcCKDY6sxZ1sJ1u1XQIJ68MhlFdBb0HB2oLXrtwImmT5zrzvuWw
 iqXpf8Y7Aom/tFKNu88sMbS7yAa4O4k+Vj5P5RT/tqQwFTGE6YlORzzLQLKRBHa4wk6I
 AxYw3FvRWTESa4X+V+k6RZ+x+8BQAUGbXx5xl4Gpmo/fZFh3nY0URNXKPpDN/VgIoWjf
 bo9u6fOCsA5o3kMM5QdRubR6F4WRSJSjw25tYdXuU0j2WOyhqkCMoNeh4nWDACueCrlf
 a9kDF+BqjYKKowWHjqrli8drCYrCNLNis01HgzywKvTWiHgWDXJ5RpEkixVxUlSo6w7E
 fZYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5pfGmQtcDMLOPG6UFRPWGjOpWpqLI1CdZ8erXHFTGWpaQgRc56duuGX5Wo3AOm+zVfbTq8c+mjZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxx8EfkEhG0x08h8UrCTPHnBNSnTEzQX7+olqYQgSeABm0qgul
 DTjEyZaoSiUEUKa2CeA4Ylj6FzUkTiQRtWzXlSnG0gNlrvJg4xBQ0j2FnjoCx6ScOVi+k9TUmQi
 L656a7fP5qnR5xZbfhD+2iTU9dIuF2GY=
X-Gm-Gg: AR+sD13BXkkY0p/ewr5P6caJ4jKD2D/igeG7sOZgPp1L1qu7IZDkWHqEsH5KLYY78Dm
 2eqgOgYTaJ9c4FTAZwDxZP/AqtAxEakpJeg88Gohi9FvE8P9sVpYgxDkQwztyjPf4LC0E99haQF
 IPbfCWlDBfI5pf53BzDOE1c7OxZnA5QbuOzjefhHQRDlXGYC1Jh7oz+XhSRfgk89fi0HJSmy+l0
 rNbd7zIXng2yD5RnNGOU4FKSTuW9IJXBrfy8l9PIXqE1feqVurB8WQTifDXDuTrW/3jAejnfuKg
 mQVsMqnGblm6hAqe84dnBzFkzIHnA5X8NTQH/teEO1UD7xEtAjf2OY9Vlej62REvHJyWbnlqMXv
 9LkLmChZ3V1x/Ce8NglZOBkXxHg1496BpDcR1PRhbcntgiRnY4kfA1YgpJhfX
X-Received: by 2002:a17:903:2451:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d3b0d7af99mr4135785ad.2.1786652437935; Thu, 13 Aug 2026
 13:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury>
In-Reply-To: <an4NvQBt3389jP6E@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 22:20:24 +0200
X-Gm-Features: AUfX_myQRhMg_1RjW0BdPohelYryX955pzu-Kspe5KhUk7UGyWS_4IH5HccmtXA
Message-ID: <CANiq72mDrC+43kbj-X0dpSKP6zFM61R3QFPa+2_xKEP-RHUppw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Thu, Aug 13, 2026 at 8:32=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> Not OK is complicating interfaces and life of your users.

No, we don't want to introduce interfaces with unconstrained integers,
especially so when we have already types that express what we want.

In other words, we don't want to introduce impossible states and error
paths that aren't needed -- we want to rule them out statically. That
is the point of all of what we are doing with Rust.

The unconstrained interface you are proposing is actually the
complicated one, because it means now you have to provide more
documentation about both the allowed input values and the new error
cases. Not only that, you have to provide more tests for all that. And
you have to duplicate information that types like `Alignment` already
explain if you click on them.

And on the callee side, similarly, if someone already has e.g. an
`Alignment`, then we don't want users to be forced to convert back to
an unconstrained integer just to call the function that requires an
alignment to begin with.

Now, if a function is truly something that we want to call with e.g.
integer literals all the time, then maybe it is worth a workaround --
but those cases are rare, and even then it is likely to just be a
wrapper to the normal interface.

Cheers,
Miguel
