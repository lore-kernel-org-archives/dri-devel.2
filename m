Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5477CC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAF310F05F;
	Wed,  8 Jul 2026 08:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="xb2P26cQ";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B19910F05F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:38:30 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c08acccf4a4so44679866b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783499909; x=1784104709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=35GhzNQivfiRCZTVl3Now4SgwKIpqR1iOQGBo2y1fA4=;
 b=xb2P26cQqSm1unR39BpZCMUNuKD3xHC67fC3Qe/RMUkVZB8JhA891VTp0F003PLSBA
 UabYlL8X9qp1pIf734dKvCW8w6AjQFFzNkDWUPoQ6o95pf+29uMST6iLlu2AnSC+XMUB
 sSvwg1kYzLG7HtWgPn8QE369zvy408f5283dY1caEuCs5zBEfXaxghI0HzpN2DFSgJX8
 00eX08g46dMYdzH5KKeO1IgbWjvscwPwXr4AxDDgt3JthzM5nNya1X2cG0z3wjKpQLt7
 7taZC2lDb07sZAOX6mC+POfImy+yEJ3wMuqAQhLxbw+wSswD0KAqxc/1yUszN+kzwGV8
 lT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783499909; x=1784104709;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=35GhzNQivfiRCZTVl3Now4SgwKIpqR1iOQGBo2y1fA4=;
 b=Flte/fstmg6mJroAXe/dZMYjzrZ2SfqXDRm5Dt/Vu44KqxGWkm0IqdrAX3MTE2Aeu/
 kMsMPCHQJ63FmNqdo7Soly/PhnYO3/2VWhJaBbh2dFQ+OYGtg3dZWYPY+Rn5uLshdOof
 +0rZIX2n9ycfeTSj2fmfgORXDSX53zzNwvKUrdTpqY/0XC8NFI1L3+b1rUiL2FG2qwOh
 FfMW5lPNlO56jDr2gUN5EyG05d4bY7OjCneKmWQGp6Qa4rjxmuzlP84EOJggXFCCYF8D
 2WCQ8pBkHabfMgY4Z3MN0aKcchr8gqXNwSmi9x3OvtOL+clOALod749ZS9BjjuNNIqcG
 XIBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP59ce1wh7ZBWh9mJsfcWMiaw5XBxLVUYmlIIGRwapxozvQHCWLP5BWr18r/RzGxZZmbtV7TYJRFI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMWrR8AaUfrr9f67JdooMvXIuFTl0LQdwOeKZph1ZlNpH1LhPg
 jX7L+n8Zy8REu5R4p84Eja3xPK6+cGtWCNLRNC2HPINO5j1/YbMOTOqRpxRcP+vbzpQ=
X-Gm-Gg: AfdE7clAcPpg298texzcabBup0bevB40rHe8Q00IlufeZOQB8Hv7fK6MX4mzTAo3nKH
 Y4xbHqgB5Ay8LusvPEkc0wXKBvu5K2qqnzCtdepzBcXLkb7fmWDRkH3X09zH23qYHGQNa2oAa8N
 Le7a2t0gGOxoR+omQPgpMtnthXCJ1pKF8A/NfE2OvcheXlfjkBK76hz/XDYFXPa57ejTDG/8HqZ
 7SdmcE4OFLnQ51uimWA+pljTEWd0rGkN5SlT7hiDmsRItWSGQEHCgajHgSNvyi4JqhqsmG1IRl2
 tor4kQDm5ufCswLKaq3nBb1Ae1DqbP13dZa15fxAa2peTMHNAUk7Hu5R0BoOXeURTZks53ISnM/
 tw+I131YS8y2T8ZIb0IEaszKoMkJuGP6lJ9qDdjTD8IeOjN2O1zPM3grYG/a5scqN+FRuH/Aeqn
 LKnHIRBNcx1yR0joYbsejpmDacus94vqBjK2ddSnBmjHgT
X-Received: by 2002:a17:906:f58a:b0:c12:7eeb:d2d5 with SMTP id
 a640c23a62f3a-c15ce0fa416mr78006166b.33.1783499908629; 
 Wed, 08 Jul 2026 01:38:28 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15bb51af39sm179911666b.29.2026.07.08.01.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 01:38:28 -0700 (PDT)
Message-ID: <943175dd-afe2-4951-baed-4370f2bf2781@ursulin.net>
Date: Wed, 8 Jul 2026 09:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/guc: Return NULL for missing multi-lrc parent
To: Linmao Li <lilinmao@kylinos.cn>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@linux.intel.com>,
 Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260706071412.559909-1-lilinmao@kylinos.cn>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260706071412.559909-1-lilinmao@kylinos.cn>
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


On 06/07/2026 08:14, Linmao Li wrote:
> multi_lrc_create_parent() returns ERR_PTR(0) when there are not enough
> engines in the class to create a parallel context.  ERR_PTR(0) evaluates
> to NULL, and the only caller already treats NULL as the non-error
> "not enough engines" case.
> 
> Return NULL directly to make the non-error path explicit.
> 
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>   drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> index 28e8a092f4e7..18077801b2e6 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> @@ -44,7 +44,7 @@ multi_lrc_create_parent(struct intel_gt *gt, u8 class,
>   	}
>   
>   	if (i <= 1)
> -		return ERR_PTR(0);
> +		return NULL;
>   
>   	logical_sort(siblings, i);
>   

Pushed to drm-intel-gt-next, thank you for the cleanup!

Regards,

Tvrtko

