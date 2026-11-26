Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd4cBwBN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E1B112849;
	Fri, 27 Nov 2026 08:29:27 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD411121C6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:51:09 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3ab3cb83f54so4862831fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795683067; cv=none;
 d=google.com; s=arc-20260327;
 b=atBdfqjaut4Xqsjm4C0voqe+Ujp4SVxn2jjUFSCWWD4OkZRKhNnhUrMuzhHlkOpEah
 A19z2MYcf1OB+nI4ePxN5fbQZuD12D9+agtgd+LS6u6shkV3RsuVzky6QELJo0fWmetb
 Hlp4CbVbdBmMiCxtoHX0aUADJQ9ppMbEMON4gwDhh2b+yxVjbaC7GAu0/UI7lGZoKVqs
 UvUL3oLG0vWxSDDMeOH/EhbKm0WJ6MYt1n+QuTNvXAGKITAg72XWf+wwTed4WtmdBAKP
 wpVsNiJRhL/J+3Mv4BC4LfYsT/yvjqe/DO7sGKseDj3HHRkSDRXtzoOPZG/4iC3MA85W
 iTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ITOW/VUS/xqG6eUBGAKhOlylTSyWPsCYCdwCBfmp5mk=;
 fh=hnqtyk0xe3kw011rVe9ACTLO2f3NQjp5WtZozO6TSqY=;
 b=HTTSTxfud+dajTcBiQ3DsfqywBfFvmsoTPntOZvaiPDhAlRMDdAMOYWeL0/Y5oyZiV
 Fn/ngmMKbDZXGztOX2vCVvEMljfeyzAfygY+WmiHFB1q8BBnz6PkySP7Gxbmn56Og64u
 cwAnmeaSvKVet8dJsR4E/hWPA6CYPI3MjrkOl+uwuOE+RZqrPydF9FjKyviE6FmKOU2j
 utMeG+APnfpCMlqNjPgNz0g+gT2c7AXZ7t+aiUZexPtKlfT5PHXBWstKz26tBNEb7gjS
 Yaqn5DMA++iQIReN8+FrTlvzEFvm30DkZWax9C3ueuO98VCXjdp6VEKH2kju3Horic2o
 vP/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795683067; x=1796287867; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ITOW/VUS/xqG6eUBGAKhOlylTSyWPsCYCdwCBfmp5mk=;
 b=sd4cBwBNn3XoeEIN+Vru9gSIT0D4QH9PV/ztFsCVqSiBSVVSW4/BkNPPxBnZ9iqX+m
 enD/+h5vNHML8oJpzc3ug/xNEslbS1mSexw6pG/TQmObfvaSyntShJ1mcb+mIIQErQjg
 0v+Jr652cAU4JLTaYmF07NnhtdraNhNuM/DycF2Mc6whriWll3kwQnfI8iCrWX9ml9LN
 ryl8yjq/FW9CCL9WyOkid6E7uNtT/s0esHoTBF5h5FazsOWdZU/ZbiwBZrCQjKg7U7/1
 +Eok2vq5vToVYOxL5inlHOUIRK3Suz7ArTKcKnRwx/Sygf4iQzpRzmmttDLqqbq/bZst
 i+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795683067; x=1796287867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ITOW/VUS/xqG6eUBGAKhOlylTSyWPsCYCdwCBfmp5mk=;
 b=lEOuaKB2Tmsb3uyKoOjRdtK/zLveKpo2ed7WJKZB4iaaqUtfUFK641VkTZga4DMvxl
 3kqB+iORzMDoWHkhgnLEY9q+U+25hBe2/P34wTFstPz+LJP8nOfgDnvYzt53y8PTh8/J
 11ioHomZRmHr1AVcFLP1ENpK0kERvmEMIj+ygpKYfCHSRTNzuXUPE6RL/Oqs7Rt561YJ
 en6331N/MIK+YYRvi9xFEqOMv/8rv5zJ8ifjl5YBLM6Uw6z0uYCvYD2B5mODpu4PfqNg
 bEm+ChjCiMP1E6a/bprVON23T4ivnsYU84oB7uBMXHQMbEvWA3ZQcPOAFi62UKOZwA/E
 zPbw==
X-Forwarded-Encrypted: i=1;
 AL+hErFc+leQYw2tH1hvXrUxDzEFWTDk5iiTD88Q4DXe/3a6M369HlhkVuiX20sna31WNfDYlKh4Ah2PzCo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Dvpou2irooUCbD/9uM87eTloWUhQQ5M7+Fmg18OhQSe5B5mjj
 fzjcepkfU+i4kkDs+j4s/0dikUHdT5SfG2TcZcOlb4JU+Kx1OP7oeHf045SpKPRrQONKW1++H8G
 FNpRSPjxK4qz6vuUhiQSz/sJ1xX6XFLg=
X-Gm-Gg: AZFdTZcp8v84CyLtQRW9HxKTDnSur5eoClzq2mearRju1i2NhiKwa5Q0fBdDJLIfnKd
 aRedWYNOXPwAXNIbsd5p+d1MukYQSu/8T6eTepPNVeT3Bw8AnCibvQ+hVr5o69g7P28M/51eVpD
 Nm9yyHXGfYcbWv3pIrM4FxjXA8l8b7bpx1oSB7mxnuVc5KDiOksiAyRmRWYqet8MMTz1kOzLH2x
 iUTGdV0uxMoQ+vFPTXyBJisFfpF2OPPjmIndMSRXekfUMbGcP43KYWXr3CPqG4RguNhcusgnZ6N
 HeXqtzRTBBavqpbyvlm3CoZvGDy3GByitFTw8BxgtokCPuTg6xpu9zD3qoD5CLguOspnMCO1ypZ
 coUDyYLSOm1b7FBbLmxWuugg4J8iE+O55x38+3vLd5BLZyVdfzuJJQjhIVNQwDNyhKfE83YY=
X-Received: by 2002:a05:6512:b88:b0:5c1:5488:f57d with SMTP id
 2adb3069b0e04-5c1bc85b735mr7624851e87.4.1795683067065; Thu, 26 Nov 2026
 00:51:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
 <179533990370.107225.5765165679182115805@gmail.com>
 <20261122094050.GB2739410@killaraus.ideasonboard.com>
In-Reply-To: <20261122094050.GB2739410@killaraus.ideasonboard.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 26 Nov 2026 00:50:56 -0800
X-Gm-Features: Aa3M54qYbt6ioFRQuuBcY-nINhYnmyO69wxHem1cDdgKrz6EAiep7-lR2zDaAac
Message-ID: <CAEy9hNWKmcr9qsvrS3t-UkG3igA_eYdQY_Q0sxWK7fccpWWeow@mail.gmail.com>
Subject: Re: [PATCH v12 06/23] drm/bridge: synopsys: dw-dp: Fix AUX transfer
 timeout race condition
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Andy Yan <andyshrk@163.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>, Igor Paunovic <royalnet026@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 11:40:50AM +0200, Laurent Pinchart wrote:
> There's something missing here. You may have reviewed (whatever that
> means) and tested it (probably), it doesn't seem you've understood it.
> All of this screams of a big hack.

You're right, I withdraw it. drm_dp_dpcd_access() already retries a
timed-out transfer up to 32 times, and my test only counted
per-transfer timeouts under an artificial RT hog; it never showed a
DPCD read that actually failed. Sorry for the noise.
