Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24ECC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2964A10F138;
	Thu, 20 Aug 2026 17:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hArgYwTA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6985310F138
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787246991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6fDO/OvmnpEv3y56Gcz9A5mW0qI4GbmiOBQlO6WwdI=;
 b=hArgYwTAqZUOI2nbMJSJu6wHU2Wd6ELhZAnTZeCAdGYNNmVxMjVSSmnHhVOTT6xJWWyv6G
 UFv52SJn9Ipc0a7b+vXC3mwfYLrVrJJLyllf5r17cEjhzPN1OA0+9zIPAQgjxrtMhAoR/0
 3VKHS44VThhCipIOGkQhxB7EeRlU89I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-KKs4RdDbPx283WCtHssJHQ-1; Thu, 20 Aug 2026 13:29:50 -0400
X-MC-Unique: KKs4RdDbPx283WCtHssJHQ-1
X-Mimecast-MFC-AGG-ID: KKs4RdDbPx283WCtHssJHQ_1787246989
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8fdace20927so821176d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787246989; x=1787851789;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S6fDO/OvmnpEv3y56Gcz9A5mW0qI4GbmiOBQlO6WwdI=;
 b=mBfqpjVF5JPkE+kf/aO9LB2OgBkjKh7kI4+ZodzfDKbYPKptvIlsilbWjcv+m6AED1
 xdUzMq+eXwk6cHrrhwXYxvkzi4PUFqWkeERePxERVzS21Q9MxfJsHgVoMhrqkEeL1+z8
 EnYXNaNp9EWgm4InZj8Rhmnp3PK7srJ6Yk3LPc0VzF6alqUx/rnrkvsHIIkfpSPu9CaX
 5dPEur4T3rAAbJ1+cbdBcY8QPeeLM7lB31Yqr6utPzKGkkgBWdvlkQZoO0UrOw8x458W
 D5Xs5+XjJdxTaUTHTRgmJy8WYrVaLp4UmuA00xPsP3E4uwfEEU951cijRPLVXX1/zqCn
 1AmQ==
X-Gm-Message-State: AFuF++mx77xCU6Ih2eJICoQvAHPtQnhH+QOwA06z7c2dt3GAkSNnSglc
 583urGCQIDdbgah5jW8cUM9LzcXdMbE0bRvgDkXVCAXrGcLo+4lgS3UAPDRi1a0qpZz1Ft3Rz92
 Nl00fiFQf/plEVH9s6NtKuWIOi8cg88KgNU9h8DHYMeyjgt95stGGFxgiHRHRFeahsdO+3w==
X-Gm-Gg: AR+sD10wUav108qzwy3Tw4nuPT6QWysFnam1T1q/NXLvtGiMTH29DLjBsS+1qpFGzOs
 znYihVIvvlthY1zrh3mRa+WDQ4UomtN00JOeKujeeTM7lLO3AYXCGFXVpJsd2kSk1NYCdtHkPWN
 yQ9hDwet4b1CkzoA2ZL+YiFnggG8bvZw23oqk/+/KKngs1+dOu7rHk/eR5KatmKU+Ow3ej8cOsM
 zlLjry58N3eN280LdbD6Gj/qsrccFhc6shwNvOuqzfzQjv3W9W2SQtuFgLiPhRvOW12W7DTHl6k
 rC9zJ/bfsYrgv8hzKbTqIRoI3RWvpZCwhY1Ng/MUN8EuX8kFnwTS/iFBmlAz7QMM3jjWKLMl
X-Received: by 2002:a05:6214:e44:b0:8f2:3472:5b33 with SMTP id
 6a1803df08f44-90c5eb3e8femr119832146d6.23.1787246989369; 
 Thu, 20 Aug 2026 10:29:49 -0700 (PDT)
X-Received: by 2002:a05:6214:e44:b0:8f2:3472:5b33 with SMTP id
 6a1803df08f44-90c5eb3e8femr119831826d6.23.1787246988873; 
 Thu, 20 Aug 2026 10:29:48 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f28feffsm42491486d6.27.2026.08.20.10.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 10:29:47 -0700 (PDT)
Message-ID: <26de71ad1e7ea3a08ca30b99df49d7c29c34ed68.camel@redhat.com>
Subject: Re: [PATCH v2 5/6] drm/nouveau/kms/nv50-: Add
 nouveau_encoder->audio.crtc
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Thu, 20 Aug 2026 13:29:46 -0400
In-Reply-To: <20260819161540.439931F000E9@smtp.kernel.org>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-6-lyude@redhat.com>
 <20260819161540.439931F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BDW94lQK1Ra2Aqs3qwcxV9DixZx8pkUTQoLVGNAMHuc_1787246989
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

On Wed, 2026-08-19 at 16:15 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] PIOR encoders do not clear `audio.crtc` when disabled,
> leading to stale CRTC pointers, ghost ELD reporting, and missing ALSA
> unplug notifications.
> --

Another hallucination, PIORs don't support sound in nouveau - and I
confirmed there's no way with the current codepaths for audio to ever
become enabled on them.

