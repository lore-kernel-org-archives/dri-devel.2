Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFE606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gq/blA5E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CDF10E19E;
	Sun,  1 Nov 2026 07:46:09 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E60810E19E
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 07:46:03 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33fb4680717so2497549eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793519162; x=1794123962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SAR00vszMy7Oo8d4FC1bVF4Fi2pxCcoHYlztJt6Lr9s=;
 b=Gq/blA5EM+Y9Fg095IhLAQuFTIV3M+FoKGCTkLexhOUVDgTCS9E5aAhC7LhnYLQYGS
 u15sy+OnjTmFWh40gfnNsyHmP1guY08aG/3I92PoP4METp4EnQD/0O0AhLeevj4pTgC1
 DYYydgQGjoVVg8dX0SrmLdzSi0wXcBvl0cHrL84l9x1STHngexOzjY2UD9bBpVNuUSIj
 ZpTnQyIoLhyXujhWSymw3cxWO8riid+2M3pqbYLeXHNFNOWPRogju3MiddxJMjAC/j9k
 6WuZH2dhs9YF88PWjVKoP/umeQiES7z7q4IpoL2rrPv3B48zY/ladr5VXLdFh6RSk/zU
 rIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793519162; x=1794123962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAR00vszMy7Oo8d4FC1bVF4Fi2pxCcoHYlztJt6Lr9s=;
 b=uMm6DwN/npwITy6KjhgyE+boDvaTLDSwsSphnQJ+2UgRgPmr1PU+3cWfsSzOtQQ1nT
 IlnXhOPoNtGZ0UuJBqMggQAQc/aA+VIEpiZLISq6Sp5oJ+gb4k6EqJpnJSKlkRCTjAY7
 skS8BF0Ytv4doPNpOc/UWQrm5EaX8tLsQA/3GwbeDqidUqYl5o4eVE/aB8xNIcaRPIHX
 kIEkicmUQFnSkBCLsqLVfeC2GovHSM+A0lIU5n8UgTrCT5OT0AK8kW/BckhQ9ET036DV
 YvUU8+JPBQs8tq5okSHhnEpbvUGMOMKFCuNwLIhounFMah9/14a65B3ILVjk/6Vzi9mJ
 gelw==
X-Forwarded-Encrypted: i=1;
 AKwUvByNQxpEpHtCPsXf3TWorOL/vGpM5dNvLqw+DtV6zo5v2lUJJpN7sWTzUQTzk8wyqA1yGDLiiXPCav4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lASkKLQ4W0xvx3/zHIq31tUwKDmzq83snbXJRg8F6xlqMMU1k
 JzEQFck5oUzI1Pv3/JzlTAiPgoqZxNzJiE6EAaZwL1jH5TCNzDz8KQD/
X-Gm-Gg: AYBFou1q4H7YPpflYKVkZxZEbF/c0A+CnPwFW+msUYdyb2VnmlxrDBog/suvm2sDGzd
 4O6gyQvt2o0iL0P9Yx3F5mLF8dPyQFrX/0lIAWzk4AwVibmfuzoKhOSveEwCb5GYEu0+RWxFIbH
 Hm0AatOa1BjeUcqfM+puNLyr6/H8zDm4+1jqNyav21ah7WRLbm9CoBFzyrqlLhcWrNYlKAaoVZj
 jqJhhBrrgO5wy2JGY4AQY3554zs6DFsb77zg/c8CwPUJI8y7oexBlgJbtEfQur83tFk++62jNBN
 Nr7vMcoJdtIxLKo1Lkr3b1Ha4wz3RRa1XFAm7G4g8THiFe84paJsQCCC4+akRmkUGBwFGHHgfhI
 ks0UCIQ3pOUmW3wUAqX5ylsMwh+noFzccwzDNFTQl05GjD3BCOkEVM/5xFYgp7Qy8Swqp52pOJv
 CqhbKTqnWG6yIGeLZsW+9njw24gyZBmh9fhY+91jUT462//EpGxv38Ylc+Kggu2OikY3gFUk1yc
 1CLVPO81uaPcegS86yBCQ7tCVOCKdoDhJTbLjw7Nj196BfDNuqZen0gSm/qmPSRqLbvMLqjW/6X
 1vio8sfIjbwWAxhmypoNvRDXUSzlOcpulp8e0x6r
X-Received: by 2002:a05:7300:fe86:b0:35c:85fa:5a68 with SMTP id
 5a478bee46e88-36a42400c6amr10962673eec.31.1793519162483; 
 Sun, 01 Nov 2026 00:46:02 -0700 (PDT)
Received: from arch.localdomain ([152.175.67.103])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42662f23sm28414684eec.2.2026.11.01.00.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 00:46:02 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jerrysteve1101@gmail.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, damon.ding@rock-chips.com,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, jernej.skrabec@gmail.com,
 jonas@kwiboo.se, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 RESEND] drm/bridge: analogix_dp: use
 devm_phy_optional_get() for the DP PHY
Date: Sun,  1 Nov 2026 15:45:51 +0800
Message-ID: <20261101074551.263631-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013134659.335829-1-jerrysteve1101@gmail.com>
References: <20261013134659.335829-1-jerrysteve1101@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Gentle ping - three weeks on the list without comments:

https://lore.kernel.org/dri-devel/20261013134659.335829-1-jerrysteve1101@gmail.com/

It makes the DP PHY optional, as needed by the RK3288/RK3399 built-in
PHY, and drops the misleading "no DP phy configured" error at probe.  It
has a Reviewed-by from Damon Ding and applies cleanly on drm-next.

Anything else you would like changed, or can it be picked up?

Thanks,
Jun Yan
