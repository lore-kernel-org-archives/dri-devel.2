Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B058CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC89310F3FE;
	Fri, 15 May 2026 06:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EvWkYBsi";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038B310F3FE
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:47:28 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo1731309a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778827647; x=1779432447;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4GSV1VMYT9oCWN+WztoVciJCG7ntocFd2tnKjl2yZp0=;
 b=EvWkYBsi591L8rKjzWiMngNpud9EZ96qr62LaMzTXKEP7gMSbAJDpVT7rgpfwjenUC
 8yBYvIFKTHrcp8WkTEGBDROHW2bFgx6ONh73YbeQiLABI5J6usv4TXIZpGyciUPYluy1
 3s9BwvM7mr5Da3mQClpTtqCy+A7ACjGSqrFqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778827647; x=1779432447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GSV1VMYT9oCWN+WztoVciJCG7ntocFd2tnKjl2yZp0=;
 b=Sycgr7+hoLRP8Vw2j4dgJ0UFFV0roIy3gyTGPhrGPdTRi7ONIVl+tAhHjaeJ4eY7xn
 Qz3CN1LAJ0OXmKLFa3UTwZr7zPHKeiPNtNWqImhw307linL5bpKVs3vGqfABYZhpLTjf
 XaKZ080SB/j/qNnj8zCYwgbbPtyzVyWsDWkwX6tuHOvCdV1SLqJdqhwaNEE2wzE06HVf
 LDLOMIM29FeS5+Nrw8AdErM3x2g1M6FnW8X4n8Ifz6A0TgWW8+B7mGYPLErd9zhwTD/w
 wFtubvGenoPtT41jj23Qg13SRXArB/y/QObEO4qilGtLVGo9E92jfPuyz/ox/YchJApi
 sHmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hbfvTQKwlFkqhROlttnAh7bKyKfDfZEG2LZ4W3Ns3IAuGl+EkLQLovPGS57CJufyzooMFgnvheCk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhPKiw3Ed6VV1BK8rF8NEm3Kat1mWcpfR9AIoonjTpCG8bxI8T
 v6Apb+dMoOu7uWnvzWR59P+ggmCXLHAjBVTRf631cJzFFE4gAHtcUYPxNZJEq4cyOZ4=
X-Gm-Gg: Acq92OGQPvhs8ANCrsj+Cxl00tO0HLcE/pGxyeCybvyB0ql8gqQfqo6EEUc/l65TKet
 bM0ASo0Lh4OvbmjHsOp0CCf1Bg/OYzokJbLR/GBWadgNvvkK0Lq8t7OjZE/iEz1ElvSlkCs1RZo
 ealGwKXtkOX6po/gG7JqPVuetFddmQUj7q8QaCd3lBouEwNHkpO9WpB+6S31HiixKoYXNnpdgXN
 yjy1QEb6UxFdTEEJPpY/CqH87vLMx8avxRM8k/rDL8qB+2abFDob/LK+copKqk7SK0JxMkHph8q
 lUfTnJekSs7tGjmyOs6iQJJCVtgDWpgTwg+u2PDAZ8HfCB+NLp4igD0EiUPv0MmVxElV7K1bbHs
 XJB3d63Uc/oAYjEArxR5LVAX4ON7l01D29zTzqc5TsmpOuK8oN5pir8o64PPQz6ncwLcUnMBNbM
 porIQAGq1qOv4OV2MDPa++LeHcRfzjYbBtesZnSjZfJ04Fx010jUPEUfqZnkWpsfh2RaNDfYT6T
 6LIr5LTa7y7Ba3HikXocLqphMAM7Uc8H5E3zG9GG9YbZM0W
X-Received: by 2002:a05:6402:424c:20b0:680:ccda:55b9 with SMTP id
 4fb4d7f45d1cf-683bce9d17amr868593a12.16.1778827647337; 
 Thu, 14 May 2026 23:47:27 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.42.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68310d510fasm1607798a12.11.2026.05.14.23.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 23:47:25 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: display: simple: Add AM-1280800W8TZQW-T00H
Date: Fri, 15 May 2026 08:47:13 +0200
Message-ID: <20260515064721.1750990-1-dario.binacchi@amarulasolutions.com>
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

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3e41ed0ef5d5..ea5fe23a6fe8 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -29,6 +29,8 @@ properties:
     # compatible must be listed in alphabetical order, ordered by compatible.
     # The description in the comment is mandatory for each compatible.
 
+        # Ampire AM-1280800W8TZQW-T00H 10.1" WQVGA TFT LCD panel
+      - ampire,am-1280800w8tzqw-t00h
         # Ampire AM-1280800N3TZQW-T00H 10.1" WQVGA TFT LCD panel
       - ampire,am-1280800n3tzqw-t00h
         # Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
-- 
2.43.0

base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
branch: am-1280800N3tzqw-to00h
