Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267F606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=CxMdBpVR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21395112487;
	Thu,  5 Nov 2026 14:36:30 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE25112487
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:36:23 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so1977804c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889382; cv=none;
 d=google.com; s=arc-20260327;
 b=IdLIIiQzAL9mBFm315mhvgLIhx8zFu+f2dANV7ZkqbtoxgiVM5sFWUSZoENSKJ9iMh
 C4ei/e0T+ACQEEuRNCslOxq2CqhG7N9YpjvDt1uYnDo3KBgRAmN6G62DIp/SPAX4y7J7
 I7jLxQoByIURbjVsekFlG18/oFNXAwvEj8cA6YIC8AkTaK7bURDhhG7/IsokLHDba5Nj
 C/XVjBGhkR6PSUwOKE+Y2xM/LThV0TUWvJCylLFFUQA6zpsuyorQgaj7G1+vJcfGx3FG
 dQDB4/28VBX1j7UiO8/np6Pkl+lyRwkjsZipPZSNX7J2GPsoDT7cnxDzZCjE7CKuM4YP
 lEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Ymc+4AQvzzaiCWsBbLGU5SMznTThrS02qv+sUCHS1I=;
 fh=asage0K7U8DocCvq1xa8eilVpG0P1T9W9mNFiLcXz14=;
 b=WensD2r9TivA/IEnqgBhk7YvZBvbBzQMk37ECbQ/wQPbaQ+Jt9xb7W4LmEXSwTToxv
 YLX/gnwScSGzkbDEMQdLDitIuxP0hDpx3rTz9kyDRQtInYiR/2MIb0kJxPkXUTMBYk3y
 8f5o2Ph0sO3luB8MJwIhD3g+RLBntYbr5fCnZlKlqjoXx6700/Xt8XJKIFFkzaEU8jlw
 75galJe4eFgHoL/hCJqOYw/ryYAFDNRDk4AGIS2005k4iwwKwtyc3Au2tVKBoomQVsXd
 Z0J5DCXuU1v4uza3Cx63w1NucR0HItwsK3xKcImVT5GMtA+2rYOORHTnjf2kGYTOklV3
 iNug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793889382; x=1794494182;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Ymc+4AQvzzaiCWsBbLGU5SMznTThrS02qv+sUCHS1I=;
 b=CxMdBpVRED5qbl/rLJZxK8tBfSk/8AYzfUzQ6IBNqyFRpv3TJvLO0QXN/GHCJVlh7/
 KY/Ik/fTGLrXHhFfRDvH+FUbj4T8QOQNqG0BQoe/sjYSKSNlmSVIJQvUQYW7luHUhYG8
 isn1ZsZGp2Pah3QhLIxXNgAzLWM6OiGAF6Iz3BnA7ILPMNdJR8IFFsRUNgwdY2+WuuBf
 WNb0gr8FICcFa0j+J9hs6UyAsBistQkJFumHHZejVeApnQZMxdiXmVSpTKAIQq6qhy2Q
 Nf2tWBGwAtZ5u67Iv397rfTgC2S1woXa2BPxstm8Z8z9J2XdRCs3AycCGGBy8K1xntZj
 8XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889382; x=1794494182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Ymc+4AQvzzaiCWsBbLGU5SMznTThrS02qv+sUCHS1I=;
 b=dd5MG90XVtU3iNT6I4sJ8LiseGDgGqIBHjIczuGlUmL51n/lzH7lsyjUYSgs/VxNeq
 7RXIz2F1/uHN8kQ3qhm7/O7OyH47XWvPqzYyiQzA2qlBZJFmQlp2wR9IxGJFoXPzoEWW
 AfCbDBf5d/BhXt0C6rIkJp2KVppubM+HN2I4FcfGbgbdC1GEy0tcKH48GnAukIGeu9ga
 Oe7TqPFZbyQOkf8k81qtzsMpn9cCDU95SOgBTkif07dmytUrjVd77pcMXoXbEa96WKxA
 mFtwoO/Tq6fi/EVqFLqDBKqzDlxPm2NfmAnbiAxzPsC1kgHPGXNexrKcZ7IE4nTnE3ip
 6rWg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMdi9DxTEOHpHNZIIQcuMW3JURYbVvPRfCfTlINdBmGI+I96M2WAhOvMNwPikvns0uuFn8nhlLj0c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+N6Wnxx6PvDqgYBMZF6LcI1uUNQZtb41R/3GWVN5Z+Ul3ZJWWV
 UvkNQcPcduiY8FHFS0qTpnRQVLgQocfR6I3dDQMpEbMbKNK4aBqmeNQoAFEraNe+361OAI88j0n
 7ZV3/L7fSIjQvINbyNrvd2NpeshCLYbyJ778eq3jaew==
X-Gm-Gg: AYBFou3qtJ77n5iK7LS8EJzicnyAUq6wzxgoXkCyKcnh/lZNzjrVVOu5hybLkfbpIss
 1A2OM848KnrfcOV7tQoNvydYWgoUalXjPXpViZiSSJPLbc02fa/xg78uLLmgb0dYVI0wEInvpyB
 Fww+T3g046L6XZO0YAHh3iQlnL+lgiIaAsy0joPCj4e/XmaiCHCZL+xwb+iyHJTmDw+QoF1APnI
 gnEP5y0Nu8cDYt6RVZlz4SSZYEy8MgVS/HHsx3pL6bxJ9SajIYaTkzZTBh1sS/wV6ZxWYTYadm1
 SRIgUPz2OiuGf5cr1GWKI/3m3y9K05025w1ZWG/MjAL7bQ6BZ3wWMpAeOdA4riV8rPAER36gGjt
 SE2NGdIYEj30NuyTfC6ix0m2ZNg9XxHFSCwFy
X-Received: by 2002:a05:701b:454d:20b0:1b2:3b5b:b80b with SMTP id
 a92af1059eb24-1b23b5bb847mr12680614c88.8.1793889382405; Thu, 05 Nov 2026
 06:36:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <CAPj87rMQdE3eeUxGSb4oQfB4Adry6UV8CvhGoTKtdKGQHdSo4Q@mail.gmail.com>
 <81fbb960-abde-44ea-82ab-3adc054da836@collabora.com>
 <34506010.aRNtrjHk3s@diego>
In-Reply-To: <34506010.aRNtrjHk3s@diego>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 14:36:10 +0000
X-Gm-Features: AclHuK-P65od5HCTUxTkNtF8XI9WRdmLEVnuoZ_IAiO-y4WkOrppI1hKYcCtIdc
Message-ID: <CAPj87rMyMB05OTMDLSPe+oDZJYUW=oHF9E-f2LaTPCsBrKAAhQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 13:22, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> except patch 9 of 15, or mail hasn't turned up yet :-)
>
> It does look fine to me, but if someone has an eye to spare ...

Nah, I just forgot to send the mail / was waiting to send until the
dclk reset thing was fixed (I forget which).

Either way, it's done now!

Cheers,
Daniel
