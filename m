Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA01B106F309
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B48710EA21;
	Thu, 26 Mar 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A8Oc1npU";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C600810EA20
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:40 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43b7481f9d3so368475f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515759; x=1775120559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX+Eq6ZJKid1E3TEpQUMDLjD96hUECbj70afvdaxIfY=;
 b=A8Oc1npUGb+pT0zVGUq6EekdKBoSx97GvMIpRAT2GAGrdL/oqAzEjMgmNwjkcbdAtf
 R5L6//CHaR82zp66zKYBiArmz60PB4gWz0ZR5Ykc3LtPpV2MXlI9bQRKRJ5E70F776Eq
 bBYXDMpSbYKs/037/P0TgJ2XhQkpTxIeiYcHgspQE1QqcTEpItSX7kRpQ9X6zLbpu+aF
 3Uw6FTvM7IRfSm9c1t1NBwfyOUBbrFq7MOT+irGXoQGrJqBQjPOz+lCkYNok97kPab2b
 3F8Rq/UUlzGhh8J0dlhuZnW9dFEec8190ITxUPk+rSc3+F8YxwzXpJydAhmO5UjuXH0m
 0LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515759; x=1775120559;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JX+Eq6ZJKid1E3TEpQUMDLjD96hUECbj70afvdaxIfY=;
 b=mMpsJmhphjJaYxio+cGhuJ30sDRVFizwU9MLU24sTq29wdWx9SKoBOLNlqcgSXdJ7h
 K7offVerd22/Pre2dJRuqrhHDgW8vFaL1e1/G0FXgDCshKXh5J32kzQytHLajs1gI6CY
 IcpUUVYNFFoIqGkFHXWeOK5g3jFI+Hp1j2qQXPIuaSnExjSGGgiLKwm8ESM3U+4dkQcn
 /46k5bIr7Q9VS1KQYS1ofKX6AzapZ31TWpqHUsN2rH9gHIUYWvDxfcL4aiW2wxWquTfN
 H7HJElvX2ShrC1S28osr4uUtjuw7vG5DLEmLVM3LfxkG1SDwT16d2cGz/Qqwoyb9xSvd
 wQzg==
X-Gm-Message-State: AOJu0Yx9UfH2ssFKIguLubi/zEOcQa0oEWIHQQ+OGbyrVbT/ROEGOsaB
 iSh9WL3gGvfj+LMAcNhBCJx7vS5P9HZ06AgfiwF1Wl83RAePe99ueVPUWz5bXsI3r0Q=
X-Gm-Gg: ATEYQzyejhiraACOh3KmVi5KjF4UQTyOGUeyQo8KYBtCWPOyrGqeT2M+gIUFiLQ+DWZ
 x+K4H40G1u9KsEEOnziKbhkkG6aCjykVsiGgcTVspVnZRynMPSYoTmrlZ3k8Dp7SJDv+JL7K1L1
 FHPEypkKxLYzGQPh9I9aAx9PAKraw8amXKf8QQnmzVOf52CaxNjGdz8jhmOG9VWvtSU9auvLg1B
 fc5XzfZFuEYvaKiYBL4OxdR9Xjl4ZBNtcTgrYebInJuhzsbKMlpl57jaeF84Lon5HfgtTgO07rj
 X6qEaJs7Hc0tCHpPcfqwy9pfMHIsXgUoJBIpmg6iX/BzpWlBG7SeiwCT/Lv6iWF2R6ibKbmNmym
 a7H7jnl8q9+pGCyxbEnu9kIQv5gHw+TJF7Rr+T/4Dr8Agys8w7qp9tolV6Y7+iKmti1Smr14WZ6
 wZttyMBppkLLwKhibLB1L41ePQv1XBEHuqQED/e0xaKAzE
X-Received: by 2002:a05:6000:4025:b0:43b:86ce:279e with SMTP id
 ffacd0b85a97d-43b88a411bcmr10944712f8f.44.1774515759194; 
 Thu, 26 Mar 2026 02:02:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com>
References: <20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com>
Subject: Re: [PATCH] drm/panel: sharp-ls043t1le01: make use of
 prepare_prev_first
Message-Id: <177451575851.103892.8993961022549136919.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 23 Mar 2026 03:21:49 +0200, Dmitry Baryshkov wrote:
> The DSI link must be powered up to let panel driver to talk to the panel
> during prepare() callback execution. Set the prepare_prev_first flag to
> guarantee this.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c222177d7c7e1b2e0433d9e47ec2da7015345d50

-- 
Neil

