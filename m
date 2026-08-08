Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D436C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19ED10E65C;
	Mon, 10 Aug 2026 06:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRwud9kB";
	dkim-atps=neutral
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723B510E47E
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:14:29 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso4932955ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786198469; x=1786803269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cRCYRkrqsjrsSzRNFotYZZ98meWVRPcoRMuLiucayfo=;
 b=gRwud9kBsxa3fajgZdnFJOHGaAJMrrMk+9zttbc7w46c62Rj5lxv033ZynjH7vjHXb
 Aak+M9zfTPbDsBa4ZaF9h3IIOdqRArSh5f3yDzOW5354zraxqF3aHyZvMajnRWcUDx0Q
 1ZQmAZPAE02oWS9msQMljo7IT2pfJzIpSR5siodjwcBZmMJyf4IKI254xwoVHazPBEww
 Z+ySehzlGInizRbV7gEaMOjMiaKxvqE/e6xHjwj7+IJ/k/lQrGPLDqRY/A4asLq0p0qV
 02JrNmnbTMROA9+Tg0sZZB9YR3lXCqbCOQbFHR8y3U6s88F8NbGtDqo0XYYb9F3ioqTx
 ei6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786198469; x=1786803269;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cRCYRkrqsjrsSzRNFotYZZ98meWVRPcoRMuLiucayfo=;
 b=BkMgVVLPiiZzrAN9otUc6vebIY+CL4rHbM84HQ6xS7RrXzUmLu9Q2xStxA2sQLgq6I
 Uvez3iOiJvxBWCRtp2O+zoPMSJdBk/5eJAWnjXSXyzEVjD5HpWK70TahkgwWv5pLg3s/
 XNVGHa/eI6JGwmfAMvTmvD+g0lWOr93al88IrgobpVqNiFg/++w6TvIue8Zy8W/b42t3
 IHF1vbh4Yo5o3i9kS6WDJ0gODdo+K2/G/1I+3sOLF50K7u2rfDzKRIT9sjTLso4stEsW
 bWxj+k237gv3LnuwGUy2kLZkpnOGq/H5kXrZJ3ow5bKT0OqPqlAZCCXOf/QxN0aa6txO
 8MKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroLEDyWOyb/xhoJUHHSfusqbQgUM1EAqN7LGkHotioWRDc9nmjOOf+qxyZEzV5rfmpR4/9sfcpsBc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9JJ1PSkN3rSezaxCZrDFbGW6r85NaxHD4byestlB40yuG3ORY
 ojS+moTwbh5chuRPn1NmhhJwCJ25azL4tiNeGyaDKfdIYAc+UyyesdIU
X-Gm-Gg: AR+sD12cDR/TkFXQYwNptPpCdRK6Ew5Y6FzGBe4lLAv/mP8kEq+EIp+6hnkCWO9quzt
 SR/sxpXrBLI67Kq+Xd+qFbh2ep8gY30Sbopa1ozjud3it8BG7fXmNLY3IsBNV++FT/NJkAZ6ZJC
 WPmVQSmdCqZ32FXonPVsLjY3Ow5PSvyT7qbZq12yj5NQUFx6AB7seqKL9KpRbxoxv7JqF7d7qJD
 KRlrO82SpObSp+i6EpBFeUQUPyRE5JnMdhToZ8MfxLA77PN4RiwTbG3E8wVA3vbGFutv2NiM4OZ
 KL5HQEwDaqhnFb1jDVQ7cTfu/ddtAbxclNE+uDLUYdNMn+EHFL04pZ2WynCCDGxTVdPx74ckQMF
 NA4LmeSmQUIP6jXiOhWZ2EH9/Z0lexs1iV6m70GpCjKQ+CFmguxag+Cu7w2S20WeF05rO5To8Zi
 2Ls/2pnpAL+MloFInv8eg5GE3WovX+9To6iysmiJ8=
X-Received: by 2002:a17:903:f90:b0:2c9:b2c1:13ec with SMTP id
 d9443c01a7336-2d294c225a1mr141926765ad.11.1786198469018; 
 Sat, 08 Aug 2026 07:14:29 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbeaa7bsm19180265ad.41.2026.08.08.07.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:14:28 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:14:25 +0800
Message-ID: <16421007bf6b2a251ccf51cbb5bf3694.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 05/17] phy: spacemit: add Innosilicon DP TX PHY
 driver
In-Reply-To: <amnzTxDYtSBojHdY@monoceros>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-5-6de34d80e86c@gmail.com>
 <amnzTxDYtSBojHdY@monoceros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Uwe,

On Wed, 29 Jul 2026 14:36:31 +0200, Uwe Kleine-König wrote:
> Hello,
>
> On Sat, Jul 25, 2026 at 12:51:14AM -0400, Cody Kang via B4 Relay wrote:
> > +#include <linux/mod_devicetable.h>
> > [...]
> > +#include <linux/platform_device.h>
>
> <linux/platform_device.h> already makes sure that of_device_id
> is available and <linux/mod_devicetable.h> will go away soon.
>
> So please drop the latter #include.

Thanks for the review. Will do in v2.

Cody
