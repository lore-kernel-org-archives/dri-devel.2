Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307D60A2619
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AAj/pu6g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FB710EE60;
	Mon,  2 Nov 2026 13:40:45 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794EF10EE53
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:39 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34647415e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626838; x=1794231638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h+wkXijMt26jWnEtDLY8VzmO1E+BB8IahUIUjU3Iokw=;
 b=AAj/pu6gdivSOUTt8UK9LBjEAcwk7sohF+QnSaRharrZWOnwjbTK4yjnzRtv1xZQmU
 khQ+WLdtZ22VU0uWD59aVgF2OKinGlOx6tFDGOfSbWaLNgU4SPZgAeeXUgiCL0D/Ieha
 fnUsBWDR5vtfGJuIkYpGTsTLY1oReiSNqC5CCZY/q8mO1vvZO3D6z9/y8slpV/Dsu78j
 1FbrXQynumhO6d0VTZVDJA47cs3GmIfX3FslrTjRhRdZM9gBHJ2qfxWSBmcpxZr6/0C5
 q+yDiE3vNCRgeXSgVwS7cvKBEvcSXhUYNSn4YFkgup4CNm+1uoAbbnEV0PNUH+T/umzC
 wzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626838; x=1794231638;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h+wkXijMt26jWnEtDLY8VzmO1E+BB8IahUIUjU3Iokw=;
 b=UTZVIwL1YsqIkedxSZo6jaYEAVMZZuSPU/RuLGB9vDf6a6IHEzlcrvArn/XgTj5/xB
 Wy9mtoewGKkm8M1JZI6/kwHOvPRDiv00+IC5UY9EhCn2Zq6VNSpY8471EGs6Rbu/GF/2
 ERSPE/zLXSGEecUSu8tyeQOCKsk/6uEGsmIRqFaMo/mrotrAR/8FAkdQLL/35V5TqdPI
 twyvY0lrLarppHnnWZfCWT7lJl/Sr06pXE1GTzF2vHMbMX2jWUjHroEducg1kxkDYV4/
 p2VCPEQ5u6uTyPVzkpWcAaNbs3+ZaE0aenAOSFUg40O17WxhZnE6bwuYTVhgTCL9R7xZ
 xaiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywEvUrMf9GlGljbmJmJaIJvogn/NPik+6PD7zN7j2BhC7puIvNiTM2Alvt3nUdj9zZw4lYmJD6lcg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSx2jdJoLaHrH+IMZsI4lo6+YUtQ15B1WZkNV4bgxtkBiuyNV7
 YDvjPUOqXlOXTb709HXMGeZql3aEhEwmg2jGo6G8HCVkArtpOIWmKVjO8G7ihy1XuCw=
X-Gm-Gg: AYBFou1KfSFGdlb1rRe+Ft4UWbFgFYhWW7ltLClIRCc/8YXb6rD0sDSkr4Gl0F2Ilcd
 Et+T87rZ5g6O5axSHmPh3LKbQ4Hh825pyJiQm2CZX76+Mg9Ekc0yqzzOlvn/LQ4WGzGQyWoxgsq
 VICBULoZ1rdCbpC7FIplBp/kB92Ys4039eX2bswl+Wp37ZJgFuwmuqDLc1r85t4ZY+ZPkLLte7b
 5jUe8eIcYHQ70bZYVdUMEhe5S26ydS9ZovGa48kh+cHlGe4BR2KWpb2MgpsPrm0a8aB1jzMB7HZ
 gY4/dmjHws2eQ7xUgQua9rxHUB9L0RWqHmIIFJ7spU24z1a7/BqY2c4IFS5sYTaBvcE0zKlyGus
 JJGvrIWBGGrSGf0R2H6yb+8zxIVe4iEQH+AEH163Z4yXgezFIIePuvKfgLmzbb62qQJ5GReNNS0
 XsORYURiKDE6YloIyV/fSYqe2B8WgFQJ5ukLyO3MAodNK+IHwvswyp3iv13rfUEBvltOSJG3Qi3
 J7mBg3nE7LJ2cltCv9P6RX3GhrKHdZj+eH3gjbi4gwGJXHCE1J9J9fdUdYl+wpl0oBtNmmzYk9h
 fBgWFZQoSntUib54z394lgkdbpHr/nBSg97dISY324nxbibLaA==
X-Received: by 2002:a05:600c:a48:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4b22ec58f9emr16148545e9.10.1793626837704; 
 Mon, 02 Nov 2026 05:40:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Felix Boucher <felix.boucher@savoirfairelinux.com>, 
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
In-Reply-To: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
Subject: Re: [PATCH 0/4] drm/panel: st7703: add support for DCLTek DT300248
Message-Id: <179362683669.3310106.16771881319791378859.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 07 Oct 2026 16:18:55 -0400, Marc-Olivier Champagne wrote:
> This series adds support for the DCLTek DT300248 10.25-inch MIPI DSI
> panel based on the Sitronix ST7703 controller.
> 
> Patches 1 and 2 are necessary preparation: they make the driver send
> the init sequence from prepare() with the DSI host guaranteed up,
> since not all hosts accept commands once the video stream is running.
> These affect all panels using the driver.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] drm/panel: st7703: set prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/aa0f8d68fcef246d626a8edd8724e889a71c346e
[2/4] drm/panel: st7703: move init commands to prepare()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a8e72d97ce2e779a95e1d521553c9914791ae759
[3/4] dt-bindings: display: panel: add compatible for DCLTek 300248 10.25in panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0a16c2a62af399444849dfbf7c00980150371e43
[4/4] drm/panel: st7703: Add DCLTek 300248 10.25in display
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8068c2f78f7233a0ab528e429a02fb73864f6423

-- 
Neil

