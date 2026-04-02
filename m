Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0CDCC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C52E10EF9B;
	Thu,  2 Apr 2026 07:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oe3tgDCx";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E47810EF9B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:12:37 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c5cf871adcso21696eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 00:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113957; cv=none;
 d=google.com; s=arc-20240605;
 b=eI7DnjY92F4uPTMkZBvB2nOBwLzDjP4b2u+C8qOUsEdp1MshkMmxO0sH5O0uzNSLCj
 0FAdSCIEXESz+q9XHlqCrq+5vknAVLKYDsC2A+xjGK0rI4E2+E6Tkw2yXzWmSF/YlNBk
 YNdgfVUmzHgOW0xvW8LbDAcWiWmNdaSJWGyDK1Li3khM/VblSHyI1fWapTR7WtOIA8Yy
 qGOWr4lpK6sOdnOujrHbrYhewOIKz7lIo1E9mSrHT1ZfSPQNkUlYxP0/hc8R7LX3AJcK
 mMJYUC1gdm+jRw66nGJHuBPINwqd6rDbpXOS7FNDY2wvH1XXbQGEj5Ehc0FmKQa7aRQN
 PEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
 fh=Ad3v28LFkqQ4w39663aR9swehPP1Ekcl20E98cvXQeg=;
 b=fopzOaxkCCcnDUcvBBtQJvPj7ZTtWuK/6hUWqhUyUnIMeXafNEpufzqLcjCLxiBBX2
 91VuFNv5ZkfURAU73SXFeJwA/P8ci9ZULUxJ6rSZrBa2/lflE3e2L/GUW8w4nSLOiFgo
 2mHNZrvYXDHPvUG2qrVHW56VgLEAY6Ehpqw2EE6Fa8auF/uQyW+GBMHs7T7XCtyeCpJ4
 EbJat/XzehwqJrQmczQFOPgvtfjIEP0HKanhAHwWpwEYKKPfLb7ZO1hfAxFUA+WDyGPM
 VV+Ig0iwCskf7TfqlrEq8y2vuhoJMxsbYYDOt2/aj7dL35AAvDJrNMS69MFPuE+eABZ1
 MVnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775113957; x=1775718757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
 b=Oe3tgDCxIZiC4DHC/Cvby580mx72qpb7OUEo06GejxVeUWTty7UHge39Ht7uWHkA0D
 dSexGccwUCE4RFdL07aImWBx03B6BXz3UOylyqwWhCv7+mpvxWXksGqVmbhOLsGEf6uY
 k1UwpkSS9squsvNsuMS6rxNM9W5yW+5U4OX4bw+S+lCtGUnsU9PTWeGY/v9tloLyIWye
 zkaVDPOD5iZcUeIy0gQDKmSWE9mHe/ZGiktrtKw270u+vWaO2TMDmKIBA+RS6S4cr3k4
 NIWGre/Ym4UR6iywQx/E4T08sOjeC5/0jl48ns3Pf7mBFlcmO90fTsFrYZ6jnD75C8DD
 E/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775113957; x=1775718757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
 b=JidHSdTBh2n4yYBG9H/XCPPG9CxJJ5g6jxZwl7Bq9hrVNhD8kBOhUxpRa8TH2e6+ye
 8LlJEPge5DjUYvcwwMweipw0Z7p+RC7CKrhO+UsdZnBI+fFZnx4BWfMsZUJgxqONJVPX
 JWN7a60OQlTeTdr6fCjLVFJiFAEdqNqHDssLyypylS8kafvsX0RJ/kOG9Ye40tTWuvhA
 YPcxHxSAkC7YnS6l7mdM29A93eABe0NyYjKyvlBwPHUbcdUKMt/vT7nZumscJeV4YZiB
 Pd5ah66XnE/7Fn+nJRujlXQs3vHtJ+8StSA0uDex7x4DBEU08swRKUAYEudWrJidsmE6
 HwjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUEk1miC3DX+0szo6PblF3VbXk1qJoNldE3tcwLw+xcUeOzaeFqBDRfu5Am1YWm8NAaiinz+LdbGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIR2XHVGa7jf6YaqNv42gYkk4qzYXbhcDrJmjuAoBdLtEoqz7I
 T/IMS9nDkkzPfn67r8FVqwX7wTwHQIB/g5qSFJwWZHSfunV7LZa1fBnEQXG+LtUIEC3k4eeOonl
 6hVfrWSYF9sHPN3UBD5x15Err4j0xduo=
X-Gm-Gg: ATEYQzw2SwV52Xr4bcC8meqTh0vgyXrhncVr4BmGYzECEBbbon4t24Cbp+YWoLJm/gr
 7IzlSPK3+D2xKStK1NVXBE6UY9gwkqhNCshKHRD0pOc3bqmuOEQ3nTfaV6BO9cQ9FL/Tkr52MVU
 Afk0TpVn6MC8GKfLXjJm+G5DyFrFxYPQk3J0tBQRRudtmW0BvY//Yn2KAXJUkamTL07tHPaGoNi
 D1DrErStZ8iV52EIXDrKP0zbvaYLISYZPfvkutONdyfgAWh07UzFXtcnhkTSlYOik4DD+2zBDDH
 yF71nwfxeSJVA5zKUa23EXmyrSLDkTxcTGThL61AXpFnGgExx+jggHQhYpKIxGvRU1iIV5+iFwY
 htlRHrGpSIoJFwxVP0fgxJuo=
X-Received: by 2002:a05:7301:6790:b0:2c1:6416:2a07 with SMTP id
 5a478bee46e88-2c9321b7bf4mr1634311eec.4.1775113956496; Thu, 02 Apr 2026
 00:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-16-ojeda@kernel.org>
 <DHHWO582XLXH.1DU3CO41F1PV7@garyguo.net>
In-Reply-To: <DHHWO582XLXH.1DU3CO41F1PV7@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Apr 2026 09:12:22 +0200
X-Gm-Features: AQROBzDaEWueCbjTzytnJo43NDIAkvyWYngeEqQLnAsLh-4PZJOJIJpad43tD2c
Message-ID: <CANiq72n4sCU=2m4Uee8Wpsv3mjkw_BuT8Sg54Gu0U68j7qAM5A@mail.gmail.com>
Subject: Re: [PATCH 15/33] rust: rust_is_available: remove warning for
 0.66.[01] buggy versions
To: Gary Guo <gary@garyguo.net>
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
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, 
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

On Wed, Apr 1, 2026 at 4:58=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> The scripts/rust_is_available.sh change looks correct to me, although I c=
ouldn't
> get scripts/rust_is_available_test.py to run on NixOS.
>
> Looks like it filtered out PATH but uses /usr/bin/env to find python bina=
ry? For
> obvious reasons that will only work if python is located /usr/bin/python.

Yeah, the script has some assumptions on it (e.g. it also assumes
`dash` behavior vs. `bash` in a couple tests which I should relax
too). Happy to change that.

Thanks for testing it :)

Cheers,
Miguel
