Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E15C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA11110F560;
	Fri, 14 Aug 2026 10:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qlxl6ACL";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D144F10F515
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:30:35 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc8311c6ddso1164115ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786703435; cv=none;
 d=google.com; s=arc-20260327;
 b=RxP2U/28Y8ogBbKd520g9+zgHBIRQ10DmfykKnsf87j3yvGuMQBK9fss7qDkTWw15J
 sqNaMokY3HlaKf1T/2fkxYHUntrdWjKeL2hWWysKs3SK06HMGiJDRi6q7sEaYAiBYpG6
 6Qxf1jpWN3py0JxPeTm/plUr1vLrnOni6omNzC3McruKilQJCY5QYIUMIQO1ADZrA7o5
 PjgN+f+5EpvV+uDZhaVDDiq952EYz3O+IlDbZi+Gi+JUACPj02HgSE+d8mLQZMQPneEm
 7jC4DVD1vUOqTxkio1zBFC2rlHwtMqtcWZo+6vLgdeH2BZ4am/ccMzfYwZJzLMaPVQvk
 8JyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3fehzsHa7Sd9X2tq+C9ScVdD8EMn+jQuH5aGR6j+hWU=;
 fh=k56caGeXxGgxV/WIxX3q3ehkevy8Bg696EPiFJa1eO4=;
 b=VgpqV+4Qwoj49qSzaHzuD9GFmlIkhzcIoHI3tiYS809sJ0VvmFWl4rGVT6EKt+rtO1
 9qOoP30l2ppML4YFKMW8A3t7N9srX6xoEeFxe3bVC9TD2WUwuQYdKA7s38x+1CVa0joJ
 aQC7AJi0MXjQUKJ6vCXnUttqRTfxQw+cb58qU1droOc+c5SsPSAlT014BXbCf3hyNfMq
 yRkKzLyU/Eu8UkDYhm3HOOgTyaNm83Jade2tScyV3DaN4pFG0NihMmb4j7W7wT9/pWOI
 k4XJZ1U17LC72+TGaA2YfOMtHLRHgWRa1pWNUr4zJYwwvE6KMPuuCXySCkWGSikq6cB9
 Mfyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786703435; x=1787308235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3fehzsHa7Sd9X2tq+C9ScVdD8EMn+jQuH5aGR6j+hWU=;
 b=Qlxl6ACLNMPNJiiQJM0H86sTBFiAHkKoBxh7aV3aO2Nd+hMhYExgyB4ZADzI7tCijn
 WdDOZeZUJ8yqInhqEnfAN+VVco1m56xQyldYpOKGUH8GbOhXz8XkNRcaI9bnEZ8YZgSw
 tMhGreaTj9FOJKuLWg5tm5wUoE757Q64Z5MIHbRY/10Bqs0J6tcM6H53DN6uHP+HmB7N
 3hn+/tf/7vEpZlx1oaZQlb3VZTOr5+EdryzslHDPdwiB58r0tFTH1ekuEhJGIvXict26
 /HeYSHFT/NHZQAFpzkSLZBJLDlEp5LqyU/FdSzERlnYN69tEjDEluxaAXaJ4P7Mzck0c
 VlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703435; x=1787308235;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3fehzsHa7Sd9X2tq+C9ScVdD8EMn+jQuH5aGR6j+hWU=;
 b=fPUSAlfR08fb3+MKJ46MQQobhV+8fcJracltBA9Wxe1Wu8u7vZ9Nahc6UmfecOiKw3
 FLU/3h8/jbQksVd5jQi73UcBT7X2Vxud3ncynuM5FjvbUWcw0ZhC9z/faF0L8fCWPtbM
 9/HTcgb+ESSr+HyMLAaf2js5lVq5Mc784t6Wy+/M8KUoQHQghcU2DyizQLUpPezNLfCB
 H3TdO9az95YFTP2v2Qyx4YtkDfi/ydSBfc3L+kI3+R7aTsxZubk4NwYJJ5iMh29g24BE
 WNZh5JLEx47NWEMDDrSJ+4GIAsDVddjRK9u6M7b3WvVG3xQ2SBQaO7RG4kyO/7vsLLnJ
 jg3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoE8RznMLgpBPn8g0/xTWTpFIdYLlg/R9xAUvCnaV6n0vhjdOA0TTpG1AI5RJ1M/CpMKCEuLTgwoY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFUMdjt/i0ZLvXaE9HTkPWZac+RDrut3jjTlL4Uv5z37/D40Lb
 GVBYhOmucsQ0PNt3Y4K1uomxC6E26xQZR/qHtJuLXCw9oX7B34FwaPHHYNzrD1aNxfRXEYQavpI
 y8q/uawEefiYBc4aJ9lVQ43e+uh48fPk=
X-Gm-Gg: AR+sD10cWeshWb1GRmRiGKPCU0Mz7HfDUqjigunIrvoV4jZ2Eg/bEXxxqIQg11h50EI
 zbguxSlVbwk+OZc2R9K2v1aLYe1paz0TbYHrfZ2d7l91NDXPie/hdiudP0rpsnobiZMH2lPl95/
 oEH5nDktLM1EzKUMAl+TRRpAVmiiFIuq4bVCj70nkocqjG1IfQ5fMrP7DuV/Ksl/pX6wtYWrZYS
 UvNzDbGQOUWLzh0VX4nkt0pLhmQU/6YXdmjkfdbJYudZ7G177BksqgtN3+ANOmaQUoXUBcHJktV
 Q8p0wnYI1SAopnNznvBNKfllcrK+l+CnNIh8hj+tUQX1lQgs2RCVImA/ja2GvXfWaY1GRA6mJlA
 9NB/tqWiqDQ7vO/GyrFk5CivhxVy6/5slEjyaZdKxXgAvvRnZMk39y5WMpQeR
X-Received: by 2002:a17:903:22cb:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d3b0c5dd2amr40185465ad.2.1786703434950; Fri, 14 Aug 2026
 03:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
In-Reply-To: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Aug 2026 12:30:22 +0200
X-Gm-Features: AUfX_mzbSVhZjPvAzS9iZYtypbsJ35PZ4Nm04Q-zyNGgr6kR87uRIK7yu3xiGYU
Message-ID: <CANiq72=UbRsAJ2Hyk68HDkHL+TVzg9n992jMSO5Bt2iEDYhnrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: add functions and traits for lossless
 integer conversions
To: Alexandre Courbot <acourbot@nvidia.com>
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
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
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

On Thu, Aug 6, 2026 at 9:36=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
>       rust: add functions and traits for lossless integer conversions

Applied (just this one) to `rust-next` yesterday (next-20260813) --
thanks everyone!

    [ Added a few more intra-doc links. - Miguel ]

The second would have a bunch of conflicts when merging in linux-next
-- if you really want it this cycle, please let me know.

Cheers,
Miguel
