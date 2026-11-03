Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A4606A336
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owGK/BlS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB10F10F5A9;
	Tue,  3 Nov 2026 13:27:48 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515B410F5A9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:27:42 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c445c95d553so566816666b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793712461; x=1794317261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xRUzoMUosdglIXL7NO1Kr4njcuwduorg+AuPTQxBoIM=;
 b=owGK/BlSZLaEYPFLCRbf18sFAGOjV4WgKPnw5RKPuvhYsQyh7/qIb96As9f4EJUpP+
 zJ1glqQSDZG/gzeMEWGvs7PIo9dWmMfl5CW9xs/PNT7tlIQGFzifQcNAO6SJmuF6HKrn
 NAKMnPCgcnrWlmD3VDYSsZYS5NpY8+i01owAOv3WJ6ndqqIMyghrlc90Z18kz67PrZYz
 uYbcwwcNC9DqXS6z3ahpRu/f/YvV97L7AHIOBdXRnRM7d9x6GzO3XHF3Kj3SEVXhop2n
 iiCH/IB6VO4lyk7Mhosk0u7mSwSGpEJNJffz5YKhb9pIVaGYOmUh75FEvAvLRCOsTnii
 EjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712461; x=1794317261;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRUzoMUosdglIXL7NO1Kr4njcuwduorg+AuPTQxBoIM=;
 b=KxJf/urmPMjEEfVePawemoBUGil3l9/gXpHVyqjgfwTl2QzGrfNtZgW2Zh9NkWuo/1
 Z9ynyQXarWHJ4cRgbhyz39OQVm226lvq/cUhAE8t47Q7zDmxoYzr6WAv8JPGF5kK65pi
 8uVZPX9Nai4Yfkglz3fBOQVpL2ofUV+9EPPYzfrdpas1i5X6tH856NJ7H+VPBz5oVXp6
 /A/2JsAq4I2js8cJbadxEUk81mRmbmg/geGygGuc8i0iaV2Oe3gwYY+Z1fbfujeTA84B
 5uZN5/nx1d1Ruvia4iqeLVKNSwnuVU3KWhuPBCms9xvoTzQJvChKBun3NRC6MGZLtDz1
 wAag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc1OIg7+VlLbAj5VF3RkmYxM4AXXfgoMhNMyf2lkbO9wuwpXgsAYtF5+3POnkZU3PfhKubtFrAP9s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gs85xx3+wy7U7btsg0oqCa1/lMna9t1pInytf99CO0Xt660dE
 0o711KynH4O8elk1XpB8+oVkWR4TNLAZJoH0s8BACeyK9Omstz4JgTc=
X-Gm-Gg: AYBFou3x73bOymxmRTwtfMCS63ZAUVNkqU1ScNjhYpSOs+P/tcUCoZ+04CnQIucWOkw
 CIIWSDzlmQr7kAFQqhbawz4TOcv8ZeEwTFxjBcr3CFwRCk50K9BmrW2mq4ASIqbJgnLsTGsYR7f
 syjxsdyk5f4OFkIpMQCoUveIbncX/QaawiCdI2E8a5o1GzhQspqN5s2TMg1F+Y8pxvYobu5S5mg
 5HhVXJgEpWOIEiPZ8lcF68opwMLSh5yuTSbgHXiS9D5ot3Ek3E4qw48xz5YfLAqRp0R1EDeveOQ
 eCUIMWtrBf9u+bzLwRaesJEhvHrhPqVGY8dVkVleL0lYLF1Qugqh3QmG+5aCvtaLlZhuDVbERHx
 aQuw6K5F+lHWSo33OWTfKu1yrCWhIr+bhQFKS6fBiZPRGsG6pHP+LWGj9Q7VnJPTFIMgqAGClc3
 dgE3BZTUYOAXq6TMmKdCaXcLZ1/i+QB1X1dQnLfPSXinpqUxkxKBY/Ti7KO+1UsJe19iPtmCNKQ
 dMhfLaGNGohD972YrC2iuIsVj9V5ngfNdvuFUM2vjfNJMuuoHkkrpR0VpRE0XIge/c7336D2+dX
 /28dfmiTq6xVv6iKv1tC1NkiAm/t2uBtSKg2o2wkBeOSGlnDTp1ID2oFf/aJUy37E3fpUSLkEsb
 yvHuwMBFy
X-Received: by 2002:a17:907:3e9b:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c4ca7a887c7mr1045052766b.21.1793712460530; 
 Tue, 03 Nov 2026 05:27:40 -0800 (PST)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e7a1d9d71sm19668686f8f.48.2026.11.03.05.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 05:27:39 -0800 (PST)
Message-ID: <951eab35-75d5-49b2-8f82-984aa4864c71@gmail.com>
Date: Tue, 3 Nov 2026 14:27:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/msm: Inhibit IFPC for state snapshot
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
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

On 11/2/26 8:00 PM, Rob Clark wrote:
> We need the GPU to stay awake for this.
>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/msm_debugfs.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index aa59b28a3392..29209c23fcfa 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
>   		return -ENOMEM;
>   
>   	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		guard(ifpc_disable)(gpu);
> +
>   		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
>   			msm_gpu_hw_init(gpu);
>   			show_priv->state = gpu->funcs->gpu_state_get(gpu);

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

