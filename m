Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5D4CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433F810F0A4;
	Wed, 20 May 2026 14:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aEgSc/+O";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624A810F0A0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1tSo1G68Ra9imzMIPMx7cCxGvcqmHD7eyQZ4RzsS9c=;
 b=aEgSc/+O5fptW48VZNe/MelZqoTZrG4UtC2SuuNEB6Ii6CU+rentjjFcW4uWgdGnS16mFn
 jeOrcaOaHh4OhM+7iJYd9U26HM84QVqUzSIZRCB3wohfyqViLvlTyWMz8x5wbgCBhJsDVz
 pI7RAIOWcLB/LO0kyEh4E+v5/jrQMDc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-pnaqIOTWNJe7NqQNTfHAsg-1; Wed, 20 May 2026 10:44:45 -0400
X-MC-Unique: pnaqIOTWNJe7NqQNTfHAsg-1
X-Mimecast-MFC-AGG-ID: pnaqIOTWNJe7NqQNTfHAsg_1779288284
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so4170920f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288284; x=1779893084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1tSo1G68Ra9imzMIPMx7cCxGvcqmHD7eyQZ4RzsS9c=;
 b=eRtaMY2po1KNXRNZB7r7a6oJG66hQdrkeaEuPPHW5WP9K1cgxI31Rh926bF+B6UU5b
 1U/TOoflVuXuAQ3Gh+L2Q+oWDSRI53qu7G6Reu+VDeK+68SK7r69q57nDlVwXfwXMV9K
 5oWVuaCv1rfFR3gbC9ls0TGMngXDAe6Hz+Ia2jdYzyXrQ0g+saTQXcZX+0QDPB7Ytm3W
 JQuO3Vf/F76NZZ6rmpxDbHST0SZkfPbIsZhDKbEtWbt166NCPiuBJCB8FdDVdVy3UY2k
 NTudKDH1YqgZnChOMMj9j/8iYfdf/DXjtVSgjPP/FQByzbueyfzCIsunXas3XqgGDBlN
 m3dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bS4A6HoiqGTSDeOexhdAxz8NkE7h+OL86Hv+tJcDYBFPGJkyqgXRLVf4vgYCii66Kn9I5ZCJqzfk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZZJJkAIWWVzma1SkcOVsK+UxdkZZho4IUpsgL2YE4O1PCiEcy
 plWveS4VbG4GCa6W0F02gnoY1E/I3gzgJqB1J7ZtrYyZVspndDULfwUqfh78vuZIEzn0YfXiH4r
 ppEu+mhe66lfaxaDYtkDPsHjaHgJ/cUWsIxcyDZujAZYw0jHw7M0/5bjoNu58ClEhjk2akA==
X-Gm-Gg: Acq92OEm741L3TqhV4kxUA+LlvlfFhisyQe7ud+meilTj7l3N5z5MXTd1opVIZjFnmJ
 N3go2YgUx4uiBTNzpHO/wtqjsikV0dMiY7h0iYUcfq5cIpiSI+Z08Kkz2xEz/WN8wEEgmPzUGJp
 etl8Q/t+laqZp9plyA40+wBrOZ1L1IgzlgkKtuvTof6lSzFjTCQqRSzoQM23ye4J7Evwimvoa38
 SlYhldYPYZ8k8YCKmGIXHUTuvz0OiQGgS7aE2bluaM1h8NNfXW/hPp8ilw0XCUJ/7t6+TR5RWf3
 GKb853X7XbBjBJrsMRrGQPY8wIgt5vhe6NFZsYBJYaphNwj84VwbRyR1Ppqi4l6mv/AyZX3rlFm
 5nUjGY7CJu9ySohjFkF5jTX9SamluCWj0UMgy43iBBR1/tOs=
X-Received: by 2002:a05:6000:4301:b0:45e:93d5:7bf2 with SMTP id
 ffacd0b85a97d-45e93d57c00mr5545584f8f.15.1779288283681; 
 Wed, 20 May 2026 07:44:43 -0700 (PDT)
X-Received: by 2002:a05:6000:4301:b0:45e:93d5:7bf2 with SMTP id
 ffacd0b85a97d-45e93d57c00mr5545510f8f.15.1779288283160; 
 Wed, 20 May 2026 07:44:43 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm50145145f8f.11.2026.05.20.07.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:41 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 6/8] drm/sun4i: hdmi: Use the common TMDS char rate constant
Date: Wed, 20 May 2026 16:43:42 +0200
Message-ID: <20260520144424.1633354-7-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HrzZYUN8ZSqnvVy5uSl8agfNIwisHKc2mTS_wZ7tdOg_1779288284
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

Replace the 165000000 magic number with the shared constant defined
in the <linux/hdmi.h> header.

The old comment referenced "HDMI <= 1.2" but 165 MHz is actually
the maximum TMDS character rate defined by the HDMI 1.0 spec.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 07e2afcb4f95..74c7c3720ba8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -189,8 +189,8 @@ sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return MODE_BAD;
 
-	/* 165 MHz is the typical max pixelclock frequency for HDMI <= 1.2 */
-	if (clock > 165000000)
+	/* HDMI 1.0 max TMDS character rate */
+	if (clock > HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ)
 		return MODE_CLOCK_HIGH;
 
 	rounded_rate = clk_round_rate(hdmi->tmds_clk, clock);
-- 
2.54.0

