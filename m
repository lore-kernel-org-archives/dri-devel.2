Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7710E9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E0710E127;
	Sun,  5 Apr 2026 19:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8TCDEVx";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D816110E127
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:32:02 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-127337e3870so153200c88.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417522; cv=none;
 d=google.com; s=arc-20240605;
 b=OIUjIL+WPu0JSn9IFHkUHb2EQpBeI2gIDrEsF8xmNCUZuOISOrbZd/pJVhi83acl4r
 R1WnO09PEgnlj2+gzl25gagLsJ1BsqpDBV5RuR1rf0irk8mbzkAloISrE1NWn/edbdAG
 KRwjTmxsLAYUw7pKAU2Xp1yzRluE/4BwtJ6FlaKjvdjhVf+f39TxBW+i2NhvoYD69Po4
 s4Fo78OXc3mqzCmuqVOQgECqC/jrNFbtNgQvGT8k9FWr38n+l7b0xs+iu3GHfnRa1gEx
 85yFXcyCqhIXgSFbI2CD/p2QqIkLRjMRz8soiS4MLKFtnBcKg4UcO9iuJjWRKEHaD4v7
 HM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
 fh=RdbqikcESxj2h0xbNMcQEEwCp0Fw6GDGGw3vIZYUmC8=;
 b=dgoZmaCRnS23B505/HnZEvu4tKtBZCUkCwIMK8Ntq/nivD1GqkOECmC3c4VcIACdDt
 Av30WGN8O/AV6nDuajTYvNT0n/9nzqxww/VnqYRAZuOV3ineXGMV8sH6Q7PECMVUJLOB
 uqvQnQwrRLocswvKX54TGjWMBnyivYTqpntyuoz7fYwCz6cJc6udQ6tgMT9gFoKmCCAu
 atrqSYKuFBWOX3eMJPCQvaWwRYeCmQZW0xviYqwiBOwYGTtYQboZUUhodArsCbIheDcW
 DdhM4YKxQYajiWruAjc+ue2vMLP7Xzxv13JHkPe7WW7nG+LZr7ghzwfYdLnDX7F/MZn5
 wD/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775417522; x=1776022322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
 b=e8TCDEVxDRpRMF1I0c+Emlln009wBNuAJhj/wsJRpyifzoFp9UvqQAl7pO8rqyBA6O
 d9XIbs/7jCRQzsH8sm7wVMQaedB6jS9tNbbCpWYZhL8i+L2QqKXbNcmPrUKxHq+uL0NQ
 qc66DUZeshhPlN/PTvEV2yQaNCh/0+KOdGAotMPnkxK5NxaBa2frDRCjPkdVHMbTtm87
 yuGFvCGd3fzLERJMLoqU/A/DyjX3R/77wdKhvJoCyUU1UGqgZEqhrVtCxnuMUZIsKGuj
 pvl/OaWOqcYUbxAsq1hO9cCGKFhFkudidIZDRlbGgP/3zeJR4z8UhAew9rBAG+tEtPwk
 GHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775417522; x=1776022322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
 b=YlTAkCLXpKbOqwQlMz9+I5k5vIUn00K2e1gnBXyX7X5PHezY9lmFSiHK1wF8aCrrEG
 qPKAhBCpsnyt+8F0rIcgseRY+ltur33etmOf/YE6FX/i34UtD2MEvPPvfcyqmMVIBX4Y
 S+GdQDmhqWChDuNNjPT7BX3w2aY40fK746xXsmf9VWXfcemxtvmHlUmNhFZx6GgcE1IV
 HmsVitZYVJ5qHWjdO/eQsWpVkhoJvxA12vVfSyjAionzPvRHK0Bvq+zi6cvNehlOzzQT
 i5rPlDo5fGSzoAPqALhmz2PwpvERpB3e5giTsulKkgXIGHCJrGOvleaqKnNWcF8IxxMI
 wK7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyfIDi6Q5i14dF00ODQwrrRrtfpok8lOZM78RMYryjttpxS/eFk4MUcW7wcT+NUq85oDRiACLWtQw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Uaq0mJ7iezZ0mJeXJzzu/Vx0zfzVJinaLluASQEpOyqnmOC1
 4wDrwz6EarPYAp3tkuO4q/9In+hYqmIqjbjhtpIzKnxL2qwjh7QW1I35oZ16M8RMTT6wBpRFXH+
 XxspxQ8FOJZI9sPdt5GQLmMwoK3W7tV0=
X-Gm-Gg: AeBDietv7Y4LLZIngCVA12xDAIQ0n/6i037KD8a9YsVE18X4HeKsj6UXVpumrSxHUU+
 xhm4w7oh+xwy65d1x59D4UC3uA3MBvuY4+FM8ARaIVPIMNXBlQ4f2npq92+OHXUnYI2kGF3Zyvy
 5oHmxfk4RXMMugbXorp+gJyLfV+pXBmhV+7rwvzgi1RcmiJrhx9/aMkDpZAFYUj8M+R0MVF9tp+
 XqzBR/Y19s9UXx+/W1foEWGQTATq6CLtbezSD4riSTi7cM0r3mqpPM/Y414xsjcwUdjvcgeuMi2
 JC1681tmS0Cx4POHaSRxBjErWR/jkr8vDz+gWVxGoWsc7Anp3mwRibX8x7lQLxrBVFOspiuDudP
 aOMu4MFQIw3/m8Xok0FjnuFIefTij+8SviQ==
X-Received: by 2002:a05:7022:418f:b0:12a:7181:2f12 with SMTP id
 a92af1059eb24-12bfb745195mr2138075c88.3.1775417521967; Sun, 05 Apr 2026
 12:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-18-ojeda@kernel.org>
 <177508434455.73816.15756486388132647025.b4-review@b4>
In-Reply-To: <177508434455.73816.15756486388132647025.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:48 +0200
X-Gm-Features: AQROBzC24JtVqMf2jJjrf2a1W5TmgldNN6NvGBvsNhQ1qBgBmbTFc7OPu1-U-ac
Message-ID: <CANiq72kh47Nss9+OdHf=wRhO2=79dxPaL_vcPv8U8qG64bYfmw@mail.gmail.com>
Subject: Re: [PATCH 17/33] rust: kbuild: update `bindgen --rust-target`
 version and replace comment
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
> Some citations pointing to the upstream changes would be good.

I added a couple links as usual, plus a reference to commit
7a5f93ea5862 ("rust: kbuild: set `bindgen`'s Rust target version")
that has most of the details.

[ The comment already mentioned the version, and the commit that added
that message has the details, but I agree it is a good idea to add
some references. ]

Cheers,
Miguel
