Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B89CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D9A10F4A6;
	Tue,  2 Jun 2026 18:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqtdpdGu";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1112C10F4A6
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 18:32:35 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so9074372a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 11:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425153; cv=none;
 d=google.com; s=arc-20240605;
 b=AVIb4lSDVVAnn6LbdWjxA2AGhpROKn1vMi+bGpyWOXo/SekC/ujpmTjUbqFYHI7vkX
 tQi4EvcGboslMR/nhFPdbc3ZSptAncZ/hMSS+xglJTdv+hs1BplTrf3nE07oeLY+zsop
 2P/WNx6qTPpLElqQ+7QNHNgF2MLF453eYAoolayGujrq+A/JWQgonNSp5x8aNv2IcMsz
 FdFlzLlvGulN2B4g4GIfRWICKehkHYYeF4NNbajVcQK4+a1w+9FQxAQZXJ6eSFbaZ6tn
 +7SbPN5j9BtnQXABkH/9GoHijYCocDxLJTruxHbJkODCey46HVxYtLfSTjzSv4Pik7iU
 hzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cu+PErPTR5Ukq3l0vklbPNxm0Ku3rQpUZSHJOUi+t5o=;
 fh=2Pk80tAe43/Ss5HdRQiOIa1S3dau8mK2Rqg127XP5D0=;
 b=UWRapM+jCqVeucjnuzzTyjAF6oThWgU1qe8JFZlxtwuO0Nz2u5fEKs+NTO6/bh98Yl
 mWeKpyPb2whrKOfwARr6cjcQ8/xpqA8zABnTuyexgkC4DCQ0G5bPof00CtEfHkAYtZCU
 jaUgWfeo7pBsG8n9CuTMCCb6F60BYclUCZdlccMIFuB0yVv++ZfSLLyFQpDkyvberbef
 M2HaAnjvIKBBu0RAc61ROpdaU+vzJhj8FfpESimUKYexmTmiTKU+EhoTWSvNvJvycacG
 pF9hIFcHkyWOuTtgB6+wJ9GqtePOLYAEk1H5BigTA81xy9RLEY+YpEtsg9jToC7mvn9G
 QQNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780425153; x=1781029953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cu+PErPTR5Ukq3l0vklbPNxm0Ku3rQpUZSHJOUi+t5o=;
 b=NqtdpdGuUUtMCy2nhFn6Po0Kx3Kp7OvFjctUKr4WezH3SaM7zvthQiin37VbQlt7JH
 dSvkQ9fJOIN1PlpMBEJfLK4x7dj/x6Q7ZCF20KXXAVg1nGIXIttWwvHKsYNepq4HMTmR
 qZQuZZ8eCOAfAqgw1LArqEUdUwW4rwAqCvMHbe36IX5XsB+CClr44zQJMY1q+rw7BBSA
 0gQnA7J6LnxbEkWmOpqiG3N2qJHCpSkEWnKXy6/t2wdVDy9ZTqaMP+no4sY7FMjnTRRZ
 Mlatb2cgM7z44ym4/lql0TLkmD6hUHarMK7cVkaCilh+0i1nInYJtC1gIcgKU2Z2yCgl
 Aczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425153; x=1781029953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cu+PErPTR5Ukq3l0vklbPNxm0Ku3rQpUZSHJOUi+t5o=;
 b=GtgR4nKFa8InxQjcFQ0dVSLz5Y8C3iVoYEE3qeNfFUnYsZrrLEqTiLMEm3adm29WoM
 cBF83mXQaJOd614bFnhLso8n1ngIAi3N29vv2wVrobS9/qTAb93FMrPP2StU9HF+fz3l
 Z3DM9du8FGhxXqmZdABDUrKfAQvEpDQroA83ea/s47YE4V5TVqrx84vOKndOKN+tvq2E
 /CYHBDXBzf9SOHTAgOwIQJQy4jv9gHIES4zMSHH/Bf8hq5H5tNzINccQ5WFmzlXUFtCY
 jy3gYJjblktkHMghWM55TBt4C15F8TFOAK/Yn3OTUV304K5KV3DVv5vkcwe7/eEetuws
 brPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KR2h+/EeCEHDsGSUMD6yJM30iqX9qhXmbQU2CYlJYYYlM3ZN/JjyRTXCLwz3V0ktkPsmfx2VVaJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0LR88TfNb4SQw3n3qFfa8NOJzfq6Vi5+y4oKzf7+LqmivAhDe
 rIocE7B0+PS1NeIyb1mUF64waNjQf4z3nTKJuj54D7+SKYHH1wEC9w5TKZIlKO1iciOT/NOrn2m
 r5gP2rEfdEt+27ZRGYk3akwib96j+KHw=
X-Gm-Gg: Acq92OGXp98LEex3GMAHd9xGw7TCywXdJDEMk8FTbT7j1iNf8gbkaFOH8B3C8IOy6tK
 tESL3v+4o/RsoOJkcEWDIrIapNUWu5FMfwo9yjDvSc4NAOeCZHJzKFyAvY7whkzm+Ds4OvIdNVb
 biEC75OuWeL4rR7KGizJ3W0kFZSjzrVhhITtlSZ1dqlR2JYhWgMRsdAuhBdT68NE/vxHkpINHE+
 a3NJXYYb96xHj4Td3k5G1vwI/n5fnoEzl/TYJuN/V9g5YxUejrobTyZAWLyLJbsAWs7rQo/3JeV
 r1YyHOr6BpdUPK2PvXGsIfFNr5UsnizGWNrNbv8kV9aroZq8eTAdd3p/2SqD+M8t71E1Dvn3pzu
 I7d2z3zHD36kx72kyF09Yd0O4qKx749I7XAkT7OR2j+CKShqd8HHGJweYcyoqym+ogiwYgc57ct
 /xSqk=
X-Received: by 2002:a17:907:c817:b0:bdd:45d9:8e15 with SMTP id
 a640c23a62f3a-bf05eedf3a6mr49344966b.15.1780425153183; Tue, 02 Jun 2026
 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
 <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
 <CAOSULedF6GUK_e_3KRPB+D0Jxgtow38OjQu9B1=vG-XTfsdYOA@mail.gmail.com>
In-Reply-To: <CAOSULedF6GUK_e_3KRPB+D0Jxgtow38OjQu9B1=vG-XTfsdYOA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jun 2026 21:31:56 +0300
X-Gm-Features: AVHnY4JNBGI7LPUW-G8axQLtxVQUn2E5aZHqEdkW01oHLe8JBx5hv2aDMiWM2BQ
Message-ID: <CAHp75VdtOuLEkiuiUqxa3DT75y8Hd-1PtquodpN4qJ=rCFs_4Q@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
To: Enchanted Hunter <enchantedredhunter@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, andy@kernel.org,
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

On Tue, Jun 2, 2026 at 8:13=E2=80=AFPM Enchanted Hunter
<enchantedredhunter@gmail.com> wrote:
>
> Overall, it doesn't address any compiler warnings, but this is my first p=
atch. I wanted to start with something concrete, and I saw an unsafe functi=
on and tried to fix it. The fact that the compilation behavior won't change=
 is true, but the code will become a bit more formal =E2=80=94 maybe that's=
 a good thing.

Not sure we need a churn on the working code.

A process hint: Do not top-post.

> =D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:25, An=
dy Shevchenko <andy.shevchenko@gmail.com>:
>>
>> On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter
>> <enchantedredhunter@gmail.com> wrote:
>> >
>> > This patch replaces unsafe sprintf calls with snprintf in
>> > fbtft_register_framebuffer() to prevent potential buffer overflow.
>> >
>> > Signed-off-by: rat1bor <enchantedredhunter@gmail.com>

Another thing, use your real name and not an alias.

>> Does this change address any compiler warning or something like that?
>> At a glance I do not see any usefulness of this patch except an
>> unneeded churn.

--=20
With Best Regards,
Andy Shevchenko
