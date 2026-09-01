Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A0C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D18410EED2;
	Tue,  1 Sep 2026 19:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cY6WgTNe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552B510EED2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788292516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2777MRqkHHDOXl9YhBOlEzmHGlKVDToTlF462SeCB8Q=;
 b=cY6WgTNey+oAjL/R5Oh/dnKgzyE84uArNch0M5M0ltdQOQO7/UjqpFqgYiV+KITj/3jgH5
 B3gW3BVn6andYLsMD8wqmqH4rPTc16ywgeoQ3MHPa4sLUBWEqvZl1RgzV/79elEkiMlM5c
 s/SfSbDhAl19Gwi7m3OVvBPlNzjLrfE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-NlifdjvFMy2uxp15V2AefQ-1; Tue, 01 Sept 2026 15:55:15 -0400
X-MC-Unique: NlifdjvFMy2uxp15V2AefQ-1
X-Mimecast-MFC-AGG-ID: NlifdjvFMy2uxp15V2AefQ_1788292514
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9394ad7f64aso61530085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 12:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292514; x=1788897314;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2777MRqkHHDOXl9YhBOlEzmHGlKVDToTlF462SeCB8Q=;
 b=bhqdKUtK9MQB0W6QSdKRShoAyEjx5ZFRvhW0aXyzTVrGwKisXd3VvG9I047Nmg2+33
 5d8EmR4EATHNUp9BuDgd9dk/1ldug+xfUyLeKF/bLHAM4AWDMAv7ePdcqvj/SEnhb70A
 2tuXiFb/d2Askmp2PunsBATJrHq7luXvwvyz6wRKANJCs5l+b4EhNzj4+7uXfpr6YHyc
 VqLPYcOGXP1TMJzlNDuu0zc2/66y027xNtoZWs87G5gLKQ5Ju3E5/C+62Rxolh6BcWZs
 osCoplZCDCh3JtX43VA7RpW2oEpu8qakXvHOIyYU96KdmrieMu6C5Q2IodS5muh8iG69
 Q3Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqApC+trSn3l2BEcqhBssAM8I9tEwsHfPQ1rCSt3sY3ypDSB/ikGm7Q6Sao6mN9QtZHaB0ZIHkc178=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laprdpu1wM0iKaACdf+D9vXGUfyDp0mCFDm0rljbNhrtHTCWFR
 nZsLn8LQuw7fzIlgB+KiibstUEeDZLJkp5XUNhfTSKZaPzrUDhc9tdtbKEkYf5/KuYx6fMobUoK
 KtXY6U+4BhUXflQAFLyxIdq2MYaHLKdR9ESKXoGFSeA+31SdT1ZRw+ViYlntc3OAdwxPzsQ==
X-Gm-Gg: AR+sD13Zf/DtTqhaWScTAgrw1VM8DeQabTcmVMJhOYd3q1n5/X/dBhTe1dsAg39P4UX
 h6EbsnWs9AvHayYYQs0yk3utPVhK812KtDGOajHt9g8ywehi7HcVdYLqiaQRjr1qX9vq3+9Myn2
 Efqjza3bmLzHqENJWH8lJ+AyXtWHqbIz0kUz7JLHcH4sy2DwH2EOlhKWJrW/UL0Ku/WQvrWBk4o
 wumyyGK8MzCv7KrMpPn2WWYMZzojfsuZETqyjYVKsjrU2zoB2ZKEfT0vCwYvU+4Xfkb1tu3j4+v
 XZcUYFLvsROnE0gxKN9qVkAU+cF4txrAStEkVpHml7C/iI+yzseqKavTPI0En62fMTER3rXY
X-Received: by 2002:a05:620a:2b88:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-93948012fadmr1557893885a.15.1788292514232; 
 Tue, 01 Sep 2026 12:55:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2b88:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-93948012fadmr1557887785a.15.1788292513678; 
 Tue, 01 Sep 2026 12:55:13 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f361042sm19286085a.26.2026.09.01.12.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:55:13 -0700 (PDT)
Message-ID: <27200b7e13ecc99d57c41da4e25fad690fca68d7.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: Use write-combined maps for coherent
From: lyude@redhat.com
To: Aaron Kling <webgeek1234@gmail.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Faith Ekstrand <faith.ekstrand@collabora.com>
Date: Tue, 01 Sep 2026 15:55:11 -0400
In-Reply-To: <CALHNRZ-JmYx-PhruhDZ3L8aPVu51cJrqP_FeNtGTyMHCH_esgg@mail.gmail.com>
References: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
 <8cb96c08-2d1e-459e-b356-c6fd97ef869e@kernel.org>
 <CALHNRZ-JmYx-PhruhDZ3L8aPVu51cJrqP_FeNtGTyMHCH_esgg@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4AbuiJzF1sSWxZnH3MD4Iu1LRjXdrso5u7iC44SIF_A_1788292514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 2026-09-01 at 13:03 -0500, Aaron Kling wrote:
>=20
> Looks like the tag is:
>=20
> Fixes: 1b4ea4c5980f ("drm/ttm: set the tt caching state at creation
> time")
>=20
> Should I send another revision just to add this, or can the subsystem
> maintainer add it when picking the change up? For stable, I would
> like
> to see this picked to 6.18 at least, since I primarily work with LTS
> forks.
>=20
> Aaron

I would send out a respin with the tag

