Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A2FC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D3D10ED20;
	Wed, 19 Aug 2026 06:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cJmRs/Ae";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFC110E2D9
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:24:45 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7ee4399c3abso2610630a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787005484; x=1787610284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PmyumuIbO2ebXCMuhpUbu+i9E21ps12svObOY0TjhVA=;
 b=cJmRs/AeMePxtlLzrnnJYm4OOWFrPbgr4FLyxk1t7ehPx9+q67OjoA+lmtcw9j2YMS
 z3LosHhlAXFBm4fLh/XHt9ibrpWynP4S9CgsLrKm2YrMX9jNdmbVTSmPc5VxjJkXDBwB
 h34edr1vZiHjUsyFF/WhDmj5UB0exKkqPBqGIKS2bByXNkz39lSjYoUYBD5LKmQYiMTe
 0excAwovyaKIPpDElk0JXBlcRMixxxCESm6iP/WkyD4/NBcxyLmPGq05eIAvrXvwp4sf
 ojCnER2j7WkR3T4mqemVPNruvNaL/aAZuFvngH1ug1SAk2xMkvy3eUJ8whIxbuEaXOdG
 qnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787005484; x=1787610284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PmyumuIbO2ebXCMuhpUbu+i9E21ps12svObOY0TjhVA=;
 b=NzEUzRegjShP4qt6JrN2qx/SjNlSb7jtATHsKQM96fejNldFyBZ/D6bqBrVGDzm6vx
 5Tgwh3DCO8oXdlSbv8GO4gDVtpCniLbZMbD8T3bPppm7MrJTiZqKZ/2ORAonYeDwbtVy
 QB/pRV/oAo5BiPJNQkWogEBFNF1GYUuEQzkc2/BgDgVhIkcbTo/3rvZ6G7quNjATPzrU
 2Hwfc17td4P3Qi0IGtTbrVJioX17asPJnGrgo6vjdDvZPssnsOOJdqvBDcluDg4ppUpr
 SZeSlNjBilHq/XXUu3IZjPMK0N1696avc7M3mL7JcOnYJqa0eDDDqwckRBxVriC6sm6n
 Bxjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEN3ldIm3MJtGA20Jheka+NTQ9z1gPnaNFB+Rr0k3Bw+uQ4f2OFEFIdVrdC5yCBsVd8Lrl9sGKuIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5vwr0czfCUloo7m4NAvk6FSu1+6iHVTQDtWOmW3C290us3CHn
 SLxcuotDJlaOWR6VD4S0ywEWxJJASwSCfyP2p31nLzDv0nOI+HX4HnLT
X-Gm-Gg: AR+sD12fOhMQMw/kw0ls3thSz5G1uW1fNAXRGR0A/GKkJfWIkLce5DuN9+wbvDbW8CK
 Dz3MIdDPKN+YSirDkUvBgRLGFAhnzba8xtX6PLTRpkIwtYv+wgE/2VTX7m5LVq+dVWYHNEvDTae
 am4AEu9r6E0JSIp9FcoGvaOPFgT5zQjO8sLr2mSUSKEhoCjPVqDR6OeVdh5bHwVND3qni4tzM8O
 Yu59ypD6AUfGkN2HmqKXfHhN/4bMY6Ojf8KnTcU5yYBDzRKKcrsML1gQCwKISMf3fUK3PqDTcDG
 VkEwsqtsiDUby9P60COOdoIM6q+0JDMgCUD778JdpNOM4cxG6tZpyXTdAeN9hsgd+NMfhnUpUcL
 VWVqNFQVUzVW1oTFaHkqVWA6S7n4CuofRslSviDCxPjnZJCd/rzXi2oKRgJUTULRIJ5m2riACEc
 apHJv3pYTKQKZDTZw1cUjXTb94nDiuWR5j3KtwIkb3nBHr934BcYeupguLjCktjzJ2fcfMrTUfR
 rEAN4KAfYLxKG8zf/MbjPR4fm92LIxbLHwxHU14Vg==
X-Received: by 2002:a05:6830:3108:b0:7e9:ff97:5e3b with SMTP id
 46e09a7af769-7f3de65e719mr26071151a34.15.1787005484560; 
 Mon, 17 Aug 2026 15:24:44 -0700 (PDT)
Received: from holowork.tail3176d.ts.net (static-68-235-46-81.cust.tzulo.com.
 [68.235.46.81]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41bf31393sm2516813a34.12.2026.08.17.15.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 15:24:43 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: sashiko-reviews@lists.linux.dev,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Amit Barzilai <amit.barzilai22@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Fabio Piparo <holofermes@gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
Date: Mon, 17 Aug 2026 18:24:01 -0400
Message-ID: <20260817222401.906748-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817154126.D13271F000E9@smtp.kernel.org>
References: <20260817152500.703770-1-holofermes@gmail.com>
 <20260817154126.D13271F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

I can confirm that one of Sashiko's findings is correct, and it's not
limited to my use case: with the early return on !plane_state->crtc,
the clear in this path never runs at all.

I also have to retract the testing note. I did more testing, and the
blackout I had attributed to clear_screen during bring-up was
something else entirely, not the clear writing RAM. So "Exercised on
an SPI SSD1322" is wrong. The asymmetry itself is still valid I think
(the sibling ssd130x_clear_screen() sets the window, this one
doesn't), and the patch stands on inspection and compile testing
only. Happy to reword the commit message in a v2 if the cleanup is
still wanted, or drop it.

The other finding, the out-of-bounds read in ssd132x_update_rect(),
looks real too, but it's pre-existing and separate from this patch.

Thanks,
Fabio
