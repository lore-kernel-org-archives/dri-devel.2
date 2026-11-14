Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11C606A88B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ik6H7g0d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D1D10F02B;
	Sat, 14 Nov 2026 16:25:05 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D5710E4EF
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:20:01 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2086033f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794622800; x=1795227600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D5fZZPHoNA80HLJCIs04HdBTYoqvhRKLX7/FlR/nB3s=;
 b=Ik6H7g0dSGeYCAdcDVS0xOK4Ej5977k6YIjJFpCA0VPnvsi6dw50l9i4UFVn3l7WbN
 CUp4So/cW5d5EeDEgbb9IyIXyTOXf075I+EkMZbw+KiU3lbVcffakb2PCB1WiVPOMXt4
 g/Ov1wjH/zlpDkV4sOoLvzjfadYYEws8cv4firJcIazSnqbStZ6poHp+B+63y3kzvomh
 YkI6k0fX5oY0JvKzEPtyLXCBaR4mnNTqcs11Z72It8hkAKVP1PVF+Rx1iVkqbm8B2gPN
 CNnsCoQaSJehwYdgohSSIuPtYeOaOusUEsKPCSstBQn+CkxqoDwuBz2u4vgT8s2soHwF
 Dc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794622800; x=1795227600;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5fZZPHoNA80HLJCIs04HdBTYoqvhRKLX7/FlR/nB3s=;
 b=yHNC/OC19Spnccr4dmrg4oDG61FtaykB+/J6SDS//j4SYfCKA+3V7j0McUVAbLiLXW
 cXVbRgJwIERNyZrFGMhMPmLSfefWmXqzTekbA6y0r+XECS40cbrC42we5eSMvsQZMiLE
 2+ZA+BFa3f/hrQDV3FDW86WMDZjFaagO/IgR+VXjMFKj2zX3K81unUGlFdx3gsnKnTL3
 zIqZa5htljp6YzWIjc8jioBvXh2DtaBtGB/XOGahWL1fgs44zZxZncUAZZsKxDH8wpq0
 bzXyXGN3Skzo1fa1vOQ21RG1q05KcrOjp4oeZlbi/DbSS6O6UZ06VQjUxo3zCb8AZFRo
 jr9w==
X-Forwarded-Encrypted: i=1;
 AL+hErG9I7VRC552y+Qz1sUFnc5Z31D0VTsMgiYJ820zBCSrUQOdawHCG2VtfOBhlcfUMV8SFTyAHTSK9us=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+19gcsu7M58RCWOYHQa9yeOxu+92NnHJ/dIen8zttY4BTQwaqd
 U3JHXZd58IegMJ+rg7/b752MFmE4mvL2jF8X3KIUOMIMJU5CLBt5wnB9
X-Gm-Gg: AYBFou3fW2FOzPdoO5NaqDD/DX3GFHYRGRQbNQqEy0BIwilLtzIuRrClDlIfBLXGjiT
 7Gek/OTmWcNkLX2CixyNG+MbzovZtMHDElI+hHlleu6YSmbRhaN9GZtkqIkw+4mIn7vx0ggDzYt
 xDIlINYxLo39rlM2rMzKM56ErjBHNP42/mBXNsfr6yrrNFyEDh/ri0MW12h43/4MbL3g23k5H7/
 +lqFZEW/x4XYbxMq6uPsM12dXxBUPfb71Rv4CYQjkr3wFh8mkWMoYUS9le6h2nDHPOEac0SnksX
 AzjoPUhAPfSfhVu55B29PiP3TqzyqvnfDEC3cFtRHmQ1kmpY/BltF5T2mCflcKSG8LeoJrpQJ7i
 083vcsYViGraWi6pLIUIZCymnR8RNeN+pxBqzam2oLexFbzq9y6H1JWlkrdnK6fhNJ3kAJzLk3n
 vkCga60dwhzXG6EYT62Lpp/SzTrGAzJcl3p0Rs3jvNkDIlpsN2ZPfqz6Jz/8DTYCs6utd1x0LGG
 zaSV4/HKFLJvIvZlXUaKdqw6K7eAPsk4ZtPGQf4JGJZ1TKVE6iBPZX63hEEngpeygLBDP9Tz2hB
 rzxUqeCMOA2E9eWB3pjfyjJiWIJPRIZRWvN580h0TOxC2LeqWAmZVdCT3qfvh2H/Vl0RcssUmiJ
 uGw==
X-Received: by 2002:a05:6000:402c:b0:48f:cb37:3ec3 with SMTP id
 ffacd0b85a97d-49c714a442emr9810855f8f.41.1794622799727; 
 Fri, 13 Nov 2026 18:19:59 -0800 (PST)
Received: from ?IPV6:2a02:908:e843:f280:6cae:291b:a1:8362?
 ([2a02:908:e843:f280:6cae:291b:a1:8362])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm13284412f8f.7.2026.11.13.18.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 18:19:59 -0800 (PST)
Message-ID: <3c34d3e8-9dd2-4af3-abfe-16907f7c1287@gmail.com>
Date: Sat, 14 Nov 2026 03:20:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel-edp: add BOE NE160QDM-NX4 (0x0d25)
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261113214526.231324-1-ingo.kubbilun@gmail.com>
 <CAD=FV=V7uw9s3BttHn8uLjxD8mt5=3iYXA8cRzLU=OYFtS65Xw@mail.gmail.com>
Content-Language: en-US
From: "Ingo A. Kubbilun" <ingo.kubbilun@gmail.com>
In-Reply-To: <CAD=FV=V7uw9s3BttHn8uLjxD8mt5=3iYXA8cRzLU=OYFtS65Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Doug,

On Fri, Nov 13, 2026 at 1:45 PM Doug Anderson wrote:
 > Please follow conventions from recent changes to this file and include
 > the EDID in the commit message.

Will do in v2. For your information, the raw EDID is:

00 ff ff ff ff ff ff 00 09 e5 25 0d 00 00 00 00
17 22 01 04 a5 22 16 78 07 ed 85 a3 54 4c 9d 26
0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 a7 6d 00 a0 a0 40 78 60 30 20
36 00 58 d7 10 00 00 1a 00 00 00 fd 00 30 90 f8
f8 43 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4e 45 31 36 30 51 44 4d 2d 4e 58 34 0a 01 0c

70 20 79 02 00 21 00 1d 7a 0d 66 08 00 0a 40 06
80 3d 7a 54 cc 24 9d 66 02 0b 02 35 54 40 5e 40
5e 00 44 12 78 22 00 14 99 47 0a 85 ff 09 9f 00
2f 00 1f 00 3f 06 77 00 02 00 05 00 2b 00 0c 27
00 30 8f 00 00 27 00 30 3b 00 00 2e 00 06 00 44
40 5e 40 5e 81 00 1e 72 1a 00 00 03 01 30 90 00
00 60 ff 60 ff 90 00 00 00 00 e3 05 04 00 e6 06
01 01 60 60 ff 00 00 00 00 00 00 00 00 00 2c 90

 > Please also provide more details about how your AI agent analyzed the
 > ACPI tables. Did it use the ACPI tables to determine the delays to use
 > here? […] or did the AI agent just look at the delays of similar panels?

The delays were not derived from the ACPI tables. I wrote this entry
myself and picked delay_200_500_e80 because other BOE NE1xx panels in
panel-edp use it; it has worked reliably across many cold boots.
I'm working with this machine on a daily basis for two weeks now without
any problems.
Only afterwards did the AI check the ACPI tables: their panel 
configuration is a generic one ("Panel_Generic_Amoled", backlight PWM 
settings only) with no power-sequencing data. There is no datasheet 
available to me.

The AI disclosure in the commit message was a generic text applied to
the whole series and overstated its role for this patch. Sorry for
that; v2 will describe it accurately.

Cheers,
Ingo
