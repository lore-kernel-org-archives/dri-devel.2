Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7BBC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9188D10ED99;
	Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NebbcwcJ";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F4310EDA7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:15:37 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2394044f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784722536; x=1785327336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=irQTQ8XdUWdZ80B2Ynlymn+M9Ebrx4IqFd38HePJwiw=;
 b=NebbcwcJFaMsk133ZVY78B90qCpSfOEtr3C1Dn6PkKrbVHJGUlm3crcCoTTsiF/wGU
 sDtAlY4AMCFndi05BDDmLUoSLycZqNogapLz4L5QfH9TAhqAciTcuraHJ0C3yXEsy3Ya
 9JwXcb/nMKck2jJZlWOfFEBfQb4QcimuruxDaNa1QnD7Tw2dgl902uQ9N3RdmAeU0JE5
 FjXkpKdRzQ1MjuZSix57EVEBg5PLDRLn6mRXFZESaKOqBs+YFS0a+xxHM6TjmOtUnqiB
 d9yLx1GUXq+o3LbCLY+3QovEGU2zXgxCxagqFkcK7apKvyZQFyDsQC6jNdWOKPFeW3JI
 zaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722536; x=1785327336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=irQTQ8XdUWdZ80B2Ynlymn+M9Ebrx4IqFd38HePJwiw=;
 b=G/7MNKk2EkHy2NmHSD5RO/z+NCAHLaTy//BtBN6/DRGBrhMsvbq9AFgN47k07ZeSQs
 LpQSAuGUU5MzqYkobjuxfZB56mDshsPAGLeW7bh5FuJgzbZYzpPQrx4UsdLRHao0nFNc
 p/Nm3eSl8gWRQKIK0k5iNEhgkg5Cac47p15RkqqL8EE9WJ6lMcgvm0Khs9g0UiwqcRt8
 QDlj8bhBtHPaqW0QuW+/EZ/RDpNlJAdQHS0tS8xNNTBPYaZG0qe1ZnbHWo/HHM3J8JTp
 IZNy0XLXawZoJr5qlrHfvmaIjftrdPKTguCOTpl43zSWyB76uj7DGEZ8LZmqOIURlk3o
 FUHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAA8z+wV4q3DVC7yJ/dXyrVR4wozrfxm9dn7jQzOrxFtQWD5+kpOhU/uUGuHB7vW5zIFTSZbhwAUw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9U1MswonH+DSHFZxx2OrQqyBVPdWseuX88HZTh5z6JV8dgfnQ
 wXRtS8sSxqiepJIApuuS4U8TtIM2asASdqEWA1XUfIXbymc4wTM/cI8KHBEeg8xbf1g=
X-Gm-Gg: AR+sD12aaMReDAEricCx9VjAw29g+0MNMQos9cuQSrZTHiBCLhowcdfqkYfrQem2Umr
 E5pFrDwA/l2ATIIPWII+G/UqKA8GGmBUQ/vVyeJpejWD3D6VU5zIoQGaYuCendvdTnBTd6zUT26
 46DQn78aCUCFskUpa7nfTtpMgC6utse8zD9QA+GODbJvsJiFrcG8sx2w6kvl21iEio7jrEE2iDT
 PDJA8ljKCmuA3Svim25uzsO/MUCvD6pjp/Qe8ijG+Yoh2yVUC8GDtsjrkpts62PrlgF1va/Qi4H
 D6JpcnT4FIBqWxj+DgRysDOhjRupYvTbT9OQgGxkBagpAlQIjVHgoU3UiabZFtGk2gl+NDk830n
 PKke0tJeWvNv/JFI24kNAr3LfjLXBc/VrNwUe2r5yrXx+Jav1KnK+tYNLcnUm7H4ATDmJ/mePW1
 RRWupnzZmjcqE1taYLOQUMp+VIUcoZ3AyWgQ==
X-Received: by 2002:a5d:5f84:0:b0:47f:80f9:1830 with SMTP id
 ffacd0b85a97d-47f80f919b0mr8632658f8f.53.1784722535970; 
 Wed, 22 Jul 2026 05:15:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm4379093f8f.21.2026.07.22.05.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:15:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/panel: simple: Add Kyocera tcg070wvlq panel
Date: Wed, 22 Jul 2026 14:15:13 +0200
Message-Id: <178472247764.1745070.12653554536175856217.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721041935.757240-1-hs@nabladev.com>
References: <20260721041935.757240-1-hs@nabladev.com>
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

On Tue, 21 Jul 2026 06:19:32 +0200, Heiko Schocher wrote:
> Commit 922fb2db0287 ("dt-bindings: display: simple: Add Kyocera
> tcg070wvlq panel") added the compatible string for the Kyocera
> tcg070wvlq panel to the devicetree bindings documentation
> (panel-simple.yaml), but the corresponding entry was not added
> to the panel-simple driver.
> 
> Add the missing compatible entry to the driver.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: simple: Add Kyocera tcg070wvlq panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/900517da69afca6f72dacf14278aee3b65275507

-- 
Neil
