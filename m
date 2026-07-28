Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BCFC54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8253A10E54E;
	Tue, 28 Jul 2026 09:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TNoFd3m/";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158ED10E845
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:18:31 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso17615965ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785230310; x=1785835110;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OWdXeAE8uA9DV3aiiuBfjSr6VRPTM+UnFjc1T+sgsLA=;
 b=TNoFd3m/n61URs7ZTUdlS541rCLx12VRI0Nx+QuMbhztkrr1NnVT0I3qPcqJfhcUqk
 88Cxiq0kHsu7QkQZjmgwBdOuskIYAmLpkHH6LpJMCGy1nBKOEHrNXPPWHF1OoZQNkwuy
 ZYL3wF1GsSgi2RKPpX0Rj3XxiuNubIo1oxLUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230310; x=1785835110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OWdXeAE8uA9DV3aiiuBfjSr6VRPTM+UnFjc1T+sgsLA=;
 b=otYoaDVHjt1Z3Y8u7+i2beQz9LuJ5DuF/CIXF1VJ/5KF+CGZu8wa1MK8PhHxIyUhAn
 MdSre/1/YK+sNzqjbb1OtiQ/0xbsdBbdaiRRoS1aGVLYZBubxhGYUwaFG1S4i8s+U+3Y
 5vXjCrI0k9v99NdW2oQx3aYBAJicjr5OVzjFmCsD9b+MITlk8jXO52ItJwMgE6dO8EDw
 XSFauz/uN53iU8Kigks+8hnLWGIOPVEy+HFxW2zjpFJhfJVK/cIFizzXumuFm6p59qcO
 EBT+QpKskvDRRH3RjyFb9c3l1mjPF/ccQvN3eSu/4AhV24W4QBsldVI49r0KPI8KeMfk
 elHw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5EJbWvoI2N4cC4fWkoFb9MWYGY+jDEaqYarCkRWr70hNT9lCW7Yu6p8GJ05pvylvk7IJzxRhUjJE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzTguThXk6fG8qYdwbSpp6uBd4/rkpwJCM+I8tO1ylImg1y4F1
 ib98ZHRynS4MxWgZW8f04WYWc71k2/kRtdPgEoiz6CA2jvZmTZaVNITSKa7kEYkePw==
X-Gm-Gg: AR+sD10DuZ7rV9s2Hax5V0NuGCjbAiwFYjQ7R2WWOLypVcsTd6a0heJxRHGLSHeprNH
 mIDyPMDXInIb0JLQzXbymQl5y5jaiSKsenaLhb//jmPuABH23i9LIn/2RHmEoyLuQkW2pzNJHSz
 05jtdlpBBmaeq/kdgZoBamdiTv93PI4UdDgMDkbPwcCG3XPV24k57YSkpKnk0lTxtv89N3Bk3sb
 odDcy9Ag16K2axOPhHP+Wbl9GGAdw+ERaskL5+JvkfsKhvXPdruraXUXVnvOiE4CLoUld9n9AfD
 xt8VKL7X5WULhWB4N9hew+e6O0svO3kFbGA7wdQzvkCCOWtc6Fgecv6k1X9mZrvDHDLYOuWVLNf
 HfUw3rfq0e4u+OX3kAeJDNS4afMq567z/ov3TwjAU/lKft6LdK4AJ3V7JP+dISMnnPhNOFZz8/T
 0/wQXHFv8VR9mR5xqgw8DVBU7612YdWBi1xJJ3APNffriv1VG4cCKVqhhPNe5VqLxMAKMvGa2xU
 ZAdRlg2NBxncVn53mkyNihd86LoR9RXbGAfLigLqii8fQ==
X-Received: by 2002:a17:903:124a:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d015ace749mr18293065ad.7.1785230310643; 
 Tue, 28 Jul 2026 02:18:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c85f:b2bb:a077:d544])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81dcc1sm48616965ad.84.2026.07.28.02.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:18:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 3/5] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173
 GPU
Date: Tue, 28 Jul 2026 17:18:01 +0800
Message-ID: <20260728091804.382753-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
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

The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
of the Series6XT GPUs, another sub-family of the Rogue family.

This was part of the very first few versions of the PowerVR submission,
but was later dropped.

[1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a43c79c2a.camel@imgtec.com/

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index a6bccb600a57..e9218e0f363d 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -16,6 +16,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt8173-gpu
               - renesas,r8a7796-gpu
               - renesas,r8a77961-gpu
           - const: img,img-gx6250
-- 
2.55.0.229.g6434b31f56-goog

