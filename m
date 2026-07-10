Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B34C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494E510E574;
	Fri, 10 Jul 2026 10:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BywlWTUj";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D33C10E574
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:04:28 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso580149a34.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783677867; x=1784282667; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wyZXpBPBL61m8TrV16Lohtok6L4J2DeS9zQ53Rr2MRY=;
 b=BywlWTUjfaPBD0rTFJEsaCXTEMZ+RJg0XHs/O+G1YtHObbE01E5PBCZ/W9Fe3tLQ7x
 1N9EgN0FM0t6BUuj62GW/Se8wosphIIt5du1sGhO7OMue818AXc4yZ+4np8sIZ0zz2jA
 WrvOgrIMFsjRFptlaNiXJGSkA7LcoRY6SvP6az4fMMP26VJOQgGkgXuIV/9Eu8T3y4i0
 MF2rheKJ/ox4Lv51Tql9iZTrpz2O89qbZ0rGiYRiGUHm8xCD08BFa74MV4pL2isgLrCm
 B5LUqRttsfXa/ieD1uDNOc4/b0uMMGZxnGMmtgXs351xECO6OCzucCt8uuriM+JLOKci
 Ujow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783677867; x=1784282667;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyZXpBPBL61m8TrV16Lohtok6L4J2DeS9zQ53Rr2MRY=;
 b=K2Eb8ADBz20HPUEO2S7xe7QRNM27RCpnQbjnqDOzokt6ZCod6gofEgHUb5sriH2Dde
 aKQkAXwf4j662PilXnp1hs7yAJQYtKJ4x7WDRNIoJlrpa7ycT+uiyOuQmLyfrhYURVYd
 WZ/Z9u2asDts/4XG1GvKj+JYJ4EWjaBt+rdHfD8BSIQL4THWgxeMNHVgbtYx3+VSGBof
 a2fmcR+68RRpsdpG40i+H04L1EuDJnM9wb68moDfvqB9ghsKbuZ6eSpDJJK8FHvN/9rO
 crwD7vb5wcf7ak3BZ9tk96qXsLWj9IOT6BQ6eGk5z09lNeFQkqbgHbxsAkYewJtoo+Wz
 ETJQ==
X-Gm-Message-State: AOJu0Yy7TrS4sffkSbpXh6Sb0+rKbP+6JffKul6s2UYIK+bEEDb3TOKJ
 Xnh1/CX8MCNYfDUkSPGqas5ZF2ycYZzN1HmENNAE23gAt/1qP/8Ud7cV
X-Gm-Gg: AfdE7ck5MXQwKP01KoL6hWLl82ZNJDj7YS1EuOHnhA9phlHOyyFoHPXYXwqXKde97SM
 eRNEVTthp2UxL1cygkewMllqwimjzWEbz441bmPH0gFFcZa3wuXBjLIa46PabJDMtFZr8cYTVW2
 JXtFYE95c9t1Pp9cHk816T1RVE253pzZXiQn14mZu7n3RT7EjDFrlkCaaMjOEaveTpEfJEpa4X/
 +Ya0i5Q5/sW0eeUVZY9LAupk2yZ8InMixMxTrrxpJ8s+6iDUAIJ3FcY2WMKmqCthxsdgLimmKzj
 kQH6dAvMjvE/eE9tUwkPznB6ekB8GbhZz5YlZ8YFsLVHVER79sSgyVMa4dZR9wmrq/xNre7wh0M
 cbNNF06y8kCrVjgvmusyWnhvgUFhn1jOJG5Gzhz0VNjESfrEOIzFTswhfL0fpmfKFijXaGVjcPE
 8TW4cEFpG6vy+lMNQ=
X-Received: by 2002:a05:6820:c90:b0:6a1:50e9:d589 with SMTP id
 006d021491bc7-6a36da636f5mr7405199eaf.70.1783677867421; 
 Fri, 10 Jul 2026 03:04:27 -0700 (PDT)
Received: from localhost ([74.80.182.70]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a38aab2761sm1591968eaf.1.2026.07.10.03.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:04:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:04:18 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [bug report] drm/rockchip: dw_hdmi: Propagate bus format to display
 driver
Message-ID: <alDDok08ZB6hBQ4n@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Jonas Karlman,

Commit dc70272cc184 ("drm/rockchip: dw_hdmi: Propagate bus format to
display driver") from May 18, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:289 dw_hdmi_rockchip_get_bus_format()
	warn: 'bridge_state' is an error pointer or valid

drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
    278 static u32 dw_hdmi_rockchip_get_bus_format(struct drm_encoder *encoder,
    279                                            struct drm_connector_state *conn_state)
    280 {
    281         struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
    282         struct drm_bridge_state *bridge_state;
    283 
    284         bridge = drm_bridge_chain_get_first_bridge(encoder);
    285         if (!bridge)
    286                 return 0;
    287 
    288         bridge_state = drm_atomic_get_bridge_state(conn_state->state, bridge);
--> 289         if (!bridge_state)

drm_atomic_get_bridge_state() never returns NULL, only error pointers.

    290                 return 0;
    291 
    292         if (bridge_state->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)
    293                 return bridge_state->input_bus_cfg.format;
    294 
    295         return bridge_state->output_bus_cfg.format;
    296 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
