Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5093606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RHgtl+hj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BABA10E9F3;
	Wed, 21 Oct 2026 01:45:58 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3DD10E9F3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:45:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso76430f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792547151; x=1793151951; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N685GSgBsocOGOaVWgwO0dJAiPky3e+vK7Q06g1oPm0=;
 b=RHgtl+hjpWxhRK8/n19zI3LJ/fxggbBXNfpZf5N6h6RebGtaB1prVxl2IBMn4rB7u8
 qKcngzkz5nyYp+llRe0rOrbVcVb58x8j9CkkUmVYE8lrFK4Mne/ZR+310F0Zye6a8LGE
 KyhQm/Yd5A+mcqRWbOUz71N8Yz7p8G8WCTOWFfL9+kkDQTFPhwk/qLLuEE/HYu893Em1
 RQdIzPCSeQa6BMlDhyW1bzw7jm8huZHItGQULVqflDOElU7v3vVU5EjdojQespoCnTAN
 uUlWpF8CIR1JezZB3/oq7PXP5A6p0c7Ikr19RP2mwhBPS1uWYZA9YAK0+8lhfYasaJdj
 QAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792547151; x=1793151951;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N685GSgBsocOGOaVWgwO0dJAiPky3e+vK7Q06g1oPm0=;
 b=muHVLfCXUbjGz8fRTFDba8sU4aAYCWNd8GFbhifpcfJLplMFuj7g1wOuOUw0LAkuWg
 J1gPmEdGQF7i5BcU7WrohEmebHv1JGh/XR1AUjTG6slKnj8HikXiIVTDHLbYwZihmVyR
 Leej2OtiT3+dTA0tZUQ4BDodvJvqN6XFA7W495nB0g06tEk2+ehRNlYbuhjDN8fEXRH+
 GWfxz1Hoztb4G0cFTPlcaf3AVAzU/GGVQXkYd8yXcQMaMteWP68MQuKVcieXUOCUAV3W
 ux7dUrx1KqBcWAoTJEZm/hQpgW1tjQczjVMZFlr87FcqjwyuLieJ7ZMaog78NAfAc3Zq
 7FOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/hDuRM0KyXDU9rPlAbtuUGVUlF5EOTHw9aBI29PTuZD+ubTO7wWRGmdu+c6CK94+aNV9ulKgjgkA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJUUQwRndw2P+TRqDZfZtdi0ckhBbm+oFR3mOlWP26XVnee3S0L
 tAJDLAYVjptLYFfebNFU2dYochJ3c9r8cwRsH8prLKxpBB4Jg+en6fE6
X-Gm-Gg: AYBFou1w3VyK1lyDWeVnQ/gTfh8cM01A1dwxGC6PHzaTh3xq3wg0rtvVCf7mp1U+qwK
 YOq/k/YsOAYadamFJVzP76yrM42/ki79gWwl0YMTtiIm5YZZ2l3d0z3GbDT3gsqCk+Mdn60kkwK
 5HcQv+bzegx88cQ59sjym7n+X+v5uWrRrfp6I+gPG8XlK1+Kw9U/T7BpI0Kwm9glV2aRTY0fTwo
 aJudw0yzc00FrDK375RLn9ZEnagx5WYZC7D0/iY8ObQHltmdkv8DSaqmMTR1I025KDZ6/+3QM30
 XxzdlKwnIH7eh7NiDFJgEL/6Wsk9sxXYTgcoTGwl9P3ntPvytWNNwwEuQhDnkdQSCRcPjoKFxcE
 VOQm+sZL2oQo7DXgwEYRFBIIDjyvnJlZsYNO/ACJUbavsJcbjFsYvrTvy+2iY4q2sxFJwESyoIP
 rC/oeeW4C554i7HBNzoUJepzII0JTnCLN6rNn1n56BnBHYLUQutna9CLtuj/y1I0BYz2NYz0QPx
 adDKEAyO7SK+lhc2umb9lA7fluqQqbrEd49K7le59cjdov4NbxiSDlX9+sL2lcHEPQcYHeVdN3Y
 oWZSfXLYVDcUUYLucxx+u9rUyybzxDkT92+FvyWHE9xV6A4ljf8DBnGoUFBApc1XWpFIFSEK1F/
 BWDhmqJs2r54BB2w=
X-Received: by 2002:a05:600c:8714:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4a1fdd1604fmr8629335e9.16.1792547150977; 
 Tue, 20 Oct 2026 18:45:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl
 (dynamic-095-117-105-001.95.117.pool.telefonica.de. [95.117.105.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3666sm118638605e9.1.2026.10.20.18.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 18:45:50 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:45:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Message-ID: <atgWXLYKOFj5cZ0F@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
 <atdKZpEJVZY0enR2@nvdebian.thelocal>
 <20261020182029.GH3008132@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020182029.GH3008132@nvidia.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 03:20:29PM +0100, Jason Gunthorpe wrote:
> On Tue, Oct 20, 2026 at 10:16:26PM +1100, Alistair Popple wrote:
> 
> > I haven't had a chance to look at these patches yet, but if some of them are
> > fixing bugs in Jason's series it might be best for us to fold them into that
> > series, with correct attribution of course. Anyway I will take a closer look in
> > the morning.
> 
> Are any fixing bugs in tree right now? I think one of them is already
> applied from someone else..
> 

Good catch. None of these fixes a bug in the current mainline tree. I
based the series on the stale c37cf2824740d topic and missed two fixes
that landed in mainline afterward:

- patch 4 is already covered more broadly by f2d70dbd3dce
  ("iommufd: Destroy the pages content after detaching from dmabuf");
- patch 5 duplicates Ankit Soni's e745cd2c749e
  ("iommufd: Take dma_resv lock before dma_buf_unpin() in release path").

Patches 1-3 address lifecycle issues introduced by the PAL conversion,
and patch 6 tests those paths.

My main goal with this RFC was to put the concrete lifecycle issues and
tests on the table and get the discussion moving.

I am not concerned about preserving these as separate commits for
attribution purposes. Please fold or rework any useful pieces into the
mapping-type series as makes sense.

Thanks,
Karl
