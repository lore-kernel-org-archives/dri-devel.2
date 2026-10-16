Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE73CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B011A10E013;
	Fri, 16 Oct 2026 09:32:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E5C10E013
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792143130;
 bh=moPz88+BKWBqA4wI7xIuez0SP9HnxmGxxTZhvQgnrkg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YIo6r9hxhFdJT3RrNKDuNtNzXUdaXGjT3OnP1EjcSV2F+72R81qKdDcWOI8EJMa5U
 rNd/kVnzkOtJH+4YRo/n6AbnZOUFidnbDWMg+vvzdxxwB4I2G7bVmnRXvxMgB+01GH
 f5Cwnd4quCNpNHy02cGSb1D6qXI+OWr/HI/rvwZcL40rTkoYBaC75L/ClppvoZwRz0
 wgRklWA+/OVTuPvIFGHXpss+v0lw5hgqTYul/fiRM7KEAcsmLEV0hnGFafCq8aZO3B
 bB0Zo8nztfOKGMed7xAGqY1CghsWoR5g9EmvQm1gIlqox+itGdBwksHoAqO2UUk8sM
 lI2cRJR+MB/tA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 353B617E0411;
 Fri, 16 Oct 2026 11:32:10 +0200 (CEST)
Message-ID: <aa6ba0bc-38a7-4c24-965c-a7660c05eb3e@collabora.com>
Date: Fri, 16 Oct 2026 12:32:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm: devm_drm_bridge_alloc() conversion and cleanup
To: Johan Jonker <jbx6244@yandex.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Huseyin BIYIK <boogiepop@gmx.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
 <179213353665.3058528.14437637653539699061.b4-ty@b4>
 <d1f0369c-ff43-4b76-9092-5c638b132f15@yandex.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <d1f0369c-ff43-4b76-9092-5c638b132f15@yandex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Johan,

On 10/16/26 11:11 AM, Johan Jonker wrote:
> Hi,
> 
> If any decency or Code of Conduct left in the DRM group then also credit the original author.

Sadly I wasn't aware of the indicated submission - this was just an unfortunate
overlap.  My series stems from the following discussion:

https://lore.kernel.org/all/743283af-753a-40bb-96f3-d05b1e38e186@collabora.com/

Regards,
Cristian
