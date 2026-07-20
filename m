Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F31C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463EF10E19A;
	Mon, 20 Jul 2026 13:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t/Tf6e0X";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A77D10E922
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:09:50 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so18642895e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784552988; x=1785157788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+h2Q619dl8wI7WNCJbvozQ6DDMbbno91znOwGOQgLhc=;
 b=t/Tf6e0XOhRA7g7vC1wD+XnAaBkAS0QaNK64Qy72HMtVE7As7rWTb8yu4U3jdbmS9K
 oHlpnKAFjjpJVznLfARzymIWh1BrcRWC8rU6t3uvBoknprrN7w3FWI/M+zbY3ylXTj+R
 2jjIoDIKz15XOPo5NJaRzQAJImWzVvNNcGu5lsQuwY7vvsccc4f/JHxwAPt7C/zHewnI
 buBcyOq5+3NIyIblhKnx9fcIsEkf+CTZVL6ffwCsldGXeAxuKu1fSTLnMlxtxCjqzZaF
 MAGvcTakrHrXAL/eLoObqKP6MBFI0Zc6fANKaVHVgCA0HUerMx3fhl+3AXuI/moTj4js
 iMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784552988; x=1785157788;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+h2Q619dl8wI7WNCJbvozQ6DDMbbno91znOwGOQgLhc=;
 b=nUK8XSz53+av2oRdJh7uKPMwIeoXuhUIR4a+BTe93QQ+OargiwNe++mjB8AtlDeOC7
 ia+x3wC1TmHBYutyp/AD5mACNjWJ/hF7CvzDUGeL5/+ZESXPPz8zjEljMfm2pgbs4AVk
 O2Y5bkUXzJWAV0/4TXkBIu/yE9jHMjxPllL2Id90YUVEqJ+vV7Yg6rdTq23EGMVpPU9i
 VRPGtFevE//kQcC3BmaJXjfSbXpRsiBBorkiZnQ3zLHPvoD9qsu1X6enWBjosR6gUIRF
 7SNhh/TzYujsuikfJcoYXEYOT6ldUXBVhT8Af2POh6/iw3lyMzZ2RxoR4wXh0ZbXqQxd
 p1bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUSnP48hTHQczCGKH8sEU7QHiTtVz+2stOaI4O0n8obaKLLE1wmhKqjoyrxAZaafa/gWVyQOrCoSQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPgtmt6lqQFnEJ8znu4cFM0xnC7TAHJZYCBuk0w7JVAoGPm+Wz
 YZMealAe6FJl7WoiopMxQebMR1R5AcrZpnilj1SrHQljA5nyJfbpa7K2CpidRcmlkbs=
X-Gm-Gg: AfdE7cnvBlu77mgy8uHOb5ieDe7wofcNdsuE74PppC17RQNwTJXO2+Bii+dKkBs4tEH
 vFP0nCuSvnRwChadhrmjmv5ck2BnIqDvKKLVBbZvVkZ3+vYDUx+ZUgNMnlwLPWPTqC+V3YgqaZ/
 YdJafEA86GFrYLW1xzKPVhDX/6up4dZqDZBkHcVxJqeu4VudcbL8lRYxIu7UlMScvryfm8qQF6l
 eSQf4oEdUvb5guvCKR0ahQfitWk5MlAhKQ1f2a/6Lh+x3K384B3ht081BNykT3Y+81/zcWNGBnP
 MYayxtkKJpbIzV230sQw5XlpTId2jI4R4/VnECifh73LlQWMetADLkVh+/MKc79eDdQj6FVdw8t
 pRuClcc+6lMF5co0ZTCIFKgWw5pBvtFGG2t1+sc2fguJw3vy7pGvD37yILmNdZZAK5TNsMZp++u
 kJx5ck9+rGEOoz6rClsThFsh4=
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49564829df7mr2659795e9.37.1784552988438; 
 Mon, 20 Jul 2026 06:09:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30767434f8f.24.2026.07.20.06.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:09:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org,
 =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: sofef00: Fix DSI transfer errors on backlight
 update
Date: Mon, 20 Jul 2026 15:09:39 +0200
Message-Id: <178455228137.789946.17345667385294508463.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
References: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

On Mon, 06 Jul 2026 07:18:22 +0200, Cédric Bellegarde wrote:
> Backlight updates via bl_update_status() could be triggered before the
> panel was fully initialized, resulting in failed DCS commands during
> the atomic commit sequence.
> 
> Guard bl_update_status() with a prepared flag to skip backlight updates
> when the panel is not yet ready.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sofef00: Fix DSI transfer errors on backlight update
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/72eb80d9f4e6c0493298bbf782c6a07a24b4e608

-- 
Neil
