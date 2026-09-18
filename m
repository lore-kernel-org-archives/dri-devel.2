Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0DC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CB010E443;
	Mon, 21 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHTuh+yU";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91A110E165
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:23:18 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-91235f46716so12123366d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789766598; cv=none;
 d=google.com; s=arc-20260327;
 b=mxL5X5oT1V8PWQr582vXAsPune+itE5CMcMjOZURnY4LdlGq1JuXQeN3l/RqDB1UO7
 vGeXhPF6lOYoY66Rh7G7s27gC3FVMgwtOAoa8NWcXSXElbb2q20IpcUwLGOaFZHb8qpz
 xQZlSAIwYGesl2WOxJNKYqfg39WxWqhsffxs8N9HBJHLUjVXslrDpPIjKI2jghEs5hBU
 2YZNAkBpQgmxSeN09p9PrsH1IFaLk8/Pf/YflUU+4MI5WqFgMifYQ+3M+vGhDtdtu79M
 nC8Cm/bxi/A7VVMAoSq4ppROro5/ArJPa2kbMHfgYW/oOwtrFRaQTolwc7w4XoP2zhm9
 Q3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0eXnGz0srvrxX++zhKhQ4P/04p9aKnhwE4Xq1r2tq1s=;
 fh=YgfmYqJ4JO5OhX8p/g9VUA62+eBu09SKBXT/kcyJDT4=;
 b=Yyw2bsPTED8aOckz4ZIT6S901rvxkrOCGB1YmQChfHIqoaD8L/j2d7HbiOIWTAhcPo
 YKlngeSuuFKS4Sd2NVZ/7X3zM+FUschXlpfJ8Q6t8e4lbMOD8P2F/tdhTqmjhFjeF+R2
 o+RGBzKZi/YXy8ups5b+cEKJGak6lMNom6IKWpBo0CdyoZnz+DlKMTjuXgFSljvn3oCN
 0vycqBIi2w12UaGFBU8dMh/dtt2k4dHVSCYztmsVtL+PwNmR1kH89L02H1x8592MWtgl
 4HZAZdufKuVqSQ79V/ZYi9RFfVIngIPbnDuWaOu7KB3OZCwoXOgZ0Zm2b7hkJdGuWV5Q
 pLdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789766598; x=1790371398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0eXnGz0srvrxX++zhKhQ4P/04p9aKnhwE4Xq1r2tq1s=;
 b=MHTuh+yUkZUCCnsjU46IGoAScA1JAN+/zNSurZ/be/DtezYiVCPbQ+fRoMLZlOj/zP
 oxT16sYNnujaX13cZRviUz489PdulHhbgbJt6U+GKRYvaMHCFQzhS/H1msC713d644lO
 269HnbAefpzKRX5BTIea3Lwqw/M93lwbALUFCpkcMEEi6xrL953svD+78wh2VgzQ4N5h
 FRSyCEC8B++IpE/ao1PIzLVJBpZxTdYllLcBWwgKw7wjTnl1aa7ohPqb9xWmpKBOS9WM
 WmkhqH2QMo40Wwgz4LlRhW9ixf8I2qdqenU+1RCclR0d0vBoDNxTAl4xmyzVn1oINhtc
 m5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789766598; x=1790371398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0eXnGz0srvrxX++zhKhQ4P/04p9aKnhwE4Xq1r2tq1s=;
 b=bmmTaORGdI/qMkUt6NGjUiVFbb99IlH0ZoNcdjedkPYYb9UpFHTv1pMNRjlA6+/9Dq
 +iHoF6zgDyE3+f6/UowTX3rQ/YwRJvJGUyhIkMC48dQMv1DFRDluuLMR7WAE9CMIS6Fx
 uscbhjALWmxwhElVkjxyCzJxvBnDw3zrvKvHBit7OyrN8MRN+mZ2P/OgWPQ4ZXezvi0X
 TAvHvvQlSep0xGLqobb6h5rk3p3PwhTrizb7ZxcteODPRPQd39jIt8VoruWjLDdILpMk
 VWuIsPey1hFxXZ1Ilr7NEqym1nP6Qkbqdma71Wr2qI24n2Mdk920aZSo60KixcjU+EFh
 gVig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZI1QsASK04zW0F6FCnnRmTnydB1DP/AvALuTaRSKxJ7BBAe+8U3hUhXkZpq2O4tjWWOUZjDiaINE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kG47UM21uCWSAyhvERpkG5pZFgtMo3JP+7Wn2KwI0mmOhOeEhM
 Kkx0WEZcEjjT1SrjeiXkP5EdT6/FrIuaXaMEW7gwuRLvk/09gz9lJdzdvWeBq4hmxU2wa7+7zW8
 EO5nzByYPEPf04X8ArAHHm+EPnhnsPF4=
X-Gm-Gg: AYBFou3ecI6Yc1A4kVYZxttn9Hf+qNgnYlnE1wNfBVW1O0IQoF275dQYTfU/mq/1D3D
 1B6AV4Y2cs2oZYdkNoIa9BZkY1U2HWHCkFhVDU+L2PyT8g2m3AYwzm8UTeDa2k7lZeMPWkYCmfL
 jLGI+kBfnQROJJ/UoR0wj9V6qUWfZWkkMp/j8HyUhti9syNmdqZxNkSq9YfhOFMaaUlG1ETO2f7
 BlfiP3A4pmKHrzL5x0MRZTR7a/P11fNxfdBXVYZaVNyl3i4KcINX2eVkUCHmT1BajoeDc2sXUyk
 pIkUdT3FMu1exIwpPrSlmZEfiOl/G9XqJ/HdT7/Y1oqoQLlYyAAHMN6GgXpDwUfRvPkr6g/9Spt
 KUqZRvTvjsZNv
X-Received: by 2002:a05:6214:2dc3:b0:910:6f61:f912 with SMTP id
 6a1803df08f44-91254c9b0e0mr63870416d6.33.1789766597608; Fri, 18 Sep 2026
 14:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
 <ac19e380-e93d-470d-841c-7bd3f2b0b86a@broadcom.com>
 <CAEcBvW0+SqM2zHbaDS+JycXxc-ztzvixKtHVSVQby9viVH=+eA@mail.gmail.com>
In-Reply-To: <CAEcBvW0+SqM2zHbaDS+JycXxc-ztzvixKtHVSVQby9viVH=+eA@mail.gmail.com>
From: Claire DuSoleil <claire.m.dusoleil@gmail.com>
Date: Fri, 18 Sep 2026 14:23:05 -0700
X-Gm-Features: AcwNN1X5eSKW7ajEZ6zTzJv5nQKV6x4J3x4seSYzTJNYYKKJqhIyS9cqM98ziC4
Message-ID: <CAEcBvW10sKwD2+Ro6o8Fq_9oLwsedq405f=gjQ+OMbY72=+VFA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

I had Claude Code generate this patch so I could run Omarchy in a
VMWare virtual machine.  Without the fix, all I see is black screen.
It is currently working but I have to re-apply the patch after every
Omarchy system update.

Claude originally identified the issue as a Hyprland bug but after
further digging, it's really in vmwgfx.  However Mesa has coded around
it and I also had a Hyprland fix that worked as well.  It seemed the
best place to fix it was vmwgfx.

Claire

On Fri, Sep 18, 2026 at 2:17=E2=80=AFPM Claire DuSoleil
<claire.m.dusoleil@gmail.com> wrote:
>
> I had Claude Code generate this patch so I could run Omarchy in a VMWare =
virtual machine.  Without the fix, all I see is black screen.  It is curren=
tly working but I have to re-apply the patch after every Omarchy system upd=
ate.
>
> Claude originally identified the issue as a Hyprland bug but after furthe=
r digging, it's really in vmwgfx.  However Mesa has coded around it and I a=
lso had a Hyprland fix that worked as well.  It seemed the best place to fi=
x it was vmwgfx.
>
> I thought the patch had already been rejected so I do not understand why =
anyone is still looking at it, especially since this has been a known probl=
em for many years.
>
> Claire
>
> On Fri, Sep 18, 2026 at 1:56=E2=80=AFPM Maaz Mombasawala <maaz.mombasawal=
a@broadcom.com> wrote:
>>
>> Hi,
>> This looks llm generated, can you disclose the llm that you have used?
>>
>> As for the patch itself, it is too overly verbose for human review.
>> Could you just describe the issue you were facing and what is the fix yo=
u have done?
>> Describing the current behaviour and the overly narrative style is not n=
ecessary.
>>
>> --
>> Maaz Mombasawala <maaz.mombasawala@broadcom.com>
