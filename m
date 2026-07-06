Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC14C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7F110E8B8;
	Mon,  6 Jul 2026 10:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b+NSLQaO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FADC10E8B8
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783334525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=whzMyrHzmjkYmLR0TF0+AwgAGT12A2zCfTqGGbo/b6E=;
 b=b+NSLQaOvxp5QzHG44Z1uNbnkcgx+SVaHprkb2FNBRDqFp7YBp+xlnX4S2aN+nzuQcY6Wh
 Wk2v3OUEicgzxck7wi6G5SeJ2/P6m0YvFkJY94EoOJVbu7V2Mu7ow1/UQPPh2fy/Q8ZCx5
 qnyPvHa1D6AY3mE/prWiWOcuJ+uFohY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-meGySih2N1qHZrMSd9hWEA-1; Mon, 06 Jul 2026 06:42:04 -0400
X-MC-Unique: meGySih2N1qHZrMSd9hWEA-1
X-Mimecast-MFC-AGG-ID: meGySih2N1qHZrMSd9hWEA_1783334523
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so38369795e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 03:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334523; x=1783939323;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=whzMyrHzmjkYmLR0TF0+AwgAGT12A2zCfTqGGbo/b6E=;
 b=h3xcNjzcaK8Txi2qiXiLqq4KrYRp++vw+/G8d3Dy41OPCojpAYCTefFW86ypRcdoLh
 WoaS1mutLq1pbcnN9Tg4zl1bPlT954CzhBC9ehqxzgjVMOUsiekj076zaCGUdN8Za9kf
 OuIptuemUZ8HP8JD/W0p5nGgx2uZ0KDrUOaHGRpGU3+5+kcdnEpG3V93HPigV+tvnZln
 w0sfPtaTL9EFNznpklFgjTDl6/cDx68zaYETkwOUJ/fm/uJHd6qrbvO5IORcCrkeOiTd
 DLQUxVr5jIf7NHu4J/ECYcPTEX/fgl46edI2cjj0nNkNmkn4pSn8+RfS2W1MSyK2r0Pd
 Sl4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8qhE9oTYQdjCoOzctNDrT0SEfeYNdtykRaDGQqBJYlBQt2vqSZRWd1lqlv85HEkPV6TVE1AkB5Uw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSlwh+hiD0V094YMsneLICfFI3aNcMkbfQfSi2hnphAMemyvSf
 /nUw/1bDyjA9sj3C17mYWJ5tTjxtNm/4T5cmypqM5CNb2J9nxVzgA5cTxvDB2lhiyflHL5gK+pd
 dVNkmp5m0c752OuR5XgJeuVH3/vw7VjeZUQcSKzJom9UGkA3WnKQXtyLQhyyleL2eMmfTyw==
X-Gm-Gg: AfdE7cn5GF7nRCkmiiXU5zFLF/BpEzgjDLS7rvIKySJxoezToucMUeawhSddJXZrcFJ
 nqWK0XBaKo+zyWT/DAqnr150jWc4cBtOqexEweC7ZUjTg8icVaVNragYJk30NMvSs3seAdzoU0R
 clPwWxpcqgSGCAOpMIcEV2PHWAZ0afrGSvhXwT0qoB4zIeg2Qhu050imrL4ZsM+FoZOduR9Lng7
 jIOktPhGuKCUFfWdVAuRxazE2wB43d+tkEXS+aqVetQ6UiR7dy4LfhE2Sx7tL4qI+7OcHm9eqjy
 kgyANFaqxkUlG2z16wzdQj46kErvOiF1FH59jUk1e57o4R02PkgAOMlEvT6SXi4qzzw3KqIvWGh
 jYNhhNmjtkSsXhzbTaRTbzUT0VDMz2uQ0yHzusxMdE0AfR940s3M1L5vpBbRLNg2fiHE4NQ==
X-Received: by 2002:a05:600c:c167:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493d11f4b8dmr106609675e9.20.1783334523055; 
 Mon, 06 Jul 2026 03:42:03 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493d11f4b8dmr106609185e9.20.1783334522481; 
 Mon, 06 Jul 2026 03:42:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6da9sm23161720f8f.12.2026.07.06.03.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:42:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 0/3] drm/ssd130x: fix column and row end address in
 partial updates of ssd132x and ssd133x devices
In-Reply-To: <875x2ydetf.fsf@ocarina.mail-host-address-is-not-set>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
 <875x2ydetf.fsf@ocarina.mail-host-address-is-not-set>
Date: Mon, 06 Jul 2026 12:41:59 +0200
Message-ID: <87y0fobds8.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tcJs20IjRlWoGbyuYgpd3DhkxQu-xLl7D9z8Ol-aQ_g_1783334523
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Amit Barzilai <amit.barzilai22@gmail.com> writes:
>
> Hello Amit,
>
> Thanks for your patches.
>
>> While working on adding SSD1351 support to the ssd130x driver - I
>> noticed that the area of the cursor was refreshing in a weird state.
>> I would fill the screen red while the flashing cursor was on the screen,
>> but the screen wouldn't refresh the entire 8x8 rectangle each flash. 
>>
>> After reading the SSD1351, SSD1331 and SSD132x manuals and manual
>> testing on the SSD1351, I was able to be sure that the problem was the
>> end addresses of "Set Column/Row Address" being sent as relative addresses
>> instead of absolute addresses.
>>

[...]

> For the whole series:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>
> I plan to push them to drm-misc-next rather than to drm-misc-fixes, since
> these have been long standing bugs and the changes are likely to conflict
> with your SSD1351 patches that are in-flight.

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

