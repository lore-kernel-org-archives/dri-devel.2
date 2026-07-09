Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED4EC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C38110F3D7;
	Thu,  9 Jul 2026 07:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="jnWY5Pvm";
	dkim-atps=neutral
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5DC10F3D7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1783581131;
 bh=wMMlPYy7nnXpVB6FvIeH87WDzCUQamWqEFmFsgEttos=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=jnWY5PvmrwVmHvDAq8v5sZp58U1L+Uo3Z0cNQWdTxisgiPq4khRVj/P1pohQyAf5p
 gqpwjcEt7OBYa7ChLMxNdp+WZWFjMCYgdEodNY2O0Zn6UHDQlkD6yIIF9JMc4qN8K2
 qxc1d1OVQ7sqTZsaVJUyYw1mgE6EPTLrWrq2BP1I=
X-QQ-mid: zesmtpgz6t1783581129t6844ee2f
X-QQ-Originating-IP: z+G+QLWqjlW2I2IbBBHbbVGoiBJyh6Msi3DKDcj+EiM=
Received: from [127.0.0.1] ( [61.154.14.86]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 09 Jul 2026 15:12:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2660938683507216801
Message-ID: <C19180EE3CEA14F2+991fd802-3b76-4805-8c2d-a15cd8417a13@airkyi.com>
Date: Thu, 9 Jul 2026 15:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] DSI Controller improvements for Rockchip platforms
To: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260603033532.164-1-kernel@airkyi.com>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20260603033532.164-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NjuDfT6zrIZc7HGFn6Y4r6ydJY+KSXEurk7aJJvtRix+Q3pcOm2UdHcP
 oJWmXeJj8KvYPiL+jlbohMkm691cKOXrBTJVKxwyHYZqjwpCHUvsTrpfFWNFpE754ZkDPFv
 ZkTpzRnwgnWU6aYHRkvJP7IsJtFQRRBBePd4eryY/KwoYcySgqfnIYLpo/SsRXuKGoouufR
 Ib2UZbbBmKyulpUHgkZcdP8fDBr8N/Ep1my1LoiNS7re15+QXYreKxQFOaMq499bEdFCNdq
 vFXA6L1no9CLSJjyvS1Bg4RM3b34WY67dlWVrhQiNid9LzD6Z/Kh3XTJyC4S7NoLelGjORV
 YlZ1n5BzpXZs9I+L3tvJMFSU9E36bij2T7hRcO9vDj9QluYZKEHgZlYtKq0Bo+uTe6ZnBKx
 QUp8cVZNgbFIctG2FQTk3GcsmfalC/b1vrDB5f2Dry2yryD5esBxTnSq2Nodgu0y49cJcA3
 zKkGKOJkkn8Urnvgrj11T3aP5jWRYO8P/9/aKpjPebPgNffRAA3CHLB7tVnLYN5peMNDEBy
 oER//DlRnO2sGq8CP6/p4yWi3AqoxPMx9gm8fvdbe182+egVk1O1aF5JvNHNdTKNxCxr03Q
 jsJrVJRTJ8NAm4YuVncihV6BhKdzVVNUjNNQ4hQcdJJ3y0NrRWT2GPDXiWO/UgnBlY6/Rwp
 /RC/Y82Q/26PpD5S7WnaKlvPgYyc6UK3Zmmy7XDWk7+hgZNsVhjZFSKUhmg+imjs2+2ske/
 TTwxEF6+SaNlg8O2XON0smH8sl3otpSZYzj7xpUWQ1csB0Cha+Z9hKgHc6uFnROx3OK2eTo
 gaMpD73qacWlPPjWgqnDJ1oNezoea4w/mL8TLOBNrChWg3MxL/HmnwNyk4SplMHf3IN1Wr7
 uvHA1j02dBYf/4ytyF/v7sk5SN6WQa1iR0A3KfNpc7/gQ1tVWjrGFe/mushoqt1dGjPv6+R
 JcavSKZ7HQloZYSk8LcuRZMU0VOVSBjH2OCHmo0H329t80VgjMKxQJHDPDiwAfgUFImDHDj
 pCGK4z7QV5YXZoSTgorDJDwDJBask=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

Hi all,

Gentle ping for this series, thanks.

On 6/3/2026 11:35 AM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This series is dedicated to enhancing the DSI controller and PHY timing
> interaction, refining the lane rate calculation, and addressing the
> associated hardware limitations.
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/all/20260324085838.90-1-kernel@airkyi.com/
> - Fix the unit conversion for max_mbps.
> - Split the lane rate calculation into a separate patch.
> - Add more comment about timing config.
> 
> Chaoyi Chen (3):
>   drm/rockchip: dsi: Add maximum per lane bit rate calculation
>   drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types
>   drm/rockchip: dsi: Relax the lane rate margin requirements
> 
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 66 +++++++++++++++++--
>  1 file changed, 60 insertions(+), 6 deletions(-)
> 

-- 
Best, 
Chaoyi


