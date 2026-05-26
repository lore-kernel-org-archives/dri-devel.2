Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2E2CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1806F10E511;
	Tue, 26 May 2026 14:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NWq7Z2gc";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF3310E50A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:40 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so6408207f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807219; x=1780412019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5cQRAN/rOy/5Hd0UrHoeFdJRowMHdiS3Folbw6peeI=;
 b=NWq7Z2gclzcAzS8bUJDFeu72SMz05IgJFcm6Im3ZyhHHQY4xG7EtMhuDIoU4r7b0+9
 iTUpPfuQjLJ8nlu2+1rEIFLhp/fQITciMrDEtjfiBnDEqWqQQCmf+G7cN5Af/iCNG28p
 0XFiN6c0JCaFzhCMulQC9gUuNrydHE8PgXtiMf0mF8LmR5TPMV52EqlrjCk9jRUMejQa
 PgbA+pHu8X5oUZZKFiKvKKU9jyg3OAgqQV4qZceitqk287niAYgrXvnCkaZ9QL+S73bw
 vJBXRC01kdYA3Iiho5uqvYtyVHy6vQ35iVS80LpmjRtE/jDSyoQSGA/ezgUfNzZVHdO2
 horA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807219; x=1780412019;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5cQRAN/rOy/5Hd0UrHoeFdJRowMHdiS3Folbw6peeI=;
 b=NuvaqvQGXO746QUu3478nX9diuoHMMT/1co0LHojOOpkj02rh0YnCvBWrSDmNp6bam
 A2/V//PnzpehCHp5fE2twlErVxsW6nTUAcdFV+EzVHUxrMIyQRwvwTNSZm8sF8FUZNbU
 X/JYzb17tb3zW7IK3drvTzr9dWGmHRav+8STQbSPilY5qRUcIIVH31k1QaqEUyTzDn9Z
 qeQoDC01VioDACuYxsY0Kmyz1N2x7LB9bptleWJcdmvyXC8EoBsM5h0ZhOwrp2WZmaEr
 C7sNubdrm1ZIBK7+2l+OAuDcjVKMlnM7tfvjip8Sqfgbnfvsyq1DIvSQHOMsGBYqkP9j
 9pbg==
X-Gm-Message-State: AOJu0YzFNmL5r3Ftywi0mgt0Ib+7zMYUTCBpCWz9snt8j8fRJt3dg6qu
 /iGdWodE5AiraGZ4fL5oHe04roNmFh+MclPn2gH2nuUew6KJQZbD/smuLhPsBuAKwAc=
X-Gm-Gg: Acq92OEmeXREwt8typofWkuiytYpTQFRIqu4vvogjRbQbB7dvaCrl4vzLhpjqgYLwu8
 VgY9MYXXBEy8XSJYP/ufZqhf9VfKEC2QprtJSXoYvKwBSbvvsZ/RVxz6JkASdgDOL6LikYUTyCP
 AprCJbrY76v4f/J9ppIhnpDeJ1GpGrE3fUEAblfMfvahojhlT9VXqeTIMijAWuJmmfGlPljMXDz
 F0v2qXY/rDpnJUj7J9fkUUq87UdoHV9dqcCGYRjCd6JWGhtsYiR6nB1uBTkCp6C0ryz/zx9xb3m
 wd+0f/pEi78rBgcJXnQzcET0yqLy2QVtiQZkjNFouiXQek17SAjDAFQbN0E4M5PrdyEAtekffC+
 Z/J2I0eIjiMGA4X4gX8i1HFwseOFjn76heDb3PKLIuaxWIg/KI0f7ziDCj91Ov3smRycK0WSBUK
 pnoghigfvZ24U95+deGgFiRTY6+m6p2jo442vpWLckkFzen3urlcEobX4=
X-Received: by 2002:a05:6000:1a87:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-45eb3673319mr34044860f8f.4.1779807218962; 
 Tue, 26 May 2026 07:53:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm36278884f8f.24.2026.05.26.07.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260518-v7-1-topic-panel-simple-nl6448bc33-v3-0-21ea14a6e835@pengutronix.de>
References: <20260518-v7-1-topic-panel-simple-nl6448bc33-v3-0-21ea14a6e835@pengutronix.de>
Subject: Re: [PATCH v3 0/2] Add NEC LCD Technologies NL6448BC33-70C Panel
 Support
Message-Id: <177980721808.3070642.13975316431536819752.b4-ty@b4>
Date: Tue, 26 May 2026 16:53:38 +0200
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

On Mon, 18 May 2026 09:47:44 +0200, Steffen Trumtrar wrote:
> Add support for the above mentioned LCD panel from NEC.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add NEC NL6448BC33-70C panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7a1d12f6f9305578641d3fd0ab01777e511f1785
[2/2] drm/panel: simple: add NEC NL6448BC33-70C
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/23c8c2cd3d4a2b65c21d31cf91e81d5e0b81ecd5

-- 
Neil

