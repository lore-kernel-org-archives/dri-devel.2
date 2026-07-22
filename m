Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61DC4453C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7E910ED76;
	Wed, 22 Jul 2026 12:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pCFMoj2w";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401AA10E431
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:15:42 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so25144025e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784722540; x=1785327340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uTe5FAQJLLQHDH6vlAa82uTTEPb2slflxpV33H1nb6w=;
 b=pCFMoj2w1g68eX/TBr7+W97OU7E+AEZKnAy9Qpwb7M0bbr7LW+lnsuEV8aIIosV2kU
 xhnyh5vGCDNb/GjcCx6pk9NEYJcm2eML25liTKtXTV9JgMDrzExim/nsg8MZejiLXUJs
 OuP3x3phxzeksekYI+K4pfYg1yTqRTM3jLkp/nxRq8kTo7K6batWOXPz/gtB7j3wt903
 oD0/01DNQt9SQMdL3f8FAWt0DO7/Mdtq1C6HWjpdut7MlFSOL/O5Bq6JFyD9yUC7obdz
 z+COu/syIKbEDxQWqh266zi0Ndbusq+TsRXyT8iUu23GKguScZJ5thwjrCrHpNP7CWBh
 hYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722541; x=1785327341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uTe5FAQJLLQHDH6vlAa82uTTEPb2slflxpV33H1nb6w=;
 b=AC0k3yfPZloIm6ORrThSB4odl/ZFKnfbjS8uZdvpDreXESvxlcDamNVuRDWhWmasI9
 /ARF2ozigtlo5i5VfztIWfZELUh5vhKN2tTEmns2CJDOoqQdRzf/5HXzr3Id3alZ4bcf
 0pmnixPZhio5/x+kZfykzRQgnv2BemWlRACZUy67B9QJyriPRsyO5EYSAe0MmSB+a5rR
 FAB09gqJfpWZ/tM/5qH6uwHew6mepl6e72PBAI+tn8vcgcINsj5qkX7Ud8m4uRms7HEJ
 cHqPt9RJeR0gliWGy+iY9UepVeIDAQ90t6Kscex0LbsoqzPOx8o3hwh0gKmDNVcM5byH
 UGtg==
X-Gm-Message-State: AOJu0YyydPqguzKDBiqQCTfxfnAK+cphteOgcklUTkKPG59Mn9EAxp8q
 JOn9WB9udm91yisgBgJtTJNJVQhTofyvGJJlTeSYcEsUPoXkfBI7mAv3KdUTGIeJuqg=
X-Gm-Gg: AR+sD13VKWgRu3ArRk8zppxIsXHTR7AiYtL60b2YHSDd9yC0XKwgu5PYd3snvNC3qEN
 iQ39MnCuCbQbbiRz291QDGs1TuKwCbK2b+xIp/Sqbtu4wZz5KY7VGDp1NT/iH4vH5972un52jv8
 eyLjQfs903jo7wuyY/kmVlJK2zOvONCiWA2NyzpUReW/VCNjKDvGpYN1XbDsLz0Rxh2nQ3aCcCx
 DpvAj7tdtBVhKJMmh5pKftlbSReCgJeJLX/YXqYmJsLsUqcCiV56LYMge9Zcidst+V9UCSNRHU9
 o5Ygc56qJBpKziTlzyQyOoHKF4GSRHEni5c1o/UFVFFSgqCdOPaYTISO/YnOh5uB+XNM7NBr7DC
 uvjzpbhFpviV3u9MSozjheMdlGO/DWQRsUPyyDXyDEAa8JjSZ1roPblg9iO6BLYmlsyQnah3Soe
 8bZFEq+iEHlnZxZNR8AVHDP5U=
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id
 5b1f17b1804b1-4954e126afamr259062795e9.26.1784722540451; 
 Wed, 22 Jul 2026 05:15:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm4379093f8f.21.2026.07.22.05.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:15:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Albert Esteve <aesteve@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm: fix missing header include for drm_panel_put()
Date: Wed, 22 Jul 2026 14:15:15 +0200
Message-Id: <178472247765.1745070.9105161637266531122.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722-panel-fix-kms-panel-put-v1-1-ebde56446ee5@linaro.org>
References: <20260722-panel-fix-kms-panel-put-v1-1-ebde56446ee5@linaro.org>
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

On Wed, 22 Jul 2026 12:07:30 +0200, Neil Armstrong wrote:
> Some DRM drivers lacked the drm_panel.h include to use drm_panel_put()
> after the commit b71a623598d3 ("drm/panel: of_drm_find_panel() return a counted reference").

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: fix missing header include for drm_panel_put()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/057fad48d7f9f1caa90bd32295a03228254cf1e3

-- 
Neil
