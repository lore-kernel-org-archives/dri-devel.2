Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sx+XLhk7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E9010E214;
	Thu, 19 Nov 2026 21:26:42 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63EC10E71B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:26:35 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso2038257b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795123594; x=1795728394; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GpzYE3Jc1he50CMWHOLwrLBE02eLthVYkqvqGjNMGAg=;
 b=Sx+XLhk7HlCUMmEleLiUY8wo9TvdzX0q8AIGv52ZS3K5LtIl7o9YovzvQsNFbhqvcL
 2hXDync568ktPOYcne7/3kyqae7aAlK4YLH1zJ8h3Gt5eyoAl9gtfSKJOCV0GgCt6CR8
 SDmWfypq2RPChDY1DFHIF72DqekrAsLh9z0C6Xm4tyCj46gdp4sJ6Obly+HllKd1K6ti
 wmWgUx6aJiBKDQlvqqsLV7rlXh4TTT1TGUfaPjfLBSIZOCQDGKWrQ2WU6LPD9OxljMg2
 87DPsNKG+w/8RS8VyI+odHJfopBqcYCAH2hfbrI0t1t4gHDcjL4DPu2KBlp0z9a9rnF1
 tNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795123594; x=1795728394;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GpzYE3Jc1he50CMWHOLwrLBE02eLthVYkqvqGjNMGAg=;
 b=TsEvpzTuRsPK0/cNDNXDalaqutdmaJjtp+BjwCxNae9Q4oWZ8BggrvHuO8kZqntbIg
 jGEFIhEXM3zL2KtJXXCooxjRl5wJX1Jce1KpVFflL+emZPPsHlgSgaugZUDp09TTjgAq
 EhldCns8lNy5dFWMy7aIYObBzdZnjlNL8FieBiUsVSSfYuhjObeh3n8SMBWVHVZGfyIT
 qKh98SpIpR76WJ+CqGMecAhYnskb10HQ1/ioblUcxsXE3l7iUYAhWCDXZU7eBs7tAtbN
 CpItL/isOD/T4pAxv4EX7SAQFkIB6rpeqHowbJArzyLQ9tsN0oor1HOAxlxsJbVVzWfG
 TFug==
X-Forwarded-Encrypted: i=1;
 AL+hErGBor0OralwgX+tbLrbGgbDBU/d63l8NVYDnG/f+287fqzgOBiBhqPOHGr5zeumv+Umnk3COxXssXQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Vok98SuJ5k25N5SaSBFr1do9BDi9JntXZnOFmeux3VSCqKCtg
 bWk6TgpAkgqxF8CZ99saLvrsFFSIqlztaWVG7wi5Qf/czNkY5gga6RJM
X-Gm-Gg: AZFdTZfBEuRWY/6WYiF27Bbty6+ZYzQo3fefNMRd68mKy9M+cUGOr/JplF04u10HKDC
 8bGHIH/f53WayO9KIE23MEfl/GNtXH8t78cd0fEaeXP0UNiHTuHMeHeHXHFYltpfvF3xb7Tg079
 IdIvmwioWiomBxpx6+q9PBvwNwI9h5yB+HxtKsoMAacAPWW/Z62rkYGKk/+3xcGG15/NAtf1Hox
 tU2DH5+OLnDmEJGP8+/N15ejzXrJMn0K02a2J1j2ZtoLubm/Wx0mLjas95noyy/vewRWCxCmk/c
 M1wm0lTFVLSF9adLrBdnwwM/DW4dwJlV/eXZfA0YctKVQQ8to44Af5Z21ZB06dIUz32EUqE+mmP
 5Ew0qauOLelYWqs88IrgeX48aGpSYAhsN6vOGL+UCmeeH6w45yxTOsFZlVWG7+yJaiyMtM8Xvyu
 HA8XVvjpcVvQ08x/1Duee3vY13IPta4mLeUgzQ7YF4xj0HhQrcokmte+W9tjhn50wYE3L0eRLRC
 NEx4NAZYBd9vohntE6PdWynaaJuTJNWxeP2CDk+yZEhPTMsLbkVx+YV8XDUdHipgRQHzaBPl+1u
 DW4kpoZ+LSQ3YAPLMgIxUV+u10LZ4asRXEd689XjftMQxiBxEqy1raZCs2U0Zwebq0Gb5D1TUNi
 iVhsmUZcBIfoJNht+1dLhZtm7lguvLqR8tl/HCmA4ug==
X-Received: by 2002:a05:690c:3707:b0:8b4:e17f:f7f3 with SMTP id
 00721157ae682-8b52045732fmr5288457b3.22.1795123594166; 
 Thu, 19 Nov 2026 13:26:34 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b5202bef08sm5583527b3.20.2026.11.19.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:26:33 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] drm/nouveau/dispnv04: Support PMU sleep on the iMac G4
Date: Thu, 19 Nov 2026 16:26:31 -0500
Message-Id: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A6Y4AfdiljE+NQBjSFBEcS9G
 yxPce9DEUEQqcseCrgkyuESVJ6RXY1bwDIlky50rZRq2R3nBXOy343luAGebVWiqPVoNRpKoQ+
 Y5f6n/fC+H4tE3q1kAAAA
X-Change-ID: 20261119-nouveau-pmac-sleep-c54e062bc2e7
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=H47g+gZOtNzRvfYRZiTfxTdPkEiWb/7zemgBeHo4gRg=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3Y8nmwbZhz84vhDxks6a7K7SmJ+C61dciotVzqw3
 vTCbh6hjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmpD8jw8Gwt5anuo
 /u9fhurCLupPTiZugO7YmvNdgOf/x8ePX1h/8YGe5e/zZ52d/b52c1JTn7LWo7wy+wRUlhFY/kz
 mMzPF/NvMsEAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With nouveau, the iMac G4 (PowerMac6,1, NV34M) only offers s2idle, and
when PMU sleep is forced on, the panel stays dark after resume.

The dark panel happens because the VBIOS init tables, which nouveau
runs on every resume, reset the backlight PWM that Open Firmware set
up. Patch 1 saves and restores it.

PMU sleep is missing because boards flagged PMAC_MB_MAY_SLEEP need the
video driver to call PMAC_FTR_DEVICE_CAN_WAKE, as radeonfb and
aty128fb do. Patch 2 makes that call for the NV34M.

With CONFIG_STRICT_KERNEL_RWX=y, PMU sleep also needs "powerpc/powermac:
Fix low_sleep_handler with STRICT_KERNEL_RWX", which goes through the
powerpc tree. The testing here included it.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      drm/nouveau/dispnv04: Restore Apple backlight PWM on resume
      drm/nouveau/dispnv04: Allow PMU sleep on iMac G4 with NV34M

 drivers/gpu/drm/nouveau/dispnv04/dfp.c  |  6 +----
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 41 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/disp.h |  2 ++
 3 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: 8e2afcd2b57990465f132367fd8fdc2e55c1adad
change-id: 20261119-nouveau-pmac-sleep-c54e062bc2e7

Best regards,
--  
Matt Turner <mattst88@gmail.com>

