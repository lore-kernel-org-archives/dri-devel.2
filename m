Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D57606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nxmSHtME
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710D610E0C6;
	Wed,  4 Nov 2026 13:36:08 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9E810E139
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793799361;
 bh=Y50lTd+v/mAmOMd0DQBCaynW91uLDTWppOCSN5jsCG4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=nxmSHtMEU+dek1QJhtYKgggXiG6+UesAKILlb3OC3xpnz83W92fiZcMdaxfOIleo/
 9el6zATiG979ybbpVa0M3qJzXg4NbZlkF/wjOeokkb+8KLvx/darvfw7XGPND3G6dv
 NKSwM4iGiO53DSgiMP6Z2AL/1yCwTF9O+ox8LpXRStH8g2UXofA+k/oZNwwaWdnZUP
 Bmm817+4Tikqr+o0jZdkTkjcki4/t0swuQWD5/a8d46tl4lAtbBpA75133ZIOBeDuR
 lFnWTpz1GdGdouDXtfhPETU9FvQs8sxYgKSpcK5mnaVapMyKHYSKIsMukNiaDK/L8V
 tT+FjgBtj6aTA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E887317E0269;
 Wed, 04 Nov 2026 14:36:00 +0100 (CET)
Message-ID: <9299bf4b-f238-4af3-84db-61af746768da@collabora.com>
Date: Wed, 4 Nov 2026 15:36:00 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/display: hdmi: Prevent NULL pointer dereference in
 sync_scdc()
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20261002-hdmi-sync-scdc-fix-deref-v1-1-d99b4f544dd4@collabora.com>
Content-Language: en-US
In-Reply-To: <20261002-hdmi-sync-scdc-fix-deref-v1-1-d99b4f544dd4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/2/26 1:26 AM, Cristian Ciocaltea wrote:
> The connector pointer is used to initialize the local variables hdmi and
> dev before the NULL check takes place, leading to the following Smatch
> complaint:
> 
>   drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
>   warn: variable dereferenced before check 'connector' (see line 657)
> 
> Move those initializations after the sanity check to avoid a potential
> NULL pointer dereference.
> 
> Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")

There are a couple of additional fixes on top of this one, which is why I've
sent them together as part of a new series:

https://lore.kernel.org/all/20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com/

Thanks,
Cristian
