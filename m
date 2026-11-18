Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F9606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXvkDnFE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511B10ECB8;
	Wed, 18 Nov 2026 21:21:21 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588DE10ECB8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:21:15 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so861929f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795036873; x=1795641673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y30ni6xyjZkpdJ73if1NkuwLR6cF+n60eri4wMvHUQY=;
 b=EXvkDnFEYWCur2I5DeVFDnRfT7UwUDI/MLYc6fSdmBulmLEjqkaCVKkt66qQk7uXio
 v6GaONRdfxJN1AviwJ9sTK+O4WGaOZo8W/AzCiboO4jQlOut8Qy2LxGiNhBmB58NZSOE
 tqZFME1vHVWdo036kH1kIpQ+93t0dDXi9u+hGdXpe1g47hzWsJDRc8xdQGKVc1ZsspII
 EZgj4bJDUzA3VpGX/9/yLX3tprlzvh4SCzy0Go6e5PRTuVdg0p6Ql6XMxlPuF72gtPU9
 nc78h305KXVtsnNiWl+7AVqSRs/zt56MJrP6WVDkLyWSeSsgvEAMcWNSD7f8QXWbaAeK
 xm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795036873; x=1795641673;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y30ni6xyjZkpdJ73if1NkuwLR6cF+n60eri4wMvHUQY=;
 b=oIipKRBgYu9VyhLj0NRFPIRvJldZy9bEf44Om6FUvu6oiFVPlu7LMQXlkBk6Wv+3Qk
 MylWyuZxxj6sMVTLCg3qRCVaQ76aTG5BiREGTEbqTfcxTO8fpZKBYs/UtuNbfjjeHRXR
 RMo47BS1wb+PJ24UwP8Wz9GH01fPV6rCNNACkI20pLWZ/hY7Q1B620LOETlyMP+XCoG+
 Dnj2pBUsuvi4HLIRtLVsNOJwJBm4nmePTCPvp/W4B5edEBuYLaxsum3wLPFasjHcmHrz
 vVkxuoNmgxOhIjVxTwJ9b27cLkbqFnJPZkDY9yOv+L1A2PvglMVw64dTIPB2de27foBX
 Ow9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF069N6+lmCX42/ZEwv3Qd6Bc8WZECT6GRiVZAfwm8a2FdKQWALbBAIJ4m+O49ZkcHjyORTZztxl6s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kjgLyEf+OxjJ5Cv9/Cbo+Mj9VM+J2NHonJRwGOlxo2UrEwd6l
 FPs9muVOszvsdyhgtRL5PBsAh6rkjirRvZXxaqS7K/io2GTqiPe0LzXD
X-Gm-Gg: AZFdTZd1+VX3zAdYtHCgPcEHbnCIUXamkRCTlb533S+8pw0d3APDj6CnUyL7pz5fS74
 yCO43NqrGgVO1JirqptdfL2jY2oIgvKRKzh807gcYKx822tW1g7rtAPBXo2V75WByzzEZcMF6oy
 jWcH6cfz9XXIwAS9TPRP2wHQGJk3/QvrQiYJsVd9s49aSRBuPhn2Sbqk4ALj5JNTBD175mLeVI3
 4AfOxys0MKnJVDnyVfbei5BXOn6HmfoyDIov8JXcNkdf3m+9OoBMRw6LSMyfqAx86vvHzq49I/0
 Al24OFVqnQbHpzDiaEoNVSs9tK17+VAdSPXclhH/x7yiwmjYr+U6+Kn3sf5xivY1Wb6l22ipedP
 cdD3ktwTp1j21sqQVx6/6FXvmOZ3YuLrgBow3xXzmTkQ9Y2sUg3NMtYTY8gfZ2WLY6Fimq/ElXj
 1W+tUIMTjaUWe3iC7mcZlVS6cm35rqDVWizMX5B3y4JUWmKhkIcMc4JQkWBZfSQ7U8aikmbXRMP
 iPjJbAn/w8H61IhBzAdyqxNoz55EC9waAF6KVy+Pr7DF+n6kEMbRci892KwMYFJlEsv/08CfX/m
 0o+xuL4lD/KPOOeiMvlT3p3pfC9BXPLk6FzN9uilqhqK6JjQoajbvtY=
X-Received: by 2002:a05:6000:46c3:b0:4a3:d77e:4659 with SMTP id
 ffacd0b85a97d-4a633a63f73mr5867941f8f.6.1795036873420; 
 Wed, 18 Nov 2026 13:21:13 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655db6d45sm6763321f8f.33.2026.11.18.13.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:21:12 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] drm/tilcdc: Implement state readout
Date: Wed, 18 Nov 2026 22:21:11 +0100
Message-Id: <20261118212111.150938-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <avszNevIGlq-SKmp@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <avszNevIGlq-SKmp@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 05:50:31PM +0100, Maxime Ripard wrote:
> Awesome, thanks a lot for that. I was working on sending v9 today, so
> it's a nice timing :)
>
> There's some redundancy with some work I sent since v7, but it looks
> pretty ok.

Thanks! I based this on v7 and missed that v8 already covers patches 1
and 2 (the install hook fix and the panel bridge readout), so I'll drop
them and rebase the tilcdc part on top of v9.

> > - The U-Boot mode doesn't match the one in the DT (16.94 MHz pixel clock
> >   and slightly different timings), so the first commit with the panel
> >   mode does a full modeset, as expected.
>
> I'm not quite sure I understand what you meant here. If it does a full
> modeset, I would expect to see some flicker?

Sorry, that was unclear. Nothing happens at boot: the kernel keeps the
U-Boot mode and the logo stays untouched. The modeset only happens when
userspace does its first commit with the mode from the DT, which is also
when the logo gets replaced. On this panel the switch is clean, even on
a slow-motion video, but other panels may show a glitch. The real fix is
for U-Boot to program the same mode as the DT, and then that commit
doesn't need a modeset at all.

> Yeah, that's because I wasn't supporting partial pipeline updates in v7.
> It should be fixed in v8 onwards.

Great, I'll check the comparison again on v9.

Thanks,
Màxim
