Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCF606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2bS1NRVq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A8E10EC24;
	Wed, 18 Nov 2026 14:31:44 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1426E10FD2D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:31:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 993FBC4CBDA;
 Wed, 18 Nov 2026 14:31:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BDC545FE9B;
 Wed, 18 Nov 2026 14:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D21B711BC2252; Wed, 18 Nov 2026 15:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795012291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=OG9POYdEHH7btivB/AUnbEj4V7CX4w1ygKsa7b09Rk8=;
 b=2bS1NRVqiott42d5kjBK1IWmEAXlK5HVRiIxhtKO2GL5KL8Bwd9qLcDzmK59MHYTCnH6W2
 hufgIAWgP5qqy8KY+m2j6IJPobNdoE0rYsZ0oYw0HH9JlJ5hRJ9q0tu7g+W148pRGmw7Rl
 aro6gB0Ss/fuV+HLq0NyXEYJmZeihvsOYnV0jNbOy+sOTcFidy2qjSH19FRfd+SJYMwHBH
 2a1gv7pDZxHfmevNaQAz87g4ZJmZLbwOkb3vAEXAOSRo4/xvQ55r6uR6lVXo8j7uD1Y3FV
 YqlKq7UXJtTKjyd05DTqWWQ5/Lz6y1Mmcd6MMDlolqAtmFjW/+6pidVjNFMdXw==
Message-ID: <f728e984-7808-47a8-b9c5-c915bb785995@bootlin.com>
Date: Wed, 18 Nov 2026 15:31:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] vkms: properly compute gamma LUT size in
 vkms_atomic_check()
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-3-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-3-leandro.ribeiro@collabora.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 21:18, Leandro Ribeiro wrote:
> Gamma LUT size is being computed wrongly, dividing blob size by
> sizeof(struct drm_color_lut *). But the blob is an array of struct
> drm_color_lut.
> 
> Replace sizeof(struct drm_color_lut *) with sizeof(struct
> drm_color_lut), properly validating the userspace gamma LUT size.
> 
> Issue caught by Sashiko bot:
> https://sashiko.dev/#/patchset/20260804203351.148521-1-leandro.ribeiro@collabora.com?part=1
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 86a8a95694fd..28b99511f186 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -112,7 +112,7 @@ static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *s
>   		if (!new_crtc_state->gamma_lut || !new_crtc_state->color_mgmt_changed)
>   			continue;
>   
> -		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
> +		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut)
>   		    > VKMS_GAMMA_LUT_SIZE)
>   			return -EINVAL;
>   	}

