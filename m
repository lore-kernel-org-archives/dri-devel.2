Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1C606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=SA8vSYJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC7510EAD2;
	Mon, 19 Oct 2026 19:41:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEDB10EAF2;
 Mon, 19 Oct 2026 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=k9Zx/ZW4I8N+mjB5vEjKMn6hXcn3AohRAT+gKs7pw1Q=; b=SA8vSYJODOm0IYLi+FFi63+/R8
 XtHCyZLlK2msXsGkFeHikcB5TwNf86G3x/vA0XkCAX5NVtodS5DzRBo4b4nCz1O2HDPkY7xJRPEko
 44NohojE2p/Jcy1QvVTaCYkhUpA500wqDVMUfSGaED3J5pLDnvDaWGxfyzHGhURnFAGpl0ABKMyBL
 JNSmz10y0q5nln+8UiXYVtZUrpLI2ug7+XEw+MLT3OQziJUVj9ra5j4EytZCoI1Cu//3N2CEyZYiO
 gDfUyyJJ3o3G9Psb7GK8BFOswedtt56vMcCSdBoO9tbfW92R43NvH1rLbUq9jAcEHFtNK/EA9Q85t
 Ao48gZSw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xItEM-003nxp-E9; Mon, 19 Oct 2026 21:41:10 +0200
Message-ID: <45638e6b-04a9-46b2-97c0-66f3e2f9930a@Igalia.com>
Date: Mon, 19 Oct 2026 12:40:58 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] drm: writeback: clean up writeback connector
 initialization
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/19/26 06:12, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Enough of the drivers don't use
> the encoder embedded into the drm_writeback connector.  In preparation
> to further rework of the WB connectors (as planned to enable WB for i915
> / xe drivers, which would move drm_writeback_connector to be a field
> inside drm_connector instead of subclassing it) remove the drm_encoder
> wrapped in struct drm_writeback_connector. Rename the
> drm_writeback_connector_init_with_encoder() to
> drm_writeback_connector_init()
> and copy drmm_writeback_connector_init() interface. Then, with the
> encoder being gone, handle proper cleanup of writeback data in
> drm_connector_cleanup().
>
> ---
> Changes in v7:
> - Significantly reworked series, no longer insisting on using drmm.
Is there an intent to move everyone over to the drmm version in a future 
patch set? Or is the plan to give up on that as being just too 
complicated for the benefit?

John.

