Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D7C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800FE10E548;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iq371aHY";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7C310E36F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:21:38 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so4116038a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787034098; x=1787638898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yLs/RlrXlKm3gliodn6KiIGRLWy/mBk6EHfck2hwzM0=;
 b=Iq371aHYmRCGdYBHwnzD7A+ywxSPrx7nqAqnFSKJIqKppgAZAswNv605a38lNzPMgv
 KtFUP/sVDLvvogq79ldaUKevlLBJVy+Jc9srHLL2LRcvcvAOIy/0SUJbDRwsM2BYSSXH
 08a5Af0wmnOCR/onPRBGtuz+D2W3KzkoBy3tAVHmJv+RHyX5YkQXYkjB5xP5BiFBQmOH
 QWUZrbf2EHj+ARt/9TWKopqq6GRUuwcKlsLrC+KRHwsJayjWpyMmZ43RvwERdG25QcYL
 6VazXYn/aVdZcMzRcrIju1sOMpNxQYdyO72sniEh/jTGa633inZ3GOlSNfLS+PexqHV2
 HkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787034098; x=1787638898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yLs/RlrXlKm3gliodn6KiIGRLWy/mBk6EHfck2hwzM0=;
 b=Eocr8CTByrxQXlBHXJJcHYLWUWfAtW5Irjz4cmKSUl5tdFZNT4SC6VcSpTv292Mtgh
 nkXCGEiZqP/lXgpQtTKmoIfYXQ20vdpH9reie7b5w9atLDVlPd4xQ4UCa1NCmNEGPX0g
 w645gMWFLizIytQO2n+H0NMYlv5jH8ws3PPPBLPUs7GICgNqr7nUWX/Vy2Ngi+0G6Vbs
 z6eQqRuzIrITa9tO/s/g7NaetwbqcNs3TIolmuB9dJjwxEsKGUn6MO+Y27u71NeoditA
 Mliy9+tAisaGppiZtHO3yC1GJLhYI7NhOP9zpfBi0K/aXYL7PM1c7I7tawT48D41v1EV
 Kgow==
X-Gm-Message-State: AOJu0YxRFmzS7s7EvVSBpa1Ej3bEmsHrvbXryhT2MpP2m6BrAkP6kl6l
 UFUltLT0HXncijxmmUTbNVezaBumR0R7vBryvkDE8pTMe4ti+HSR7Zo=
X-Gm-Gg: AR+sD12Ia05SeHrVrdGfEEKqExu9BjhiFNGmOlwkBGFYZaoULUcvT/IvlqdcLy8ZkWZ
 kbBb5eoJMAdZMdbaV8d3jGpV332+Sja1nnbwATilSrFfRsmiroih/4FLwtQAPoUh28FpoBFy7SL
 O6eka2v8hQWQJyuELijk0yO3DWZMKhe+rKmKN160LGP4V9nkvMZD3hYkg8QUjqGMcq9HDP9TrVa
 zdkOqMhXTh+arwdf34iMtpZQv5lKA6LAKDE9AX4K1iA6CKm/PDnlts51YBATkg2c/omJr47iiaY
 Bu1l63gB6mQMcrqdaDuBIKafMyXi08OEN1FRCiOkp3jCxAzvtodVEvtKdSBQhj0UCQdE5SF0ddH
 nsDRPCCtvXYoV1HK/5XEYuXdnN/Kaf49iEqjS0q9lWtJ6eo8i0b+bbGrs/QADGLfejbt63tCJSK
 gQA4BAiP1UzuaZLWoeT+oISwfG/KT6qBWW1zPfOnBsAuUsh+D4vtLffYrd2ysKaNTVquIru8fSr
 nwEYCpxdYFU
X-Received: by 2002:a17:90b:3b84:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3955a3dae07mr4907995a91.4.1787034098391; 
 Mon, 17 Aug 2026 23:21:38 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2b85b1sm4859020a91.2.2026.08.17.23.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 23:21:38 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: markus.elfring@web.de
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, ogabbay@kernel.org, royalnet026@gmail.com,
 tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: Re: [PATCH] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 13:21:34 +0700
Message-ID: <20260818062134.1634572-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <67dc50c5-19ab-4612-857b-59d6a850f76b@web.de>
References: <67dc50c5-19ab-4612-857b-59d6a850f76b@web.de>
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

> > There are programming interfaces supported to some degree
> for the application of scope-based resource management.
> https://elixir.bootlin.com/linux/v7.2-rc7/source/include/linux/cleanup.h#L10
> 
> Would you like to take any adjustment possibilities better into account accordingly?

Thanks for explaining. I am happy to continue working on this, but I think
this would be more of a refactoring to use the new API than a bug fix.
Furthermore, I don't have much experience with the new cleanup API yet, so
I think it would be better to consider this as a separate change in the
future, after these patches have been reviewed and I have gained more
experience with the new API.

Anyway, thanks for suggesting this. I'll take a look at it and keep it in
mind for future changes.

Regards,
Triet
