Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEA8C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB1510E25F;
	Mon, 21 Sep 2026 10:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKAJTj0g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD22110E142
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:46:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E6D29601F1;
 Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D66EC2BCF6;
 Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789987585;
 bh=VzG9WGvgbCSaoayzd2ht++Y85jlKLhif3VYGTpEVkAM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OKAJTj0gsMArSCKuEkyPR5bwygqGrSR0Za+XqKxc0jUpjdk23viwlw8+9PNAhat8J
 GpnA6NBC7QaPJMqiI3luFdzpPQEDJGVQwi8YWTO9TSmVABAau65/wthw0DYxIDmGow
 L4r7iH/1zsQvGdLtB1BZBFcvGT7eUPBg7crsO+1d3fBYOKEfyu0S+CO7a4hIDRJxXh
 N1g9uKoOStWdyJNiSPp18+7DWxOyvmG3JZHMjP0Vhab2z6oxifKCXPLmCCbnWeQJ6Y
 uSV5upNz0v+c9je0wS6XPDjPEQciLkZ3AwItXvJUFjPFpjg3kg1LLumtsQDuO9sxzl
 fiynr6catAcJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6D545C982ED;
 Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 21 Sep 2026 12:46:23 +0200
Subject: [PATCH v4 2/4] backlight: qcom-wled: Fix WLED3 brightness register
 stride
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7dg4sNfoJUcVQTg/pZrE7IUtjXq8Oym1qNiml++xiMI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqsQr/sPC+A2M95fdj4NxWG/mcIHavg1o987p1L
 ijk5700k3GJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarEK/wAKCRBgAj/E00kg
 coGhEADMtxTn4ww2WMUJwvEDnnzgSyczCpqyJrexzt3wfJ4e37ctZNxb2pOiekO2LXiWSozjtwM
 Skk0DtVcB8jWMkIp0vtBnWxsjdApCsjudOgv65lXTY20YVP+4f3yvnbJZEBJaHy3HCimLSA3YO7
 r07cgUnIsk4f8TWT2UO40uLxcMZjIEVaGakFHOwKHNeyd978d+x7mC4NAJvLFGILR3jRV73lX5D
 QshqkGFGd6xVd+/L4KWq9TKzJKK3NoOsxDAnDMDRVrfvOcMOS/13VrMkIVX0OgN8gUrkn1/81xa
 DOo3/sGebkYyoIYHUGEESJjOdN0cVkSk+jU3iBI6SqFksdCJdxnvRz2k4SS3PheAMqq+4c3dEBT
 b7G17F9scwl9W0tjKq7Sfsi2aXa2WodI8TfDExIYAzI9hZkKSFSWmOdN9U2gtu2pvEQJHoF7adf
 l6aWlOj7RFyVXbGDDOWWlZI5noqP2SO1mQk1Y0oV15bm0WJR7g0Ny6US01b00mPtS23pX+vbXpq
 RsiBQUGr/YCy7LXeBMy8v8DLLwWwU5WzvThn28TSYgfyPLPrTvzUpWMfpwQy1SVQfSujBtYAHLy
 Cp6T+3LBN9vMio/Ydu0HWPLnLV5E6URxcL4GqWOXlalslWw4Ys6jNYmkRXwr0Z/j47/g640reF3
 HiyH8n2VkdXPI3Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
which is what the pm8941-wled driver wrote to:

	rc = regmap_bulk_write(wled->regmap,
			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
			v, 2);

The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
defined as 0x40 + n, so the two byte writes for consecutive strings
overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
with the default three strings only string 1 ends up with the requested
value.

Use the 2 byte stride.

Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 2281007bdd459..f452d328997ad 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -54,17 +54,17 @@
 #define WLED3_SINK_REG_SYNC				0x47
 #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
 
 #define WLED3_SINK_REG_CURR_SINK			0x4f
 #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
 #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
 
 /* WLED3 specific per-'string' registers below */
-#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
+#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x2))
 
 #define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
 
 #define WLED3_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x62 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(4, 0)
 
 #define WLED3_SINK_REG_STR_MOD_SRC(n)			(0x63 + (n * 0x10))

-- 
2.55.0


