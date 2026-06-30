Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA22C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFED10E1F7;
	Tue, 30 Jun 2026 10:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ATzHyXVo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4113A10E1F7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782815417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt+GIzX8xwbGOeudcihqYde9U4BtzFfzJJUO9ZPZWtM=;
 b=ATzHyXVoEGRnKPCkM/zCdXziZjmeIl/anGNO8u3O6XfmnNsVhHK5v9u5W2wqXGjjZUsidm
 /SFKBdWdCN+WqxzYqj5E0XleqdREUAvzGTEnHcT06RYA+sdu1TxhGSqliCJKSx5TkjJne6
 Pon4Ji4SJidcbbB796246CImGHg2AZ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-VtUrlMClNsGnwXfqypydyw-1; Tue, 30 Jun 2026 06:30:15 -0400
X-MC-Unique: VtUrlMClNsGnwXfqypydyw-1
X-Mimecast-MFC-AGG-ID: VtUrlMClNsGnwXfqypydyw_1782815414
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493b54823bdso3432255e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 03:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782815414; x=1783420214;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rt+GIzX8xwbGOeudcihqYde9U4BtzFfzJJUO9ZPZWtM=;
 b=H8BMAR9IoL88+LbF03m0cGNCYWo8DwCPv76xMX5OvCJnB21oh1Ni3PUENvSh9u+53Z
 opHP4C/SsqmafGv35cScs2aWBNDngph4CtH+e8IutNO8N46L+Rb4YQpG5C3fvKNT+ycK
 07oiRYNgx7dw77iTBaLzSjMrj83xuJPGYc47UOxyWMJk0pBoeOQHDCPkDe4oJTzkX9b3
 J1qDO+mTyAHsHMU+HzV87uED3bpKyO1aXzEtWNBt+kZEaK0FbI6RUy/9t68+K90OQL77
 3CNDv6Kj0CnvtFxIKlBkxuCMczztYvDkvO/pgqK9Xqh0vaDOYI7guJaeGOubBXxxOC+y
 cEww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn321LboH53JJKVeVJiukBDxfgpLvE8s4z4M310yu4JWP8sI04hvCjhkL0z5Dl3jyMd9ubn7SY1no=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp+v0OjiiU76SSUmxDZhFvYS8iaxk7/ierN7I3dTlszYK5oojh
 FKs0ZgO/dwAlL+aUCaxfhMK5rIaMakAdb1mMEkhegyvWOLl+m7jcDbeVAbkgiBsa7h+9I6+HFmL
 nA3RU6v63aBVQurQAXW43w+kH1N2T53/hxEyisx5SoosxYi9/OgLVFoluC/2SVxfr4HnfOQ==
X-Gm-Gg: AfdE7cntViJeuPDGT9+0MVcKw/vQm5OXCKQFIDMkUlOtB58tOCyAyl4bnI0HwyCMW5n
 C0UA60rZztYqoVbyj6V2gzxD2f6V0VFFq/LuQSfwPVSY3mCm8OnaINOJ7k6FlhF3AQbcIs2bFj7
 /MPl1QxZvcGDPeOJBaJ2+nOd/xI0MJ3aw1akSU2u6GqkDn/7W46764OF9f4HgbrCWrkntQ0XUVe
 hGzeeRkamEAs+EwY+h67tfm+eT/aCo3fUUpNdeUTzNJJbEl7s9OHK1tpsJaeg0rEOLsdT8HNtZA
 mXQdciFy4rMtZL/VYpU4oyz2MB3xPS4kpjbjk77hvKE14/ouHyZ2Q/AYO4qQn0QTEVq8/LH4UCs
 /d/U8UFl5o4bdrnl2Bw+hwPvt9rnZLrOrJD3PUHg4PDTEsMVK6bMTN0LXUps/GBEMVOVj+A==
X-Received: by 2002:a05:6000:4a13:b0:472:e43b:5e8c with SMTP id
 ffacd0b85a97d-475dff5e567mr2010141f8f.20.1782815414172; 
 Tue, 30 Jun 2026 03:30:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4a13:b0:472:e43b:5e8c with SMTP id
 ffacd0b85a97d-475dff5e567mr2010076f8f.20.1782815413538; 
 Tue, 30 Jun 2026 03:30:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm6895099f8f.1.2026.06.30.03.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:30:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
In-Reply-To: <20260630095600.8392-1-amit.barzilai22@gmail.com>
References: <87mrwdd8t5.fsf@ocarina.mail-host-address-is-not-set>
 <20260630095600.8392-1-amit.barzilai22@gmail.com>
Date: Tue, 30 Jun 2026 12:30:11 +0200
Message-ID: <87echococs.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zVOVtyy2cE997iXaQz-Hhr-gaPeE8zNGLpl_tlQW2DY_1782815414
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> Javier Martinez Canillas <javierm@redhat.com> writes:
>> Sorry, I was on PTO and couldn't take a look to your series. I plan to do
>> it this week.
>
> Thank you for the update and there is no need to apologize.
>
>> One question, though. How did you find these issues and came up with the
>> fixes ?
>>
>> It was just reading the code and the datasheets or were the issues (and
>> fixes?) identified by an LLM? If the latter, then you need to add an
>> Assisted-by tag to your pa+tches.
>
> I found the bug and solution while debugging the ssd1351 extention to ssd130x.
> I used an LLM to make sure my patches made sense and to recheck my patch logically
> and I wasn't sure whether that was enough to warrant the tag.

That's a good question. I don't really know to be honest.

If was only to review your manually written changes then I guess there's
no need to add the tag.

> I'll submit a v2 of this series with the tag - let me know if you'd prefer it handled
> differently.
>

Up to you. As said, I don't know were we draw the line so I will let you decide
if you want a v2 with the tags.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

