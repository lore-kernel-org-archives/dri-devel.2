Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE3606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=kD6rbp5e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD0710E0BE;
	Thu,  5 Nov 2026 11:56:08 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2415A10E0BE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:56:03 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so1546611a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 03:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793879763; cv=none;
 d=google.com; s=arc-20260327;
 b=hh3z7grXxIJqB7PvCx1trQC0QdsU91RbPB9+6Uv25+Fki0gDVVgJzkn2M0mx8rl5Tq
 C92/3+MLYRKuHeqKManXvxneePixxblp2Wsu/9v3TdRObXztQinWMoumyD9V46CF4iOe
 /F3dP+PZXK6ZhiiKOXGoDlvPhXOlo6qvAF1GtunbcYOrZwmMFkj7uqSk8fjeOSkt4j9I
 AVcxVJ8r/jyDF0WfVrysbGa59ieYuRHcVrSrGlwpPXGwPYhQV4DgdDMJGnMk8TcT/OJm
 MXCNPVkjBZQVbRPN8Pj5ISLPYB7jm1Id0krr8AeB3LVk2PQdCCxPbKQwwNcesX3oI//4
 C8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PaO3mUrvyrlxLx6T6FMLOlGYCy2w7sWQHAyzdDwn7S0=;
 fh=un6VGGsr6pRMjkqe8pIMiVbWAuRgTItlvLIQAWmUDck=;
 b=J7xkRle4duG7nIuxx/+YzNUUQZOaTDcJRbj8LEeW2RXIDNh8GuDV9mrZb/bSoPDQM4
 o+8mzFDSG7GIWsL5JEJ1m1OuAJP0mNFtDJvLjGoIjIjawdRlKKdMQPk99j+Vu+Y1eO1D
 0HgwjwJeMYR4+FoiqwrNz3ivaTzb0zwygnZDRKpOkRxdodEh0MVr9RYdhFaCMUDAEoNe
 KaPzaVpn4j7ZYmM7YDwlIQlX0NF8ODdqZ5KYEZv+pjPM2D0GVvLNRImeJigyhCblV1UP
 spNK6Gy0MewoYrGrZFwZjereddR1qanB8gSLTFTjOie80HPr1SqmrqJomizhmdb2o31s
 mMpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793879763; x=1794484563;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PaO3mUrvyrlxLx6T6FMLOlGYCy2w7sWQHAyzdDwn7S0=;
 b=kD6rbp5eIhaqo92UZHhzYN81O9o4+EGHWw1V11omn7gsElRW9TxtIl8rH7AOcGlXJU
 Tbpzsix3FiI5sA7VD8eOUPprtzYV0Hv9hygUWRdO6u0eDeFxoL1RQ6bSpjCPibWUgoMB
 TDejyjKka/g/hogRWNDQs3JXnXO1+Wr42kdC9CX8wHhGAtvn568BtjgfYXnXWLExAJOM
 QK7Xgjh2MgXQmKmicvgf9AS1RiAYm1VqXa/hSsqFt0/loYycIm5JRwyit3hlvb+v9tfV
 IhwmhTDZZNfdCU3cPkqlxZFXJVeEVzIIZFr/VbIOdIcx6lajGNZ+Tf+BFScoNEiyBXKl
 wluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879763; x=1794484563;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PaO3mUrvyrlxLx6T6FMLOlGYCy2w7sWQHAyzdDwn7S0=;
 b=ThawRTvRccZ5Cniie69qXnagPRcmEzmIwhpD/55JOZS7BR+YulMgnRR2cJNIhIEa6T
 QBiwfPNeK0IxYAWk7Jk82Nb57zza+qZc5SjlbqW1XbVAmvIEoq/FF3xkvQUgkFrlryWF
 ZaQgC4ry5v4pVZ3kNqYXkKBbZKoepRpRB1ZA5UwH58Myf404DlZvT92nec0lC/Q5ozQD
 P6rrBAPi9sV8Emj52BcxqvjN/KyHt9h68zhMHHjpoMcDZMihuSnEq0nCBortP5iBLjD3
 wlqbIxQChrCC3On7Jq5m5MJmo7Um9yxsrUdVZ/K708L+xLGqWor6tH3R3wImZseC6/pJ
 DTlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJmqwVY+wCj8O5FCzR2c3QdpiY9SnuSB4LA15Uol/DUfsECnOnjptEl14yDll3RzdcK0lCc2feQYg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8WPhppKoYupXCsPR+knsQf0p/UJ7g2Euucir/xdN4/F77SuqMe
 M8+51SFF+G0fuz1sXRBQHCDBHF8IEHKPMQgKaMZvT9IjpAT1hQwF4Hkn5n83iWorFAqa6+Hh/UR
 XBZHLngQZtn4EW0jSwcc08TVfWznKYTIGejyFbyAE/Q==
X-Gm-Gg: AYBFou2U1Qr220KWYSmpIKqCFSN0x5G7uCXDICaFrkujUqdTHZ0neX6c5sgInhhQwHF
 6uWv0hePxnOTzSZ851HBgHOIKcoBYIOqSSAvFvcxCATnguy8IT7Zbgfh/kf6MRKY+40EgphKtFr
 GNfPR6gs4WKGHq7dcNONaANNuwRtMxIRx77yLN7lZAwsk2Ps5bh4cBka3R3Ga16tIbgD5nP2Pqn
 ZODO+8+4lmFR5lQlQss1bNTFb/Z08fchYghbQ8MCMEM7nxFlfAz/n/Bk8n/7tvCybcv3iuqh9VU
 zKtnSyyFGdWT7SC1RYVs9oa7zw0/aRRtYtw3S97W7pjq244VcUc00d7LMCcpjQZdNqcVaDqgmg0
 XNPbz28gpKMRb9pvNCJwmgHKA9WTqLiSVmYBA
X-Received: by 2002:a17:90b:3b83:b0:3a8:5d1f:59ad with SMTP id
 98e67ed59e1d1-3ae89819ff5mr17083778a91.43.1793879762611; Thu, 05 Nov 2026
 03:56:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-12-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-12-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 11:55:50 +0000
X-Gm-Features: AclHuK8Jj7G6el-i8_82b6TJ0oa9AUPdN0owTnb0JTIANqcEHa0Ic8C9cFJ1sYI
Message-ID: <CAPj87rOAjcLZeKsKCMr84NoN89VzRDLV7Z8LySHK-DVyRW=u2Q@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] drm/rockchip: dw_hdmi_qp: Do not mask error code
 in atomic_check()
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
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
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> dw_hdmi_qp_rockchip_get_vop_format() calls
> drm_atomic_get_bridge_state(), which takes the bridge private object
> lock through the atomic state's ww acquire context and may therefore
> fail with -EDEADLK when the lock is contended.
>
> The DRM core expects -EDEADLK to be propagated up from atomic_check()
> so it can drop all held locks and restart the commit.  Replacing it
> with a hardcoded -EINVAL defeats this backoff mechanism, making
> otherwise valid commits fail spuriously when multiple threads perform
> atomic commits concurrently.
>
> Propagate the error code returned by the helper instead of
> unnecessarily overriding it.

Reviewed-by: Daniel Stone <daniels@collabora.com>
