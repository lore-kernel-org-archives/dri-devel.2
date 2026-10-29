Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B24606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ozyfDH3F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9861121CE;
	Thu, 29 Oct 2026 10:51:58 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD771121AE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:33 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so251695966b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269112; x=1793873912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZswYnDpjiPQQjT78JVpuuL0hR+s+VPAsr78sVKkNA/E=;
 b=ozyfDH3FdbwDIpko2PaycEUgBDyeSZyfjretx9hffj0Q3mwFwWc91nL88u0IZX7p+8
 VTA3mKyebO4QNXIO/dq6jM8lzdLXTdkBcVq9ZutXfn0N/vzp+v9QWnBaViz8BQuQBarO
 T0YVnhHm3NxLoOO8A0VhbI1lDpHJf+T+Xer08doLcJi/eLieZufLPKEOMLjOx/AaJtml
 KCC4rnv9kMptgbKA3+9g2HwNXfUpFq2/bZPTu3VGDmC0jylbO/8m4pTiNRnRVSF0gYd3
 eBnlRllcJZWp9hFfT0q0nIyI3V3vBTlHcNKr86viXveAZPa4H15UJKLhf4gfmvsJ3Pq8
 pgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269112; x=1793873912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZswYnDpjiPQQjT78JVpuuL0hR+s+VPAsr78sVKkNA/E=;
 b=b+k+WzrF9I8JAfbEiWcQrbX288SwULVqKLFGtE7gKO3nq9Jf4boLJkh5N4GNquCThv
 iffkX23mZeXkRCRf4xg6kDxz40ZWH7i3rTLFQJ+z8d3tzpy4rqgBALF3DuR7m8goWhJo
 l2XJAlokRz0RlR3uPn7Jiikph+vxcsMv73iap+xQbMStUpnpd2DM0Abb4LuVDkR8BJ7g
 XhpeXE5KK7Ml8iMaepmA5a6v9mDv3b1JCZsLDbAMqwlpTRzHCHs1dKfC0Di4XwKK30Zk
 PFxGBSd6v7tHgJ9NIQdUNKMNi6w+JdzJ9kyknzJ8CesBZpk/XWOJ0y/GOJ6vVvpmU4LW
 DOzg==
X-Gm-Message-State: AFq9FYIC+izw3VvmhXeFUNtWTfpTtkkwVW4/fb+vefBm+cWz5GYuiV02
 vtwzJ6MEcHPrp+qQTNXHSDvRKpvuGcZwIZ+gJc4VvMVv9jdHFhZtzt8MgmiK3tRH
X-Gm-Gg: AYBFou3g/lM1gYmeG6bZlUE84mAUdQ54WFWd2boBMUSLGD2JQfEI0vnc+ybX5zy/XA+
 1knsZ3bVYlZ8L34Dr/HrNTPvSBp617mkDwQvrQe8Wr0SUZOqp1wOY3+c+6UdnhNhJdYi2I/yDLr
 68YXyXATGdoIVPtR3kuJMR07L+v8Mlwh8xlJ/qkAl2YvM0MqRi1JaIf7N9sXKySdZy4ydodrABl
 fkvpx4tX4B9pLcZvCX/EXzsXBkcDPxQmMSIlPFZivLBYiqJdLgGYF5U5PFp0cLdNofRViWKt4Hu
 guz9+cyOb8vMmJzH7WxOs9SRXuJcB6SnNdgTUN55gmE1wsJ10O4IHqTvLBXe4H0sAnoGXljPjsb
 mgeoCKe1k7A4EU7KokrvYKQPOon3b5lEmjBV0XxTKKMrKMqPeF9XBUYt68FHhotIXEw28QVpyxD
 9YA2dXty9ncZCxtKIOb7frcKnFsD/NZfo4DQxWo4G7Q57uUC6ou1CTAVXN2h6ocx4Ylo7aCgOvO
 IXfYx7bfQVQ8sxvzgCt5zIUFJORjk77DuhsTfXGN5amoFHOqUqazaz3FEktS4d76FvoEgTlj/OH
 439cNFUMapXcwuzlwfAoiFkK30YIaf7cN1+IRx8EaH6VnMYdkUWsp/Mb2OKEIDM=
X-Received: by 2002:a17:906:ef03:b0:c2d:c98f:4824 with SMTP id
 a640c23a62f3a-c49bdf32b3emr416211766b.30.1793269111958; 
 Thu, 29 Oct 2026 03:18:31 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:31 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH v2 2/5] drm/bridge: cdns-mhdp8546: Use
 drm_dp_enhanced_frame_cap()
Date: Thu, 29 Oct 2026 11:18:23 +0100
Message-ID: <20261029101826.72773-3-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the helper instead of checking DP_ENHANCED_FRAME_CAP directly, so
enhanced framing is used for all DPCD r1.2+ sinks as the spec requires.

Compile tested only.

Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index f47717bd1..8cab9a3e6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1375,7 +1375,7 @@ static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
 	mhdp->link.rate = drm_dp_bw_code_to_link_rate(dpcd[1]);
 	mhdp->link.num_lanes = dpcd[2] & DP_MAX_LANE_COUNT_MASK;
 
-	if (dpcd[2] & DP_ENHANCED_FRAME_CAP)
+	if (drm_dp_enhanced_frame_cap(dpcd))
 		mhdp->link.capabilities |= DP_LINK_CAP_ENHANCED_FRAMING;
 
 	dev_dbg(mhdp->dev, "Set sink device power state via DPCD\n");
-- 
2.50.1 (Apple Git-155)

