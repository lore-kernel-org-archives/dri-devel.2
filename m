Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE618FF5106
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB7C10E44E;
	Tue,  7 Apr 2026 15:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.b="RhTEaoIr";
	dkim-atps=neutral
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0246710E44F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 15:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4fqqZ330Ctzlfl5d;
 Tue,  7 Apr 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1775575045; x=1778167046; bh=iBtrPgRunBecdrTnNSw+BC0U
 6kZsQggoJVilSHd5EbY=; b=RhTEaoIr+4zABLPO5VbcKh2tAoGILNmNDLuSVwry
 RpV1HhN4NQu3IhH3BgLOUi9d80ZhL3+94yIOFXsIxQ+dkfCwlLFXRCyMghUnJKRo
 ZD1pRvlPZM8LPfKPXK2lOLhfj0wq+exXVCXyuBrLkgk+lB8nE5XSC5imCAR0+pNl
 UzWuWuGO7D6uWWj+yzfcvp3v5aN1nEX8569lkNEFspKMpmrNWnfXbUpk8y4GTZK5
 fr4L70ZA+GHnt0ofy9zVNSl+o1aQ2V899DUTcCJHHvZk/QOjJ6PL12rV8bNLpkSN
 YJcTESglxMub5vTRsertCbnVT8qUJNNXik82xQj0DMfD8A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nWNT95Txk0gV; Tue,  7 Apr 2026 15:17:25 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fqqYs69lQzlfvpM;
 Tue,  7 Apr 2026 15:17:21 +0000 (UTC)
Message-ID: <a4cfd10b-bdcb-431d-991d-ca664eaa2a98@acm.org>
Date: Tue, 7 Apr 2026 08:17:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb-helper: Fix a locking bug in an error path
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260403205355.1181984-1-bvanassche@acm.org>
 <1c03e4d8-0eac-4863-a18d-1ea750c853fb@suse.de>
 <c8c6b2a0-4ef4-44df-9f38-4f5b8d50dac4@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c8c6b2a0-4ef4-44df-9f38-4f5b8d50dac4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/7/26 12:47 AM, Thomas Zimmermann wrote:
> (cc: dri-devel)

Hi Thomas,

Is dri-devel the right mailing list to Cc for this patch? If so, how 
about adding an L: line to the drivers/gpu/drm/ entry in the MAINTAINERS
file? That entry currently doesn't have an L: line as one can see below:

DRM DRIVERS AND MISC GPU PATCHES
M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
M:	Maxime Ripard <mripard@kernel.org>
M:	Thomas Zimmermann <tzimmermann@suse.de>
S:	Maintained
W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
F:	Documentation/devicetree/bindings/display/
F:	Documentation/devicetree/bindings/gpu/
F:	Documentation/gpu/
F:	drivers/gpu/drm/
F:	drivers/gpu/vga/
F:	include/drm/drm
F:	include/linux/vga*
F:	include/uapi/drm/
X:	drivers/gpu/drm/amd/
X:	drivers/gpu/drm/armada/
X:	drivers/gpu/drm/etnaviv/
X:	drivers/gpu/drm/exynos/
X:	drivers/gpu/drm/i915/
X:	drivers/gpu/drm/kmb/
X:	drivers/gpu/drm/mediatek/
X:	drivers/gpu/drm/msm/
X:	drivers/gpu/drm/nova/
X:	drivers/gpu/drm/radeon/
X:	drivers/gpu/drm/tegra/
X:	drivers/gpu/drm/tyr/
X:	drivers/gpu/drm/xe/

Thanks,

Bart.
