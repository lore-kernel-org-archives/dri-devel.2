Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931B606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=by2HmfOs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB4110E0D7;
	Wed, 28 Oct 2026 20:55:58 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B8210E0D7
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:55:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a54bba0442so3645e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793220950; cv=none;
 d=google.com; s=arc-20260327;
 b=na764kaf66xYJXPRR0z/WrfI7L2f12hmBLKFeYgOmu4XyXWxyiXUBvi0Nk/OncoMp9
 4C4UbGu72iN+cGVJJSvlSkOjxMEVwGQGxIVhCspH1ZYA0Dgh0/PaZ1EYTeq+BxrHJcgJ
 IUPwAlZMuITEKoPrRkOBvIDb7vAdkAe+h5y9S0FgDZh+SdWG/N+kpoVkded8sT5RmR3B
 wVb1i6VgJA7Rg4iqeGCWZyHk5A5s3Q1lxUNI/ZqtT8lPxb2IoMLEdHdjxhC360wvGou1
 GWjMpVFsHee8BsHzrdfv7qoIBdvo+Y5wBUR4WkjqfNuTpC61GTC0Eq6nBLJ3X4MlZiqj
 UYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FqCotvToqRit0Ta4Oz35Sc8D8hyAm/wLhkR4LX3nbHQ=;
 fh=LvuQJJ0rpuoEOD0FRKqYwdzlHljI2uSlt5PhOnZam6k=;
 b=K3s2lqB/ypP4z4gEog4gCdF5lR+edEcpq9ModF3fkoe9TQBSmm3SSkgkvqImMMeahM
 M4mH8OAAu/QYq9G9daVxiNtpYUYJKezLMr4WDAHL6/E0VnBLHqOr8fxS/6z2r9jgdakV
 JAX2DI2/TKT/GaiRdDH5Z6tR1ZeMXISd1E+be2uaGUxeZcFHEzV4bFCpM67ytczLVPG7
 i6vS2yPkJqtja+vT28ZxRMAHr35+kjm9r+xVld5Vx2cR3HRn1zqKVh+/vX5HKDkGSyYE
 bwzqZhSWF26VuKkBlN9WY9SdQbkXG2wxgIIqzMpxrDSmGrJkEq/FUCBCTyUAdsIJbtxX
 of8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793220950; x=1793825750;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FqCotvToqRit0Ta4Oz35Sc8D8hyAm/wLhkR4LX3nbHQ=;
 b=by2HmfOsYAVOKH2uAXeJW76vwJ59jG6yy+FD2q2v/IWF9aTQP9xM93JHWjqwc4Fl3m
 1vg0k4Z2vzo572ACLpZVbmBHi7aCjljHsS4QuG/gKIxUaxJXnXuHCZIeIfshXiEBOSS9
 PAwXKeRbhlb1IreBeipreSzN7wImNEg90QqIMOIH0mDICXlIWB9lHkIGxQcJG7PU49uz
 7M+AzeuD7NmYMQLQPg6Xn1LiGiievKYUL4duG2YVtuPv6butyVFfWbaEd+6NNo+/J4Iv
 RvwBmWEAhVO1HEn88z0VMK7+f/p/w2RA1ymWZgsWd+3hh6e9G6xB8hZ0+5SI6rSHXJ8A
 5X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220950; x=1793825750;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FqCotvToqRit0Ta4Oz35Sc8D8hyAm/wLhkR4LX3nbHQ=;
 b=i2C/JP/39MFjOlsAWzArICgnBjiIQlWoifZRQ2Hi8MT86C0cLmCXGXgf4EIz9lgICE
 Exqi5vj2mBawk6gHP3+c3KORiRGiqSpHORyCiZ+ro/U3p14/95yCxoiPD+W+FPtHFAud
 Ovq5HBX4GvDWXKifcHa9sMqz30oxlM+l2q2DWf+dxD23COzcqsgI5uIVpFFLFMYrLDd8
 r7ilX8Iq4i96mo/xAk+UxO8qoHjmDU4OzKKcsOuSW2T37dsLU8uf05rhy53GpU8H/zNm
 JcE0lVU1Tb/MFadFtGjGXpGMA/m/LwphpIOdWZVJWHl3astzK77L6j8UrNCMSIJ6aIvC
 i+Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq/g3DPmEfk20vqrAZUkBEZICuL7rP/1o1zf3lb8c7u5hhXyUc6uT37zCIb9usJRChzNAdzI/zWnM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJgyV381MO0pl/nuP6QjJXetwB2d3MSJzJsu78swtVH/rvdrUu
 0JWUP3mjn3wU/M4QMaF8h6fE75apYzynzCFaEBybyz3GdBgATaEc6GmD8gtBPHVE6FBITJTrbyO
 V6uFDFz1GXlHZxbYIgdVkPWjZyLc86bylfaUR9d5Yk4on3xqe5jhlll5MiXo=
X-Gm-Gg: AYBFou1QIomCW6brZQ48BWIWmhZ9/NjDElTWNgbdcd8VvmA/AR42SkPElkyMIvYD5z+
 PT4NGb5L//rUcDxYIGeSZcNHJZ8kkpEQH8w+nsvnLG8hMzasuZ7ynFMLRx9RqyTo+PF++3YYp7K
 EG50UJfakkGax4NeaZ+pEhLVKHaw22ZilAmnSKlTmH4fmMwndj+ADmgGSyswhjKTvGUuc3wSuT8
 jzK4xoYFdAFNcXTdfY41laduUOnpmefLPbzhZIIM6u3LExmXQbf8n/3TOpIBy2YrpoLuOXze1Yu
 MVJpKcYDUAW3vG08N09tk7zSQuU5XYHcnAh7ae4/FPQwwkcaMzNoWC20jscYSZh/XtJXDDTF8f8
 YI9AuYit4ool8ALleMrsnM+pFMTQhnQlrW0gpCbBZC+GEWz7UFaMkRNP71KRqjdjSYRVF4iguoQ
 DQBR7TQIQ+VFKng47mjUKkgy4=
X-Received: by 2002:a05:600c:3649:b0:4a1:d2f2:9fbd with SMTP id
 5b1f17b1804b1-4aab73beddcmr67845e9.0.1793220950027; Wed, 28 Oct 2026 13:55:50
 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260928195850.1982569-1-dave@stgolabs.net>
 <20261007120745.bvhqqa6cowqnt3jc@offworld>
 <52a82bea-3105-4bb5-a6e0-b1a0e3b808b3@amd.com>
 <20261028145924.5gcjfjbjd2ejgozt@offworld>
In-Reply-To: <20261028145924.5gcjfjbjd2ejgozt@offworld>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Oct 2026 13:55:37 -0700
X-Gm-Features: AclHuK-h0Y4xVklKo_Bdi3jnKsdQKwdLAyU1DW6GXSyu63AoyxnHO43jCYQYOF4
Message-ID: <CABdmKX28BVf3EWdpDBBefJg_9UFYOAwOK63n1vcpQrf2LZHKsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dma-buf: system_heap: 2MB chunks on x86
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: =?UTF-8?B?Q2hyaXN0aWFuIEvDr8K/wr1uaWc=?= <christian.koenig@amd.com>, 
 sumit.semwal@linaro.org, phasta@kernel.org, benjamin.gaignard@collabora.com, 
 jstultz@google.com, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Barry Song <baohua@kernel.org>
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 7:59=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Wed, 28 Oct 2026, Christian K=C3=AF=C2=BF=C2=BDnig wrote:
>
> >I've just pushed patch #1 to drm-misc-fixes.
>
> Thanks.
>
> >
> >I'm still wondering if #2 is actually optimal. From what I've heard only=
 2MiB should be used and especially 64k doesn't make sense any more on mode=
rn HW.
>
> I have no problem removing the 64k for x86 in v3.

SGTM. I think 64k is still useful for arm64 (SysMMU, GPU mappings,
generally smaller scatterlists, and for
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D04c7adb5871ad04c9e3fd645570e21c93f1b2f54)
