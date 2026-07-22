Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DCC4453E
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4310810E431;
	Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FnzzTwyn";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805C510EDC0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:15:37 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f8773ce8dso400387f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784722536; x=1785327336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lyxwzSpvGQN879gUQIzhLBDWPp/ka/KsPTZu5mIF37Q=;
 b=FnzzTwynS0sAfi2Qny/PBNQnHxPSh1Har4x/8/Zdn1qiwAZ3pqSbkSyExcG3BCJizg
 +PIy5AlfVB4tCzUJpJe9oxOf5UPxtMuD+0YIypevBXvyFjz7AXomELEHkWvZ3SZv3Ziv
 kmq7fLUIAGBmFB/wN1B/qVB9MSp7bLYCSf+8wIUpKUR3Ceks6WnMpduvavuixFKpNFKs
 vM+sFCo+/YjnCNCMGFxNoz4PBnm+opVadtZH6Aohm669do5MDC5zAGLd/DHSDleUvU7B
 SF8NUG2+TN/A5FooOibfuhRnRGtEAhb5BesYWTqNACOus5P95H/nY5jMZ+ZSL8MxyxdX
 XYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722536; x=1785327336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyxwzSpvGQN879gUQIzhLBDWPp/ka/KsPTZu5mIF37Q=;
 b=cIc+xUN/iEkyyWPSk2Yy014oeQviacuZVUXVfa10Gh5u8lXGYYTHs0AoU8wWmWC45M
 KuRS2GOb/4s3so7l/jKiDyrBxNZCQvZ3Ft7K0+V50SSuoFxdhWTp9LaQ0lwNK2ZQz9ps
 RsXAOvwWuz7WF0whAS5wpoYQSIammutquZ5spTmLVRdAv6RCukr6f1acqtdCyjQoPMJ6
 Tf6RrcnM+T9qplhsAEfaftfWZ6srTNeSeCr6BiIS+mCCjCxxWiXyUDbESMvnbjhlQ+RY
 4YJZL6vI5DNiCprh/AF0oj/m+YNW9u97ZJCmR4ZyapnIbU6GvqzKmGY6p/MRf2pBJfwu
 NHFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwPbemWPM1b08jP7asXLJXepvs9Id/rX39jPHFcaAmc80Wm+tY1DfzcuEX75PttgPbtNz5vUpysLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMQxjxZfztMV0unFDHEKjVWL8dqLnJGIrVk5NB5/dsRAK1h81q
 XMl8916Ng9wm79TFSmsLBtTp+wpJhxyBPuPD3pzPv1UPCdNwRHPdo01/DJ8Vkqtpkkc=
X-Gm-Gg: AR+sD11ddkSnXViz+dxvBVJk1EPXsg97qiehiE47Vo5n0g4vv8rZfCmP2mtvSrxoiEX
 YY00nOOWBih21jbNqISCwkJZ1N7vlJAcdzuKE5gkWYC/igzhhFNqLW6l9zu/bGy6oHtcyGWrZ0W
 PkVO23MkxfADA1dcWU0lP/5NdqPl/Bq49nNr9O/6obyN7En6ZGJXUnNx8+CH90igY+wwYMNFmuX
 5KyzudXn0mtRKStZ0bA90wAjP7/C2Jr0i4zRJj0PlnljxT8XfkrN5w04qVuqgz3HS6gQEbu2Kv1
 RlFT11sGIcftw3+Tpcax80N+Aa4LXM9XH1Acs0ueZGbRUNX3ZPWG/6kq2F3SK5r7ZTFNt797dR1
 d0CMXJCJGQ4BTjkvEhblWVtposBQiE4plS0tHMjeZsOh6mh4uUjcYgQx773uqvq7PI3Pt6Ldf2G
 OdnWXV0zfjmx+kOKEX/XRenX4=
X-Received: by 2002:a05:6000:40c7:b0:47d:fc45:8587 with SMTP id
 ffacd0b85a97d-47f622c6242mr27265527f8f.0.1784722535151; 
 Wed, 22 Jul 2026 05:15:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm4379093f8f.21.2026.07.22.05.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:15:34 -0700 (PDT)
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
Date: Wed, 22 Jul 2026 14:15:12 +0200
Message-Id: <178472247748.1745070.2574676962239424273.b4-ty@b4>
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
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3367c5a129f74812806034fa0a106a1c3e4a3890

-- 
Neil
