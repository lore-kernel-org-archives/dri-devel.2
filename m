Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971ACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 10:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429A910EA26;
	Tue, 12 May 2026 10:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dOuAq+Iv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0410EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PTCQguyzZOALvI/M8ISm/nznLSKM8BZ6LQMRxjifeRY=; b=dOuAq+Ivw7QZfMmubJqVJ835cF
 iq1cq8H3sVxHdTcxROkLyrXPnxNRK6Eoo7iV7Clcc4NTuKU+L5rpRR44aC8Pu1avJqh4AKX3LH01g
 7PZAEHINi6fa1KuxpEyzeNGUzyG9E23WiPSmTO1ECjaOEJ9SH0IV+6o/UTg8zd+GoLOA0nwY/+6gr
 KmAf88kWR1PgL+2Qd7JXMO/0pwIfGK/3CSyCFrjV448qVQ7JcskvJnpzgQOX1cW41cC45IJO4+XC+
 qM1p/tect/OG1vg8A/knchHUDzGf5AWsBt99bBPFjGMp06xPhhvOdpdzKtYTH2ubcnpaX8BDScGfJ
 P04cZrZw==;
Received: from [189.7.87.67] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wMkmP-009QmW-Lz; Tue, 12 May 2026 12:56:01 +0200
Message-ID: <93a2cb1e-3907-4aae-833e-15d0cbbbf255@igalia.com>
Date: Tue, 12 May 2026 07:55:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/v3d: Refactor perfmon locking
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
 <20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com>
 <7afa2b5b743d76f6f9ddf4bf58997e2ac178a0ba.camel@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <7afa2b5b743d76f6f9ddf4bf58997e2ac178a0ba.camel@igalia.com>
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

Hi Iago,

On 12/05/26 05:20, Iago Toral wrote:
> El vie, 08-05-2026 a las 10:41 -0300, Maíra Canal escribió:
>>
> (...)
>> +void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon
>> *perfmon)
>> +{
>> +	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
>> +
>> +	perfmon = v3d->global_perfmon ?: perfmon;
>> +
> 
> 
> What's the rationale for having this function do this? The caller
> explicitly passes a perfmon to be started, but this here can ignore
> that and instead act on the global perform under the hood.

v3d_perfmon_start() is called in 3 different places: the run_job()
callback for BIN, RENDER, and CSD jobs. If the global perfmon is enabled
at submission time, we can assure that the job perfmon is NULL. However,
if a global perfmon is set in between the submit ioctl and the job
actual execution, we give preference to the global perfmon and new
submissions will be rejected with per-job perfmons while the global
perfmon is set.

> 
> I think it would be better if this decision is made expicitly before
> calling the function and have the function always act on the perfmon
> requested instead.
> 

I believe this would lead to code duplication as this function is called
in multiple places. Also, this would mean that we would need to transfer
the global perfmon logic to all run_job() callbacks. Also note that we
can only access the v3d->global_perfmon with the spinlock locked, so we
would need to open-code the locking in all run_job() callbacks.

> 
>> +	if (!perfmon)
>> +		return;
>> +
>> +	if (perfmon == v3d->perfmon_state.active)
>> +		return;
>> +
>> +	if (!pm_runtime_get_if_active(v3d->drm.dev))
>> +		return;
>> +
>> +	v3d_perfmon_hw_start(v3d, perfmon);
>> +	v3d->perfmon_state.active = perfmon;
>> +
>> +	v3d_pm_runtime_put(v3d);
>> +}
>> +
>>
> (...)
>>   
>>   struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv,
>> int id)
>> @@ -316,11 +354,15 @@ static void v3d_perfmon_delete(struct
>> v3d_file_priv *v3d_priv,
>>   	struct v3d_dev *v3d = v3d_priv->v3d;
>>   
>>   	/* If the active perfmon is being destroyed, stop it first
>> */
>> -	if (perfmon == v3d->active_perfmon)
>> -		v3d_perfmon_stop(v3d, perfmon, false);
>> +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
>> +		/* If the global perfmon is being destroyed, set it
>> to NULL */
>> +		if (v3d->global_perfmon == perfmon) {
>> +			v3d->global_perfmon = NULL;
>> +			v3d_perfmon_put(perfmon);
>> +		}
>>   
>> -	/* If the global perfmon is being destroyed, set it to NULL
>> */
>> -	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
>> +		v3d_perfmon_stop_locked(v3d, perfmon, false);
> 
> I think it would be better to stop the perfmon first and check if it is
> global second, even if we are certain the put above is never going to
> delete the last reference in that scenario.
> 
> Also, maybe we would want to document here with a comment that we
> increase the refcnt when we set a global perfmon, which is why in that
> case we put it twice when it is destroyed.

Ack. I'll address it in v2. Thanks for your review!

Best regards,
- Maíra

> 
> Iago
> 

