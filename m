Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5160C43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCCC10E710;
	Mon, 29 Jun 2026 07:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U1kRkc6H";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DC910E65B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:22:49 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-37f7a5a217fso807439a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782670969; x=1783275769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0DQ9dWZ2koMQA8ywoE0uWtSaYihQ0LX5J4USq5K1Kc=;
 b=U1kRkc6HKtI+5Ue0H3R2yeFJrLkbkKhWyVZ7oHBhTRuNLhveuJXpRVZFJ6GqiN4i0l
 yNF+26mHXGYWsAOR96AAvApiaqw4L6n5jCdAf1oxevYFFP2WDsjsqGEy1yPtPc9n16hx
 RExfvdBMd9rC316oE3K6rhS+0olynmCZRgfp6opfNkBJJ+Cj0NULAPT7Wg/HTkLloJu0
 WHAZLC81OydxD2dV9ixpnug1vB3BKcspKSmcOmD3ClbNE1FXTF2mJ9pyu37x0Odlevk/
 tKtu1Kd/smWnmYgqzgCDusGq8zERsgk7yUm1Zm085iQT2okiNWL36iR0okK9LG21Zkff
 +ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782670969; x=1783275769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0DQ9dWZ2koMQA8ywoE0uWtSaYihQ0LX5J4USq5K1Kc=;
 b=PYgIlSlK093qhOtXa8sgdgR//35qPDYg1hoaFuTpLII3U0OLLDuFecjfb+x40iarKT
 lMspV3oAjfMO/DHK0WTSuZzxpDGny8YFOkXGgO+Mg2ofVgbVtR6s3Y4GPeHJJctjiClV
 Kewb+Bha8/QOMCgedzyEuamK6jqw//X5GKs95F12TSirbEy6nL00bqaTrcQbyUjUTbc/
 rca4qqca8BIIiq0woGxNlQF2Jg5mQyZLgN/c2MetBADm8Hi8kGZ2Wzwb0sI8Z7o1IYgi
 viAtuvTd6mWLWdYtKKGGvIdazKGy9E3zKchz4LJuWY7zaOD5vlpt8Iz0dy1jHLEAGCoi
 eh+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfLsx9USWiawEHFj7FFtHBG+Ayglv9xhVwrteQiPPNOjbAoC+Zr+f6Pp5J6tzK305IwBne4fgYz2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGhGVyQPUHO21tj9+nC16YYLyHR6NUTo1ENt2VNVTXFYWNIqIf
 J3QwrgA3YTJGKi76Il1Ft8f1ApXtrTsdJ4w7j/Sl5yrytOcSxak67AdA
X-Gm-Gg: AfdE7ckAOK2IZHrwWIJZYDv3WGAmIskEvRoSxmKwpwCy7MKQrIsYEr+j1srw1W0dgJ1
 ZawSMVX6FPSXmXIUTvwx8814YYnzqja+CX2+zcw0cJQV+yHeakFRh/I7ynxPmm5KTY+3O76Mmbl
 gH9f1uKqf7ohVfbNT8LWye7Nse1+hf/M/z2XBszdcQNbccM83EHdcESfDrViS7nhacJGCPFdFWg
 3C+chSRerwNox7kxfFmZ9RI1QTOat3NydWGR9inYGpcICf90Ujx3cPdAAObkDv5jAeWh4EqTiDg
 4JfMRFUa3av3Q6UY05oWz1ferE+LzuR4hlC0CCjtnJha11uaqgvJCcweDfWV5Zw+zmPGaioUvfH
 AdpKsLmnxs29RfI6nifAWNeh5hSoyVbOE5ykioKNeURYYVyRSpQyhKpeK9TSeBQULzI1e8NGD1x
 dbTU0F+TJtEi0h0FeP1hL1BqwVfzQiSvwx+7YpaVIvZuaID7nZQZmDfkfgHasUbP5AuHXrENpcO
 EJ0+NdQkfgMgj4hpmub0ORa+373Jl7ZWiHzUA==
X-Received: by 2002:a17:90a:da84:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-37fa9151d83mr6068848a91.19.1782670969047; 
 Sun, 28 Jun 2026 11:22:49 -0700 (PDT)
Received: from libra11 ([143.248.188.236]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37ffdc238c8sm781779a91.6.2026.06.28.11.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:22:48 -0700 (PDT)
From: SeungJong Ha <engineer.jjhama@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, acourbot@nvidia.com,
 dakr@kernel.org, rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 SeungJong Ha <engineer.jjhama@gmail.com>
Subject: Re: [PATCH RFC 4/4] gpu: nova-core: gsp: convert GspMem to zerocopy
 via the transmute bridge
Date: Sun, 28 Jun 2026 18:21:54 +0000
Message-ID: <20260628182154.712621-1-engineer.jjhama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628172200.B116D1F000E9@smtp.kernel.org>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
 <20260628172200.B116D1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

This is pre-existing and not changed by this patch: it only makes
explicit (via a checked `zerocopy` derive) what the previous `unsafe
impl transmute::{FromBytes, AsBytes}` already allowed implicitly -- the
layout is byte-identical and the message-handling path is untouched -- so
it neither introduces nor addresses this. I'm not familiar enough with
the GSP threat model to judge whether the TOCTOU is in scope here; if it
is worth noting, I can add a TODO comment near the affected reads.
