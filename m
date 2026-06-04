Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD712CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5E38A03E;
	Thu,  4 Jun 2026 21:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="al6E8Awa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB80C10E3FA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780610073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDPVm1AJlqD7pxLo2N44HveMpvqTZuENh9GvAM0K9UE=;
 b=al6E8AwaFgTFalT0uuOh8VyY6AYkkCoanYMYjfHSyUNce7QgrfCPSnLHYBqggAYxPkdvAn
 UqFYwUsBupXMcwOH8z//Ront/8naakNgyacLN0Chts8kOakk47mA9cj7SkHkeJZipKFVJU
 p4FjU/m0XVFjwBBtTkv5zpsoSYlMJ+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-GsGj383dO6WgeDiu8BB8nA-1; Thu, 04 Jun 2026 17:54:32 -0400
X-MC-Unique: GsGj383dO6WgeDiu8BB8nA-1
X-Mimecast-MFC-AGG-ID: GsGj383dO6WgeDiu8BB8nA_1780610071
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ace40f13so5650725e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 14:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780610071; x=1781214871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDPVm1AJlqD7pxLo2N44HveMpvqTZuENh9GvAM0K9UE=;
 b=r74e8jFjPea1eTm76ayqtBj6Cc3Y7+h3Bhu46a+//hGEYmAC3sSq7qHOW+idKzTtJk
 TD0MCNcWsHns9P6dYHk8a2Ald4rjpDIB5WzUOYOmrJ/YfvoMXtWM/TK7BoV7dFlnS/LQ
 +iiuCxlE69L/ylu9UgXtmoFJ/Gbuk/wPFyycgb/iM/Xc0CPKDhn5LSJFA4gC991yxA/r
 zJa3KMOBKsKTDrF7YHWU3Foen/jumWVLdlW1xHd9OJ4c8VnhRygCY7fznakSoCbF+cWW
 Gjy741qP9v4BYCZliaiYy9KEPhJC3D3CdvtsuTpM2P1upmB5fBuo7lOmqGVjwFI3Wwo1
 UcQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+79l49F+0D8VGfszbKJ2tGdbTuPKBayymuK9kwhvITPzCuDovodtWMBbELx13Bl73/exgakKNCavk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEMF90Jkrmg7Os7PMPn0/kfecoXuXo16egjYZz9Siluu8z+wV4
 VuHBSoaVLao8P0jHRuBElF9Nfh6wU6GPrf5TSk9FSXDZ3fiWqaeHOf36H0h7DUKIaAoE0YmHgr4
 mYW1wdRIP6lVsKxXjREOjdHeR57tPtLBvd1IEd9gR4WHoGHIcsH92EE0Jy5s/YvfVfg441XRROn
 7Izw==
X-Gm-Gg: Acq92OHWGmkQBLn1UdYKrA/i254O0SgqnVXnRcd+GSFkknkt6eTjIxmJ8URL6mvoZfQ
 HtslxF8/A6vDwV8IeDUuy5MTMABL7nRCb87TcjJQbJP9VmSUIZmWLQoIsh9Nu+R7LaElU0NFkDy
 zNBxY3jC04L/PFYPixV8vqVMYydj0Paseow+2QdchVl3UHpHfBQ1er+nrJLYlr9VUorCJquKdSW
 XmANhaiZAY3ukzo+GRaYmPM2QWT9CHBWmcp5jx3wQqmV8AEKk2zGXSAvA5ElK/s5+m8qDfwVeKC
 Ad5lFbrK7cQrG0MQBfXchnnDAdtQuQFH/Jly75Yi5ShV5SYsMo7iuwgOZDOLE+vwjfTq6SasJWc
 yrrov1g/ZaKJEGW8xSwUDNCZz55D5GVBiCYGXOiZtKld3qlyFgzIREPivpSmOKCu+VwFezoCe
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490c2616e16mr5240225e9.28.1780610071247; 
 Thu, 04 Jun 2026 14:54:31 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490c2616e16mr5240005e9.28.1780610070894; 
 Thu, 04 Jun 2026 14:54:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8?
 ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490be1f69bcsm86932005e9.8.2026.06.04.14.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 14:54:30 -0700 (PDT)
Message-ID: <81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com>
Date: Thu, 4 Jun 2026 23:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why do DRM_PANIC QR codes not use data: URIs?
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>, dri-devel@lists.freedesktop.org
References: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: STW_t8dmhOxeYzPk93YSmas9bm7TBKu8XAOk6nseUio_1780610071
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03/06/2026 16:20, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:
> Why do they not use data: URIs so that it works offline?

If you set DRM_PANIC_SCREEN_QR_CODE and not 
DRM_PANIC_SCREEN_QR_CODE_URL, then the data will be set in raw in the QR 
code, and that works offline.

The drawback is that the data is not compressed, and not efficiently 
encoded.

So with zlib compressed, you have about ~7500 bytes of kmsg, and with 
raw data, it's only ~2900 bytes.

Also, even when using an URL, the panic data stays on the browser, 
because the data is in an URI fragment, which is not sent to the server.

Best regards,

-- 

Jocelyn

