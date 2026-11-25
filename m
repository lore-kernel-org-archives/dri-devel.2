Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C9606A69B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=D3VTcu+m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E593410FD13;
	Wed, 25 Nov 2026 15:50:06 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097C010FD09
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:50:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5FD5D1A17F1;
 Wed, 25 Nov 2026 15:49:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2C4D660480;
 Wed, 25 Nov 2026 15:49:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 92A4511E6A175; Wed, 25 Nov 2026 16:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=e76EZuVdk/zJavZpKu/IrkQBob1XPJ451/OfmCEgZd4=;
 b=D3VTcu+m4wLag1usrlpRaoceWYMUfAq5PwHhGBJiWy2vDDrmZll2RplmdIeak/KnCeb0bM
 KKLAx/yQ0VgUJ6FDL6egz4jdZlxQnMV9NWG1Dlqgem7Agc2voTAB7sV6kJGltt8Z+eYNGP
 hScxABceZnP/8sVIFaHm7KkaqSb9zNTYE8QMCxWZtMtLq+RzfuIlmwL6W7pkSo3YM/+XAb
 7fkEAeg5XMi/hD73MaGF2gdEBjgLB+ppBnadBw80imPovsluLsv/fe+IPJDb5TYvT+yi4O
 xWOXsjD/nWwafWGtX0aOZQ+WIlzgBSwbPX2yrrEJUJ6z10829CLqDYkLkc4hLQ==
Message-ID: <ec16a467-5d4a-4c39-876a-4d108c16598b@bootlin.com>
Date: Wed, 25 Nov 2026 16:49:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] drm/vkms: add script to create optimized LUTs
 for color curves
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-12-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-12-leandro.ribeiro@collabora.com>
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
> Add a Python script to generate u16 LUTs for VKMS color transfer
> functions while minimizing interpolation and quantization errors.
> 
> The script compares different LUT generation strategies and uses greedy
> subdivision to generate optimized LUTs for the supported transfer
> functions.
> 
> It also outputs the generated LUTs in a format ready to be added to
> vkms_luts.c.
> 
> v2:
> - Address feedback from Sashiko bot: conditionally plot, to avoid issues
>    on headless systems.
> https://sashiko.dev/#/patchset/20260804203351.148521-1-leandro.ribeiro@collabora.com?part=10
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
