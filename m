Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE63606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=il0UxCUp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A1E1126BB;
	Fri, 30 Oct 2026 09:13:47 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4947110E213
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:29:24 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so169928a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793334564; x=1793939364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HpeEYAEKyyCPvuV7efERlE4nfg2Y+m/mO0FuoK2R5s8=;
 b=il0UxCUpQCFe6E8n1ZmdR/LpHy1PyMNvAMcpHp1Yi4wTlJY3DpoaTTBvcouzAnHgvf
 hhUY2qFjfsuLxc3FpXJzwEHNZIFfnPH+Id+7Jie2yT+iPSqUNlxqFZoLuWSpDJDvO8Wy
 wAjbNEMIWWtoQl1M+PJQUZ8liQeoFxpndk25QRWDQpEXbxqbsPFANNfWstM0n5cyKn6D
 WNZDD0Q89yQKSbV54t5NneGXQKzaPTsZcpsbMxWy/YEJggtbxPGMoptCjbpZzheAWmlW
 nAhAeTE4jj5M7gXL7pNSnEbZtY2PbbmQLjhFjq4NnxZcOBFBtAPpgMGR3AVLitJKpEDJ
 ZPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793334564; x=1793939364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HpeEYAEKyyCPvuV7efERlE4nfg2Y+m/mO0FuoK2R5s8=;
 b=JksHi8/1W036qm83kn3aOZCb319g9No8sRfOl8J2WdpnrsrnGcyNuRGTL3NoHwqaJk
 6nduulG1SpIvPZOZAEOrzve7xv97VJl74WA8xDP92JAkuM9ChiwW2ja+NBsok2P2NBRU
 KJZJ+SBeBQKKW1Jy52jiMvDtV41GH2EEpStCX3+SGE/2ZJCqmKuIpWGvPoMChQyWQGVU
 AxGYEJaiCdZmuyOqFJodSPu5vMTWdzWfYLrOiUIIZZLDYfUhAw3mTQMGj1sGTji6cLAu
 XOIc4oF3EFlIi9pfq2x5YKWB3zvuzRaeVZqMaO6cFhMcYLWdBWOrDa92Q4EFKFx+31EA
 Ox6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvlwuB+9xNvZFwfgig+VAhgRHQKxK/r1u24/q0qmuOcICFn2N7gFsJ/uyuT94hy4tuu8sUQw2rAwU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKq8qKg6qnDuqHp+cZ6GhYIn4cC1fXBbHvzegGjnfGEwDmx97Qu
 l7hdqocchXyQbZvy3a2S04hJ4Axd4DIR++2FrmZlsNyWkSO6q+5rtSo=
X-Gm-Gg: AYBFou1Dlh0rQZ65qE9uNZwEOzw3V2DtkKDiqRaxogCuzjD9ba+LiGa9ZKL3kUKuVi1
 TBr6IKD9LGc/5y81W8SwCyMNO2zvM/I+PKSS+jfkf9inclave1bvTlslgqb+6BR9CwftZTJrbd+
 aNenTsFXgyo5XrKnKfApqP4Oe0K1K34cE5gbJuiHf3xbaYfq9hRniAua8IFwKw8skVG0vDkfukQ
 3vhZazKVJRi1VJSIpF6HG20zWja4cjtqYarsXr+I94+r7dBvXhBkYJCjj2jTgEJsleaAi9ETZtY
 sgdlAfRKwKKklMcdbdcWwsaMOd5FZO64ouTxdg/4If2BKFAADbDjXzt0yeadUxc4Cz2xuLuXUhR
 dkZe4G2Jc+2TKkVTttdecZXOiG3w6oSx4DJT8fs/25HYymRgP6L+puNDNj+HuccSHVcFy8FdAyn
 /z4Az1SsInoZSU3J44LoR68SP0iVJtmQapAxJ2K2NMwjIR7iriCjAb0RPj1hvPwFIK1s346WvVD
 zcB0rl2NCBnyXMKbkpBBrJWhD7eBZMw018pEhZmtC7sJKZ+kFgG1b94hS059PK5JNq7Y4i9gU1m
 4Q9ehAcFKpBUdbM4+cyDXxC9Z9ueINd/rDMSiUQKmfrs+hy1HyqeCgHYVE61NpuQxhz6
X-Received: by 2002:a17:90b:268a:b0:3ab:b39f:41cd with SMTP id
 98e67ed59e1d1-3ae897ddd43mr857008a91.60.1793334563678; 
 Thu, 29 Oct 2026 21:29:23 -0700 (PDT)
Received: from freddie-kane.lan ([71.212.222.246])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8826a769sm606067a91.4.2026.10.29.21.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:29:23 -0700 (PDT)
From: Burke Cates <burke.cates@gmail.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/20] drm/msm/dp: Cache eDP link capabilities after
 successful discovery
Date: Thu, 29 Oct 2026 21:29:00 -0700
Message-ID: <20261030042912.2745609-1-burke.cates@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009-msm-dp-hdr10-v2-11-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-11-1835d4966da3@radxa.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09-Oct-26 11:16, Xilin Wu wrote:
> Discover eDP capabilities from connector detect before the first
> modeset.

I tested this patch on its own (not the rest of the series) on an ASUS
Zenbook A16 (UX3607OA, Snapdragon X2 Elite), on v7.3 plus out-of-tree
Glymur platform/board patches, which include other msm DP changes.

Without it, msm chose the eDP output bpp before the panel's link caps
had been read, so the first modeset after boot ran the 2880x1800@120
OLED at 18 bpp until a DPMS off/on. With this patch the first modeset
after boot comes up at 24 bpp, 4 lanes at HBR2, with no link-training
retries, on two boots of two different builds.

Tested-by: Burke Cates <burke.cates@gmail.com> # ASUS Zenbook A16 (UX3607OA)

AI coding assistants helped run these tests and draft this reply; the
results are from the hardware runs.

Thanks,
Burke
