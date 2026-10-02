Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FC6CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF5B10F80E;
	Fri,  2 Oct 2026 09:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aPkAU7WW";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDAA10F80E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:32 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b09f6bbe8so983827f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932591; x=1791537391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9dZvdj5g2Xf7CgbEOngSTP98R8970sBXh4beZnL1CI=;
 b=aPkAU7WWKgt7F3HkSb/XxN/OsCOb+fOtWmVbKPr/7yaj4hEBQajY/TPVOEEHFTfUEd
 +AeroM17R+TgO1u7EnYaXmV7V6uGgUhZS79hj+bPQ/KkWkzdXb7oYs2AS4xByz5eMX9j
 jRXNPV12DtyMmKFrFGFzXzVN4KPJgT5Bz8cntNTUoIL6aZqJAmbDMH+hQ5e7cWt/SCjt
 Ps/38AK8jcTi06Vykgj3kRFPm/1CZ2e42KVOEkhPqpr3O4F4Juj/EBpAQsQxZpkvoyjo
 EGjy81lB2G/SbdoBCz3kdrk7pPQMXGv6lWdU6zij7SdvNq+c0voQ0s/qEuSLAqp8EzaQ
 Y+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932591; x=1791537391;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U9dZvdj5g2Xf7CgbEOngSTP98R8970sBXh4beZnL1CI=;
 b=aGrnJc7lTBqETKM8khaFoLeZvhP18O8Ky/6jbJC/5ZU9hCxMRzTc+UQCdo5ZDZvtQK
 Wo+rZekhepbqMNzTRNffCrt4MkSbybRgJizyE9LKmWa+pyau5u78dl7YyBBIfm0zvD6q
 7QxeDW0rQd3MNTzrewb+SJ7wYDbGe6VCyY0VZzDlTqBaDMvD1mYH3t+rv9WS6NuD+/OJ
 xxSGQ6jjnqZg5JF8pHBUJl8vCVelaDEN5AFz0ibZxbgnu86KOjILfEjhxBG0NjuTPDrU
 u18fwdXN0kUlVrCIWMyGvH64aYyvd0yjFd7jPVufWvsHamKOFK/Sm9FHCZC/u7KI9Ieo
 wESg==
X-Gm-Message-State: AFq9FYKpRfKymI9XjICXnGJyOtgFkSfHD3X+Ngkif9VYC70djigKeQyg
 EjEcpwNbYNyGTywG0tHJkVbKkpZF3ZS4ApfQxgew/CYXjWeUUvIBgj4x6lu01bJan4E=
X-Gm-Gg: AYBFou0wFoGMeJhr3eEcxlC9bTeLCT6ifjNtFBe4YW93r3ruM2Eb/xSJWwghfIuYsMo
 GDP5njbXyPVaKI71I2fAJh2XaF6acOEWEFwHQLEJBMXYKEY+PJwnzskcXonPpd3wl9jhwDMFQjZ
 b8WAvy5tTnZKvepM1T3r0/aFEFlYpesUdQEcPWnjl5MafS/ypDmZ/RjOCjDRCIGzTLp8wkOZugM
 k1vYFNfFCIka0NiEvqbhN6hhqmLdxQwOS3OOHbXRPV3kiNNa59IgRw1ReBusmve8puE/5PdcuPe
 kwJFKyNR45cKqFU6kwbLGxVD7E9C9RyhuvBxF1y9MLr9okppgvrf0EV42RmQZV01BgUNjetIDXa
 E7F47j5V6ip7oAWHeK+UFy+vLIdcN4+DYXGzcsyNL006sLIkueZQEC2TWhvWChRZXy3v4lTY7rk
 xZDUBBa52gyhlNQgQ+2VGn24/m6bgXuGdfKslWAArG0O4boU7yz6nUiSO57onLPDoEr/oN1zvdf
 F0H5/flM+d5MMtFaxs=
X-Received: by 2002:a5d:5e92:0:b0:48a:efed:ac97 with SMTP id
 ffacd0b85a97d-48b1271d746mr4025071f8f.33.1790932590900; 
 Fri, 02 Oct 2026 02:16:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261001-asteroids-panel-support-v4-2-fb228194ad91@pm.me>
References: <20261001-asteroids-panel-support-v4-2-fb228194ad91@pm.me>
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
Message-Id: <179093258996.2282096.10304907203936947883.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Fri, 02 Oct 2026 01:51:46 +0000, Alexander Koskovich wrote:
> Add a panel driver for Raydium RM69220 DDIC based displays such as the
> BOE BF068MWM-TD0 found in the Nothing Phone (3a).

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[2/2] drm/panel: Add driver for Raydium RM69220 DDIC
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/54e61ea6c492d69a1717018826d8340810c812eb

-- 
Neil

