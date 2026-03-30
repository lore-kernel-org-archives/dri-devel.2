Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51E8FF60DB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9798B10E894;
	Tue, 31 Mar 2026 07:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hw5xU9tO";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AF010E805
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:19:10 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so1401092a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774905550; x=1775510350;
 darn=lists.freedesktop.org; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kjSx54bMkrLLfgzdPU0y1PUqW6GqciS0yWj8IpjRMAE=;
 b=hw5xU9tOPTv7cmHjh5ITtuKmHW2SB7BKM59c+WKFqYOUD6JrxjXh4c4c/hS65lQkSR
 gi2Hmpi7bjfFRTE2iy8d5hnqagt4WoYm2YgTKQq9WUmP/fDYSOePfsn9DL3NIrZobAUW
 XyLLkaP3rTGN4Hzc+BAwOCm9Q08LlgWI8zvnJ/9leaLXyhVcZWKcMEKcuv6KtH1sxAzv
 wy9pEcfxKdhDQ4dwovmu+pCQY6wQVTBxw3YaG46Y2DySzr7/bi5korOwGZ2KcozGnWMP
 cXTdqGSa6fyS0qdMXUWEMZYppkud6gy9ylUm9Coc48k8G3l5AGPA52ANUr+L+1jsADm6
 18lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774905550; x=1775510350;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjSx54bMkrLLfgzdPU0y1PUqW6GqciS0yWj8IpjRMAE=;
 b=a2Mc05veeNhbYNuvrDVERMdC30oEbf/qZY3rS7uaC3uQDrbNsjgCqWb3hx84SHDaQS
 MQtZ0sdrask5GDkPod3p+AhZ3enM1WMput2wCrATd+bNW5oxGhujVEfpZUp0IJjxkfAK
 j6JjxrvSD0uiqObAZgVBwngUPViVNKy0X1Vwy87GCDojGiPmfSP8BxUSQ9XUw7MlxKSq
 GkAtyFp6JorI1kyHh1zgWgQhcr7ELhFqPsCZg+dXiunWQHh/oWhMPqadpIkAeyGie+l9
 f0uc9C+TwFL0U7fvTGYow5zKM2E150mPv5itqycEygaZXiJSYgAOyiIwu/txlbaPBVfv
 Djaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQjPn7cqRSQYE7GLExY4Vsvxu9wa/uEpgOEPvfZ8Y61kX6nU6RaVSPZzYNbEVunkHK0JQTRevoZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2qKdb6jKi/ZcIQrNMCmPS+3Il4AQTdzdggLujDp/mdB7cNhB7
 Cl2MQJbPbPMWC2AQbStWPHVegFyeHDhHnSBSC6BCTUMt3+jR50QzP7yEEmyrQ/Sg74g=
X-Gm-Gg: ATEYQzzoJrEzLiLcP/P0drsElyH0kVWQugYt+5FbrhTOWXw1iUiMle/ArwEInX/AeOy
 1EBHXchA5P93/rZ+G0GDP1dsjz1UgHm0AQiVGwgMmo06Xwq9IoZ7JU8GnXB4CJhUPVd294/ELxT
 GRo9AcPckVpKhFosYTaPYko1+k8BnoAuDn8jePWJ9QZbCkM834O367frxsSR1e740LNG3wNH1kf
 +3KiUEvFQ3Yj4/fsRP+QrukYcPC5Ca5DfYZ9Dtynt0iUT9lAIaxRLCpYKpf2Tiv8vcZoCPvFgrp
 8vOB9nRnJRyg5rH+fiBok5W9XKSzO/8ee3FhfA4xkBZICov0ZkSZYrJc4PNpB+rfT6ZC7ChtHri
 Qdw9QWoDzlUcVPAmIlh596hEmDE7FAqLK4KedmcfWAmU9gPlUJCxB3S5sfPPX8rh17xBeX/oIFD
 pPoC5tXs1/cYu4C4022+M=
X-Received: by 2002:a17:90b:1a8c:b0:35b:9aaf:21c2 with SMTP id
 98e67ed59e1d1-35c3000d679mr12293717a91.13.1774905549876; 
 Mon, 30 Mar 2026 14:19:09 -0700 (PDT)
Received: from localhost ([97.126.187.42]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d950b5583sm7943123a91.14.2026.03.30.14.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 14:19:09 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, aaro.koskinen@iki.fi,
 airlied@gmail.com, andreas@kemnade.info, conor+dt@kernel.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, krzk+dt@kernel.org,
 laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jesszhan0024@gmail.com, rfoss@kernel.org, robh@kernel.org,
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com,
 tony@atomide.com, tzimmermann@suse.de, andrzej.hajda@intel.com, Mithil
 Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/8] Initial support for Samsung Galaxy Tab
 2 series
In-Reply-To: <177451576215.103892.12129135091369769725.b4-ty@linaro.org>
References: <20260303203017.511-1-bavishimithil@gmail.com>
 <177451576215.103892.12129135091369769725.b4-ty@linaro.org>
Date: Mon, 30 Mar 2026 14:19:09 -0700
Message-ID: <7hzf3puib6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

Hi Neil,

Neil Armstrong <neil.armstrong@linaro.org> writes:

> Hi,
>
> On Tue, 03 Mar 2026 15:30:09 -0500, Mithil Bavishi wrote:
>> This series adds initial support for the Samsung Galaxy Tab 2
>> (samsung-espresso7/10) series of devices. It adds support for 6 variants
>> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
>> based on 3G and WiFi, but since they use different panel, touch
>> controllers, batteries, I decided to categorise them based on screen
>> size as espresso7 and espresso10.
>> 
>> [...]
>
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
>
> [4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d37690b5e02418a2365548300628ef3895a24ed2

Since the bindings patch already had acks from the DT maintainers, I
queued it along with the DT patches (via the OMAP tree.)

Do you prefer if I drop my version?

Kevin
