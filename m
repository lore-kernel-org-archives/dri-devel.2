Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F64CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E62B10EB40;
	Tue, 23 Jun 2026 13:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LV6+ZgmE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5C010EB40
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782220127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za8b7Tz7sxL5eoB+rct+/JCwXX95wBIIb50tfWhm9/Q=;
 b=LV6+ZgmEQANS0LeMmNmHlDR7D+k7zMb5b4zev9BG4MRiln+LYmmZCfa/KqH2NPxmBWkmZm
 EE1sTj5MQStm7eXCbV7IVZVt7FDLmK7csW6K6E43MQTZ3TzFpx5QSZj4uFJygIwslrRbf8
 Mbi78d0Ett4IWus0mWgZgLU99PgX044=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-qPPNA83yMpW1Di7JAMvdmA-1; Tue, 23 Jun 2026 09:08:43 -0400
X-MC-Unique: qPPNA83yMpW1Di7JAMvdmA-1
X-Mimecast-MFC-AGG-ID: qPPNA83yMpW1Di7JAMvdmA_1782220122
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c0853e3bd08so413925366b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220122; x=1782824922;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhV+fQg4GhL+/RFHqkId8dIHE/BQEiUCFDOj1bTyuBw=;
 b=BiNJ4epxLH07BreHHsCwgcGysvw3aNhj9OCKd3MbuyNEYUd6Gr6FBoD3bqWwiezswo
 52bYUvA1eWaZwBQts2SqjaHJBjn4EaMLYMwTCpgQlYYzrSHFrBk1/CkXOOSSxcEcwB5W
 1R2hYh/LPdMatFeiRmNZs0Yupeke8F+rdGEhhaXwxpedSaPjvQSC6Gj+zxjCjGfgqv1o
 tfJWZfyMzvjZRZp4727I7YZsPa87y8TGIY+UJ1tmlPTYEd6f1RaxP2Bh2sZ1S/RHipap
 mGpUbUCZr3LefgOie+8+QKeiQJKmf0WdN36H2cyPC1Zp/m93ulKGo8W8E4U8+P8cCHkp
 9QUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eWFqa9SKywKJrkD836H/ORiBN+54gqpmgppDuQWAUkd8yFp6vJ0azNQbPc05xprDFMQTuZrq6+Ro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+M4B3AYLzXR53N5pYR+oWtJtlvF7g3Q7MR6g9faq355UdRhEw
 q+5vYgcYtV3baWxoyZkLr1gXkb/NN9xOx+CVapNlbOyeBEtTqrXZp/I6Q5eOGm1SokWpv3OxryF
 An6S7S3XgOO7J1QkT562vwRLusWPqhBt9GYNMPepSJDVKTWU8stdGQzM2TJiq3A9kF461BQ==
X-Gm-Gg: AfdE7cmNcei5MjVlEf8STwWfK1xLwD1Z9VrEzcNS7NanIh2HdaeBn8pvnFnBqmsGYow
 hDBEOhthrXUiCUxQIDTIzCJeLGM11H2u4iOxcqH145/Y0wAwyyDAOB7G8oBRgDiXBnJhpCs1E3f
 UJGY5VCXrUcEUhhpVnNj1752IhxTDPVrx3rSMHzMPwRW2Smp9DITcH9IqB1pClSErmDNKyZkIfM
 BabLesrgfcz2K9PFRSZAE1o+3Wpr5AuHsdZnmfVTjl0biSzp0uCsh1ZN316ILGv4yLRLGOUoLZs
 D/IfJ4jMqW7wE+JeOwwfUPNFc6/e2hDkYpD4AljOsOF0UP8DLNARg2pyCJv2kR2qEpePHm3nzw2
 7q59IG2gSg0T+E/nDfrhHSxySyo1oUOjtyOoD
X-Received: by 2002:a17:907:c0f:b0:bfb:13b8:2ac4 with SMTP id
 a640c23a62f3a-c0c643a9322mr732716966b.13.1782220122312; 
 Tue, 23 Jun 2026 06:08:42 -0700 (PDT)
X-Received: by 2002:a17:907:c0f:b0:bfb:13b8:2ac4 with SMTP id
 a640c23a62f3a-c0c643a9322mr732709866b.13.1782220121644; 
 Tue, 23 Jun 2026 06:08:41 -0700 (PDT)
Received: from [10.32.64.70] (nat-pool-muc-t.redhat.com. [149.14.88.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c616175c2sm511061966b.61.2026.06.23.06.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:08:40 -0700 (PDT)
Message-ID: <bf8dbb798406303e0fdf75a596e36ab8fb85aa0d.camel@redhat.com>
Subject: Re: [PATCH] dma-fence: use correct callback in
 dma_fence_timeline_name()
From: "pstanner@redhat.com" <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, =?ISO-8859-1?Q?Andr=E9?= Draszik
 <andre.draszik@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Tue, 23 Jun 2026 15:08:39 +0200
In-Reply-To: <27f54324-94ac-4bbc-ba58-642a314197d7@igalia.com>
References: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
 <099959fa-3a41-4166-8c10-4e5c2b9fdf19@amd.com>
 <27f54324-94ac-4bbc-ba58-642a314197d7@igalia.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wS3YjgCIxBP_lt-Q0AWdcDLYt73tQtL8DYURjhMiZzQ_1782220122
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

On Thu, 2026-06-18 at 20:30 +0200, Tvrtko Ursulin wrote:
>=20
> On 18/06/2026 14:46, Christian K=C3=B6nig wrote:
> > On 6/18/26 14:00, Andr=C3=A9 Draszik wrote:
> > > dma_fence_timeline_name() is a wrapper around
> > > dma_fence_ops::get_timeline_name(). Since the blamed commit below, it
> > > calls an incorrect callback.
> > >=20
> > > Update it to restore functionality by calling the intended callback.
> > >=20
> > > Fixes: 62918542b7bf ("dma-fence: Fix sparse warnings due __rcu annota=
tions")
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> > I'm like 99% sure we had that already fixed weeks ago, but somehow it l=
ooks like that was never merged to drm-misc-fixes.

I'm also very sure that we had shot that bug down not too long in the
past.

> >=20
> > Anyway Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> I was also perplexed and took me some digging to realise what had happene=
d.
>=20
> The copy-and-paste bug was indeed originally fixed in:
>=20
> commit 033559473dd3b55558b535aa37b8848c207b5cbb
> Author:=C2=A0 =C2=A0 =C2=A0Akash Goel <akash.goel@arm.com>
> AuthorDate: Tue Oct 21 17:09:51 2025 +0100
> Commit:=C2=A0 =C2=A0 =C2=A0Tvrtko Ursulin <tursulin@ursulin.net>
> CommitDate: Fri Oct 24 16:56:37 2025 +0100
>=20
> =C2=A0=C2=A0 =C2=A0 dma-fence: Fix safe access wrapper to call timeline n=
ame method
>=20
>=20
> But waaay before that I sent a fix for something else which touched=20
> those lines not noticing the copy-and-paste, fixing a different issue.=20
> That one however was not merged until earlier this year:
>=20
> commit 62918542b7bf08860a60ebbde7654486e0ac0776
> Author:=C2=A0 =C2=A0 =C2=A0Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> AuthorDate: Mon Jun 16 16:59:52 2025 +0100
> Commit:=C2=A0 =C2=A0 =C2=A0Christian K=C3=B6nig <christian.koenig@amd.com=
>
> CommitDate: Mon Feb 9 14:05:20 2026 +0100
>=20
> =C2=A0=C2=A0 =C2=A0 dma-fence: Fix sparse warnings due __rcu annotations
>=20
> Notice the authored vs commited dates.
>=20
> I guess it was a silent conflict which overwrote the earlier fix and=20
> restore the copy-and-paste bug.

silent conflict? If that can happen with our git workflow, how is it
that we don't see things like that more often?


P.

