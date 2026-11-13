Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C39606A8BF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=M6rA8KcR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E9810E0B1;
	Fri, 13 Nov 2026 12:24:37 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CCC10E0B1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:24:31 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-170135e43c7so486981c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794572671; cv=none;
 d=google.com; s=arc-20260327;
 b=jH7PV9E7QnaV2eRuR59C2X9OKIOACZafWyX1LR6ltYHtO2GeRkiYhbZ3yVk/qtexr7
 +dA5st5TyWwiShJQcHExnO4RDdiU3JXDAsAjp+A/CsHgTgl5Ulk+uoDEzPQ+zDnEniNg
 +SrUiYq6DLZbZJWPyk55B8dZuNEBgNGCtpMdGLYG7TJSF8vWanIz979Iw5Pdrt8DDZWD
 ceXq/iQpKa1BP76KoQAeivKKg6S+RdUzuoaBsESC9mLBv3EBNsg6JsWcmY/IAQCKLJE1
 ushI4uNf5QtGE1K+abVMxKl3IvgM5o1N8JLaRa+R4ZYqSjazRENJQL6m6vLlMKxWSj0s
 yUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dDT+wka3iDhLnyTTI61/KdTvaTRDfkuzBYOliEPIK7Y=;
 fh=pGlZxQTGZSSNyL45UEOH0H6arq6fRMd/Q30NXfJcj8g=;
 b=hec3SmRvDwMoYW0b1KxArt8k1db49s9TZ3QpEIkhnVa3fh1L2I7TJLpZJtaz8eK4LR
 sXcohpI4ShbaWtcrpIzmrFXsQsCkGgbaZvY6pBeKTYPM0HnYvbrPXyB+UmXGOFjkxg9B
 6ZGuECtz9sb+2+WLbVL5wDNWNvc65/WqgQOjASAIQmo/CaPlkMNIud+TxqEragoQXauu
 3n5Yxi7xsZDapkdiDFj0dLp/U8uKq164XMXFmyn179/P5H0RF9CImbvTsnJ5vmZJisII
 I8l1Qi+LakkcC0IjwIOqr3kXPjp9k7c23XHVTpGcth+OfadWMt2wKn0tVRt004Ly2Q6O
 WOKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1794572671; x=1795177471;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dDT+wka3iDhLnyTTI61/KdTvaTRDfkuzBYOliEPIK7Y=;
 b=M6rA8KcRDqgni8Q7n7j6OYIqjIdrdsc2z78ZC5BbFvmHvXEZPVK1Gub+vPHzfDDUH3
 zMybBAqRJQt2o3P+DZ8ayzEKsMOOMwJhGNWK05NflQYuInCszmA1yDzGZOybDo0PzHnZ
 YXOK7IEuks9evlPE/K9CzsGc9aelgUiiL4dfFmMRSJpv3GLh7N35ZeNl09XUlMFdaNV6
 p0snENpPHJ5RklKixHNXZtPCJO9S/Pm1V3KuzWXcXxgv048nxgVkJAQo7I/8gDSNZMOM
 dxBHzigOq0dMw1uZB2PDLVcMSPNVpnU2/XWIt1qquLoh2R7oSMDLqS2qaSMAe2kB4xqu
 dETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794572671; x=1795177471;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dDT+wka3iDhLnyTTI61/KdTvaTRDfkuzBYOliEPIK7Y=;
 b=ZYTMb6ckdSGf0VZgKaCSlF2dzVAtadSgTpqTHbblh69yZUwZW/NtTFI7alaxB6tROF
 FX7HfUgY4WzXfGoCnRGyuiUwvCLHEjPkKACLTSRQftiOfwsYm9ntEZ+N2aTYmHowSIkW
 ZCY39xw2mmKoD+fls9tzx6er9x1vbboAFZ0IlneQa3OGQXabb/D3R9yHbsKLNcrYIamL
 Ucpsq7tb4tz14fcNt4S63F6THdR/+Huxum2smhrKQUE0yw04t97q4RVTTbjd8t3gyCJa
 ZwKPv+dBLhL5xELL4gqbvi+logZHFMsLgoKIsQLwrMg+UTvSwAbzBSNBrzz7c30QZ6R6
 H5lA==
X-Forwarded-Encrypted: i=1;
 AL+hErHWf2SFfBdVe1VV5OsrZMFv+DcvanzetzWGbo+LBFvQwrsn09mfJjCqRgEzL/mtoGDtDRGFzovCA98=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HcYYmjyxkmeD91T9r5ZjJlW61ahMV66rvobro9jHvzQMmySeM
 AmxfboESCAnp3WCrz63o8aHj8+7o6+jLKL9zg8f7rCsOys0HBf4NJGHkDLCyU/mbbp0wm32nf6r
 x8GmteSt70IQVcoSn05H3El4W/Koa8RDog+jYXCtFzw==
X-Gm-Gg: AYBFou3DgbaZVduJbykWb6KL1rrtDjtPSl2p69OgE4rYb/7UV7ParqZvAu+QKVCG033
 vl7cCD4v0yl5BVcySM24UQ6c8i0A/OVXKIek6BWU8weh4lHP5bPlUefySDo1XrYJK8eabBSyazE
 i32U77sOLdDrcwUQKIee+oqGKoTG4XJUtA+6Z+dGxVCXQovuxU5YyR8K2vGut5ULdeKddN8aROs
 uHo9JrXw3I7b8Yg/4rFmnQLmpmJxa69ADHtkh24WiUAkvgNRyhrh5VJilxNzK98qo56IfNy6TTs
 H8acGKkVVHNntTWkM+ftkUAtWqWvvohOYopf+UCKRMIHSL0b2xZTl5uCne0wkCdtgFY3IOnZc0m
 1mRPj9UW+kGn2JsKxnAWzVksRh2Am8MZTuB4P9TXB9ucHktOmT6eJQ2+zVptT6Z0Stx/9aQTZH5
 wTJCJP+YyCDYWX96u+
X-Received: by 2002:a05:7022:f4c:b0:1b2:6cba:7f48 with SMTP id
 a92af1059eb24-1b50315622fmr2098905c88.31.1794572671002; Fri, 13 Nov 2026
 04:24:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
 <20261109120902.125242-3-cunyuan.liu@cixtech.com> <avLsAlL048MtIX4x@e142607>
 <avRm82TLBe6I6LAD@cix>
In-Reply-To: <avRm82TLBe6I6LAD@cix>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 13 Nov 2026 12:24:18 +0000
X-Gm-Features: AclHuK-6TzVh3nCVDRnwGMEM8YGOPOqHwZQu1e6cxT9cH1x835RSR9V7MLMVi7Y
Message-ID: <CAPj87rOi0+T7E7Kge4z-8L9FuCSTt6dCqT+9+YtF3wDkd4vRVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panthor: Add initial support for CIX Sky1
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, boris.brezillon@collabora.com, 
 steven.price@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, gary.yang@cixtech.com, fugang.duan@cixtech.com, 
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com, 
 robin.wang@cixtech.com
Content-Type: text/plain; charset="UTF-8"
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cunyuan,

On Wed, 11 Nov 2026 at 13:16, Cunyuan Liu <cunyuan.liu@cixtech.com> wrote:
> On 2026-11-10 10:03:46 +0000, Liviu Dudau wrote:
> > > +static const struct panthor_sysc_config sysc_config_cix_sky1 = {
> > > +     /* Sky1 needs these SYSC_ALLOC policies for correct display of GPU output. */
> > > +     .alloc = {
> > > +             0x00230000, 0x00000023, 0x00000000, 0x00000000,
> > > +             0x00523222, 0x00523200, 0x00000022, 0x00000032,
> > > +     },
> > > +};
> >
> > These should not be in the driver but in the device tree bindings. If you extract
> > the system cache code into a separate patch we can have a proper discussion there.
>
> I will move the eight SYSC_ALLOC values into a DT property, such as
> arm,sysc-alloc, and submit the system-cache support as a separate patch.

Whilst doing this, please break the properties out. At the moment,
it's written as 32-bit groups of 4 source+RW pairs. I would much
prefer to have groups of [<sourceR, sourceW>, <sourceR, sourceW>, ...]
than just the raw register values to be dumped into SYSC_ALLOC*.

FWIW, I agree with everything else Liviu said. I don't have a strong
opinion on skipping out devfreq if OPPs are not present vs. exposing a
single fixed OPP from the clock provider, but the former does seem
better for me.

Cheers,
Daniel
