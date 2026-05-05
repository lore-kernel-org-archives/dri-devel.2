Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30846FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8557810E157;
	Tue,  5 May 2026 13:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcykEeGZ";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7118510E208
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:00:05 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-651c366f7efso4988064d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777986004; cv=none;
 d=google.com; s=arc-20240605;
 b=CsrdFUoA4V4uI2qmZgljnhygwSOEx7z3ktaFg4n853Ca5Z2PR7cuy/JehKGOUxmAzN
 yA6Fx0TFipg2hrRxEuITkHK/brKobiRAvKgXgAfKMbojKNOUYisLrzf4fQ40dY6efMnA
 x5FivY29PWKD2DqGYoyCm94zQ4Ovu6C4Rci7uNKYacYnNiu72ZDXgibB3cpV3mnoS6jZ
 L/D/GDUbVi5l8qj+mkLBZz2xhNQk8mp/eNg6+w8OtoR9OX3BB+/4jrA5UJ8tbXqSX500
 ccf9jUV0lo8SLrpcwbHPKR36kIdnFDYJ9zeGSdU1HTgwcptarHmuoawTQLPdBKfaVIfT
 2LNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hIDRLg2eWaFSrnAvJdPT6cUXbRWnjBe9GRrwIz05WwM=;
 fh=cKZk7Q+FOf/wkeVMfGzvDKfKNmRKHN8glBkDR1K9WyQ=;
 b=JKt8pSkeEXQo4CO3toh9n2IwleiXxhD/AQp9/2a4WyIDdLZii5IGKj1OjTkhinyyom
 Tgy3CeU/CdILWbc+goX/EejXJKZA98bUtv8G9y1zZwNfoxIPmhSX3+bR3yR3xyKvAH1j
 ojNbENFWwPecpwxjDoN7enpsHbXnamOqrV4iJf4AL6DExhDoJmJyqrK+IceD/qEZ0BAx
 Exxkk89Oz650VKKwvZ40uL2kI9rkgyoQfFipIJGQ3SX29kwL7HyMxOqB9SoNOOvy4/rZ
 ZUO1HGToEHOWQkHm6spn7yHIyDsNZQm9HIqorzgBuQ8suEZQm0oS1MAXyI8vq5niY/EC
 aVlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777986004; x=1778590804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIDRLg2eWaFSrnAvJdPT6cUXbRWnjBe9GRrwIz05WwM=;
 b=YcykEeGZSnejnO+e8L5paWmiFIBjkvo7Ec/ysNJ8+I0O37ulWOm6yqvmnupULojvJR
 UXm/cOe+0sKKAyinY0y86z0RHWvwRMBeKCTNVE/RYOAdvwsxic9wl+Qx+l9tJhGLMEqA
 s+k55H0TNbSnADXcHFjaEn5HMccghDf2PSc+cdad9Ov/COeJAdRxW0qgw7GW240DG6nW
 7uYKPa6OqV9yjRy4tKmDSDp3vRp2iZ0Z3vi3iGVt8SdI89jOzMmqr5Ltk6A/rOC5S11v
 qOz6hEn1Dq6dBjr/9WNyIyXx+mBEZ7x5lLQUu8VmJg65qVk0QCPhsB5ztJje0hAbiiKo
 VrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777986004; x=1778590804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIDRLg2eWaFSrnAvJdPT6cUXbRWnjBe9GRrwIz05WwM=;
 b=Cveoxana+/x0A29YdGsPSpgNAw1vEFWhd9ofX+fC8PD/hf4MXm9epBCLAqPzgqFecz
 VQjF4mk4NouiXCHKqA8mhXPrbHFe9SQAAlHV1RZq/I4ErFo7ZgFLP9itN0dlWeqQEwUB
 3meFHwW2HCrv9y2xMLIP0SQchnjYDwE9C/ZoP6Fy0dPpbUYBIuYo6HBX4EguMxUQho7g
 0kxLRRoXgjmBSp+DyXEa4iG/KBlZs3aIh87tsCBi1+vU7q6zo9ShpkrRs8w7dPaoebgf
 SQ97Q6FhyAonjZQujxL0NtiTCubQIZFkbpPHyv5BZJsFNxPW9/lHGBkLcZdDvJ7g33I7
 5t+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dyemq2e+E6MYZEsLEFR6UlOCcJkS42PGwepQsu1eyHSQ+KNbVdnfihaQuCVgn60Q5xhIJO6tOKnc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz19KA0SCiw2q5VcjKWaGIrW6y7C1rj7dfihUplRfKq5fScdOVS
 lzJ3U3FXZA0eqa2VFOdVUx1yVOcKKU32i6EoY49F1tEhNfrGHOj4PL5h5B4S2l1//AJyw3DhfIG
 8be+8qzNDBPVQPa/5SuhoslfegQuun5M=
X-Gm-Gg: AeBDievvL2D276DEweaPVa/Hn3DgtPaJDECrvI+8Lndlymiuy4IHEzQP3RjmSaFa6q1
 6eQYM6/e12gYeuKrwuQL4dOl9SKxcWL8iU6R5Y0vt/8v4b4r8xntRPHL6Cl0Zzb85RWZVn5c/Zp
 9KFizo+3MFTSmpikA2WHr/qM+R34HVofoO9Z5iiUL4AG7ZYJETCRVplZ3qtM20nDXgpird3aXHA
 Bbc8rBgWK74Jh2VpIAbKWexFB2jjwl5YX1qk13u3FMr6L2Q5mYRmfpcYKGXqTLrmQu9ESPiKQ6v
 /OuKXAvo+lMWMFK0IHtla79iwHHvgplXM0NdJ+9kC2rYb7JId/qEQTXDAW9+dWANWkOfSA==
X-Received: by 2002:a05:690e:4184:b0:650:4a79:f3b2 with SMTP id
 956f58d0204a3-65c3da71099mr12790430d50.28.1777986004285; Tue, 05 May 2026
 06:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
 <cf945dda-f526-4544-bc43-22f70acb28f5@amd.com>
In-Reply-To: <cf945dda-f526-4544-bc43-22f70acb28f5@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Tue, 5 May 2026 14:59:52 +0200
X-Gm-Features: AVHnY4LkH-1c7-8LjQHE1WeKKibV23GXxWelkIeQtvvCstfkg90iy7cF21RDMuQ
Message-ID: <CAHijbEXQfm4QDDfo1yiVBV9mVvogGqt_BAu2ipnhqa-EDOKteg@mail.gmail.com>
Subject: Re: Regression due to /sys/kernel/dmabuf/buffers removal
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, corbet@lwn.net,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>
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

On Tue, May 5, 2026 at 2:41=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Hi Julian,
>
> On 5/5/26 14:25, Julian Orth wrote:
> > In ab4c3dcf9a71582503b4fb25aeab884c696cab25 ("dma-buf: Remove DMA-BUF
> > sysfs stats") the /sys/kernel/dmabuf/buffer directory was removed.
> >
> > I've been using this interface, specifically the exporter_name file,
> > to detect dmabufs created via udmabuf. Such dmabufs show "udmabuf" in
> > exporter_name. I've been doing this for two reasons: 1) to detect that
> > mmap on such buffers will be fast and 2) to detect that GPU access to
> > such buffers will be slow.
>
> Crap, I really hoped that Android was the only user of that sysfs interfa=
ce since that approach turned out to be quite broken.
>
> It's number one rule on Linux that we don't break userspace. So I hope th=
at you don't insist on bringing that interface back, but if you do I will j=
ust revert the removal until we found a better solution.

Bringing it back shouldn't be necessary.

>
> > With the removal of that file, that detection mechanism no longer works=
.
> >
> > I'm not particularly fond of that mechanism but it was the only one
> > providing that functionality that I could find at the time. If there
> > is another one, ideally an ioctl on the dmabuf, please let me know.
>
> The virtual fdinfo file you can find under /proc/$pid/fdinfo/$fd also con=
tains the exporter name for the DMA-buf.
>
> You can find the full documentation here: https://docs.kernel.org/filesys=
tems/proc.html#dma-buffer-files
>
> Is that sufficient?

I think that is sufficient. I probably didn't use fdinfo initially
because 1) it's a lot more work to parse and 2) I wasn't sure if it
was intended to be machine-readable or if there could sometimes be
newlines in the values and such.

>
> Additional to that the debugfs for DMA-buf also contains that information=
 and I'm open to the suggestion with the IOCTL.

My application runs as a regular user so it cannot access /sys/kernel/debug=
.

Having an IOCTL would be ideal if it is not too much work. I'll fall
back to fdinfo for now.

Thanks, Julian

>
> Regards,
> Christian.
>
> >
> > Shipping an entire BPF compiler in my application, which the original
> > patch suggests as the replacement, is not an option when the removed
> > alternative was simply reading a file.
> >
> > Thanks, Julian
>
