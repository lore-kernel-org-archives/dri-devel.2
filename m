Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0722DEF4ED4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEDF10E26A;
	Mon,  6 Apr 2026 13:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaEiBeOI";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F22B10E26A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 13:21:29 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-124a7216c9cso161696c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 06:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775481689; cv=none;
 d=google.com; s=arc-20240605;
 b=YnkXGkdDjx/gnkCQBsly02lPkU2gQ/iMnBxgkRQTjtaV9gsWPMaUF7qfE3Iq4seryt
 T2uMzVFTO/467/uDp1q8tn56/P3tylKXZU+movnpaGedhhgHgbhUS963T8hncW/ShpFr
 xOUa8u5nVvly/He87VZMLjqdQM/ifCcmAZeLlH2iu5xrNqGvPvJT2VHkXYhpIWHUO15L
 ggsvLbRbAqDrrr3/W8ITMYrhyVn3fE4K7T0i5UbjpA3ye9EXtcN57Z0nyl28cjT9mo8p
 FKx9yRY8VZZkBW35U5dEx28pEd0hsjWxOHsEdey9PuKwJeDHMa+fmgkN+vqcAqLTTVFP
 Ip3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
 fh=YcXSmk4PK8dk1qb5kbuA1cRxoxA0ZOJAMmNhwii+FmE=;
 b=LEsWIOXogZAr/36sNDQFMtq9QlkQOkjMBqxNIJpp2dxOTiS/OGzgF2HWRDU/oAUlg4
 31YgHQIi6EKeEXAn/WQJDH4i3UasMYgd3FFQKJKNJ5tC7q2ASVB03UoIdyzq49zwqDUB
 95Vbpvh8MQdwQ8l/jpN5xcin/Ayi/3wDbyQQuPJcieYB50hTYC9aOfsGtEl12p6Tc4T8
 0tbJA1/oClYUAcL8h5EyDvBVuhvxJuGFsVtdfJbshCvktmFu76tXFuK6Dt2+hZWP1Kc3
 +ztBIFJ5Xr9Y/IUvVNVd5xx01ITl0l/RugDD1uxWXHR2D1YHkZxJdFcoxehkr7WTJ9o0
 hbIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775481689; x=1776086489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
 b=WaEiBeOI/w1vF1Mz89j1RbdhmCLAVB2toshdPp/Wz/PeDoqFje4y1Dn8ksjDPMvyOE
 gnjhRQz6XJ5Rkm3VlqvvZJld8879FgvOjb7s34HV1lFqrZK7zACoe25I4veEagVURU5a
 xchxnLlPJ8Hlk87v9HpGq2MenV5Fo/K1eQPIC9UOOvg60TB4xVkcdNF6CAADU1j3f9Pp
 vAMAs4nxGUVvkOCvmWJJsqsQE3R/h2HwAkubdhGTSqo8VxOzNxcBNQ5552z7MvEkiWxb
 I623uvkiW1psKDDBrkYeA60Enk6Z4BQgxToU/Sy05E47qJ9K/BJTBEJ7+T6owJUbSKVy
 3vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775481689; x=1776086489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xy7FALhcYqLgXu4fKO0MtrrfIdEU0qZJHPfoz//MdsY=;
 b=pB+yLEiLfx9E9c8I63u3aawlGSe5XIIv1o0HQIJJYjmQNcKBFqrWC2UtoG1okz+DeJ
 vvIcMgigJ9z9YXI+Rouo+nVENCbOTWYTRSXUVHZEGReJ6YMwun/OI5raX5l6KO43NK3s
 nsb1R0jcs73aqM0T5G1JL2F6FHOpAt5bnPfrixYmORuYYeevFvhzCl9+tSTiYrG8bzFD
 nCKjZauUik6ZX44ldQcgqNLq8nQjHkpvqCUdDLir3mE0aBf6cPatNFrcp8xSCreOi0Xf
 iLIdJmtkH6DUfkXoT6Jk1pirvdiJaW6Snew4z1T1iF7FplQ65sAJIuFbHOcTvfbWLEkG
 W+rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv7kDtEjAPHRBoM7+X8hIsvvDEoWjruAqdlv9XkRRQNLgR03BOcOWR03rEOnKl8QLTkBUeOamFXvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC0hz1prOxT8q/Gio4V3/qpZOR6GvFZo62vItRnrvs+VXSc2cc
 LHM1Of/rKn9uHPD8+eT+q5n7Bgs2q+df41cu53ldx5658hf0scsprItoWxuB04y1/+J4BF1CGi8
 NrrgXfkRU71U+73+vi5D5WgnyQbNhZLU=
X-Gm-Gg: AeBDieuIExQh4zs85C8WlWoEyveBj4oB/7vYyZFyDBDsMjjvS99vrFfMXi7nJSfzBwl
 ul9epuzmJAvLCKbpLAXIaMeYeLMhDqa+pNnO8qwAmucrD5+POymOMAoV+6ZicI6U/x6hkCdosgQ
 2uWv4TNX6bFrMccER1FvFfyMRNwd46h6hQX1u8SHRzlF64KMF7fxGOrzJ0e+htJQMEDvuNCl0LB
 IjFZ0syM4p0cgThSxpCBhxTbVrq/iOvdZBldIHvWAt301t9scuxuZMkgNtEzA1PnQtnTU/QEuI2
 LurQ8J5hqoxOtSycu7/ZKTIVbuBpcQZzwn8eY7HPAzY7jTGnAy39QEPPq/WeXAXIW27zqvuZAFB
 Za/dDqr3/uIsI5zv5ytMqYCc=
X-Received: by 2002:a05:7301:1007:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2cbfcf52a13mr2965052eec.3.1775481688630; Mon, 06 Apr 2026
 06:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-34-ojeda@kernel.org>
 <177508434476.73816.11744805605122440072.b4-review@b4>
In-Reply-To: <177508434476.73816.11744805605122440072.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 15:21:15 +0200
X-Gm-Features: AQROBzA0LUfPYuEZWH9uKj1KexaW3DTNKfQ_If4tWD7xnq1YUXDcYUMRbV47V4E
Message-ID: <CANiq72=25GRao7NciojymdbZN_=f-U3hp2+2qBMjb4VCaOgR2w@mail.gmail.com>
Subject: Re: [PATCH 33/33] rust: kbuild: allow `clippy::precedence` for Rust <
 1.86.0
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

On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Might be good to retain some of this in a code comment.

Bah, I missed this note among the rest, sorry (I didn't reply to the
ones where the commit went away due to the changes in v2) -- I agree
it wouldn't hurt to remember why it is there, even if it is already in
the Git log.

I will probably add it for tomorrow, especially if I have to rebase.

Thanks!

Cheers,
Miguel
