Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09539606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsGCZShs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6733610F5F4;
	Tue, 27 Oct 2026 14:39:49 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA3E10F5F1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:39:42 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-7cc074a653cso197051137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111982; cv=none;
 d=google.com; s=arc-20260327;
 b=O8PXtXq+p6CDrG29L/25EsZYHDnkKUDSYWn8Tdk1ye9k0B51cUynyZ+WHTwi6PHZj8
 fL5K0bJh11TTYXu5LVoUOUIQ/apYJpO7/9SZN4/PpyKCs5wpG2LyM5CMuBa7ZUoW6jYe
 LQ484NNWGq2yyRGzi3EJBeCrzAfUa5Q9P73oxMg1A3yhuJKh2uHzf1UHGJPWwdOE06uH
 CQKGU463cT2jlD+gKB8rqrBjcPhN8BTN16qE1OK0YYWudJXqBne3MN4RM0sJFA5nSXLz
 Pn0Hn6J6gyjNrdOROujBV8IdF8IaBPJ794I4pMaJLNPrPmXLGLNzU6GlnEyDhthishCk
 RdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 fh=ANmB8mpNtiZGTZfmiTjiovsETFY/EbDvN4T/Gd9jLS4=;
 b=eEq2xl2V4IBVsoYFJHRMdg+VquGZfPXlKyWENN1V3rh/JzqVz8TQaap7LXtbP+yi5P
 jkDB9Lk/I/89u2IYWNt8t76qfKZ8ZeqfNCPyrF9Ohsrv8kkovGclxEnjUo/02w9yxMwe
 ejkFuQ+2CrnUx3Nn4x2n9Lnmwbn5lTD4+BOIomUEoeyiQk7KRfOlvGbyX3BiiqlDmsRT
 yqLqxVJtV7njpe6hR/rgC38WgiuWY4l/N/iFsjWFGw9dIQ6nyvr0vkofQi7LnVgu8C29
 nFwJdGXHaugh65KG6VdNuUbnL3RtCznFPG+19wNS6CmuPdMWRREwl4r6liM66EOxamir
 BRaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111982; x=1793716782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 b=AsGCZShsSWfv555+Uqazg5tPKeFsPI/s/hGFS469F6fbE1ROQRPrJhYArmcVpYxAcH
 2VnU96v6ZBlzoMrF2RSOPbomCED2g9Ya+Hz1TapqWtkJBa1x/ar3wTEa10S4RLuAeJgm
 UgCT1tvN2tjeaPJJSiJXkheWOckm2N9oIZdmEcmzSgdbdafNvePkIYDICbseCDhhI1O1
 slz2ekP/wYoHuNg4kM0qHifC2NZTWm/jGbylYW/7uhom+I8UVBnMNI1H5vIZrcnBLnJs
 8uh57CxxvoxlJ8Z6B+apRRL+7xdjxZqlCBTfXBU7i1pzp42H2IjPYwzbghMYzZdj2SIU
 zPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111982; x=1793716782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 b=mRQ6RnvmlQH8bx6p9ko0KU1a+KWoWlvI88LcD/LT5TSrQbvx//RaAyt/BZW+pOxIDu
 PDiYtWB3R+pxWvf9GWh5EW8XHkRDAohbsgwYZhdKjJS3aipXbgwYI+mt2VPn2wCqLlQd
 /n/CfcowikFNLe467ITSO0BjwuW3iKhRaotYX8a0Sk5E+c8pAI9HugVpRlJXa/oU9qqj
 bhe/xNEyr9FH11rx/z9BHQCNDOKa5K7prvtvOockLQpWGM4dEx9Vn5MS+efaBOX4ySum
 T0lARpkr0AKsEwp2+pN8xHQwjrZlyv+RI1ANBKTOIYugbSo31zlRfirgU5GTjjdMz8EM
 7bWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIJTSmaG8bWpul/0zR1/OkjC9GabgPgAIqSF9y++rEEqFp8bl4vrdrfqidSQybOqy+d4v8xv12hIw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIerR7q+VhQL37W0VVNTS3svYvPNmQkKCfmRTiW4ScszsplpE2q
 g0g2mwI1JBLTc8mT5bC8GJTKGPi3o5QrCQdmtd0S/iHGV2howdX5t+JSct1w1r+OjnLl5cWkKOr
 n8E5WkaLZPfe+5C1+lMBKQHQ89dDZt2A=
X-Gm-Gg: AYBFou0gdnBnVY64uBxsI2SK91l08rQB4/ZzZxhQdYSpj/9gl6yktKLKpX36ScIqXXi
 rrRJ82S97jajMcPr+3Za5/CqgtQmVKX17fjm68va2q2CWCgT96rFCFfPQgc34H3WRFQTyWMv7Jo
 oK+A7wfjB3xanmIrO4FA1WfkqQMlVH5BgYmAodzYF6KpBY08Ml9jmHngcGSFP+yKpEMlN7OeT7W
 2uAbIx64CovaV4fBHivG2l7sxlMULhwJCTK7hWnCFJtOQxco/CYJJl05J8bXeD0RBQWQpPOIwht
 1jCUvz6XAh9V6JKxDf5xHtJ6nmL22TkAfqXZ843V03I4i4KPKYhdnbPcGvHlRwek8rNPsKXpt2C
 O9WNCp+A2rhvzsqCbC9eIeihqHWk8ARHXdmKglaYGdvQZULUod/6+kbcDDEDVRvxB9HYr493oZ+
 Y9fUDCs7t99FaU6dc2nky1+OI=
X-Received: by 2002:a05:6102:868b:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7ce5ca0ced9mr3651871137.1.1793111981697; Tue, 27 Oct 2026
 07:39:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
 <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
 <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
In-Reply-To: <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 10:39:28 -0400
X-Gm-Features: AclHuK9s3CHTU3bFA1ccuwGnhC7tFGFBKddQ8ABnYXLC2ngK0GiJr07BAJIqJaM
Message-ID: <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 27, 2026 at 10:31=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Tue, 2026-10-27 at 11:21 +0100, Christian K=C3=B6nig wrote:
> > On 10/27/26 01:15, Matheus Tagliari wrote:
> > > Hi Timur, Christian,
> > >
> > > Thanks for the input, Timur.
> > >
> > > To be clear, I'm not opposed to a backport. Fixing VCE1 for people
> > > stuck
> > > on the radeon driver with an LTS kernel is exactly the case that
> > > made me
> > > look into this in the first place. But my goal is only to help, and
> > > as I
> > > said before, I do not want to push a change you don't want.
> > >
> > > Christian, if you'd rather keep this out of stable, I'll drop the
> > > "Cc: stable" tag in v3 and leave the decision to you. If there is a
> > > specific concern behind it (risk of regressions on other SI/Trinity
> > > parts, say), I'd be glad to hear it. I can also try to address it,
> > > for
> > > example with more testing, so that a backport can be reconsidered
> > > later.
> >
> > I was part of the Trinity bringup back (I still have the engineering
> > sample here :) and I filled a full swear jar bringing VCE up on that
> > HW.
> >
> > Interrupts were definitely not working correctly back then.
> >
> > I have no idea when they were fixed but I want to avoid that people
> > start streaming that this change made their system not boot any more
> > and we are forced to revert a patch on stable kernels everywhere.
>
> @Christian
> Are you saying that you are worried about the backport because it may
> regress Trinity?
>
> @Matheus
> Would it be possible to only use the interrupt on SI and not on Trinity
> so as to alleviate Christian's worry?

I've committed the patches already.  I don't think the stable really
matters that much.  If there is a problem, we can revert.

Alex
