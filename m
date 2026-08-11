Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CFAC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FF610E0C9;
	Tue, 11 Aug 2026 20:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GiRWNMqQ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883DC10E0C9
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:21:48 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-495509b08ebso3585e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 13:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786479707; cv=none;
 d=google.com; s=arc-20260327;
 b=hLYozafTRHo4W+MqzZTzYkDMjYkFzx6MTf6VVgp/htbgW0GvUWvSEh625zEgkBU9lr
 jomYwUccEHnbF9dE/rdA5Z99SQBPd8iSkSMnLYuUjLu06MNN1rgJc/xe9lbr+8uT5KqU
 Z5w5cLFK31EiFaAAjLUytUcZAI/cVEV0z9UEn6il+NjeXh5PlNEuOt8w30Q8kYLzF8JS
 3kD8gV0eEU1XwqSAPzNvbVmem2TKFj5CZFBSVirtOmB5LsLBkZGDTEEx2eWw7um9ahD3
 IZ2s1HAHjHqHsKlVv77+lbimWrDvUIm7BlEftNkFQLFa90CcPu8Bfr9KuTKLKtJNyQQb
 r2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2y76Lt61/i/b/snN9JbQtpyqqRRI3i3v46Jl7CWq7qg=;
 fh=NTaPEhR4ipvOSI1II+nBN71nQ0RVXHhBIfdh0Ets6mU=;
 b=a3Igt3YYXMOELb/r3PhonNaEi8dgaLqblNj8QrctW6OpoHf6ihv/5Z1MYqpDhDNuwe
 GncL3r/vvZ/0gpEzw/raWDQ98NO2cPF0Ld8PLUViRxv9DzrEwnfOFX/ylQUneiqvJr5v
 QpYlrswksE9QiZSkZHFc7TWCaKJWBCbhbrT677eNN/by5zYGr/ICWFn6M07tLpNNFD71
 ZxdrmKss+rpjn4efJ/Vg+lYH2nxcVCk8QHyUNP+odKtIm3QkqCTwTzpe08K1k6XnEFiC
 L13nRfCqvO26ggltEyl0AB6P4phsWAQkBoAXlRVXn7NoN5s9E/dhL26o/mvU1wuYH4Fe
 Spww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786479707; x=1787084507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2y76Lt61/i/b/snN9JbQtpyqqRRI3i3v46Jl7CWq7qg=;
 b=GiRWNMqQNA66/1kS43Ck/BUuRvcXjeaYHZ4A34RP3CqpPlXxA8t6749ZIOree9a29L
 YH0xZith53l2yJg82jpKgBqkhwAE9uxBLXff5YTPuNPdxrU9pNlINujpUUAZ737kIK7w
 hB5Pu8Pks/EshwdSOKoNmCOK8N5QQ9v5UTXaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786479707; x=1787084507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2y76Lt61/i/b/snN9JbQtpyqqRRI3i3v46Jl7CWq7qg=;
 b=WCQYxXac+E82n5zJvsq+yDZtfVtJmR61f4lKbNz96nBthj/uxF0jos4xyyeYlXejC9
 my4Pi9qmt7yEKQ1a8/V0oT7LQuXoYBCFNzfWOtZUZBKjACLAgv4Q1YN3CNqSn3v8i/Ct
 a3DGqLAF7kMIPVX61dlAmEJcr1hCUMU54NXEpRGUiXo3XWsXftS93b1aAwbu4XyPGiPl
 Q6rE6u5F58zBpcz0gvOF/N2UPB/Hk0zqfA1eMnBOzussGnfCF9+BnT0lx+wThulQrp3O
 QNUo+lHr1JFx5LBqtry/vAnVHkUnRBq1R7wYewXwR1QQgtNgmyR8Uq2p99rrZzrEhfo4
 iVLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfX/T7p3huulZnMDYftkaxIr3fQuLgF4ZQoZZpsAHBDzjSFYA901tvpI3SPMybUujeUd6QnEQWDy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7kyfKCozCT/Cv0mWzIzLnnW+EyOOiwnZkR1craAOa3LzvCy5w
 4AVekG2Xs/S7akyplkOpAP4h7hIMRfrmdgSIh8NBf/d7GmN3WyQR7+ZunORNMB+5rV6qYgGCyNd
 WCkuQWLuFGBAhMO8piuBeiawdU2M2vm68BiHPQpep
X-Gm-Gg: AR+sD106tTfwD+Teb5PhS/mE2FXBVa203gZvNL0nEgDpC6FWAlGKn2kmdguOCjYmAfX
 4NhDhc6KBO44vyMOVGrqVxO2lsNs0/LfKsejom3AYhvype02AllyTS7JbaNUPE/nwoOYPErs0Wf
 GCtl5PUyUVvZ+JnrD3emRsHaChDi8k94xCy52T8IYAKP5EZaSTiyejFJHd0+xBtAiho4AV7QvmF
 ZOyPyvETsx0XQAIuxE0P1Tc49ITIUMtaA57lZpfTd6L+3rHc4PYiorYMkHbSbmJdiK67yhL3DB1
 gqsRcG4ZOF5c4sbdMCb515C0rBswZO0E+wbP+NF1EpOIScRyIywKXCC6FIhrOn+vIIe/afwkxdu
 c5uH9+p8610PRtRs=
X-Received: by 2002:a05:600c:a210:b0:495:51b1:3b7c with SMTP id
 5b1f17b1804b1-4997ae8fa87mr189725e9.8.1786479706369; Tue, 11 Aug 2026
 13:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785838269.git.sean@starlabs.systems>
 <6f65c9869714188539f2890aef6cf30e7bd2edcb.1785838269.git.sean@starlabs.systems>
 <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
 <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
 <CABtds-35m_cfT=Vm4MZkJYRe=dOPAKR6HYO_fu3SnwkdVQE0nQ@mail.gmail.com>
 <64d82edc-87a0-47c7-8a17-f0d1c806a294@oss.qualcomm.com>
In-Reply-To: <64d82edc-87a0-47c7-8a17-f0d1c806a294@oss.qualcomm.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 11 Aug 2026 13:21:33 -0700
X-Gm-Features: AUfX_mwPkMPdfE9_YsGRn0TlcmOaeVgS_UG6HvdrEqDFesBA8RH57sUUWpUXm-M
Message-ID: <CAODwPW8B2-i4Ne-ZTVUM_H-EZwn2hoaC4joRhxNM=CREDd_aUg@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sean Rhodes <sean@starlabs.systems>, chrome-platform@lists.linux.dev, 
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
 Denis Benato <denis.benato@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, 
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, 
 dri-devel@lists.freedesktop.org, Oliver Lin <oliver@liuxiaozhen.dev>
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

On Tue, Aug 4, 2026 at 4:28=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> On 04/08/2026 13:24, Sean Rhodes wrote:
> > On Tue, 4 Aug 2026 at 12:05, Krzysztof Kozlowski
> > <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> >>
> >> On 04/08/2026 13:02, Krzysztof Kozlowski wrote:
> >>> On 04/08/2026 12:13, Sean Rhodes wrote:
> >>>> rename to drivers/firmware/coreboot/Kconfig
> >>>> index b78c644fa253..d273bd836245 100644
> >>>> --- a/drivers/firmware/google/Kconfig
> >>>> +++ b/drivers/firmware/coreboot/Kconfig
> >>>> @@ -1,13 +1,16 @@
> >>>>  # SPDX-License-Identifier: GPL-2.0-only
> >>>> -menuconfig GOOGLE_FIRMWARE
> >>>> -    bool "Google Firmware Drivers"
> >>>> +menuconfig COREBOOT_FIRMWARE
> >>>
> >>> As pointed out by defconfig change, which is supposed to be separate
> >>> commit, this will affect users of the kernel for no real gain.
> >>>
> >>> Do not change this.
> >>
> >> I am surprised that such change appeared at v10.
> >>
> >> Changelog is quite incomplete and I do not see any explanation for thi=
s.
> >
> > Sorry, don't follow - so put the names back, or split it into its own p=
atch?
>
> I did not find explanation of this in the changelog. It cuts at v9, so
> maybe that's the reason, although lore pointed me the v10 as the first
> version introducing new CONFIG symbols.
>
> Anyway, IMO renaming is really not worth if the sole reason is Google
> name is disliked now.

Krzysztof, the idea with this change was to introduce the new Kconfig
symbols that more accurately represent the new directory structure
while keeping the old symbol names available as fallback symbols for
people who continue using old .config files. Doesn't that avoid the
pain to users you're concerned about? I thought doing renames like
this cleanly was the whole point of the `transitional` feature in the
Kconfig language. Why do we have that lever if we don't want to use it
for the kind of cases it was meant for?
