Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB8606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGHOqVA8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA1F112A00;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335CB11299A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:27 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a358881793so4162467f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774465; x=1796379265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K+81Uiocp4dxkgsx2JTIwt2UK6FDgoo8FjodVxd3QpA=;
 b=YGHOqVA81r3GF+vOvgcP3KblRS9pa9IKqWscKoe9+ylhWIqPI/twJqrbBvG6VZDNAY
 VySQo2KcK3FvBu2FrQfjQJTpiIm86NhFB/g9tCFvJmM9lj1EWqoGklMBptEqmahauFuj
 2aQU3YupU1seUN1YANc1ynYI+BHXrgE5zYjxRh7mm8jC2PURp7i+iTHn/nSydbnL+t9B
 NG8JL2N/CU0C69yGnxrsGVxt69z1uCx+N4qxcfEmw8ToqbhsOlP4+dLH0zf9LLKA71oP
 jFzbnFe5ZMhW1vYFgt4EasOSYboN18dcYCkBiwhnmKLqFcwWsEvt+T/X7MJv14wTUB8U
 1cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774465; x=1796379265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K+81Uiocp4dxkgsx2JTIwt2UK6FDgoo8FjodVxd3QpA=;
 b=BGkBMaRQkLunvFdjieMZduJr4h42bwIKhvzdgYd8Q/UzAbonGD7JGG1hJsgwvodlHK
 ERRf/qtXVEhian/5kKiSQPXicLiKLIaJ71v1fTtNthpB8z+o5U98PrSr0Rg52S3PAojD
 nOveRmBm7xG6Uq6osewUJ7tvsWnRPLdLyDN72gJDsRPhYqgsfNcUjm19aPHzxE3UD+Al
 8lacS/UqOVce2tgd2CgnwTUIWAbOXN0tGIY8zNraeYzs9AibCaHtPNxACRfvHdkszWlR
 emH+eXIcbSjeQLKcD0AsZXCE5CWJhuiAnqBex95JYzbqon1sfTqfuUQphyY/hJ0PL4vT
 RJ/A==
X-Forwarded-Encrypted: i=1;
 AL+hErEC5BXJa7FseB5krfQMMySLFHff1JQV0Zjuk+SSwmA+auVwpzb3iGt6Rs/i+zWoqoZpjrUb+GF9MTY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+W0pvKVxXBLGzJOyzkSiKAqFDrLE9qgR0D7LWUqeN8O+3AGiIK
 93RLhDJtj8vrBsZm5BbqHSM8tgkAtutjcrolviFDzOiwJ11u6QiB1tc=
X-Gm-Gg: AZFdTZf845qOU+xItmazmJ5DC2ap8uwqXGuMTOYK7eERPJzLSmo5937d+suisLtWti+
 QumM8Fay+RA7dlrJjumiT+sNi23IJsKMatMh0QCCo7nNPU/eFEGLr7fQO96TtYKv9OevcGR3tYV
 jEKNKgEJDonPWZNU1mHo7jKTzR+2pBqfEBkqhHLTRwh+VoOGnCv8PA87U1GB5zkbTENw02Na5l9
 swj+YCXH8zRJCJWzwnjLS/jF50/xqw38AYliFx1xOc8a5CM6Vf88o1IWBzliSbUdaILC5mzkPK5
 J+TkCnTvxDp/eGqoX9fqpQg3/o6VGJpOziCIk0vamCi+gquQabWpqaFxgE++PQjBXsTZo17TPG+
 ZdIzJDSTGpnFY3wUpeA2UeMyxu+gCy9R6YdrthIX/b3/yS/29Utfwv77Wz1wllLV7rSqBsj3rHP
 gvcPVmDrmraYRIYgYOGOAOEs/cz1GMyjiaQ5m2A4GK98qwVz1yyic3UNz//NpbYUeQ4vYeAKwyA
 Qr+cwJGZChUK72aT15tscilevoWAi1aQMHHOqq6XzqN6WE8QaL8AWQj/wkKD8YZo6xqVYmpsmu8
 nl1wyZGcxe/1gAtin6KqufIVJhmzjold5RjjXWBXnfhnprC9QpiDNPSuFLWAaTU1UC1yu+plrCq
 MmVk9hejVs3/DjgWpn2ASpcf68LEWGsYeU0vug2X+EkRhSPdGCEmWw9B01Nk=
X-Received: by 2002:a05:6000:188b:b0:4af:e519:ccd7 with SMTP id
 ffacd0b85a97d-4afe519cf33mr36813384f8f.3.1795774465333; 
 Fri, 27 Nov 2026 02:14:25 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:25 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 02/10] drm/msm/dp: reset cached link_info before reading
 DPCD capabilities
Date: Fri, 27 Nov 2026 11:14:09 +0100
Message-Id: <20261127101417.24303-3-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link
rates table") guarded the drm_dp_max_link_rate() fallback in
msm_dp_panel_read_dpcd() behind if (!link_info->rate) so eDP v1.4+
SUPPORTED_LINK_RATES entries take precedence when present.

However, link_info is not cleared across hotplug cycles. Once a monitor
has been connected and link_info->rate is non-zero, unplugging it and
connecting a different DisplayPort sink skips the fallback and reuses
stale rate, use_rate_set, and capability flags from the previous sink.

Zero out link_info before parsing DPCD capabilities.

Fixes: ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link rates table")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d3468b73fdc3..e633afdf2b47 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -195,6 +195,7 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 
 	msm_dp_panel->vsc_sdp_supported = drm_dp_vsc_sdp_supported(panel->aux, dpcd);
 	link_info = &msm_dp_panel->link_info;
+	memset(link_info, 0, sizeof(*link_info));
 	link_info->revision = dpcd[DP_DPCD_REV];
 	major = (link_info->revision >> 4) & 0x0f;
 	minor = link_info->revision & 0x0f;
-- 
2.25.1

