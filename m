Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=i+r4z4rr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1569610ED34;
	Tue, 24 Nov 2026 15:13:43 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1400710ED34
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:13:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AB240C2C64B;
 Tue, 24 Nov 2026 15:13:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3681D601E1;
 Tue, 24 Nov 2026 15:13:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B130311E699B2; Tue, 24 Nov 2026 16:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795533213; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NXqk/EsElW6S2KxaRSKdG5paeRpfpZqtOu9th166vX8=;
 b=i+r4z4rrCxckRaTeNCSRxsUaHI/gO+H0yCodAfkPVR62Tep4gQaNw+aD5O3qU7DcLTGP1B
 H5OW3hm6Dt8yS1R/HygpKnuy8+gmyEruXK1ea000hywxR9t6Jy8+YvQdqZJeIyRl2k0RKT
 8Eo6sqRqXW/0ctOvx3B76knH4O0PwN3W5fmQ34vkcZMjMvbr2u20W0lpyY3iiC3zdZfwbf
 Fp+zHLGElegH8Z/P1Ci06050FSTfup0XAQEfw83I/YcE3O5Ncfbtx7ZULoPU3A6DEYYQjI
 0VD+A5Nmu+r2jTVoeeaPTUCpqRYiSqWrbtPNUk9sDn6r+ZLSdwD31jGbSM1CCg==
Message-ID: <7409b2e4-5f16-4fc4-a0fa-39546c50d0ef@bootlin.com>
Date: Tue, 24 Nov 2026 16:13:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/4] drm/vkms: add a KUnit test for the precomputed
 LUT table
To: Oarora Etimis <oaroraetimis@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
 <20261123-lut-v1-3-5556c89a2ebd@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261123-lut-v1-3-5556c89a2ebd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/26 17:20, Oarora Etimis wrote:
> build_lut_table() turns a per-pixel interpolation into a table lookup, so
> a wrong entry changes the composed output with no other symptom.
> 
> Compare every entry against apply_lut_to_channel_value() for the same
> channel and value, for a 4-entry LUT whose channels differ and for the
> 256-entry sRGB one. The check stops at the first mismatch and prints its
> channel, value and both results.
> 
> The tables are built with apply_lut_to_channel_value(), so this proves the
> lookup matches the interpolation, not that the LUT arithmetic is right;
> vkms_color_srgb_inv_srgb() covers the latter.
> 
> Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

