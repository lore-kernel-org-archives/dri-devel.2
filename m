Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49C5C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79DD10EC14;
	Wed, 23 Sep 2026 09:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XvxsDhc6";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CA710EC14;
 Wed, 23 Sep 2026 09:54:30 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hqXPG62HMzMkr7;
 Wed, 23 Sep 2026 11:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790157266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNJQx7eG3HyvFQ0X0+FNFvV8AFm7jVjyATRQZ7QjHTw=;
 b=XvxsDhc6sDw6jWabjFnd7rqSASkwJCCSiyum0/HZmpONf/RR6qAw0RoMsDjXi++LHK59Tv
 9BpaDN5UqXUhgAF6ww8oO6sALQbqcjsH1xOCu/APUZpCtzpvmx9S6YLB28NUziOSEb6A6g
 2qw2Exsv9Q66x4Qtl18IxQ6kNp9/0QJztYuddLJZ6im/+9e2rfMgj4j3fWdyYLqYfMEnTS
 mVwgZ9L8vLDin/LbJ3YPyEXs6PPXLb15ll90PDhe2qwd9cdnRXZvfGHuTNro2Or923orFz
 7hewrAjOZO5jX7lK9NwMsmB8IavrCTgpIpF9FUVhDfimdykDuyqU89IX8p8MuQ==
Message-ID: <3b90b2c4-5acd-453b-8f9d-738370a52ddd@mailbox.org>
Date: Wed, 23 Sep 2026 11:54:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Content-Language: en-CA
In-Reply-To: <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11646ef09ad52a70421
X-MBO-RS-META: ds7zdfw7ac3mtbp1kbr9duz934e1srq6
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

On 9/23/26 11:51, Michel Dänzer wrote:
> 
> Either way, should these rules be enforced in drm_atomic_crtc_set_property?

Or rather in atomic_check.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
