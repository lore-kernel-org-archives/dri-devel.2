Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64A606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeDNwZxd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEDC10F456;
	Mon,  9 Nov 2026 17:13:38 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BA210F457
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:13:32 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3adfd217146so432577a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794244412; x=1794849212; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oeNE+sqLHyyLIoS+hr3FxhWoJgh8QINKzJXl7a9fZrI=;
 b=KeDNwZxdU8S+2XKJbfPFgxkNONBUtC5F2U+a7I1IY7uWpTYvUfLWKONYnV9CSG2FJd
 np3lljoymiwCAQd5FvR/BqLXThTNPf7bFxcW3dtXaTaKQfqTAGkYj0chYe8jNdgB0RSs
 3sWlgxGXrsVIYUPwmlL6QP87J4AU5/alDxFD6coIPdq5LjXeDrl2mRT13bN04t7FfDPc
 zDVPHrtqgmz5yK8LbI0YkNpfxjparh2rc/Ty2hjlfh4DMQDftAFXleCpEv6HmR+83AHj
 jPMJ7TqHJXoN03febAcZWT8caTsoi/el+02VPvID+nGZTewtobPG8q3nzGTUzvjC8lEP
 ohKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794244412; x=1794849212;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeNE+sqLHyyLIoS+hr3FxhWoJgh8QINKzJXl7a9fZrI=;
 b=CRuWLCHMfebNiEXLOZKuw9cGsqTkZk8WHs2JyOBtCaMaxlwIHD/7PaMbu3OUZWGMfr
 hTBWdLmjtaTQqw3q4sB6uwvDW7hF4NqJc6tlpX/UMKYqaFyjdfewCAhQ43M5oY+jC3Zz
 BFCDWJyOCm8blPoapE+YK8vzV5iNXDRlAsrWYJEb1t1bg47qnZHzc21UII5TXP6Ux5Ym
 XpyGJN3GpBprf7L24Ou4rV6pgY+HC+I4onVcr5QK73fx/FXBALcDhyhURowwZOHHKE7X
 sQrEyNCQxiYkNLaovQatNF3aCdvbpBOho6r2+z+qo5sDkT90O69PxskOvtAfhJzMXMAq
 42Pg==
X-Forwarded-Encrypted: i=1;
 AL+hErFUTWthEfYMzjwaPYGPrJs3EoRmfxiqbCSUtMMHob6Ei0/+hhCseIF8qd30X2nEJhE/dsbMsgxIJ/4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+oQlVKY1o5t4ZOnXU/jWnUKDXiX4VG3yl65IcsDWxSbngill2p
 CQTpIPcjn+vyWG2gvs1fHJM5ZRq2OqUIAqjU1ErYGDXexKgel6+bWBPT
X-Gm-Gg: AYBFou1RZC7yOLfTN8qgoz6FYLmgXHB+GRAk/q98ZszKMBW5xxjJmR6rZ90A4mr2fgW
 V5Jd3/GWfjqPi89fQBdXTuGIlB3sx1HJppfUBXqheEHbwFlFbuXf4CwotDavQEVJ8yZcoVGLy9I
 9QlLCXnZ+0aw8dnpvHR24SW8J7DPUHfFDeENAFCC/IGrTA+EuvWqWuSwgdYUkeEqfGGNaQJP49M
 YTSahKRl30TbsHuGrEogUVVcGHoaWASzA+yqcSgfCJzCOgiIkHk9RXVWcRzp7s0iFKmKzdRX/WW
 sLORTj8l3GF/NEanEsBIXxeaDxqtKvziaT0W4p8XFSEJwvHBW0n1X4kmUkdaVTlVo1Gu1Ho6BPD
 EhpqHU2W0+y6RVUmEECfkY1C53eIrLgtwlJx2RyfcYT0y4YNXXeBuYnseuVahoBeIzxp2hdAxu/
 rNemadKldwlx+J/j7S44kxLdfGIPHSqPfZqEjXcyHsZWoGxkU3g0S+Bz8veNPlQmWGCkqz+O94r
 79/z612IcuXxHMTLQhgJ4f00vx8ZizcVfMEd277AOAuyAEqFJZJkFXWbDGw8JMXjGMysK3Ig1my
 JO1n33rRB+NUnSo8Ou7TqTh+2aPRcetNr4RMu8cr2vg/5LJvSsBOVunGNKs/90en3f0A3oQNnJn
 6X+QNn1AxBfc4bRSV6eVO/khV4C/cc2V3
X-Received: by 2002:a17:90b:586f:b0:3a8:cb54:e135 with SMTP id
 98e67ed59e1d1-3b166cd7343mr254891a91.19.1794244411414; 
 Mon, 09 Nov 2026 09:13:31 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1679c41aasm92356a91.0.2026.11.09.09.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:13:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 08/22] drm/amdgpu: implement SVM range notifier and
 GC helpers
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 04:12:45 +1100
Message-Id: <179424436564.222336.1790875367286789154.b4-reply@b4>
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <20261021025915.2433837-9-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-9-ray.huang@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ray,

On Wed, 21 Oct 2026 10:58:47 +0800 Huang Rui wrote:

> + * Invalidate the GPU view of @range over the notifier window: zap the
> + * affected PTEs and clear the gpu_mapped flag. The range is not removed
> + * here; structural removal if needed happens in the event-end phase.

I think this can leave stale PTEs behind when only part of a range is
invalidated. Take a one-page notifier event on a larger system-memory
range mapped with 4K PTEs. This zaps that one PTE but clears gpu_mapped
for the whole range, and then the event-end callback unmaps DMA for the
whole range. The other PTEs are still valid at that point, but their DMA
mappings are gone. A later notifier won't zap them either, because
gpu_mapped is already false.

Maybe the zap should cover the full range when its DMA mapping is
going away?

> +			if (crosses_boundary) {

Another case is GPU_RO going from 1 to 0 over a whole mapped
GPUSVM range. This branch isn't taken, so the PTEs are zapped but the
old DMA_TO_DEVICE mapping stays around. The next get_pages() sees valid
pages and reuses it, so the writable GPU PTE goes in without an
HMM_PFN_REQ_WRITE fault or a DMA_BIDIRECTIONAL remap. If it's a VM_WRITE
MAP_PRIVATE mapping whose CPU PTE still needs COW, I think it can miss
the write fault. So could the old DMA mapping be dropped before the
writable PTE goes in?

I couldn't tell from the cover which drm_gpusvm base this is on, so I
used 671b7825dbfe for both of these. I haven't reproduced either one on
a GPU, though.

Thanks,
Aveline Noir
