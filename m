Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=Yeic/bHI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB0510F84F;
	Tue, 24 Nov 2026 18:40:18 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B75410F84F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:40:12 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so2535508b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795545612; cv=none;
 d=google.com; s=arc-20260327;
 b=Gp3maNw9H7xxy8T9M/Ot+pq+qGns+rhRhNrJyjIPKKJJZiicaSeU9rbbL1YWq2U5tD
 Xur0LiLAkxNWa1swCSZJeHV1DDtGzX4ncm0VyCsllaPokKHaFr/aL97S7j5HS9EDz9gT
 Z+hYijjEvOm0iFklFg4YPXXpjbW8I0qftyzkkRWShl0s7Q9NnZbn1+O3HUz4ELdUJXPm
 anS+mj81N6S1ekGF4JYD1b+czWtbTch5Fb33saZVIbmBpQbKC+tBWeoBkSdh3S5o8sO8
 NDjbwALhygs6DOlkF2R0BtnwZWixudd/IlFP5Cm/t5SNw4nvl+8ts7Mrq3ICIJ1w7Y49
 YSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3cr3soCs/aH4Auc5veUlCs6H08qDugqKnqtBUy6DKyY=;
 fh=HHMO12g0G7ZprpjCCNffzmVO8f93EcoxePuTtLzIyFU=;
 b=UJe3zRD6amWZjAfTTERuhzLAWc+0M8040KF9Ta0NKPnfo9t/hI3CtgCkWKPmy6bsOy
 XSCjoST38lW7oazXRf+YAZ/8AK+/t3xBy61pzgGyJq7feFqLZ6mtRzq3fa4BxTatJ+85
 moMJ51BiuKBR7c3GlGdAbR4TZIBQUW3IKaGBSYG1Wj0gp87bbT77z/HJ+GcxYnzNpnJN
 zHICVnopSOIRWskdLRJSniMM4h0tKOP3uO66ufongRGaO447uKHWBcuui68U8IMRu4k3
 3Y1q2RAtUAKbtlin1mLNnAbO4zQBGvANMWmf2jI/tB5SAnZ/rqLAUpTill9NP/V6tXaO
 DwmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1795545612; x=1796150412;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3cr3soCs/aH4Auc5veUlCs6H08qDugqKnqtBUy6DKyY=;
 b=Yeic/bHIz3W+gXio5nssxoCXJOwca/RMFHNCCqLwE7M0KxDef7PB8eSR91IfSDjD09
 M8VUoTExrlAuIvUlYeIkJiGqZSytkF57HNRZxVTfVQkZh/2xU8H4Ph5c5es3rDKw8QEs
 OXjyQRRLbv/w/RlP58vMPLpSiMaygYyEJ45BufTO0+zjiEG1uF2ZPJNQELzruUueszUI
 dOOyN98U3kQFfwSmx3mKfwN/B1wswvoUVYv/g8nm9ckZW4iWJJaAYc0wpm2kdGc8g+O1
 t7xrDCRhf4iV1XerzMJmTM4ZxZzqij/hcUALjQyPwZRgsyABfYU8nU70jFKBA6zKRkT4
 3WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545612; x=1796150412;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3cr3soCs/aH4Auc5veUlCs6H08qDugqKnqtBUy6DKyY=;
 b=pLTJXYRGKaQCgXRWcF7OJQ9HNl+mWi21ent8NmF8vJW2XU86UWAloVvDcN7fzP18eY
 ym4LCz0TzogeDY89nIhSuF+SS2DjYJbgeuyTN5YmVtE0QmjdfpfXxtLM3XU7bNyUlbgZ
 FEOQ5+wAaXxr9kdfC6DLJ0hsVHPyDeksWf4/WIBWEje9eRDpqMLqrg2SjN8R6ZZ9+L9j
 whrkrApzPwOM4PYYVAeqGQoZzpZ+NGOIYjY2fP5Gfd3Mv3SrKmlulR86cmVcmgbY1dpA
 evgKgfZsbAXiuy07bM/mI0fXzv9/xHkk0cubu2GxvJa3BXncJZz/yqYeFI0y/10avfIP
 LS4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHiPsS5SwjagoBX3tTGvtZ2XBiJzu4z8ZIe3hsyVKdDi+Pxr9uGAkLRQirOFfzG7KdHMX8HrHVk180=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Uu4irxb/69UVG4ay/Jbvq41nSdQwVFW+Syo7B9Ug6SDsNUkWt
 HCcAxQXl9hmR3PK4k9NDL82UXdP7UjzD2eKXbVJaewSTsNxX+zLgicAg8ldjjIZjOGkWotvzlLY
 +kkhZ18wMobl7uaJZxrwIl/VcMMZde1m1NaqK3pWhSw==
X-Gm-Gg: AZFdTZefjKAjMj0ZZkHb/PSUc+X7VUEfYxS8/L5yHNZwq61JVGtWOh7rtowpsDIiC7m
 xX+OGjvec55D7KEZLvxmbEnq5hdGx/kUc9N0BLhR//7v9YXsjTFC/tDVJ+XS0WRbnc/ue7tZZ8I
 P/ogrcU+RYPGX7Zi5kp5uAzq6ezOMEpwXauebykuWaOsilHqPMF+nuGY9EB1lfEcGBTkdUzjiz6
 SDdXOp5uI+fV+C3WaustjWELamDKe1rh2gNjrk2xZkaVGXpiHJID6OMjGvRAwTanKJLtyCjCcjy
 g9jn8NsF/b2Nw/9zZUVSE9GYtU4b6c+j3PFp83kWMclU3UDaYDTEC6aLt5kxx4/H859eCbjpv7P
 QTH2gaxLSsP4FBF9CRlQ/Sr2vdY6P2SeDlDZk
X-Received: by 2002:a05:6a21:3e04:b0:3d3:ae40:51e6 with SMTP id
 adf61e73a8af0-4014bb52da7mr14240670637.26.1795545611912; Tue, 24 Nov 2026
 10:40:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-34-angelogioacchino.delregno@collabora.com>
 <CAPj87rO9saEC34+5NiYK8xyZiNytrVgOcszoY5uc7BpL=M4WTg@mail.gmail.com>
 <14a4f698-8739-45c6-8904-496ac61e73c9@collabora.com>
In-Reply-To: <14a4f698-8739-45c6-8904-496ac61e73c9@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 24 Nov 2026 18:40:00 +0000
X-Gm-Features: Aa3M54qIEgHVmsqq4DxWvUflQF2v_NEZOm-dewWZxD6n7rtVG1aK5-HIk_WFDp4
Message-ID: <CAPj87rPtL1nDrEF34LTmQDr9V4GbX0s8SR3wwwWWp4r0yQ2hag@mail.gmail.com>
Subject: Re: [PATCH v2 33/46] drm/mediatek: Add support for Display Controller
 exDMA component
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
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

Hi there,

On Tue, 24 Nov 2026 at 15:01, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> On 11/24/26 15:28, Daniel Stone wrote:
> > On Tue, 14 Jul 2026 at 12:45, AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >> +       if (!pending->enable || pending->height == 0 || pending->width == 0 ||
> >> +           pending->x > OVL_EXDMA_MAX_SIZE || pending->y > OVL_EXDMA_MAX_SIZE) {
> >
> > Definitely don't do this please. If exdma is asked to do something it
> > can't (and I'm assuming that these last two checks are intended to be
> > on w/h rather than x/y?), then you need to reject that in
> > atomic_check. Getting here with pending->enable == true and then not
> > enabling it, is not OK.
>
> That was done because mediatek-drm isn't in the best shape, and atomic_check is too
> late for this check... adding support for those components is done on top of a big
> restructuring, which still is not complete, as the entire mediatek-drm driver can,
> and needs to, improve quite a bit.

Hmmm, too late? I don't quite follow - there is the layer_check()
which should presumably stop such a state from being generated within
atomic_check() - is there something I'm missing which means that this
couldn't work?

> > Relatedly, most of mtk_plane_pending_state should be deleted as
> > duplicative of drm_plane_state and it would be great to see a patch
> > series very soon to clean that up.
>
> Again, I agree mediatek-drm needs a rather big cleanup.
>
> Lately, upstream has been a bit slow in reviewing etc for many reasons, which is
> why this series has been there for months now (though things are getting unblocked
> lately at least for this specific series, so that's good).
>
> Anyway - let me see what I can do, but I can't make *big* promises - the only thing
> I can say is that further *big* cleanups/restructuring is something I can do in the
> next iteration (after the partial restructuring that is done in this series gets
> merged, but definitely not in this series) whenever I can find some time to.
>
> I'm all for making things perfect, but I only have two hands, unfortunately :-(

Sure, that makes sense. I think this series is already a really good
step in the right direction.

There's still a lot more to be done though: if I was looking at this
as a new driver, the state management alone would be a hard reject
until it was fixed. It looks like it was a pre-atomic driver with its
own state management, which then had an atomic implementation bolted
on in a way you wouldn't do it if you were starting from scratch, that
has then had three different hardware-programming mechanisms (shadow,
direct, and CMDQ/GCE) pushed into it.

I'm sure there could be more to be done with the vfunc forest and the
way all the components are modelled. I'm sure any specific 'why not do
it like this?' suggestions I would have would be very wrong in some
way, but as an exercise, sit down with someone who understands display
hardware and KMS drivers for half an hour. Start by spending 3-5
minutes explaining the MTK block & routing model to them, then go
directly to attempting to explain mtk_crtc_num_comp_planes(). A lot of
the questions and confusion that comes out of that would probably feed
into what a different design might look like.

Right now, it feels like the top-level DDP implementation is so
generic and flexible that it's extremely difficult to reason about and
think through, but then it's so abstract that we end up not being able
to use any of the hardware blocks in anything other than passthrough
mode, which is pretty much the worst of both worlds. Hopefully we can
come up with a better path forward that means we can support more
hardware and expose more of the functionality as a nice present for
next Christmas.

Cheers,
Daniel
