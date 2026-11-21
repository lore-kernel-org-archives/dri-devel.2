Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69961606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9Ft89kV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10F510E73C;
	Sat, 21 Nov 2026 10:57:33 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E67010E73C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:57:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so12222725e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 02:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795258645; x=1795863445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s6L/5zARcCLel44kQYhmt6hmNx9yE54W+X6j7p6+kLI=;
 b=a9Ft89kV3KLL5HQO4+jdefAkLLq7SR4ieTrWzAYFKLgK+jnlIvFaolp7tgrQVU/xkT
 P+7tOc07byoTK6yf7X+o3ralcp7AabwarRdhHdz3wuEYN+d7ZF3WOAzOJu6jDWb14fg1
 sOxetIuBHBc/8B+Y5euKYg4mIOH+nm0zsDYVffexwLfersDmkHZXAo4j38BF0Q7ZZHJp
 mcvWjnZSQVPQ5Fi5t+VQBRTBSC5FUjxQkmMf8EC3sF5m+pQ/D7ncZ+/JLflXVTP/UO2a
 zYQCFjWeZ+qvv+wxsX7baRUxspxhh2zc5voFPJNjkkEPlTd9P7eQr/8KJoHz/NiSIudw
 C+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795258645; x=1795863445;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6L/5zARcCLel44kQYhmt6hmNx9yE54W+X6j7p6+kLI=;
 b=zzJjGI2CPM7gZiywVsSbT4rzVW84YXnSHs7LPpVLqtw34dvpEmfZhg/8YWRvDmCOu4
 Jga1Xf6k5JzgSt79RtN/a7kOAk6KBDz4Y/LdqShptWW5cbP0m/xVeDQE8XkWUkRoSNIH
 ofgIq5juzShziMqeJc3WVdq02DblQJ1KNAfdu4zjUErLPbVLeCr7LGuTCYqbDv/DJTPV
 AJc1dJ+vwl7LUkUux5Zsr34Lj2gw6fL5rOtGvoCHFsQIrKJrpLYWjh/6G4IafKw8sm4k
 cKldd5z9dUV5GGmXqraKgxEExDWckDxOZ6HjrqfF+VVj7Md1JK9br55EbQVU6PW3pVf+
 LUyg==
X-Forwarded-Encrypted: i=1;
 AL+hErFDzXu+CV+JgiZveYS+obpT6N49VlngzRZFhU4fwyr9eTxpdeQmDWR4WUhYXMJVQpsFbON40XS0PWE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Z/XfSmRUbBPgF+gTmTToX0KHEpDRENoqud4PjF4pba/IXftRP
 /enK5SjuerQ+w5LDScrag1AsP/xEPid92Y2v4ufL7SC6+QQCooaZYmUj
X-Gm-Gg: AZFdTZeQWh0pM4hO91A2Vy8OzbCMfG92mMhUa7q8xSssYieZDpeGAiV97vMcKs7aOLE
 dlSfKe6fQeQicsU8tX3L3OxvAKekqCivYMbfU17nu+l7ASWj+hU9pqBPxdH9mUauu00YoeobifD
 2zrmcuovm8pizGRPN9FtaA/hOOnyRYVXFk/1ieeVCcER8LNZIyI5JV4RjgD+txlQ/OU9aF2f+Gj
 hTcrfOseG7I7TzYaOIn93Tg6kdk7LZBP12Ec516u1iAc1GY6m+ZYAcJmQMt5LrWsC/eYqS5tIhq
 s6ke/K0rnihxgygj6Mw6VXraDdbR3c2qsVhu/uxU0KV2rvI7H/YBy6SW4u3hO01QKKR8ylDd9wb
 2Y6C7b5kt6ko3HqRu6yrBqai+qg6cCX5eY6/V/QKfnbOMwv9vA+xEIgxX+VUbo8YUkt45VXUjld
 CiT134AWn6jw0ocD/KIKas77eKRgocRZdajhZzjvf8jl3yRRy6Uh3ozW4P+shwzh+yeKpBWacii
 qq1a+gxuiPnyaUZqNd6rCNTVsdA1QDWAx1ENDHY6J6Y0ltm1h0RCPdLvg/S6nYL6sFZmdMNdRqs
 mp6KVWGSCcej7yrCHXTxQRtvBFNbYsZrAMkhgxQilYq7Ax+roGUlUU5F0SDK95nF2N2EmCDxsDE
 SBPU=
X-Received: by 2002:a05:600c:46cc:b0:4bb:69b3:2b42 with SMTP id
 5b1f17b1804b1-4bb888277b3mr133199515e9.16.1795258645328; 
 Sat, 21 Nov 2026 02:57:25 -0800 (PST)
Received: from ?IPV6:240e:47e:5028:61b2:a372:4c2:dce1:98eb?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm163775135e9.7.2026.11.21.02.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 02:57:24 -0800 (PST)
Message-ID: <9b43c3b6-02aa-498a-9287-b1c9d9027460@gmail.com>
Date: Sat, 21 Nov 2026 11:57:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/43] drm/vkms: Explicitly display connector status
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
 llvm@lists.linux.dev, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?=
 <jose.exposito@redhat.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-1-78ace90f4fc1@bootlin.com>
Content-Language: en-US
From: Oarora Etimis <oaroraetimis@gmail.com>
In-Reply-To: <20261120-vkms-all-config-v6-1-78ace90f4fc1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Debug information are mainly read by human, so use full name instead
> of raw values for connector status.
>
> Reviewed-by: José Expósito <jose.exposito@redhat.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_config.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 5a654d6dead8..48c60930302f 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -2,6 +2,7 @@
>   
>   #include <linux/slab.h>
>   
> +#include <drm/drm_connector.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_debugfs.h>
>   #include <kunit/visibility.h>
> @@ -367,8 +368,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
>   
>   	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
>   		seq_puts(m, "connector:\n");
> -		seq_printf(m, "\tstatus=%d\n",
> -			   vkms_config_connector_get_status(connector_cfg));
> +		seq_printf(m, "\tstatus=%s\n",
> +			   drm_get_connector_status_name(
> +				   vkms_config_connector_get_status(connector_cfg)));
>   	}
>   
>   	return 0;
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
