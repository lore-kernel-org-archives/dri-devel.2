Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F160FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B2410E846;
	Mon, 27 Apr 2026 17:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W53FUgLi";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABF210E830
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:11:48 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6948fb494a0so4278889eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777309908; x=1777914708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRXPhKIxUEkhfArxTsVmrthzYNjEzyOQR0qGn2CDhHk=;
 b=W53FUgLiVpIx712MLY67A6BMrY7QIHcR6lW9dFtTPAiSKWzDbCIFjtTf0lFH5fhCcP
 9uXfbMDSgt9LW34oL8Cr7xuAwHdyE70DkYbgI+m6z7Uc4asaUqWlET0ah+PLhctkTlMC
 LZ32vBUHG7P9aaXUj/zQ5x5YtPeJk00GqF1IJ4V2Vkh0DBZAqkuZJENE+TtEofPcx/yt
 iAdNw/ypuMcamvFFMaeuNUj6HCo2TGvokXD9nf2RxDkl+1x2QHlnj8S1D44quRp1blJZ
 pYyM1Ox94R63uajul92acsPxYv369dhyXacH+lF+BlfpXJGpV/y2M+ASORi3tt36laih
 k4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309908; x=1777914708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRXPhKIxUEkhfArxTsVmrthzYNjEzyOQR0qGn2CDhHk=;
 b=BxmB9J9qiZiMbTO3T+uc3VobOtzr1YqzybK1u+8yM74jRqKCf5oAwoWh8At0PVv3BQ
 vNSudEi7JOk4K9Btoo/K6TSAkSSiNd6bTvDTBfoJtwf4aZJPXhJlZS9FIMz/imYJMQC9
 WR7m1PlUH549Jsr8n+lJYyoAD5g4hHeghwDGiCfdLQ1iRPngJ4560jNJggUMP49Xq+QT
 ujf5qD/U/BbNk3j/p4m8lBWRIjTdJFDMEIuM9vrVPsmd4pg6Ax9WC+CNr23lGYTXxkx1
 BwrrABMw9qEIaOILMQWNVuvSA+wbO2uDe73GMVD3jzkyZQ7uif6SYvpY5IjuaGGytYBh
 a4xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NxY7lbMoo5F5MtebyVZtrSU3PUCy39Dqj5IrokCPOLW3KKwNo6NcbPu1wA3f6QAGgWoTGu8v4AIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyXaqTp/yx2eIJsmnKteh+QGBOXSQxlizVd/BQqS6HnHQu8BSD
 1Ku1rRRK8PxsaDhDg1a6gOYLy0mEPXXWelsgLzdIpr1pvFjWOzbR3KBb
X-Gm-Gg: AeBDieuqkkNtjo8JQIm6eKLD+BWemBqdhi4B378WFeH52t5Fv1awyzfkUmQ3zqZUc9i
 7FGQJRNnL27FNjJ6zBkcNk9HNmM4Gtjg7Wz0Di8Vl/GD+gBPmy+waAysvh9WkPVT3nB6dFlWKYo
 opAH1wgM0xPWEYrBuxtFElfQzAwe4NBXZyVlveaB9zfwVKIAX3gb3R7rFbFpfXfPzVMjI/qVpgn
 VYJZEq0I4TalzWx4fwnG/1XlRKRCE+JJzMsDHhyJe5qoIda8YRfgExtUBMD462Mdxi75T8uzz7H
 qnGCRzRQpKvfMzNWKf5Dk9MMxLgsCuzzSU1qJKl0D8CFqeobopW9iVSLNGbPdTU5sG1ilpcpKza
 glNSZ5pkEPa6XsClx/gpjxA7tdtmifzKp/SNAhrk9y1PqdkhFKD8IpJhNnG5fopX4v0nWqBYFJQ
 LY/diRViNX1L27T87t4VzAxDkCbRnQaTc=
X-Received: by 2002:a05:6820:f00a:b0:696:1a85:587b with SMTP id
 006d021491bc7-6961a856499mr11658167eaf.39.1777309907872; 
 Mon, 27 Apr 2026 10:11:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:11:47 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org,
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
Date: Mon, 27 Apr 2026 12:09:13 -0500
Message-ID: <20260427170914.5062-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible string for the Anbernic RG Vita-Pro.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1a9dde18626d..b8babe9d3a26 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -66,6 +66,12 @@ properties:
               - anbernic,rg-ds
           - const: rockchip,rk3568
 
+      - description: Anbernic RK3576 Handheld Gaming Console
+        items:
+          - enum:
+              - anbernic,rg-vita-pro
+          - const: rockchip,rk3576
+
       - description: Ariaboard Photonicat
         items:
           - const: ariaboard,photonicat
-- 
2.43.0

