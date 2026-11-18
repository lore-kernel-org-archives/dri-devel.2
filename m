Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmSWIevG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4546510FE06;
	Thu, 19 Nov 2026 07:53:04 +0000 (UTC)
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A2E10E541
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:50:28 +0000 (UTC)
Received: by mail-pj2-f6.google.com with SMTP id
 d9443c01a7336-2ee1c8e6fecso3367725ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795017028; x=1795621828; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4lLupD4z98CK9UrD3eQfsjdZUJgyZTecsH4A98HzZRA=;
 b=xmSWIevGb5Bca8hJafTR5bMCRG+EPY6srTjnFN4W2ZjAHpANVrhF44RF0/ezIclphB
 r71GOqTYTgOA3vSslj3h22qXwHbGLvtPzQZnxq9hRVMRg20c6EzVIOeBVoLI6fncguXf
 ZDGEXJ9nlrBZVpEheAevPBroNym0UbnjwNsqF8AVOk25aj2TJVfHhDK33QpxgTmpFrNK
 Y8+fIKed8DfRo0bn7+Tm96U28ou4NRLhsyX8M2W5tck3tUspknsUF7vovMMRXQJMSF5r
 yjkEaB2BpH+5eERrkGQKUgeRxCNf823rozMUW4jl0hu5aTRyXw+uE1L/8YIYX3+H6SxJ
 JSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017028; x=1795621828;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4lLupD4z98CK9UrD3eQfsjdZUJgyZTecsH4A98HzZRA=;
 b=z90HXTIOITbWBLw1YFbiIV7suy1oXEaYpmmYYrxvb/bIaSMp5gfeJpESf46dzMyP8C
 9SB9g617doevX78kWmFX0K9Hn2caNlFVDIhqEmj66vGlKYBICBibc8vQjXcWwe71dB5e
 ik7o8gKkLg54gDJY+jO1ULaEQzIfRb9HgPTEVQnBCqLCcZGDQR7RQCcBH+zZdKA4VRPz
 tvXNCWOyfaby1tduqpl8wAm3/upur783eA4bHiMIe5WaFchBE85MKBupA5JSP4lkPXaS
 q7MxR+OPbzXESXD+MNYW/zlesKXlaa7wAfGb4iONsvYTQX/rFeHdZilSG5v2gqpLsgQI
 WYrA==
X-Forwarded-Encrypted: i=1;
 AL+hErE5SoIqX8Ux2VbrRA5LLHCBhrb+HFVpcKV1/D4qdOzzNa51vAG1gT1EQC8AuL8IMl6TLD4r6O0rnio=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mxKA5/7phLxWhYDXI0rwEGTArL17hEZqr2r8sXlLtRzDcLzLF
 TwFgGZPK7vdzI/4V65gnPwNU0ZEO1BzJQb4uhfHOcuqC8iHprbwbTkW6
X-Gm-Gg: AZFdTZe+enPIU91hJs0LY6VeTabfYAI4hz34UmBkBvv42wGmMXJXNEg4ZmSB3kGu7gp
 q2ffwAYofJ7O7UnD6cp3yfrxaDnurDdKXx2yYld+HyRwufAi3J0dLOE+TMKtY4oypSLjYX0Jyuu
 O+iU9BSa2wEFrDQGjWF1JIFbTE13+c84aYiBk3pdqKBnvzHczaTmb7Gmfw/Va/xCNWU3J9sf0pD
 /0Xv4XeL0jDYKjQr3OLP0OxuQqbkKVIkjFBOoB/aUMaZw/ozSHGBkVRyrVmD2uR31750SnbWAMy
 rr1otEGt9okz1rsdOUxuScP13M+MPNEE2gziqGKnOwqwLnfwJRC/MD4ILFKpGg67nLTU85HoHpq
 nfNB+JZkkxD5aZklxQXAyNR96kc9QmZymg2gsmbPoqHf8xBhocTlEmYVmOIRbHO+0/t8pzf+4MX
 R1eb1y9MvbQhd8wB0UsdaK6SyN1Lu7LcfaPl71JBIJrsf4ttghz2ED2x990qPOB16nusJLupnmY
 Meny1Qk2SWym7fQZDNnQFnC11VyHhbc6i4oi1l6NCVFpWXVpoc+9dSyFcI3UGmi4wYEEhvs1tA4
 jqE=
X-Received: by 2002:a17:90a:dfcf:b0:3ac:9d14:feb1 with SMTP id
 98e67ed59e1d1-3b3d07c9ca5mr3201351a91.43.1795017027692; 
 Wed, 18 Nov 2026 07:50:27 -0800 (PST)
Received: from localhost ([2403:2c80:6::107b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde534ae0edsm193214a12.21.2026.11.18.07.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:50:27 -0800 (PST)
Date: Wed, 18 Nov 2026 23:50:21 +0800
Message-ID: <aee275aa2ebf093d8518e53c5d264064.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guodong Xu <docular.xu@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
In-Reply-To: <e492222feabaa5c72229c93ce75f9500e4346da1.camel@icenowy.me>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
 <e492222feabaa5c72229c93ce75f9500e4346da1.camel@icenowy.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:53:02 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Icenowy,

On Thu, 03 Sep 2026 20:07:32 +0800, Icenowy Zheng wrote:
> 在 2026-08-09日的 21:14 +0800，Cody Kang via B4 Relay写道：
> > From: Cody Kang <codykang.hk@gmail.com>
[...]
> > +	drm->mode_config.min_width = 1;
> > +	drm->mode_config.min_height = 1;
> > +	/* K3 user manual: each DPU scans out at most 3840x2160@60
> > */
> > +	drm->mode_config.max_width = 3840;
> > +	drm->mode_config.max_height = 2160;
>
> This is for the biggest possible framebuffer instead of the possible
> scanout pixel count.
>
> The width here should be based on the maximum allowed pitch of the
> display controller instead of the single-GPU maximum size, otherwise it
> won't be able to drive two 3840x2160 screens in a side-by-side
> configuration because this will create a 7680x2160 framebuffer.

Thanks for the review. Agreed; will fix in v3.

v3 will take max_width/max_height from what the RDMA registers can
address (a 16-bit byte stride and 16-bit image dimensions), and move
the 3840x2160 limit into the CRTC's mode_valid.

Cody
