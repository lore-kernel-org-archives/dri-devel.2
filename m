Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C7ACD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA3B10E3E0;
	Mon, 25 May 2026 06:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JyLlgN3P";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7B410E095
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 20:15:37 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so55639215ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779567337; x=1780172137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63gsm4lozyWo/LQgbMDAJ2S7yKWjAOtV2E9hWx+OomM=;
 b=JyLlgN3PiS69JzGWZWsq5bQmk6ov1GyvqZygJkKL21rU/9ElRbXVRx+2GaQNANstWC
 41y8w+LPlTqZWx9liFqFkXj7iMddQ8WxBPvgN6B41Ldd20uE+nyxBEswM0uj5Vqsqr9U
 ZFNVOIuyiPyXKXRPD1/rJD812JFGp9VqbHXbOwPD+cylwxf6DEjVfqtT9t3+YhiM0uEY
 mbZyWd+ckZWMPHvVdsP0M9d6mxTII5RIJceIUV2ND5SUJzMgT2diqpeHrUTjyfzGbYgr
 yaVYzQsBMWdVzY8zOTuOTSqtZWBeEb0AWO8fOvx5kK8Dqp5BLSTMYjq9NrYl271+wvOZ
 99aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779567337; x=1780172137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63gsm4lozyWo/LQgbMDAJ2S7yKWjAOtV2E9hWx+OomM=;
 b=f1Fzgc7tAzblwxE5zyXv7NhL+c717FoDAGN2oxPwnfmTAjNyOXESDXDBtB+z4p93+J
 edox7UfIk4VSoU1s5I7ola3ovMpGztadeNZXEgNOX8mkqSKxKMEXpTcFdgb0NZhzbqnE
 b/3kmVJpJ+ATbokWAdaSBYzElog/+uvrNZzaPMBfWnnOEhhgTswClZjp9at8/7lHWVeb
 mckq7mZSW8ppW+MW8UuS/f3VrpSgTSYc8rjkmPpLp4vs5TiMnnemUkImWQBA1t8RZXNg
 wjxoZhNjNKP9V49pSdY1WaoCxq7wK8ThoYVCdHpoik9e8IHEpEqdtZdE+WjeeeK3kQPm
 nVGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QujAlbK5dfUx1c/UwjSmbzAf24GD0Lc4Y2QDawSL0GMJ+Z1smJeFd/semXLhjSlOVuOpuNorB4WQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfofVi3DRfxLMC8XxvuYJI3cjLSOMJZm4Jm5wjAI8usWE4c6l5
 VbhMFWfeAhl8owoKFjJCpR02QZNN2Ix15hGlmHr1FvoZpmcvV4HYyuPa
X-Gm-Gg: Acq92OH0ItaCmr6wLZ2LoM504hEqU5diLDHvnccEWabbU0Fm6w2H9eLdPswhw/ekCji
 LxSePbyNDPtbdvC5NrwR50Ih3JPk9ckMiyYBEkogOHSYINkxrI60NFnBqua1CI2dqy8pHBIDYgk
 ASMXaoNAXn98rI+ESU/ErWvvP4u8S1V+Hl99yy/lnxMfv3Hu8r4NWkaDtMqmYB8DFWkUktWWYNq
 16AWYVxdVJ0aH3nAG/mYzCBb6IgKS1i8ZKi7B58ge0/nh6Cyjr8Rt1bl9n/2XMmNDZ8YvqDkXoW
 UvQ4D0vLpraSUwj95WEdHoc/GrgfRHRRyk3YMYvMF2pK9BVEUt21J3ZhRtDjmLPrtlH+/OAxnDM
 v+LV0dxyEv9wdT0AmgNZAL2ZdZoBZhpKuyTV9U2d/AFMeDke1aUT9LiaP9HtxVarJzaChoKagat
 h7amQcPTDH18dPs5dVsvhAZDyHW4OABbEECePuKcSo/4c1zhcxsDBA450nLkoTpyRdnOTFeHdyi
 kL3rOXaCBrkJdlHhxRqPFjTVTYDoJbr8h57xuErpaDzf2GBxkXQIUwAM1Qzceenniks+KwQRO0u
 Rtst1ZgOoUo=
X-Received: by 2002:a17:902:cf08:b0:2b7:aa20:3c61 with SMTP id
 d9443c01a7336-2beb083ee1fmr89812565ad.33.1779567337013; 
 Sat, 23 May 2026 13:15:37 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695a40sm47957545ad.17.2026.05.23.13.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 13:15:36 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/ethosu: fix OOB write in
 ethosu_gem_cmdstream_copy_and_validate()
Date: Sat, 23 May 2026 20:14:44 +0000
Message-ID: <20260523201444.66197-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523190843.33977-1-meatuni001@gmail.com>
References: <20260523190843.33977-1-meatuni001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

While reviewing the command stream parser further, I noticed that
weight[1..3] and scale[1] have their base and length parsed but no
corresponding WEIGHT1_REGION/SCALE1_REGION commands exist in the UAPI.
After cmd_state_init() memsets the state to 0xff, their .region field
stays 0xff and is never assigned, so calc_sizes() never updates
region_size[] with their extents.

The job submission in ethosu_job.c validates region_size[i] <= gem->size,
but since secondary weights never wrote into region_size[], a userspace
caller could supply large base+length values for weight[1..3] or scale[1]
that exceed the GEM buffer without the kernel catching it.

Does the hardware specification guarantee that weight[1..3] and scale[1]
are always sub-offsets within weight[0]'s region, or can they reference
memory independently? If the latter, should their extents be validated
against region_size[weight[0].region] in calc_sizes()?

Muhammad Bilal
