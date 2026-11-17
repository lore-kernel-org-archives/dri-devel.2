Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nlsZsEvN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3ACD10EB13;
	Tue, 17 Nov 2026 15:25:47 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D1E10E8AF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:25:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9EE834E4157D;
 Tue, 17 Nov 2026 15:25:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 695C35FD6A;
 Tue, 17 Nov 2026 15:25:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7806511BC0066; Tue, 17 Nov 2026 16:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794929136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rN+481S4GYpfidYv97LQA1HYewvg9PE9lPqaKVSokeQ=;
 b=nlsZsEvNVFjQKIYLoZjSGlxk2xzVmNeins+40O9GvbcX7Xc75uEoYS5khhPUz9tqjiPv1S
 I0EyQq7tDinSPTiQs4VH2Ar9GEsRgXAcF4kf8bhNad4FBwdQxVtplb6MeSJxbqeu597ppV
 B4v4UPoDVguGWGyhJgPe/WQMyOR8eLQeBH3mLuCurX6i+KqP9AE30qs95kIkuUpA5wXEpZ
 f9OyUW1fgkeqQLoY0FV3/dLnSY8d55i7dmTJXStbZ+TddnCJ30wdV3osYIy/4+FGY9cRxM
 XuueBSCCdPut/ie+6TFOroTDDP8QVvJzC9+nI5illLUlBxbEMtFvePe4NJojJw==
Message-ID: <e7ba12e9-ae4c-4f47-9374-517492b2ce85@bootlin.com>
Date: Tue, 17 Nov 2026 16:25:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fixed: use fls64() in drm_fixp_msbset()
To: Oarora Etimis <oaroraetimis@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261117-fixp-msbset-v1-1-60526519ae2d@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261117-fixp-msbset-v1-1-60526519ae2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 12:32, Oarora Etimis wrote:
> Replace the loop with fls64() on the value with the sign folded away.
> 
> Output is unchanged. The loop runs once per bit it has to skip, so a
> channel value takes it about 47 iterations and 347 executed
> instructions. The replacement is 6, and the work is one bit scan: bsr on
> x86-64, two bsrl on i386, clz on arm and riscv.
> 
> Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>

I did some quick testing, it seems to really improve the VKMS 
performance on some workload (up to 3x faster)

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> drm_fixp_msbset() walks from bit 62 down, one bit at a time, to find the
> highest bit that differs from the sign bit. fls64() returns the same
> value in one step.
> 
> In the other users it is only called a few times, so the loop does not
> show. In vkms it runs for every channel of every pixel of every frame,
> and a channel value is 16 bits wide, so each run starts 47 compares from
> its answer.
> 
>    Link: https://lore.kernel.org/20261108-lut-v1-0-f762d70ae4cd@gmail.com
> 
> Fold the sign away and let the CPU find the highest set bit. The range
> drm_fixp_div() shifts by is unchanged, and the output is bit-identical.
> 
> Counted with callgrind, gcc 16.2.1 at -O2 on x86-64, function body only.
> ---
>   include/drm/drm_fixed.h | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> index 21d822aeed55..7dbe89ca30c6 100644
> --- a/include/drm/drm_fixed.h
> +++ b/include/drm/drm_fixed.h
> @@ -28,6 +28,7 @@
>   #include <linux/math64.h>
>   #include <linux/types.h>
>   #include <linux/wordpart.h>
> +#include <linux/bitops.h>
>   
>   typedef union dfixed {
>   	u32 full;
> @@ -121,13 +122,9 @@ static inline int drm_fixp2int_ceil(s64 a)
>   
>   static inline unsigned drm_fixp_msbset(s64 a)
>   {
> -	unsigned shift, sign = (a >> 63) & 1;
> +	u64 v = (a < 0) ? ~(u64)a : (u64)a;
>   
> -	for (shift = 62; shift > 0; --shift)
> -		if (((a >> shift) & 1) != sign)
> -			return shift;
> -
> -	return 0;
> +	return fls64(v | 1) - 1;
>   }
>   
>   static inline s64 drm_fixp_mul(s64 a, s64 b)
> 
> ---
> base-commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
> change-id: 20261113-fixp-msbset-5965c14bcb9b
> 
> Best regards,
> --
> Oarora Etimis <oaroraetimis@gmail.com>
> 

