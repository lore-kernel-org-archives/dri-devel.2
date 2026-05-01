Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0261DCD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CAA10F52E;
	Fri,  1 May 2026 13:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="I4T5mbx7";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747F710F52E
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:52:58 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso14705945e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777643577; x=1778248377; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wlBdgMSaBrvj4nn3fTIofsiAJVqHoduoWGd4wbf6uD4=;
 b=I4T5mbx7gc6zFeVcM5hl00yj6izVvs7QFnDgrcKOCcTZVj/41AYOCwV6cEk9yNBfxZ
 fGVXc+HYtrCWvNkU0VlVDwZZkayIUgFqaGInwghP3U/TEz9tz7mIKF49c27a4jWSyfAG
 1aAJyMh3U/6i0WvwBF7FQP9YKedhirBNEke497sGoA7Xod+ezYgRQG0mqkzzdk4lmlsT
 Y9UEFu6lzG1bFsrRO+y3y7k0CfCodRWlhDJ+WiylAMDVGK+7M0na70ibgw7c71TA9Wns
 AxvyhkP3jFWHJTc8FcFEUkXd2Zum40lwf4tLGj4UGn9Gr6PFgNMq718VkyQr+cuCiwVa
 Qx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777643577; x=1778248377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wlBdgMSaBrvj4nn3fTIofsiAJVqHoduoWGd4wbf6uD4=;
 b=lVuxbQc6FLgu0FZ8MxRQSC/q29vWp5Wh+ALdh2w3YxtkHP2O5B+l4Q+iGu7Mu4REE8
 Wk45PV5SuNwWGwDAcsp0+tCYuhE+PYranozKxmg4HaRURqWA5g/NlhIVsVUAa/9ddy7A
 UzPrfe8V66jTCRHlMpRZIuY2ETc4U8X8Y6B8igSMt/8L8g5hxLTMGapq+95g9hdvvndc
 NgfKXNFhqbqHHEWaNWfaGB52TMYtolDKwRqu0XrzOv8gerpKC+eOIx3YaUpL1VO+T8qG
 xTWMwNyXf57H8vW6jP2XuZRzOo1gjTrkdmmMUvA3zr/vVzNEVMmIzP/X9n1Zz7KcM+BY
 oShA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XwQmJ/1u+OmtgkWscxVl9oH/uqEsGZIntoPzfgf/qpXSIRcb54maro2D+JmGjKQcNozOiknpLizs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywuatr+ba88GUx6oSsIkoDJDvCgH1Vg8eICGGQBHUDYMB5mtkF0
 vLbmpS67K0HY36LhNp3/yUnaf+B6NFRzltm7LX3ur7dhGxRc88mzRjvGh9s99bqM0n8=
X-Gm-Gg: AeBDievXqgkW6OmsoHpikzZiFG4lCwVAHhqSl0aspyAHOjrAd6RQIDDztWBXnPiPF+B
 sNMco33S2aN5UHQe+8YdXBBjQ0+zNpdgTxETY97OHQaKrPHcnRNq4LQ3JlVcsZR5+/fsHZ3N6N1
 vMU7NdRmTc3jzG0GWEX7HEKRjzf+F+7TOVyxIZgpGSY8qvEllU/A7oK7oLdn6+UOr0AC7YeUzvP
 JngTR8j02nbYI8E6fW4dXPA2vCc5AKQ5U0W0D74RwWd5HWiftrbCWgS52DXSJxfwUYQCCOsZX7/
 bYa/4pQxirx6ei5Kk9JW/QdBEkOJH9aU7TbmHtyNHU5HkIIH18EVHRiIGomBQ4V4tR7+LdloHQ7
 JmQqWkVgJ5t+kjtdUsPEb8+SMAHtIBC0MoJ7bkbjNRTW/qJExvUGEyQZHWrn+1i2nSgsZh8LISS
 X/vDd7t/CN3qV29EmztFUQtXVwaW/BDFKyDEHs5cz2Am5Kh+kkH5BPYEFkAGPpjunZ/gG99bUB9
 k9z8Sih5wTyKMEiOSM=
X-Received: by 2002:a05:600c:a119:b0:48a:75b9:5e07 with SMTP id
 5b1f17b1804b1-48a844f4de3mr89135795e9.11.1777643577053; 
 Fri, 01 May 2026 06:52:57 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm143934275e9.7.2026.05.01.06.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:52:56 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 15:52:47 +0200
Subject: [PATCH 3/4] arm64: defconfig: Enable Novatek NT37705 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-fp6-panel-v1-3-e09cb05651cc@fairphone.com>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
In-Reply-To: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777643570; l=724;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DjNX5gZc/D+U2BXi73d2NzYnyku+i1c2bZwR+jErVvg=;
 b=Y2pJ0AUuHyu+EETploINL6flChxL+nyB3pK50wKvLl3v72jYTSoxvGfIDclaN0/CdVAkrGmir
 NanfOodzP6WDAj8JVb7IBI6qsyJ9NM6FbF9JLWK4/bvdAzjAevbGEwQ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Enable the NT37705 panel driver which is used on Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dd1ac01ee29b..cbf62bf623ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1007,6 +1007,7 @@ CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
+CONFIG_DRM_PANEL_NOVATEK_NT37705=m
 CONFIG_DRM_PANEL_NOVATEK_NT37801=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m

-- 
2.54.0

