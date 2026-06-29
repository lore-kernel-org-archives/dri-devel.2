Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A9CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EA610E83F;
	Mon, 29 Jun 2026 11:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HaaLGwrF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98A710E83F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:57:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAF064132C;
 Mon, 29 Jun 2026 11:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1FB1F000E9;
 Mon, 29 Jun 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782734265;
 bh=t4KyIkZWBJKdALEOa/Y1pLyb3DX+1WVmbm2CZeogn/M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HaaLGwrF0nTazgQ0V8JznfB1bfuUsWr2nEWeoukqgJrDYxQUaXguNf96xbg+NbCmi
 iiMC5GiwK4GqHlBDsuc8ZlpawW9CS3jPe8Zvga4iKUOmztqDs8bgxn/fsN3941cT02
 wVG8eYPrWyo29HGZCBK8XdMaUmv2ms4PfDV34iAh34EXvSbWNnb9yvIOFLNnDWFS4d
 3wFDsEFY2bNRjuF3GBLSnkZsw+ji33UVlxmkAsxo3B4cITIv0pEdNwW2Ki1awMcC+9
 +UwOVH6YUdrY1f3DFRIJjJRj7r9tiXffsx6NiqJV0DU2RgjBS16rz5BuT70TL7gnKb
 8lfph/Zxr8u+A==
Message-ID: <2b869c87-8269-44e7-bd51-8492190b23c1@kernel.org>
Date: Mon, 29 Jun 2026 13:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/sched: Deprecate drm_sched_wqueue_ready()
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260629104040.2695163-2-phasta@kernel.org>
 <20260629104040.2695163-3-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260629104040.2695163-3-phasta@kernel.org>
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

On 6/29/26 12:40 PM, Philipp Stanner wrote:
> Deprecate drm_sched_wqueue_ready().

AFAICS, this is only used in amdgpu and the implementation is a single line. If
we don't want people to use, I'd rather just remove it and let amdgpu open-code it.
