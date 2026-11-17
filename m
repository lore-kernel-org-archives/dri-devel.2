Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=a+9hWyxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499A110E644;
	Tue, 17 Nov 2026 16:35:20 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06D610E644
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:35:13 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so15167135e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794933312; x=1795538112;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z8CIfRuBE0dh3C1ZRhqXdDSEMv+0cdiVuIl1a6bMpog=;
 b=a+9hWyxGeRZz0ZEJ9gpUXzL+wvarGVyfIyRBjDO6NZRpOwRr/BRqxxLO6sk6xgVeW+
 VOP6YA8K7p8cmutTvoAXh+Ul5iXo0FE17eFAhK1MTfmriAPzfS4bMrPQmgWxM9ZEX0T3
 Hw/yMHon6EJPr0xcmCpZMCsVx520MWS07h80Y9gl1zq1KIu0Vg4oyuJHr2SxU62LR+JH
 xvF0/LnfuYRVbK12XPR+hzgc7qem/vjRuFKtzKGzCixHcZh+kv6R0Sp4mrnK+3eWWT7l
 MLnyLaMikpP3dynBAyYbasJNAqMrjKV8Ob2ImEPxdXtsJEj4WxNp2TqYrXeh5T4qOZOr
 bEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794933312; x=1795538112;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8CIfRuBE0dh3C1ZRhqXdDSEMv+0cdiVuIl1a6bMpog=;
 b=i4fyqniSb3qyttgLvq5mlUmbJXlUkvXdEFmB82srVbmE0aLb0BwzK65mJNkTEyOKZo
 KItNR5jL4xI0K3K3VmZzInu2Q/gOP5q5/aeGkwzmjF7HGAvThNQaGkXqzDvjWZkHEoBI
 pi5zaEeMwJ/XYtHCKV0iHfxw9JCL/R3PqN+10uyTUGRjwaXhUca6ZRmw+RJvboRJzJzO
 +5JErWkPcq146i2l2F8rnGnzKlj7S2IpD2rr5lmrDjU0mWjm0/+zLQ2Q62olmxjv3fPf
 TXjWAsuqA5sJnkG/zNeeXt1Ml5X7EjJPhAEhECD7biRGX+2r5Qnt3Pa/Bhsui3ndWaHZ
 et7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHkF8mAxIhSgFuy2f0X1eEUvu+GuZ7VKP3/gR+3FW/L8KAAbrL3tCPJ7ewY6gJFKM+bXdt45PZy4CU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NF3fs7xdFgG088JfoZGNndR5+ws75jdJn8guQ5V0Gdtg1kcr6
 RJeUBsFvd1e0BxUvv+nzA9n7baKXEn4yNK61LSLHkuHBvvNVi0cwfGoI+dieEXtLcV4=
X-Gm-Gg: AYBFou1FmEWaX1todEcKDfi7LBQ+hwtZYNHAIzqxoryN2jEMD1STjuj4zjQ/HFKKXf9
 BXoCZjwX9OO+tVU++cxAWv2AcdgDZmcfSccsGPvM1zyqdcXcc0ixClpVcS9kEGf5QCr7vqzvcwA
 QM7Bg33AXC5dfLzaBwdS9qIiHy5ZgKH6929LDfD7dz913EF2xRLxiJ/u7SPQLfzhQj9JCzOoFPt
 1xIcr0a7DVr2XrcQgB8I2RJEbsmoy7tcLMZKGlsoRqaeFeNQetE7x9lyAERaUd7U/LzBfy2PyRa
 3oSueMZVWrrxaj2ltoiZnfllWKa68v8A72AbQ/liuxW72NfOogFM2QYS6dxWfIzmzRaiww9vrGw
 hzZHwAHWWky3BmJ/7LHLHFb5+q57eWnRXa/7pHZH8UByrndu7qBPwBzE5utos8CQ8VLv21GKeVW
 YwDlvMZIhlTuvI1KeEbFGudqfzfxJQILBO9a6/00xbVeVEJbsKTgDshERWil3l/HRAREdLPqE03
 G2naGe4s08euCNaxG2+fgv50R+jhH3uJIxXT7n3P2zqs/s2/npGNZh1bDFvYsHe+0l8mGHcpBAy
 4NpQX8LIh9xDlokvdLrQc0gV3So3Msj/1sAROxph9BhF2s5UfXO9MiBpHslt504JiR4hM2lf0CY
 EBg==
X-Received: by 2002:a05:600c:4513:b0:4bb:687c:4fbe with SMTP id
 5b1f17b1804b1-4bb7837c4e5mr72201605e9.8.1794933312192; 
 Tue, 17 Nov 2026 08:35:12 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7838c6a7sm71536475e9.5.2026.11.17.08.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 08:35:11 -0800 (PST)
Message-ID: <9429350a-4c59-419c-80da-7f6d3768cfce@baylibre.com>
Date: Tue, 17 Nov 2026 16:35:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/rocket: Fix NULL deref and double-free in job
 submit error path
To: D D <dhabal123@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: simona@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <CA+g3TbucTCsgvGaywNqyZdh5g-889zK06WZ57Mpxm1qOpgYTfA@mail.gmail.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <CA+g3TbucTCsgvGaywNqyZdh5g-889zK06WZ57Mpxm1qOpgYTfA@mail.gmail.com>
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

Hi,

On 27/05/2026 15:33, D D wrote:
> Hi Tomeu,
> 
> Two bugs in the job submission error path in rocket_job.c:
> 
> 1) rocket_job_cleanup() unconditionally calls
>     rocket_iommu_domain_put(job->domain), but job->domain is only
>     assigned after all fallible operations in
>     rocket_ioctl_submit_job(). On early failure, job->domain is NULL,
>     causing a NULL pointer dereference.
> 
> 2) rocket_copy_tasks() frees rjob->tasks on its error path but does
>     not NULL the pointer. rocket_job_cleanup() frees it again,
>     resulting in a double-free.
Please read the kernel docs on submitting patches, you cannot submit 
them as attachments.

You also need to rewrite the commit messages to be easily readable by 
overloaded kernel maintainers. If you are including 10+ 
function/variable names in a single paragraph, or translating C code 
into English, it is a sign the commit message is not useful.

Thanks
Daniel

