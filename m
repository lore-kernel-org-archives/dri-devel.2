Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FBCF8E4AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B70A10E95C;
	Fri, 17 Apr 2026 06:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oeUMhVq8";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A59F10E95A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:47:19 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5a2c77c62d7so411989e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408438; x=1777013238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cla95yKUKTBsgVaDvfogIRMWaCGGOWq4z1TFG4Fvu4Q=;
 b=oeUMhVq8soAL/Gs/O+mL6tEpFMUqF7TSMSjHnYsnBz7tNVoNJwMEQz6VEPwpDquSjF
 RuQsYmYkGvmWScx4ZSW1brCvNff5BHzg9UBpcnsTlQjBuWfBQIN+Mh03fW4X3zpHgWSP
 7MQdc3JiuYv4jn7gtTRoG2PZazPkTv5+xZMDevBpb79ewcV7A2t30wode/MM/EacmAZo
 4cOwEMu54zfw8nyKncR3S77nPVhs3lL1tiwMzwWXO+5jjNuvPiVvre9h9blxATrCGJqA
 oXGMl6wvgIRRb5z7jLZPcQVIHrsUXp3WLnWFeQFTruqlAGGZu74x03ug91uUFADK3MTe
 tvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408438; x=1777013238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cla95yKUKTBsgVaDvfogIRMWaCGGOWq4z1TFG4Fvu4Q=;
 b=NuMQnKI7tc9W16ue8wEEadPmt6MzriU32tmZyAzRqXkszX1TYYYODP4ef9hpWkZxXn
 BBUTQ3M0izUtgWgG0ZaNGWKbp40PrqqGHHrE/q/2/v0lJ1MdSNFT/Bv0qhB9XNNCgFAV
 jCQE9clfWTJfsOjYI8oYv8/VMI5WV3vc4cQ8qSPUETbwMJFWv2msHwIggjIo/QLQq4da
 O++zNpup++w5qeR8A06YDETjj2Rvrjmlrnhm6mL4I1E8EBKHwERPQcWPNn9LFtOM8HEs
 S8yX8VPIBnxYWgJduZlEuszc+0YCjNnwuDKvPRiWpLes+MhAihMigK7uOchuq24soNLk
 CCCw==
X-Gm-Message-State: AOJu0Yypqf97DD0rPcoff6jAZ5nD+K0K+Xnx1IM0JxFEwGJbnCYi3i5U
 LHUWJ6NxnQZ2h2m+xiAIjz33BmelnQXw29WRK6LU27EOfgZcC/S53BBw
X-Gm-Gg: AeBDiesEeKtV54PhKyk7883LscP8/Hyjwr9yV6P8V3zm+Zkttcb4J6hAWW97mmaqw+M
 Q3zr8MRm/BhFxfR9L4+wGZkJi4yn2QCYj+SoCw+neJ1fbWvb2EM/R3LOxyzrT315vSXVzHKODfq
 EU1LfaDXcGL3BbWbkTrpVQH1ZRKyw7AaWFofsao0h7G/5BEl74m7TpFpbp0n1iVQYQx0b7myg8S
 e/rLxJr4ALquawUfdyQhMGpgqQ59n+wamd+ugoRN51LJqqggXOSBgDvlc7IKWJd3AQM7rMkgVLG
 OSBn08k07iA6SwbKbc5ThCxadTASUPrJF4LbQLXuSxAd7ZVhJL1kskcgNEvpJqkPLnVaLwrT+vk
 OmGoSLRdwzh+NA2r/4UkI0PJ3C5CgVoiHccL2yDYOtI+1YQ6EGo9FmCeZMSMBYzX5T0RvqvD7jn
 600y2piQIXsamX7/nTGt0yZ08=
X-Received: by 2002:a05:6512:138e:b0:5a2:b8cf:39ce with SMTP id
 2adb3069b0e04-5a4172bd2c3mr417584e87.10.1776408437508; 
 Thu, 16 Apr 2026 23:47:17 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ec365sm141768e87.83.2026.04.16.23.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:47:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1 RESEND] dt-bindings: display: bridge: ssd2825: inherit
 dsi-controller properties
Date: Fri, 17 Apr 2026 09:46:56 +0300
Message-ID: <20260417064657.20293-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

SSD2825 being RGB-DSI bridge should inherit dsi-controller properties same
way other DSI controllers and DSI bridges do.

Svyatoslav Ryhel (1):
  dt-bindings: display: bridge: ssd2825: inherit dsi-controller
    properties

 .../devicetree/bindings/display/bridge/solomon,ssd2825.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0

