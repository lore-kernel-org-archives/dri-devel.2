Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF5C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 22:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA4C10E344;
	Fri, 17 Jul 2026 22:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RssnlQU3";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB4210E2E5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 22:39:32 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5b0115b9e17so4826050e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784327971; cv=none;
 d=google.com; s=arc-20260327;
 b=D2k4CTQWI70Rscf1+TR7H9y4IAfYd9RLeQG30BHR+Dl6FJ9osVa7og6mlf2kuN++kS
 zIxcQND/m+NG+rR23ia6ZfJ7scAZlKpKXq/tnuN+mFm55rUI7j1dU/YLFStrvsaqgkid
 o3OuSVawSeTURlxOo7oKfd8gdr7yofJznE2KREDi143m/naliQu8JFYp+nnC7HLgBGS9
 YU0YXJqhyeLBPhU9cquD7KTl/CRae1OJ0roOJPP/hynnU2OeXEUt4Q6y1hPZt7tFEUTr
 gxdpUCynyRzpwINigkoSRHoHIaW0/tn3GYHXJ3+DV0I1dCkW5aBKR3jAUL743eP3CcA6
 weJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LRkNSJZe2U19CYjgtrr82GDpwrQo6buI7ELWlIUz19c=;
 fh=iTWkCJXf+N12dc0aEzs7IHw3ud4O0+raTBBmXi+wuHI=;
 b=XzLto0AbZevG8k+aVZ1LAeQFSmpVOVjswOZ110g1GW2z4Y8pbXmDW5LltS27brJIFr
 KjgGZMy9suILtq12Lz99UUFCpJlS+tQtdGPCN7H4m3GC3vGntptTmsiYZ5JPoa8dari/
 bCXOUdiqxJRaNuZKp1Vzio/nwb2cBv3Yfp62O+DAR3Ua9nODAAbRE1oiwPEDNH7e1CYV
 ofDotEVA0lYcX9Nm/KazksFsk1e2NCDkAzr53wpo1mBj479fyAsSC7pcbHO5iF41Flvq
 HLvM7xT2PaZLqRS2tkxZ5FtMociB91rOlHLqNSo2jTj/3Its4yxzJUskK2WjQJyOMOmf
 SjgA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784327971; x=1784932771; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LRkNSJZe2U19CYjgtrr82GDpwrQo6buI7ELWlIUz19c=;
 b=RssnlQU3dkvGdZ4p2R/aoK5DhA/NI4kxa2p0cauCqKyF1NB+tClnOCFD+ZvL4wcT/g
 iS/QkH01/984qmcHHMNyYZEjdOFZ+EEgOvM4kdpDj7YyXy0AMrpgR5cqszVahprxBncG
 cWLIUF2orjbozQ3KoRfRMBCnbNi5Z7Oxmf1uXEwobXtd/mfWcjZWsq914kENVp/S/0yl
 sqjDf2SAJOGM/eH6NZR+j/n3hzfywz3patmXwL6ZsL90h2Z2MbELSF+V1yDltCD8ahth
 isaunA0rFlNtAwNJ23LzdDTyRemmllY4lFFXuuR21pkJtj+iKUJ3RyvveK9uE0Wde3Rz
 F+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784327971; x=1784932771;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LRkNSJZe2U19CYjgtrr82GDpwrQo6buI7ELWlIUz19c=;
 b=o2JuJ6oD8VqASOYXBjITpY5HHFN8u8GdGKH4NDK4PEGwvr3Ft752DTzALdbzO2ZHi0
 zjedr1FTgSyouKjFzcHOZnvIjCAF43J/uM3j4vChTgJAefCbRcBHGLrzlm9wJgjGsYLd
 CgbD3SFhhi8sKV/+s4e0mTSGiwK+KfGJ6v9SixnntFttrtyfVHoLoV96MpH++riywlB8
 F72G/jjROmqrH+e0ox61y+8oPdl89vcLptIgg3tGFjEi7K3mQvDm0zYzRMl36lIxwB/Y
 YS4KVwls291/ALY6nnqpDxa5cFqrDaiPGNQgipysSCdaHkDpy83SInruMNm483fZNiAc
 gqJg==
X-Gm-Message-State: AOJu0YwK+/9l/KaUFY4NsHVPt0mZcFF4QqkPOdqtE0uQ10Vn+l6yrZCS
 gfFfB0OMSMgJjp0GyGFaKATA26Y4e/fpp22zRe39IJ/j6cc80zRHtq3k9zmzxPcfH/cHsi3zWMx
 1MjKxgi4Ey7InnctzCInuMwGFolYKNn4=
X-Gm-Gg: AfdE7cmTh95Gsd54qviof5JQ9gRwniU4E2i5IpjzV8j6NYYCzRmk+Xna5rpvIlTvtZh
 XAV7UMXu/9f7JZsMCclSb90/cHxFYM/RqGFSOwaHjh4z0DiCKYbyz2Yjh+CITIiR/ZOOndB8g1J
 c77iLwX+SLWsM/XhY0O6awbHXhd99acba0ix8ilHJQsiDORRj4KbRs/Dm4yD410yF4AqrQGEN+T
 /xrBROHf4zphv89W/Bo4O4YkNrxMDrbTqINkg/zg+nfCF4T+sL3q8Z/rfasnIOysUKHvMo9vpLk
 Sg+Qd3Bq1Z1M2zSEukTUO84vsRvz4PLWdxsdT+3i2SL3oOvH8WpvxBe9dBhGjoma0RSoz/gB4wu
 t5ksq
X-Received: by 2002:a05:6512:61a2:b0:5ae:cf16:489d with SMTP id
 2adb3069b0e04-5b28f9b7c24mr956500e87.32.1784327970524; Fri, 17 Jul 2026
 15:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-2-kieweg.leander@gmail.com>
 <20260716-decidable-tingle-175efaf36540@spud>
In-Reply-To: <20260716-decidable-tingle-175efaf36540@spud>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Sat, 18 Jul 2026 00:39:19 +0200
X-Gm-Features: AUfX_mxpQfuaZHTtcrria-kK0Gc7mvWWjVQ6o1S-g3N_SXZuZJUJKjEKnEsiiRA
Message-ID: <CAMwcS0hBc_ruk_r+F6cQHQzO+jZagi3M9_AHQ3fpT7cbSUqeOg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: Add GlandaGPU binding
To: Conor Dooley <conor@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org
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

Hi Conor,

Thanks for the review.

> Sadly googling this device only shows up Phoronix and other copy-paste
> reporting sites. I think it'd probably be good to include a link to your
> project either here or in the commit message.

Good point either way. The link was in the cover letter, but I agree
it makes sense to have it directly in the description too, so it's
not something you have to go dig up separately when looking at just
this patch.

> This clock sounds like it is actually required? Doubt the device works
> without it!
> pw-bot: changes-requested

You're right, I'll move clocks into the required list.

> Usually I would say do not include things if you don't have to, but I
> would much rather you did if the alternative is an interrupts property
> like this that doesn't resemble anything used in devicetrees.

The example was actually taken from my DE10-Standard DTS, just
shortened, since I understood examples are generally expected to be
minimal. For v2 I'll add interrupt-parent back in and use the
GIC_SPI/IRQ_TYPE_LEVEL_HIGH macros from
dt-bindings/interrupt-controller/arm-gic.h instead of raw numbers:

#include <dt-bindings/interrupt-controller/arm-gic.h>
gpu@c0000000 {
    compatible = "glanda,gpu-1.0";
    reg = <0xc0000000 0x1000000>;
    interrupt-parent = <&intc>;
    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
    clocks = <&osc1>;
};

Thanks again,
Leander
