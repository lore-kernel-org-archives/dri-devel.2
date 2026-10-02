Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1CCCA5FE1
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECDE10E09F;
	Fri,  2 Oct 2026 01:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qwkg+LJS";
	dkim-atps=neutral
Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com
 [74.125.224.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF9810E09F
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 01:09:00 +0000 (UTC)
Received: by mail-yx2-f40.google.com with SMTP id
 956f58d0204a3-6762de1c77eso2556506d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 18:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790903339; cv=none;
 d=google.com; s=arc-20260327;
 b=Uj9Jxj7mzIKqR+P07nDbxpyYhNyEQnUPxjNqwWqD+1H7/iCFzlje2Q0VILVfSO0zrk
 wPjkH8YyMBFY+5ENlaAxHmTsTYpk4xMflC6zc3MQXXOABa5nHyqke/672RhbSjUN16EJ
 KhUtDuggZ9ghshz5IFJ3oslynoDHi+Rb9bNcAIWQUYLzpf92zRsKpHTyYPV0ajlbSExi
 IN5294W3wuNVBiIOX4Kjp8xBu6Dlfu4jVA/gXxesxA9XKfcGi1KtK8R4usKKctihNFKI
 HZLNK9QDnViBCgpFTuyGLKvHiV8dsefPIlGlrRK7BNmRsvUORsOQQiz3TeuhW6KuKi5t
 wLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OP5zp61MrjKPY8CNhX4kYBCEBteI7PfiFh3wprS0txc=;
 fh=fFkqZkZqEdnUEUNmR8mAFXAVU/zcyYPrZ7SqdMDE+Ss=;
 b=KAMNzqdEfI/r6BmvDNAyccXiENAnqsquL5VYbQvkoi68e6prEePRWR4vBAcoLhKOPm
 UbA/PlF09b9VxsxV44s90CcxjLfupyHMJlAuwDUl0ie58OW7F1dSlG7hYclalEKV7xyt
 Lfcm/YeEWcNxW+RwSXGZ8v6AJ0gxiJYnceFCHcLajNsGjFz+wmJwmtUPwZP1w/PwW3Nm
 /bru499F6eiz+onvhoXnNHivx930qyJPfsTBgC8B5iFyEAXTJfhKPeAbqRVky85r7WiU
 OmC3G6A2SV8+2Kozv19Twi4qACzUxFqIgTnI5QvjQgc6QEzo18uVE1ib04V6iLDvS/1L
 WOeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790903339; x=1791508139; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OP5zp61MrjKPY8CNhX4kYBCEBteI7PfiFh3wprS0txc=;
 b=Qwkg+LJSMXwyfSzzpnzHflbIvkFMt41+5RKcbig/9FMSD4WZ4S75cV+IlIXJus/mvJ
 NcavV8vVdoxwEKkndx2FxmKFzJEvwR4BgQxgJIRSPJD2ReA0CIcGEWuJcAMjn/i8ej1v
 GIEf1TJ5pme3X3rLcZbMzihGpJcoqBU8Grttw+8cWsB4N7cQh9M0ScYLLtrkZheq1FLy
 KDjLC+G5swob54DhNwZwrWvK5uaWfhAbthONTM9grH7fgvZLq1iJkZ2Z5LtwaePnDzKm
 J/8of66/LjyxK9kQ+cFqi5XtmKqYgPRkJNLzHRPOyQWmIH1ampioKRpbitZxffjs4rK1
 XUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790903339; x=1791508139;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OP5zp61MrjKPY8CNhX4kYBCEBteI7PfiFh3wprS0txc=;
 b=sQ7w1Sw6SPeAprSngESxzu+qsZMzpBW/w1NCMaN+2QilLb7+Fk5TkmSxuVAGQCePNk
 8I8Rk0a6STNBRzs5RU4HNZUtyF6uBHWqEJUy5O/cCX2t7PSZfiCG6Ni5vUXod7+YHeJM
 4ElRYdHvLwo0E8nEnwhyIAXT01MR6ZMby5mS4PTqiOuM51GM6/UiTwLkUFHoFt3h/RDj
 k5WoKqCxHjbAmDE2R7t/moH+RBKXjdbWkaDA2gK0tAyCaz+v+R1joBSVYIfbdmc1pwgh
 D0iK/8PcpH32X3f0Ow4bizxs2gvTGFM2EK9O1hWtdYSs/cjaqWwT/i2hLlEsqkCfdscL
 TSLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByAEcnEk8tAfjMKPCvABGfionJM8o4/Crz/DJcrjCTj/lnnb8xfjQY7TDNzZ5O3r1jzOmEXvWWl/3I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2II0l2/31Kba1kvIncTWFuNiEGPrXUvAVnVBce+2xsP8yjJ/f
 zMF6tM5+pAHof8AwzDQNd30VtX5b7wKREGXbg79DvQM3nYsfmFbrrVl9f5sUZyLEM1iHkpm7HKL
 rHs4VtNJ7ly4t6A1Yu7XWOUrHB8XWBdM=
X-Gm-Gg: AYBFou3I0GXw16/InU6AKCiLryA+qBBml4tnLOkToiryyGkuiovch6h4bl/TMJ1CKda
 bgRFOn2lQeWaAVHg3nvSs9B+fgEmWL5rBUccOE3Qow+Ph6T5DweL4LulknkXT8TJyOymZix8BTv
 aRB1TDJzE+daDRkY2y5jASEIKf1Zc4M7eKdRxKRN9HR3ZNIs0eienpPYD5T8fau8ZQlZYbEtKrw
 93fpd0gd5MRzvSVtWY2BxfjXShR48ARKo5U6Xt8wER9pqSrAMJGtO9QwL6ub+/3WOqARDppx+n/
 cRFirOf15hG8yrlNSrl5ype4zQ5mqTNpdcbzieLYsYtFR7GPexV3UAYobD/m9xVob3M=
X-Received: by 2002:a05:690e:1d2:b0:673:2e61:1720 with SMTP id
 956f58d0204a3-677ac0ae6bbmr380025d50.82.1790903339575; Thu, 01 Oct 2026
 18:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
 <0e62e6395ca0ea1c0cb6d5f973eef05a57df2136.camel@imgtec.com>
In-Reply-To: <0e62e6395ca0ea1c0cb6d5f973eef05a57df2136.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 2 Oct 2026 10:08:48 +0900
X-Gm-Features: AclHuK-OHWJzRH5kn9gO-J8iY5okJLINZwSskhDvYeT2xdlw8ABFwgR8e13fUWU
Message-ID: <CAKbEznvLy3dio5FigiVzcAggES0e1fjd_xFUzq_SZ4+zv0Rw5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Brajesh,

> > -             const u32 l1_start_idx = pvr_page_table_l2_idx(start_addr);
> > -             const u32 l1_end_idx = pvr_page_table_l2_idx(start_addr + size);
> > -             const u32 l1_count = l1_end_idx - l1_start_idx + 1;
> > -             const u32 l0_start_idx = pvr_page_table_l1_idx(start_addr);
> > -             const u32 l0_end_idx = pvr_page_table_l1_idx(start_addr + size);
> > -             const u32 l0_count = l0_end_idx - l0_start_idx + 1;
> > +             const u64 last_addr = device_addr + size - 1;
> > +             const u64 l1_count =
> > +                     (last_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT) -
> > +                     (device_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT) + 1;
> > +             const u64 l0_count =
> > +                     (last_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT) -
> > +                     (device_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT) + 1;
> Shouldn't we use 'device_addr + sgt_offset' instead of just 'device_addr' as
> start address for l0/l1 count calculation? Only account for requested mapping
> instead of whole memory.
>

This already counts only the requested mapping. `device_addr` is not
the start of the BO but the GPU address where this mapping starts, and
[device_addr, device_addr + size) is exactly the range pvr_mmu_map()
fills.

Adding sgt_offset does not narrow the range; it shifts it by
sgt_offset, which is an offset into the BO, not a GPU address. This
can leave too few preallocated tables, and VM_MAP then fails with
-ENOMEM.

-- 
Thanks,
Gyeyoung
