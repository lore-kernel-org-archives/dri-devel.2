Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA3606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JRg8LcAJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D50B10FD38;
	Wed, 25 Nov 2026 15:50:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA67510FD38
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:50:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B28854E41774;
 Wed, 25 Nov 2026 15:50:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 872D560480;
 Wed, 25 Nov 2026 15:50:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9F00211E6A17F; Wed, 25 Nov 2026 16:50:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=i66x6SulCuugAeQE9LzOp5zVoMaKrTk11/eSNR3HO2I=;
 b=JRg8LcAJgi/KjbL6IwLz60whI3amVQ1fV3T1HKKlo7PMD/hoE/1nJMkfhMRsqU1XkINeSg
 nMHaIGfq4deXYzBKmAXhGzn3jpIKOGsktbDANvnDxPTOydp5VX/5PmI2z5irfwx9PbqdFW
 xqSuMgCfMoShohmKnxGluilivwCWmkk8loCM8+gfzXhZ+Tiz9Dss4BVV1vyPThzRFD7bXP
 IS7ASOqH1iPmaIDp3Yx06LJDNOgDy2nR3JF3x35HVeJRQGudSCkq6zpHUTQMQed0eBbwBC
 oTChZh81dOoviid9Lw936MheMesPzE91ufmk4AkdwfsWWJ3sqM0/j8KI2w7hcQ==
Message-ID: <d979ca00-a6c6-4297-8186-92c50c95bd63@bootlin.com>
Date: Wed, 25 Nov 2026 16:50:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] drm/vkms: replace uniform sRGB LUT and its
 inverse with optimal ones
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-13-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-13-leandro.ribeiro@collabora.com>
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



On 11/6/26 21:18, Leandro Ribeiro wrote:
> This uses the script added in "drm/vkms: add script to create optimized
> LUTs for color curves" to produce optimized LUTs for sRGB and its
> inverse.
> 
> The LUTs are non-uniform and have more taps where it matters (areas with
> high slope), decreasing the error they produce.
> vkms_color_srgb_inv_srgb() error tolerance dropped from 122/65535 to
> 11/65535.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
