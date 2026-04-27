Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67EEFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E1D10E2BB;
	Mon, 27 Apr 2026 14:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="VncJzTTB";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="xQhv2aGe";
	dkim-atps=neutral
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB6D10E2AF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298199; bh=PlVdMq6qW4rUTUiG8piYkHmgJ1TDbkyhmaNDkhl7m00=;
 h=From:Subject:Date:To:Cc:From;
 b=VncJzTTB0oUwh8yfwutxrcJZvA9YSlvCQSi5+xU/pTUKKkSHclyw/urhTWdbKj9gW
 31ciw5rxNswCYPvsBPT0EAuhjaGkAXTSfv/tIQFRqteICZXRWTG0WkHF52R4pGxdVb
 s5pcgCn51UjVdfbCpi+gxfxKpA4s1cEhkFY/V74P9uLXOZw1mg3Hoaa5fiAUb/8ePU
 q0fa18o1LlurwMM+ZvNOCcC68mFomIPfCVcMN61JWoMrzOvlPGiqr9U7iZxRsIYCQN
 CzoSZzOYBkUzTHvvgJdc4HCQ8pUQAmg/ZEUgdk3I1s2sIeZ0Vq0kSTC5j/kU7wc9sF
 7F30WIVysOBaw==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id B02B0FB05;
 Mon, 27 Apr 2026 15:56:39 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDsV6zT7T1wQ; Mon, 27 Apr 2026 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298195; bh=PlVdMq6qW4rUTUiG8piYkHmgJ1TDbkyhmaNDkhl7m00=;
 h=From:Subject:Date:To:Cc:From;
 b=xQhv2aGeR5FalT7NQhvOWBZBgouv9CacGbRkZkBM0a5bM6PpswGDHnq7pIT1XU/Vh
 3mfEvXPl4zx5osquUnjCytkgUFmX/S0Ujnj9HjiKcEhIXTUhKV52udvcgqF8ySvTTK
 5uR2PZd/eWg4aUb4ubigSQEg05FuiLxzw4IRk7hXMOSj5jMz7C/8dDhwti/1kjWVn5
 QXdM/JDumOhuzcWJOBj63Ldb5KZQj1nQkAUsKoM2CRkjmFFWIg1+n//4CCJYYEjDJH
 UTJ4A9look4B2VBYwjkblSM8HzurXK0C/i7raJWVr011hC7xp9a5Dq72JaLUzqTAFV
 XHSTCkI3oqLkg==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH 0/2] drm/panel/visionox-rm69299: Split DSI commands out
 into enable/disable
Date: Mon, 27 Apr 2026 15:56:05 +0200
Message-Id: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPVq72kC/yWMWwqAIBAArxL73YJZrNhVoo8eay2UhUIE4d2T+
 hyYmQciB+EIbfFA4EuiHD5DVRYwrYNfGGXODFppUo02+CvHjWEnq61F9sO4MSpy9WxqckQN5Po
 M7OT+zl2f0gu5tPyoaQAAAA==
X-Change-ID: 20260427-visionox-rm69299-enable-06f3d736f664
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=PlVdMq6qW4rUTUiG8piYkHmgJ1TDbkyhmaNDkhl7m00=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQnA3MnNQZkQ0QTBKRG9vZjFpT3ZlV3drZnQrUlA4CldGMm0xakdzMlRnenp4amZ3
 c0dKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYWU5ckR3QUt
 DUkFsdjRaU1N2ekI0eVpURC93STVDY2VoUlM1QjhIbk1ibjFZWVp5NGhjTmhicVpwZXNYMkh0Sw
 psT0d2WkNFMXFQWnN3WENOcGpaeUhSQ1p4RGsyc3I3TDlYSWxWRUd5ZDQ3VGNYQVpnQVBhTGgrd
 jUxMXI1WG44Cll2ZC9qUlVlYjdpckpIWk5qS0FaWUVISjFDblFJN2VyN3FkQXdrUmlzWTRSTHR5
 RjJmSXdGVmtBbElPRFVkRTcKaE5KMWJEbDN1S3lWQnR1bDE1bW5PQkorZTNuQTVsVGRqY2ZCUVl
 1UjZsTzhnNVJuYVhMeFlFSXZxV3NyMFNDaQp6cFJmZmRmTkU5Q0Q4R0lGVHFUUkkwdjlrRFlMN0
 RndzZ5bjR4SWJ3dnlPVEozcjZmMDRaNWtiSDVWQmptc1ZHClFUcThtaWpjM2RCcEV4aDRuV3h5R
 0l6Z2xtZEVHdEJXckIvOHZZMlBFUXJINXVIeUlpNmd1d3d6Z1dwSlUwSU4KME41TmR5Qm11RjZU
 c1FtYnpDOFF2aTU1ejFuQkVLb0E2SlcrRkJ0M09ZUHBiRGIrZGZWUEt2OW02eGhkRGRVMgppazJ
 hL014QW1mRHdmVjZJNzRSd1VrYWxqSDZKQ3dwb3lTcXY2SjRCQ2d5VC93ai9RNVM0OGhkc1VvRj
 ZrRlo1CllXWEpqNUNQMGc5YklSaXlqdURONCs5TFJxNlhpdnhiSmY1WjJ1NnVjZUx4SE5mY0hrQ
 kRWYU80SjlLTVZUTVkKS3AvSFh3UDhvK0paM3IvYUQraFBCYWw2TE5JMHBkZWhSaDgrNkdsMGk3
 SjRaZ1BseTJPZTQ0aXh4TktjaVcxVwpzOXQ0VkFXNDZycDdvdWE4c084YUJNbXI0Z3g2NlZ6R0h
 tV3lOUEFiV0xMNjFhUUpTY3BWT3RBVmVTblY4ZzJCCkZPOVJldz09Cj14R1A4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3
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

The DSI commands should be sent in enable/disable, fix that which also
fixes various DSI commands failing on screen blank/unblank like:

  msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
  dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
  panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

Even with this applied I'm seeing some

   disp_cc_mdss_pclk0_clk status stuck at 'on'
   disp_cc_mdss_byte0_intf_clk status stuck at 'on'
   disp_cc_mdss_byte0_clk status stuck at 'on'

on SHIFT6mq once during boot but all DSI timeouts are gone.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Guido Günther (2):
      drm/panel: visionox-rm69299: Split DSI commands out into enable/disable
      drm/panel: visionox-rm69299: Move power_on/off into prepare/unprepare

 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 113 ++++++++++++-------------
 1 file changed, 56 insertions(+), 57 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-visionox-rm69299-enable-06f3d736f664

Best regards,
-- 
Guido Günther <agx@sigxcpu.org>

