Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AEDF30295
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 02:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FFA10E04A;
	Mon, 16 Mar 2026 02:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Cy9WSrpN";
	dkim-atps=neutral
Received: from mail-m1973185.qiye.163.com (mail-m1973185.qiye.163.com
 [220.197.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D90B10E04A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 02:45:58 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 37099b5a3;
 Mon, 16 Mar 2026 10:45:51 +0800 (GMT+08:00)
Message-ID: <a60a6435-ee62-4788-8dbe-85cce13f2d69@rock-chips.com>
Date: Mon, 16 Mar 2026 10:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/18] drm/bridge: analogix_dp: Remove unnecessary
 &analogix_dp_device.connector
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, alim.akhtar@samsung.com,
 jingoohan1@gmail.com, p.zabel@pengutronix.de, hjc@rock-chips.com,
 heiko@sntech.de, andy.yan@rock-chips.com, dmitry.baryshkov@oss.qualcomm.com,
 dianders@chromium.org, m.szyprowski@samsung.com, jani.nikula@intel.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20260310012458.169272-1-damon.ding@rock-chips.com>
 <20260310012458.169272-13-damon.ding@rock-chips.com>
 <DH1TLZT5696T.2XAQIND6F9YS3@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DH1TLZT5696T.2XAQIND6F9YS3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cf489172b03a3kunmea86f0cd190659
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1JH1YaGUNDSEJCTk0eGBhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Cy9WSrpN8R7G3q+DpLjNtJcxR9Rfmh/Uw9G/ysOtP84TmMj/x6CzlL9UeA6hPyGqz/TzXs6Y4L32fWY23llQHRqZ9CIz7GHJSV2gfREmMNFDEkOgCZmGwbsqBld4AEmsv24+Wk+fnoEsY5oPxYEI21QfSNHI4bNxhYPZeLCtxdg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=hG5rWW1tvZoHBRwfgexg2zqSAF2tcsPwI8XnBrBCp6Y=;
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

On 3/14/2026 1:12 AM, Luca Ceresoli wrote:
> On Tue Mar 10, 2026 at 2:24 AM CET, Damon Ding wrote:
>> After adapting to the bridge connector framework, the private
>> drm_connector is no longer required.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> This should be folded in the previous patch, where all usages of this field
> are removed.
> 

Will fix in v11.

Best regards,
Damon

