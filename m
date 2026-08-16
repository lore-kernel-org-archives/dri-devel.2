Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE2FC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 18:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887ED10E0B7;
	Sun, 16 Aug 2026 18:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRnzAgjJ";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9914A10E0B7
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 18:54:12 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-664ae043b7fso358620d50.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 11:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786906451; cv=none;
 d=google.com; s=arc-20260327;
 b=NAaEEg8Hg3/cjNq9cJmIBUHvbx2cS4GHNd4fG2Kdo6SyT1Q3ZhEq4eyGF5Z/5S7Jtu
 +vvZLw9G+KzFE3LTfS+7uxiDtV35XbnNZH4kdQesvhEHm94dkvQlAUnPIpSrP5ppKPwo
 xad9iMXPnyPUXXF7393f35guaSfZyILmPXIZNNlXFRFAkFpIVqUqga2Uco3pN37ALqwP
 fAoQ/qSkczlpRS2KM1bV7t/i83O2wkFJ3Cym1Lt0zfqvDI+7KPtuqcX8kPx+CctgUENt
 akaaul8LE2R97lXo9EM+wwoN4W3CViK0w95BsG6WGWj0nfIBQDksY/fhiYYkz/zZoIF3
 1U1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K87DdrzV6T05ieuNKPZOU2wz5knyEjMGfCEK8pz9YqE=;
 fh=eMP0ehwgb3WSRDfsq9rC1icJWZ6i5qKL2ruz4x2vKN8=;
 b=SZ1rYyfaOUWY0WU+lq7SCjI1dMj6kAG5ACumtnyzx7KcU7mJvjXba06vxg2MGg1b4+
 Cgto2imCBHWliqWNRRYbWCHTW4eWRLzEhFDDSX8SoK/fsL46Au5+MU6B4Rdx+fcU6zIr
 siAqoWsyGCw4TFnjr98Sl3xWNqVe7gvoaGwIdSxhgu98Wwm9m8SH+kVHCtcrHCMt7Rw8
 WWmtKy/PYm/py3rNCCm+THcDQgnf3S0KRY0NgstInMTtUbi5W+ExvzT2w19+zoP97ffz
 e+vohntc3JwPmQMt6Nu+cf+ZQOkDTR0neTiwVEB/3jLp/ikK982GOaRYXmCI6kyldSRC
 6ryQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786906451; x=1787511251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K87DdrzV6T05ieuNKPZOU2wz5knyEjMGfCEK8pz9YqE=;
 b=gRnzAgjJ3jTgglpzScNXzxf5O5tvWCVDD7f7tfLAZ+Evqh9ykRUD6i04c2uWpfDjpB
 rZBiLts/JvRegFUXJVaAjpFmV0MzX4lzlQCio5H0pjKFEO6azTmXz//bsHxb/PoxIHJJ
 TyEZz3bg2jwdb1IQz8EEhNmRTA4t4Uh69yRoZbEtbAFbiZvBy7l1i0suqonqBqTlIDnQ
 wjkOvoVmDPl2Ad6p17PUUrCM+1BvXpsl92cya601mWaj6HgNT+1SH8RC5nzZlidJ5NSx
 lzgszda6Hl6ROG+ppRtscPm5TciDEjpAyAIjTXiVdRZ2m7i4IPe6GPSOdMuJYfb73HWp
 DajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786906451; x=1787511251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K87DdrzV6T05ieuNKPZOU2wz5knyEjMGfCEK8pz9YqE=;
 b=Cc61iBLhQKYPmviSEsyzLaDFr+UdZx2khKhRsXR5KDg4KBRnD1p+q5DvVJpk2MXw+B
 OR9E5i2YkZG4hPjsP+Y5ICSmUtEY3xTK5cRkxlDi2NNhQrnfS8Wn644urt9DrgMm/FwR
 zZv1Oef7c8NWtPiQF11N8vjW8EAH4Xdb5qjykH5HWOcTKkJytdDf6TOlEH4YiGAKiXAj
 sMgRlbGCypiyxosbeYdsgz9QcIzf4eZNRIeSKyeRBi3AZYZJV8hBdkbUGTm2EVLmU6jD
 5P/huI4LQXqKjxK6+urSAX5UlFWRgWvKMksK/GrYobshSPqBKT7GzR89rz8Wl/kLk51m
 V/BA==
X-Forwarded-Encrypted: i=1;
 AHgh+RooHccjO1FRVXDTAWeycIGsM2K84PeoshvqhBSYAwAVK/dUAkw2JzyFCL/5CMwhQ678J5cpbPlvaCw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2371jAdzUZOKKKsoa8pDlvn3SICaY72Z1nkwHyPinNfdExGhm
 Me3EB+2H7zXMuFuWahaGTALqmPWOvMf8FF1Q367zE8/ZxQXrMblDUJsU9sKwIkCK3YEyVQlWhh0
 PwsTNb1VbZ/9gDpzy5rhZjC7tl+yGB/E=
X-Gm-Gg: AR+sD12yI/wgNr1barSLqkRw5a7CuRvGBlNMwl+UCvARCBWiiqCNFPgxzqlUGFZRSCQ
 cS/XLcuOGvw9m68yggJMq6F4Q3XXe0LaR5Bm2t77CbJoLvQZD8wP7Dpus7lNjQWi78dq5RifBO7
 sAI/KHOK0TbbAR2YVUbBdll82YstsQccseCk3VbZqgjXdzZIbA7rhDCJLUtzZ+7VMng4a06bhs1
 XySEG+EJ3xxcEtci5R3xjKqHoGOY8EIWViyFbzyya6Y3KCu+PNEpXEf4lROCocbdRtblFdIr33k
 7bTWfF0no5qQ89nXY8Np2Ed0X1VETbzkBT6x1meo8PUTwr8Ueu7N3A25WSKVvkYcTNsMHwNioJF
 W
X-Received: by 2002:a53:d004:0:b0:668:6e5:16d9 with SMTP id
 956f58d0204a3-66c72cbb9c8mr4687899d50.2.1786906451288; Sun, 16 Aug 2026
 11:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260815130556.68876-1-royalnet026@gmail.com>
 <20260816041233.3566625-1-gahing@gahingwoo.com>
In-Reply-To: <20260816041233.3566625-1-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Sun, 16 Aug 2026 20:53:59 +0200
X-Gm-Features: AcwNN1Uh4_l9nX5DwMZE2uVyBVHcgamwlhxHxsLdAI4oiEGskahB9NDY4Ow6O_8
Message-ID: <CAEWPSH54fhzKEYR1cgTskNgKryDEMaZOY1y5aFdKQQyzfKbYfg@mail.gmail.com>
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

I ran the discriminating counts on RK3588. Details below, but first a
source-level observation that changes what my result can tell you.

Neither mesa-25.3.0 nor current main contains the modulo form in
rkt_regcmd.c. In both, BS_OW_CFG (0x4050) is emitted conditionally on
operation->depthwise only, with no dependence on output channel count:

    if (operation->depthwise) {
       EMIT(REG_DPU_BS_OW_CFG, DPU_BS_OW_CFG_SIZE_E_2(3) |
                               DPU_BS_OW_CFG_SIZE_E_1(3) |
                               DPU_BS_OW_CFG_SIZE_E_0(3));   /* 0x36c */
    } else {
       EMIT(REG_DPU_BS_OW_CFG, DPU_BS_OW_CFG_SIZE_E_2(1) |
                               DPU_BS_OW_CFG_SIZE_E_1(1) |
                               DPU_BS_OW_CFG_SIZE_E_0(1));   /* 0x124 */
    }

(mesa-25.3.0, src/gallium/drivers/rocket/rkt_regcmd.c around line 234;
unchanged in main as of 26.1-branchpoint.)

So I take it the (oc % 32) expression is from one of your 102 commits,
fitted from vendor captures? That would also explain the extra bits in
your two constants: decoded against registers.xml, 0x80011111 vs
0x80011011 differ only in bit 8, which is the LSB of SIZE_E_2 (bits
8-10). Your working-at-56 form has SIZE_E_2=3D1 and the failing form has
SIZE_E_2=3D0 - and upstream's non-depthwise value always has SIZE_E_2=3D1.
The three data points are consistent with SIZE_E_2 being what matters,
rather than the modulo-vs-parity predicate as such. Your values also
carry RGP_CNTER=3D8 (bit 31), OW_SRC=3D1 (bit 0) and bits 12/16 in the
reserved range, which upstream never sets; if those came from a vendor
capture it may be worth checking which of them RK3576 actually needs.

Now the measurement. My runs are with upstream Mesa (main,
26.1-branchpoint-5505, clean checkout), i.e. the constant 0x124 form,
on RK3588 with the in-tree rocket driver (7.2-rc7, rockchip-devel
base). Standalone minimal models: CONV_2D 1x1, 64 input channels, 8x8
surface, uint8 asymmetric quantisation in the mobilenet style, output
zero point 0 so the hardware's clamp-at-zp cannot mask anything:

  1x1 conv, 64 in, 56 out:   56/56 channels within +/-1 (47
bit-exact), maxdiff 1
  1x1 conv, 64 in, 88 out:   88/88 channels within +/-1 (81
bit-exact), maxdiff 1
  1x1 conv, 64 in, 120 out:  120/120 channels within +/-1 (106
bit-exact), maxdiff 1

Reference is the raw CPU implementation per channel (not clamped to the
zero point - same lesson as operator 28). No channel had a constant
reference, so the matches are computed rather than trivial, and no
channel sat pinned at the output zero point. The three jobs also
happened to land one per NPU core (per-core IRQ counters went 0->1),
so the result is not specific to a single core.

Since upstream emits the same word for every oc, a
clean result at 56/88/120 says RK3588 does not need an oc-dependent
toggle at 0x4050 at all, at least for these shapes - which is the third
possibility your two forms could not distinguish. It does not tell us
which of your two fitted forms is closer to what RK3576 wants, but it
does suggest comparing your fitted values against the field composition
above rather than as opaque constants.

Happy to run other shapes if that helps narrowing it down.

Best regards,
Igor


On Sun, Aug 16, 2026 at 6:12=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Hi Igor,
>
> Thank you for running it, and for the unclamped reference.
>
> Your 1001 does not discriminate between the two forms, which I should hav=
e said
> when I described them. DIV_ROUND_UP(1001,16) is 63, odd, so the parity fo=
rm
> gives 0x80011011 there and so does oc % 32. They differ only where a coun=
t is a
> multiple of neither 32 nor 16. On RK3576 the failing one was 56, and 88 o=
r 120
> would do as well. So your clean result rules nothing out, and I am not re=
ading
> it as support either way.
>
> On my side that register turned out to be the whole of it. A 1x1 layer wi=
th 56
> output channels had timed out in every round it ever ran, 32 of 56, and w=
ith
> the parity form it is 56 of 56 every channel correct, with the old form
> reproducing the timeout in the same log.
>
> You are right about perch.py and there were three of them rather than one=
. The
> inner maxdiff, the interior statistics and the raw row dump all assume a
> surface with an interior, and all three raise on a 1x1x1001 classifier af=
ter
> the useful lines have printed. Fixed here, and checked on the host at 1x1=
x1001,
> 5x5x8 and 56x56x64 before flashing, which is a check I should have been r=
unning
> all along.
>
> And I will re-score operator 28 against the unclamped output. The max(cpu=
, zp)
> reference does move channels that are not wrong, and reading an empty
> convolution off it is the kind of mistake I would rather not make twice.
>
> Jiaxing
