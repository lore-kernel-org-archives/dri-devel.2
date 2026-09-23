Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A653BC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F6410E355;
	Wed, 23 Sep 2026 21:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QIzdP5xJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B006F10E355
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790197339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKzsQNntyGjEwsAIdx0pWG37GNuIJKd5sAW4Gaaxezg=;
 b=QIzdP5xJORmrFuUTqGHDiLGR5oHJtsIsxGnnDmnssibV2BudDD66r1kQlU1Zq+Fjcmc6Ps
 jo8vmE0s1ncMg74drcvIS4ov8nLJqZI4bs7kxASt6SgTiSogBHUSAekRZYZh1fJDwPEl57
 ge/4D4FTsQOEh0fBTlj1bhZwy1Ppxfo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-K-A87gy3Oj-mfjnekLxdGg-1; Wed, 23 Sep 2026 17:02:18 -0400
X-MC-Unique: K-A87gy3Oj-mfjnekLxdGg-1
X-Mimecast-MFC-AGG-ID: K-A87gy3Oj-mfjnekLxdGg_1790197338
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-532dc3793easo4400051cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197338; x=1790802138;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DKzsQNntyGjEwsAIdx0pWG37GNuIJKd5sAW4Gaaxezg=;
 b=epD+W+SVzHWPDdkPtXPLHRfXAIiWSDHhziEHVGM9S1f/vaYUpj2QzG1LjY5Ir0ztAQ
 rmmpIPVCjn/nHoJfx64qngY8F8L1ejYiNEKljd2EaKxZVDyd/gRnrW81QFdsfe8R+Ai4
 TyqhtnAG+0v0J6CHIFxiUYP3OD+YMxdUqPBN4y5UCl28lExwhrhRBIR/6UEEOMXlHaOd
 5ZrLDh4Qr54ikpl7wfuhR4m7W8PERZTGIJNbq2tRh1OnAqglgK7+y5Mk1E1fCI+nt9Fs
 0A1Xnr6xaFumcSxRRyCWWxQeMtx0QwYhiYTHYWzLVijgNF6oErc0rfJJ60Ci7OeX4hJS
 3b5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw//07yEVVnkruAT3VoFxORmbfxYWU3bIea2IaW/Rn+dWcycoTZqzNWlJO31wC443fdJoI3lj3rnZA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ng1f82Ih8LAUcdJCxaPFigRJxta4IBP3t6dWghH4Nj7US9t7fD
 7l4FyCLrFwxt+WbY6KXZcJDzTb3SHAhiwMIPHUD3KHIrV5h5lr0qxKkOQya51i4sdVPZDBhiCNw
 itzSEdOJmM3kKvrvAoTzj7AdYAM8U+b8r07IcmCTCpqIpqUODO1M6zBJzgChZ6l/Me62orA==
X-Gm-Gg: AYBFou3+vNe3rD0iIhOjFcCH2cqyg4auULFzXzK7NlaaqAI5n5d5w9aUewhSi38VwzF
 8nJ8NrvbVrKOg2v50UdngYVPPf3ca2+0E2X8To7/Stshefqv3ZWTtI3rh2B4Bsbw5yQA2gGl9FJ
 1fCEyEUSsf2G+VbeeZQOdnheGlNAiHknChHfjr94pl3ymi0XXIiXdFzZ29KT4QVdsPCbBn6yBhB
 LH4ysb6EIMIkHZ4mM6VEipP3Y1EZEPruX28UX79ZEvJfUGxyD88Br3O0s98R7OeqMcoGtEJVoLC
 AJtikTimTSiehgkI16+pHzKltnL1MZGORTh3jCglwFksEq0ULl81B9s4gvLnhQUzW/INRD0=
X-Received: by 2002:a05:622a:1e18:b0:531:1e10:acfe with SMTP id
 d75a77b69052e-532fb6879a9mr5732301cf.10.1790197337670; 
 Wed, 23 Sep 2026 14:02:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1e18:b0:531:1e10:acfe with SMTP id
 d75a77b69052e-532fb6879a9mr5732001cf.10.1790197337073; 
 Wed, 23 Sep 2026 14:02:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb364154sm28033471cf.22.2026.09.23.14.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:02:16 -0700 (PDT)
Message-ID: <d5a7e1c598ca3bcaa8cd9eabd1c952a9734033c6.camel@redhat.com>
Subject: Re: [PATCH 0/6] drm/nouveau: HDMI output colour format and
 quantization range
From: lyude@redhat.com
To: Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, dakr@kernel.org
Date: Wed, 23 Sep 2026 17:02:15 -0400
In-Reply-To: <20260923201930.1836730-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
 <c78df20bd86437dd3987053765a550b3bac0cc65.camel@redhat.com>
 <20260923162348.1037898-1-Capitain_Jack@yahoo.com>
 <07d66ea7e0f0c7aef313b11d0881ca9170f05c77.camel@redhat.com>
 <20260923201930.1836730-1-Capitain_Jack@yahoo.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rFm8TjmuHT9bPUUPcOprOCsyUICDELhy0JpTuyeaD5w_1790197338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

https://gitlab.freedesktop.org/mohamexiety/nouveau/-/commits/nouveau-imp-up=
str-v120

From Mohamed: "the old one. new stuff still not pushed anywhere yet as
i am still hunting down some bugs. works ok as long as usage bounds
dont move in different directions"

On Wed, 2026-09-23 at 17:19 -0300, Daniel Campos Ramos wrote:
> Thank you, Lyude, for the detailed answer; it makes sense.
>=20
> The bandwidth point is fair: my sink tops out at 225 MHz, so deep
> colour at higher resolutions was never exercised here.
> I withdraw both series, this one and the HDMI Deep Color series v2.
> Please treat them as a proof of concept, in the spirit of the ray
> tracing work, if any of it is useful.
>=20
> Where can I find the other developer's work?
> I would be glad to test it on my bench and report back with a Tested-
> by: a GA106 driving a Sony KDL-46HX855 (HDMI 1.4, Deep Color 30/36,
> no VCDB), including 12-bit frame-packed 3D at 222.75 MHz and full
> against limited range on a sink without a VCDB.
>=20
> Daniel

