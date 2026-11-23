Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEE606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q9RoxlwF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD4310EECE;
	Mon, 23 Nov 2026 15:00:41 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586F610EED1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:00:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EF6111A1795;
 Mon, 23 Nov 2026 15:00:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 952C0601E1;
 Mon, 23 Nov 2026 15:00:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D950811E68EB8; Mon, 23 Nov 2026 16:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795446015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=byP1kMDVZHEXOHaPsdzqxrOuK3QLySv9pjAZMI2VCWQ=;
 b=Q9RoxlwFV/d7u3pieMNnWNcAZHglsNUae4Eh1WJnS0nCUIFvoSZB3cmzBOOr0ZH99awg+T
 islPHguKhHYqVdkKu4dooqt+kDfirixH6wFTZ3FY73v0hvN1c7zO2JeQqVX5SWMP8JsUYg
 g0lGE5MYSQZMJhLLZsUa36jmO7AnlgjUjQuHDGAalDYCnqga6HG0PdAbMKsL/9vuaWV21R
 5pc6tph3UobKuaiAjjI2ENhlOri/5EQU3qdyFgcoyGWnmqnfstRRXwRK838byy5hmadLQz
 fdIB10/niK5sJ8IcgVAKvTt4o65XAJUmJD8yjAb/PShd/XHlOg0S68ltfAFrqA==
Message-ID: <18c7d8af-1156-4bee-be0d-f78334d1908d@bootlin.com>
Date: Mon, 23 Nov 2026 16:00:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/43] drm/vkms: Introduce config for plane name
To: Oarora Etimis <oaroraetimis@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>,
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
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
 <awRQxKxzVyw10pFr@ArchOarora>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <awRQxKxzVyw10pFr@ArchOarora>
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



On 11/23/26 15:56, Oarora Etimis wrote:
>> @@ -265,7 +266,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>>   					   &vkms_plane_funcs,
>>   					   vkms_formats, ARRAY_SIZE(vkms_formats),
>>   					   NULL, vkms_config_plane_get_type(plane_cfg),
>> -					   NULL);
>> +					   "%s", vkms_config_plane_get_name(plane_cfg));
>>   	if (IS_ERR(plane))
>>   		return plane;
>>
> 
> Small one: with no name configured,every plane ends up as "null",so they all look the same in the debugfs listing. Before this patch, the core named: "plane-d", which was pretty handy.
> 
> Could we keep that fallback when the name is missing, as it can improve readability? :)
> 

Make sense, I will do it for the next iteration:

if (get_name())
	init(... %s, get_name())
else
	init(..., NULL)

Can I keep your R-by with this change?

> 
> Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
> 
> Thanks,
> Oarora Etimis

