Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F60C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D8810E050;
	Thu,  9 Jul 2026 14:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TBzODXke";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E1710E050
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:19:17 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15d47266baso235197966b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783606755; x=1784211555; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mbTByd7x2B0SVAGizj79lBbxC5X4KQlpFVsjQoIekHk=;
 b=TBzODXkevrzdedvgzNvZrG3SOHqmBYdeaPqhllkxv293fE3jwERsXVD7uh/QLfKWeG
 Ju+hioTwl7VUN/rKoaHovV06btPWaFHtujt974P8wcf1AYw1ZVI+XSOXTtfK6j5ATSog
 oHu7cI8wLezC5inwls0VsOkGzmP+FE9aR30qPXWmJ28WiFoDCPRKnPgHkJQ8XkSP8ICV
 U81KeXdzkMl5BAZMcUQeOQb2I9NVvTxvNvHUXS0aNHhnN0mFYj3RLx8zakhEZsq/IjVF
 LDJ8EqCB1a9i4T8BoQ3StIb7QhUaI6546sT9XILH0PexP+aCcgp8eVRVuuUkt9NqurJg
 DOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783606755; x=1784211555;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mbTByd7x2B0SVAGizj79lBbxC5X4KQlpFVsjQoIekHk=;
 b=BDMc81FYQD/FTbl0HidBjM89vYvUuRQJPi3d7M3dZ/TF6U6mPq9s+Av6VMVv5fanwJ
 qrb2da5j9K9pBg/E6EPhikiEdKNCCCBGVKYV9kEX4hCUW+9Jt0qMuufEoaWaM36hbC8q
 S04l82ITQ1Uuj9ivsOtJ+RTsaIqMAHGbf2fFaChKmskM4DBQ1oso4LwLSQibqPKl28Hy
 cCtck/myvFVDgwr0d6Ln/8/r6Iou/cpeDLWm+ec1/cMs/ZS+a098pe5bW5Pe9567I/gL
 1wD+nTUYLXSMwHV28CNZLFX4s34z0J3NUUsotMD1Vmp2PE/kwiEo3hW3pdxrigOjjqiq
 xIwA==
X-Gm-Message-State: AOJu0Yx7vnZj4YoeiJk2af1km8/IhcZ/KaKHJl91L1Hz4g4UtVobfiPz
 7EiYge8tWaaBcl2mX5OtUnU/8ae/hhVgkyXB6rCctZHdP6+QZ+dO1fPAdwdC9RPUjas=
X-Gm-Gg: AfdE7cnUhRLhuSekgs8SN+U/6cdyMeFU7K5Ka12jmWu4aavc2DQi3GQ7r30oz6XsERN
 oqWX25GKvfyw/T/GZ8PtNUnnJiyQGypZvE6EIa6iNk+6+xA0JtJe2eHjnJ7C332o02Pb19aeZTA
 SFSQELWCSryitolW/N8Nrn9mcWq3LT0glBn91lZ4TXurBdCKOOtfVU7wucYXFWC6FgY9cf4KW4P
 LZdcRp17cgqFxPXAG7/W1ikcZdvX54lV60F7UnmS4IW36WhPpm9SKrISUDRSZczwexgYMD0tT2e
 AQ0blDnI7PHAz8N39BEShm9mW6hDy5tA4NyXcLkouUkovUiZkiycaC22++TrzrHCQX69Gw2BQX0
 5tgLku9JxWQHqt8A3o8YvV/OVEBgAk6b6tlwypc3TMc+4odbXxML8IMa7RxiuMr6R4WydhY9NC/
 RRYtqFxnHvE+KxezdSLBKU
X-Received: by 2002:a17:907:e146:b0:c15:b55b:7826 with SMTP id
 a640c23a62f3a-c15ce0c03f0mr176642766b.39.1783606755075; 
 Thu, 09 Jul 2026 07:19:15 -0700 (PDT)
Received: from [10.1.1.102] ([212.129.81.133])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ae0bb618sm497210466b.20.2026.07.09.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:19:14 -0700 (PDT)
Message-ID: <899942cc84af7a82a35b4ca34b486c40327fd543.camel@linaro.org>
Subject: Re: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: phasta@kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Thu, 09 Jul 2026 15:19:30 +0100
In-Reply-To: <1ccfc0b5d1696a8dec4756b675294e7fb41ab5ff.camel@mailbox.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
 <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
 <1ccfc0b5d1696a8dec4756b675294e7fb41ab5ff.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
MIME-Version: 1.0
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

Hi Philipp,

On Thu, 2026-07-09 at 14:32 +0200, Philipp Stanner wrote:
> +Cc Danilo (who is currently concerned with drm_device life times)
>=20
> On Wed, 2026-07-08 at 16:22 +0100, Andr=C3=A9 Draszik wrote:
> >=20
>=20
> [=E2=80=A6]
>=20
> > Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-=
c03e77b36f34@linaro.org?part=3D1
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> I am tempted to think that this also needs a Fixes and needs to be
> backported into stable kernels, doesn't it? Especially if the BUG_ON
> disappears in stable kernels.

Good point, thanks. I forgot to add this in and will try to find a reasonab=
le
commit to relate to.

>=20
> > ---
> > =C2=A0drivers/gpu/drm/drm_crtc.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> > index 63ead8ba6756..d55f1377ec36 100644
> > --- a/drivers/gpu/drm/drm_crtc.c
> > +++ b/drivers/gpu/drm/drm_crtc.c
> > @@ -501,6 +501,12 @@ void drm_crtc_cleanup(struct drm_crtc *crtc)
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D crtc->dev;
> > =C2=A0
> > +	/* Ensure our dma_fence_ops remain valid for an RCU grace period afte=
r
> > +	 * the fence is signaled. This is necessary because our dma_fence_ops
> > +	 * dereference crtc->dev.
> > +	 */
> > +	synchronize_rcu();
>=20
> nit:
> I guess this is the only place where one can reasonably put the
> synchronize_rcu(). But I would hint at the RCU delay in the function's
> docu.

Unfortunately, this still looks like an incomplete fix -
https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f=
34@linaro.org?part=3D1

My next version will simply copy the relevant strings into a custom

struct drm_crtc_fence {
	struct dma_fence base;
	char driver_name[32];
	char timeline_name[32];
};

or similar as part of drm_crtc_create_fence() and just use those as part
of the dma_fence_ops. That approach should avoid all race conditions and
corner cases with RCU.

I'll also make sure to update relevant documentation.


Cheers,
Andre'
