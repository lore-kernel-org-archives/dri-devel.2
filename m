Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99650C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B006B10E520;
	Tue, 28 Jul 2026 06:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n9KvkdTD";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB9310E520
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:36:05 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1c4db7ca93so477886266b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 23:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785220564; cv=none;
 d=google.com; s=arc-20260327;
 b=X3/of15kXeCDyMX00Lhuucn/DjCIrwNZDGV7qOpZOg4Q586nBuxZrymWTk58UdN6fk
 WgePPlYa3Zft4JKDuXB9bk6bt52brVvgCHXkTugfztajfkZkATiU/Iq3pPj+nEkxaSHK
 fdgUnYHfI/H1Ejudut0BsV2IAVnW0pXxXNe4zAxpWHhkqeWSkd91yYp3XRr/6m46tKpb
 Btg8NhMJ7qmJRIE6B4EvMdsIKqsTjnkqkS6PUnNQGkE+k0xCgs7F8Er04tA34CgXH3vJ
 x8/CG5Sb5seZ9+nrqEZt6kbIGSySAB14FN5mI7tbxBdsQSTN2jAsG9NLMSEHgvmHm6vV
 Fugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
 fh=T1gYcEX0I6ztdeqPMm9DWvBbWiHYzfzIvZBNI6KjSi0=;
 b=HEYfJ/MLU+30K5r48VBbTGcrlcfw5UdxEHxHN96mlljXDxc2DSV/4rgLfQcl5y12HS
 dBS+wC7Kg174mJeCYxhyYbCyT6BTwJ/WCTJaXmiCjXjo6Vb5er2PUrGMcKYXfguxgcml
 HsBYVxjFGoOKhOZFB99ZPl1rPV+jyigccqn1LiDLHKD8MYiZ/CFyBcn9L7wLSTQmUNmR
 Rhw37l+RaauVppvfZmsdP/KGxHC+Infye15oP9pJ/jLOBiWWoL5TAjZMwdqCe0COcm9E
 luGN2Ww3ojNOi83AOabAA2g0mmZ9b+jD6HpAyU+wb9AFeZd2pwk+Dj2VulkUM2h8kuwU
 Zvhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785220564; x=1785825364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
 b=n9KvkdTDv7LnSO5JthY3BOuwl5lvsW767lrHnnnpd/xaraq7wNOaNatKwuVFizVDO/
 ccCsTIvzfJSzjgbB/1c/S43YZOBz67EkBRJMRPwTHPegp6ju6T50kTFauSv2xLpOVA1F
 fGYEMIebdSUus94+jVR8OdFHzGM48NCuwGGiUdkEyXBoMm30Hbmz5JISjUfZh/3LmZTj
 Luf6LNtnda3ttjI291PKOasVWnZqENvH3gb11lqw+Lo2jsjcfmucnMniu5SXwp0Ge5DA
 VQo70A3gENGzyBzpto9LoNDYTGIZiK2peM5V9zXoIk9fJhkCeBVlyQxsaJMGEjFExRo7
 P32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785220564; x=1785825364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duzfZmLmmvJhemX2jMFCmPO9f3XrbkW2eTjJNcX7UWE=;
 b=mRoP3JEKjZjnk1PUdBXG52Kv9078qvJCm6R7fGFg74STeEkPFoJH/r5Bo+swh0nL9f
 PGmX86ga8bPFqN9K8AzgHJNOzjwlCiTPIIEqB8Ksg8Cy1/l5v6Atj+u/Ds/zK/afAdpj
 jSo6zGQfRWT3oYf5pXf8r01fygqxyu+EZIN9KSdfMc8PLhJNPdDy7/WxbxOlX2ArdRDz
 BuXMvrLQvOrQILz7JPPKn0XBuGVFC23Qvvr5nABn4Sp3au3+F5Qgwha4mpfCMlIxffMn
 J8BPb+jHgOBabOog8RWm28ch6fMdGM1VBSlnn93b1i1WrJ+AMOwLSQTZSfq3OE48FUy1
 QILQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGuA6btdRAcBu4+iSUg28gX/u3zPILVzVBQ7G9U80gCDh6Cc+gBDIcB524InMfbBOpYsfxnu5tYPc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHl8miAx4UdQuSLwOy4cgRGz4YEtK9UeOu1OEHfXIK3oKjdYZn
 RgEAw04i2ODynkv0w1hDzanzfnHMOw/U1OUitBHjhaQGH4gpIk9xwShiiqZuxfXGwcAhb3zYGNS
 /2t2sBgPWMrc8GLxnEA19u4zn1oXvdR97bU7+36Z57Q==
X-Gm-Gg: AR+sD120PvDYpwFTc+fUwC/mLnRJj451fVaWGNG5HaBnyHV8eIs5MoxdnuacdjX2QvM
 b9YcYEEz6A0TathsRTlJXYxRMPCt7o+bcKJAuXQxHGDkcBlAgpSwXpirKr63X7ZPow6/XxVPJFV
 jzu1cWaSGwiwBt60emPVFOOwZKDn8zsutop9rlOCBLuUbnc58Bf/GoOskAf3ZYmzzo/EfhOO0b1
 b1KKEl1uCPIRQvwkNztT0S8WAOWRNZSJQ2ovgCwMyuehz79wsWm1QNJJsXPnVb9UOU5ZaRTcLG8
 umYR3s9SicnoUiOlsREJrZyI96lr
X-Received: by 2002:a17:907:d10:b0:c15:d422:3bde with SMTP id
 a640c23a62f3a-c1f72143dccmr45688966b.32.1785220564048; Mon, 27 Jul 2026
 23:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-2-shoubaineng@gmail.com>
 <20260714141359.7758575d@pumpkin>
 <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
 <20260714153319.07b2b1e1@pumpkin>
 <CAGCp47wsjwstEebFcKSv+Hox0LJo=oYgt5n-2xfKWgq4WLZK1Q@mail.gmail.com>
 <CAGCp47zxaZsoBKeXz2YdyxbX8QOy_g8dGwnC9gVpJ-Sqng48Qg@mail.gmail.com>
In-Reply-To: <CAGCp47zxaZsoBKeXz2YdyxbX8QOy_g8dGwnC9gVpJ-Sqng48Qg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 28 Jul 2026 12:05:52 +0530
X-Gm-Features: AUfX_mwmHSb9ULjRcWMzRfxF5YDIQvTQbS3OokFwfCg21Sudlmr7BMxr4LzKAj0
Message-ID: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

Hello Baineng,

On Mon, 27 Jul 2026 at 08:56, =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmai=
l.com> wrote:
>
> Ping. Any chance this can be picked up?

Thank you for the patch.

While discussing with T J, we realised that adding a selftest for this
would also be helpful. Could you please re-submit with a selftest
added?
>
> Baineng

Thanks and best regards,
Sumit.

>
> =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> =E4=BA=8E2026=E5=B9=
=B47=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 10:04=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi David
>>
>> The rollback here is the simplest possible case (put_unused_fd +
>> dma_buf_put), not the complex sockopt scenario you describe.
>>
>> Baineng
>>
>> David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 22:33=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On Tue, 14 Jul 2026 21:38:07 +0800
>>> =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> wrote:
>>>
>>> > Hi David,
>>> >
>>> > Thanks for the feedback.
>>> >
>>> > The concern is not just about the EFAULT return =E2=80=94 it's about =
the race
>>> > window between fd_install() and copy_to_user().  Once fd_install()
>>> > returns, the fd is immediately observable by other threads in the sam=
e
>>> > process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
>>> > copy_to_user() has a chance to fail.  The triggering condition is a
>>> > deliberate mprotect() flip, not a corrupted heap.
>>>
>>> That is what makes doing the close wrong.
>>> But that is a program aggressively trying to hit the timing window,
>>> not a normal program that has managed to pass an invalid pointer.
>>> The most likely reason for a real program passing an invalid pointer
>>> is a corrupted heap (assuming the stupid coding errors are fixed).
>>>
>>> It is really no different from the sockopt code that receives
>>> SCM_RIGHTS messages.
>>> In that case once you've removed the FILE from the socket (or similar)
>>> you really don't want to have to put it back because the write to the
>>> sockopt buffer or length field fails.
>>> The chance of correctly reverting the kernel state is small - and won't
>>> be tested.
>>>
>>>         David
>>>
>>> >
>>> > The fix itself is small and follows the standard kernel idiom:
>>> > get_unused_fd_flags() reserves the fd without publishing it, so the
>>> > window between reservation and install is entirely under kernel contr=
ol.
>>> >
>>> > Baineng
>>> >
>>> > David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A
>>> >
>>> > > On Tue, 14 Jul 2026 19:46:53 +0800
>>> > > Baineng Shou <shoubaineng@gmail.com> wrote:
>>> > >
>>> > > > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into =
the
>>> > > > caller's fd table via dma_buf_fd() -> fd_install() before
>>> > > > dma_heap_ioctl() copies the result back to userspace.  If the tra=
iling
>>> > > > copy_to_user() fails, userspace never learns the fd number, but t=
he
>>> > > > fd (and the underlying dma-buf reference) are already visible to
>>> > > > other threads in the same process and are leaked for the lifetime=
 of
>>> > > > the process.
>>> > > >
>>> > > > The obvious "close it on the failure path" fix is unsafe: once
>>> > > > fd_install() has run, another thread can already dup() the fd, se=
nd
>>> > > > it via SCM_RIGHTS, or close() it and let its number be reused, so=
 a
>>> > > > subsequent close_fd() from the ioctl path can operate on an unrel=
ated
>>> > > > file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
>>> > > ...
>>> > >
>>> > > My 2c:
>>> > >
>>> > > The other option is just to leave it as a 'problem for user space'.
>>> > > No reasonable program is going to handle the EFAULT return by doing
>>> > > anything other than exiting.
>>> > > Even getting an EFAULT is really an indication that the application
>>> > > is already in a real mess - most likely with a badly corrupted heap=
.
>>> > >
>>> > > Anything else leaves error recovery code in the kernel that is pret=
ty
>>> > > much never executed and open to a variety of bugs.
>>> > > While the recovery here is probably ok, there are some sockopt call=
s
>>> > > where it is all more complicated.
>>> > >
>>> > >         David
>>> > >
>>>
