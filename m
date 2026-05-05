Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA2CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08DC10EAC4;
	Tue,  5 May 2026 12:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oGGHN1cu";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34B310EAC4
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:51:20 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso2414035f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985479; x=1778590279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UYQAESnOyxoMqRm/R2b1rrlMHxu5iHH63AuKOpb/GM=;
 b=oGGHN1cuePs6+br+ze7udRp8pPu+mX/bQlrutybXLzXLdwcMU3dtz66PnAThKNdj7z
 r7x0YRREf62Aqf88v6bHtwdxm7P3smG3Xmwqi3mGEZN46RU7dyUnFQl89Ed6NZxMtJBI
 cJWohtRyLqw3m7H5Yaq6pQJIrhyPEqIhkYpAhmNJi8MzYcENpers6H8IacUJ/TqwIjCe
 OziEzPCwVky/2f8eygqQXp3a3/96E4Lr1mG4rH/M8csc++VlaWriJ1lYbxn5k2gEm84d
 Ca0k/1Ld/7NFZxpWjqY54y3lH4d6qTXzi4QY15/FC5OPeCHnsPgqzQPWf+TRk6osFnkJ
 KY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985479; x=1778590279;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UYQAESnOyxoMqRm/R2b1rrlMHxu5iHH63AuKOpb/GM=;
 b=H2n4+/Wlylkk/+qwbNSAO6ZRYgyfFFAw12OcvjEc7U8ELwk4eVb4Yi3AKCADgIcY0G
 /HECX19ERtEPg47kiOxQX/iqVIVANAGcaqK+p4Aq+lWovWyINw9fUlP23rliWaRZgyxP
 natfAX5sq4la7Izfja7p9ssMF+74VR2Af4uTxpphPhxHJ+2EISBGP1hTy01Vc/tjkyj7
 Pm/UFkPEtmio39Ob6bPYOdVZplfPl8xODEaDIRkDU3Tt+G9TnpIKo+oT18gDdaIQ3+qB
 J02U+PRCsh6DrgHgbzSrP2Rdt7PSi/yPgTlh21j1DUnAG3NrRjEm9IQTmfA5HH1blT0P
 4v+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pL+TzKKDuBgDE3E0/Rbf+aGxe3yj/kUnFH1tdOE4WdkahQsTqonHlaz+85/4b4HeRh+1mXuhOCPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkAL5wZhipH3LGT+s7wrLu/iSJKOhiQC4xae4mkW5QVIW4qHUi
 WbmMVnMJg13CTOrFAcG5fZoOiGoNJ8gt+wCVK78UkXf1cHBy2uwBLfhHrDdCD5TU1CQ=
X-Gm-Gg: AeBDietQQjfJ3naujt+ixsMqETzMfZjKxlxuL7xFami2mha4MGSkIqMYfW/7HHxYGPg
 DDQBT4eBdzwn7go+9lbaIQqJ6/e1Ou3S4y8jDiUeerMHKEb793upj418+anXV7G44H1wpYC8Gmz
 +VsXjwedqMFBTAGmaKtDXeBk0CzOJnQdmArqIgOGsYpj0iNGVlZiuwAZ5k+mPMVkyhyHt5a9eWO
 4Fb2uA4QxRBptbKcWPSynGZR7FqjftSrEUQxoMXA5pNB84Scj9M23qvCg3id8DRnxLsSkxfECMf
 j4rt5FeqFZzdhgmkYUl5qWoh/OR5IqWwTHVnY21BkqKCFqA1ps7IJqIa25rqVMKmOZHyjWVDACP
 /jnzg2D0GTWMa5ISj4GPInhjSStIaF7f4HYoGvlGxXtPW/wo9i4k58dynAprstdmYC5IVrTkHY5
 hRYF53WMrpqu2qeuFb20XHsUZeS8WaoILj/6hU5/1l0fKtJ4SnF1395Mg=
X-Received: by 2002:a05:6000:26c4:b0:43c:f247:4792 with SMTP id
 ffacd0b85a97d-44bb32fd802mr24179647f8f.12.1777985478915; 
 Tue, 05 May 2026 05:51:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:51:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jitao Shi <jitao.shi@mediatek.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
Message-Id: <177798547810.553197.7357142190879759101.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:18 +0200
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

On Sun, 03 May 2026 17:17:08 +0800, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending disable cmds
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/570cf799e87ae805eacfab3b4ba66676b5fccdb6

-- 
Neil

