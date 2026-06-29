Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CDC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA2510EB47;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S64bhzJE";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C6010E0A0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:11:26 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-662ebb1329aso2160060d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782749486; cv=none;
 d=google.com; s=arc-20260327;
 b=bco/nGSB1hA4pS1JvBZYnmUdK1kDzkUrF34K1aK0uNHxasQVnYgKx6moyouMnSNJpA
 TXAPyFR+PmStJB0ttZnMubXEfUJdbg6F+Ti8uCPdTlfO2WhyjWcVTTLN4Q1zYi1N0wwj
 D9RXPhLO98QaCQZXPrGmr7xjL0uZ8T/6lJgWU+HtNd8mV1psVfTEg6IFBsOc6YZCQIfP
 3aTmbqZBlf98UTzrerE3oNNojDxvezRFiIHEmySHRYO7iwfHdABtAJ7n8ylQzB+xfcUm
 /psx4Mb5pYaeC3c5ez5bW+dZJP+Bx/LX3+4aUbYHG7XNfHgFStbyjaVf4PR9JJqbTw8u
 nNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 fh=tB74kGpA1WUEitVikBxgIBZIncp5Ejab+YiZ9AdJyx4=;
 b=HxfjJtvFemz9rHt4ODhyUNcRtFNxH0P0CRar+N9T2PlG5Ws1BcOnVsJHRMvjxfH4TI
 nVVNDdy1GUv9kDIFP/wbVnEXwLcFSZ9Q2bRZN0G1BSs1yFqHHQv9UvSaspKFEwXX4j5Y
 wjV+5ssuh58fZkNBGJ0g5JLOH6SW56ZJTuuYorv5NLWhXyYepSRxp+FthV5PD305dKCz
 3JBlf5J/KHgAfSuQ8e1UhrNqY+IQYiuVHbMy6/VzDCFeVboTAupfXuD4kSfp5XAwv8Bi
 OdD+2v0nhfDe2wfOvkUs8ETMvGbB5EwJYQ+RTAzH+ppsz6UjNCb4ABWwcr32OAMYW1X3
 XzuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782749486; x=1783354286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 b=S64bhzJEWiypbXInEkOvudDhTB0kIhPy4Nx6RCKhQDcyIU9EwlIpUe0c1Ofre6zmhS
 tqRI0VspWwKOorUwxyBNcu/C+DThmfmycFy/py4sn1jYuL6b5k2+Fc33KS1G1uN5x/mj
 ZAg0/SDiX8qN8WO2KjP/5pweFgWC74m0xOaJRU08/tgod6ZYTAzMuAMTuhtBzCr86tLX
 YbIC0tFuo9GyFFbi0KIRe0rFd1S6ZJLSMrdqVOu0XI1InTBKneHAuRixJkcSTk1ZaoXV
 T1dgqAzaYhk/5uS6nYCxHBFjCPNTgkwWrh0qQ3aIW70GwR2O/eKizYlEvKZV3BPWblsK
 AXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782749486; x=1783354286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 b=MLlJAdbuB5b7Am6Bub8gnyGYH7ESq3U8UC9IWkt6NPGW4QGXLcAu3ibAwcek/ajhh2
 X+PDvZa5R8udjIrzGMZdZxmaHcSCbYngCrBoi1e2oClSxQJeCwXzMcEq9JsOAi+yiFGU
 c1F68bShaSRVi/KKMnNQVzTxmQG+mbjRLkBJQ3MY/cVWQKFxbFGmjpeBFyxQAIlVyv0+
 JR7NFsr3Jq4940tpBdOgBacRQXbEhAQHr0zHv6LQ8yN593R2+sw5OnB9LZ7V4T5pJfZh
 YLeEf8TDGQIfUD3Vs3D4nDGp6IGdf9NHBI0qo0UZAVwkzdq9Y9sbh23uVIywi3xec8/e
 NzsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdJwQbVFHKfcJ+H28ZrdUbN5oX+vMMrYdEFMji2jbpVeurHpdp05MTIJXtmwFMW7ipdq1ZYobjS5E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwG5kNB67fP+R/ckpuEpC1ri7/1OXCdrsGYny/LTmCAi78ppJMP
 CyLEkM4qwvyX0uJq3fhlY7KXsCf5/D8QMO/gc26BPik24FNTaXEfGW8PfcR+gARwjz1EpeJh8dS
 buSM8hBbPwxASrZvlbdw+fhiBrmmM8AY=
X-Gm-Gg: AfdE7clEXa77JdJfpPiqnTLWhOlONsPPqsjNrn0ck6H+ezzVqbjEaYImAvYstt4M3l3
 wxrOjDYI20cWTkSdaild4sTEwEK7SSAci0YTqBxN1/4SHD7sSI7eJUPb98CPu844tltR5yuTS49
 Gr6m40IgBcBu1JvuISTPCCiXhbgoWx+RQ1Ftfaiu30705a/UMXaccxgD7R6kRz2FnE7OYNwXTY+
 TzC1gVAHjYEkRqFAtct8CFqF198quckEKE1+5ruMWVCYJzTBUrGgl8HIjN4SnD8jhV976d6
X-Received: by 2002:a05:690c:6c03:b0:7fd:e030:23db with SMTP id
 00721157ae682-810d8edb122mr1823157b3.31.1782749485666; Mon, 29 Jun 2026
 09:11:25 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 11:11:24 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 11:11:24 -0500
In-Reply-To: <20260629152807.13492-1-alhouseenyousef@gmail.com>
References: <20260629152807.13492-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 11:11:24 -0500
X-Gm-Features: AVVi8CewJuorlk7vVm2WjIOaBKBFN1AO6yCKlkqQYzjQNGpeFQjuVHfzv5rEKHQ
Message-ID: <CAMuQ4bXQQYJb1nAYKJUtbz7WLi_oMtVyCSpLPVKmd-XMdG0wyg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

Please drop this v3 as well.

I rechecked current origin/master and this fix is already present as
commit 93475c341119 ("drm/amdgpu: check amdgpu_vm_bo_find() result in
GET_MAPPING_INFO"), cherry-picked from 528b19377aff. It uses the
existing -ENOENT behavior for a missing BO VA, so this v3 is obsolete.

Sorry for the noise.

On Mon, 29 Jun 2026 17:28:07 +0200, Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object before taking
> the object and VM locks. The object reference keeps the BO alive, but a
> concurrent handle close can remove the per-file BO VA before
> amdgpu_vm_bo_find() runs.
>
> The mapping-list walks then dereference the NULL BO VA. Return -EINVAL
> when the BO is no longer associated with the VM.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v3:
> - Generate a clean patch against drm-misc-next instead of stacking on v1.
> - Keep only the intended !bo_va guard for the handle-close race.
> - Clarify the v2 withdrawal confusion in thread replies.
>
> Changes in v2:
> - Describe the handle-close race instead of an initially unmapped BO.
> - Return -EINVAL instead of -ENOENT.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 27be5083f2af..83ec994ad36b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
> struct drm_amdgpu_gem_vm_entry *vm_entries;
> struct amdgpu_bo_va_mapping *mapping;
> int num_mappings =3D 0;
> +
> + if (!bo_va) {
> + r =3D -EINVAL;
> + goto out_exec;
> + }
> +
> /*
> * num_entries is set as an input to the size of the user-allocated array =
of
> * drm_amdgpu_gem_vm_entry stored at args->value.
> --
> 2.54.0
