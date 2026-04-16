Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C85F433D4
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A1610E100;
	Thu, 16 Apr 2026 02:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQaTBNPB";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84D610E100
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 02:17:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso50466345ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776305857; x=1776910657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YiM99jgiXcT6WCgvh8nGGr5bdaeTxUPbaDjRT/oKk8M=;
 b=JQaTBNPBPrwDu+jFoZHWAXodTv9dGM5pCKYmLAb7WWjXXKXQNRa2bdXRcDPeZeWdAg
 59JjVNZQx3QrFGphUhWC5UEmysogNqvUFyNlatuiFR/+nR3BiLvDBVjmkOp2rQ8UNdmr
 CiuuUhpUtLpSsqzjGfjSzDnrP4Vzf+asMF6g1WQ1MtHn2uvO7hevFc/kGOW9H+QNQN/b
 iW1GOdea5HBSkoX93PTY2i7Oinc9IveWCNpKdGl+0BxntpG+D/6Ka5Ri4t/gBm8nLril
 d7QWdvhRenBr6gVlvB/1ktl6X/jOk0uOWJI2oXIYIleygb2ToVYXwKb5Yl9ZiCMRlina
 fAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776305857; x=1776910657;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YiM99jgiXcT6WCgvh8nGGr5bdaeTxUPbaDjRT/oKk8M=;
 b=NKbSqi1HiboCaadNkedWhmGukvDUHmqSEtpUHR1+dB+Ji39NnckUq04ywp9vxahBM0
 jUdrqzjmhtcJ8gaVwQirCgiMMpsu/S5y6kj0Jg0SBRHXj8aWuevPnGXE9g0z3GOWY8Dz
 9c+EbucjtW4SnV1mFteerLJimZ2VwNtSCT/FT3dl93zuBkxaXjaIcKumBy1IF8eQrpau
 O5qTSGaO3SwzuhjsEFSR9GQuiOzv+gQnAtJmdDIuCtirFBZUu2x8Hky13st1ZcNzbwE8
 OMbySpZdHrcorNyaoAwv5mHFYM+sxELs0S3Whnu1J4Z+QAiSUZTPD4wyHiRKDqpbjxCf
 5aGQ==
X-Gm-Message-State: AOJu0Ywsz1HmCIVBVeqdPtRxwcqbImTZjKm4uwkF1emAIxcpinxmAiFI
 /zIAmuczEmYS2RTXUAx4qnvl65k4RDMwkjgIFF6L9XgKm7qAhoui/brW
X-Gm-Gg: AeBDievPKzwKrPvt7wI+Swc+tqKcP3x9jG9OpYG2/6bgfXlNG5iLJ9/ucqeqkbFLMrN
 ///hYNNutz0GwlqswDMdqxYDBQzgBUzgcOTenitV/6Y+9dxehZlvKoY6az540cF7MZ+NlUXiVL6
 2fitYD7U99dx+h2cc5/CNc/ARQrN/JtT0WbNluvbtpH4l+8ZsX19sOMT6r0E38YJMPRMMPgdzqE
 uNYxahs2B7qZvKIwH72/j8zttv4RuFjWiOREAmbWO4PbXBjXt4+eQmilKwMf7dp3CLqwixfCIK8
 LYzfWEvX/hrX/Usawb6cbq9D1URSY+7cvDpOkY3AEyK9l7+f9cbVQQE96fiosEwzhcBAy/dZhbn
 utSv26OzrkTgqxXMirfopVyxOi8FUv+dInSkfOxlhFkBzer73KD0uNS1NP7tVI4bWE6Sz42PUZA
 WT66h71Ryob7mH9Uju8J0SQ1cXkzpt2FItdfdlUkXLon8=
X-Received: by 2002:a17:902:7001:b0:2b2:4e5c:69a9 with SMTP id
 d9443c01a7336-2b2d59411a0mr157321785ad.5.1776305857115; 
 Wed, 15 Apr 2026 19:17:37 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:78f0:5b08::e2d:a51])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826e23dsm43589825ad.39.2026.04.15.19.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 19:17:36 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:47:32 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
 skhan@linuxfoundation.org
CC: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Documentation/gpu=3A_resolve_?=
 =?US-ASCII?Q?kerneldoc_duplicate_declaration_warning?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260318143612.2533863-1-sanjayembedded@gmail.com>
References: <20260318143612.2533863-1-sanjayembedded@gmail.com>
Message-ID: <A2B5F0ED-8C58-4A88-A4EA-8DA50289ECB5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



On 18 March 2026 8:06:12=E2=80=AFpm IST, Sanjay Chitroda <sanjayembeddedse=
@gmail=2Ecom> wrote:
>From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>kernel-doc build with `make htmldocs` reports following WARNINGS=2E
>
>  Documentation/gpu/drm-kms:360: =2E=2E/drivers/gpu/drm/drm_fourcc=2Ec:39=
7:
>  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35=2E
>  Declaration is '=2E=2E c:function::
>  const struct drm_format_info * drm_format_info (u32 format)'=2E
>
>  Documentation/gpu/drm-kms:491: =2E=2E/drivers/gpu/drm/drm_modeset_lock=
=2Ec:377:
>  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48=2E
>  Declaration is '=2E=2E c:function:: int drm_modeset_lock
>  (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'=
=2E
>
>  Documentation/gpu/drm-uapi:607: =2E=2E/drivers/gpu/drm/drm_ioctl=2Ec:92=
3:
>  WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69=2E
>  Declaration is '=2E=2E c:function::
>  bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'=2E
>
>Add :no-identifiers: to prevent duplicate identifier generation and
>keep the function documented at its implementation site=2E
>
>No functional change=2E
>
>Link: https://lore=2Ekernel=2Eorg/oe-kbuild-all/202512302319=2E1PGGt3CN-l=
kp@intel=2Ecom/
>Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>---
> Documentation/gpu/drm-kms=2Erst  | 2 ++
> Documentation/gpu/drm-uapi=2Erst | 3 ++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/gpu/drm-kms=2Erst b/Documentation/gpu/drm-kms=
=2Erst
>index 2292e65f044c=2E=2E0f0f90b3186d 100644
>--- a/Documentation/gpu/drm-kms=2Erst
>+++ b/Documentation/gpu/drm-kms=2Erst
>@@ -356,6 +356,7 @@ Format Functions Reference
>=20
> =2E=2E kernel-doc:: include/drm/drm_fourcc=2Eh
>    :internal:
>+   :no-identifiers: drm_format_info
>=20
> =2E=2E kernel-doc:: drivers/gpu/drm/drm_fourcc=2Ec
>    :export:
>@@ -487,6 +488,7 @@ KMS Locking
>=20
> =2E=2E kernel-doc:: include/drm/drm_modeset_lock=2Eh
>    :internal:
>+   :no-identifiers: drm_modeset_lock
>=20
> =2E=2E kernel-doc:: drivers/gpu/drm/drm_modeset_lock=2Ec
>    :export:
>diff --git a/Documentation/gpu/drm-uapi=2Erst b/Documentation/gpu/drm-uap=
i=2Erst
>index d98428a592f1=2E=2E73b49e0dcda8 100644
>--- a/Documentation/gpu/drm-uapi=2Erst
>+++ b/Documentation/gpu/drm-uapi=2Erst
>@@ -603,6 +603,7 @@ DRM specific patterns=2E Note that ENOTTY has the sli=
ghtly unintuitive meaning of
>=20
> =2E=2E kernel-doc:: include/drm/drm_ioctl=2Eh
>    :internal:
>+   :no-identifiers: drm_ioctl_flags
>=20
> =2E=2E kernel-doc:: drivers/gpu/drm/drm_ioctl=2Ec
>    :export:
>@@ -761,4 +762,4 @@ Stable uAPI events
> From ``drivers/gpu/drm/scheduler/gpu_scheduler_trace=2Eh``
>=20
> =2E=2E kernel-doc::  drivers/gpu/drm/scheduler/gpu_scheduler_trace=2Eh
>-   :doc: uAPI trace events
>\ No newline at end of file
>+   :doc: uAPI trace events

Hi all,

Requesting your input on the change=2E
Is there anything that I missed or required correction ?


