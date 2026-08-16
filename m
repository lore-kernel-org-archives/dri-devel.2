Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BFFC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B137910E360;
	Sun, 16 Aug 2026 20:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BM+4DQrM";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DF610E363
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:25:21 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66c70f41417so302372d50.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 13:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786911920; cv=none;
 d=google.com; s=arc-20260327;
 b=iZ/qIg1DLN2LVLyUTFYbWedbLqjtk6fBv7Q8w1xdhoBcjSHS0YbxLKBi0QP3WEg5MQ
 8zV7gyEiUOH8Bv3ApW2DVYgvXXFlLTk5nJYpVAvPsqKyTMVijdVAtBwcjgUOS9yjjosS
 CGyRvsj7rk/Ht/Tle/QTvBYRTHLaOnz0PYoRGQZaCRtJUxU3HJFY1tJfzezitOjP1rf9
 wNRr6w8k8H+uibbwYI1YI4H3YZHg6sc15OrA204gsqCKt/H4nfYFaneVzNXk8XJJ+bQt
 ANjLN2/SV3z5llhTOj+237E2wiWkZ0UpPBkz7yrIrAmcFf6FIVY5EWH9X5ipfF/yRjuI
 v7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pG9a6R2lI8zBUJdzvIIYffn5eO9OTw8/lShO/60FBpw=;
 fh=1f8A1rvQUZaI2Eb1cu3htvmdSvuIvSMRTB0tYP6HxFY=;
 b=DwZLz9BWVkLsAAqu9WkbfPD/w7PQXklUXRXPI+r1uz4GTN7xKXmRUlxVtzH4UoGN4X
 OZ0Ga1odKT6m8zI3Htn0Gh8x/zWca/sivPO4pOoM5baKoKXWd6CjiDC52H5CbrNae7f6
 B7jwGfIgiaP4UJvo2YXiv+9YefPSMNl6PUhIS1VVEf6HJUo8sHjn6B/mwC7Jip3ZWI9p
 Q+rz7gGYGevaPclbSAPU3Kcxupeg1n/xqAn5qNqide5AX/Vn+P3xA+Fq5GWxTgbxleQh
 62964ntkpgxayDRRTWFsqbrkpuM9teXB75ZQGcNywF6AH8rm/V1ODU1TxUvvqx5l3ZLK
 F0LA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786911920; x=1787516720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pG9a6R2lI8zBUJdzvIIYffn5eO9OTw8/lShO/60FBpw=;
 b=BM+4DQrM+7RBvLkTAZQqxODWltKu0qX6kcAFUCtTD8bjjY8I1KIUmpFGCt7iAB6ukR
 WN10z9c5bipev6i+ENswfDLl0iS5WYcWPhtRPpsjrVc9Y7ageldkVPR+APldK9FtVpDI
 s+KBEG9tkxePDFJnYLG2bLFDe0dJkqiqMQt8lPa2Ophdirckn8eBchoyyAWvdVdOAOVc
 IZ8n2tC8GwRWySfOtw1yGhw2y9C6UJQ4DEqiZtaS/Z/1aG1WeGbgnYePxCi6/I8cts66
 kP9c2+FhOjdzy5nFri0b3ZHJ9p+gmKcF8ANKW/h0Xg94btQ+dbQ+oWrsEsm3EzPpcEhl
 FWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786911920; x=1787516720;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pG9a6R2lI8zBUJdzvIIYffn5eO9OTw8/lShO/60FBpw=;
 b=GRqQVmSpmUdbpYE4WD4hyWyxwp/j5I0jPaj9MkGexyQ7Eu/m6/QVA0s+wmOlUjSZs2
 DSllrTuuH8uSNKOGv7MJdiyXIf9zyLbjJd2Lv/WyLPdW0sEExaH1X3XR1K4pCAgCaW5P
 ZBaZdGeZjBe5opTrHtrYopIhckGc4o1DnEM13jrU9XKLobmqPfb91eq2u+ruK3L1OaaX
 H321oP9bXY7XZzVwaeBqnVsqxytEBwvA4HAmmMKxq3qNkM0IvXpe3CBXnDJU+SB2qN2o
 srLVjc4Rk2GloLcD+O99n/iXpA5nTM/W6dDoukIv0x4C6n647NjebxnuwRISje8G7dB+
 RsMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/ZwWHXbtnRixJ8anwV+B1KYZDPojiwucM2lPDlzFed6wjfY/5O8GulFUba4f+dTlZRiit6NZw5sU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTtj2kxKxASJmfCXXkeFZGmOmhxy/M0yV6JfZBljBPtdboxtp0
 iYhVJdBhH/kNLOmjH4JdtI7OA4X9LFsUz3ohIakvhe3T+UFRIXK+sk38+9w/fAJa/zJsnB6q/zT
 H70InyOp0XUbtWYNNP1e2ZMJyZWz1W6A=
X-Gm-Gg: AR+sD11eSE7rXzqpNGnAQ8wTHzAlXBp54rykfOO1HTof52wqRtQ3qCZIM2IzmE1J1oJ
 +W/3yn5HMb5H0/qIuhVONNCTMqhcvlexkSQ6gpOVaJQBS65M89Uaw8jMyjtnDoT0JKqX/xHa2Ji
 rRb3JPS5ADRHjEp9letgVgTi1Fj/bn47mpL7sZ56m45K2RNGpK5PwU3LYd8x5oYO3/IO9Hk/DbW
 F5ZTU0leYDNXOj/Fc6+CvoMWYRMdtcMJF89gk4oDkAEKdDlMremauajspMIQX2Q24tcFX8d1n9f
 3J/uxjCGfL7rYC323V4+7SseBFHQ5qdlxUeH16F3kNjn+e7Vn/tayDN28JfKx4dIT1Z6L1VEHRq
 v
X-Received: by 2002:a05:690c:6d89:b0:820:100e:1abb with SMTP id
 00721157ae682-83713764b12mr81554827b3.4.1786911920200; Sun, 16 Aug 2026
 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEWPSH54fhzKEYR1cgTskNgKryDEMaZOY1y5aFdKQQyzfKbYfg@mail.gmail.com>
 <20260816195837.497735-1-gahing@gahingwoo.com>
In-Reply-To: <20260816195837.497735-1-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Sun, 16 Aug 2026 22:25:07 +0200
X-Gm-Features: AcwNN1Wl390p4y87UVjUoqPILRXDJMOlLHfhAU7h4LLl0DQ3-Pk8Q_Wr5x1SlpE
Message-ID: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com, 
 alchark@flipper.net, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

Hi Jiaxing,

Your conv2d-cal result made me curious whether the clamp is a property of
the RKNN output stage in general, so I built the same shape here: 1x1
conv, 64 input channels, 8x8 surface, uint8, out_zp 128, no fused
activation - and compared against both references. On RK3588 the answer
is the opposite of yours.

  output channels    vs raw CPU              vs max(cpu, out_zp)
   56                56 of 56 (47 exact)      0 of 56
  128               128 of 128 (113 exact)    6 of 128

Maxdiff against the raw reference is 1 in both cases; against the clamped
reference it is 128. Where the raw reference falls below the zero point,
the hardware output spans 0..127 rather than sitting at 128, and only
0.6-0.8% of hardware values land exactly on the zero point, which is
about what the distribution gives you by chance.

So RK3588 does not clamp at the output zero point, and the clamp you are
seeing is not something the DPU output stage does everywhere. That is one
more thing it is not, and I think it is the expensive one to rule out by
inspection.

Three controls, since a "hardware equals CPU" result is exactly what a
silent delegate fallback would also produce:

  - the per-core NPU interrupt counters advance by one per run, so the
    job did reach the hardware
  - 15 of the 128 channels differ from the CPU by one, which a CPU
    fallback could not produce - it would be bit-identical
  - 46% (oc=3D128) and 59% (oc=3D56) of the raw reference lies below the ze=
ro
    point, so there was something for a clamp to remove

One thing I cannot tell from here: whether the difference is the silicon
or the userspace path. My runs are upstream Mesa main with no RK3576
patches, and yours are your working tree, so the two differ in more than
the SoC. If you still have the RK3576 board on a stock upstream Mesa, the
same shape there would separate those two explanations - and if it turns
out to be userspace rather than silicon, that is a much easier bug to
find than a hardware one.

Yes to the 88 and 120 sweep on RK3576, and thank you for offering it. If
the toggle follows the same rule at those counts I can re-run the RK3588
side with the forced constant for symmetry, so we would have both forms
on both SoCs at four channel counts.

Best regards,
Igor


On Sun, Aug 16, 2026 at 9:58=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Hi Igor,
>
> You are right that it is fitted, and decoding it against registers.xml wa=
s
> worth more than the fit was. I had been treating those two words as opaqu=
e
> constants and comparing predicates, when the thing that varies is one bit=
.
>
> Your reading also named an experiment I had never run. Every measurement =
this
> board has produced was of the value my predicate happens to emit, so 16 a=
nd 41
> output channels had only ever run with SIZE_E_2 0, and 56, 64 and 128 onl=
y with
> 1. The cell nobody had filled in was SIZE_E_2 1 at the small counts. Forc=
ing
> the constant fills it.
>
>   output channels    predicate     forced SIZE_E_2 1
>    16                16 of 16      NPU job timed out, 0 of 16
>    41                41 of 41      0 of 41
>    56                56 of 56      56 of 56
>   128              128 of 128    128 of 128
>
> So each form fails on the shapes the other handles, which makes it a two =
sided
> measurement rather than the one sided fit it started as. Taken with your =
RK3588
> result, RK3588 does not need the toggle and RK3576 does, and what the tog=
gle
> selects is SIZE_E_2 rather than anything about the channel count as such.=
 I
> will write it that way, as the field with a reason, rather than as a modu=
lo or
> a parity of something.
>
> The other bits you flagged I cannot defend yet. RGP_CNTER 8, OW_SRC 1 and=
 the
> two in the reserved range came from vendor captures and have never been v=
aried
> one at a time. That is a sweep this board can run and I will do it before=
 the
> Mesa series goes out, since a value nobody can explain is a value nobody =
should
> be asked to review.
>
> On the unclamped reference, thank you for using it. It changed what I tho=
ught I
> had here as well. The clamp is only free where the quantised output range
> starts at zero, and on a middle zero point layer it rewrites about half t=
he
> surface. conv2d-cal is out_zp 128 with no fused activation, and against t=
he
> unclamped output it is 0 of 128 channels rather than 128 of 128, with the
> hardware equal to max(cpu, out_zp) to within one everywhere. Where that c=
lamp
> comes from is still open. It is not the output offset, not the BS block, =
not
> any register in the stream, and not the coefficient records, all four mea=
sured
> rather than argued.
>
> If you want another shape, an output channel count of 88 or 120 on RK3576=
 would
> tell us whether the toggle follows the same rule up there, and those are =
exactly
> the counts you already have on the other SoC.
>
> Jiaxing
