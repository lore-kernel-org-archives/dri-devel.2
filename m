Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2954CFB3CFF
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E8810E5DE;
	Mon, 30 Mar 2026 10:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="IgtYNeQG";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD43110E5DE
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:25:26 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so42225345e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774866325; x=1775471125; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk9iPA4aEAPWdzSPecO+wqcTKPBLIZIOOXlz3adrPoA=;
 b=IgtYNeQG8ImvC8w/7KvOCGmcNB0WjGZiHumW6llESVZx8CXYSrsNvIocKypacansO+
 +VTTx7Dy3hkjbDz2LjIK8y5tM+NRuFl90tXKjFGgy7maq64Q1DrEqDSBLaH/o+Fp+R4/
 pek9hj3PcpDU0yiqFhZqAsZgmR0IbOrHNr+19qz63WoAf+IOPGfVR8dcfhD078QAr5Y5
 TQKeZAZbrXpdeb93dUcKKRmNjX2dBDulKG1xep518aUgMSnQX18KhpH5m4FsJNxpCFHG
 TUEA7KIKfPlHA00n12S1YdSMlnfVhmxJ+ebU6ZNgiegkAVkZjk45XuW7blyDESh5v33M
 q4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866325; x=1775471125;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk9iPA4aEAPWdzSPecO+wqcTKPBLIZIOOXlz3adrPoA=;
 b=G14Idv1PfjGZUczMcc5B+/81WfZaH+0gpFY3VEPq71rHSrYRjrd61o0NB+ei9v2mzm
 z8k2EV03/xV+BIZoB/B+qe5dapGYcWOSBac3zO4KzF0Lm5LQ5BsJGK5T0hp681/u531I
 QryvdDZ3RwJy1R1fDsO53waYryOM+lBongdHrE8Vod3bZFah/LqGQPIT7x3Cdw9SP3dt
 wp4+s3aUO/2Icycmm7y7HCeCcTmcx7l24tTQtU00J3kuDRdwSsb+MVlg/3FAkE/Gvtt7
 fKkrM5en9F7bNupMv0ZzvlK4fs95YUG8MnpQ6zD8jSjfst/emNhF4RnlC6FaKL/bxpKs
 ai3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9YQJj2FrFG/OSDF6TtySaFRhaYu+Gj+pFuvp2wj3XZAuKcHStxoPikNFLdN14EsY0pdHO4MExpM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwS2QveQXV6UO5RGFz0C5a/YCWAYwe0r9MmRkClluS0uAEnoBLS
 cVaogr4F6etC1ykMHY+esOA/qtV3qYfjsMqLVVHTyFFF/zbe2/dCqfkPZpsIWIfgyg==
X-Gm-Gg: ATEYQzz8GbHkdKu/e2nZCahG3QKj+lM+7mSB3gypNUC8g0xSNRYx8K6KsYWNDT6Py/d
 nxEAu6eD0M67hiav6JsgrY6cMprqQNa9mN17QlVbOEOY4fAHIlLD2e78yhFqNCv53NfZaubzj3J
 yQl7kbkAnpN2YGa9L4qLPhl7AJFTposIYHyetiJRM4iqhLE1Oab9YRpn4DNZJt8jx2jgLq4VOL6
 r2tlanR4GQ0QII4FAjjrEYENXpsJCWCqfjC5qraxj7rgjTf6bs6EwbKpQMSdh+lpx4QqvIBLL5E
 mC0DpJNAtwsrPvA30JUo8f8bhqiJcZrMFRfBUyLCSjNWsZgqu0pBb2YySBoytFzLNcSAHwuUMOB
 1EBdBTzx496O9wHQig5tOde8tCcuwUjRm8z7dpLNpJSERz89/MWcmU3jbEb3BEXwjNtkSHqHXYl
 gHRSLSWf54uWpO+eM6ofNpRfviXxThOmxm8XglrmA96iGy11zQrm/Ygz2G1bYp+Y8oYD0qHCg9z
 e4foIunKk/XIQU=
X-Received: by 2002:a05:600c:a408:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48727d735a7mr152106215e9.8.1774866325041; 
 Mon, 30 Mar 2026 03:25:25 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487270e7248sm123961175e9.6.2026.03.30.03.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 03:25:24 -0700 (PDT)
Message-ID: <cf54e793-63d6-417c-b7c5-3301455fcf33@suse.com>
Date: Mon, 30 Mar 2026 12:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why memory lending is needed for GPU acceleration
To: Teddy Astie <teddy.astie@vates.tech>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <c38387fe-beef-4f50-b928-74f96b881b7a@gmail.com>
 <ce114f02-f45e-4638-84ee-a8fd86ce1c5d@vates.tech>
Content-Language: en-US
Cc: Xen developer discussion <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Val Packett <val@invisiblethingslab.com>,
 Ariadne Conill <ariadne@ariadne.space>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <ce114f02-f45e-4638-84ee-a8fd86ce1c5d@vates.tech>
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

On 30.03.2026 12:15, Teddy Astie wrote:
> Le 29/03/2026 à 19:32, Demi Marie Obenour a écrit :

May I ask that the two of you please properly separate To: vs Cc:?

Thanks, Jan

>> On 3/24/26 10:17, Demi Marie Obenour wrote:
>>> Here is a proposed design document for supporting mapping GPU VRAM
>>> and/or file-backed memory into other domains.  It's not in the form of
>>> a patch because the leading + characters would just make it harder to
>>> read for no particular gain, and because this is still RFC right now.
>>> Once it is ready to merge, I'll send a proper patch.  Nevertheless,
>>> you can consider this to be
>>>
>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>
>>> This approach is very different from the "frontend-allocates"
>>> approach used elsewhere in Xen.  It is very much Linux-centric,
>>> rather than Xen-centric.  In fact, MMU notifiers were invented for
>>> KVM, and this approach is exactly the same as the one KVM implements.
>>> However, to the best of my understanding, the design described here is
>>> the only viable one.  Linux MM and GPU drivers require it, and changes
>>> to either to relax this requirement will not be accepted upstream.
>>
>> Teddy Astie (CCd) proposed a couple of alternatives on Matrix:
>>
>> 1. Create dma-bufs for guest pages and import them into the host.
>>
>>     This is a win not only for Xen, but also for KVM.  Right now, shared
>>     (CPU) memory buffers must be copied from the guest to the host,
>>     which is pointless.  So fixing that is a good thing!  That said,
>>     I'm still concerned about triggering GPU driver code-paths that
>>     are not tested on bare metal.
>>     
>> 2. Use PASID and 2-stage translation so that the GPU can operate in
>>     guest physical memory.
>>     
>>     This is also a win.  AMD XDNA absolutely requires PASID support,
>>     and apparently AMD GPUs can also use PASID.  So being able to use
>>     PASID is certainly helpful.
>>
>> However, I don't think either approach is sufficient for two reasons.
>>
>> First, discrete GPUs have dedicated VRAM, which Xen knows nothing about.
>> Only dom0's GPU drivers can manage VRAM, and they will insist on being
>> able to migrate it between the CPU and the GPU.  Furthermore, VRAM
>> can only be allocated using GPU driver ioctls, which will allocate
>> it from dom0-owned memory.
>>
>> Second, Certain Wayland protocols, such as screencapture, require programs
>> to be able to import dmabufs.  Both of the above solutions would
>> require that the pages be pinned.  I don't think this is an option,
>> as IIUC pin_user_pages() fails on mappings of these dmabufs.  It's why
>> direct I/O to dmabufs doesn't work.
>>
> 
> I suppose it fails because of the RAM/VRAM constraint you said 
> previously. If the location of the memory stays the same (i.e guest 
> memory mapping), pin should be almost "no-op".
> 
> (though, having dma-buf buffers coming from GPU drivers failing to pin 
> is probably not a good thing in term of stability; some stuff like 
> cameras probably break as a result; but I'm not a expert on that subject)
> 
>> To the best of my knowledge, these problems mean that lending memory
>> is the only way to get robust GPU acceleration for both graphics and
>> compute workloads under Xen.  Simpler approaches might work for pure
>> compute workloads, for iGPUs, or for drivers that have Xen-specific
>> changes.  None of them, however, support graphics workloads on dGPUs
>> while using the GPU driver the same way bare metal workloads do.
>>
>> Linux's graphics stack is massive, and trying to adapt it to work with
>> Xen isn't going to be sustainable in the long term.  Adapting Xen to
>> fit the graphics stack is probably more work up front, but it has the
>> advantage of working with all GPU drivers, including ones that have not
>> been written yet.  It also means that the testing done on bare metal is
>> still applicable, and that bugs found when using this driver can either
>> be reproduced on bare metal or can be fixed without driver changes.
> 
> One of my main concerns was about whether dma-buf can be used as 
> "general purpose" GPU buffers; what I read in driver code suggest it 
> should be fine, but it's a bit on the edge.
> 
>>
>> Finally, I'm not actually attached to memory lending at all.  It's a
>> lot of complexity, and it's not at all similar to how the rest of
>> Xen works.  If someone else can come up with a better solution that
>> doesn't require GPU driver changes, I'd be all for it.  Unfortunately,
>> I suspect none exists.  One can make almost anything work if one is
>> willing to patch the drivers, but I am virtually certain that this
>> will not be long-term sustainable.
>>
> 
> There's also the virtio-gpu side to consider. Blob mechanism appears to 
> insist that GPU memory to come from the host by allowing buffers that 
> aren't bound to virtio-gpu BAR yet (that also complexifies the KVM 
> situation).
> 
> You can have GPU memory that exists in virtio-gpu, without being 
> guest-visible, then the guest can map it on its own BAR.
> 
>> If Xen had its own GPU drivers, the situation would be totally
>> different.  However, Xen must rely on Linux's GPU drivers, and that
>> means it must play by their rules.
> 
> 
> 
> 
> --
> Teddy Astie | Vates XCP-ng Developer
> 
> XCP-ng & Xen Orchestra - Vates solutions
> 
> web: https://vates.tech
> 
> 

