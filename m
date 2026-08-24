Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F03C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2B710E73D;
	Mon, 24 Aug 2026 15:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bFpSLd6m";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C7110E73D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787584559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKvGLa80ZT9txpe0vw2U1X8sS6g8NCFrqzM4G1SwujA=;
 b=bFpSLd6maPmTcly4ZfaG/kwOWseEZF2aAcYa6zpkqpiLt3PKxtJJdVzafAkMJEFmQRPrnA
 SH8vmBA0ocxeoJkxQLXJtkycItCB0qvPZT6OnyicfwwQC0MY7myZdBPCNccbIFFQJPyHvF
 de0EnQKfZab85cgtoToyBo5YP/x02+E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Mj5oo-PCOsKCozrRli3ZQQ-1; Mon, 24 Aug 2026 11:15:57 -0400
X-MC-Unique: Mj5oo-PCOsKCozrRli3ZQQ-1
X-Mimecast-MFC-AGG-ID: Mj5oo-PCOsKCozrRli3ZQQ_1787584557
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-907b38aaad2so19365046d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584557; x=1788189357;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKvGLa80ZT9txpe0vw2U1X8sS6g8NCFrqzM4G1SwujA=;
 b=OTXB6eZO2COcZC/mqkqTe9mXQjU2MuQ5a9e4yTEfMag9O3jMDDOdgfoWYhaw6/KY4n
 9VvveFgNHE7p+W8xrlcK0fg2SeXaij1ZW/dVxWrECkW8orqmV7DuDrUKQ//rlq27+KOq
 ehnKEYC1Nu5dyGKGhAoy4u0gEZtC7MgSxZBfwVLnIqLdHZYlxihlTl6OMJo34hvlC0cI
 b+beGqpy+OnVwdsXzqc3+U24/O7EJkJGU4QoaZMl6SUGjFfLLuOA6FP+EBiFzLByMFki
 aK597BU9sGDfIhmTF/QvUXPh7f+rnpacgDdmk4Xf1AlQj5nagKhDACh/lkb62h5URRgn
 AIVw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4LF4FPtUrmSEcCCdXfoNuuFr9sd9iXR1ynxmUCG2AskVE59KqlMLA96yvqhBSKDGapy0quxgb1bo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6m2G1XfDTiaJI0ZT/XiKdRyB1jVe0lmFzO3MGNWfG7Qz+U7MT
 sD/Sx31PJcfHfmP+xeWRy/AKsWMy2Eknoi3gAe2eCUVXg+AR/8jfg10RkKa8VpM9xgBe2a3k1tj
 dHYwwi4BRpAiU9sj515I+BIKMea0tVnCjMbCEagCCNx1Y385prCCIiNoxs11QCwSJk4rMJw==
X-Gm-Gg: AR+sD13ytdLf7YqmY4WXG2kVAWX/hXqFaoaOM8vkaDnRBG6Pu3W9O6xYJkx6+jkZAxI
 o8chTxjPBK82v09Ly5hRQrJU//VHyVkZI6mCxah2sllaLd6ls0nJ9hK8L4n1lCwtXK4WuD33+r1
 DDKIyE5BYBcM7DGCmocblY6k44UszXpkiVisAKW2OrZ0NXj5izhCA3fkuOBebBlH+AGWf/UKzlI
 K90LPgxHzMbX6NgZ8XCWRRlZVYpeZ3+0lU4s+gP6LMK2ERSotUTfAhA9pWswEUmcOH/fdZzx1/w
 rtLLlxDRldv9iF5+euJds3yjL4dpW0EpywaPLtx/Bz0aJ14WE/u1vQISUAhuSkpBSPv9aQTgCTx
 qnQ9GGxPDdXTmOj3W7YT8rfmBVqZP0LxeuR8=
X-Received: by 2002:a05:6214:3c99:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90c80de23camr297867426d6.14.1787584556577; 
 Mon, 24 Aug 2026 08:15:56 -0700 (PDT)
X-Received: by 2002:a05:6214:3c99:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90c80de23camr297866236d6.14.1787584556058; 
 Mon, 24 Aug 2026 08:15:56 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c939314d2sm64503026d6.25.2026.08.24.08.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:15:55 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:15:54 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sun4i: Make sure clk_init_data is fully
 initialized
Message-ID: <aoxgKneyW6uUtrVs@redhat.com>
References: <cover.1787239944.git.geert+renesas@glider.be>
 <0f37278d04c02461e17f42032a379dccfb773171.1787239944.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <0f37278d04c02461e17f42032a379dccfb773171.1787239944.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4vGY7iGTzBo9aHJt3DKPqfoJIyMor4-oGvTfqDv9nBw_1787584557
X-Mimecast-Originator: redhat.com
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

On Fri, Aug 21, 2026 at 12:03:02PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

