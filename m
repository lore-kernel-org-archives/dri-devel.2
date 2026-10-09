Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0A4CA6018
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A56112086;
	Fri,  9 Oct 2026 11:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ujbkLkSw";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78701112086
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:25:10 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b1701294d0so1505044a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791545109; x=1792149909; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trob71jrLJmnCTpqAQkVdV8k9io4Vh7M+IWZZGLBcWY=;
 b=ujbkLkSwspDGRnoVOqIM42Tio/TBFf2NVIvpSSRQb89+tUmcpsT0Z1rkdsGNUBeCwq
 n4LUgaqhwBAqGSo7drcstiyLqZ3HEVZnK1aLIgigGzUqDoYy8XFvknAM9RJ6r6S/A2+8
 rwnZ7LJjBZ1uGrsppHPqoKMC2+fEHje8miP+xQ0SOOrVqgmuDq1wUPflUDH+yF/lzm/t
 /+8TSDGIvOcpMXqLZ8ryfUOZEzHr1Ot9KclCvrsDSOWFcwIegXmrluGuhy3QmY/bVPsv
 acBNUb31yXD38UsJacm+cWo2YYX0zGyDue4QtT6Ijthx/kjGZo3Ja9jXi2WsL/spsTak
 X7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791545109; x=1792149909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=trob71jrLJmnCTpqAQkVdV8k9io4Vh7M+IWZZGLBcWY=;
 b=tgaSCMmovGkk7SQHfzxSTVjrC4RixMhZx3wRxIyZOhBNwN52DK0dOkoEYR9jq+P6zY
 Mjc6ov35lgrYyMA8+6SYKjz8M4OjF8lt01eI73Dt6kcY638Q+6xE9SyZ2ZvJzpMBdyO2
 KOauWWiogd3ytYQUciEqxjZIHNRpJ3wCR6HZ/MCk1DJR6xc1zp36ru5MZhrDAkur7qx2
 uPURN0W79h2ixdVmGanaZbOk9oWV0SBPrHzUaP6WIbpFJb7OqomWING1Qwd86hrNZyun
 KNHrNemYgOFd4iqgnkd3DWgwDTXDmYwC4tzdTg+8Gt7+MiZn2kQ+XIG9ryWxsO4paanz
 ldwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLO6xwIgv7tYqK+GDuySpkDIezheFd/p63aQ95FnbrkyNKAB3g9DZa+TVbqa0ClK1GpZUUu5H1RAI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIj/sUiGF7hoL3zlg1HkhAfoZ6Pxrwy+Dr8am7MyZiwpgmbQUdp
 /Z8aSIfOse1NR1QRMDxgrBT0DdWuQ8nkcyBbTMRCpn0/NbDA80P/qxLoQcrAU29tPwg=
X-Gm-Gg: AYBFou3j8Gulbbm8V1pSv4bXWuoKlfRaVmtStKSrECQXO4PTbUFphFkSGV7lGasmyE7
 9uZoynd3R2X16pKAa+nOQGQ19ogEtHygZcpR5TMX0nxlU4Y0uHQP7tyTNyJdLMvwCKFbqB9tpKG
 tiCVRZUMcxdMLnMXXScuxnoDYafpFAdDu1Gr7iOCaVqbTP8eRLToknEqu35nWrZoaKYMP9vLy0D
 PZ/dfNZpNxR5/yhqOfY0iagTYU8akiifcU1S1mFFUpzUKWkcmfu0e93rNoCsjFBBFUd50HkppO5
 U4APJhS+Nxl2VahjrIQlpj8p1PXnj/itSIuAN2feG7rBiRHBkXsWxMTciDCOe/hoafW/4v1fMSg
 1tKiy0LB66f7i7VqosBFx+Br5xhPY8j0tP+dM2NLmkeu/HM5ZF8JS9N/aCJIs4aFUvn3RLGV7gk
 CAvmuNnl0F977io5oiezQN9W5t/jitZcLM1NcfAPQTthzyLPc5kILfmzRGXRcnPoR2Eawkc1oL+
 e6XO1ceq6dK9icwLXerpdG2XUthOqN9Sqvg5OIe8Ts+2OafOQGf
X-Received: by 2002:a05:6402:274c:b0:6aa:e3f3:c9df with SMTP id
 4fb4d7f45d1cf-6b17c252c9amr1447419a12.20.1791545108898; 
 Fri, 09 Oct 2026 04:25:08 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dd3597sm985764a12.14.2026.10.09.04.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:25:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 09 Oct 2026 13:25:02 +0200
Subject: [PATCH v4 3/4] arm64: defconfig: Enable Novatek NT37705 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fp6-panel-v4-3-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
In-Reply-To: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791545105; l=791;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Ow1g5nb84JaBXwtId7U1Ei7JzeZxrlP38LbY2puBam8=;
 b=zcZTLYpESs6HkFuhiJJO4ex7iS3OKoMwbYeYOixjFkTwhHKF6/mXLg00Wm2n2nZuJbFx10Srw
 hzYG+p/eC5fClyEBuI4SYS1ZuYA1CMxxotWYaEVsc48KMcsuoKB/Vpe
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

