Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C94BFEEF4E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA60A10E420;
	Tue,  7 Apr 2026 14:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gEucaIos";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F5A10E420
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:13:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B28D60131
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442C6C2BCAF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775571199;
 bh=5mucqtRqZUC32Ucba3hcpr0TYw4Hx9sPWSW0EAmo2Qk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gEucaIosHM9b3uXIg9wCIDGrIN+QFR/6iPwXQnWdFH9HWtMNSWt3HnRH18WyUTQpJ
 s4umHD45tbjfhln8lAimbMNko8WzgfUQDHagpK5O5HB0bTIScDMv2ww+UgBRgkwiqd
 IRpFehScAdjq8204q/+sCn+ZIHPw+22qUrQNrb3JyH8+zCNdKy3liqkjAvk8WeRpM8
 gb9416wPR3BQbGzj3b+S3F3dUN9WQF1hw9T8EguZWupT+YQu8uF/mwY1YlJ7eF6Oj+
 00geFQ0nmAc07pftQft657gbDmcjFQDJjODzgg5FqLvePA1Fq11yxK9ldCXqXvijeM
 coQR79hDwKq/Q==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a3cee3a271so3419026e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 07:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX1UdvQkkL94rDZ+pUh53ldLyFWWDKoYw8MYyCjjThmfXnLOSWrEZiOdVEjVByETEVtcCjcS3qCPWM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywf0A1byHoD10shpE92XrNrVGtJoWlWrsz9GIk2V54bRxr5ZUo7
 GkFL3OSnmwOg9qteoF8tyDxsAmYOl4zsvPycrqIShfvd6xdDUB3Db/GTaKfYuKIpTMGtjslqkxM
 951xhcpe/ebYLVayDPz261xOvFjEevFQ=
X-Received: by 2002:a05:6512:1385:b0:5a2:a8ab:ab5a with SMTP id
 2adb3069b0e04-5a337584899mr6421611e87.30.1775571197439; Tue, 07 Apr 2026
 07:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4>
 <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
 <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
 <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
In-Reply-To: <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 7 Apr 2026 10:12:41 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9kqhQ7De+faY20PxGS3pYAyuRM6A6NVtNdNvdn_t9vwGA@mail.gmail.com>
X-Gm-Features: AQROBzCOb76MPiztEakAab4vOA01AReuQXW6N_U0hZ8trRfXq-PYQWgznDgWpRA
Message-ID: <CAJ-ks9kqhQ7De+faY20PxGS3pYAyuRM6A6NVtNdNvdn_t9vwGA@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Tue, Apr 7, 2026 at 4:37=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 6, 2026 at 5:31=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
> >
> > You're welcome! Actually it seems the lint was already improved
> > upstream, starting with 1.90.0.
> >
> > Link: https://github.com/rust-lang/rust-clippy/commit/c0dc3b61 [0]
>
> Indeed, I had the PR linked in
> https://github.com/Rust-for-Linux/linux/issues/349, and it is nicer,
> but it would still fire in a case like this patch :(

Ah, that is possibly https://github.com/rust-lang/rust-clippy/issues/14827.
