Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FD5FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D21B10E44E;
	Tue,  5 May 2026 14:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EiL/RuTv";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7C010E44E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:10:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so35877265e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990227; x=1778595027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o39g8wlpOFCzeTe6oMKFHWRTSB/POxW3BBRThWnn5Hs=;
 b=EiL/RuTvAgI2EL8Tj/qWku64/wbxNMz5nqyNokyK5u46NuEpY8gPbO+tahUk87vzsF
 1nusiz8EWzhjMgQ9vAPlhWqfB8G/CLsv1Td/hMXNYmsCaNk+a6FVwcNjTKBsLaUuRr87
 FZkGH7vcDopuq+YElCycvFc0NpEcJb69ApWH+jCOB7etiufSHhxYr38VAuScsFO1rHow
 e8wjUidUxprWt+kdRg0cWB4FCpWQ1n3K4IL2zy1Aseu8sXyCqp5QtO7Iu5uaC/3gO3+G
 lcQ9AawkkSlg24rScv0ppEh+FxpQOTXBmTRRhtQ9rzPitmoVQ2rMPDgoEQMr7/DiQRWc
 GeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990227; x=1778595027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o39g8wlpOFCzeTe6oMKFHWRTSB/POxW3BBRThWnn5Hs=;
 b=bsgcvgCI4IBgaoVGZTsOjSLbe8tRnCMX5uhTEdVTYsr2i4afOzqTZHph6pdYGju/nY
 FKRQOZaXIWCrB54uQN+T7Q22AWeF0eAqIgsZ+1su9k5EeLufuXpdiRW/eZpX408tFmxV
 N5y681wysWeZ6szeGOqUSV7PGR/dilzOtd3SJR96pT7XuW7RxCz7Ih7C4MPN73kPCG61
 PjqEToAYK3COXmxXiVE3PnbZEGf/uvJHiU4640zxwDgzWtHH/VqgPvtE7Bz62UU68vtG
 1fCcep14uEOXdLlXYA5bDt6U3vR7lA8RjNqINOXz/jcZVBmchngyQrWCsiCQRE5kqn4F
 3c6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ806Ai7E8iMLC5ij31BLe2G6cdQDtQG9H8dVFYDHjw/0KFawLV7el3jkB5VGKSqBfQr9gnLtwT+08A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyslzPmHJHVSPXN9/WgLfNXdyfhwvv+DIlxSAWu5k/MAhuMaFQ2
 YPfhSfS+HWfnJsQYSIYi9Bjh5khLlRUEKsaEVFujMeVWB6LCXYKSvOVSovUY3IuOXfg=
X-Gm-Gg: AeBDieuGHuCjMvlRldCsaRtfKhk/mxjqtsO34K2IRxvq1HH3AwKcdmmaSxzf+ABU0ZE
 h7l2wwdt9w3fOJ84CzWWosbVy2a16axS980BTwNkaERrNIg4CLZ/Bl5yYvoFYO9g+HREGnESyNW
 Owyb4rLuT058ZuDzUHwTvBG9tHTmM+SdvVYozAVI12LHuieiw5RTvzl1jMIU2qNJcz0yhEigAee
 Pb1TtsGcaZBoTgWsRNVwdzHnpFxcp6B2bPNqzqgbJFPJzsyASOeTA/m8fFh1p/MCdgI3ZsiU2rE
 KGQcA/yiOCASMrwmCNc1CcDdafxn2H8IR6gkXnxkY7d39XIWspR6xREqUJcMaHUYGA8nRrVYg+j
 gdfRke8Jiyn3Y80MgFnKXU0lnyrXw7Ww1MCVLerLibT2TF9yskM1mLm4DVCLGrfwH3/3d/JiajF
 h/tFs4EBZhIU6NmoNALN52aud/lVFtEYCcpIm6dAIcEjv2FV7Go5+0IvU=
X-Received: by 2002:a05:600c:8b17:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48d1426cdecmr59572055e9.14.1777990225978; 
 Tue, 05 May 2026 07:10:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm409279785e9.12.2026.05.05.07.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:10:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Adrien Grassein <adrien.grassein@gmail.com>
In-Reply-To: <20260430085344.34271-1-francesco@dolcini.it>
References: <20260430085344.34271-1-francesco@dolcini.it>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
Message-Id: <177799022502.801510.5143685041087488845.b4-ty@b4>
Date: Tue, 05 May 2026 16:10:25 +0200
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

On Thu, 30 Apr 2026 10:53:42 +0200, Francesco Dolcini wrote:
> Update the maintainer from Adrien to Francesco.  Adrien is not
> interested in maintaining this driver anymore, Francesco has access to
> various hardware devices using this component and the vendor
> documentation.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7aee5b1da99565d97fd898d5fe77cb55b9ef7128

-- 
Neil

