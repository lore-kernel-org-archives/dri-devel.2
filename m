Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E34ACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46CD10E374;
	Tue, 19 May 2026 08:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="BF8XNCO6";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED1F10E38D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:16:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso18038835e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1779178587; x=1779783387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KOEE/PRccoAJYCTGLVRF3V8r6JJZoXF78TzvXmadEag=;
 b=BF8XNCO6pXT08Y5CYm6Ta84WgLrMpcIOFJurlVCfuFsyebBmMdjWJucswj5SmLo/fY
 Lgwfm1baonRm6/dW06jIKE3i2InQu8EyWdbUmROyok810tqP5/p6ZvDYRtyKhW60CQyM
 3TQLwRJBAmR0O2yU2MoHv0qH1ewFm8qliX2eoPkI19LzbUE5jGONp5Ob7uwSSxOJskBG
 e9Uh3/YjfeSrHQ6zEGFeixeeTCAfRb0QumDSLRLXq9hw5T/7E3dBwPBuqF7J2ha1bKbQ
 2bOt5T9LqS50TU+y1dZiW1F2pmfybDwh9K1LUhESBAnojwz7FfCBnMU6u9zOZhJofgjB
 FReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178587; x=1779783387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOEE/PRccoAJYCTGLVRF3V8r6JJZoXF78TzvXmadEag=;
 b=XZH+9Ue7Jsa/Xc+L2f3bGgHLQPtLiTVLv/P5eTqjOIb/yH8AVMr7eg5kxtHcWCS+0R
 0FHqAfgsGU5TGe/DOUWki54vWmumU1Q/FNl+X1/syW+KBcPxf5kun1Zgqlt1XerWMFhk
 qjKTWKhE9v72PVsqx1C1/5bmgdTrCHpwl8D8ykqpGZ3xfhYP+5uLawNGYUZv8B0nsprA
 IGHl4oUolR53fodk/ubJhOeukKSF/j0lPK8rbiTyQqM+uu5n363E/8Bu3EYofMlzd3a1
 /3viIvr9EE5689pnM4vz/xZTAm7YqBIVd5depzhjprEHbC+EGs4X542fwTNXikNXppTc
 fBTQ==
X-Gm-Message-State: AOJu0Yyf9aShKNEq7Sm4OabtqtfT2irRdIFQnE3vFtk+6yIc5BjtNuDO
 3mU4SeCM0YYe/h+49kZ+jahRhl6/tpSYqeO9vqQhWSZmhm68Vos7UPY77XA9nfGA7mHhjydcMTb
 Y0i0H
X-Gm-Gg: Acq92OGMnWsJxfuu5cBs9sm1gSB0cF3+RKvyFs/twHFkVBF7djYzg9Zs3MkPxGmqXMJ
 uFfpgMfQI76edDNKKju9w7VlB8jxj4th8Y8CXcIeu3yeh6xBUr7iDtKtBwVzvDhbgZCDSp8MIs9
 OMlBlSjMC9iW9qtC6sw9+DZ/95YFrEZGMpEQzGkTlRlddUxjVUak6YbhhLQ6Ir7rndjNAt+w6Lw
 lLlaa7k/fi+BKQJQLfTYJurGbYdPu1OgaFOgRhqKVgzB/FLFOX7Ui7TLjRSGCwgmZFEU4z6ODHK
 YYPoFDbxvUjeEE9/PplMaansuKgN+jV8y6gXy0BDdebKpXRm3oHRh8IhyAr8vT19THyMYz+2Igx
 j1hYpjS4fqfh0vwU3ljeFXndRbkaL2vy3/6u/LQR0RO5UhEzek2tcTmSm4Yy47HNoNG5/9whaQb
 6DxkFy1hG2noDrUwhbPQ4OBVOz+xIRWkKoeegkKVE9YQ5mxS1O++sTAD7bnUxzw8I=
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48fe60e473bmr254612155e9.2.1779178586441; 
 Tue, 19 May 2026 01:16:26 -0700 (PDT)
Received: from [192.168.0.5] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm339529205e9.7.2026.05.19.01.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 01:16:26 -0700 (PDT)
Message-ID: <35bbd887-68ea-45c4-a7aa-19cd74c6aa5a@ursulin.net>
Date: Tue, 19 May 2026 09:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "i915: don't use a vma that didn't match the
 context VM"
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20260518092941.47247-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260518092941.47247-1-joonas.lahtinen@linux.intel.com>
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


On 18/05/2026 10:29, Joonas Lahtinen wrote:
> This reverts commit 5401b9adebc9e5f68df58226f51493ef0e6ceb4d.
> 
> Superseded by a13edf9b92fc ("drm/i915/gem: Drop check for changed
> VM in EXECBUF").

If I was able to follow this accurately, I would probably simplify the 
commit along the lines of:

"""
Drop the else block which was made a no-op in commit
a13edf9b92fc ("drm/i915/gem: Drop check for changed VM in EXECBUF").
"""

You can edit while pushing too:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> Link: https://lore.kernel.org/intel-gfx/CAHk-=whfUM8y3PoFfT21+guKWK-mJmAE=8uLzOT+7HGv5NtqSw@mail.gmail.com/
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 05997e8bbb29..1f303d4eaa4d 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -898,8 +898,6 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
>   		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
>   		if (likely(vma))
>   			vma = i915_vma_tryget(vma);
> -		else
> -			vma = NULL;
>   		rcu_read_unlock();
>   		if (likely(vma))
>   			return vma;

