Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F2BCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84F610E8E5;
	Mon, 28 Sep 2026 08:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PY+uGwdH";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B7E10E050
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:31:31 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-93a2a8c29c4so185361285a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790440291; x=1791045091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ilWbdrK2o5HYjWejTvlhwKOghbkTj1jD2D3PzsAcjlU=;
 b=PY+uGwdHrX1sEfzakl779ITDqMBB2aRcBXPH7NxeIlK01MgCXHurD84iNYElJbslZ3
 uxo/QdDaDp7NIWJNwF5+t+xSAWrZYZfqwVEqmII7954BxT9MtOUbC+DdRVw5tPLHX+Qn
 qJh/HdwbOtS8hbMhwQe5ZO0P8+RPXliXExO3WQGxrKvbov3iFVUdIe1A5mj4I3MIZfcp
 UoMSMaxBfGe5Qfx0cgRYJT5PrHl+DGsbW0B6sAmeM0s5hg8MOFn41avp6GfWWnRk/KyH
 syxX0wTaDIQC1NuvMJ3FxZafsj5YTyuO3dZIPaw+n+M8BFrPtFzwMG6UUKjAFT9FTla+
 Jr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790440291; x=1791045091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ilWbdrK2o5HYjWejTvlhwKOghbkTj1jD2D3PzsAcjlU=;
 b=aYJy66cAggLHxA90sKU5FyWWWJqK5U0WPZxI32gaVM5aor9VOqAT7tCeO1DHTWl3aL
 CGxgNe8mxW9e6RXbP/1kjWCIpQSzuDQom6yIp5h1/s23pyVtUp7wmeKxXgMZrChqcGi2
 dr3eyVxkmB+sY+XtiaQWMoXzp3Nf5IER3BB1d06fwfcxaR5mF9rF9WF9Qyx5vIcF+TwX
 /vxHoX46pn3XPoNf4l1I56vBxzaZf7rkZremjv0kAlSvACx6SDTfP5lsgy0HmvYmXbgu
 2KqdmZSL2CI9C1sL3WFCnafzjx8BWYL3UPmii0uXTutiDK7IOhf/aS/hdjlltNBSnPlR
 wKsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+qxd2ARVqDwRC/4sQXeiqNWCVFllFpyJUOeEE1M/4mSI/vFt0xBdwrC38mzn0L2R74e2b7W8asxI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kf8AmsO5XXBk0E41UAeAB2og4TduJ98Xsl1I4SqKiqRWMy20b7
 pW93qSnvxhVY+4LxwvKFOjEUjubKm71Wohsx+BNVFFyKUfmwT/CjR1hn
X-Gm-Gg: AYBFou1B4XhZX8cHEdCawUOTQC1aj4tBiTt9+atLRkh2Ip/unKA9edkJMUx9LDQnZVQ
 4bA4YvUwsppufSPhyFnznL4IsZ/Se0U3bwbgFbx0kbBoiiZU9CyKYKOTlEjtTclAszi17EdYlKH
 xJ0I6aXm6AoFaKTWUySsHeLQrrf+74vAWmV7U/mZkCLBekAcogslSB14MPwSO6M7hIR7WXPRS87
 gxx1BuUa3tOFuE6DIdbTfaYnKbIpNox+gY5DzCXNfaRSLFY94t7aJjgXZ6q0F7CErnRS3t0Qwg+
 3Db2rp51tP9KlVUadRN2FYIkY4H3lNzPOpFKp1tpLaUhzLDHgarEGplHHbpguMskKZBfkv80Xwf
 PrqiaESsJp266Mdc26wWFutITqd7fXrJKT+b8UPgp4m5b/V41kwxx6/yYMFOC7FQPKnu+G1/PrE
 s9Wahlh58226rl0a6E0OvEi2eZJCmv6CDWohsgZdFUQhB259IpJ+aVSG9qHd2DBIxb+f67m7IP4
 2nwtGwPCKqFBifzlcCzRk1Zw+LeTAeEM1S8lz5gO4inezg3mVDAVcFNhw1xetAIC1F/
X-Received: by 2002:a05:620a:4111:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93c43b7f202mr1155214985a.5.1790440290642; 
 Sat, 26 Sep 2026 09:31:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:29f7:9600:f571:6178:b590:34a4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Sep 2026 09:31:29 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, christian.koenig@amd.com, krisman@collabora.co.uk,
 noralf@tronnes.org
Subject: [PATCH v3 1/5] drm/qxl: unpin the framebuffer when plane preparation
 fails
Date: Sat, 26 Sep 2026 12:31:19 -0400
Message-ID: <20260926163123.39217-2-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260926163123.39217-1-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

qxl_plane_prepare_fb() pins the framebuffer before preparing its GEM
fences. If GEM preparation fails, the atomic helper cleans up only the
previously prepared planes, leaving this framebuffer pinned.

Unpin this plane's framebuffer before returning the preparation error.

Fixes: 6071c4c2a319 ("drm/qxl: add drm_gem_plane_helper_prepare_fb")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..1f869734e14d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -887,7 +887,10 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	return drm_gem_plane_helper_prepare_fb(plane, new_state);
+	ret = drm_gem_plane_helper_prepare_fb(plane, new_state);
+	if (ret)
+		qxl_bo_unpin(user_bo);
+	return ret;
 }
 
 static void qxl_plane_cleanup_fb(struct drm_plane *plane,
