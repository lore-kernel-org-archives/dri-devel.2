Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C19C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11F710EDDE;
	Thu, 30 Jul 2026 07:19:58 +0000 (UTC)
Received: from mail-gw-fk003.vdone.jp (mail-gw-fk003.vdone.jp
 [160.251.152.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008F610E0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:39:39 +0000 (UTC)
Received: from mail-gw-fk003.vdone.jp (localhost.localdomain [127.0.0.1])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTP id 7DB20401449D0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:39:38 +0900 (JST)
Received: from e3.valueserver.jp (e3.valueserver.jp [157.7.184.13])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTPS id 5F65440191736
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:39:36 +0900 (JST)
Received: (qmail 514985 invoked by uid 89); 30 Jul 2026 12:39:36 +0900
Received: from p1706034-ipxg06601niigatani.niigata.ocn.ne.jp (HELO
 ?192.168.1.120?) (jack@supremeoverlordjabs.co)
 by e3.valueserver.jp with ESMTPSA (TLS_AES_128_GCM_SHA256 encrypted,
 authenticated); 30 Jul 2026 12:39:36 +0900
Message-ID: <7b6b347d-f5d9-45fe-8255-27e01f23578c@supremeoverlordjabs.co>
Date: Thu, 30 Jul 2026 12:39:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: give rk3576 VP2 a primary plane
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Sandy Huang
 <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
 <24547ed2-0950-48be-92cb-bbb0e1653258@rock-chips.com>
Content-Language: en-US
From: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
In-Reply-To: <24547ed2-0950-48be-92cb-bbb0e1653258@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

On 2026/07/30 10:56, Chaoyi Chen wrote:
 > The description here is not accurate. VP2 can wire to different
 > display interfaces which depending on your board configuration.

You're right, thanks. VP2 isn't tied to DP - the VP-to-interface
routing is board/DT dependent. The actual issue is the plane topology:
on rk3576 the two Cluster windows (the only DRM_PLANE_TYPE_PRIMARY
windows) both have possible_vp_mask = BIT(0) | BIT(1), so they can only
attach to VP0/VP1. VP2's only attachable windows are the Esmart ones,
which are all DRM_PLANE_TYPE_OVERLAY. So whenever a board's DT wires any
output to video_port2, vop2_create_crtcs() finds no primary plane for it
and fails with -ENOENT ("no primary plane for vp 2").

I'll reword the commit message accordingly (dropping the DP framing) in
a v2. Does the fix itself - promoting Esmart0 to PRIMARY - look
acceptable, or would you prefer a different window or a driver-side
approach for VP2's primary?

