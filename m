Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E5CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76910E356;
	Tue, 13 Oct 2026 13:18:30 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5622E10E356
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:18:24 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3535dd9a601so222890eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791897503; cv=none;
 d=google.com; s=arc-20260327;
 b=pj4Dsyk1S9wbhRq8MJEbVrE9jRbpl+fAv+YslZT07KwRCBcZCg72OVNGtTi56UbnbP
 /4ZsT4zBx/qSK8L3aCIaiwYAjiRx/zTWytWW0TcWNxFDT5GXvGu/tx2ek9MCju02CXrH
 HE3tI89/q9oJXSQYB3iT+3J9XUq0LxZRrJP8RTAsZOVqEAzsc+nlGtZG2MthTWanOoua
 cGrDy1GyvsU4lxfHtBHyRlSKWIIxAElnewc3jKVvbfDB125fiED6KvtZX74PdgsO8/uI
 xUGSJeDtcPbwMqbyvVgu+zzkGxaNfWN3MC200nGXxqurKalQ0ZIwJYX0/NS+zacwVGua
 mOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bL59kslE7Bvimc7NTbR0+OM7nidwyCwsipRxQthChUo=;
 fh=WQ+TvdOUnGxo+ZeYjIDtYmPmA70Wgy2kco8keYn4cCg=;
 b=qlW6yVplhAaghKxnGzSZxgjy9nP0o2FORwsBSVmMoRZit/2V/w1c97u6WS1PaTN3dd
 asF6L1dS6u7y/3LKWVFhq/YBBmqdJ9X2lvBrcC7mHofPucVKskQJLppAp8xglZAwMAii
 N0KwHhV0TYqIeXCElF9JOzoU012tk9GEbOGOoDzH/JBdEyr/zMrcvpfSlyNKe9I5lBVZ
 dq3XlEe2240GcZ8HlYBw4/yFJWSWtAkG0tu9YdWPiGIAGvevtnLlQWC7k6FVTgiQlB4c
 6DlnvaBQGfrqXHeXxi8Akl0L9F0dv1l9Fbh895mtrbuPP/Mw6yKVBGSVymafCoL8Wm5r
 HKaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791897503; x=1792502303; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bL59kslE7Bvimc7NTbR0+OM7nidwyCwsipRxQthChUo=;
 b=jPXIC306LwuRtdH4C/hnoiTzx6HV0wepHjCZKd+HpCoRdk6UzDIjc+qC3t/CEaTh9X
 u27DoFPJfuTisyl6T4RhQAQJRX6e+DRXtL1ieOHwGu7d4+wJxENV6sILcSyaX5tHDb3e
 qO2IBZB7LR8OSFHJql1SS1E8R8GVLTM48fxn2AwtlxwYzBUd3/d282FShSsG2cdew4hF
 2R4LWOhcMkfuQVIE1RGZRx/ngcAX+5s0eL1g+u4Sj4b799se3sy44XaC8sxgo7IfEsex
 7e0ipppGNMejNNeqyT18IUCaKaXEoHojrkIixOsgbYbNPvGKlrwKtCDcS9FyXMsm10kl
 TAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791897503; x=1792502303;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bL59kslE7Bvimc7NTbR0+OM7nidwyCwsipRxQthChUo=;
 b=PLd+dLZ4GWP37kALFKy/TIaqDA382oe7fABngkYsA2hysS4mikP+HnV4Hq1QbPDdBI
 s755l1Dq6eoPmCOBq25fOoEhzDZCLCt5Mx922dUisKsd2v+mPlKWND3QXs0ff98MEpu/
 ngSFx5GnJXymMXh2nPY2RWakcDuKtjaE/RdBcEAhuyMd2q1/ENx2rhf7XLqhuKuvMlap
 Gi4PzGdEA5NWRLRct8+2WmXCkoqif/gzGZ12RrHnvTIG0MxmgKW9gSR4jBRZB+cqv28v
 PmkIn4zAGf+e3BgyrfJ73kTyEl0DAwCxy+6ICYM30wINAhY3E2bxR+tT0CL5LHQpeup5
 JD+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwSoQC3i/J7EzomfpJZYAkfInVCF8aX5GCA8VSPb8Vd9T2OYCgFRT/mdbI4oQMsI0f/hst8AqX1Eo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLbL7PMPn4WncjVKmGeULBDUzw0QkZAD+aYdZYOKAzsnh3BIfO
 XCoK1uPCIYZV6GCSa/mBI/nVTxZx9cgA4LWNusTtNMlLpjZPfBWJIG9WVHgNhVhPWLYmMYyvnJc
 81sIJupfO2I/ijjzbKfaL1xS1QYab96o=
X-Gm-Gg: AYBFou2uBSozLfLxmhz3yok5DMAz1JwYieWIcLkQOvlg0uXs/i2UykLN+70592rPTXZ
 TbxMAuDPh6wLVio61nrrMCAVEQ/9vuM3nCM0lFK+fxT4axvF2xFKWJObQ6KMLYQJVRozX07QozF
 R1if140nnRztO6H+aybyXWZND5OS//WRoEkObadsJ980zanF5//vpE49KrII7SlmfUzMYvxERIF
 7In9POlWA6UVvql1kVfhkNhdsgBnv3DLSk6dIZsPpa8Wkjypi5UrW7K7rQ+bofiMaP9vz3jseKW
 Q+aNr5wkPuqHOZsiDp8b2pKynYkdovNZCs/2eEZ8Pxf/+FknLNG9ZJlbxmkU2ERQEj5B7qVrOov
 V9qWm736e/nWl/P5JIlJuwNJtxUIWviknFSpwDwSHyMgbCNYh5SlRynO5GsOljdQOf+IKmPE0Lp
 nrWx6ObR4Gm/p813++WsbjJB+TgfJKK3tC8lm99NbamkSx768ufYA1a/vDdgJLgw==
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-16b4f520f3amr27369676c88.0.1791897503344; Tue, 13 Oct 2026
 06:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
 <20261013-cv-v5-1-113a538dfaef@nvidia.com>
In-Reply-To: <20261013-cv-v5-1-113a538dfaef@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Oct 2026 15:18:10 +0200
X-Gm-Features: AclHuK_z220Bvz1iedMpcDzIc6RcPj5ZS2ls1iZZ_k6lRJyNsSKpCWB6rOoIE30
Message-ID: <CANiq72kccCL7DjBtLw7AF-nNcKo7OjjVwZ7Ba4fZAQXVZaMkMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: num: add cv! macro to create values from
 constant expressions
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Tue, Oct 13, 2026 at 7:58=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
>
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Applied to `rust-next` -- thanks everyone!

    [ Added a few intra-doc links. - Miguel ]

And thanks Eliot for the quick respin :)

Cheers,
Miguel
