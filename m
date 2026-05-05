Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D71FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F06810EA37;
	Tue,  5 May 2026 10:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x7/iP7Zs";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAD710EA37
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:05:17 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso60353925e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975516; x=1778580316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlHVQCxd0yBU+/mNTY+khRLm9HzXPlkgRkNoBEL+zto=;
 b=x7/iP7ZsfQ7mNWmADMypNDxINU3baSlNr4MRJ/sIKfTlv2OZj2sQi6aILuKaeKchC9
 dWc3ql2WbBhjL8n+j/LTw2v6A/urL/+MYeF+69vO4Z7k5jWio0DA0wCSuU53g7wnHTq5
 CLePOe6bVObMlQ6avbK8oO3DqjPZx/sbi67d7hQgvaPl/P63igleSkq8fyd7Fqun6ek5
 BV+x3RftCPaXHUFgENXWHPp/3xbmJbZWoij0rnniN5S9cExpi8Q/jmoY569gxvVminp/
 dkMOjTyENTCttE3KNvSSTut/4PrP2PjXmKYvvpFmKzo96DzTCpacVkpjQiO6tS/FZ/2y
 2Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975516; x=1778580316;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GlHVQCxd0yBU+/mNTY+khRLm9HzXPlkgRkNoBEL+zto=;
 b=Xwor6vFGXsXvzmT+US+SRHRGv9BfJIEACPveZG20GjESq5lZwTyJh+TIVnYzohaSns
 4Mi+iOLknkahXkDpad8Us7LIO2ty7PWrjScyX+anFnT5LtJqBCgyL1Epq18QKHOTMGOT
 aeKJ/7yxJavZNe9AtuF7mmaGGZJYDwL1RTAsGzDQg4Fi0B7Q+IheG9WBDGsIdPl8/xkn
 XmMkoXPPqKKAfXUzsafcZ2GibGpJK9ftYSzwNN2ZbPzcbdSq6MtIKRyxr39/qSM3AVHs
 ryIKpeEe+Uq7JE7xnE2UlMdvH4nuN9PqmAsjlb9NyodPJLogd2+/U/h9NsdzxzQY8JjS
 2j0Q==
X-Gm-Message-State: AOJu0YyvkCDOpqSOWU4I2b/3J4+6WUO787wg+aTGSnNyWFGJ1TqPmW59
 FwJdg8oqJKIJk7OJEwSNE1TxWmbiCk2Zvz5lrii3MQki/XGgsDYGX2W479nhiBNStPc=
X-Gm-Gg: AeBDieuXjToOgcAD9RdwgN3QNHUdLjE4vv+xdEPXAWvsd828ogu6PzLkMAGciz++RIl
 vowTKDTecADAIRQwr9oVq3b6yGpkqh4FsKBd/We/CtoW8o/s6d/uBXPp52vt3XGGP3LBuCuSfz+
 kQZ4V/Y7+onPTwpNl1ZUu3Hlor2PSqUtuNJyRTPnQhV1ZiWlkTA+n1IJ6aCB3HFwwWMnlvXS62r
 yxJKzaMwyvW6qH7dawV/BuHsTUAsCHjM2UsdUuTlg5A/UqWBfExRNOIT5JE22oT5N1oK/vH6+0U
 i6V050GMLPAi9ADeJHnxrgBcIiBiCgNUE/Wmw0VEiq5GUBTtTCo9OzRyrQoFn6LdwcHz9wkINdA
 uRQy9q+iw3T94bw7RRBWHVOQalTajma6VnaNs7cOGBmFdlBawzmNGd50YS1zqs/B38aoGf4QJ5g
 XPVWGt+gYUxwXZ5ofSHiCuDpCe01nA3LNO7iirZyQ9jp60wzHqw6cQD3Q=
X-Received: by 2002:a05:600c:859a:b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a9865f870mr157244835e9.13.1777975515504; 
 Tue, 05 May 2026 03:05:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm381856295e9.4.2026.05.05.03.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:05:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260426-ch13726a-v7-0-554247c569e5@gmail.com>
References: <20260426-ch13726a-v7-0-554247c569e5@gmail.com>
Subject: Re: [PATCH v7 0/2] drm/panel: Add panel driver for ChipWealth
 CH13726A based panels
Message-Id: <177797551275.290023.313213958679206999.b4-ty@b4>
Date: Tue, 05 May 2026 12:05:12 +0200
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

On Sun, 26 Apr 2026 23:39:36 -0500, Aaron Kling wrote:
> This driver is based on the one by Teguh Sobirin [0], cut down to only
> support the AYN Thor bottom panel.
> 
> Due to [1], the AYN vendor description patch has been folded into the
> AYN QCS8550 dt series. Which means this series now depends on said
> series and it must be picked up before this.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add ChipWealth CH13726A AMOLED driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/889898e011b281e77f2ae03c32246000daa3ef26
[2/2] drm/panel: Add panel driver for ChipWealth CH13726A based panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3ee01b8647b5ed894c8a18aafb4ea51b4fa05ccf

-- 
Neil

