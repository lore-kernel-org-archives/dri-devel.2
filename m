Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36671C88E46
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C8810F412;
	Thu, 10 Sep 2026 10:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.b="mEx4ynb6";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FD010F0A7
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:30:35 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-90e7bde5596so72428016d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 03:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949834; cv=none;
 d=google.com; s=arc-20260327;
 b=AX2sCmwd1AzpwSrtSoCtKYqAQGMkhv9YEsvMVdO2GzEg8qdR/uIu+sg+oeh/HTVhMq
 5LEvkKqaOBbThUOxG0vo4hGLdK7c8kFa/DB/+kqB/RGe+JEqvJcfrB6VZEzJpxzIb+y6
 BbLybzgbO+Awxc3oH/RLDCR7m7/EfRF1MVltZrNkwNwNqOuY+/1o7rXsXsHhak3mbBi9
 lLvvkztoDq5oxliFfUiINaBHwNQ/1FRB56xPmmtZieiU6qG3fAJF95RchBgut3ukE6EX
 6P3MmXoxnmRP+kLEsqFNw9p3JnMMskD2B7ZQ8/xEUT8xY7S1fnE9w2pHqo4iu5f245mh
 FJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jpRvNvSvD7V0OL3stsnfs9SVxZoTLrRcZKUqJWQu3kQ=;
 fh=n0QSagqzLQTyAFuCJYe5p5MYBfiiQrTx04SdEhPKR28=;
 b=YfNtNPdgY2AfTL7gqPpIWpEQvIPP23xmYD9qqyr3verhEvjgNhwZ5bPTADYp9EW1kO
 8bNns3UvrFxtTs2mWHffYnTwReum9MWSG6lQ9c12mLHrUjux3wDBP+P6WrKUF2umbtOo
 Sme6rsQdQ4DW3DrLw5joOcWRtRASXpynXMwEBR1Vot+921EpzNfnegXxeBoMCsosvW/K
 aE3qdJu2FJgobqpzmO8UPF4l/jqGU4PEy6vPvq3jvb4RLs4KYxiEJz45/MC2QMMIcZY/
 yG04CoX1F1iT4IMZO3mNiqLX1x+z4Po4OGF261R5CqS6AwndxpLpGph5iOEdHxSI6e/C
 SRNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=szeredi.hu; s=google; t=1788949834; x=1789554634; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jpRvNvSvD7V0OL3stsnfs9SVxZoTLrRcZKUqJWQu3kQ=;
 b=mEx4ynb6OCfaub9Fv4e292wq7T+lw6whmfDdYkJlQ8ertK/gTJZ2cnr8/tDzj/LIJF
 wmVFlk3zCk6rv58oDAuIAVNkszwitNP75EWXowDuESiQgfHAw6aS8/PjThwRTN5a3Pkj
 8HY0tNu8+4sz0gyTifmY4K9TMydAqlbstHPGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788949834; x=1789554634;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jpRvNvSvD7V0OL3stsnfs9SVxZoTLrRcZKUqJWQu3kQ=;
 b=VSCl4hkuPjRS2cPblOOeZdUlZE7k2fq7jBFJhPYVlMIkTkHEJ1VwXhD/yxbucl2AOI
 kgOlvoWW2wwE8fvHT3dqFVq+icy7fiY19W0jJcUUHpLnHalqZ+sPcjPzJGupguGjOwgA
 ny0ehTYKmGrgx+bp3r/2FXMHbQ+z3j9n9IOcOQxjHtrrHeDWnNQ7FlxrVJjg9aFgSXig
 CrNmx4hqlIw2hr8COHTFVz0lUAFDbyHrKRFnX7Q5aoy9EX1gkU+E7IdqgXiAwGsZJubk
 slpSG8G3QQSCrw6eo03ct2NondrcUAHzmWD6lv+NAur75U0322xnZ/ihlZwtrufehUHz
 iIOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd31SY6H+0i4rr7oNzwN4GQlxU/xMX/DrzNp4LNQDRZFR35Ju4FtfBe50/6/tLrGdfcecwe0L5PIs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++li6XxVI14AgSq3GCOHsiSd9SdIv7GV/pSYufPaZB+0wGuHDJmx
 K2OdGPKNNfRGrLWXslia7t8sp2JDuNc2jgrXGZYdvdNRhd7elCywxzjuZlYNd15ryhQ0s4u9sUt
 7h61v+yXg1RvggmERBxJvnKxn4N6+qv5c/ZgTApdFKw==
X-Gm-Gg: AYBFou2PL4N52nTSRrL2fV3ZuLDOKu/tdcJPWt+wK1rzB1gCmugHPfGKxxjtn9Yj3PW
 7e8oWrk0TMV1Sj+McBswW+TOzto2+0FSisiXflninParpbuo0zcVc54E9xMEyCKWNjMJN2sD+/0
 RRj6fkYaAAq56VRwGrgrq5cxSLgrusKHNxqFn33lrqqCHcYotOaZCJHmIHRBLawvsXaNFXc2tZH
 lN+WWIlSGVdPaE3Ibh8Y5ZEOL5nBX9d3Bq/gPONAMdq/EZc8K3lSe5cbdI/AjiSj2RUJTN22YFN
 8V2w/eUBVBfYkPUCLwmUlyNkkwgsF+wSPN0wU6H5BRjLLejGR3x3GGZKxctZoImxQ6sGIAMHg1t
 ay5viHe/Zkuv/
X-Received: by 2002:a05:622a:1489:b0:52f:bc89:4933 with SMTP id
 d75a77b69052e-5305483d9ecmr389465191cf.20.1788949831561; Wed, 09 Sep 2026
 03:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
In-Reply-To: <178894801687.37859.4186888279082797860@jlahtine-mobl>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Sep 2026 12:30:20 +0200
X-Gm-Features: AcwNN1Uh9cE_469mX3O2aBqf9qMn4Rt3GJCs03Vdits2s9ouaewG7zKYcPHnkzU
Message-ID: <CAJfpegsFJkghPimBYAnJ_KyZt43T66cAATAvpENZeX5Lj73zSQ@mail.gmail.com>
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, intel-xe@lists.freedesktop.org, 
 fuse-devel@lists.linux.dev, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, 
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

On Wed, 9 Sept 2026 at 12:00, Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:

> Based on reading of [1] and [2], it seems pretty much expected FUSE
> drivers can trivially deadlock and ultimately in worst case the situation
> can only be solved by manually aborting those connections by sysadmin.

Exactly.

The real question is, how far the effects of this deadlock can spread.
If it remains within control of the user that mounted the fuse
filesystem, than that's okay.  If it affects processes not controlled
by the user, that's bad.

So it's not about being able to stall a process that accesses the
filesystem, that's trivially doable using fuse even without any page
faults.

I'ts about being able to stall an unrelated process.

Thanks,
Miklos
