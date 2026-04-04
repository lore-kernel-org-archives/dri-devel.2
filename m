Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE76FE63FEA
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 20:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019DE10E052;
	Sat,  4 Apr 2026 20:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ofgy9RmS";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB0910E052
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:04:50 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56a857578a8so1046501e0c.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775333089; x=1775937889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MQ6/dIVlDkLkhz7sEG8ZPD2tsrLrbIS99Jl3sqf2Sw=;
 b=ofgy9RmSynjzTjQ0LeBczjWTnn+hD0IqLYUgB1vQxaHebNyIYugBd2QGJL5AuTvIRo
 jZEZXWJ6Cmy0LxWN9+ANd1YBKfJAx5AFDKQMJm2AveQJKBg8y7WVyDKzd77usgsWKL43
 gLClw5v2F8BGtGtw+i8cUMwsqPzhQuWw32YemTY2L7SzFPvITOHGPxcmBB8IQh/xOHTd
 r15/JqqTAKibVzekd2W/yvvzExFi+i3y7PFzqLdA7rxiipgSZpUtuo4Coq06ONj8lofi
 3zcRHfsJBo/JYg+Ag2R9I0vNcDQkSIUOEmR6m++RdojeLhMf6kvwopmRIuriJ66JHmun
 zq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775333089; x=1775937889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MQ6/dIVlDkLkhz7sEG8ZPD2tsrLrbIS99Jl3sqf2Sw=;
 b=mTdoBBBsJsmHzJ4wqI0oL/rGIt7AESPLvnttq3m0vQ7z7J+KTzudiJDSRDjc/zS/BY
 9Jut8LTIHu+RCNnx8MhV6cZOpvqPLqc/ik9DEcxjDyWKJjppYXEyiAz5CJIRguOyYTT3
 mN0wKoKO08I2lERujaquD8sULWQ1wVSOQbMFDr9T6qBLLWL9wMHqL7uPnQa4qZR/OMpf
 pnol3N1d0ST8plid5oYdgL2Y0F1Scj9/VCU8EbxTz/VMeBn5EYlbPhhPYHsFOqSNPqe2
 mJMihFLws4MOaeyMuBvApa8l/i7+BRqVAN7pOh9CALYlnqgwRqPiwsFIzMSP955V2iR5
 JubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9W4iIQXY9OxlWkcALrBLw2KqzFCoUgDte4GduzXcFfxiwCZgp39K8VT5Xp+LDx+u0F1syTHm8Odg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMvcfQwntt2zDBy1psIrtDvDhXrApxYLNmo6yV6CSfxSIhDmbn
 7DzQZAJGb2iq1KBEJvLm06QBrNx6gVCX7Ne6fOfEt3Grl8ebS+UHkb9k
X-Gm-Gg: AeBDiesGe3LO3yFCb8MXYeHcCvdYXyNRLl46/5I2EYpOlOkVdDFyHRqDO4a6xzOvm9l
 0Sk2oySyIPPZRqQJ9UG4ia5ulVc5VS+4KIquq2NiKRX9MBaAgW8C5Sgm4BKwty7G7kUfFS/Io0c
 R3ZVFyxEoMIMfob+prfvHZqiKPiCK/JrKaKp9ku3aKX8+sBShvcSdtHGguowaZEeKaBfM2iyf02
 TJ6Jh+ToldMI8vbywpc62ZcGKpTc61K1j13MhOQdt+V7s/SZeob2gExgXFdXFLHXZSk/jZ7qC6V
 2Si8yq3Cf+3P+h1ENFu6eyDWcNMygDBSUtfWG82djQ5R2RgbpXitd++n9lEGjVHMG1a3IchO09O
 beAtK4oR5VriumH6opnJH8PGgzbnJ16R58WBSUbyrNqstJwWfKH6zq+2GNfQEaICtvRTaXua+Wi
 kqfo7CBMwYmM7MlOzA5+euuwJLauowg+7evYQ5QZAzWuIccDwZOzMlw0+FZVsI10opCiFHGw==
X-Received: by 2002:a05:6102:605b:b0:5db:fe0d:7fd5 with SMTP id
 ada2fe7eead31-605a4d76e3dmr2210872137.10.1775333089480; 
 Sat, 04 Apr 2026 13:04:49 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:fafb:5a7b:510a:6309:f015])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-605b214b45fsm5120113137.5.2026.04.04.13.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 13:04:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: display: rockchip: dw-hdmi: Allow resets for
 Rockchip HDMI
Date: Sat,  4 Apr 2026 17:04:34 -0300
Message-ID: <20260404200434.1954651-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The Rockchip DW HDMI binding sets unevaluatedProperties: false while
also inheriting from synopsys,dw-hdmi.yaml via allOf.

The Synopsys binding defines the optional properties resets and
reset-names, but due to dt-schema rules these are not considered
allowed once unevaluatedProperties: false is set in the Rockchip
schema unless they are re-declared locally.

This went unnoticed because most Rockchip SoCs do not wire a reset line
to the HDMI controller in their DTS. The rk3228, however, does use a
reset, which causes dtbs_check to emit:

Unevaluated properties are not allowed ('resets', 'reset-names')

Re-declare these properties in the Rockchip schema so they are accepted
when present, matching the capabilities of the underlying Synopsys IP
and fixing the dtbs_check warning for rk3228.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 29716764413a..59fb084bb4fb 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -113,6 +113,12 @@ properties:
       - port@0
       - port@1
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: hdmi
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.43.0

