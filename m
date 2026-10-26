Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD3606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=SFo3EwWO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF5A10F326;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA1610F053
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:40:32 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso32633775e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793032831; x=1793637631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sAOWa8x25rACNbacVKQZnJMMCRBQGzMNA9iEryT5ck0=;
 b=SFo3EwWOH6HB3I5xw8cSCnYbESZAtQSpp0JhaevgaJHuCIjg9QFFvbOCnwD45wFoM8
 KGxrOvoKNpxXen6AhWrrL1aIx1s842vENJfUN3iHph8ac+ITRmNoJvRriPIfv1hf4vEN
 I8DFDGoKqAb842kAxPpx0z+daQjbuWuPH1COrJ1Jn07axrjKHIzRHuyp4x6JpnUb1dF9
 DZou0jtPSfsDoORheXy9iCrHNE/eiYV89DpHhTZ7B9RikHh3pqD4fl/E2eBiYG0vbRsM
 tDlC1TdVJImqPp00wZGkg2en8q1s95fWwGE/kMjo/zZLAGTG2Uh++ki3BCUZv2mr10mY
 7emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032831; x=1793637631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sAOWa8x25rACNbacVKQZnJMMCRBQGzMNA9iEryT5ck0=;
 b=fu3CXu+CrIrzeRMKrBaY+NpfoNGvqcAu8W3QNF9DvqLbKTiZX6HuRVj7wVxHhbIRtB
 9xCWIO0BuMXOa5JMfF4p9t5wjUB6SnANPDTSxSUiK5hAhZPY/euaKSCh2vIesnNNW1H5
 EOnPe0hHVqUbZkG3sic9QR9WDk8xzjubtrtcUmVf71A1AZ2Hr4A1e20PrgWWLphL+7oK
 t4TR80d9gZVosxWOV9B4atcdcN3GzWUHkmvfw7o2auUDE3A+qv0j+9V7nzmNo197CSo6
 HwD8CacEYThaY9S9MzOspYA+4ngr4k+tPdS/mVaGOLoCsOEozGyAmjD/FWcUIWFFAUhB
 faEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygTIxzs1BdgNKcpAhAT1FrVflKPHo+0OqLsH5VduhC21suMXUTDf4Ay9hUN6uEGFhPekO9zzdefE0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9nzWajZSIOd7poyStwjO1aUO2xh/JxYYAeNaincx/1oXyy6c3
 /YukY9SiwFHqehwal+/VdzOoc6lfucfrqmp7PVBvKVbECgwhzJhciZHUeHwVqVran5XWds/joQO
 EGBno4LMTqu4uaLA6V13D8fdUy5sYRwRa6SYQATpuyMYAdRilETQguUx57DmeWrKdSalUKRb+/L
 e1ZkuLS51bi4TEGZlRfJexEJiE3uaK3cVejMDHBkRRo4Oag9fzS/5nKRLUTuIWlmUSj7vSQx96z
 9S8IXKCSDwzq8BkHtpcxLeDGNA=
X-Gm-Gg: AYBFou3JzpWi3lhG/aU/lC/WK5YJ0/JZOQjm5c16jiOAfW33Q6JMDxVJhlXCaPpQA4E
 1793j/CgzVJBptT2mZTBY3DkZ40K5hFmEfURtVwhKJ3zQSaRGTaUsyjN1jE9jl2yFXfQy+UGyCT
 Guj7p0E4J3SDBCTQOehyRZKhcndy35S0N25bxnGBPBYQKuNWGG90eiTLAG9xMNMzKSlGjG1suPX
 xFkInw+33FQGJSgNdFnG3wjL/UxXUhHf6ASFwkLPPZ/9+7ROzPF20b1OrO+iPqucCwkWy++LA6d
 OJD3bBetKDiJReS+ALWxiQMObj2v6E9aFZnMz1O5VEw0px5bt1dDfo8G4NHhkBYi/O7cvM6gL/R
 CQph8SCCciTKFD4S4Ym7iFWL/1Jr2WKEqRt67CgXx5NCWYmZ+1DcR0SkPPK965XVsPTulR663MF
 av5mQtD6rMkMbtMC4DANU0eJd271/gOyV+d2L3FuPeY8hE3iLfpcyB+8wkO5PvoexdQgym4QhLe
 BPgwlXe/HhW4dDqDvzqOHgTrY6HVuY76o0TyUDn2sLWDCfc8lOvwCJelIkPdyt6MRjyiNJnLV2u
 z48tFSYefg==
X-Received: by 2002:a05:600c:3b11:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4a35acbd3b3mr141129035e9.15.1793032830719; 
 Mon, 26 Oct 2026 09:40:30 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:30 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the
 output is disabled
Date: Mon, 26 Oct 2026 16:40:26 +0000
Message-ID: <20261026164028.78792-2-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dom Cobley <popcornmix@gmail.com>

vc6_hdmi_phy_disable() is empty, so on BCM2712 the PHY keeps its PLL
and TMDS drivers running after the HDMI output is disabled, until the
next vc6_hdmi_phy_init(). The TMDS clock is therefore not stopped
between two mode sets, which the SCDC clock ratio change requires, and
the idle PHY wastes power.

Reset and power down the PHY on disable, as the BCM2711 variant does.

Fixes: 0b1dbe82e051 ("drm/vc4: hdmi: Add support for BCM2712 HDMI controllers")
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
[lucas.tanure: Rewrote commit message to clarify the issue and fix]
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
---
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
index 56e6a35da357..5040f014bf7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
@@ -1197,4 +1197,9 @@ void vc6_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
 
 void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	vc6_hdmi_reset_phy(vc4_hdmi);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 }
-- 
2.56.0

