Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A7B10854DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DBE10E78D;
	Wed, 18 Mar 2026 09:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mailbaby.net header.i=@mailbaby.net header.b="SHiBF035";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="fap/Acyd";
	dkim-atps=neutral
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Wed, 18 Mar 2026 09:41:30 UTC
Received: from relay0-g.mailbaby.net (relay0-g.mailbaby.net [64.20.38.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA0510E78D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=aRavYgOWVKoyYXThS/WCBZX6NQj4ML17HDnyR1moraE=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references:feedback-id;
 b=SHiBF035M8C7wGGOerJ+ICjCuWtTKzLDPAZ32wdeDdQMxPYBIlZGIUrEUqRo+ndEegEbyk4Jc
 W0ObooYf/dACp7ZEpFfuK479zBqAx1GvRTlhmPy5E1xNmwLHF40OuI8SWXIsf0hd7u9nLLGHIfy
 7HkovqTXuBHRcLVIVKUBpUc=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
 (Authenticated sender: mb86144)
 by relay0-g.mailbaby.net (MailBabyMTA) with ESMTPSA id 19d004d8faf000319e.001
 for <dri-devel@lists.freedesktop.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 18 Mar 2026 09:36:16 +0000
X-Zone-Loop: 91e6f1033fbc7ca946ecc0d7e7a24c6c37173b55e3b3
ARC-Authentication-Results: i=1;	rspamdcluster10.mailbaby.net;	auth=pass
 smtp.auth=mb86144 smtp.mailfrom=jeffbai@aosc.io
ARC-Seal: i=1; a=rsa-sha256; d=mailbaby.net; s=detka; cv=none; t=1773826576;
 b=eTs3Iw3OvSEmtSZav0V2pSxrfiXRN+uXI5U0wLwM4e4tRRtQddO8gdFepc8uGGg6WLJD4D
 BZy3WLF7PwETRwY+c532ArLFoL3H1FnUKUVHPKPeriTn+cJHMUflc/+CUdZ1fRp3T6Hhe7
 4zhh3c25Dl8mc5qnpYyj7/2WffUE2/eg5HMIWV9CTRkCvDFHbl+zgny44uZvIlcbbjC5L3
 fsUrKuv8e46zjt9sSo/ohrAp55rnkZkrbEZclNtoAQy5rtSE6httlS6npl+RjlHaRvb+iX
 FKk1gcaQxpKs/OUwxvn64wkQZoW3BFsjbF+8LrUumLskeRB3YUO7tHi+OHk8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1773826576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=aRavYgOWVKoyYXThS/WCBZX6NQj4ML17HDnyR1moraE=;
 b=tiPoxoeFvBPwZG9IfrW2ClzSH38XMHoGNxjhfZuqyymGgeVvO4tF5W/e3d21RrF0iP/3QD
 06YApzgVgmeqN20ycxxLlFli7kpuXFFL7io3YM+c9NmuxV2jGQHpgtuwmkDQbg8eV8z/Hn
 ENT6qXr/YwubsALXmVsFv1nC/SihHcEZVhOposFxPzwh6PUl2TztcwTntvCsqLXkuxtPUz
 LdxSSg20nLDIqrgVkfVuxQ0wZ2A5jItpAuwQQuDqrtmf16mHunQl9llLIng3LnhdmdYqS/
 CxWYUMawwc4qLUftILZIMM0LnbU/3oWusvUfHbtIyh2Q+KcIUp281sGrKxNGnw==
X-MB-ID: mb86144
X-SPF: pass
Feedback-ID: mb86144:19d004d8faf000319e:587f4d465843594778405947455d:mbaby
X-MAILBABY-ORIGIN: PASS
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com
 [144.217.248.100])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id 0A2F520112
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:36:13 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id F23A63EAFD;
 Wed, 18 Mar 2026 09:36:10 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf2.mymailcheap.com (Postfix) with ESMTPSA id ADB944007A;
 Wed, 18 Mar 2026 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1773826569; bh=564P1Pt8Gne3Up4y2gEfBfyHGqv6PI4DVAe2wHxq3yY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fap/Acyd0r1/9cpvzkqI2YR/cB9g/VFPiwabod0y9wzwPjcPO03v/CikRhc29HObF
 fNXJ9RMKRcG/ZA4OgiVBf7CdTZwNwenICC9LGRHLKNDdB5drdhxlkvVo7tjHqXXLbB
 IdEpgdM3X7jHl8qg+zOZ4eCKJinIeGH6FyYFuFXc=
Received: from [198.18.0.1] (li1563-205.members.linode.com [139.162.83.205])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id CAE82404E9;
 Wed, 18 Mar 2026 09:35:59 +0000 (UTC)
Message-ID: <b1ce6674-c8c4-4277-894b-2d611daf2507@aosc.io>
Date: Wed, 18 Mar 2026 17:35:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Jianmin Lv <lvjianmin@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Qianhai Wu <wuqianhai@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20260318092349.11651-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: ADB944007A
X-Spamd-Result: default: False [-0.30 / 10.00]; MIME_GOOD(-0.10)[text/plain];
 R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
 R_SPF_ALLOW(-0.10)[+mx]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; RCPT_COUNT_TWELVE(0.00)[12];
 FREEMAIL_TO(0.00)[loongson.cn,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,xry111.site];
 MID_RHS_MATCH_FROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 LOCAL_OUTBOUND(0.00)[];
 DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
 DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action
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

Hi Jianmin,

在 2026/3/18 17:23, Jianmin Lv 写道:
> I and Qianhai are GPU R&D engineers at Loongson, specializing
> in kernel driver development. We understand that the current
> Loongson GPU driver lacks dedicated maintenance resources
> because of some reasons.
> 
> As Loongson GPU driver developers, we have both the capability
> and the responsibility to continuously maintain the Loongson
> GPU driver, ensuring minimal impact on its users. After internal
> discussions, our team has decided to recommend me and Qianhai
> to take over the maintenance responsibilities, and recommend
> Huacai, Mingcong and Ruoyao to help to review.
> 
> And We'll continue to maintain it for current supported chips
> and drive future updates according to chip support plan.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

Thanks for the invitation and will try my best to help.

Acked-by: Mingcong Bai <jeffbai@aosc.io>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ea84948d76..4232039b7282 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
>   F:	include/uapi/drm/lima_drm.h
>   
>   DRM DRIVERS FOR LOONGSON
> +M:	Jianmin Lv <lvjianmin@loongson.cn>
> +M:	Qianhai Wu <wuqianhai@loongson.cn>
> +R:	Huacai Chen <chenhuacai@kernel.org>
> +R:	Mingcong Bai <jeffbai@aosc.io>
> +R:	Xi Ruoyao <xry111@xry111.site>
>   L:	dri-devel@lists.freedesktop.org
> -S:	Orphan
> +S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/loongson/
>   

