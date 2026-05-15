Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277CCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0377E10E034;
	Fri, 15 May 2026 08:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DqzQ6kXN";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF66010E034
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:22:44 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bd2d8bb1068so685621866b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778833363; x=1779438163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Y029AYLsU3gQyx7qK3mdElsxQO0fMSNbqm4SAjcN30=;
 b=DqzQ6kXNmNvsmQH6e1Tswq1VahSqkPlcwsASEJpp3eSYYsRK3OVvZhLY/QFTzGQpZS
 aUBRcHBhNReUHsaX843OCHU6E7YLST/nMx/BwQLk80dov+rNBBtVFIIRO1bxwSujxUjc
 P8G3UhOZ49RfqQMGiv+GaJs6sf26fea2JMlBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778833363; x=1779438163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y029AYLsU3gQyx7qK3mdElsxQO0fMSNbqm4SAjcN30=;
 b=lQkZyNZ2q4VDdtdfHxMBaFlUBjQvVR5q8G38bu2RDDatYW9OQeYVMzPi8C1jj+a5Q0
 rU+gIBNTQ2W98ftsNpBr33mq47C1zVw0KZGxXbcA7iAMSBDVmjrj8n0ME8+E2qNwyRNW
 p1TPFXsxTR6mbMkUdpQUee4nqAb9SWYz/aLtJZHbOtnufNDP8N8v8V3LjAsChWprsXtI
 v2kcheF6ECDnY6bLI5qY2voYRX9srRh8HAFj8EId694wPtGe9ao4YMT31iSGcBiy8Byu
 ujFCNaZaz+0za+ryKsYibtfIWD9v7ERoMy81ETXvCFDbOmHf5bWDehiBKrVt6/WN157Y
 CUDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jP/XtwAg0pKMWWE5K/scDz5/A3bw5LtNgTc6Iblcp+7XtgP1zdybf0PNs0GBKsWPly9gkojl0WpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMJurLOTcfWXFHodpCPFjDQDxWvY5hAvtdsHZ07h7yEETZ+5Fe
 zsb+YcZBeH2HTCZh8CagWd+Oh4uTteVF1b1cjxunZZIWyDApNi97TC2qj1glrnhr35M=
X-Gm-Gg: Acq92OH8ZOby3Nv0INscC+HFPoqdCt+NNcgeHqOFKo28NRpnw+tG/jlUGnrRk0gXCsz
 f3u5fo3C0F2R+86LH0ETB/RpbkzML0mMj9IYudllistVn+ZXLBtjkBPi89lbko5gcQ/LnB1IGxM
 pZyfn+vilfD4UvNnFPi7Yw0JrjXEEsVo1ZMgDId5tjix4VxWOO8/TeGAaF3MN2w0IBfh7wPL8PF
 ddgdrRXqqHOfKGQU106ESADOcoq10xPHke7TjorQYmTQugyssME5w5FfGL7T+bJ0ZCDisatAKNI
 kLey4Oo4Ac6yCVZR+hXTdV7Mr0jpLuOavQA+g7HTbqstRSWIzi/EU+HFaWIS8a8tFykGhpG5xWb
 6lqf8RRKB8xQuJlCR1eQuAij5MPbHDhn0rt/zrxf1UpWyMxa2LgTLvfmn4uJ0yTulrVqhWzlm7L
 RZUS3mlZZSmk2CuwPPE98mZlmFxOwy60dA+RsLAb945GIykDO7Ma5K4s3iz1NnUozDXwGUmeYlC
 +jBQsLEtYfwgt7z2FdW0PtBOTmIQVvUsLAnnVO5FmkGOve1rdzUtYb5Zz0=
X-Received: by 2002:a17:907:c291:b0:bd4:f594:8a59 with SMTP id
 a640c23a62f3a-bd51792d179mr143825566b.38.1778833363275; 
 Fri, 15 May 2026 01:22:43 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.42.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e4d54dsm189529966b.47.2026.05.15.01.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 01:22:42 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add AM-1280800W8TZQW-T00H
Date: Fri, 15 May 2026 10:22:00 +0200
Message-ID: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
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

Add dt-bindings for 10.1" TFT LCD module from Ampire Co. Ltd.
as part of panel-simple.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Insert the new compatible string in alphabetical order in
  Documentation/devicetree/bindings/display/panel/panel-simple.yaml
- Replace WQVGA with WXGA.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3e41ed0ef5d5..617cf9d64627 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -31,6 +31,8 @@ properties:
 
         # Ampire AM-1280800N3TZQW-T00H 10.1" WQVGA TFT LCD panel
       - ampire,am-1280800n3tzqw-t00h
+        # Ampire AM-1280800W8TZQW-T00H 10.1" WXGA TFT LCD panel
+      - ampire,am-1280800w8tzqw-t00h
         # Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480L1TMQW-T00H 5" WVGA TFT LCD panel
-- 
2.43.0

base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
branch: am-1280800N3tzqw-to00h
