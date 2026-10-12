Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F29CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E8210E2E7;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B4610E44B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:43:40 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so12593275e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791787418; x=1792392218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FqWEUpOcbkCEI5wu3LVItbSlVvKJOnpu9ESLF/pgJIg=;
 b=W8nS436BeHb/eiVwslsVgzbcAT8RN3iAekByEmUWRzWrsAqC35K5VFIVCzYuKRG/tY
 FHlxpYOVvd5/FjAoLXllOmonKcoaWI5P+sRNrl8EcUi0IPJR2QnAzhnEOWbqRh3Jsm3t
 4xBipnew2LbGwIHVvfPtMnfQuch0JZnQsv02qsSO7TIFGxTKc6haz0M7YAsrg4Y4d/vf
 33LPe1MVDjucIPMrpW1nq8wIuBifaHyE6dux4No0BFJ68e5FGHZcXewS4EffRd4uWLtE
 gh2uo7HnQHte9xOdO7hLUtkcYCZIAXn/S+AS1v3Ley5n4oW3vUdqGAH1/dmdgaPhxGS9
 4CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791787418; x=1792392218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FqWEUpOcbkCEI5wu3LVItbSlVvKJOnpu9ESLF/pgJIg=;
 b=MYyphy6TJPNiDjLaMNOD+POVLNS60yuaZLjzzaAw3rJrdQu9W5PCl2wkVnE+S1K1nZ
 Wbl4VzOYRsYr8lZ5Jw0mUJ7IaSl3jX6cCPQy1kJciv0PE6IfFyHfwCLKjNaIbPw9bh/h
 pGI+kzXVHQ0WQCpDyvCiW4BtKokiUfknuzRo9WAJ3sNy6gJyzfH3IF6VrTefbj2BOaX/
 u4kJhsrQ38Yg28sUiRr7GvxQrAZYBJAWZSyvsY9XZqQ4pMlRBfjaeomZDCx97HIt166p
 apE26IeBroG5iUs7JJSRB+3IUoMhxnG6qoR/8jV3iXhSXn/KqvyjVa9BcrE5Kjj4tVK0
 q8GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvmf8PzhZjfMuVVOh45vxoPBkBAAKVXdch7IPWimKJ1QqSmNSbmKSABvCkN1Wiqn92ZLwVGABxZQc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjBrxKrRuzNrFGEJc1oqR5riTQOVCD5co50To2LkmFAHS/IMzH
 I1q/8OfkzNWiU+m7xKxksHQ1iCnas3bP83Pfyt6PFW2ysz9w+aXK4LIL
X-Gm-Gg: AYBFou1Kud29Dm+uPcNz14FfVzOpCs4JKDMg1ULZA80AQQieAVlmpJn+CZzSMED8BId
 A3jtgngLGFLv+IyqkK3upENgn+Q7Q+8ocoWZieWqQYY/dV4eaGPtyPI0DuaxFI1rvaiwgcsAXca
 m8Opu793AIJN/R7Gac2JG2EpXEx5lgvv3sYj54W/3+3sP8PpmCSMBF/HtzURPmSwHmX2ERSVlrJ
 Q8yfjgFWaiMO4gaj/LUTHUsWHogZn6lQmI7EWASBROgVKZos5MUfEfxKM2oOhdm1oVBtONwxCqr
 /4Ds0Ti1DdgLZWvtSpAtb5SVHjCpEZeXw/ONT6nKWqurdUt4n/GHbLnAGygS6Bl/rttVU/78wJF
 3PrslTd6Yg7jP6rSXDSviyRKBPNQAePf4nVtYtG/hiDFvyYBFpC+PM+fyvTbB2NFfPa++Bp18D8
 eKMvQfK3uNcPunIvxdyn5kQreq5sKDFDtPWnspdJC6dBJE6ymIA36ZC3BoL92bZjH+FWndKoeid
 xT7hF7g8kj0RibAnl9OGM0=
X-Received: by 2002:a05:600c:8218:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a18e49d9f5mr153991385e9.9.1791787418332; 
 Sun, 11 Oct 2026 23:43:38 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net
 ([2a06:c701:4778:c500:38e4:cb76:562:f06e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm499586165e9.9.2026.10.11.23.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 23:43:37 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] drm/exynos: hdmi: free EDID on connector update failure
Date: Mon, 12 Oct 2026 09:43:34 +0300
Message-ID: <20261012064334.3193085-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

If drm_edid_connector_update() fails, hdmi_get_modes() returns
without freeing the EDID allocated by drm_edid_read_ddc(). It's
an unlikely error path but nevertheless possible and should be
cleaned up fully.

Free the EDID before returning, while keeping the existing return
value of 0.

Fixes: f6e4f57fd90dc ("drm/exynos: hdmi: convert to struct drm_edid")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index d4fce39c2b61..386557a7f5e8 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -893,8 +893,10 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	drm_edid = drm_edid_read_ddc(connector, hdata->ddc_adpt);
 
 	ret = drm_edid_connector_update(connector, drm_edid);
-	if (ret)
+	if (ret) {
+		drm_edid_free(drm_edid);
 		return 0;
+	}
 
 	cec_notifier_set_phys_addr(hdata->notifier, info->source_physical_address);
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

