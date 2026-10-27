Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aZ7C36FF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62D810E220;
	Tue, 27 Oct 2026 09:00:35 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC7110F2D1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:00:30 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so4303455e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793091628; x=1793696428; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9WCkf6QzTLTdkFQ4qPzTcHJh7ncWmxtj0NsBOYpx7Cs=;
 b=aZ7C36FFG9nPmZhb4/dAHJJp+heY4/QMMojiOZ8kjEjvLlBxJ3qKujY17Vnz2wRsMI
 NpTGJUSQRTyF1hfFo2XB64oQGI2iWP4gvK9Y5m41jPchnX+pX2jR2acFoDkvQRUAbqnv
 sTqpxvvPNwPsR9IHXc1srfODQKw6ha06aw4Db6IJt1XtlurI2OqqOmB7MgGPDQLOJCsl
 TFB/ksjhTF1LfGSQfEKyvgF1/zsNJzgavp3mNz1c9kKC7L+e1rnlLAnL4fZuCELiuU1m
 eC5Kri8WnHIBRzyxZz4spyYCLMnIbl7aMpW4fSTOks5sob4FuUmtOH6EJpyW2KlUCjVr
 JORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091628; x=1793696428;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9WCkf6QzTLTdkFQ4qPzTcHJh7ncWmxtj0NsBOYpx7Cs=;
 b=YvEMOAvjqUP/QVdFonh1ctJ10AU4gOEFJfThoNISm4xk9LpL/GaIv5nQKVwMYaFZLN
 t2GZ4SE85w/Q81ApYnqQjDMvIUWM9EOG/bBg+2EnHntO94I2OxMfTQDh/rnihyo1j+pt
 BndRftCI6E5W3AULmSyY4K4cWbyXwfJjRwUTbKE/pJ5QuRpLsEPUtij1BGxCgxlwOjXs
 ZtLFWUVT3EUHPaFU/s/ZNknmyATUc/Zr3HZ+tHGgo496fexWbkcgxqU5Orjd7UnLTBXw
 ZmVMpe9h5P10EVs3TUFc0TDBEpxFdIerSNMmjB2+SR2Ai7wE/11b4dp8hLnE3wDquum2
 1NVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzE8cDmZWqOcN+1yH0rb8MM/zJlTPro/K70XDS28pplGSeyNfaKL5HG2c2CmTZx+vV2EYdeENEhqI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFJruQJP+KtEWOm39eodafkIXHmvYzr7Z7LBnnRF3Ryc43pddQ
 xI3PZerHjR3zl8l1h4rDNsDYGOqsXbnpAsNpvO/WBIxFbh6NKb3YT75t+XhbM+3cC/M=
X-Gm-Gg: AYBFou3Fnc/ryW6bIMGKKWLxrjQd9KYdOUo4+qlz9U87uxm7zNV/I6QkvH6KwFl9SQJ
 LXULrD82vxMH5rbxxAzEvb0lI2WGWGxpwONpEtiBjKKTj3pe8+Ej7VeXLYfOGXVPp8jLHmfYRsK
 T/KrcUW1ce/PM211jhQtMC2+/Gc0R0J4xJodGaVotpKf7/HTe+NpDT8JMV4pggmv+XGzfUfWH0a
 UNHQkEfIaZogYO3ImplBq57wtAFvsHbCsgyVghdSSDyhVK0AF4eA5j3HAzVjI/0opgxMywMm9EC
 6Ih4NJy25l/uLFbj8UNA3uksLIgsxUlm1sdDWi9YSvm6LD1C64BLKhDg6dtwhOnxHyQU5xHSGlR
 WD6PB6bgtzgT9G5OaloOZRSudpEWhiAdnjdsT0PN39qa0o1R0aySDIZAQDlMtpm+wUNDPP3KHkh
 MblDlJyaVc8ul/sqYUFuJ2bHmC/wZZ3kwJH+l/g8V/Fb4dpUa5PpMco64hAAmCnGE81tStBY5ON
 04xoQje82ozJnSAwsP4K804EF/OL91bzpnUvUvtmGIDk4fRFDManruPYijL417HSYF0c/gkH+ky
 vg==
X-Received: by 2002:a05:600c:34cb:b0:4a8:a341:2377 with SMTP id
 5b1f17b1804b1-4a8a34123eemr7244685e9.3.1793091628213; 
 Tue, 27 Oct 2026 02:00:28 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbb725sm251375205e9.0.2026.10.27.02.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:00:27 -0700 (PDT)
Message-ID: <3e3b9652-7de5-4391-8b5d-122f00c4b585@suse.com>
Date: Tue, 27 Oct 2026 10:00:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev: Replace __MODULE_STRING() with __stringify()
To: Thomas Zimmermann <tzimmermann@suse.de>, Sasha Levin <sashal@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022175543.1831620-1-sashal@kernel.org>
 <2a9b1325-386b-4460-8651-13fc43dca6c6@suse.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2a9b1325-386b-4460-8651-13fc43dca6c6@suse.de>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 10:51 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.10.26 um 19:55 schrieb Sasha Levin:
>> Commit 08abfa5a161e ("drivers: Replace __MODULE_STRING() with
>> __stringify()") converted the drm_fbdev_overalloc parameter description
>> in drm_fb_helper.c ahead of the removal of __MODULE_STRING().
>>
>> Commit 6b5a66fd9f21 ("drm/fbdev: Move fbdev module parameters next to
>> module init") moved that parameter into drm_kms_helper_common.c while it
>> still used __MODULE_STRING(), so the conversion never reached the moved
>> code. drm_kms_helper_common.c is now the last user of the macro, and
>> removing the macro breaks the build with CONFIG_DRM_FBDEV_EMULATION=y:
>>
>>    drivers/gpu/drm/drm_kms_helper_common.c:46:18: error: expected ')' before '__MODULE_STRING'
>>
>> Use __stringify() instead. The parameter description is unchanged.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
>> ---
>> This depends on 6b5a66fd9f21 in drm-next and 08abfa5a161e in
>> modules-next, both queued for 7.4. Petr plans to remove
>> __MODULE_STRING() once his conversions are in mainline, so this needs to
>> land first, either through drm-misc after 7.4-rc1 or together with the
>> removal patch.
> 
> Dave, could we put this patch directly into drm-next? It seems like this fixes a broken merge commit.
It looks like Linus took care of this. Merge commit 5b0764a53235 ("Merge
tag 'drm-next-2026-10-21' of https://gitlab.freedesktop.org/drm/kernel")
updated drivers/gpu/drm/drm_kms_helper_common.c to use __stringify()
instead of __MODULE_STRING(). The current mainline has no remaining uses of
__MODULE_STRING().

-- 
Thanks,
Petr

