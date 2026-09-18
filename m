Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C18C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3437910E11E;
	Fri, 18 Sep 2026 15:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mw6twh0s";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7756C10E11E
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:58:46 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so3730845e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789747124; x=1790351924;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k6iD2D2etMihq1Ed/Z2D6Mnz744U4yuQqMUM1sM4K3I=;
 b=mw6twh0s/w7RxwT8+Gx1zjt3mvg0hOw1e7/Z3P3w5GDSZtpJat0nrQhYwsyg+XdsMj
 0NGiSIdXs1Fxryon/vP7mezPgCnpIDUFQDjb7+iiXIL/LC2gFkXbk2mraEEJbjMwu8O5
 hBkkK11xfYtmsepuNZ7R9d37rU6urP6kMQppGfRC6VN1DFnyKMTgkBDzZVxxwkawOSsC
 cGLqXWtR2gBx/SsgeFpZmmjvjeFNYV61ETJzKTtHKRhjqKxbg2yuIXbk38grVLPYxAYM
 LFjUy7KipZfIKpeHdunfxe2/n0196wnXdPhIqSPUmZGNxXquX8z7MIEzr52hOR/1zmGX
 76zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789747124; x=1790351924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6iD2D2etMihq1Ed/Z2D6Mnz744U4yuQqMUM1sM4K3I=;
 b=iHJl+7RZAvOSJ20LMs1xS+JiW9HP4wBPTjPE2233MnNB1l2kO3ZScehkqFAuW0wSRH
 HmUcO8SnnSFCQ7+ELEF/AT/bBpYr6FduMu9RxiUUPQlvlZ0VJddM4tH1Za0FoVBpwioq
 yzF6hGfcUuZo2gfdFxeqsTdyT/Obhocxa5PnOfvtumbytGmjCTU7LBUvQuggTbbuD8q8
 5f2mUPPlG5I+haanUdAv5yk3z+gz8i8QNan7gz1Xf4iY5MQEEzATIZk6Y18DE+4M3DPq
 g7D4OkloqbY3ZRuG8Lze0ga7gUPKzl45eBIhjJmQGNSf3Hd0bWZEPsPYaPEf5nMyZ5uY
 z0Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJoaPcj7GP7Rgh//MlqZqEOjRi6cl2ivkkMBDwZotoSHfNf6gH+OpP0GkvVLFy651O4vmiO14zk8U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mh/+MXioH9cGb7VuRhaOEKf+loGDZTw3U4NO/ni4g2XodYIldK
 /N6BlCHYwcWaUTmBUXWU1ktm2nGiYpeAvZahBsUwlPR8Klvfsya81wqa0NM+Ca6eQ+w=
X-Gm-Gg: AYBFou2wr46IbcpeQ/ck/ADCGK2iK1qL2zvnUUaQCEfSwp2aWirqG6aSASlEhq4Y1X5
 mckIkltYXu9tptsw5wFsUIVuKVsVUAgoB0JusEC+JO4nuqUJWgf4s8+6lmWsRU9RyR7Xv5wT+Wv
 oxfHaXFXHNYRUcbjNWzEWXcyvJitkVqIpLUYurLXk/IQ1eBznEce/QCfiWpnNV79ftcWWngDKAF
 62xvyQwD6V8J3NWaj+wqReEtghcf7IL6BWA23fjGmY0MHVAxjmytfec2xrUVpASd7VA7VbQcZa6
 N+5Kj2Ooxe6lOsIVJ7L8yCmtCR+EyQ2fVCK5HNpkgZlPQl9SxpujE+Of52853XFIWjANzfL1+so
 Y4PckEySvJUoAGuRRpmiyCIUm/tus4HU4izk3pIP9LOijL3ClkMD4vqDuVJMQE9Oi4zn+ilXEmH
 Jp00XjfcYkqD/46KAcOS9c/4i2xTAF1Z00yOr/h46MpLbFL+dnGQIse1b8Vib/q7V6clfSvYBvA
 ACIMAeUelj1N6xAOVAYQ3nQvvyNDVR6Cvnld5pZK7PVre30Eo0XSOIG9U6LsA==
X-Received: by 2002:a05:600c:1389:b0:49d:2936:8ad1 with SMTP id
 5b1f17b1804b1-49fc4f71c7dmr45192755e9.1.1789747124490; 
 Fri, 18 Sep 2026 08:58:44 -0700 (PDT)
Received: from localhost
 (p200300f65f19a90444c8989fe13f5be4.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:44c8:989f:e13f:5be4])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fc56eff84sm56426065e9.1.2026.09.18.08.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:58:43 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:58:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for Novatek NT37705 panel
Message-ID: <aq1erjmXLCFB3uoB@monoceros>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qruxh2qmdhupwtoy"
Content-Disposition: inline
In-Reply-To: <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
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


--qruxh2qmdhupwtoy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for Novatek NT37705 panel
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:40:05PM +0200, Luca Weiss wrote:
> +#include <linux/mod_devicetable.h>

Please don't include that file. of_device_id is also provided by
<drm/drm_mipi_dsi.h> (transitively via <linux/device.h> ->
<linux/device/driver.h> -> <linux/device-id/of.h>) and you can rely on
that.

If you want to go full iwyu, please use <linux/device-id/of.h> instead
of <linux/mod_devicetable.h>.

<linux/mod_devicetable.h> is a dependency hog and will hopefully go away
soon.

Best regards
Uwe

--qruxh2qmdhupwtoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqtX7AACgkQj4D7WH0S
/k45Dgf/cdIUUEx1eWlxLi0ByfmazBebC1gamR8J8DORRZZV6FdlLvHC+Xy2/RL4
slct57z4ZQbBeYwbTEYHirry7VGiKwEpKPQDLmLDnPWad4IuhJyPJHWq1qextxYL
Jr0wsKOilDFYPTydHs9WPS30t/IUFq+/EPzL5pa8ZeGgOVFoqNsW8b/ZrfoDFdJc
O+3m9OwNRXXICF7BpJ5BeHKu3Npv3CiukAmilSjD8dyFd3JXZX3b02ursgRjuDyR
4k+acvjvKFtZ9V4lJpvtwU/6XQxLiQNmLT4YYEYx0aH9JNlxjtie+CUXYEDKcNoU
ynf/eUOrVnbj4s3Yoh1l7LkySt2lyA==
=Sgj4
-----END PGP SIGNATURE-----

--qruxh2qmdhupwtoy--
