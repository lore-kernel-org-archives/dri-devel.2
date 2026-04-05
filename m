Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B2AE9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7004E10E1B9;
	Sun,  5 Apr 2026 19:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5tkb/uE";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D61F10E1F8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:32:10 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b8095668ebso238004eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417530; cv=none;
 d=google.com; s=arc-20240605;
 b=gs1KuddvN70IYAj33lQshEt8Lyy64cCxu43hnqdaVIbcjRb6elQxhy7CgwEKrk9CkS
 8i8uF7E7E1yDhpvF76S9gPH4oG7hPQ+aC96TpvZJaJ/WS6cZ5+rRQKA2hWJUnDuzqjDg
 EXWbgKX64YcU2+Mh5PfTkT8EoJ869eXv44gUipq7zxDiOKqG3eCrNsgdKGDcDfQDHMzH
 /1YZzlxREApWxYKyQgbWVhhvlpNAO38lgWVVFTsga5eL2V7xG1oQKk5NXRZWjzb/IuA0
 1k2Psk0mB3U2uqGJ4UFu7ksTJuEVsqweg4wlD6oMUVzIYEbq6wa9gvsALXjfbCuySVYQ
 Xlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
 fh=8rdnGaXHpiSWhTwWFxWgULM+mCKRkhfashXKtxHpRpc=;
 b=VaFGSF1gMldQLtCZ4AGEy2Xc0AyAyBx+W1HRnPqdAlNGoGiyjMGbZXoQaaBq8J0Au1
 UH9MoMy1Q3m6oW6lHIjdks/qok7SijJuDOPSUxQUZ5HPK791MdwAjnLCdpJekV0vg1l0
 HcT9VBK1vBYtByUhBzQLN8DG4Hm2W7P6b87iSMFl1Eu5vhvgVW9zW0Z8kMbMZdEDGyQH
 c0aSMR1JfNWhdDSSd+a0orKrf340V71q4X0fFUsgJCW2E7H0U1ot98zH2iR7N7R4jAtf
 UFqpHrNvH7bB/QQ35VdwiVAtAkOPurAiOV9RCr71l4apMQR8CY3Vg2sKxKHKOYXiJDL5
 8NiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775417530; x=1776022330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
 b=G5tkb/uEWh6iw73jdTqX0G50RMULWWUbFusnue9eDEtWwbXa7/rUUXLvg/PAKIw00I
 vPW00VdyQRgrHIQyiuQ6cZz2v18xkv1i+7jUJnvH4rzqbeSRDSE9W/99jCS62acQfCVB
 Ta4wF5aIlrsoUsrSncf6HPtfTydnCOSZqMhWm+Nt2g/cbsIlwpLJ52jafdgUdJuQ8zBj
 619JJqpTQ2wlUAoaDLZZtFCTtXgcLBAWvFjeerDUFdyl+QsvIKGv5FKqlucUnEs87Bty
 denf3ChB7lic7EQI87mATLN61ceI8IKqy4ihUeMBIX2fL9dGLdLspXKN4NprXsjL2U7i
 A86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775417530; x=1776022330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
 b=Ox9TRMSrPWL0B1PXlow9C0oGo8jH0SBsFZJfsIGCR6Li6rXUDi56ca+3g7tzNqaah5
 f1LkvuWto69KBUVs0ngeaO5YomzjPHrfITkF+XgA/hIP+1q5Vv7ltAion2DF+6sg+L8z
 p2zQqN758yvRNEgO011S5HHDOjT1VL7lVHBI4KEzqz085G4Rz0eA9rcoouImjdBwNeM8
 efzw5C+KeagVdCxxkOAQseRWfUXCMd2mdZuFgUY95IHqE5QDRn9gjRkED0nNBmcfziHE
 qi0SZFuh2ir9g07IX6BAMAQWeYSebao2Tow2wHZe0eyk45GSmuE07mKf5pu4FXDL2h9i
 3mJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjN0ArUVqrYBB+mk9UgJN/GDK9dd5znr+X+Egjfwf9pnQcUsodvppQYWuz6UOI584Iw3D6VPqghqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxb9S5YUpp6t3etsLURhgYxFv9v0WOXMuJLxXaaMicXKf72tP/n
 yfhSQfw++QjDtSK8tZ1lYshs6x1w2YfyUM5RVdeore5r7wKtXOQHeVek2/GnXE7zUuv6Xe6CxxF
 Em+UwrK+wYMETWX2MPJ3NhKx+enjOqcA=
X-Gm-Gg: AeBDieu0+DwXa4pYs5IGqNS61QZUZ/68JNPWrZe0Wdxvp8AxMjJIfbER0aYuul5E95V
 6/dq3U4HwiHOoHBSXdwaaMOIEc33XYfd56hazOaYP1tAtGg8mXDCnPBb7CSAslvRyN3UyQzTUpx
 O0yeono/EV1Lv0hFui6+SjQ5KPLhVsEV0PfysC3l2f3cOfh9G2eNdkiK7l8ayHO4kZGpxhMNp4Z
 /vaE6xwbtuCL+E8BfhU4nLTm7Y8S0kAySKISj+s9grPK5MfZBN1L8zBL5t/HhMtVo6CpM64pAmt
 zHg3CavC1YOd11s+fcaH3npbtceOQ0jv4FXyx7Yn6C+hL+C4M2pn29k3b9rXSlX3RU63CD5yEt8
 PWC1ur4hRjS/9ivgCLo4kc3M=
X-Received: by 2002:a05:7300:cd86:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2cbfc768bbdmr2210515eec.5.1775417529556; Sun, 05 Apr 2026
 12:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-21-ojeda@kernel.org>
 <177508434460.73816.4231801886718165891.b4-review@b4>
In-Reply-To: <177508434460.73816.4231801886718165891.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:57 +0200
X-Gm-Features: AQROBzDsQvgh2EDKUg3LiGNTUf-8TUQBnEeLR3UEGt8KzpEPnOxtdZC7xsmuU3c
Message-ID: <CANiq72m9bsXZnMJv2w9eszV5DGUG1Cq0NCEUqv60=4Op__Uong@mail.gmail.com>
Subject: Re: [PATCH 20/33] rust: kbuild: remove unneeded old `allow`s for
 generated layout tests
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

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> How about ordering this, the previous patch, and the next patch ahead of
> the version bump to avoid the need to mention it here?

That is reasonable, yeah.

Cheers,
Miguel
