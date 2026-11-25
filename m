Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2144606A338
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k2Dt9nmE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CEF10FD1A;
	Wed, 25 Nov 2026 15:46:27 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B452E10FD11
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:46:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9EC24C62219;
 Wed, 25 Nov 2026 15:46:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9443B60480;
 Wed, 25 Nov 2026 15:46:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8750211E6A112; Wed, 25 Nov 2026 16:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5M+Y4WoolzAgpLfZyN5TlkHUMbwAipYug+VFIXMqPl0=;
 b=k2Dt9nmE0buK4bYqIChKcV0tgCmwNutYBmzUfMncz5nmqXPDms7CzBAk4lHG7w+AwEWSnq
 59kSslg/CIxRTi3pP3zP2mUDOnW952toHqPOyIYlYU46yZwRBMRGQ9ky4KtgRex+fa6Q2Q
 /qRJijNE583eo6zqrkWtf7kbBLG48BaUO7/zVQcmIJjI+QbsQFu5o7F2dBvPDMKo0LEp23
 aB7SlttQOA1yhF3iabe80jIZnVo/Zziy8gX6LYgkmzvpxzmbQBQV4Wr6UpJ2I3X5UcJSZi
 juUI05Mv2gDdoPNBxPrPiuFGItbvUfI/IV6QGlq7LAIOdaQCh4NlEN9pC7xXBg==
Message-ID: <c8551be7-738b-4a0f-9694-5e557a1dd5ec@bootlin.com>
Date: Wed, 25 Nov 2026 16:46:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] drm/vkms: add support to non-uniform LUT for
 internal color curves
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-10-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-10-leandro.ribeiro@collabora.com>
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
> This extends VKMS internal LUT implementation, allowing it to represent
> non-uniform LUTs.
> 
> Such LUTs have the X axis. LUTs that come from userspace (gamma LUT) are
> always uniform, so they don't have a X axis.
> 
> Note: vkms_color_srgb_inv_srgb() error tolerance reduced from 1/255 to
> 119/65535 ~= 0.46/255. Before this patch, the test compared the results
> after quantizing them to 8-bit precision, while the updated test
> compares directly in 16-bit. The LUT precision does not change with this
> patch.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
