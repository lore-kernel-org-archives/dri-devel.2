Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7CCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615BD10E8FD;
	Tue, 16 Jun 2026 08:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NuIHvlcE";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE3610E8FD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:39:30 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-842358aaf36so1664737b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781599170; x=1782203970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4Je8IwSJvG/jfPJ4CeCInyfi1a6CXtfdj6NR9s+scU=;
 b=NuIHvlcE5CcO2oc/OV5KXDl/zxg+lMUp5TeXqfo8uBeetDhqCJDrKBzsqiJFUpythw
 Nx4R+XPmycjhVMe8RgSv1UP7BvOqP1LjQgMeshiMoG9aEFM+XDK8jGbx6faf4UecuILw
 1WjeLIoGnWV1D0okoujLygfqKaba47NUx09JI3V64rcNTZagOxnYmG3+XEnUt9DDyto3
 75OpJ0aiP2jEnCJwJCMniW+/GmgIepSFh6mYfRKd+FrTtL1i6el044BL7AR10vAeu0MT
 EhzWKzISrovqfiYJPQ64Sbqmn55XrWEawuX/fOvhZLYxODV3IFQkKe9CsV10ZJLxJajf
 tCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599170; x=1782203970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4Je8IwSJvG/jfPJ4CeCInyfi1a6CXtfdj6NR9s+scU=;
 b=UTF8tdEntKqF3qC0/+YuO/f6V6UIqfa8sDWLuLHYTmNjJ1OYH1tLm4ZC0ogPPgZ91A
 siuhkq7PnI2djT/ENcUZUyXgzQTkjyh5kinzPyENoxflek8QUvNpYm+cY4eAHpzDMbZ1
 Uf+quYESTqCJh2GasCHSsYuKjavcZdFmpiREeoLfhLz9fowwgR4JLiTZoTkeJFtX/Aof
 zF4R19wp0Y18vivqMf5nUDLFgE5Vsea5yoWGBO0PCaEtPbDtoy3SPtNlsQwLstOtHfsC
 e58+IuCOY+bsxTlDQaplQDdJUY51v/3zyMVHyeMiXz4mkaCPv/2YIxfrSrfrskRRJszk
 4t6g==
X-Gm-Message-State: AOJu0YwzvXzKtgvQeoXviWqTfW1phr/kwiKsWU28w5L4Bo2OB1hI5HK6
 EvG7c0Wls6jucBhprgyBVyfkahWDdKQBqpSCFaCgUpj8Hjc2F4Pgp+xd
X-Gm-Gg: Acq92OGUOFfu8Pr70+/P0juqn3zs6OaaDYhvlXTj15vujXF+C71lMBzB31udlrEHMne
 tZOjHsI1NyKAMxg7jdsxXi1+anFJOHDJAPCoZUnhveCUeEj4DTdZ8jGk77on5MI48PV2sthVu1y
 fIB+ATvFCfAavNluEWo8ZH1Dkg0VQST4wqxjvR3scmrBnSlCOwIgEM93aqPSmfAXgdx2QVRhfd5
 1cQ1eDbBi9kdmYRAgmHLP8bZ8AMKpZrtQt/Ji80f6UF+v/tHC96oK87f5CoekAsPzkHMA6Aeykm
 AlnYA6KH72azKZBSY78BNSllHNaP6+pV+XPWdSy/PQ8jSmSSnOLBW2h2yfzDEDFW0pLP/6lVsxr
 L496UUHouCYF5/fpapXxGp19kjhWNRzZU5741RCZ4nibxtlX6JxHX7YuvY1uaKVJyDwUMHRc7a6
 /PaTDcQb/dqXfmsQRnSjB+UtBt3sLjbB28PkuxLnNmepDX75WpJn0bnu1t7U2QVnO95PuU7C1iU
 19grPqtpkhZS1SibS36eTbIOjCH/G/Rh8A=
X-Received: by 2002:a05:6a00:4399:b0:842:2419:6c0b with SMTP id
 d2e1a72fcca58-844e19676f0mr15311972b3a.10.1781599170061; 
 Tue, 16 Jun 2026 01:39:30 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9dc87sm11497535b3a.4.2026.06.16.01.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:39:29 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Tue, 16 Jun 2026 16:39:21 +0800
Message-Id: <20260616083921.4066690-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Devarsh,

Thanks for the detailed review.

> 1) Could you please share the datasheet for the display controller used
> inside this pixpaper version ?

Unfortunately I'm not able to share the controller datasheet publicly; it
was provided to us under NDA.

> 2) Does 0xFF or 0xF7 mode work as well for your display or is it strictly
> 0xF4 which seems to mean that analog and osc bits are disabled ?

I'll test whether the standard 0xF7/0xFF sequences also work on this panel
and follow up with the result.

> 3) Also could you confirm which display controller IC does the PIXPAPER
> 4.26 use ?

The PIXPAPER 4.26 uses the Solomon SSD1677, so you're right that it is an
SSD16xx-family controller -- the commands it uses (0x01, 0x0C, 0x18, 0x20,
0x22, 0x24, 0x3C, 0x44/0x45, 0x4E/0x4F) match the standard SSD16xx set.

> it would be appropriate to add this panel as a new display panel entry in
> panel-ssd16xx.c rather than a separate driver to avoid code duplication.

I agree that consolidating SSD16xx panels under panel-ssd16xx.c is the right
long-term direction, and I'd be glad to converge there.

I'm not yet sure how SSD1677 would fit with the controllers your series
currently targets (SSD1673/SSD1680/SSD1681/SSD1683) -- ours is a larger
4.26" 800x480 panel, so I suspect it may need a new controller variant.
Would you expect panel-ssd16xx.c to be able to support SSD1677?

In the meantime, would it be reasonable to take this smaller standalone
driver, and migrate the panel into panel-ssd16xx.c once that driver lands
with SSD1677 support? I'd be happy to help with the migration, and of course
I'll defer to your and the maintainers' preference here.

Regards,
LiangCheng
