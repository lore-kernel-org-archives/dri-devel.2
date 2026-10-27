Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC7606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyUIQ9vC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD0310F5BE;
	Tue, 27 Oct 2026 14:24:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C7310F5BE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:24:39 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso33054325e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111078; x=1793715878; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IkPxJXmtiqMser+kPyM3Frb14w4G6irRRFb+HTaDxFc=;
 b=QyUIQ9vCoMe3XSWMHcVb43qG8N+xyQKy8LEBiJJcJNSKOweYB9rHcCvD4uqTYhCI4V
 zYGueAexieeZjQNxYOJgO8InvIF/wBw/7P0u/kvcaq6i9pq1mU0YpBd23R1/d4WZD/+I
 XXylWQVcOhIXtiH5KxZFeDSBM6EjN+GMihHgUIVfVClQhJDQ9wOeoC1iBMagcGuEokWw
 grkJtxPYcqwA5p73gliRcPdTx988918q7QFV8k9EmfqbuFPMhQEFMScDRVUx7nPeXMAP
 pavfSsQhTySefFehVIPLG9c5ombWeg0LygFG77k/Mu0yO5JWJqKDisHqffWobKY8Wl/e
 LDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111078; x=1793715878;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IkPxJXmtiqMser+kPyM3Frb14w4G6irRRFb+HTaDxFc=;
 b=fToBaY2XiJpl0MMXr3TtlfwTPc9Upm6dmoe/p3v7fZDUoIBYnRjVLYxCCamIL/8Xj+
 wwj0Vgma9+8CMy6mVaN9X5M0asxWLKiYICW76urV0Ow039fdS1r47fqTW9SXKNKhQOJY
 wt2fpDqlW8i9X/WUdfk/Jt4p2Ncw+AcqzN5YTigXk2zii6i00LlZEanSlNChiRazMnQ4
 lv1rAbtg0vRH7eWfSNZE6ESRLRAhcTXzQzwSivS0yWF77XvE54SVTHvXFFH9zd/dgbng
 PhzQ7mqtuPFSkHYqYr1Jm6RuG97U3CG2zsKb3IPrEtvFSNDSkEM1tXPN1Or3B301xXWw
 0lTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJv1+2qhQ/U6Og3HHv9HJupgIPTWbVeKfFo4Jbw/wyYgPyA5vItIwaFuw1jKvoW2L61xENKSFmaqo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLMykOLWJkm/4+9u+ITquSd0MXzPLtm7Jy2hw1yPwkJo77kJ+dD
 zVaNAc1JZZmWLZRA4oMhYF3tvRawLU19J+KuMTcCDX5Ed1827RlTs2aA
X-Gm-Gg: AYBFou0SrEKYT1c8cuuJ6LeyJI5WJX+LS5+JiWnrpZVlFV50fiYB4QmQpeEouz/7l5E
 SRvF4yqBj+3xAqJ8Ce2tk+otmtGubCAOh5oSXy6AJVPtwcQJ42d0qZMwNMGR1ei1hVj17Mq8d+l
 3rUvo0kkEICWGdHGaGxq/iMow2zSTFYyH+JZEXU91iJ1XR2dwWjDibLRgeqEV/+j7jb5IFFF0xY
 MWXif/mh9PB0EFPCF99krecbSL5ITnRQSJfkaNTjSdrcHqufa+svXsUH2BzDVdOGca34T4tERlK
 rWxyr7xD0Al7mxRLT9Eejo43GxYXlgsqZs1JSRzPBy5rD84d4v/+eWxKCzkWaCGr3Ea3pU0BxeH
 Sj3HZkOdFI8I2Wms2xOZM0FNDrSmFWy0bcgVKy1+JOd77bvy5RpsRxUBkIN4RJFDiOAj09VwFbc
 w5JUvHlL2c9CsjRTC4OjQAfUp5BCiQd/jHAIzCkpI5ETbc0dwPYHD+6fGTX1FM4+w6Yr0VZDEwP
 q9CAhRCx8nVY865p0RN5rYvnyRFkrx+2EFOKjJ2VpTSARJtHqyT2LDGwJFRiffrg5AA1Z/wC+Yo
 3/ozaID4/Oo03VkDA+Mgg08pszHazmKQFOhXyJ0=
X-Received: by 2002:a05:600c:37cc:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a35acb990emr193736245e9.33.1793111077331; 
 Tue, 27 Oct 2026 07:24:37 -0700 (PDT)
Received: from [192.168.1.253] (4E5C72DA.dsl.pool.telekom.hu. [78.92.114.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e9aasm279010885e9.5.2026.10.27.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:24:36 -0700 (PDT)
Message-ID: <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matheus
 Tagliari <mptagliari@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 15:24:35 +0100
In-Reply-To: <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
 <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

On Tue, 2026-10-27 at 11:21 +0100, Christian K=C3=B6nig wrote:
> On 10/27/26 01:15, Matheus Tagliari wrote:
> > Hi Timur, Christian,
> >=20
> > Thanks for the input, Timur.
> >=20
> > To be clear, I'm not opposed to a backport. Fixing VCE1 for people
> > stuck
> > on the radeon driver with an LTS kernel is exactly the case that
> > made me
> > look into this in the first place. But my goal is only to help, and
> > as I
> > said before, I do not want to push a change you don't want.
> >=20
> > Christian, if you'd rather keep this out of stable, I'll drop the
> > "Cc: stable" tag in v3 and leave the decision to you. If there is a
> > specific concern behind it (risk of regressions on other SI/Trinity
> > parts, say), I'd be glad to hear it. I can also try to address it,
> > for
> > example with more testing, so that a backport can be reconsidered
> > later.
>=20
> I was part of the Trinity bringup back (I still have the engineering
> sample here :) and I filled a full swear jar bringing VCE up on that
> HW.
>=20
> Interrupts were definitely not working correctly back then.
>=20
> I have no idea when they were fixed but I want to avoid that people
> start streaming that this change made their system not boot any more
> and we are forced to revert a patch on stable kernels everywhere.

@Christian
Are you saying that you are worried about the backport because it may
regress Trinity?

@Matheus
Would it be possible to only use the interrupt on SI and not on Trinity
so as to alleviate Christian's worry?

Thanks,
Timur
