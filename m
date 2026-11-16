Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE902606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=CjC+uwo8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566E5891BA;
	Mon, 16 Nov 2026 09:32:06 +0000 (UTC)
Received: from mail-m1018.netease.com (mail-m1018.netease.com [154.81.10.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A21210E3AE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:31:59 +0000 (UTC)
Received: from [172.16.12.90] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54d4748f7;
 Mon, 16 Nov 2026 17:31:54 +0800 (GMT+08:00)
Message-ID: <9f3252b6-7f60-449b-bd69-23edf2616f04@rock-chips.com>
Date: Mon, 16 Nov 2026 17:31:53 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add two reviewers to the Rockchip DRM entry
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com, andyshrk@163.com,
 damon.ding@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
References: <20261110101554.1809467-1-heiko@sntech.de>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261110101554.1809467-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e3b2e68103a7kunmaed757ed40d12b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0NIS1ZNSh8fSh4fTR
 5DHUhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=CjC+uwo8Rwy8hZKTdryKZwzTX989KQ+E8N+m7SaMIJ0k5PL53QO3WMYHqSknOPHGDG4g/gcMVelfHxUTqRc1Zv0O4BcJM1wbZd1Hz1+DeyJJjY71L1TDKPOYjjTZ89uko9qgT+s0E5G/wWtIR9ys5LBdfKe8GiuuKInl65BkIGo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=MLeOwJjv+/uluOjkQHQQ89/FgHix7fE7jGoDf7goFoA=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/2026 6:15 PM, Heiko Stuebner wrote:
> Chaoyi Chen and Damon Ding volunteered to become reviewers for the
> Rockchip DRM drivers, so add them to the MAINTAINERS entry.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..99142a911350 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9139,6 +9139,8 @@ DRM DRIVERS FOR ROCKCHIP
>  M:	Sandy Huang <hjc@rock-chips.com>
>  M:	Heiko Stübner <heiko@sntech.de>
>  M:	Andy Yan <andyshrk@163.com>
> +R:	Chaoyi Chen <chaoyi.chen@rock-chips.com>
> +R:	Damon Ding <damon.ding@rock-chips.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-rockchip@lists.infradead.org
>  S:	Maintained

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

-- 
Best, 
Chaoyi

