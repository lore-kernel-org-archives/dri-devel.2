Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BFFF433E3
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF84E10E179;
	Thu, 16 Apr 2026 05:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IynrFTzC";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E699810E179
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 05:41:15 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b2503753efso66843005ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776318075; x=1776922875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language:subject
 :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cag2ptL6wrm0V5bGbrcQIfwBYr+GeQUuV1iySRth4GY=;
 b=IynrFTzC04Ls+gDqpiw5j/4c/nvm0wCpqKe588TSQuiNPpZ5s1sg9gKMeBxlnRyhv+
 nJFzzzABxHuF/A8sTrqc5uynwcdMv3huITl6vgD1aDYW+etYCHoeTjBe1nB0Opm7n+Dt
 Yi2iwJXs6RFCBpBzLdfJSAsxABfYOJa4xy1NQmcMmSTv9JgTqcKGUZgyy68Fj/M5u05G
 WkGhb/nFFlKzcO2nJDzkVdY3IFZfyBKFQriA9Nqp6Ws6q+txmwuQB61YHoVo/izaPzSc
 gAardGW6OE98//BTr+nIQ24c9zVe9rmenNnOY5h94LO/NybLxQtZK2u7LY+EVGLxOynV
 O5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318075; x=1776922875;
 h=content-transfer-encoding:in-reply-to:from:content-language:subject
 :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cag2ptL6wrm0V5bGbrcQIfwBYr+GeQUuV1iySRth4GY=;
 b=Te5jpiHq/88ss4naNptWF3ZTv9lT6sHLjpdZbyWe/JajZ3dE0oca1Tsz4V/OBA4kvd
 Sb75Su7eqA2ulSvEdD112S9zi1q4BNuoYZNnrxQtFx1kN7Y0TP1hlLPTHwUrtOfDpefq
 UAYwapig+/SrLCkQz31iIPFDqspBF5th52Vx+B6qWgRdbnENTHw7WJe7a1Bi3MBQKzK8
 4c1/AoVqY2qbLdFz3efbRBz5JCg/steAJbIMM+JTm2x35sHnAqnG65ZUoye68DNwH9qe
 xfKRd+y6uuWlaXs+J54DIxLF+W/4gfj5rpmaUwK43wkNU1HIn+EJeSY8PS6rLxLI2F75
 0hFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SKxjrhGUzfypixd2RDZiRiGjaf8F3UFSBJlTPABEZpJdYIrqJTPebxu1P7W3URIg3zoZLwoPrcLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysaf/xYgAZ5UB+AjpNfzmL3JHTU+/ZMHDsdYvD2zys2Y7LP6C9
 aHtAQ6tTA+C9uPmcgUpqwLhy8XviuIb0QBO+Xs+UFQ92FkXV7CL7S93J
X-Gm-Gg: AeBDiet2h6v/cV4RwBmhAqL+xFYanAie3WAwha9NeKxTL6fwiJ5eE1R14oDkRt/0ZII
 3xJUxb7rdSiju0UDy/u7sRUuAFBcAnHfoY5NK5qxPNFxzf5taSOXO6BFjkt++ZHet45FC/61g1w
 u3UxDIyMPnxGxglF5EuQB5d775w+KYW1dLc8WmLca0jP4em9+DSWvhsrhFQSghBiXxPb0dlj3GK
 V+vWoxrEWgqtXCXWNdCrHtVsh8hXsDr8hs1YfUKUn9xS9yvQiD9oJ2S/Hn58KLbh9GRnYWlH/wJ
 8u2d35wlK7mZC2uKLLGzm+qCG+ja74niStB5/A/89Tq+povKqW0+5UbdGN7HwQkLw7Pu1YURVE5
 x2QY1j5xob8jhnyZAnSFEnNcUECU69et4XTijFSnb2uV3QJ1cwiub/o2OaVPc7iIYdJSqVFzeSy
 uasmv60xKAbA/Pe1J2hIZDIwjHYeokaGflu9wNnXLAitjOpF4Ergc6MYmnGDsk67KsfGg4
X-Received: by 2002:a17:902:c94d:b0:2b2:3eec:c75f with SMTP id
 d9443c01a7336-2b2d5a3837emr259023135ad.28.1776318075370; 
 Wed, 15 Apr 2026 22:41:15 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp.
 [106.167.137.155]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b6704sm55716045ad.75.2026.04.15.22.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 22:41:14 -0700 (PDT)
Message-ID: <6d754f54-d1c8-4175-a0f0-dd51eb26930d@gmail.com>
Date: Thu, 16 Apr 2026 14:41:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sanjayembeddedse@gmail.com
Cc: airlied@gmail.com, corbet@lwn.net, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, tzimmermann@suse.de
References: <A2B5F0ED-8C58-4A88-A4EA-8DA50289ECB5@gmail.com>
Subject: Re: [PATCH] Documentation/gpu: resolve kerneldoc duplicate
 declaration warning
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <A2B5F0ED-8C58-4A88-A4EA-8DA50289ECB5@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hello,

> On 18 March 2026 8:06:12 pm IST, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>>From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>>
>>kernel-doc build with `make htmldocs` reports following WARNINGS.
>>
>>  Documentation/gpu/drm-kms:360: ../drivers/gpu/drm/drm_fourcc.c:397:
>>  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
>>  Declaration is '.. c:function::
>>  const struct drm_format_info * drm_format_info (u32 format)'.
>>
>>  Documentation/gpu/drm-kms:491: ../drivers/gpu/drm/drm_modeset_lock.c:377:
>>  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
>>  Declaration is '.. c:function:: int drm_modeset_lock
>>  (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.
>>
>>  Documentation/gpu/drm-uapi:607: ../drivers/gpu/drm/drm_ioctl.c:923:
>>  WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
>>  Declaration is '.. c:function::
>>  bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.
>>
>>Add :no-identifiers: to prevent duplicate identifier generation and
>>keep the function documented at its implementation site.
>>
>>No functional change.
>>
>>Link: https://lore.kernel.org/oe-kbuild-all/202512302319.1PGGt3CN-lkp@intel.com/
>>Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>>---
>> Documentation/gpu/drm-kms.rst  | 2 ++
>> Documentation/gpu/drm-uapi.rst | 3 ++-
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>>diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
>>index 2292e65f044c..0f0f90b3186d 100644
>>--- a/Documentation/gpu/drm-kms.rst
>>+++ b/Documentation/gpu/drm-kms.rst
>>@@ -356,6 +356,7 @@ Format Functions Reference
>> 
>> .. kernel-doc:: include/drm/drm_fourcc.h
>>    :internal:
>>+   :no-identifiers: drm_format_info
>> 
>> .. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
>>    :export:
>>@@ -487,6 +488,7 @@ KMS Locking
>> 
>> .. kernel-doc:: include/drm/drm_modeset_lock.h
>>    :internal:
>>+   :no-identifiers: drm_modeset_lock
>> 
>> .. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
>>    :export:
>>diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
>>index d98428a592f1..73b49e0dcda8 100644
>>--- a/Documentation/gpu/drm-uapi.rst
>>+++ b/Documentation/gpu/drm-uapi.rst
>>@@ -603,6 +603,7 @@ DRM specific patterns. Note that ENOTTY has the slightly unintuitive meaning of
>> 
>> .. kernel-doc:: include/drm/drm_ioctl.h
>>    :internal:
>>+   :no-identifiers: drm_ioctl_flags
>> 
>> .. kernel-doc:: drivers/gpu/drm/drm_ioctl.c
>>    :export:
>>@@ -761,4 +762,4 @@ Stable uAPI events
>> From ``drivers/gpu/drm/scheduler/gpu_scheduler_trace.h``
>> 
>> .. kernel-doc::  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
>>-   :doc: uAPI trace events
>>\ No newline at end of file
>>+   :doc: uAPI trace events
> 
> Hi all,
> 
> Requesting your input on the change.
> Is there anything that I missed or required correction ?

Your patch is ignored because there is no duplicate in those identifiers.
As you are well aware of, you can have a function and a struct of
the same name.

It is a long-standing bug (almost 6 years now!) in Sphinx C-domain support.

Please have a look at my earlier email:

    https://lore.kernel.org/f735ce0b-db1e-49bc-86ac-b5ab8e4aec31@gmail.com/

It is dated "26 Mar 2024", but the issue remains unresolved.

I'd appreciate if you could make some contribution for fixing the Sphinx
bug.

Regards, Akira

PS: Please ignore several typos I made in the earlier email ;-)

