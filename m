Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C0FCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769EE10E423;
	Wed, 20 May 2026 09:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HxRDeU73";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB95C10E423
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779267661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5vxqUqpEiFIb59w61vGMB6RCXxTWiuGOk0+KDXA3K9k=;
 b=HxRDeU7382umdDYk29Vky1PABaZU5PdnU9KBhPqOrRGINcPqp5FtAZg0hfmAR4Mbyoymt6
 5Lmf0NjIf8C0M6gBfXsvoCag9W+5JokVNDmpm45/NpcpoA2HBihIJkdTvqdXTmE78qF23o
 mIeb/6XJ9MV3E8Lzz6eRmYqqU7go/Y0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-38XieBW3NOi8o8aqMA6XhQ-1; Wed, 20 May 2026 05:00:59 -0400
X-MC-Unique: 38XieBW3NOi8o8aqMA6XhQ-1
X-Mimecast-MFC-AGG-ID: 38XieBW3NOi8o8aqMA6XhQ_1779267658
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd396daedso28851125e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267658; x=1779872458;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vxqUqpEiFIb59w61vGMB6RCXxTWiuGOk0+KDXA3K9k=;
 b=EgziQUZ7Nhv6k7fw0M6Njmw1OUidVOLdZwcasrEx9V+HOepxtZtloM7FdocOnMfHwh
 yasCoMulUl4n7KJ5Yw/o1PCdsdW3cw/UYM9P+T1RQQ+wckjgviAROWT9cyc3oCvfkCqQ
 se7rI8jhTjGlD5Cqf+3O2Me3KVqHcFDv8MkjeOBfTF9DlQvpSDtaXMXAsrR1f1MlsIYW
 1HUQZGtOf7zEMQcjFZZnl9JvsKGtfTdnHuHuo+KhF7/29dbGY2eyxyobdSuPQ48jpZNJ
 Pp7EOArW31yYIW3DhB3cTXq89QvygvDWOsMJ7Ju6GFt2iBS8UgLeSHW9zcjo752YO7Yv
 Xfew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pB02GVThD+fBh0bxyxWOPzIheKy24K71gdXHpQZHO7qDKDagJf4AMb7fpdQWVZmdP+B4eCZiggSY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5UnUDNe1uXGkxXTmmk2abELsA9mpj4XkKo0H2QFmcUx1zfFD0
 6ryA/WdJsgjT/1Do3BfWKNFbAdTj5iYznKJGgWh6aoHCFYL5Vbg5lxVtuYYVTkFhLx7FrF7WAQH
 ZleiMatNi8PPt0UbhXZGx72y4y7u2MmusMFnayygXBROP6NNZOhGGPCoCViDwgZpoG0qOzg==
X-Gm-Gg: Acq92OFZcuqPHU6+uMFhfg4e1Vx3yw5DAD/3SUfjCdONARZTiFipVDBA8c1VbJAIwY0
 QCcaxs/1gxGxNXp7F7m4TJLg6hVtnfQK4GaO86vh/8ExS5WHeSUt2u8WzWSwLwsXYnFL5BQtxG6
 uOcSrRk/kLjU747lHBUaKA3bCzzkIU8ujz4DVo2oFYFPoLUgil6BxZYGAGHUsvlLw7xLnlUYW+n
 8IIOUQ9Mjb2JkRwbjDCpfYH8E17FpZhPY65MmmY2/4+zLhtV6EOaDai/8lW8H4q5leFz0K1TLoU
 qZwrlcoW+A0jCiev4ycJju6kmeSTrnTfuMQP1HKwgjOfllEhGFYG12JoOA7QpkF9cpwPvc9c6iV
 80UNBs6sSctDGKawwOrw/6FERRNSzev4m0hRxgiPNbQAtq3A5GBvt1P/SCdUR+OY5wBe+oCNYx4
 RmLLZu
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-48fe60e51f8mr275888825e9.4.1779267657685; 
 Wed, 20 May 2026 02:00:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-48fe60e51f8mr275888255e9.4.1779267657128; 
 Wed, 20 May 2026 02:00:57 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537ccf5sm374945825e9.14.2026.05.20.02.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:00:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt Coster
 <Matt.Coster@imgtec.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [EXTERNAL] [PATCH] drm/imagination: Fix missing
 pvr_power_fw_{en,dis}able() argument
In-Reply-To: <5b44cf26b7aae3a35db54492e9c093a3b3fd9342.camel@imgtec.com>
References: <20260519131239.1291732-1-javierm@redhat.com>
 <5b44cf26b7aae3a35db54492e9c093a3b3fd9342.camel@imgtec.com>
Date: Wed, 20 May 2026 11:00:55 +0200
Message-ID: <87zf1uwj3s.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tXdHCBRpGDg8zq9kgLzZ2RSXgJ7UUTO2Fcl4VSokPjE_1779267658
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

Brajesh Gupta <Brajesh.Gupta@imgtec.com> writes:

> On Tue, 2026-05-19 at 15:12 +0200, Javier Martinez Canillas wrote:

[...]

>>  	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>> -		err = pvr_power_fw_enable(pvr_dev);
>> +		err = pvr_power_fw_enable(pvr_dev, true);
>>  		if (err)
>>  			goto err_power_off;
>>  	}
>
> Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

