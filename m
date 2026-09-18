Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E51CC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70AE10E87E;
	Fri, 18 Sep 2026 10:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="a+wiSPQr";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBF510E87E
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:01:38 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f55efebso78412066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789725696; x=1790330496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iEbsTjofMtHgpcEzx6X97K948OuXV1PVOXo0ZagJ2m0=;
 b=a+wiSPQrAV6LaVEyFPplaA9/CSip73y/xxofjpyxXv7119MIHTvsKtGXP/m0zv11xm
 yxprLXaYflxZEBU+Fne0rKLa0Wvauv3Amw9hsbIwzh8L+Tci3MaQTuAU1MIaUjXNMBzP
 +K/3pqbcas/3LFCVe1XEkftXJqdB9g2C4XIM1qYiEtJFLaWNu5TWUpv42viEj00zYlkt
 2Swjmo9r8vB1IrMDmRt6I8+7wakBTUBAuZBNe9ky5NYjmBMFsorCX9Ne2nMuzio/mzMU
 Duiig19/kxEoxYU/zhsDy16l71GqjBcEmAlvgK527+/fsmYpyfpDR+ZxNQgdV7qsSJT6
 YAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789725696; x=1790330496;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iEbsTjofMtHgpcEzx6X97K948OuXV1PVOXo0ZagJ2m0=;
 b=vQ3Lhe0wrtY0po5JsPHFt0inbdsMdaf/0NqxftXeV99nfihEiFKEP6+U4DEu0ep50y
 nQ79YMF0jxt4+0jgidveaPPkb1ltBHGhyogZ3hbdJGodIhL8ruCUi2/FaAbOLnvXr+a+
 n9wMheTO+7ThpuRfGVH1ZH53LTFn6jfZMvWzy3cmkgEuUbM/J/fJOW/2dmd8wHykrjFv
 IaSNmu+ZeBf+WRDPyLa4mQ3l2Usmi4FT6t2ghoEVHlj99Fc+gIfCQwDW5y93axTHHTxZ
 fdOaAp8dJM9LiD93AD4Plg8qOx9p8SgrasuYI+XTfDuSHhDIAaUERwBgEoPOFjwsrvH9
 O64A==
X-Gm-Message-State: AFuF++lBQeC6TySlCXguMjEjWBV0lAkKgYIsAomTbqoN6sdxbNKtCkOb
 N+TBetETdgj+75NiScK/7DXkmVKz9mGC9Wi0f5975NuILXOZqIyJjJjhDOBpvJQ5l/J3v77U9sw
 3azc8ykk=
X-Gm-Gg: AYBFou1zUuES/TM0x0PCpeSwWxof81pN9byy76tfvZN0BUpR3I4lknTQj93EpmmpRKP
 FcGu8f5hflbxb6WZujnrr73FFFCmZuSIfu3TNP/mtalbaRBsnHH6n40FzqFVmwE8XhMy8bvt4zF
 eu/83yo5F/vZUaleMHKCT1Y/5hMHW44RONwZO0LoxdSG9+TtI5xN6i0KFYZItlegt9sawR/vlUx
 JiWmQRLOv+n+bSZ65UsKm4Yc8as0K7VIl7s4P4BKixkQ3Uy/77z+aBSLRj2KrIqv2Uzpms/s6ae
 6ThlI2aheEANrMZW1H9zjpBOKwDwVAUVf2EZ/6grEKLTmfjON6DScCVBesZwZ1JRzKIuADMxOrE
 Jt264mX9gyBROeLefGcT/ZBjwIfbsI2TgRSctecVz99qmteSn8pzkY4wIR6TaWpgkF/AwPgR7rD
 Ct+fCOf9axE0FLZYEIWLAhIt6zAR5J1tdAw47UXLHBpHAp6uNGBJ6pQkcS6y//4aZQnYO8i952u
 0BYOYZXY4Bkcww=
X-Received: by 2002:a17:907:d644:b0:c26:2f5e:29c7 with SMTP id
 a640c23a62f3a-c2a156590acmr195801266b.7.1789725696554; 
 Fri, 18 Sep 2026 03:01:36 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1bb46f17sm39115966b.31.2026.09.18.03.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 03:01:33 -0700 (PDT)
Message-ID: <f4e72135-2a8f-4099-9245-4d8c36c30713@ursulin.net>
Date: Fri, 18 Sep 2026 11:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/i915/gt: Fix selftests on PREEMPT_RT
To: Maarten Lankhorst <dev@lankhorst.se>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-5-dev@lankhorst.se>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260706114823.752313-5-dev@lankhorst.se>
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


Commit message where are thou? :D

Regards,

Tvrtko

On 06/07/2026 12:48, Maarten Lankhorst wrote:
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>   drivers/gpu/drm/i915/gt/selftest_engine_pm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> index 10e556a7eac45..c1eff9edd8a5e 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> @@ -277,11 +277,11 @@ static int live_engine_busy_stats(void *arg)
>   		st_engine_heartbeat_disable(engine);
>   
>   		ENGINE_TRACE(engine, "measuring idle time\n");
> -		preempt_disable();
> +		migrate_disable();
>   		de = intel_engine_get_busy_time(engine, &t[0]);
>   		udelay(100);
>   		de = ktime_sub(intel_engine_get_busy_time(engine, &t[1]), de);
> -		preempt_enable();
> +		migrate_enable();
>   		dt = ktime_sub(t[1], t[0]);
>   		if (de < 0 || de > 10) {
>   			pr_err("%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
> @@ -316,11 +316,11 @@ static int live_engine_busy_stats(void *arg)
>   		}
>   
>   		ENGINE_TRACE(engine, "measuring busy time\n");
> -		preempt_disable();
> +		migrate_disable();
>   		de = intel_engine_get_busy_time(engine, &t[0]);
>   		mdelay(100);
>   		de = ktime_sub(intel_engine_get_busy_time(engine, &t[1]), de);
> -		preempt_enable();
> +		migrate_enable();
>   		dt = ktime_sub(t[1], t[0]);
>   		if (100 * de < 95 * dt || 95 * de > 100 * dt) {
>   			pr_err("%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",

