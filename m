Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098E105D991
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 01:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A780910E4FB;
	Wed,  8 Apr 2026 01:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hd1vd4jp";
	dkim-atps=neutral
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com
 [220.197.32.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2F310E4F9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 01:38:09 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 39de7d730;
 Wed, 8 Apr 2026 09:38:04 +0800 (GMT+08:00)
Message-ID: <ee5ba5ac-3d33-4542-9abe-6d3e0d1e1d76@rock-chips.com>
Date: Wed, 8 Apr 2026 09:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/17] drm/bridge: Move legacy bridge driver out of
 imx directory for multi-platform use
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, victor.liu@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, jingoohan1@gmail.com,
 p.zabel@pengutronix.de, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
 alim.akhtar@samsung.com, dmitry.baryshkov@oss.qualcomm.com,
 nicolas.frattaroli@collabora.com, dianders@chromium.org,
 m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260401091454.25730-1-damon.ding@rock-chips.com>
 <20260401091454.25730-3-damon.ding@rock-chips.com>
 <DHMXIJKO62F2.3JVF0Y6L7DI0I@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DHMXIJKO62F2.3JVF0Y6L7DI0I@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9d6abd4cba03a3kunm02c5d4f5311355
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpPHlYYHRlKTUpCHhgfQh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Hd1vd4jplB+V/AGhFIiROBjwtKrMDwt728WjZzN6yYhQVzxRFstEyjBi+BZCN7a3A9WPY14JeUCdNIV1oAUbaRqlm8laee1Ct43HI8Qk8JgjcXcj8lEZANU5MrrEtuUzkx6Q/u83DBAb598knymj5BynVPjfQ7ffVnmecTsaW6E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=500nTzOsPEHbmmnZSC4nbTuUuD8MTS9l045tiv5dYA4=;
 h=date:mime-version:subject:message-id:from;
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

Hi Luca,

On 4/7/2026 8:41 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Wed Apr 1, 2026 at 11:14 AM CEST, Damon Ding wrote:
>> As suggested by Dmitry, the DRM legacy bridge driver can be pulled
>> out of imx/ subdir for multi-platform use. The driver is also renamed
>> to make it more generic and suitable for platforms other than i.MX.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de> (on rk3588)
> 
> I tried applying patchs 1-9 to drm-misc-next but patch 2 does not apply due
> to conflicts in the Kconfig file. Can you please rebase and send a new
> iteration?
> 
> 

Sure, will rebase and send a new version soon.

Best regards,
Damon

