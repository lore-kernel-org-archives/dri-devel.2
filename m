Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A8606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=YZYx/x2t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EB210E696;
	Thu, 12 Nov 2026 13:46:46 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CD010E696
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:46:40 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c4d2b741ed9so675752166b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1794491198; x=1795095998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2yGUa3yvv9BwAmjth7xVSNIdT1WjubKlsaL334MWC0w=;
 b=YZYx/x2tRdnD6egWozYt3L2lZA2Q+9e5StZUvkPgmlq0m54Snk2G7QxJrPX3fVPSQw
 wSjZmp5LYdg7FO5hhZYloHYkHyW+smg1p6SxniDMIbxt6G41pENHq/ZQKQt72RV7Wfu5
 7ZfbwqNyKvdvioi0Q8QHUAEki4BYwggCVxATGzMfMRpMXV9rsWbmlah3nyfd/nQQSLcW
 DQ5WAQMxUxP/YhvYYzsJP9kSaRIbcpP+TkhqYEMFEf2VvPh+Rv2nPg/w5G04wvFpXS5P
 WhxV7Jz673qPWqYkRgvaHTTfpv9Aj61Yx5oilrUPrBpkyou7z1liqPcetYOF+Cm06nmh
 IEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794491198; x=1795095998;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2yGUa3yvv9BwAmjth7xVSNIdT1WjubKlsaL334MWC0w=;
 b=R5h5hoRRmKLR20sAMDwtpkfCPHL8UqFnidTftXdE8hulopLGImY0VmkYpHRD+0CDpE
 bkOUwWGK1PhaCvEwtHVZwYav68xeFkC1ExD5DBupvinP5khqTdh2UTx5XxQRCKRp4rCB
 w4wX6CWwH7O0E8N6voOW2bbZtGAcYxrzFOU37Srowep68tWYA+j11/3orQ/TZLoiA4DQ
 cKRW3IRTHNjYZimGpuBGvxVZkF89g6Q0psnIehF9CoPIlt98Pdwctws9uqNWdn1CnMnz
 YNbQ1HM5gmp3+WG5RTsGTOCohUhRxcV5XZerSSTzmBec0X4iAOW5vCbegIcIXZ3e/C3a
 II3w==
X-Forwarded-Encrypted: i=1;
 AL+hErFo51nb5TIwSrZYM5QRgB1PeSwLjlclAbCxvSqATe33pRt7JM6HbPe5pLl0S60KbSBHERD6VARlN4c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8K9uUDyq3JYII73hf9eXdFW8bhYspJmr9S8wCBZqffamSTEKbB
 Y6pFxlzEU7fau1b6MFg8Szth3iHZAOmrTD/x/SCSvY7+cQyg0jkzLxXJoXm1Q+a1B9E=
X-Gm-Gg: AYBFou28QkVJde4xgYRvDFY8f9c78RO1ngD7Q+VFhkHAHsKNS2OvRruTeNFG9Po0ZPa
 7u4bgXSaPelhMFlgDkRh/qDdxriuVG8EF1nf9rVmRsAclZw7QU69TfM4Zr2UuLKzKuDdR+haeU2
 w0ECiWlGmrgj8BNieWu6xeujA1RZzfkXAe4k9KSJMmYOTFf5COVCGVfaiMOx6UEs0GkcL2iuyIh
 Bjw/+EUGdMyME+ch5C2q282cJ2og2vV/93yQSTnO5pfRY2AVTIA+eaRD8QpkLQd+xGXFDAU9VPx
 YHrhIeSZctKlJRAQLwdQthF8pDPrXTvcXvs+140fdBK+mcfAcl+AZUi/3C2Z4qMCPWR6dAAMwD0
 Njmlt7xmyAPEX9k3tvXA9uZIWf5wJ48nfT3CJLsl21L3uoObpvb2vVTdK9VK+Y6Ji4JIsthzj2W
 D5pI3UTHpExehWL6JSo6O3wJ2blXiXOiobj+8F0Tq3pSZwdEfP9r0dvNKTMJe6X7sIo2j1VxCaI
 1nrlNoIOOxC56IAGz+w+KMLRGvWjlBNdTEPuc5qdxG2W/trmXh4D6RRjsOEIB6UChkSbUQnWuTb
 oaCqwPHtaQrk/D8hIbpS83sx+8xhTn5r9hurunIFjIhHvA==
X-Received: by 2002:a17:906:f587:b0:c4d:31c5:cda with SMTP id
 a640c23a62f3a-c5066ae249bmr493311766b.21.1794491198313; 
 Thu, 12 Nov 2026 05:46:38 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a5d54bbsm349754666b.48.2026.11.12.05.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 05:46:37 -0800 (PST)
Message-ID: <fc21d057-be4a-4cea-ab92-0951c4eb7de2@ursulin.net>
Date: Thu, 12 Nov 2026 13:46:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Gyeyoung Baek <gye976@gmail.com>, Philipp Stanner <phasta@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
 <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
 <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
 <au31m2jC9SmQ6iZh@rock-5b-plus>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <au31m2jC9SmQ6iZh@rock-5b-plus>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 06/11/2026 15:44, Sidong Yang wrote:
> On Thu, Nov 05, 2026 at 11:04:29AM +0000, Tvrtko Ursulin wrote:
>> It would just be adding u64 drm_sched_entity_get_runtime(entity).
>> Nothing else would need to be exported and the implementation simply
>> locks entity->stats and returns the runtime. As long as the caller knows
>> they haven't destroyed the entity it is safe since entity holds a
>> reference to the stats object.
> 
> Thanks for the suggestion. If Philipp and Danilo are fine with it, may I
> add drm_sched_entity_get_runtime() and switch rocket to it in v5?

I am neither Philipp nor Danilo but I would say go for it.

Regards,

Tvrtko

