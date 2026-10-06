Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC2CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB51610F5D9;
	Wed,  7 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0sJ/KTU";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3F610E397
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 22:14:21 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3a75f960be4so8531241fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 15:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791324859; cv=none;
 d=google.com; s=arc-20260327;
 b=ZsO4n93evcBRJHyYGO/pr1uU1Jz0NRPG/rMc2Gb2oKfidq+kfONcPXDBGnXimrDkrk
 s6w6n/4ZYNPZUjZbOSBEX0XV9rDVnvkVPJwBlreGAwlHAxpgLhlyHG2oPnTREs7ANk6o
 I+82UFsiBb+2JX3/oRWcam9d6f2In8tZCqWNEkGYEXuFLYuinz9Tg/gv0RIIgKkG0qOQ
 1dZOgyoWc1ekZtIh3QZ4f+PWECXfykjx9N5MZpzx1IdndK7jFn2qfP23AXHRX6ATjCgk
 XjSXBod14KSPQIcwLA/SvIxDc6kJrwhZbwkTn6SbMJx8yUwtgvMKgNj10s0oAuZAyz++
 KycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
 fh=ThARES5xqMmACv6nCD2M3tIyrnPGcr9jK+yOx5fdMio=;
 b=qz2KqZm7WBMDJ2vyWLdqb0KRIC5Exm08l9DNY/7X/+v+amvNkp4PnsCRuCQoq53689
 5J+YkbUR8ExW+IZGpiPtFED3l1PNLbGZUa4skhjSe3XM2T5RBrDPoQFnAFGGT1aA3fDy
 AKQSzNl7LvmVJ5AGovQvrqh3NpEGzsnTVHreMzN/XJHHx0aUZCMfxUoZviazLQGJYZv3
 78neWCRJV6Aj55KDlo8cVZCqS/Z1soTaWpDpkRE2XhflFfr3DfV8oaWsAQ5dBgqAaY87
 4d0bsG1rh8nVlZmILfSYVQ/kClmeYz8VkK7Fhwtd23v8sVyr8p5iPsxsrg1BGX3HmVUu
 cVlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791324859; x=1791929659; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
 b=H0sJ/KTUVwg/ILyiB3enmAoFbFguvrD+UYaZ4X+QOFULlPBT+Fk++TndkBb01RpzS+
 R2tCHpRZTIbKuy41uQhNzmoS/2A5Q4/MxLWVvkzxYFeKtzcOVfUApqF19YjSSXFUU2qE
 /gsZjmymUsOeGkfe1oKTFMBCxYpK+wKPt5cOo6fAD9bOPgH0iB592WCfW4q8SbnnZin6
 Qd17kQZplKSOp4BtAkRB1Gw2KmmnmxAoMf8h12Jpag0PmRnSlMsp5Icnk54WfZOmBUVm
 mEC9ye2Guy/7mxMb3qwNsWtME1227mxZvUoB7TX5EMF2arzgqHbXn8YwyGNH3ny8IDB8
 6tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791324859; x=1791929659;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
 b=yG2ryVF5Lc9QYG6KFUgaleggaDPs/DkJt2rA/UGfGLXIVFzdPJ000KlPmpqRWQPs4U
 bKefiMfneTaFQwzzB6dYWx9Dn+0wUL+1EOTMnF6/mThcFzG5DNfswZsXBvwKx9iv97aM
 0Ga8QWrzRHR8JnQyAwmP7SmZA+GkF811TodiZJH/apWH2R0qWFMUNZjzgxCypUnPDe8/
 yYE7jGsKJATyj3S/+REn3EgSt/JBn/oPIJ15KLfz4/MpLqFeK5Q+3ueqntFW3HFlZ57x
 MhLbscAI5lh0tvLCMTv58kpxN2k+2ASR02mSEw5rBQmfMdAxxRNnlJAzGB50EFHFvJOH
 4+mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMR+yLOlTLacGr6YMYGtwI5LPZocjeod0T4esKVkNgjZjvLqmw6rmgFh+8alG9NJ0STTLhDMnn1OI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKwQ+S5iaJVKvKWFW8qcXyFGMn3s6u4jHKohERkHr6CTed9n4gY
 hrbk0iOEfGVVQiso9nEB/czUBWfAu6Sz/n3bssDR4FJc+mf3vesmZxZaYe4ehhsST6ldUTTj7JP
 KFEI1ztpr0DzH9Z9OusT2RsXnbBlfwCs=
X-Gm-Gg: AYBFou3kS6Bjz/y4XdLqZvMxum5gL5e5XoQQfc46icXAcw6uc/5chbzzjBZoLHIIE92
 DPMqbrM7cFusiTWn7/3i+BO1NRJ+zqkOD2vz+v+Su8RZQKoX9MvYccADVyzrC0+X10KZ8VnkyJt
 R4DdSSAqwPBOjeJ/inFXOThgv512pCmL1WDv9xaPHt680COcWiqqXt2kcZFsVr0QI0fDhTarDrL
 RWEJEFYN4Q95tbaGaoaQgznMjC5IpolVs32NS1BDDpjr/jEtBfrsQL5ctj07e5ihUz5oDiytm0O
 cqV8jRYj9aFIiNQmqxRFhI+njBi4jMuqUAlFeMD3qwTCEAu43mdXl9M=
X-Received: by 2002:a2e:be84:0:b0:3a9:7160:e83e with SMTP id
 38308e7fff4ca-3a9a2cc1e75mr696691fa.8.1791324858938; Tue, 06 Oct 2026
 15:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
In-Reply-To: <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 6 Oct 2026 18:14:07 -0400
X-Gm-Features: AclHuK-H1P6XAfW5WOEyeLge3myteWvfLBr0lYFKR2exJpjCcMV3nLYXUK8SvaY
Message-ID: <CAGG=RgCoBZwks5CR9GK0+xk8kexj_wWZf23WwmSTLZBu1hW=eg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

Thank you for reviewing.

On Tue, 6 Oct 2026 at 03:41, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> IOW, you're not hitting the issue yourself? How did you find the issue?
> Did you use LLM to write the patch?

As part of security research, I am reviewing how virtualization code manages
the lifetime of resources it shares with guests and devices.

> Did you use LLM to write the patch?

While preparing this patch, I asked an AI assistant questions to confirm my
understanding of how the driver works. So technically yes, an LLM was used
in making this patch. I should have disclosed this in the submission; v2 will
carry it.
