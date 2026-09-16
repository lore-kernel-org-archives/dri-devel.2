Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992EAC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA0210E6DA;
	Wed, 16 Sep 2026 09:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="StnQpLd/";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F5E10E6DA
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:44:59 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469a34907so739952b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789551899; x=1790156699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmkBm0qbxpkVGajcugUF9Qtq+Mt2sXz79zpfIKtN2Ss=;
 b=StnQpLd/vgwSgjGxiwozTvO3lhFL4dPytA0VkuBTuEeKyUnJZkMahtoxAueVyCZR9a
 q7sb5I4ei56Jtw3SyT3OiroFqSZWsUU4rOT6SgFAAlQpXcAfg19N5HvsMJqinepkW1iQ
 pqrqf5JBctp8h+W7OULRc8qAeDJ3cFfL3dl5QFRj5BgMptqHjGZO3MgTAhkdTbEPrJGx
 AjIH2bACOnUXvsg4k5JlRsSFUUNIfUrDpEvSKnFVtli7sGeiaDUhwktdyH3qZSXQe2XL
 Si4J/wZ4/9Yq85TxsAwUEHzMSWwa032ZmQpkeMz3p/pE847jHCgvqfx7KISTCWIYm3QM
 PBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789551899; x=1790156699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SmkBm0qbxpkVGajcugUF9Qtq+Mt2sXz79zpfIKtN2Ss=;
 b=vX1gcV3C4kvdTr7qqLUDoj/sDyJWtIPZk1UU/OVpxcFVGj9nbaB7qJCa62+xMpNxdm
 y3SHgzt2zL5v+MspsyJS8WjWfubYwRXIs4E1BGW9y3v2gpllxOOM7Cm5H0O+p+h8cZaz
 E7GVXUHMT14qaKTqlwZ8qVQ5bRXeNTBrYfm9ICdmyaAaID9pfM2UUQ6PQCga7X3koNhw
 vBhlIZmJgzmMfHssIufun2iHGE89oomgYWvJcCfINM783+uh+JQE26xDhFVWp9i/jzTB
 zJdIi03uaaOtINJ9qMYOb9Je06QDLu4O9eSUTUgLrqoeH19p6Bjmg7kJLKsnfjbjFF9P
 Qhgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/6vOFRVZ0HTQCRdx3tj2hueIIN22RX8UjfRY1jROnzK0sJRsEtU9VK55550V090sC/nv0VaKpZbQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpevbbwJVfRkFyV/hTDGvsYeNs90Nu2pS6jckAleY2UHB8zhxh
 HO80+6Q+PYFQEm9GokGHWQsfrdt9j4CpJMhnlb5XghdkNZfW6e3Nos9o
X-Gm-Gg: AYBFou0w6CvayYAsPTfPY0tTUHnJOdgiBGGPdC1yEuQCIBiqZom30xlACHZ1oOZ7/P8
 uAPIoWYEaFhuVilhMRQw6Mp46vudPWM+pPd9MMDEm+f62akdkg5RiXgojgJADsxC/fUED+gR0rH
 zu7TxiVLt9caFHBe0aqRaH7Enx25N0Ki8ZaAy2WHlxPRJfqeA//xw8mKD5hDfosPpkVYbR8w5/H
 Yfx+TaVPz91a0UUImP8iw+Z2IrIhWrivMZLXpD52Wj+QjaDH1QysOZcvAeuB9+eFm062Za5leBD
 K/opQL4s8D7Y/laNTdHMOmV/AmHmWAwbNnukO7G3HbxjLzL73gjHFJfUZ0tNwaiyEeKFTvK28aE
 n9Wiwm7C+/taFeGHNkTCgnrI/f1b+0aJiyLE7fa6cNeYJV8hva/ppiIpNRvC7o0pKKXNHSBAGnU
 8qvFQzkIhzSTskJ8fZW/BdCSezdHpXsvYAxiiXwFDgLcvK03qUY6JSd6J8V+b+0SfNmpf4IJuh5
 vZ59VueymWwGjpGS0Igzz0/3ilaCn2VqJUMEhcjV68ZvHkpSH2DODBbEoAqYCtzRL/Y5DYD6UXx
 XANjD0pwwns=
X-Received: by 2002:a05:6a00:f04:b0:84f:3f5e:f072 with SMTP id
 d2e1a72fcca58-8723b391635mr4037389b3a.10.1789551898837; 
 Wed, 16 Sep 2026 02:44:58 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower..
 (125-227-154-99.hinet-ip.hinet.net. [125.227.154.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87201735415sm942890b3a.42.2026.09.16.02.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:44:58 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: LiangCheng Wang <zaq14760@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Wed, 16 Sep 2026 17:44:52 +0800
Message-Id: <20260916094453.1062125-1-zaq14760@gmail.com>
In-Reply-To: <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
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

Hi Thomas,

Thank you for the quick reply.

> Where exactly are these ssd16xx patches. I cannot find them in the DRM
> trees. I presume they are not upstream yet?

That is right, they are not upstream. Devarsh posted them on 1 May and
the series is still at v1 on the list:

  [PATCH 0/6] Add DRM driver for Solomon SSD16xx e-paper display controllers
  https://lore.kernel.org/all/20260430183311.2978142-1-devarsht@ti.com/

One thing that is easy to miss, and that I should have made clearer in my
last mail: that v1 series covers the SSD1683 only. The SSD1677, which is
the controller on the PIXPAPER 4.26m, is not part of it. Devarsh has
SSD1677 support in a staged branch that he kindly shared with me in July,
and that is what I tested on the panel:

  https://github.com/devarsht/linux-next/commits/ssd16xx_7_2/

Those SSD1677 patches have not been posted to the list yet, which is why
the panel support has not had anything to build on so far.

> If there's support for similar ICs, I'd strongly prefer to have the
> ssd1677 be part of that instead of a stand-alone driver.
>
> Once the stand-alone driver is in place, users will rely on it. Then it
> becomes hard to replace. We had (have?) cases where there are several
> drivers for the same hardware.

Understood, and thank you for explaining the reasoning - the point about
users coming to depend on a driver that is then hard to replace makes
sense, and I would rather not create that problem. I will drop the
standalone driver and add the PIXPAPER 4.26m to ssd16xx instead, once the
shared driver is in.

Devarsh, thank you again for sharing the branch, and for making room for
the panel in your work in the first place. I am glad to keep testing
SSD1677 on real hardware whenever that is useful to you.

Regards,
LiangCheng
