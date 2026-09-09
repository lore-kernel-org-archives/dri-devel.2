Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D302DC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FBC10F1E0;
	Wed,  9 Sep 2026 16:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dCXIkp2X";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E1F10F1E0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:38:09 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b93204449so2985115e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788971887; x=1789576687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MeVq8rDairowljrEmGCrzLch2/pf7DNyzkC5aOrOsz0=;
 b=dCXIkp2Xr1fW8i+Be2esNqF5/97E4uvYTpCbH38So16Fi2Rn2R/uljAB4MsqvLNYGg
 Dfmlw9/01jtktJl91dip5O8/TXnGzhCAmBnNjqM15ar5MHxV9cFQq2MvItFgobo4l/0X
 ldj9FMikS5xdwrTJY9aMAxJ7XIVAFflSgTmU4+ZAHwhONczpVYe6+V7X8Z+23SZLMNME
 T6zuPl/5ABw0V6AF5r5R1h4r/caN9Rnyim2FPzMIOvMLV8SIO0GHaRy13Ssfki37uVOQ
 0Obh/wmkwIi1SzHgVBVhJYfwR42aNiXc7bn6AUhVVay+sCqH2vEyz8d3bY1FQWld1DkW
 5zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788971887; x=1789576687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MeVq8rDairowljrEmGCrzLch2/pf7DNyzkC5aOrOsz0=;
 b=lAikOikW7Gprm47X8eXl4/FkvbEySs59jtZu+zOWmA+VkLVTG66Sn9tcsJEXYrT2H4
 TIkk9FW1EwLUMOot1xjwvxTXk7LiD+uCcZyftUdtJZWymv/jHznD9UAof98oC4YxrMG/
 5NBBhgFv2WjQ0BsipNJ7LLoFtbPjYu+kYTZ9krN6lZTKDDF4pchmF5sXgDo+7coli/6l
 qiE43IXfVcP0aVT5J1v2+mLFHeqgN3oNjXZVHajDfTzYE8XvY2hWTxw4ZOmD33HVW0Rt
 RzNLqHTn5JrvIYNvb1vqKMlLYgS+QDTgIXRK+YphJu8VZqs/R0byucMsZNSQ3aiDCR52
 juyQ==
X-Gm-Message-State: AFuF++mwarrRmEzwx5ZjrVZa4KsdgAKgjqlfpt2WaXGxqkx/X7l6sVKi
 8B3nWFtr/61z3PhvuAQ/UIBKFOX+Lm4U24YPttFYkzuMSPaNI7gPrVPOLPmOZcHX
X-Gm-Gg: AYBFou36KQL+c+L4PWtVwLaT4xzyyu10VEsNsMOcoGtjm95BkU6C29We6bw6PIIXbIp
 OnO6JMswbByOYvSqYtpkFgV6jh1vDXewrzhTwLJVi3+uQffUq3228hzA2uQEnvLomLrwHYxVivo
 wk18RySOuu2jYMZcJBdnwZXDrRaeP5Idoj/wbEV7spJOsIH3xnARbOmuPXGqF7oZucP4xpx9SjB
 60Me4c+A5PnpnnoWCaTr4fX3ihaxr+hM3x4/QiBRROu+yQ0x2woqsu9/JsfD7GdlAGMbxP97H82
 J7BjZ54gQ9UADWksa+WyNCzHSpbw2mqtSto4iNjmuBDWb6nrEAtGv8giIh95YZ5fAR/vCXdcazq
 JOvb3NQ+MPLmRSTLFBiauWNtONSKBCy4Lyc4dPku+OPsmvbSuieZZGuZ/cVMHiavRXaYN6hd3ql
 cX5r8sWpZ/jNFgqznnDk50Q5wY7NEpErHfSmY2vRaber5dA0n0NdTXYU30jh9ktuaNr/ISPDzy5
 RLYHUW81/H0KZxHHfHvil5/FVDPuKUF8bxGRcYgllc1CtsyrwjP/c7x+GFAuyhioDF7vsQCPEEA
 c5sS
X-Received: by 2002:a05:600c:530d:b0:49c:e363:c66e with SMTP id
 5b1f17b1804b1-49d01dce86fmr262368785e9.1.1788971887351; 
 Wed, 09 Sep 2026 09:38:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fb40e1sm66537515e9.2.2026.09.09.09.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:38:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 0/3] drm/dp: shared HDR metadata SDP helper,
 and max bpc for dw-dp
Date: Wed,  9 Sep 2026 18:37:40 +0200
Message-ID: <20260909163742.37003-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909163206.36409-1-royalnet026@gmail.com>
References: <20260909163206.36409-1-royalnet026@gmail.com>
MIME-Version: 1.0
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

Following up on my own cover letter, where I said the series had not
been built.

It has now. On top of drm-misc-next bf63a72ea005, x86_64 allmodconfig,
building the five objects the series touches with W=1:

  drivers/gpu/drm/display/drm_dp_helper.o
  drivers/gpu/drm/display/drm_bridge_connector.o
  drivers/gpu/drm/drm_connector.o
  drivers/gpu/drm/i915/display/intel_dp.o
  drivers/gpu/drm/rockchip/dw_dp-rockchip.o

All five build with no errors and no new warnings. intel_dp.o is the one
I most wanted to see, since 1/3 moves code out of it.

To be exact about what this is and is not: it is a compile test only. I
have still not booted this exact series, for the reason given in the
cover - the runtime testing behind v1 was done on a rockchip-devel
kernel carrying the v9 generation of the dw-dp series, and mainline's
dw_dp-rockchip.c is not the file that was exercised. If you want a boot
test on the Orange Pi 5 Plus before taking this, say so and I will do it.

Igor
