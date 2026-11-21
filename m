Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D1606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spRTLxwA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3988710E28A;
	Sat, 21 Nov 2026 11:05:09 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6171210E28A
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 11:05:02 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b8a2518f7cso2048859a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795259100; x=1795863900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gHLZINtQTEgJKCqXvcXR7R3Zej47yaR3yrL5TOtoLHI=;
 b=spRTLxwAjCjBO8g4LY30svX8yw6W6vdj6kP1VsXRhaIOUymk5ZpNHU+1k3S1uCI+20
 ugz3A2nOb/jdIcrfV9Qy4wl6SbOvOxYaYrmIMVFdKNlueO5+Ybk3xFDeXPdsz+xeKmWT
 vMso1RHaC4HZUIhElUoRaEfxwTGhVKXqR4sRwaaGSoZNFJw5U8sA0GT1oWFT1GGq5uPZ
 yVwH+u161LKqobt9gJRCukfIkxGlvaUJ3AEFd0vJsHlPlECKm3I6DUSLDEiiU7rObg1e
 /+GaVXqti0VGflPe6m7H55sccbFa+H2cYthVd0G7A9/0UqqGtEQzCGH9sJYF+Tcsx8XM
 BRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795259100; x=1795863900;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gHLZINtQTEgJKCqXvcXR7R3Zej47yaR3yrL5TOtoLHI=;
 b=pQBQntJPrTabL0dsbBJKNSSHDbLWKXhHFkNMx21vOHPTN5dGToinOPTD5/Dx2w4+k2
 8ewKbSfz81i3Yv0DUTSikO9BH5C44YryI86LortZIBQwnWWUW5OeuQfx5cDIj4lI47iP
 kGeMVaH77HaoAN510xorxr+e2l7r11jqjW2KSIUfVRs+4C8PNQM9VLR2ZY9dufCPZmA2
 FzAVMYK7Wjatxqyvb3CxCEkqvFPxNo+ykiFBCbmxGnzeE548Y5ZvIGuNW3G5L0zoxLx3
 ujQSf36J88CcuuT7PgAsXXo1+7QDgqrXhBgXIKQcMn5JfIr3hRFjalIlg7xvXX8VBo+X
 KYhw==
X-Forwarded-Encrypted: i=1;
 AL+hErFng9n8tfMbsHPAA7G3ivaKVj7Grp5sTa8MYWz+pTNXBAwy0HzJCJjYWDWiULqcYQck3nKQPi00I6g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Av+PD2lTCO3y1JUVspTvc6Gow11E0ctoz05y9NtFfFwQEuw4q
 QMH0E/FFCWZiCI9nb/KRov+ELlm3EX+q3N5BvN7zOZm6U1bZvcX2qapn
X-Gm-Gg: AZFdTZd7/rfPzFYgIHScINc0Ba7d4+BV3jDALUPpta43POYLMSH7WOy1A1Zc7llCTYM
 NxX2pcTXlcf71FxPvERJKc+H0l1FGxiqgqIpD258QssfN0Vj1tNSLwrIHVVMqlriV920foSioJ/
 +9FC6ts2aTrlFdsXfssXJowKeP0xjtDZlBkEEVMSZffZGiTWMabLueMrDQjNPa+ENJd4PTYkhZg
 Ieg61r+e3uKbCFh/837yJp0YZ5ZzkDuiIw3N6bZSNPy3mG3HvD+GrBEnXZfXogrbU3AM4ujkGl5
 vXmHjW4Q69gwn8faJjDBeieQc8wYzMFkAhB2t2qj9PBbBbbnVLBlPFP9umxNsMWuMgQOXLTRCzP
 0CmiKnGADxjSy9bzmj/1qMbGw35H6MTbVzfu7ylLYEyZOy64/OI0MAuImEjjHGTa7C20P2pg94F
 MxSlgsvMGRdgq0IrWfpG4t4fZj0w0sERIRcaofXvfv8qZ0vnc3gH0OE4z+hqDkJAtakgQSW+APQ
 hqQR2fB2gnVS2pNIHpp/pgxdR79xolcM4uXCRiBelAqHMJ+n+fyz4x9HRLRV6NBJXJMC51UGSN+
 dy4T9YI9d7Q8tHHWONb6wjNcxZSDr1lQfw7hxQoCom+CONtXInPGDKUq+nZ276WQTSBPD6bM4nh
 sxPs=
X-Received: by 2002:a17:907:3cc7:b0:c2e:2d8c:4585 with SMTP id
 a640c23a62f3a-c513ab4cd0dmr513379466b.36.1795259100428; 
 Sat, 21 Nov 2026 03:05:00 -0800 (PST)
Received: from ?IPV6:240e:47e:5028:61b2:a372:4c2:dce1:98eb?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfe3b0sm182991366b.8.2026.11.21.03.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 03:04:59 -0800 (PST)
Message-ID: <ed689e5e-95e0-42b8-b1c8-afcc968bba1a@gmail.com>
Date: Sat, 21 Nov 2026 12:04:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/43] drm/vkms: Add new lines for configfs attributes
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-3-78ace90f4fc1@bootlin.com>
Content-Language: en-US
From: Oarora Etimis <oaroraetimis@gmail.com>
In-Reply-To: <20261120-vkms-all-config-v6-3-78ace90f4fc1@bootlin.com>
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/20/26 6:58 PM, Louis Chauvet wrote:
> To uniformize the configfs attributes, add a trailing new line to the
> plane type and connector status values.
>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_configfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 707cf3578e2d..5f5aa0a1812b 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -294,7 +294,7 @@ static ssize_t plane_type_show(struct config_item *item, char *page)
>   	scoped_guard(mutex, &plane->dev->config->lock)
>   		type = vkms_config_plane_get_type(plane->config);
>   
> -	return sprintf(page, "%u", type);
> +	return sprintf(page, "%u\n", type);
>   }
>   
>   static ssize_t plane_type_store(struct config_item *item, const char *page,
> @@ -527,7 +527,7 @@ static ssize_t connector_status_show(struct config_item *item, char *page)
>   	scoped_guard(mutex, &connector->dev->config->lock)
>   		status = vkms_config_connector_get_status(connector->config);
>   
> -	return sprintf(page, "%u", status);
> +	return sprintf(page, "%u\n", status);
>   }
>   
>   static ssize_t connector_status_store(struct config_item *item,
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
