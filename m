Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E8C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0637310E4BF;
	Thu, 13 Aug 2026 14:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="e/TyMpIW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07CD10E4BF
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786630015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0qjcKO/+/C/XOXqXmwloOkNNQSRaO5VUx5n09b3OF0=;
 b=e/TyMpIWCdQs2u7FuSUuVegv/m9jOUpCGB2BCKfLUTn8DMOAt40BohasUkc/Jn7Y31tq6L
 J1UMHD3m205YG0+MnkQ+JsmQiEZGwk01x4hrw25NPDB4hGEybJ/3ne3vvtc8N+uIrUoihx
 TQ5S42gnvPv/gtbwZW0Uf5NM1pcSMTI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-p9cXQXUWNj-kd7fqsyDilA-1; Thu, 13 Aug 2026 10:06:53 -0400
X-MC-Unique: p9cXQXUWNj-kd7fqsyDilA-1
X-Mimecast-MFC-AGG-ID: p9cXQXUWNj-kd7fqsyDilA_1786630012
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-481558a96e2so1169396f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786630012; x=1787234812;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r0qjcKO/+/C/XOXqXmwloOkNNQSRaO5VUx5n09b3OF0=;
 b=Pxjjr5VWhpFAI2C6AzpZVUMQ/S44DTprt6+iFLC0u35no8NBjJUZlZts3pw/IdCBQc
 jLcSpqs60v95ccT9DWofPk+7DcrAN1PCBIIln7gHLnBBAAc2hLFgpNrVcTytYDB9bLzF
 O/rTd03nwPR6DDfaIV1RRt1+HBJBPx726eAxp5jZ3WvIZk4y8DSpECnFI1f0n1H0apJz
 4y4HdB4AZW05oJu4FwjFZjuupMZXJgvMtajf8hKSJ7zkVv2TWrVD2Rh9qxmC8ORuoUSs
 aVYW8PPx9igEb3c3hMhBukUgHAsTTqmnpURaHuIhBiSSWn7Je0kWLm9SrTgRdq7olOgw
 ipbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxzgolFMEHDnyRAZX6L9IIH+F9PyyVK7Ak8SuYkxAUxN9oPAFeei/QYYs0jfcD5+1jXFH82iHtBFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN9sFpwjpjHsNIi6oJNa0CVx1Y08wH4u3sF/Em5ZW2XSwZ6hnW
 3t/H6hrbyB6KXuBkrpSj12wYQAWWCdyPg6iH3cjLvW2u8V9W2WWgubtxYC20l+YnllL/6csSND+
 vljNqH9yUrfnzgY7wRctNAa3qlv3Gnd/NaNN84gX85qebNKWTSBuevPym2iqvnW6/VUBr9w==
X-Gm-Gg: AR+sD11Py43p0R2nzHiuY/leQhcn1JCJTPwTkoJjEHfBtZVIlduQSbEumX9vGJAb3Qw
 eas69Kw60xEYYbkmqtwMxz+V74eF6VuNCFcyDbOSAqm+mNCzUV98ctRb/eBs9NuwzEj9sEC5woB
 CUN1j6lIgccP7YbUrPMsEy3oaCvK3/DX+9dks1E/47pH+VJc3YJGgrlVuHgyxudtjUZULlG6xrX
 0lNI0FXs5JYcuRtYYJtigpPwAHgINqFy0LPgTIdq4J0WC8umrQjm9TVArzDe2lQAgtn7SjKHZwN
 NHHWOdpUaDTv5eJocFMXGTUg9/txIX37eMUXVhaH72gW3RVqFh0m77+BMxfXYiL2KhC5umsM/d8
 YW2Nj6EUVP+XUpWMxIl1q5K6Tlv07K0jfQwtKn3qtgZOcVA==
X-Received: by 2002:a05:6000:4715:b0:47f:93e2:a07b with SMTP id
 ffacd0b85a97d-4815a00d89cmr9228637f8f.30.1786630012331; 
 Thu, 13 Aug 2026 07:06:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4715:b0:47f:93e2:a07b with SMTP id
 ffacd0b85a97d-4815a00d89cmr9228547f8f.30.1786630011905; 
 Thu, 13 Aug 2026 07:06:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:27a0:d75a:edd2:a62?
 ([2a01:e0a:11aa:87f0:27a0:d75a:edd2:a62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5612d0sm6990692f8f.2.2026.08.13.07.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 07:06:50 -0700 (PDT)
Message-ID: <1a5bfaf2-2363-4795-96c7-223c589e8df4@redhat.com>
Date: Thu, 13 Aug 2026 16:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/log: Fix out-of-bounds read on empty message
 length
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20260729084520.688087-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260729084520.688087-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gr9I3T6pIxdK8QJNl2kv1ef_mpaiDfys4ZOgkWtvPO4_1786630012
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I just pushed the 4 patches.

The 3 fixes to drm-misc-fixes, and the vmap/unmap optimization to 
drm-misc-next.

Thanks for your contribution.

-- 

Jocelyn Falempe

