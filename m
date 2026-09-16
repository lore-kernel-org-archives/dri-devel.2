Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B8AC982CD
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D8410E854;
	Thu, 17 Sep 2026 07:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DqqdrmP9";
	dkim-atps=neutral
Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com
 [74.125.227.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F41710E110
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 21:44:18 +0000 (UTC)
Received: by mail-vs2-f43.google.com with SMTP id
 ada2fe7eead31-791a9878aa9so83192137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789595057; cv=none;
 d=google.com; s=arc-20260327;
 b=f8714Sn6b0FZHxhy1CEga2vimxQqlf3D8XEtU0H5MK1uwrAoNlNiQOCgxH6zbb5KMi
 ol/WhT0IqocnCgcHrKxr+GnOULNgzbKltic24JgG2/ug9XB+pmmmACYVnYXqx/DzZxIl
 +8iHVHvlwKyssmwBptEwPaVZBP5HmnuORKwd0hlGc6wkrMt7XvavO1JX4kgPbKK3XxFW
 0u1+TXAOVnJINWuCH7uTuJwnAbI2RDQxKkYPzChYMRonXV7NNwuO8ZZbsanFvbw7Z50d
 vtySpkPjs/NlcN4+4OcpuUrZ4fJ+sfOMeBxNTTXxQEC6S/HeoZtfWqh1MttUbY6CLiGV
 QDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 fh=yiC5+mmHM9OHHMvHBvDHKgb2Ftx/4T2QNN2eB/I03VA=;
 b=k1sUQlcJJk3sCEgCyPIQXeZBlRGlIHyb1i539raSW0fAE87hPu6NonmCd61L07njmZ
 CMW0akMqcAFyfqdPFVloGyzIuNio5N3IxMMlsKBDXjz2jUo6j0a/mIqx8x1Gq3l/JO3Z
 fzdC2ADSJcEy1tPerMwU9LluFJvDzPXWzdwThnRZ+ANCkIJ4Qke4yZeaZ+FdGZ6TeN5v
 48D6XaCjyhiltOUdhXGU8NT3m4LLxtQ/6svQr1/JEaHyVVqBUtZBsJ5tinQH4itR0iA8
 TUIKdfo4znaQH3YkB9PNYeKjcGbSLebkSYy6rH40gCOiuNqRws2pdsGSlvYpaEF3ZW9P
 EWnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789595057; x=1790199857;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 b=DqqdrmP9gAmiAVvj2NjHTFHVeBcv8CgrTKqE41p4bZ+yUh1SYNTSduUS4eFKYqYlo7
 BDZccIOIgMw4lNV9VE9nfY2zcdz4+Dddn5e/oSmEgm9BrIIDZ0F1gvpDlfayToI69mAg
 ACb42Ce49NiWW0GlXxgObfd4k6QPriivgrxUH6EFU7Hmt6uneTa3eTHMlv6SzLecOUDX
 rhBXSD2EW+g1lN0rkbaUQi0ywxlcYfKSAUlHZ+h3LCxFM4ExdcVqhHo5EeRDnIGfIWnI
 UNeXi6XeW0gcQZyyc9YRsZWK001ZIRsRRGmI7t4J0wGoH/uUUjs9Bu/iCyQKf2JWeNZD
 s9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595057; x=1790199857;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 b=Q4BH+a2JPqNxttPfQEefYKjZH5xhrRfOEzhKw8SBhDhngOSV4GIMt09zwyP6K2xka8
 vPJTkMsi6P1sH/zWohQRBjP//zOkxwIfCDoEtEilOMoY2HIarns/oPO9w1WYKXcnLe4l
 8mDRPS7fhoXtR65R5Mi3E9T9x1pWXwyNFoyUNZm1V9j+wlsHHgjlpmUlw8lS0/eGhups
 aDd2CRw67CUfAmM1zkwRfEtsnKe8ID56VrXqZ0MmbmlbVSWh6/2Eyele9D89zYuVDS+B
 jSgDvWFbJVpX4PQH+leTKAlekHWgKPrkOAJYROhHkgAxqpj/fgns5HFjOzZdaqMt+ybB
 zpiw==
X-Forwarded-Encrypted: i=1;
 AKwUvByu23XpP36Tm74idKF6AR8G67tv4raSJq89eOznZX5qz+5MAF4LaoTBeM2oXEhst/dFkUQz4hAEk9A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k21A2zerBtcmjQm7CpCXQ0VZRy91O8JlPdhDkgmebilkLU5pe6
 0Y/BX+zFlwgcoAfaseMUhu3OFxZxe8kS6p1iIgFDBzFfbpdYPZp8LyyIZBxBXaNw5Pkdggz/ZZi
 cBFX7YngKa7yuA9GFg9YqVi+IcoWY32umjj7aKAs=
X-Gm-Gg: AYBFou1Bs4zO0vv0WcTbQOboWxhvrOj9PdX2Bd5erTfXpBoCm3lf12wLzs4jF9IhhTo
 17dA3pNlzA9C1k131W2kpXcboNTTpGeEmN1qQT/tPodue4SkA+e0IISOwZoQLsXS6hyCoR3ueWP
 Fn1x/TKXfAIBAEfyrUI8I+z1zfFZVZ2LYqjzrCAaMRkBgv2bpVAzJxLz71CTEBlggBo2EpULvwz
 iag+ZCMHBIMs3pTCbJ83cwYtbmYn8HzbW2eT97QMo7pYgVpN0akoDAar7SFXIxuOBNZYCrCDoo8
 Uepv9jH07e6oKfahkQlaUTuTJf2hqMw+Xq99WxN2+WXi+pLD2z4ICqFr9CepomIoM4nBch4F6Kv
 yquellT2qSFOeJDLP/aCh
X-Received: by 2002:a05:6102:a85:b0:7a2:2a6b:e7b4 with SMTP id
 ada2fe7eead31-7a22a6be8efmr62586137.2.1789595055938; Wed, 16 Sep 2026
 14:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-26-morbo@google.com>
 <202609151258.5FC01072@keescook>
 <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
In-Reply-To: <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Sep 2026 14:43:59 -0700
X-Gm-Features: AcwNN1XbboPOY3deKY79Gty15vkSErYIT9HTgeQdVXaDzFhBvm8_kiOA449bIqU
Message-ID: <CAGG=3QVZRCJ94+DOfSsSDhsrXVYf-ec01NZBy299nYiCAYfXKg@mail.gmail.com>
Subject: Re: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
 codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
 linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

On Tue, Sep 15, 2026 at 6:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Sep 15, 2026 at 01:00:00PM -0700, Kees Cook wrote:
> > Seems like seq_buf would be better her? But yes, at the very least, thi=
s
> > needs to be scnprintf, not snprintf (or add the checks as you have
> > here).
> >
> > The rest of the seq_buf conversions look right.
>
> This driver has been an orphan for a while now (we just made it official)=
 so
> I'd prefer it if we don't do anything here.
>
I'll remove those changes from future emails.

> And yes, that mega CC list is just gross.
>
Apologies. :-(

-bw
