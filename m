Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C7C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F6D10EB85;
	Tue, 11 Aug 2026 12:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b1nRfXML";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D3010EB85
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:32:02 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d30c22b1eeso1195305ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786451522; cv=none;
 d=google.com; s=arc-20260327;
 b=anoeWm2S8N0HdE1YZXsXN/ooxm5yvvPdIMa5VCeVohD2meGg4JCVLHalIf3qB97HdB
 qEA7X2iWFw0F2005b2GkweKaQUWQBxAbqFioLbaWloijR833Vdyabl0wL5uI2rCdQZji
 rENlbRYgel5ouuJnLsYgYa0Y1ba2NQxXc9ZjtwUblM/ODdPuaYZwL6iJu9bGL9UAgm+Z
 gQpZuVdusKYOPgXITfisGKyRrR5sPcVnAYE5UvA/sQqCw1+9bQy24wsmP59bAstzNdDU
 V9sasQ6WYtHJdUofPqMDF+NCSJ+03s3WCr48mpqdhn380Q/Ffjv36U3wIOn0TV75nZXQ
 Drzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=orvbh+9JL+FbxIqTNlcfLvYH6xrqqMswPRU7oLw3bow=;
 fh=8YT2yOy1nNM0i+Nuim3jjMCQgrQzO3ShrRPpyYnYlyg=;
 b=gmzltlVCMyMae0ncFO2NBDd+wV7xZMP0bi/XAx35OyjrUnLKGz8IC67RZ+GBXTbzio
 euu/Qo0aUpr45i/5isQKCAsyhNpE0pQl8kJQcLdRB+DWjd6AH1S0ULG4MEWl7uwcok3K
 gh0N50xIQgFDn2wMxlqi6RvSSh7C/UjDvZ5n9bx0EC3rPLJ/hSxs0DGnpbC1yt5ajmAs
 80+4EdwLiHplCb9BKG5Sqt45MWLhIse9ohUVJ4SblBkTI5jsK+wLWlDo1G40zl6ahqx1
 lefVJd1UGi+JELR4ByDH5BMi3vTRrwNjODfgdeL+FCE8HDNrsLQpvOYSfZ0UtzBOUFyX
 r2og==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786451522; x=1787056322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=orvbh+9JL+FbxIqTNlcfLvYH6xrqqMswPRU7oLw3bow=;
 b=b1nRfXML+e48FVXPC16Et3nAYp0Z6xIeNkHjpvUyqwMnXmi6ZHMFHwAIfZxvyM6y3U
 kuhtpMvE2UO6a/k3/wwj1P+jmUSUD5iFyEa9Hr4wygKD4cYEnWYqR+PtpbyxUkH22GbR
 whU5RgWjB5b7HYUR/pidCrrW2JLAppVLh3PfV/8ckJjVrHpXBs5/u2lKwTra1fBh7bar
 /u7B3SAIddjQzt0TaCHU/vSrDeBeexgkEmy0+tQRRTXtapgIf7WFFsqiofXKJsqvATI9
 b+90YY48LNArtzl/D88GAeHt8XooQdosyTHDT9iwal9Ahw5gGo4406/Du0XjTVMGDmOS
 q3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451522; x=1787056322;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=orvbh+9JL+FbxIqTNlcfLvYH6xrqqMswPRU7oLw3bow=;
 b=NAx0THJPPDfdheWOUHZBSgW8h6p+hGKhmanOCzKU9d9aeh/F0GlGLypuTcHIOO1NOM
 A41E/LCbEN9D9Ln9NYGbQUVwqVhJt2vdhG+Q7KTYNGC/dAjWeH2vX1KraOuUhWji2h9o
 9xytiPALIoloNpcPA4fkIsMaIuoRfXWQs5DG1+LE6eCA9kNd4JnHN4myXTMGXpLQ/BYh
 bJncYBNsomcOuXc0mqYVi0nYmJCLvZ4ThGKA7EGj3m37nASho0lE+xoP3duGkCJ2D759
 9cx+mwqpPDs5jNUNs2862uIx7mOSLlDsf+Ev+yi9tUZhYN/2XKz0U2OjQcKWkwS8jYf0
 7byw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmO0PkCS8xzDAFQfwwuV+RLn/PocRakBPPAvem7HHAnneDBvS0M4Y+bqJ9sAeBKE3owQBRYFDPf50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYfJQMv1k+rd7TmyPOG68U26z19qs3eEDLNwTf7nuPuv3GSplY
 89UIqHwvdYEZghITXTlHzMQgpctpcjWsBiyXCyFYmk97tqUbf9/mkMi5Y+cRFf781anLFbBepvk
 DeHWid1Xk1iA7fSBz3oz6WcFx8NMa9S8=
X-Gm-Gg: AR+sD12jSHiUF7Nm7W0FSZZnRX7n3VqLELShhigelDr17+NpnqBEEzvGpT0vcAgRCdJ
 S0dOzCTWkdEYkXRyY73qFnSsktDQnuw6wgoEh9ro80yQ6VOu5y4h/6WXvqTBzTGSa96v4Kelyh1
 q7jOT45afYWVh6n+Xz8sf7dC9xrFNCh4muamJGXZsm3oSag0znqRcSYzz/jFgbZhBxI5tZ6mT1e
 JP55wPI7A+jebZLrJTAmpFtkcyyuznQYt/SNTHn8u/tbH7x4TtO/E/J74I7ZD5n5ud+E7ik57A3
 J53aGzq5OorPAWPunaqiKOLfL1xpfKoXVQ4wwnONJpwY2XJw8I+VF1ehoE0DuVPC9D2RfmZXR3C
 7xAJrK6YPb5oqqCPV0lot405pmvALgUCMWtxJbeFF1ygz/JnsQHL+WnAYjJvV
X-Received: by 2002:a17:903:950:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2d317790400mr26287245ad.1.1786451521959; Tue, 11 Aug 2026
 05:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Aug 2026 14:31:48 +0200
X-Gm-Features: AUfX_mw-sYa6mBs4ValMgNlBU-v6shu4N24mrRNJSqO0XtM0upSdH02iosArTGY
Message-ID: <CANiq72n9TaUgWgZYg3Xzm2mn3Ed36B7O+f544a5BXik_XUh8FA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] gpu: nova-core: add PRAMIN window support
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
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

On Mon, Aug 10, 2026 at 3:57=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
>       rust: num: use const_assert! in Bounded
>       rust: num: reject Bounded::shr overshifts at build time
>       rust: num: add Bounded::shr_exact

Applied to `rust-next` -- thanks everyone!

Alex: I didn't add an implicit Acked-by to the first one but I assume
you are OK with it:

    Suggested-by: Gary Guo <gary@garyguo.net>
    Link: https://lore.kernel.org/rust-for-linux/DKIY9YGIPUUE.SZD2DUQM9NGK@=
garyguo.net/

The second one is actually fairly important so I did:

    [ This implies we can break the type invariant, which in turn means
      we can trigger UB via `Deref`, e.g.:

          rust_kernel: panicked at rust/kernel/num/bounded.rs:528:22:
          unsafe precondition(s) violated: hint::unreachable_unchecked
must never be reached

        - Miguel ]

    Cc: stable@vger.kernel.org
    Fixes: c59a2d14cd24 ("rust: num: add `shr` and `shl` methods to `Bounde=
d`")

Cheers,
Miguel
