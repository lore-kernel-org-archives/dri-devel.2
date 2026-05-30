Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCACDCD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 12:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A8210E2B9;
	Sat, 30 May 2026 12:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZfjMDRt8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001A710E2B9
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780143784;
 bh=RK9u4oBS3qnLrYtJPHH4F8C9MaGWD0ONvqdCmamdnlg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZfjMDRt8LCBfKQtx1vJR8HWPJ+gBEKcqvuDDuLfM23EmWtGj+KVGhyeoMrk2D7h7U
 dCpeYmCzPrOvKIW2ilABOn83xP9ee2MKEiLndYRPpo4pplIduVKpRxgyILqDab0vcG
 3bV6aAYtQ0HLRIWbguH+NPjBU8V6vFqeo8aTzuCvqXr4VT5vvVZ04N3ddf664cVbjQ
 iKXe8Vl4+lwr5mrdAPBirxKt+iStpy5i1pJP3iZkWpZQqp8gH4HJN3U3rZF5dSs3Pc
 qqywhtDR0fNmgmBrwXGvuZ3gzcVqWlmvUPuWKm7praAj3gvsHurAiuN+wVDal+rTBo
 klnoTGMyn3n3w==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6850C17E0246;
 Sat, 30 May 2026 14:23:03 +0200 (CEST)
Message-ID: <22488042-bfa7-4591-b071-8329a8ed0226@collabora.com>
Date: Sat, 30 May 2026 15:23:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Rockchip DRM use-after-free & null-ptr-deref fixes
To: Diederik de Haas <diederik@cknow-tech.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
 <DIVZ5UVI8BNH.2KC7WUNECAMZS@cknow-tech.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <DIVZ5UVI8BNH.2KC7WUNECAMZS@cknow-tech.com>
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

On 5/30/26 2:29 PM, Diederik de Haas wrote:
> On Sat May 30, 2026 at 1:26 PM CEST, Cristian Ciocaltea wrote:
>> The first three patches in the series are fixes for use-after-free &
>> null-ptr-deref related issues found in dw_dp and inno-hdmi Rockchip DRM
>> drivers.
>>
>> The following three patches provide a few minor improvements to dw_dp
>> and dw_hdmi_qp, while the remaining two address use-after-free and
>> memory allocation in DW DP core library.
> 
> What's the status of this patch set?

Just waiting to be reviewed/applied..

Regards,
Cristian
