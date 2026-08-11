Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B494C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5D410E2C9;
	Tue, 11 Aug 2026 15:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="dtJtRIgs";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3F510E2C9
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:24:00 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso915495ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461840; cv=none;
 d=google.com; s=arc-20260327;
 b=kxciGBUcQsVfGg1josDkSeTMsJQs2c+FjHxjCHbBBmXHidS/mpYpmt90z2KhkISaY2
 kFHIFI2XmMMcelCwfF1HpUKD7ggClaCaBmUfM/IfFvgkaiOGuT5xZBPD4+Pt1iy0GFtu
 lkMkZxL/jle304GKAnqj4TmkNJ43whnOHDNfARJFarjKB7SYxL/abMyASbdOTN5WM9Sx
 3tBVOjO1M75MPLk4p4FICCwlWjfVR7U4p37leBeHmg8UIxkA2fmAjvq3zyOMcSHesar/
 pfNDSBvWWHhKuDXroHkVLQmxGQnhYhBO9ZeioTOvpPoJ7iqnwvrnJ5+MP6kIJsekEC1o
 7YrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 fh=SWzFFb8QQK2lxRLu823Iqhuc7tx4bplVxofZe3g2qT0=;
 b=CP0TYNWYcp4iJUnV37mAEUDOvig7TOEq0KulmOtHR3TyYSIv/Eem6+mqOKXM2Sc0Jc
 1J05vYCPFzPg1JKp9Qfys9zlw2OWWjXRB0Gvl6Rsx0TsZ91S0jGLw0uSIQosLHrDssSf
 glSDU3t3FL0n3oPsdOyZapYwPCuW22JpJgN2LRHpSCQmlRDjCMElrKY04hYLTfrNMytG
 c+5aHfeYdFIfBFlSgDbg+LEkT3QYTog8pYBJHQDNx77xCExu/8cPlZ4jvYGy0L56IVta
 KliFS23GQTdn1QaUiulkh0zhjaX1Z3Nrv40HcesYgPu9KzB8uFRB0Q+ORHnY+kBomCu2
 KXJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786461840; x=1787066640;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 b=dtJtRIgsDQcVVEO7a5MSvnArg+lQV+BQb2dezL10wMS+s+eQVm8x98kBU5WGbUsb9Y
 X0kPaXRR8tgGRe4tbYivIfi9ACyT+h7U6b9lnbBwKIHFZrTfvb06Ko4ICeTIXzPvISfE
 olUX9mrSgx/sQK6u1ssIxFxjj+7DeEq4hUU1gCXPEkQGoifGvqCVtBaQNe2InrEjSnfU
 VVvRijQDAw/TVzVfKSurQbYAM4i8+/GpBSP/nt7ECkTMauFzA5GxUraEdSwxmU2oJMWO
 UpTJG/g1yhl0QsI1SFMx9NmK0tG7uwDE6xdsuLs60nQj9tZNaAsQPrj2helHjZ0bVJw9
 nZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461840; x=1787066640;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 b=g+7YtLZOJdYY1xivoAHv6nfpcQJDvhxE2IAleU8Fr5vsiSKRUaNAzzvE8OFbCuPgj5
 XPlkDlW1ESmwrvrk+rQt1mJcIUred/xi/lA4JiFhvmidJIQqcGFWAtREOKeIEZEjCwZR
 P5xdd5w0bMNtgaLqkyrUym9txQL9UeyAn0RqGsrFWo/ojPDlriT4Be86Bs/eIw5MUwt5
 24Sa7XGgoSx4JAuUNRUNZvWyT/+i24kYJkPr0lDmT3IqOoBLMlhylBA3TljdKaCMbf2x
 JqKDKd5rRLXd1a8l959dpx5uQ4uULpLhwJGtOhBhxNdZIBvtKvPbFKywsToTHOWlQ9ic
 nWNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpykzfetOF7nDYhxKBN6tPTPd887S+whwyelvDuCgCgUn2t8drcVxZwJW+NbRjKFZ4zORgrkDBcHqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3KTxohDlAz8dVkk6KEUtpZpkjfLWtV5JzEsv6ZDfJTFSKcIzB
 3Os3VZJpZTYw/O2zgATiOsAd1WZxxYk3mDGtxYvQeQML+Gs1Q/MtmqmRdKZN5y+qmlsqqqp/x7/
 v1m1GRG9SO5jQ3+uKQ+j7TZ5JL06aOVlZl8sVzyJzyw==
X-Gm-Gg: AR+sD10UA0NDjX6cHVPHbTho/HCLlueEEd0BKm63jjLztTZIBv2dozTBl5guMwz50j+
 BzNVTHeyBuxFF+363w4o9/BZ0nuQsUvXnCg76XAelCKep2ULuCnbOq6DTAuw2f62YYGdDMHm7xx
 JGHQLAlNl9g0sW5Ie1ac8OVJiaD0X2G0B4KjbftNpvS4gXwtAhipU6PYXjCFGXhfzQNHeCXXS75
 /CEJoLVia0/GHHLzgTKKMmuk9biA/BlaS3CFtCCJL7kI/EOzAQcNNhqBg9EaQjeCVGTxbdQ7RCq
 aQJS6M0BlUfM58iOtK5bDi9Tx2IuGVlfuDmEbCwi2Q==
X-Received: by 2002:a17:903:2405:b0:2c9:c991:6ed3 with SMTP id
 d9443c01a7336-2d3178c8ad7mr53856565ad.12.1786461839554; Tue, 11 Aug 2026
 08:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 11 Aug 2026 16:23:48 +0100
X-Gm-Features: AUfX_mzW4vpKvpSLOTXQ7G_2xDxw4RcITaclPpwkDi_AI9CwVUZdC4ZfVyrenos
Message-ID: <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Derek Foreman <derek.foreman@collabora.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
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

Hi,

On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
> On 8/10/26 7:39 PM, Fangzhi Zuo wrote:
> > +             /*
> > +              * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> > +              * advertises ALLM in the SCDS and the content type is Game.
> > +              * Setting content-type = Game is how userspace requests the
> > +              * Sink's low-latency mode (HDMI GCTS HF1-56).
> > +              */

Is it mandatory for the source to set ALLM when the sink advertises
ALLM support, and content-type == game?

Is it allowable for the source to set ALLM when the sink advertises
ALLM support, and content-type != game?

> > +     /*
> > +      * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
> > +      * advertises ALLM in the SCDS and either the content type is Game
> > +      * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
> > +      * HDMI 2.1 7.6.6.
> > +      */

Is it mandatory for the source to set ALLM when the sink advertises
ALLM support, and game-VRR is active?

Is it allowable for the source to set ALLM when the sink advertises
ALLM support, and non-game-VRR is active?

> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> doesn't mean we're playing a game. We might be using it to play back
> judder free video (where we'd like ALLM off to preserve the sink's image
> enhancement), or we might be at the desktop.
>
> I'd imagine some users would still want their sink to use all the image
> enhancements they saw in the showroom even when playing a game, so I'm
> not sure any kind of "auto" decision making in the kernel makes sense at
> all, even based on content type. It's a very subjective trade-off.
>
> To me, this seems like something a compositor would want control of with
> a simple boolean property.

I strongly agree. I really don't want to see more magic implicit
semantics unless they're completely necessary for some reason.

Someone passed on second-hand that one of the reasons to do this was
to make it easier to support X11 - however, if X11 needs better ALLM
control, then it can be exposed as a connector property via RandR,
just like content-type.

Cheers,
Daniel
