Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8A606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PVYM102Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D5A10F639;
	Tue, 24 Nov 2026 15:14:37 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2693B10F639
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:14:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B6EEF4E41722;
 Tue, 24 Nov 2026 15:14:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7F7F2601E1;
 Tue, 24 Nov 2026 15:14:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6CEFB11E681A0; Tue, 24 Nov 2026 16:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795533263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=p+bpU0SHAzyafeIyqxsdITumZBdrrKe6R0doc06h36Y=;
 b=PVYM102ZFuqJJ55UqGyg8HVM1tZvss4BSsQa7M2LFgwDxTMA25XCBlyiFOoQ0HlkQsmjyn
 Ugwd5EL/bWqKZS9bbTV84B1PfBU7WO+xuON2NBn0/4ENYMU3aNb3eZj6m70WsQjAy/NdBD
 ND7L3XqlGhJIFpcLKelQqD/hhqSUjADmtLEaISgBJOqpde0zrzlt8kNbksuRbdeHNQSqXB
 BePDntVGvjHuxZ0dyAMwhNyBI7BAaAcyeIFhiGiS/n6Hi9bSJkL+ke0Pq8fVL1mexGKM9F
 g6dUkvQzQXb69tbNuhId14BuzPSvYa0xguAK0QLm3fBxXzCfgM7h2nPUZrv7Pg==
Message-ID: <75aace8c-5bf7-4e9a-8682-b3d37d6cfe4d@bootlin.com>
Date: Tue, 24 Nov 2026 16:14:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/4] drm/ci: drop the kms_plane pixel-format xfails
 for vkms
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
 <20261123-lut-v1-4-5556c89a2ebd@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261123-lut-v1-4-5556c89a2ebd@gmail.com>
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
> kms_plane@pixel-format and pixel-format-source-clamping are listed as
> Timeout in vkms-none-fails.txt. With the per-pixel interpolation they take
> 160.1-167.8 s and 78.9-83.8 s locally; with the precomputed LUT tables
> they take 9.70-9.84 s and 4.87-4.90 s, so the entries no longer describe
> the driver.
> 
> This patch depends on patch 2: removing the entries only helps once the
> subtests stop timing out, so a job that takes this patch without patch 2
> fails.
> 
> Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
