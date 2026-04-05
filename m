Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B2EE9D800
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3003E10E066;
	Sun,  5 Apr 2026 19:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p3ybTDzH";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866A310E127
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:31:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c6f5574d07so156312eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417495; cv=none;
 d=google.com; s=arc-20240605;
 b=Z+PZ0SERXtUFsum1Z5SyvjfNgk7FjzunNoBSA9c+H09s8YX6vFWLO3EQsqedYwrdeW
 qXFwUexjKotOQgppu5oKiVfnMNEo6PIcauosh/v8Js1kA5PTQlKjEGUcpa6EeuW9FzPO
 iUkZMvIW2eKk073v5QNdqCm+fns5jCDtONp0Lz2pFRQ2CFGpH0zmTfUTH4DHG3/zFemy
 x4kAwQf447mmW4KOVjm++W42FyxGiYo1Z9VKm9pd4U/JJ0aYx+KuCcgyyplImgQMWjzz
 8Ccx0IDhnsuH0ngfLd5Ro7UuSEVirTmRUwm9ECXW5JPmhs9JErKsyVudh2891j28NNiJ
 kMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
 fh=/ahcdpOAWfi1cZU8KL3zQoqjTqTRLqqI+Vg7XmMvhTM=;
 b=QU8CWfRk7roIhkSY8uGctDTXlf3yXVQFUSOOY3N/tfsw2fMb6WyIk/Tjbpal/ucVal
 ykXA7Co9Ny49gCrZ7GAN6A26roKNzz21whIA7pazMb6d7CDn6J+xE+Kuq+hz3+dVtOfr
 /vIgwgNz+7j2rbrINEEJWdswAtr7KIgiHw0iXwadf+GiX1X1He8BYoRqKejH+tMy1BUd
 yMaVDQ+x9hTUU/seH7zxRGsTcUNZJ6JLxEskyEs8kFnvuiw6raSmnc64D3U1yC9c8smC
 Z4CLD9pzObcvkZobyVEYv9sks9MHlANPQC6RaCYQ7au3/FftijXEP1TyvvV260PMaqtq
 Lk6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775417495; x=1776022295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
 b=p3ybTDzHcjdCjuu2/mCK3TcazmuZry1qNbW5qnZcDXPlrhREEU5htjJIRc2rpNv6Gq
 NU8A93r5e8qDEKp5n3m24EhwQFiD4E2sYpFjfpAZm6eRfxnj98VbltO0mPQY7T3EjQxr
 FdXfBcSBVJNmECpX8kr1fuZw8W7iMq+uONnGcxOu1W1jFvSz5Bo+W52obbrKSOwOkMv0
 JZPqPLkg0Cds05ScD4ShsHqAfGcodh276Uscy3WfbEW6sg/exE9OFmeSTSlKVi4b1oEg
 o7/EM0nj6wcFBy4FebAT9aK++07/0vy2oSYgGWvpXmbClDJ987SRDv8ccNVI/93iqs7S
 FKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775417495; x=1776022295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
 b=Pxsz+QRGFvER0/iALMt4614Ccu+rGVhMfd5TxFvW9E2q4ta/ycZKt4iDbZk1nAeMm0
 OzkSx7CiUGBFQuTLTGjP7Gd3Bn3WE4RrDl2jT+OSnvVY0Tyw5k55tMB6EkElTPH8IaFQ
 RK0spo6pbbsg2WC+Ms+BZCDLkq7++J2Mk8weODlHUDVtOT/kkEp4mPnND9NGm59mgxT6
 hLMjxEr4jwt/FzDCwOEdL45AFmEmBxuRc6S7KYbmtkVkvV06dsB/WJi982KWpxQSQOyw
 7nq+J6xZsHkD3p46MW31Z4/1YKtr32BPcJb/AVwXCDVTDvBl/qZ+laRFli5hchvgkwzQ
 Ubfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyxJZ35V32MKGyw01zQkiGbHkVBm/ylNO93rSmok6X0HF4+OEnOSQPfzb9BG8uJ7gAj0lGD+F446A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5fb20I9BY7Yyf/1OZfXPKxCBRzpy6oGIfQTAmU5z98Q/Hgmut
 bnSqUw1C8v3OX7l4+8Nv2prCK2wbFonsq+DhwKe3iy7RuqseV1dqOvY1B00Q7OUYE4UxkZCfkao
 OtrmZN11c2+R7d41BGhoI3li07+5rxNs=
X-Gm-Gg: AeBDieuINfZfb9PolAGkN5NnfgtNW1UOqAQFq0CmBmvh62uDh1mEzMIHLtUjr1AC4a0
 Y3bOLNppFjf5MMxtc4H1wDGzHEanlfBWL5XlJ7QJLGYnJfttpV6g7disrEoR7gJvKPcbydtFzh3
 9w+SpwsV9hU/sRscQ4DzBkpVcDTIml4jiHCf25Dl32eKPbTAuSu9/SZKUWllC3fInwNCFxiHHOO
 KZHN/zPHdTlXHxOKzs1H+gcl7kxZ0/ANTCLvHTjpMFqBUI0FKcwAp/nmprcrQrNYwFEgPXgPZLl
 hJk0CHTvvEIxRHzMGT3bDrOW33L7IgRr6VsJg304+dZopGnjwddv46Vf3iUCeqbOHrooixt5fsC
 MtnhySOvyCACqOdldrHJspyA=
X-Received: by 2002:a05:7300:aa8d:b0:2cb:cc20:1771 with SMTP id
 5a478bee46e88-2cbfdb8142amr2476120eec.7.1775417494698; Sun, 05 Apr 2026
 12:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-12-ojeda@kernel.org>
 <177508434445.73816.7873322235592463050.b4-review@b4>
In-Reply-To: <177508434445.73816.7873322235592463050.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:22 +0200
X-Gm-Features: AQROBzAFcfOg6EKctMXZNeC0mwP27xs6Xk4PYTGLQOlXdHdfwi1d9GtE-fAbfxA
Message-ID: <CANiq72k1U0JacHf9rEVhOMmeZ4szCPBhbfLxC1K_0a0cQPw6HA@mail.gmail.com>
Subject: Re: [PATCH 11/33] rust: alloc: simplify with `NonNull::add()` now
 that it is stable
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

On Thu, Apr 2, 2026 at 1:00=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> This description is inconsistent with the previous one which had
> citations for both the feature (function in this case) and the feature
> in which it became stable (available in this case). I don't prefer
> either style in particular, just that things are consistent.

Sure, I added a couple references. I think it is good to be consistent
(well, at least within a patch series, but I wouldn't say no to more
information even if it is inconsistent sometimes, especially across
different patch series, since everyone writes messages a bit
differently...).

Cheers,
Miguel
