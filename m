Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79048606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vw4ShiCQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDD210E504;
	Fri, 27 Nov 2026 09:17:08 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46EE1128C8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:16:13 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-38644aedba1so11736717eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:16:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795770973; cv=none;
 d=google.com; s=arc-20260327;
 b=SNkzVHWoNDb/80CW6m31NociUDRAidfiIia1rfEBe7PjffSiKLdtGDtceBhyMenN8J
 tlFeWgWxMz1Vexp8pzaN+XLd0UG8mh4V2W1y7IFMZiM34TdeWeYp+QuWN+bXja9Ff68o
 IRiXgNk0PL2tJbwvgu0SKpngmJXP132GiTZzYvZshCUNtEAlHa8mqDZnFaMiyyZHHbGx
 pcLQh8eUuNcxK5JwxkjmaReVU5YsHdkPGG4O19WLBXJgTHr4/QEXdl29YAR29+1MuaMZ
 MS7WrEWZyaXWoxXah5r9BuOEYVkbeheEvnN7idujWo7cxaOdbk7VO0smoQ3cXQmligB0
 VA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jDYeL2kmjUbEkqOkiCW9A93olbaNlYCSbdBnZUJhtCA=;
 fh=3eOIYP/zd27CetiIkCKPaiffYb/zK/sObWxuw5QXvis=;
 b=HW3H8zCnsbI7wqI9LHqKHdxPw7KNVsAhU3HKrxSR4k4uDTkjN8yI1GpS9oVqAStU+U
 cmA2OTAzdIusmjmDxWLInbudwbvfDWZFACWt95uLwHwXuI0lPtUugTTyRlLCSMMfuLy3
 GZIVPBU87hAg9aM2TWY0IU+ORT+ORRL/Mn8lANi1YwaaNFdqn/B/omlhNRiELoainNmY
 +YoYbMAtrOFSUmBZ+wBD+15AAXHxdggnSTooL5avHkgb+giTQB4DbJ+Vu1cGC7aj33HP
 6U1sdjvXcpZA5ltWFqAh0XZ/4rRx67EM47A48G/BfOvPPgJjeeCfqii/mjHonaKaXkap
 yEGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795770973; x=1796375773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jDYeL2kmjUbEkqOkiCW9A93olbaNlYCSbdBnZUJhtCA=;
 b=vw4ShiCQjUtv8PEVkaw3bmGqAF5h7sBLpjYQ92a5LE3tRw8IVwxaJOcOJFW/kN2Wf8
 +Dz2uNisK0FzRXHo2bSVWnntqGGQG2aBsCf5Mm9P7+eqaRuTx7ZvoYW7V24xccCLYOLd
 cyZzL6USHsuHfOEkOB2+gSd0kBfaS7nCLfQL08aLT7UiU5fkydp8tcYUw9AJfocNnvTj
 KV6aCWxzuegwJ59RITyeqMm9lmSnjloosLPmfCtzauIkwowjz3kfh5d1J3/buex0228E
 SvQz3TJxyGRYvRQiVtHkafnuFwfKe02VN91VTqdP28S1B/UNyxR6dFHHANenRtB8GWo5
 CWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795770973; x=1796375773;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDYeL2kmjUbEkqOkiCW9A93olbaNlYCSbdBnZUJhtCA=;
 b=gO2FOlbHpzORrlSsFzlc/uBsvUwSu1efbHueo0No4zPb1Mg2YS6iA/QPUtmjKHOR3u
 WGeLE1V/C72YPvtIdsIwv0Ame6O9IQkKIhK6azbEwlbbfmpp+PicdDFEJtKUyjdWSWyu
 hXHMX0TeDDEMdM+VAPKwbYh/zsg3GD3VCUqlJ60tBUK1rf2dbFSPvOjCIL+anDHMIZss
 X0xIzqzFdlT36I/sz0zuAs/Bk6zHiwu5ZAOCMvmh9jEGF+m73nAK+23WQiSGRHxiyYqS
 02taXYCuwuP3mGvXO4CvH2vj02tEe0a0PCwoKa0ZN6iBx1rUdRLG/sHE7ueCeeO045UY
 W+Ng==
X-Forwarded-Encrypted: i=1;
 AL+hErH7MtIOBGTgpi8eya/FSkhtoDZ8MfM8J1vGKzRoO4FGQp/KqnY127KeQ15aLEWBOP0iqK/WIfSTv5E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ERMrtt1YRxb6h3zHrQsMSZ3CfL5umk78/ISEO5+bdjFqOq9Nn
 3bFCluX0xPT/j6ccSK9flFHEpWlDi/8m4liH18LQkMVdwS51K30oht7o8E67vi7TuLpVZeakGhE
 7b6I/4djtMOYKIDCedublTuTZ+Tz6EHE=
X-Gm-Gg: AZFdTZf/p4Wh3ykM0F7mzMVntntGDddjtU8NwFlmZuei1ajKON08XIjAvnshn1g7WFl
 7gjPVR8tLwqfg023kuncSzyiBFGviGhFFLNY5eL6d2Sz/qa7JPdNF47uQagkwdNXGyVjDogY5a6
 fCnittWx8LWv2VT4QjZ0WBAqfqnXk/9w/HRPp5tMSIfc/anaqpxWXmKLs1QNenlWHfOvZbFHXts
 x+Sd9FbmcrJUEF8t2v2ep5OZE4rG+O9YZYV173M1hTp6N8o9zVsr3k6KqZqRiB3ahx282mE8QJL
 gjE3A0zL6ghsBA49tpkaRxIeM/ioJeyEcTXveB1F1CUfhZnSKuItMnzZ599fOjmAeCuLsKF+69I
 29Ix3U6WS5+kxluIO0fDV9DALJYzKNTozwNPufJu0n5PqoXVw434mAkw97gHbrVWPYoZbRKGc1J
 8gUuV3QDpbG+FDkZsKUNCByJWe1s1CQw==
X-Received: by 2002:a05:7300:cf87:b0:386:565b:4f9b with SMTP id
 5a478bee46e88-386565b529dmr18908380eec.36.1795770973084; Fri, 27 Nov 2026
 01:16:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-7-clamor95@gmail.com>
 <CQmBXmddTJ6v1iTnbDfQLA@nvidia.com>
In-Reply-To: <CQmBXmddTJ6v1iTnbDfQLA@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:16:01 +0200
X-Gm-Features: Aa3M54qH8gYf5As35TKTatFm5o7bkTT2Je6sUBOdI-CDd1BicPTc8yLdRQYINpY
Message-ID: <CAPVz0n14uUMdQYb+v_cKMiXRudND9fgKpqQWmGUO65BcCuciUA@mail.gmail.com>
Subject: Re: [PATCH v8 06/12] drm/tegra: dc: Add elements required by Tegra
 MIPI DBI
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 06:5=
6 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Add DC register definitions with additional fields in preparation for
> > adding the 8-bit CPU interface (MIPI DBI).
>
> Maybe also mention that some whitespace cleanup has been done.
>

sure

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.h | 194 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 183 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > index 0cb0515968b35..e8913c5530a2d 100644
> > --- a/drivers/gpu/drm/tegra/dc.h
> > +++ b/drivers/gpu/drm/tegra/dc.h
> > @@ -272,14 +272,150 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
> >  #define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
> >  #define DC_COM_CRC_CHECKSUM                  0x301
> > -#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
> > -#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> > -#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
> > -#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> > -#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
> > -#define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
> > -#define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> > -#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
> > +
> > +#define DC_COM_PIN_OUTPUT_ENABLE(x)          (0x302 + (x))
> > +#define DC_COM_PIN_OUTPUT_POLARITY(x)                (0x306 + (x))
> > +#define LVS_OUTPUT_POLARITY_LOW                      BIT(28)
> > +#define LHS_OUTPUT_POLARITY_LOW                      BIT(30)
> > +#define DC_COM_PIN_OUTPUT_DATA(x)            (0x30a + (x))
> > +/* Pin unmask is 1 bit above position of the pin in the OUTPUT_DATA re=
gister */
> > +#define PIN_UNMASK(x)                                BIT((x) + 1)
> > +#define DC_COM_PIN_INPUT_ENABLE(x)           (0x30e + (x))
> > +
> > +/*
> > + * The definitions below describe pin positions in the DC_COM_PIN_OUTP=
UT_ENABLE(x),
> > + * DC_COM_PIN_OUTPUT_POLARITY(x), DC_COM_PIN_OUTPUT_DATA(x), and
> > + * DC_COM_PIN_INPUT_ENABLE(x) registers. The comment before each group=
 indicates
> > + * the index of the register (the x value).
> > + */
> > +
> > +/* 0 */
> > +#define PIN_LD0                                      0
> > +#define PIN_LD1                                      2
> > +#define PIN_LD2                                      4
> > +#define PIN_LD3                                      6
> > +#define PIN_LD4                                      8
> > +#define PIN_LD5                                      10
> > +#define PIN_LD6                                      12
> > +#define PIN_LD7                                      14
> > +#define PIN_LD8                                      16
> > +#define PIN_LD9                                      18
> > +#define PIN_LD10                             20
> > +#define PIN_LD11                             22
> > +#define PIN_LD12                             24
> > +#define PIN_LD13                             26
> > +#define PIN_LD14                             28
> > +#define PIN_LD15                             30
> > +
> > +/* 1 */
> > +#define PIN_LD16                             0
> > +#define PIN_LD17                             2
> > +#define PIN_LPW0                             16
> > +#define PIN_LPW1                             18
> > +#define PIN_LPW2                             20
> > +#define PIN_LSC0                             24
> > +#define PIN_LSC1                             26
> > +#define PIN_LVS                                      28
> > +#define PIN_LHS                                      30
> > +
> > +/* 2 */
> > +#define PIN_LHP0                             0
> > +#define PIN_LHP1                             2
> > +#define PIN_LHP2                             4
> > +#define PIN_LVP0                             8
> > +#define PIN_LVP1                             10
> > +#define PIN_LM0                                      16
> > +#define PIN_LM1                                      18
> > +#define PIN_LDI                                      20
> > +#define PIN_LPP                                      22
> > +
> > +/* 3 */
> > +#define PIN_LSCK                             0
> > +#define PIN_LSDA                             2
> > +#define PIN_LCSN                             4
> > +#define PIN_LDC                                      6
> > +#define PIN_LSPI                             8
> > +#define PIN_LSDI                             10
> > +
> > +#define DC_COM_PIN_INPUT_DATA(x)             (0x312 + (x))
> > +
> > +/*
> > + * DC_COM_PIN_OUTPUT_SELECT(x) is a set of 7 registers that allow sele=
cting
> > + * one of 7 functions for each pin using 3 bits. Clearing all bits set=
s
> > + * the pin to its primary function, while setting them to 1 configures=
 it
> > + * as a GPIO output. Other functions are unique to each pin. For detai=
ls,
> > + * check "23.7.17 DC_COM_PIN_OUTPUT_SELECT0_0" in the Tegra30 TRM.
> > + */
> > +#define DC_COM_PIN_OUTPUT_SELECT(x)          (0x314 + (x))
> > +#define PIN_OUTPUT_SELECT_MASK(x)            (0x7 << (x))
> > +#define PIN_OUTPUT_SELECT_PRIM(x)            (0 << (x))
> > +#define PIN_OUTPUT_SELECT_OUT(x)             (1 << (x))
> > +#define PIN_OUTPUT_SELECT_F2(x)                      (2 << (x))
> > +#define PIN_OUTPUT_SELECT_F3(x)                      (3 << (x))
> > +#define PIN_OUTPUT_SELECT_F4(x)                      (4 << (x))
> > +#define PIN_OUTPUT_SELECT_F5(x)                      (5 << (x))
> > +#define PIN_OUTPUT_SELECT_F6(x)                      (6 << (x))
> > +#define PIN_OUTPUT_SELECT_F7(x)                      (7 << (x))
> > +
> > +/*
> > + * The definitions below describe pin offset in the DC_COM_PIN_OUTPUT_=
SELECT(x)
> > + * registers. The comment before each group indicates the index of the=
 register
> > + * (the x value).
> > + */
> > +
> > +/* 0 */
> > +#define PIN_OUTPUT_SELECT_LD0                        0
> > +#define PIN_OUTPUT_SELECT_LD1                        4
> > +#define PIN_OUTPUT_SELECT_LD2                        8
> > +#define PIN_OUTPUT_SELECT_LD3                        12
> > +#define PIN_OUTPUT_SELECT_LD4                        16
> > +#define PIN_OUTPUT_SELECT_LD5                        20
> > +#define PIN_OUTPUT_SELECT_LD6                        24
> > +#define PIN_OUTPUT_SELECT_LD7                        28
> > +
> > +/* 1 */
> > +#define PIN_OUTPUT_SELECT_LD8                        0
> > +#define PIN_OUTPUT_SELECT_LD9                        4
> > +#define PIN_OUTPUT_SELECT_LD10                       8
> > +#define PIN_OUTPUT_SELECT_LD11                       12
> > +#define PIN_OUTPUT_SELECT_LD12                       16
> > +#define PIN_OUTPUT_SELECT_LD13                       20
> > +#define PIN_OUTPUT_SELECT_LD14                       24
> > +#define PIN_OUTPUT_SELECT_LD15                       28
> > +
> > +/* 2 */
> > +#define PIN_OUTPUT_SELECT_LD16                       0
> > +#define PIN_OUTPUT_SELECT_LD17                       4
> > +
> > +/* 3 */
> > +#define PIN_OUTPUT_SELECT_LPW0                       0
> > +#define PIN_OUTPUT_SELECT_LPW1                       4
> > +#define PIN_OUTPUT_SELECT_LPW2                       8
> > +#define PIN_OUTPUT_SELECT_LSC0                       16
> > +#define PIN_OUTPUT_SELECT_LSC1                       20
> > +#define PIN_OUTPUT_SELECT_LVS                        24
> > +#define PIN_OUTPUT_SELECT_LHS                        28
> > +
> > +/* 4 */
> > +#define PIN_OUTPUT_SELECT_LHP0                       0
> > +#define PIN_OUTPUT_SELECT_LHP1                       4
> > +#define PIN_OUTPUT_SELECT_LHP2                       8
> > +#define PIN_OUTPUT_SELECT_LVP0                       16
> > +#define PIN_OUTPUT_SELECT_LVP1                       20
> > +
> > +/* 5 */
> > +#define PIN_OUTPUT_SELECT_LM0                        0
> > +#define PIN_OUTPUT_SELECT_LM1                        4
> > +#define PIN_OUTPUT_SELECT_LDI                        8
> > +#define PIN_OUTPUT_SELECT_LPP                        12
> > +
> > +/* 6 */
> > +#define PIN_OUTPUT_SELECT_LSCK                       0
> > +#define PIN_OUTPUT_SELECT_LSDA                       4
> > +#define PIN_OUTPUT_SELECT_LCSN                       8
> > +#define PIN_OUTPUT_SELECT_LDC                        12
> > +#define PIN_OUTPUT_SELECT_LSPI                       16
> > +#define PIN_OUTPUT_SELECT_LSDI                       20
>
> It becomes apparent here that the PIN_* and PIN_OUTPUT_SELECT_* are kind
> of redundant as the pins are in the same order, the stride (and thus
> register indexing) is just different. Hence, I think it would be cleaner
> to have ..
>
> #define PIN_LD0         0
> #define PIN_LD1         1
> ...
>
> and then
>
> #define PIN_REGISTER_INDEX(pin)         ((pin) / 16)
> #define PIN_SHIFT(pin)                  (((pin) % 16) * 2)
>
> #define PIN_SELECT_REGISTER_INDEX(pin)  ((pin) / 8)
> #define PIN_SELECT_SHIFT(pin)           (((pin) % 8) * 4)
>
> This will also simplify the tegra_dbi_idx tables since they can just
> store the pin index, and the register index (and shift) can be
> calculated based on that.
>

I will look into this. Thanks

> >
> >  #define DC_COM_PIN_MISC_CONTROL                      0x31b
> >  #define DC_COM_PIN_PM0_CONTROL                       0x31c
> > @@ -303,9 +439,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define  UNDERFLOW_REPORT_ENABLE (1 << 0)
> >
> >  #define DC_DISP_DISP_SIGNAL_OPTIONS0         0x400
> > -#define H_PULSE0_ENABLE (1 <<  8)
> > -#define H_PULSE1_ENABLE (1 << 10)
> > -#define H_PULSE2_ENABLE (1 << 12)
> > +#define H_PULSE0_ENABLE                              BIT(8)
> > +#define H_PULSE1_ENABLE                              BIT(10)
> > +#define H_PULSE2_ENABLE                              BIT(12)
> > +#define V_PULSE0_ENABLE                              BIT(16)
> > +#define V_PULSE1_ENABLE                              BIT(18)
> > +#define V_PULSE2_ENABLE                              BIT(19)
> > +#define V_PULSE3_ENABLE                              BIT(20)
> > +#define M0_ENABLE                            BIT(24)
> > +#define M1_ENABLE                            BIT(26)
> >
> >  #define DC_DISP_DISP_SIGNAL_OPTIONS1         0x401
> >
> > @@ -456,6 +598,22 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define DC_DISP_SHIFT_CLOCK_OPTIONS          0x431
> >  #define  SC1_H_QUALIFIER_NONE        (1 << 16)
> >  #define  SC0_H_QUALIFIER_NONE        (1 <<  0)
> > +#define  SC0_H_QUALIFIER(x)                  (((x) & 0x7) <<  0)
> > +#define  SC1_H_QUALIFIER(x)                  (((x) & 0x7) << 16)
> > +#define  SC_H_QUALIFIER_DISABLE                      0
> > +#define  SC_H_QUALIFIER_NONE                 1
> > +#define  SC_H_QUALIFIER_HACTIVE                      2
> > +#define  SC_H_QUALIFIER_EXT_HACTIVE          3
> > +#define  SC_H_QUALIFIER_HPULSE                       4
> > +#define  SC_H_QUALIFIER_EXT_HPULSE           5
> > +#define  SC0_V_QUALIFIER(x)                  (((x) & 0x7) <<  3)
> > +#define  SC1_V_QUALIFIER(x)                  (((x) & 0x7) <<  19)
> > +#define  SC_V_QUALIFIER_NONE                 0
> > +#define  SC_V_QUALIFIER_RSVD                 1
> > +#define  SC_V_QUALIFIER_VACTIVE                      2
> > +#define  SC_V_QUALIFIER_EXT_VACTIVE          3
> > +#define  SC_V_QUALIFIER_VPULSE                       4
> > +#define  SC_V_QUALIFIER_EXT_VPULSE           5
> >
> >  #define DC_DISP_DATA_ENABLE_OPTIONS          0x432
> >  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
> > @@ -493,6 +651,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define DC_DISP_CURSOR_POSITION_NS           0x441
> >
> >  #define DC_DISP_INIT_SEQ_CONTROL             0x442
> > +#define SEND_INIT_SEQUENCE                   BIT(0)
> > +#define INIT_SEQUENCE_MODE_SPI                       BIT(1)
> > +#define INIT_SEQUENCE_MODE_PLCD                      0
> > +#define INIT_SEQ_DC_SIGNAL_SHIFT             4
> > +#define INIT_SEQ_DC_SIGNAL_MASK                      (0x7 << INIT_SEQ_=
DC_SIGNAL_SHIFT)
> > +#define NO_DC_SIGNAL                         0
> > +#define DC_SIGNAL_VSYNC                              1
> > +#define DC_SIGNAL_VPULSE0                    2
> > +#define DC_SIGNAL_VPULSE1                    3
> > +#define DC_SIGNAL_VPULSE2                    4
> > +#define DC_SIGNAL_VPULSE3                    5
> > +#define INIT_SEQ_DC_CONTROL_SHIFT            7
> > +#define FRAME_INIT_SEQ_CYCLES_SHIFT          8
> > +
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_A          0x443
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_B          0x444
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_C          0x445
> > --
> > 2.53.0
> >
> >
>
>
>
>
