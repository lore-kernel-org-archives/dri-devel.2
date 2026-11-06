Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E8606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB0MJ5Gy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F7710EA44;
	Fri,  6 Nov 2026 14:07:14 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C5C112DF7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:07:08 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c4d30639709so84113666b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:07:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974026; cv=none;
 d=google.com; s=arc-20260327;
 b=RXPJr6NtjlNX0Rrg5RnmxwzdE2KIh0aOWuJ+9nKkWfZR0YrKX09bSXHt6jWdr5RxUb
 9zDIkmML0w2fISGHbJMWnVx1FVD/zSnS0UpaVKz2atDO7j3ByrzVfDC70QeN9DWK6Qb5
 c0rIsOwu38FRzK5OTl39yIxemFg2VnOpkjIgwNnZzpuRSuI21IVx+O7aSykx5jp2iE/p
 4IPVoVmpucrvOrpuviVdbRW7kAuoKuBx8WWAzy0zZZv3xkuaNBIxLX6GE8SSpBkj+UWB
 QcAyija0RcynI2fNBztKnb2vtI+1M2qPGaySoy65PFwSdf1AhfSDAtvBzdTy3ogORTyZ
 mxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CF2uVzHFb62iNIhC5h8KQfZpRW0Yj9jP3Jhqf3ga0/4=;
 fh=Iiwdn0ocT8wpXSQjMd/6F8OjWquPv6BZOzpr2iRb1tQ=;
 b=mgBmoudTx8B7i8MDwpcgzCDm6ixbrHlGKMiIbWvWEOqHGRlZuRUiLk2/2CnmTPFjRD
 /fF/bk9AYSyJ3jmrTtr/pnqARPO0tQqDSk5r4LGDZoeHkzF8RFVXMXZwuHQILvljPW+B
 Yxm+Yphx4sCquY/hIJp19AdX0++9StjUYJnvvf/zHJ0OS0LA/bGamBDGiipEx/LmfPz7
 wr9zBZATIk8qN9I84Vb/AYiobgX+in3fi1DQY8I0f/nAZILe4l8dnIvvRAkv5F/eNzGG
 BVqxu3GITGbtJ1R5DvGh2NdkzZg2lNBdgAZIvbydecVmatgW5vpCo0wSTLenIrsH6GAD
 xIKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793974026; x=1794578826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CF2uVzHFb62iNIhC5h8KQfZpRW0Yj9jP3Jhqf3ga0/4=;
 b=YB0MJ5Gydji+PJFYaQeSiKaEIcXUZzNfzYhl46LOV9yTdweapw7UyctdIF+eODhIcY
 IAI0UiPWGeoGWfkG7Ya4PTpCNbLXrpcyUv7Q6CcFiQmS7z8McIB4cWMnz0yqpBMvFEdo
 c0957BHsweVMrgzPUYauheZ+K2K16dtsTjszf5QqBeotMgusE1dFvCFMg6xG1Ord4cg/
 0AIO7WjzaqnbCzx6JYlMIQXvoqBvsrqWPvqOwQSK1uCvcZSlPJe29Tr8NojvagJqfZ1x
 AnOOZtwHCJvWu7PJdUpFfpYIeg8eQLXNlAq7Ie/XY6GO6OBaLCM7ZdrWrI44Gxtfwfyx
 DyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793974026; x=1794578826;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CF2uVzHFb62iNIhC5h8KQfZpRW0Yj9jP3Jhqf3ga0/4=;
 b=mAmmghGv7IyEzdhEKc0+NOqoqbhu+4mSxmnbIcgm1Y1kGfAZdAnzw1ADibLqBD/rgQ
 ZhICxCH6NMg7Pufffeu2XfPPaBSOaNYBvjVXN18puwd3QJ+VIqfibUAvOr8Mg0Iksnai
 2MNDVOH6oOpc9gE4DXzQQZJfFJpreMslosG/OVHP/pk9Ry38dTInDcw4NBv3W3ZweAAt
 BbENpByeG4PGJus5Kbg2E7AcV9WcHCtV0wN30qHVoGgCmjTb3Jo0nKJTtlXZjsy41wiG
 BqZ9DR2l2a3/ptiJgUobiIKxTRReWc6txw0PDzgSrS0R0L+VkMhy80RvpX/F2ARhUNLn
 HnTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwne7IkNHLU4eXrpIIBWxbl11XzcTNf1x6IiK8z7gz15/5nASgXVVd6R4kHJqGnp7vlkBUSBMZcnss=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+me0L3JCz7iQThYAzUzKR6teuoC8boIfHHD1qIuRj9J8fBx6WG
 t2u58h9Nq/hKFFbdzyFMGussQItlk1yVLF/lUza0hrekhlWyyGgGSFFbjiRoVCqS64Ns0eK/qfo
 /S5GIw0AINLKz2N8vIl0EzG6zPnYWaVY=
X-Gm-Gg: AYBFou1uCWAt64VbDoq1sp7UkTJNaIL8rlFcHG0530RIcEIejL/PWGb7YWi2eS33Lku
 2rsFlbYFXLk6ETPBqei6FFgOE/6zYZRFPl8xnKyfyFDzAgedwFxD+yiOc24OBVzTdagpcvyR4Do
 RNi8IrWImUt9Ot1PrbG64smoWJJEm4gU7EI8Ldc5XqCexLBNB91zUhM9Da6DlKeQwJbfLw7MI8V
 8a+bPcqAGHnjlDp7g0wWdMZcLhdyJ9AktZh2GnXW/3HWfqXBQo7cTE0E54vCKt8ri6v1NNQxncS
 OVhXvkcArBHCZFm5t74V9RRUBXAySlhlHBMKzcrUEn+Z2D1Zhz716MHc34KvitQOgINI1uBVyP/
 1TnWAEr9O3hAXdbNDunWpfETy7gHNzfdcZ3BRCSPLUNN4iL9oXbGEWTo5CTJdqf0y8tMzOQ1ZP+
 1XHjcC5S27PR086pWhnhsP3FBPsHoJcsGbWuEgW3ICyPx1DSnRupI=
X-Received: by 2002:a17:906:794a:b0:c36:179b:6d68 with SMTP id
 a640c23a62f3a-c4d34babc94mr212442366b.24.1793974026265; Fri, 06 Nov 2026
 06:07:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-5-clamor95@gmail.com>
 <au3X8tpU9KWas9ZM@orome>
In-Reply-To: <au3X8tpU9KWas9ZM@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:06:52 +0200
X-Gm-Features: AclHuK9W8h_VdmRrbmlRdGVn94XocWlAhADiJndzE0sl5T8qxllPsgvIMFjUVog
Message-ID: <CAPVz0n1h8SS09Nt9fw4q806ktEM59fQRXTqdP053E7+2onzmYA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] drm/tegra: dc: Refactor and expand header
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
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

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:56=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:04PM +0200, Svyatoslav Ryhel wrote:
> > Refactor and expand existing DC register definitions with additional
> > fields in preparation for adding the 8-bit CPU interface.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c  |  11 +-
> >  drivers/gpu/drm/tegra/dc.h  | 856 +++++++++++++++++++++---------------
> >  drivers/gpu/drm/tegra/rgb.c |   8 +-
> >  3 files changed, 514 insertions(+), 361 deletions(-)
>
> This is impossible to review. Please split this up into refactor and
> expand patches. Each should be a separate change.
>
> Also, a lot of the "refactor" is just pointless whitespace changes that
> are just not necessary. Please keep the changes to a minimum.
>

Well, I did what Mikko asked. It is not my problem that this header is
a hot mess. Initially I just wanted to add fragments needed by dbi.

> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> [...]
> > @@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_c=
rtc *crtc,
> >
> >       if (dc->rgb) {
> >               /* XXX: parameterize? */
> > -             value =3D SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
> > +             value =3D SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> > +                     SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
>
> This type of change seems entirely useless to me. It's neither more
> readable nor shorter.
>
> [...]
> > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > index 0cb0515968b35..2b87bb675d4cf 100644
> > --- a/drivers/gpu/drm/tegra/dc.h
> > +++ b/drivers/gpu/drm/tegra/dc.h
> > @@ -178,9 +178,11 @@ int tegra_dc_rgb_init(struct drm_device *drm, stru=
ct tegra_dc *dc);
> >  int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >
> >  #define DC_CMD_GENERAL_INCR_SYNCPT           0x000
> > +
> >  #define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL     0x001
> > -#define  SYNCPT_CNTRL_NO_STALL   (1 << 8)
> > -#define  SYNCPT_CNTRL_SOFT_RESET (1 << 0)
> > +#define  SYNCPT_CNTRL_NO_STALL                       BIT(8)
> > +#define  SYNCPT_CNTRL_SOFT_RESET             BIT(0)
>
> The whitespace changes here are completely arbitrary, it's changing one
> preference for another. You're actually changing the contents in this
> case, so it's not that bad. Still unnecessary, though.
>
> > -#define DISP_CTRL_MODE_STOP (0 << 5)
> > -#define DISP_CTRL_MODE_C_DISPLAY (1 << 5)
> > -#define DISP_CTRL_MODE_NC_DISPLAY (2 << 5)
> > -#define DISP_CTRL_MODE_MASK (3 << 5)
> > +#define  DISP_CTRL_MODE_STOP                 (0 << 5)
> > +#define  DISP_CTRL_MODE_C_DISPLAY            (1 << 5)
> > +#define  DISP_CTRL_MODE_NC_DISPLAY           (2 << 5)
> > +#define  DISP_CTRL_MODE_MASK                 (3 << 5)
>
> These are purely whitespace changes. Please don't do that.
>

This separates register content for register definitions

> >  #define DC_COM_CRC_CONTROL                   0x300
> > -#define  DC_COM_CRC_CONTROL_ALWAYS (1 << 3)
> > -#define  DC_COM_CRC_CONTROL_FULL_FRAME  (0 << 2)
> > -#define  DC_COM_CRC_CONTROL_ACTIVE_DATA (1 << 2)
> > -#define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
> > -#define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
> > +#define  DC_COM_CRC_CONTROL_ALWAYS           BIT(3)
> > +#define  DC_COM_CRC_CONTROL_FULL_FRAME               (0 << 2)
> > +#define  DC_COM_CRC_CONTROL_ACTIVE_DATA              BIT(2)
> > +#define  DC_COM_CRC_CONTROL_WAIT             BIT(1)
> > +#define  DC_COM_CRC_CONTROL_ENABLE           BIT(0)
>
> FULL_FRAME and ACTIVE_DATA were previously consistent, now it just looks
> weird. Either use proper GENMASK() definitions where applicable, along
> with modifications in the driver to use FIELD_PREP() and FIELD_GET(), or
> just don't change it at all.
>

This one seems legit, I must have missed that.

> > +
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
> > +/* Defines in PIN_OUTPUT/INPUT_* describe pin position, not state */
>
> This comment is completely confusing to me. The registers themselves
> define the state and bit positions within them seem to indicate the pin
> positions.
>
> > +#define DC_COM_PIN_OUTPUT_ENABLE(x)          (0x302 + (x))
> > +#define DC_COM_PIN_OUTPUT_POLARITY(x)                (0x306 + (x))
> > +#define DC_COM_PIN_OUTPUT_DATA(x)            (0x30a + (x))
> > +#define  PIN_UNMASK(x)                               BIT((x) + 1)
>
> Given that pin positions are in steps of two for all registers, does
> that PIN_UNMASK apply to all of them or just PIN_OUTPUT_DATA?
>

Check TRM

> > +#define DC_COM_PIN_INPUT_ENABLE(x)           (0x30e + (x))
> > +
> [...]
> > +/* DC_COM_PIN_OUTPUT/INPUT_*_3 */
> > +#define PIN_LSCK                             0
> > +#define PIN_LSDA                             2
> > +#define PIN_LCSN                             4
> > +#define PIN_LDC                                      6
> > +#define PIN_LSPI                             8
> > +#define PIN_LSDI                             10
> > +
> > +#define DC_COM_PIN_INPUT_DATA(x)             (0x312 + (x))
>
> It's not clear that PIN_INPUT_DATA_* can take any of those PIN_*
> defines. Given that there are only two PIN_INPUT_DATA registers that's
> probably not true, so I think it'd be good to somehow specify how that
> works here.
>

I do not need input data, hence this field is not populated

> > +#define DC_COM_PIN_OUTPUT_SELECT(x)          (0x314 + (x))
> > +#define  PIN_OUTPUT_SELECT_MASK(x)           (0x7 << (x))
> > +#define  PIN_OUTPUT_SELECT_PRIM(x)           (0 << (x))
> > +#define  PIN_OUTPUT_SELECT_OUT(x)            (1 << (x))
> > +#define  PIN_OUTPUT_SELECT_F2(x)             (2 << (x))
> > +#define  PIN_OUTPUT_SELECT_F3(x)             (3 << (x))
> > +#define  PIN_OUTPUT_SELECT_F4(x)             (4 << (x))
> > +#define  PIN_OUTPUT_SELECT_F5(x)             (5 << (x))
> > +#define  PIN_OUTPUT_SELECT_F6(x)             (6 << (x))
> > +#define  PIN_OUTPUT_SELECT_F7(x)             (7 << (x))
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT0 */
> > +#define PIN_OUTPUT_SELECT_LD0                        0
> > +#define PIN_OUTPUT_SELECT_LD1                        4
> > +#define PIN_OUTPUT_SELECT_LD2                        8
> > +#define PIN_OUTPUT_SELECT_LD3                        12
> > +#define PIN_OUTPUT_SELECT_LD4                        16
> > +#define PIN_OUTPUT_SELECT_LD5                        20
> > +#define PIN_OUTPUT_SELECT_LD6                        24
> > +#define PIN_OUTPUT_SELECT_LD7                        28
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT1 */
> > +#define PIN_OUTPUT_SELECT_LD8                        0
> > +#define PIN_OUTPUT_SELECT_LD9                        4
> > +#define PIN_OUTPUT_SELECT_LD10                       8
> > +#define PIN_OUTPUT_SELECT_LD11                       12
> > +#define PIN_OUTPUT_SELECT_LD12                       16
> > +#define PIN_OUTPUT_SELECT_LD13                       20
> > +#define PIN_OUTPUT_SELECT_LD14                       24
> > +#define PIN_OUTPUT_SELECT_LD15                       28
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT2 */
> > +#define PIN_OUTPUT_SELECT_LD16                       0
> > +#define PIN_OUTPUT_SELECT_LD17                       4
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT3 */
> > +#define PIN_OUTPUT_SELECT_LPW0                       0
> > +#define PIN_OUTPUT_SELECT_LPW1                       4
> > +#define PIN_OUTPUT_SELECT_LPW2                       8
> > +#define PIN_OUTPUT_SELECT_LSC0                       16
> > +#define PIN_OUTPUT_SELECT_LSC1                       20
> > +#define PIN_OUTPUT_SELECT_LVS                        24
> > +#define PIN_OUTPUT_SELECT_LHS                        28
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT4 */
> > +#define PIN_OUTPUT_SELECT_LHP0                       0
> > +#define PIN_OUTPUT_SELECT_LHP1                       4
> > +#define PIN_OUTPUT_SELECT_LHP2                       8
> > +#define PIN_OUTPUT_SELECT_LVP0                       16
> > +#define PIN_OUTPUT_SELECT_LVP1                       20
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT5 */
> > +#define PIN_OUTPUT_SELECT_LM0                        0
> > +#define PIN_OUTPUT_SELECT_LM1                        4
> > +#define PIN_OUTPUT_SELECT_LDI                        8
> > +#define PIN_OUTPUT_SELECT_LPP                        12
> > +
> > +/* DC_COM_PIN_OUTPUT_SELECT6 */
> > +#define PIN_OUTPUT_SELECT_LSCK                       0
> > +#define PIN_OUTPUT_SELECT_LSDA                       4
> > +#define PIN_OUTPUT_SELECT_LCSN                       8
> > +#define PIN_OUTPUT_SELECT_LDC                        12
> > +#define PIN_OUTPUT_SELECT_LSPI                       16
> > +#define PIN_OUTPUT_SELECT_LSDI                       20
> >
> >  #define DC_COM_PIN_MISC_CONTROL                      0x31b
>
> If there's only one PIN_MISC_CONTROL register, does that take these same
> PIN_* values as bit indices?
>

Check TRM

> Thierry
