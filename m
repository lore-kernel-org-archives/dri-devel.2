Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C2FEC0F1
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F050110E108;
	Tue, 24 Mar 2026 18:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="urK/3BzE";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D94310E108
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 18:32:30 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-5091ed02c54so59091cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 11:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377149; cv=none;
 d=google.com; s=arc-20240605;
 b=Vb72CTF/DjW9Gg/IfOHJFaMSYGZ1T3C3BWe5R0Pz81fR86xOYQbJT6RLywTQu5PPLY
 2W1B3ZZ2jQmDAeVvQOyW5/rf05YzQd23JWtO1YwoVm+2oCuZhIA1H0WD258yMZcRM6x6
 /G33SW/u4Lg9gPdDqIHeLVfk1cIvnlNa4exFWJNk6vs9d/elf0K83uARWQ43ycOMoYYR
 Lxb1ielcbAK7b6tiS/vVr/9t4rZzuyk1QocxPDvRv5MopdJdHX0eTllWmxRgb1TIG6qp
 0lAOl6oX+/Fm2lzxEwYs9tblKv0fEuPOTzAsMUeZVg/LD1OOSpCQYmHziF6RFT9yrJD4
 ZvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
 fh=4TNE7Q7MTtTpgqqLqDZkhfUdzrSkZC44mCv5fGum2sc=;
 b=lyRniANBfWBijV+KsyFwjcqndI9LAsFy30Jr0WvAWGy6WprOgyR5DtKt/Fk1pGcxPT
 PmxV/9P2ackZtzHZC0SKWwtc3Hf+eeHviDPqtHc6QqRB9hLNvJDXhmRrASAVsTZhs37W
 JY78DND41B4/XHtxACU9RRcyHVpy6vMcsm+xMcZ9FZ9F/06uBDHfO3Tmg2SdsUCVDZ1e
 seQSfsKqX4ZdTQOwmgFWKgvlyF7+YUJM4FRWuBYMRrfAUtBIKYlhMPGZevAP4ne3fH8P
 S+bknUnxDFCAZ2GlhZJyPnKs4PHLdm81IHWiD2X3pFzr9pAmEIn4SreZzUqAaqHRY5PN
 JQYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774377149; x=1774981949;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
 b=urK/3BzEneEeYk6ux8hU27fnj4VV9inqi7APo9zEPsmMgBMv4uKhlUrYpqp1FUMjsU
 y6JlgPa51KRoV3cSXhkZDsz/yH1Jj996V9/S+Fk4z6LHL/9yTi1DTihz1itOvUJfz4kl
 WW6KCHzUFa8J9b0Pd2G5pH8pNzC+kQ4K431+L9a3lekIn7zbn2ZD7CKlEJtERQrfCPgj
 Na/AqQ5+FouRraU3+jLwQfKCa0eugQ4Jb8u+/IIdCuMQVZFOZ4UBWfeXQRP7GuowpjUw
 yfVsUCUWZhoqDoKQWIMnUXtrhhRViok2e8cNypm1l6ODRzKfuYUWpJd9tbA7ed4P2iRi
 kgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377149; x=1774981949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
 b=darlgv4c4dvltaOQAHZgO+bd2mWuEqKR1tL6aENVTMphcuVUPXyh9M2WbKinsFBmqm
 5ea6IjR9FKP/RHRHkY6Umeg1STSvwsYwx5ZmLS3Xb22MoCxTmie1B09bl+2bOOvo8IMr
 HR6XZvOfIJVFlZCsRww3H3YPmwb9aTVLoRUjUHc09frpt87EVoq8pAkK0ARMAubjXL3r
 FBk5ckwcLib4JSnbG2uUVoEDtMCWcHROzd/kZqVk+7s8ekusbAXGFrUHrcP3EvYY/pax
 zo1mQB5+Piju0/ZS6Dsabm231OrnvJd1v7Bhx/guXrmpY/wj/U7U42DQF2z7j6/sLFGk
 RrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqRyGd0455xnYV+ej3YKYfEEuKIBINqSThZM2ypmzk7cLc1xs7bhtzYzzSkX/X2NhJdJ/RW4OdE9k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbHFaQqk/ZjEqV8POUcBW4lfAJbsG1Ys8kn9VXXEX6+OQyQ1WC
 ij1aiEAcb8rxxZ1OHyisQBvkioUdppWK9LqTvgz699kinj9snBFlM+q07KfEGuY1bv9BTe4nTNq
 3aUBZHToukTd7gpq9Hwok3Coo8Z1mBEtplis8Iyk7
X-Gm-Gg: ATEYQzxEcs2kch4bLPjBO5SwHoGgeD4sKAKdNDl9IDXIAzfksULpRbHJY4tJPQRUI/N
 Ny80lbOIXlg8UaNnnv/3tJJqD1LgHbpACQNdLQbqGOvVGIliKeL/GMNNXhxtpmdvttavbwkn8F7
 VdeGg9AIlhstyjroB2A4zU9WHCpvP8MIJdYBBrFSahjejEE8cH9d4anSd54VooiBF9FR241Aqip
 FU83OimBY3kvzATaxlvbd3iKLsuLlDu7rnIrfphcH3oOUlbNRM3zEQS3Tsciir/SQr6zzZle0Ma
 RkZloh1DneRXnvCp/YWZukSsxzJ4+rOqqW4uf0k=
X-Received: by 2002:a05:622a:a94a:20b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50b8221e273mr1541411cf.12.1774377147169; Tue, 24 Mar 2026
 11:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com> <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca>
 <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
 <20260324175717.GE8437@ziepe.ca>
In-Reply-To: <20260324175717.GE8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 18:32:16 +0000
X-Gm-Features: AQROBzDqJGwLGVWhhqLuGOrSUtCUROoHSgJZU7HhysiSVnX9qJjxIyI0nzG2rDw
Message-ID: <CAFgf54pB1pikjtx588khBAXDg4vHne+tJL6gBqF64buX0K93mQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
 linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, 
 ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
 suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
 john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
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

On Tue, Mar 24, 2026 at 5:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Mar 24, 2026 at 05:36:23PM +0000, Mostafa Saleh wrote:
> > But it's not about drivers in that case, it's about many places
> > (SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
> > ownership so in some cases they step on each other's toes, and I don't
> > think that will get simpler with yet another caller in this series
>
> I don't understand how this can be, ownership is clear. SWIOTLB owns
> the buffer, dma alloc coherent owns the buffer, user owns the
> buffer. There should be no other cases, and they don't step on each
> other unless the APIs are being used wrong.
>

Logically, that's the case, but the DMA-direct code currently loses
this information and assumes it can encrypt/decrypt any memory even
the SWIOTLB one.
That's what I am fixing in my series. When I respin, I can try to
introduce some more helpers around that to make it easier to integrate
new cases.

Thanks,
Mostafa

> > I am fine with the API design you mentioned, but I believe that it
> > needs clear documentation specifying who is responsible for
> > decryption. The code should provide wrappers checking for these cases
> > instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
> > everywhere in DMA-direct.
>
> Redoingt how dma-api works internally is some other project... It
> would be nice if swiotlb would sort of recursively DMA map using the
> new flag instead of open coding it but that is pretty minor.
>
> Jason
