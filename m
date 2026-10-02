Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5152CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911D310E5D6;
	Fri,  2 Oct 2026 14:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="xN0d9leM";
	dkim-atps=neutral
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com
 [74.125.228.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BB110E5CD
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:21:55 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id
 a640c23a62f3a-c2e0f2c945eso449814866b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790950913; x=1791555713; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trob71jrLJmnCTpqAQkVdV8k9io4Vh7M+IWZZGLBcWY=;
 b=xN0d9leMHpGl/Nw6ULVyqd9Og2Rt5HGjNWDnTYJ4Dm6kENGJJZUTcfCyHnsefbwfiB
 YjUSwbyJURMueqBpr4iYPc62dagFkVEsqmr6CBr5iK0YVqvI0ikkjF8iwOde0Dg2SPz/
 seencbsHkrFiqWg6ON/4FqUcnW9lwIy+Qjtxmlh8Z5ZSV9XsgxlUQN5UCgLviReHzNTw
 zD7SP7uGvaNmBIOdnsBb7ufGVS3D2jYkSK/0CEbmG+jiL+p/5QPJsi6PwhbrIPFHHY4t
 iQa4ZTlSAy0ZV6cSADWVz1ASv80MLOWJ4XnsZPhcw24pgKvM2CbZyTZ7HkGH9QGUGdsE
 8XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790950913; x=1791555713;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=trob71jrLJmnCTpqAQkVdV8k9io4Vh7M+IWZZGLBcWY=;
 b=m4fyKVEy4aKmIE+5uunsMyS2h8vdf4dvL87Ynv+KyxuZYMLwZmEzwaoTEZAyKwC0yH
 RitCNy8483T2jN5Abl9+XvnfUoSbnuLnydkpGlTQYYmvFNTuQd67j97HmgNmN5Ck1E/j
 iMIuLXv30n7cgOHAToaQbmwOw5X1uxUGc2UASl3o3THZxH1bAfMVf89xOPSbOFCoDOUj
 +JtUWqaiPL4OzVPgqFKwT0LkuJieiJQZNlnb/wosGE4UyhfL15zbK5WTBAnsF5cXUHuu
 FnQ8YTJbfrPT2jkryqpfkNhsCldLTnPBVg8iCF/mEzrmrgDNmoOvbz47qMDHUL+Y7pvB
 ZUeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztxfKTWuvyN27y31M481h4tT1QXe0l2NHycMAiLp4Vv9HmFGzTU5bo0G8ksq+6iTyq1U3WOx5zer8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m04Bj7luR8zvyjJlolmgBEvkc+Tpoqs2Y/qHGK5w0NBffskNrE
 EIBQvrttAQL+rH0uRgcq+TQzKtmFeDVNIpS7OADNFuLY/8yKSwmjteVncVlC/bM+lbM=
X-Gm-Gg: AYBFou0HVA+ei/t/n85WCaipndrcbNtJxmad+SIFKv5iyWtyIA3bwxGTWPAGOXikWXG
 a8Cu6hTYKzhjo6aQXV6glKnndi4ChmeawR2QrZkBITLstANxt12lET2YAErpVs/0Y2QoUAhNKJE
 8gPlI8pYEIkHcH1NtBd6zmQSxlslPFxjomN23TVQECznQkM+a2+WJzpjH7bd63w9JFSfgzbv2wL
 XNLrBhSG0hux9JwJ/srNvDqf2+Uq4nWqRwoRPn88OYjeTf8eQrmUnFGh9BMpAuMl4U2NkaUdH/n
 2nmVY0iLANc3Z+1SNsJC1/TdTiHRs9dl3FOW1/xBOhDjP7XPXJF6NKiCM1PaN2EnbuufguaZLk4
 iUSI4Frtu+jYslqN6/VSz9PK+PkLRSY1aVtf4Tp5E2VrPHLmsCjNIA8jVi7za6juEb/2P44UD8C
 aiYuFH/rkbUp1N9HUiB8bRNFUx2ZXSy4O59uCuOMEXHQuFRtKBVW3vptdVSq7PWcoDJYJTQg0Mr
 rjLF+d0B0BdNMgmNaeTgZ9WJRWGFcHG/YyK8P0v2XNiJ9vzwIhD
X-Received: by 2002:a17:907:c486:b0:c29:462b:f908 with SMTP id
 a640c23a62f3a-c2e4afa70cemr214706366b.10.1790950913549; 
 Fri, 02 Oct 2026 07:21:53 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cf684e3sm89307166b.51.2026.10.02.07.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:21:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 02 Oct 2026 16:21:47 +0200
Subject: [PATCH v3 3/4] arm64: defconfig: Enable Novatek NT37705 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-fp6-panel-v3-3-4b80f83bc936@fairphone.com>
References: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
In-Reply-To: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
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
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790950908; l=791;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Ow1g5nb84JaBXwtId7U1Ei7JzeZxrlP38LbY2puBam8=;
 b=vnNsKzfbkcaR8E0y2/h+wIatu+JyKUI5twpCAlB8F/NPQKE/TnVb4EiB5ijJkaLsyDesPU73e
 g1IiPWSVy6KDdSr2cBXQC2rSEdzpAJQHV+IejXByTjAlp4igx2Zxo2g
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6ec8d3a69c98..1d4afc733c8a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1023,6 +1023,7 @@ CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
+CONFIG_DRM_PANEL_NOVATEK_NT37705=m
 CONFIG_DRM_PANEL_NOVATEK_NT37801=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m

-- 
2.56.0

