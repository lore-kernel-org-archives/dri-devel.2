Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E4BCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 15:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AC410E4EF;
	Tue, 12 May 2026 15:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T/Irb1Mn";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6F010E39F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:16:16 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so1145771a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1778598975; x=1779203775;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehW8NIZ95zVpPEuSxrNan65JxyLG2SeDMLVmVAp6lJI=;
 b=T/Irb1MnxAdC941+m487KZU0A8siGhFcV1qjm00fTdMtQAHe1zLVe1+hb2xAGUp0g6
 W/62gSehtmdgTA56g9gHGt5R5cSqHa8vIC/hvXslNvjQrD+TRnYzvqL3HMp1MKRj4ozN
 VMjKefgu65xWLZOoiRloLDIVzCnhppWvZDEPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598975; x=1779203775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehW8NIZ95zVpPEuSxrNan65JxyLG2SeDMLVmVAp6lJI=;
 b=IUb5L57coi6co2Yb9pj9wluA4FeCp4IN44fy1RWJ0cSEsHYbr8Q2yyj/aw5TxoZ0zb
 a2vOFXSbKkII8Lnc49Rey77w3TwZfBr8uNflohlK8j8UaAJz5nJ6vwWsUlStwfnxsTTv
 9IkUDkyVKs+XHOT5JSub6fhzYoHp2iANoFJZsKduuiSuG/7djXNC0WkQDmHwawS9HdPy
 a9sEnpbjgjUnnoCp7PMgG/5tQ+FOd/JOIAs9Eg/pZx310xWuoF1J4HnbiBRhRaBZDagN
 FGyZJB3NgwsgjM+oRO8FQk3O2E8lp1bzC+mrgURGZRAcx03xTftlvDIbNhli0OUrRMhn
 v92w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u+a642zUuy1U8OFxfTxis5K0fegr4jc6X+d2sXytdcbstNC0KRCvcEI33pmd2xkZqIFwzEEwBU00=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzub2K9DygI972s3HihXDSJq5PCEzAKaE1qplrcMcXeP0iDczvc
 2WsVNOG6XIrlbZ3lvnSVmpIjt0fUTUzyiyNx0Ena/E2+kES9alodzGafjoBb+69fv/QuJXOFRdl
 nl2MEqM8=
X-Gm-Gg: Acq92OE7+KBifssTEJeynMejrhKLYwIHtahnViRRPTD1Yp90g6eWGUMldP81gpL3UPs
 QrUNjVD4ZFgvZbmQu/AHUnEZ4UEiIlgWTl8XafEwzSnZP+GNZ6v6xLge+pS0cZ6FKWRxv0PwFxZ
 jyiR8dFTWsednmVn9CXKCO7xuKZtyzUfEq4iwy+wxo+dnYL7AwbJ4YyLcvHa2Ne9Sc7prbgkj5z
 FUd/gNxfWSqKaus3WtB0LR3YHghIP4g6EmKjlnn75uTCxlE/AeMRA0sO6/jjxqWDRXEH9KB+YQl
 8oe3Tx7xVVtXUf+63G/r4BYmburMEvTHi7/kZuUStyHLCWHTTQRETKpwLAcFpTv0R4epFo0F4K9
 w0z0xrwwYU8WqphoSO/4usxiq6klLsnoVPIXMdAoGjvzoKE23l5SCkQDgL+8N+C+igRm/VXWpJW
 4VgUKuL4XuA6pUIAcpOpYBkgOv5Bnw84CljEZjpxxdyRWX94Cuviq7V1kQFWI4LVUo0R71cJPR
X-Received: by 2002:a17:907:7f9e:b0:bce:80db:77ef with SMTP id
 a640c23a62f3a-bce80db799fmr458664966b.43.1778598974592; 
 Tue, 12 May 2026 08:16:14 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcba5feb124sm609454566b.24.2026.05.12.08.16.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:16:13 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso3649126a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:16:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9nLEV64YDH6NLlyr14ct5Qu8uvAAV0cK4WIwOa/T+x+DUtJU6V+6D664HM2GljYlXEgo2Oi7hZF9o=@lists.freedesktop.org
X-Received: by 2002:a05:6402:324e:b0:676:6e7c:2e3b with SMTP id
 4fb4d7f45d1cf-67ef0686b85mr6869259a12.7.1778598973379; Tue, 12 May 2026
 08:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260512085848.208008-1-joonas.lahtinen@linux.intel.com>
In-Reply-To: <20260512085848.208008-1-joonas.lahtinen@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 May 2026 08:15:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKXGC=rK_pbRY9o2dkAumRakPGws0o2nfZgqbLS0vG6w@mail.gmail.com>
X-Gm-Features: AVHnY4L8EOu7cpXBXwHAgtDAE_pgj3xPVD-NmdTaVQAAt3aaqSk4wT9w9LB_eZQ
Message-ID: <CAHk-=wjKXGC=rK_pbRY9o2dkAumRakPGws0o2nfZgqbLS0vG6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "i915: don't use a vma that didn't match the
 context VM"
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Intel graphics driver community testing & development"
 <intel-gfx@lists.freedesktop.org>, 
 Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 12 May 2026 at 01:59, Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:
>
> Commit is no-op as per discussion in the linked mail thread.
> The debated UAF scenario has not been possible in mainline kernel
> since 2021.

That was never the issue.

The issue was that the code used to do this:

                if (likely(vma && vma->vm == vm))
                        vma = i915_vma_tryget(vma);

and the vma->vm == vm condition was nonsensical - and if it ever was
false, that code was all horribly buggy.

So the "since 2021" is complete nonsense.

It's only since April this year - commit a13edf9b92fc ("drm/i915/gem:
Drop check for changed VM in EXECBUF") that the "else" side is now
pointless and the revert makes sense.

Stop writing misleading commit logs and excuses for bad code. There is
no "since 2021".

                Linus
