Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA09606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipx3O2ub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799FE10E534;
	Mon, 23 Nov 2026 16:31:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F01010E534
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1349B40452;
 Mon, 23 Nov 2026 16:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09DE1F000CA;
 Mon, 23 Nov 2026 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795451472;
 bh=EeG8CcdNnFyu3Wu0cn0cp3neJz6lxVqBGhcCpy1RbRs=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Ipx3O2ubMFBnyq3U4udDS09fhZwEf20oMZi7XmCLTFnDSLh3qbxBx+K2g1gUvxtDs
 /BYn8A7+eKdeQ6xxF81YIs/buZtWu7aBwo6NgkipkLLsAOm18e7vKyeSapWGXFiXxQ
 COUzWOYok9qLLnc3rS7EOFVSZ2AoFsLXUGNCYVWy2ICdXvVu2rkTzQBmeCKIJ3XCw+
 uvw8Zn9iADYLinFFHpvXqiFjWs7SnQdWaraOpXuk9v85ynOBrZe9zDOyZvM4FalSrG
 zGeA6qMjY9k42huPn3KaiCq0X7Sl0BOkWi6R7oEcMk2LY/AWg+lOKWqHrqdxK17g+C
 crsE6dNAL6hpw==
Message-ID: <7d849ed180032b1fadef0d400534b44a@kernel.org>
Date: Mon, 23 Nov 2026 16:31:09 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 18/25] drm/tests: hdmi: Cover mode validation against
 connector max_tmds_char_rate
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-18-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-18-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Sat, 14 Nov 2026 20:03:42 +0200, Cristian Ciocaltea wrote:
> Test the hdmi_clock_valid() logic that rejects modes whose TMDS
> character rate exceeds connector->hdmi.max_tmds_char_rate.
> 
> Exercise both an explicit limit set through drm_connector_hdmi_funcs'
> supported_tmds_char_rate and the limit inferred from supported_hdmi_ver.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
