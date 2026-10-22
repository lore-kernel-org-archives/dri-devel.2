Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E014606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=vhDjfD3i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BEF112456;
	Thu, 22 Oct 2026 09:41:27 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C5A10E145
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:28:12 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-6de2f213b7aso576068eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.edu; s=google; t=1792636091; x=1793240891; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:cc:date:subject:to:from:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xruEMXmxKsYyy3/7Uv5aUsYVZ6xRBTshqU8cnD7X6m8=;
 b=vhDjfD3iElhly3hWPPl+XJWyPkfzarNKzuDZJstiR4az/d4xJI9wscSrt5GpUsjkIt
 t17sSteBRk5RWIF7wbmLEXLgj0s+HA7VQYORZojFn30RKLPVfddylWcCFGlEOW30yKCZ
 e34BPAYDdFPvgfM+tjbGVNLCbN7g7+HKfyvhFAKtEJjxmO/skulx6+aiaYrlqtUSnNL9
 eDhvSv9+8vPjvNPp5Py7zJ8l62+DJ0cnzzGuaK0JgjMW48fozw1QMzhEloKS7brskJy8
 9zyLKf2IFyD7cYjIYVj8frKEG4QE2uYj0tkpn+tZyHwVHwXMOBVYBakl6xp1b8O4t6v6
 vdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636091; x=1793240891;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:cc:date:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xruEMXmxKsYyy3/7Uv5aUsYVZ6xRBTshqU8cnD7X6m8=;
 b=BRdn/yhJ5rdAjEsNiyraBzlbZ+yUmv5Xu69th/+UD9JydWwqOTDm7HEfjnfTaRjqtV
 yfFRQTAGhrPoXuZXn0kItxY9/d98LZhpeUc+RswTRZbZY14JsMiApzPjLs3Op8KubYNw
 PHIFtgThVXNYXoRdsTe3Nho48kzWGlYpiByW66LC+3JTi0xiYM1RdGvTsDApeTcYBfKv
 yIS2dEEFZfaebcaiwGD6Iv+egdvWzZ6rKOoSGn27g67firlP2ARn5FzjyWEKhHjd7u7W
 LiGzAkM+Tebkylj5zTEQJZ6xj7aTdyM9rX7/u8/c4yfyJwSunjYrP0eOsp17Cz5essR/
 gxyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVZzSeEOVhTSXI8IOLvrRMgYCZZOJWu7Jtv2XxYUriWoPgoNIyfImuBHedA1Xgkp29i1vy085I2OE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJv1kQbk6tWg4jXINvRp1EFoq1ZzV4zbRbOMG967+9QP+J2xKCu
 V52MMPAi6smrAUNYez8mOeFjfcW1SwX1swx3U7CxsQzNNornGmnvrnU64ecmMFea58I=
X-Gm-Gg: AYBFou3yVzvSXeywVKHY1hq+jpP5k/2qZLVoe+kfvt3fcGtqPRJUBni2d6bB2ZaxEX7
 1qlxbZQVRQ27Mm0Z+nhM/u2aZ093AyXIrEXRmHyHJifXPdAAXZA4b3fcRGQl4d8pdDZZ9KMKUIB
 sXeOwsRVCM0NfxkpGNCzazjHg7alb7tMNjNeSz01GSNNzhUR6ZvrFaw5agxMrWbZVulbn+b5tV9
 3tCnjJ0feO61aNgjdPPu9sJpOi2oIk4anRIeNwVhCULdzAxEjpA4gb3q72tRu6LI8l/1wBKzPhw
 WBnEvUQ6hmWRkXGQQfFpQ+VMIgLJTtnNriWE7HDBHdvzRK0k8ItUECB4WQpgBRufg+b3GmsNpar
 LzSjGV4wGNYssHCPO5DaBY4hyolPS9Z282oUkKhJi438GXN+sVTQ8xlBRGcv3X8cAYJQ8mW/arF
 iJ3MQREjbgiy1eU2gCxOeqD8wcEM//6DTwmRb6cZoYJBqh6dgFY8jlPfJmsyBGpkN9DxN7ikzMv
 XMkGZ0PIursK4ohJOXZMDIcPk5BOg21tUxYTpTD5IiZTXQxUYnlezA+2Fcon8rd6xVpajHnneXT
 p2TGjNintG5OQbH+io/083waNjDqre71EHBikN1QX1BoVgUFRgzYWsWFRFdM6wk1w6a/CwAxYHq
 HuXd/PUDpFy2wyvBDik1xOs7Y4QnTH60Aj+tLHk1BIU9mPaLGEsXAQVlKCnyN7olmh63WJAVQWD
 nG9S/Zzg9yn+koShGzyTE=
X-Received: by 2002:a05:6820:813:b0:6b7:8396:f3d6 with SMTP id
 006d021491bc7-70941fbb729mr2897081eaf.56.1792636090730; 
 Wed, 21 Oct 2026 19:28:10 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([173.174.112.101]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5eb8fc0sm3431624fac.1.2026.10.21.19.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:28:10 -0700 (PDT)
Message-ID: <6ad974ba.a8122b97.39a7e6.f867@mx.google.com>
From: karim.sabar@utexas.edu
To: matthew.brost@intel.com
Subject: Re: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update
 array
Date: Wed, 21 Oct 2026 21:28:08 -0500
Cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
References: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Matthew!

Sounds good to me, the fallback of trying to bind the vma one at a time sound=
s good to me. And it is actually a bit broader than my patch since it covers =
the -ENOBUFS case as well. It should also be easy to get through drm-xe-fixes=
 and then backported the normal way.

I can write it as a v2 & test it on my Panther Lake device, I have a small re=
pro that does about 20,000 mappings and fails after suspend (every time witho=
ut the fix). If you'd prefer to write it, I can test your patch as well.

Thanks,
Karim

On Wed, 21 Oct 2026 11:57:48 -0700, Matthew Brost wrote:
> On Tue, Oct 20, 2026 at 07:08:27PM -0500, karim.sabar@utexas.edu wrote:
>> From: Karim Sabar <karim.sabar@utexas.edu>
>>=20
>
> Thanks for the patch. I do see the problem in the old code.
> Unfortunately, we will not be able to pull this into drm-xe-next or
> drm-xe-fixes, as 7.3 is already out and 0e33330f1238 is included in our
> 7.4 PR. As a result, this would need to go directly to stable.
>
> There is also a risk that predates the series containing 0e33330f1238.
> If the bind has to run on the GPU, you can still get -ENOBUFS later in
> the bind pipeline if the bind is too large to fit into the
> migration-layer BB. If that occurs, the proper fix may actually be in
> xe_vm_validate_rebind(). If xe_vm_rebind() fails with -ENOBUFS or
> -ENOMEM, we could call a new function, such as xe_vm_rebind_iterative(),
> which would run each VMA requiring a rebind in its own job. This is
> effectively what Mesa does in userspace when a bind operation returns
> -ENOBUFS.
>
> We could probably still pull that approach into drm-xe-fixes + have
> naturally backport to stable, and it may ultimately be the better
> solution.
>
> Let me know what you think. I can give this an RB, but I'd like to hold
> off until we've settled on the solution we want to pursue here.
>
> Matt
>
>> Big games die after every s2idle resume on flat-CCS iGPUs. The exec
>> ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.
>>=20
>> On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
>> these parts. On resume the first exec rebinds every VMA in one go and
>> xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
>> Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
>> array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
>> __GFP_NOWARN keeps it out of dmesg.
>>=20
>> Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
>> after resume:
>>   xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
>>   xe_vm_rebind      -ENOMEM on 63 of 63 attempts
>>   BO validate, TTM populate, PT prepare  never failed
>>=20
>> The array is only used by the CPU and doesn't need to be contiguous.
>> This switches it to kvmalloc and kvfree.
>>=20
>> With the same change applied as a module on that kernel, the game
>> survives every sleep I tried with zero ENOMEM. The biggest array was
>> 30,753 ops (11.8 MB).
>>=20
>> drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
>> struct xe_pt_job_ops"), but that's part of a big series that won't go
>> to stable.
>>=20
>> I tracked this down and tested it on my own device. I used an AI
>> assistant to help with the debugging, i.e the kprobe tracing and
>> reading through the xe code. I ran every test, picked the fix and
>> reviewed the change myself.
>>=20
>> What I couldn't do: this is build-tested on drm-xe-fixes but only
>> run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
>> not on a mainline kernel.
>>=20
>> Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
>> Cc: stable@vger.kernel.org # v6.11+
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
>> ---
>> Downstream SteamOS report with the same data: https://github.com/ValveSoft=
ware/SteamOS/issues/2962
>> ---
>>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 99e42bd29..5caef443b 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, b=
ool array_of_binds)
>>  			continue;
>> =20
>>  		vops->pt_update_ops[i].ops =3D
>> -			kmalloc_objs(*vops->pt_update_ops[i].ops,
>> -				     vops->pt_update_ops[i].num_ops,
>> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>> +			kvmalloc_objs(*vops->pt_update_ops[i].ops,
>> +				      vops->pt_update_ops[i].num_ops,
>> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>>  		if (!vops->pt_update_ops[i].ops)
>>  			return array_of_binds ? -ENOBUFS : -ENOMEM;
>>  	}
>> @@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
>>  	xe_vma_svm_prefetch_ops_fini(vops);
>> =20
>>  	for (i =3D 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
>> -		kfree(vops->pt_update_ops[i].ops);
>> +		kvfree(vops->pt_update_ops[i].ops);
>>  }
>> =20
>>  static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 til=
e_mask, int inc_val)
>>=20
>> ---
>> base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
>> change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd
>>=20
>> Best regards,
>> -- =20
>> Karim Sabar <karim.sabar@utexas.edu>
>>
