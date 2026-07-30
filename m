Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D56C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF3810E0E8;
	Thu, 30 Jul 2026 03:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="InTrd8rE";
	dkim-atps=neutral
Received: from mail-m103131191108.xmail.ntesmail.com
 (mail-m103131191108.xmail.ntesmail.com [103.131.191.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25DF10E0E8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:49:07 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 481d48273;
 Thu, 30 Jul 2026 11:49:02 +0800 (GMT+08:00)
Message-ID: <a791f935-1634-4e21-966d-6d75bec87566@rock-chips.com>
Date: Thu, 30 Jul 2026 11:49:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: give rk3576 VP2 a primary plane
To: Tomonori Nakagawa <jack@supremeoverlordjabs.co>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
 <24547ed2-0950-48be-92cb-bbb0e1653258@rock-chips.com>
 <7b6b347d-f5d9-45fe-8255-27e01f23578c@supremeoverlordjabs.co>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <7b6b347d-f5d9-45fe-8255-27e01f23578c@supremeoverlordjabs.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fb123d26603a7kunme747ba0b4a4eb8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHk4fVktLHRlCGk1CGE5KGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=InTrd8rEXIAzz/o+tE2MmWAT/BagpE1/UvSTJclh6647mKFu5oSGVEKDY5NX9PrMvKoT1W+RcFFCT1rV820atajhNjkP/W3Qsyp55Xzod5LJQWw3w0jlzGbVn/UTkubXh6i+mc6r7HZGPQcQMoQ/uRJPL9XCToxlvFGQcTHNbwM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=X7Mux6FE7z9fKIoWpY6C8S3xx1B7JjI8DMShzGceysM=;
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

On 7/30/2026 11:39 AM, Tomonori Nakagawa wrote:
> On 2026/07/30 10:56, Chaoyi Chen wrote:
>> The description here is not accurate. VP2 can wire to different
>> display interfaces which depending on your board configuration.
> 
> You're right, thanks. VP2 isn't tied to DP - the VP-to-interface
> routing is board/DT dependent. The actual issue is the plane topology:
> on rk3576 the two Cluster windows (the only DRM_PLANE_TYPE_PRIMARY
> windows) both have possible_vp_mask = BIT(0) | BIT(1), so they can only
> attach to VP0/VP1. VP2's only attachable windows are the Esmart ones,
> which are all DRM_PLANE_TYPE_OVERLAY. So whenever a board's DT wires any
> output to video_port2, vop2_create_crtcs() finds no primary plane for it
> and fails with -ENOENT ("no primary plane for vp 2").
> 
> I'll reword the commit message accordingly (dropping the DP framing) in
> a v2. Does the fix itself - promoting Esmart0 to PRIMARY - look
> acceptable, or would you prefer a different window or a driver-side
> approach for VP2's primary?
> 
> 
> 

No, it looks good to me. Let's see if anyone else has any opinions.

-- 
Best, 
Chaoyi

