Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A7CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C6510F09D;
	Wed, 20 May 2026 14:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M2uJ7Ytb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F9F10F09B
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJ50i4VAT7koucsYp09rCZ4i+eT1/vUOKhdV9aKMINU=;
 b=M2uJ7YtbhFlpIOgFnhSjh+I2pvqSK62nUVw8wkvMBmYKJ6Yp9g0/EReeR/UP1L9JoClDvY
 uvuf7mGH6IE4f/MIT1WGMhuzEoiyiuhgckGz7sjWr9/fnu3nKXRQO+BEklOje9GJ4BkSnb
 ux+qpUVEWIyNDdB7xhvPPrF6XQvPHxo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-BCaZbhOLOd-bL6ZemSXiJw-1; Wed, 20 May 2026 10:44:42 -0400
X-MC-Unique: BCaZbhOLOd-bL6ZemSXiJw-1
X-Mimecast-MFC-AGG-ID: BCaZbhOLOd-bL6ZemSXiJw_1779288281
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fda34ed0aso19705745e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288281; x=1779893081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJ50i4VAT7koucsYp09rCZ4i+eT1/vUOKhdV9aKMINU=;
 b=dNdi+p3jOFUxN17UaLwgfZvSDUgRtoHQ1FtkO/eqOwqarYZwPFJ0wi6MsrozZeMGSt
 64K2Fm8XycSc9JRbjgh6lzNtxsmIAd6X9KruYYdjxjjLpQhFhzjBabq1I2Tj61Y92Wkt
 0eeLdwrE7X40N/CUWTRMJA1NjQViQh3jkBcDeSIsM4IRewPgFnZ/JRxFld6CWDaD6IKx
 yFHRCwVzDBzhACrM1HulWj+IWFJ98s/L++oK10ngpVkhJXWDp9oIiUboW30rz/uqHJ9q
 Sjw5fPa7CuUtLQVbS3546zYV6+nFCnAKEdF0ZrJnUzP8QbAX29n+MUlPWVUbRKigvhce
 UFog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IQpk17JZD/snAqN1A3lfAai7UoH7fvFSks+tIWzVFBxJSeu+/Euh7R0WSAC0YmclkVs/CpTTx9go=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQe2tm/BEiPUziTOg69E53UMDW/TNrtOgpnBwML9BUmseTIA25
 rGLwHUsMGA70WpCnNGvlEf1FnbGWkV3HRJZnCF+KMVGjPCs0pL2Ujqui/3nh6KCUKne+HkjDbh+
 BeZopLEl2+mM+r0b9kmGMx8THwS4ZvxTGrCa8c8ojLmKji58EZdrXxlPaqiiMATK6K70u5Q==
X-Gm-Gg: Acq92OFIvKEvor7N+/DSHaN2PMu5FhBpK1WK2w3K0fsojU9frn4ngzTocwF12iW6ET6
 cCOUJ6ZG1nwdxRfaMeG2rfzZBkWEh9vWnqkNtGvd1tRstO0mVR64uMPWKON5hb/8+efimDnpxZb
 mEjhyWk4umRpLEc1iTua530bOdpjbszXAPejvw3j4mU17rmxMfkOY/NGyzbUB971gJ7bHDZZyqn
 NBGJyzD43FI76Po7Slmjc1N6jFN1uA+kTZ6H7h4vbtpCmQovHtWrVbkcdB3TUznsW6YP2BIHe61
 qF2oLWCo0LXmN+0UIvYeIBRf1HP3QWOttuhqdWEQZj9xuujOa25fLsz95sl8ZZUJOnweJC/N+Jo
 mVGNRGw5trYZg8x2gmGdmPmTU4XCQ02q21vyVCBwx1k5zVsk=
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr290658995e9.8.1779288281007; 
 Wed, 20 May 2026 07:44:41 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr290658585e9.8.1779288280584; 
 Wed, 20 May 2026 07:44:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm439641105e9.7.2026.05.20.07.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alain Volmat <alain.volmat@foss.st.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/8] drm/sti: hdmi: Use the common TMDS char rate constants
Date: Wed, 20 May 2026 16:43:41 +0200
Message-ID: <20260520144424.1633354-6-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Tlw780VyDihU7f5qV_F3Esv1VB8gFDNH4G0n3DffQw_1779288281
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace the 340000000 and 165000000 magic numbers with the shared
constants defined in the <linux/hdmi.h> header.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
index d25ecd4f4b67..4fe0c54a096f 100644
--- a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
+++ b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
@@ -4,6 +4,8 @@
  * Author: Vincent Abriou <vincent.abriou@st.com> for STMicroelectronics.
  */
 
+#include <linux/hdmi.h>
+
 #include <drm/drm_print.h>
 
 #include "sti_hdmi_tx3g4c28phy.h"
@@ -102,7 +104,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 	tmdsck = ckpxpll;
 	pllctrl |= 40 << PLL_CFG_NDIV_SHIFT;
 
-	if (tmdsck > 340000000) {
+	if (tmdsck > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {
 		DRM_ERROR("output TMDS clock (%d) out of range\n", tmdsck);
 		goto err;
 	}
@@ -135,7 +137,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 	       HDMI_SRZ_CFG_EN_BIASRES_DETECTION |
 	       HDMI_SRZ_CFG_EN_SINK_TERM_DETECTION);
 
-	if (tmdsck > 165000000)
+	if (tmdsck > HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ)
 		val |= HDMI_SRZ_CFG_EN_SRC_TERMINATION;
 
 	/*
-- 
2.54.0

