Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE16CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F3410E24F;
	Tue,  6 Oct 2026 08:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgtAIPhL";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494EE10E241
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 08:16:55 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-67694513f2fso233590d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 01:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791274614; cv=none;
 d=google.com; s=arc-20260327;
 b=bJrlMDaPYrKzgSFLoxp9E5IJcNS9+VFdIguo8v8vhvxoaQgbF7NJTFNTlzrQ2Y0/wX
 +l44q9njgBnH2KRbrceDNadgTzIQSlQ3ypjtkfAtEIQqinbxquzEs6ojvhzfd4utaOna
 lhw2W60ZQV2lh6Y1pCmx3m4NVFYnV4KbhinVttLdXEiVlM39uiP0Oytx/s7GQ/afGf2r
 zmfbxpLr3Ru0JaWQ1s6Vy0ja7IMH7j05LkMiknP1SkWjoS7F1N1zai3SQY8tKzYw7SmD
 38kH1FbxpcO4GLJbubT68/CdDGhHamPN0xtqthj5qE02dD9iMmFX9uWkgIXrVCqJ7cav
 lewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M9Rv85jYRiQwHKznmIIhpDMEGyoRERFYUq6l/Icw6yw=;
 fh=3xFZtIwmSlAs9Wn85t2bTMRxRnWk08ikJc0Snsvhi70=;
 b=F5+54FiUSdHL3lYLBKHUn/t3yyOfLAIjTQbjwOmn98CGJPtHsRt8HKFkMul/BSKfyj
 DauDTFYEGm82PorPm/C7J5OKKJ8UxbEBSvBaW4I+YrQHA9BC3kqCNtYlYG/b3fmjdOcl
 xOb4TdOp660tK7t4U7O0+iaXtJ9VafKhqxs/7rs+pu16AWwidXEdTfMwWDkCuo0FW0CV
 B6/QCDTMQ1h0H0Juc5WO69lookiYXnzVKj5mRj1CKhCGR0Arxkf6pd9zhPEyf0K9FX6c
 Nl4FNuyFm0IXEgkj6qTSupwX3RCEFOregwEuYTNdZtaTUYZOzTkDpWwENhUblQmT8+3Z
 tJXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791274614; x=1791879414; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M9Rv85jYRiQwHKznmIIhpDMEGyoRERFYUq6l/Icw6yw=;
 b=AgtAIPhLuXE53tOIiyDXH2FrYCDdag6HYq036uNCw8K16oC3nmUD3o4sEC/9JDXvAS
 jaVGFO8hpxOH1pAsjjQhh7Lw5yzAbcLsPSxc0GdYkq0SRqZoqYc9bc4BsC4JAWxG92Vf
 raooKynsuZmKvzvrNzLrfZeRsrdiitfEkjjRZDkK/zr7FBI2vmzwEzN2tFlj8MtVDVR/
 97mCzMfefHEWh1e+B0Uhua2pl0gPaWh0JFUMneK7hnzqgOJvw63dJW1tGIfdxfTPnCeV
 CAsfpoopJu2Q1Jc2jobaJ//6sECs6Nfj1sVfSNQThqyjCN0sE5tYhpueWbE2CFTp/a6O
 o4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791274614; x=1791879414;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M9Rv85jYRiQwHKznmIIhpDMEGyoRERFYUq6l/Icw6yw=;
 b=w5cZBkNfiH6DgatupnqQ4H2Qk6YsBnLQx1KFUR3DzizVK7t2CQJsrS5ogd32+AYQnZ
 BJPgvgS3a2DwZAXify6CUY2s3iev2s9ZhwuVUxnr1UOasa1cNOyldhW9wMftLs8s1JQc
 fWGYIlnbhzPlVkr3DkyElanVWWyYG1dTenY1zTYp+l5KHNvbS9g5hbTrmdyeRwtflAX9
 RZKqNZtYU+smwUaBrf5/VsSUae8CxpZwDf3HIumVweuIlFkeJHt7WRcKsoaqXKtVrNo+
 dbM7F7Ci3ZQUbrTVAN1CAwVVQ5gIYtgDUN5oek+M9IipEwSs4ZaNlkj8nuGiX5sTHvvH
 nCvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9i2KhyiSjyLTYrHtkoH42/f0lCsDGQ2QVXCWaIogCgJjCFwuXlLWR2PXeXhMYlrcZ6JXZ3gzjgZ8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIU2buR39ILS4DbGETKP43NHsK83fLUcdN82QRDRTicqSt7SwZB
 a5LapGRZPz6xKXkVeQwgRI2N17E5wnbdaGPxfRJdCOj/0luj+c2SduFnRWJ2vO8MHojOWMTdIeG
 xUhF0WCNn6zQxvXBogNPLKO5W8JnDB2o=
X-Gm-Gg: AYBFou1CpI62gd0KkOeWqNPpokEU73Dd4TSEfF5jju6p3N9U7q9zhSO5MF7HBCnNFae
 O5LlIQWD/W1JSLsGOY0oywHJLRajmpfvpwXrWipgwGJKTTjIx4t6CrJht5kntn1M/J6htVF0A1/
 OBmuev0n1eGXsbhkpgWe3XW1H0Aw9vc0e8COfBjNpbcglBBba4lf4beilmEM55OigSKTx6B1+cJ
 zjV7M1QgJ7dHhAwlBh3VfLyRoJ33a2A4l7IEEnLeoaF28lNBL5XvkRdDZe9Pjasc3RRSgKVb6mH
 wGzCSkVja0k76tcYVg9qRE/KvDfsh/Sb1zaz/1cvqftdrSjAEPLrcI7j
X-Received: by 2002:a05:690e:4889:20b0:676:8313:bbce with SMTP id
 956f58d0204a3-678fce4b33cmr117248d50.122.1791274614075; Tue, 06 Oct 2026
 01:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
 <64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com>
In-Reply-To: <64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 6 Oct 2026 17:16:42 +0900
X-Gm-Features: AclHuK8Xt4FPcZVN1sc_kd2ytwjyU21VKl9isbIhwqEN1jIJop9c6JgW5_I0rHI
Message-ID: <CAKbEznvDanJtt8yEL2UmTeLpA1SZOT693E6AD1Xau+mU4Mztuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>, 
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>
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

Hi Alessio, Brajesh,

>
> Somewhere in the description, could you also point out that the previous MMU
> page count calculation could underflow when a mapping crossed a page table
> boundary, that would lead to the driver preallocating a huge number of MMU
> pages, exhausting system memory (so more or less what Sashiko pointed out in v1
> of your VM_BIND series and in one of Brajesh's recent patches), and that the new
> calculation also fixes that? I think it's ok to fix these together, or anyway
> I'm fine with it in this case, but up to you if you'd rather split them.

Since it's all within one function, I think keeping it in a single
patch makes more sense.

> Due to all of these and the fact that these errors are easy to trigger from
> userspace, I think this patch needs Cc: stable@vger.kernel.org below.
>

Agreed, will add.

> > @@ -2337,7 +2337,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
> >   * @ctx: MMU context associated with owning VM context.
> >   * @sgt: Scatter gather table containing pages pinned for use by this context.
> >   * @device_addr: Virtual device address at the start of the requested mapping.
> > - * @sgt_offset: Start offset of the requested device-virtual memory mapping.
> > + * @sgt_offset: Offset into @sgt of the start of the requested mapping.
>
> nit: could you also update the other similar description inside struct
> pvr_mmu_op_context?

I'll address the rest in v3 as well.

Thanks to both of you for the reviews!

-- 
Thanks,
Gyeyoung
