Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AB9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2E210EB3D;
	Mon, 13 Jul 2026 22:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqiOdsOj";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C77E10E642
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:33:54 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so25043625e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971233; x=1784576033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=55hAsrp5cSCWxuD/wsCuwgomM/DV8c8oAdTivk9jE54=;
 b=ZqiOdsOj4Fsmh3XDI32EYUezovAb+usxLQjN5T1TM51Elc9XQxg7QHsx+eSPcvwYCX
 m+RM4M/uLmpItv+M5zr7P/6O1qQc6/13uSLNiANTVI92B5xIjhwV9Qu9EQ/S2UMaRCF7
 jkNIaNttF1UzvhR89kmkVHEMrBenC2ao7VH9ZHDCZzJc3U0JtUK8cybnIOAAqHE6H8ku
 pwoMyhvdIEdAiSSnCzzmfC9dWrpFiSq+PL2aXdNBgTVAwD3CP6dQOy8Mw9Tyzy/y2QTB
 EzQ9QKEQNsnRKfj+Awtwn0ERFfLQgRxvFsWSw+JJo9qZUfgRJI967io7bahfgG/Vfoiy
 Pzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971233; x=1784576033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=55hAsrp5cSCWxuD/wsCuwgomM/DV8c8oAdTivk9jE54=;
 b=PAuxEE/5gRgvYKgJ+9S3bQq/qSB22PlMdhTnTEJ9EP/gFFAMO7CvfJMuYH9mnGnX43
 JkfyK8v7MJ+ReG2MpyhtTMOdxfc3uNQLF4e0Sf0Rfhk3mCIpa58nBWDefEUDojniLIh3
 gWq8Vohy8O+5uYzln9MuwPceSnL0r66pSd2qtn+/PSGV/1AT4IuSJlVgD2xtEVHtIHxd
 fjz68k9ibp/4uXgVKh9zrdpSafqn6OgSABvVmOtApjV435t26Xwb5WCf8LZcES3Sch0R
 EMekFJGC9WBPBzr2a6IvPSSuHjrK+dBbHHpQxhNx2//LuJIjx9VAZ8hMkfn8/d8747Uz
 Ojhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgvjc0jPkPnlSSOwXg0bGkzdeprWeEJYSVSGTev+nUmhkd20MZaiMXAwdHZzMQC/WYvsYLnPPXNiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxrluo7fVbU1NOf1gUitl+3pDZhvjgdK9LmKkSOu4Htm61ZOfYb
 6XhZh6UZWIiQSoWR2gRVWDDux+54eEXPy7Qca6WdKIIY2wr5VX/QJPCm
X-Gm-Gg: AfdE7cmdgH9VB0ZD8iNYwoPpOfBawvxzofF8z57gdDDAH6C89DjamsW83R5kQD1P38L
 LrnhzQmJFl1GDrCh54sXSQiLo8fVBqkUEqMMIpZNhSUYlq/Cr1FTln6Z6l7JByrtxDLSfFX25Mh
 4hUYdPvJRpg5wpsv/5/RYkjG4+e4wGlTfGN8U8Q3Q7N8Pb+/mEZ1LJklP3tAdaBIMpqc4nfPKJS
 fQkgIX4jUEvbpAuav3f4WMf7FmXNTdKEb2haWLKVxfChF5g1sTLN9H4uosEBUEVx32TAI3xLae4
 Lld/3jbk44a2W5lomSzNHg/o/H/4oh+0BtG8XT8MhUBImaaZntB/Gu6fzWborZzemh/VeG9mfCc
 s147SSG1XW2kcZOdpJd+/WtYCcF3bF+M23nh5A+SAbddXx7yseQeAwZWyg8yhjcTzKV9nKF78hM
 XVsrPmig35Qd0IXPcKeWd7q0Z41Z/q
X-Received: by 2002:a05:6000:2505:b0:47f:25b1:e7b0 with SMTP id
 ffacd0b85a97d-47f2dcd5553mr11731996f8f.44.1783971232956; 
 Mon, 13 Jul 2026 12:33:52 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0d9sm1912993f8f.2.2026.07.13.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:33:52 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Timoyoungster <timo.proemer04@gmail.com>
Subject: [PATCH v2 1/2] drm/edid: Export drm_edid_block_count()
Date: Mon, 13 Jul 2026 21:32:36 +0200
Message-ID: <20260713193237.2639-2-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713193237.2639-1-timo.proemer04@gmail.com>
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

From: Timoyoungster <timo.proemer04@gmail.com>

Drivers currently calculating EDID size by reading the `extensions`
field of the raw EDID structure (e.g., `edid->extensions + 1`) will
calculate the wrong size if the EDID contains an HF-EEODB (HDMI Forum
EDID Extension Override Data Block). The base extension flag does not
account for these override blocks, leading to truncated EDIDs.

Remove the static declaration and export drm_edid_block_count() so
drivers can safely query the true block count. This allows drivers to
leverage the core DRM's proper handling of HF-EEODB and other edge
cases without having to parse the raw EDID fields themselves.

Signed-off-by: Timo Prömer <timo.proemer04@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 include/drm/drm_edid.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac..34560b33a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1698,12 +1698,13 @@ static int __drm_edid_block_count(const struct drm_edid *drm_edid)
 }
 
 /* EDID block count, limited by allocated size */
-static int drm_edid_block_count(const struct drm_edid *drm_edid)
+int drm_edid_block_count(const struct drm_edid *drm_edid)
 {
 	/* Limit by allocated size */
 	return min(__drm_edid_block_count(drm_edid),
 		   (int)drm_edid->size / EDID_LENGTH);
 }
+EXPORT_SYMBOL(drm_edid_block_count);
 
 /* EDID extension block count, limited by allocated size */
 static int drm_edid_extension_block_count(const struct drm_edid *drm_edid)
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 04f7a7f1f..4a990bf87 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -481,6 +481,7 @@ const struct drm_edid *drm_edid_read_switcheroo(struct drm_connector *connector,
 int drm_edid_connector_update(struct drm_connector *connector,
 			      const struct drm_edid *edid);
 int drm_edid_connector_add_modes(struct drm_connector *connector);
+int drm_edid_block_count(const struct drm_edid *drm_edid);
 bool drm_edid_is_digital(const struct drm_edid *drm_edid);
 void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 			     struct drm_edid_product_id *id);
-- 
2.55.0

