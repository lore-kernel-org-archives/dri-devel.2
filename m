Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA158F9D0D0
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2805010E59E;
	Tue, 14 Apr 2026 13:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjsh8qHT";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C1310E4AF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:45:56 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c373ee97fso432424c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 06:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174355; cv=none;
 d=google.com; s=arc-20240605;
 b=Jn8Sc6IxAc+2x0WU/IK9DxvmnruUHBrHx6d7E00Ku1eSAvAKgd1QsD3UP7qKRBcu7W
 qjOEt1S3XLsUQKuJWvDhqz028I0YvRDBbU/U+uYXek924kpOh3F50Y3ZmT13k2XAZvyV
 I9+Zn88XVIj+K1ASb0p/f/1CpRbVjG2Kg41CGsoaz3Ptnkk5oelD7kyhpA7UhlOVuN9k
 BXixADZdUv5HwxqLiJgCExPBZ0QlycX+XTF8aiSiKJ73y9JYJM4puA9Tmr1A5/X+A1iN
 4zbW+jYLlmg+IbYhCTQckn7LqIRTOrEcNXjcyE7d44rEtN9Espgv6GyosxXYSb9D3t8I
 xLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 fh=sgKzRcxP8toWnjTX0k0gWBZ0QvAW9fTXORFVsMVTmJY=;
 b=jOjXUU8ES7t3PyM/Uh0zGvHM/mB1HE01x+F59GThRtNmYz5tiHIA3nw1lDSakceIHQ
 yxF6C025rXESNp13I0xD08CupoMTv8AyvnZC81g4x58BAVXfZKnBofsPIqH8SX1uLXvb
 Q9QY3wv6CbnXhv3KPFUwoDr3HnOhukhu54pvt0apDCPhPSktHfFGBSeWCICc9/W3HMBb
 aXkVStb8sSfD/5u70UxmBhoa+PQ22T4jdV7LL0QWWh0xVS51NrbOwMhAT5HuUoY6a0cC
 gRSGMn742++QQlqOYcInE1f/XLG8e1uxrHhMjg6pv/GXOiuGqK5R9zeMVTB3w0z3/FTG
 VCbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776174355; x=1776779155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 b=cjsh8qHT+NL1kQ5dXAYfBsabNAstj+k1aIQlJJF/P1sDkpRtFCvJAsfem40hhZRHzX
 iAOhNHPhJutnHwouko2qUtqVLntiiD14cHPbp9ltPfTXjT+1+dqX+AVjjUS8Z+E8mRms
 yraQyKVXiQXTwf756c1poZxoJOXuj/OuyCvnQCZ8Q2Sy2WBVNNqsLsVBOtKEoN0Q7VgM
 hsBTg6Oz7+UW7XGsvokhwoTPoNWV3KVRVGPl6477tLPRojhTOZbdVDdrRivUkUMxRPLd
 oyREoo5L3EFjqLzu7dv9H8zAfs9ispZjn9LbYv2oiwfaGz2i75sUsTkDJdj8iCKEHDtZ
 1NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174355; x=1776779155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 b=H+8iFeqG1+iFGLOU1xHi2QzMImt2D67veACoWoMJ2mkEul46k73wRjdEsGqsfifUcD
 4fteD/8vaQDQ14yRcFlBe2q742wX1b/axiaPaDt10PSTr61rmLncnBLmulmek+RHfvZc
 BkmirgWE4oXuVF/yVbCi7Om91v0X/tw9GqwyJxb3SzNSHsBG32BZYsiC0MtVrebazBBY
 K52bOWl+gIHbsKBsCWpUWQECk3pln19GqPkqEoWbgcFznEipEfPjSCwR+807i2CoFbz3
 rFyhxh5mSW19ivUxLJZ1jDYVsRPvLNlUXLrs7QlKnk1nvpFCPDr9vYdINprMYD0ZALdk
 Mj5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h01qAwUPw6stBzvqE40UlfMCygQcI/9UACYHm9KKurB4HRYCvwggz8nX8gPL0TaV32it/kTuIIT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgwtjkTbnmece9aqGoast+uVzQZ1A8mlUn/LOLs6EjClXpbAuP
 QgB59Y2d94h7Pmxqh1li4GQHWjxHzq3W094JxVAA8zvngRPXdv7LGVem7b6662FD4Xcyl40vVDg
 pyqz61jwozd28dObqY3xihEads/K6CKs=
X-Gm-Gg: AeBDies09O5UsdooMJ920I5SoM+yVxVmuyuxl8NBenNpEP/cQyj6m+7NGsVocoFEP8G
 hpZSM6z67ImBGWoMHGw6S/cKaqMv7FRSfZSWhdz7p11EXmIvdx6uWY2rCaa9uzYLxR9RxUe/kP0
 UvymT6CLTqEEuNbWQB2iLCCMTqFYrWTZst0CpYgN3cdKzO/H+9uNdeFegqOXwZX7FuomNOWdB3D
 Dy4LZdJ7rGheLXNiCkVRnRjwzBq6ghrJbF6ATsyTaDdiPHdyDwi8xHEO31nt6AozYJYx+/P6lEq
 Bnw76peHTuEhrC207tIIu6ttKPPlQhoJGm85gSNwKSS9AnzH34J+etwzpzuMrj8f8G/MjxLWLG1
 RXDpl
X-Received: by 2002:a05:7301:fa0b:b0:2c7:2cac:814c with SMTP id
 5a478bee46e88-2d58979bc41mr3694192eec.3.1776174355323; Tue, 14 Apr 2026
 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260406225008.2787532-2-werner@verivus.com>
 <20260414050840.244705-1-werner@verivus.com>
 <8892f093-a98b-481e-b01e-4e640d2edc54@amd.com>
 <20260414094721.459068-1-werner@verivus.com>
In-Reply-To: <20260414094721.459068-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:45:43 -0400
X-Gm-Features: AQROBzCrernNciiyxTUg584Ae9KLnD-_2RN0ZVtAyto5bBcJMjMxlTeTPH8_8EY
Message-ID: <CADnq5_Mq2SVsLd1=Ax1285UyEbwybbCeeKXxt4Xy6e7hKX3TAA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Applied thanks!

Alex

On Tue, Apr 14, 2026 at 9:06=E2=80=AFAM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> On Tue, Apr 14, 2026 at 11:26 AM, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
> > The patch looks valid to me, but I think we can drop this CC: stable.
> >
> > Since dump buffers are a kernel only interface the fix has no practical
> > relevance and is only of cosmetic nature.
>
> Ack, please drop it at apply time.
>
> Werner
