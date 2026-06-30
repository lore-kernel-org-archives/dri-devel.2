Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE5FC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC4310E1D1;
	Tue, 30 Jun 2026 11:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZL2iACrJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8241310E1D1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782818201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK4u7OlksOPt/6U/1SRzlgkV9O8eOQE5cC4CBUyYFcg=;
 b=ZL2iACrJUc2zI0wlNzNlxO8yeYuVofR3ZrNbk+cN98B2bIRyq+f9xgGyjr5vH8rpCPeWEZ
 +vXMhPTGD75xPQ+AFVkJgASTlpOIt4dPhKa+zmH1WZYcgtfwQ90NOC/BiclTEzfKsuH5ry
 tBxi09q9ktyXyFbskkW4qdlxDtwYnTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-8xFzDAaxP02MHv4ZqmUERQ-1; Tue, 30 Jun 2026 07:16:39 -0400
X-MC-Unique: 8xFzDAaxP02MHv4ZqmUERQ-1
X-Mimecast-MFC-AGG-ID: 8xFzDAaxP02MHv4ZqmUERQ_1782818198
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso35294925e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 04:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818198; x=1783422998;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uK4u7OlksOPt/6U/1SRzlgkV9O8eOQE5cC4CBUyYFcg=;
 b=U3AJ2K1lfirVaC2VmB+k1eh4N5pVY5zW8DPN0scVGQw10NsfV95Z+yHQdK/OKfYlwF
 W7m9JPmjSzAhTkJPco/qqeea8Ld6jiN2wI7npTrYaSWy1oxKHXlo3CsKM/vBh2pZfVdQ
 gGuBucoi0IRkRz2FEbiS8A0b49tRATe1HjQGqbhxF2BHsxA7ZBn7ecAVok/Q34NsgfD3
 mMLZxNuxJibUMxNaAJtRmZk3mWy7LygYRbrLWyI2Chw1TjNHIQNdmF2ddd0/Uuzn0Ftu
 HuL+Ru6W41TnkYQdSk9HHjtGLpKOq9xd6osBrKjama5fxSj1wXvek8H2UcT7EctTa9Xc
 DXPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9320MvPaH7cmmY+ZX1+xwumaiUeHWxmaBM8fIOK9KIpD1GlHXXzGKUZyFDRy2w0ILatjW9PAddzNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDoAurT1Y1lKbwhf6g4d6WbiNPSUe7DUcSGI1vhcodlhqSXJhC
 Wot5Rr3I9nYUQ4Uh7bB5wZdL4TdEHLhfOuXLPoMa+Dg/djgIXL2MuQfdukFFhFsGrMFPQlb3YqC
 Y0dAn9ADAdXye0rlfH43YfsGM9JNEm7vInsiu0/iDxAhCCmU01p8g+ziHImu/PE7zQnBujw==
X-Gm-Gg: AfdE7cncYJLNStkSBszzcf9Cy92wbwF04bcTlWiGAuEbbZaNzNLzIssPBDSgXCZ1HkK
 +wLzMiEvQQ6ENQ6E2fAA498WZwMO2MJHJpX4SswZ7bMWrs/HLM0IKsGJvQQLCTChwr5VkrSlNS8
 449zISFTjlAOmskLZAUVvb7oKtOAYfSvBPlCJBxm94JEMCcZpuwoYwXubume+HM8e/roqDmwKHn
 u8FO7/wpHwIUsIsnUIU6BMy/Eg+cvgcL2l2eKKJSiqIy9r6Q1GW8V4Wmz7kIGidJ/TrsF635nyv
 MUGOUw6nKNyb5wEy5TZkA+rXoUKrJr+BV/SHwk3PcibIFKHECVL0xvVXgJJ2u1B8k+8oEGe2VC6
 2qe2lIreFD2RbdrTvWv3EMR5h1v6KsfuqjGsyvpihNeKlszLtjKE5cF+wKpzrJq4rMpRaoQ==
X-Received: by 2002:a05:600c:4752:b0:493:a6b7:cae5 with SMTP id
 5b1f17b1804b1-493bda7170amr1944685e9.28.1782818198019; 
 Tue, 30 Jun 2026 04:16:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:493:a6b7:cae5 with SMTP id
 5b1f17b1804b1-493bda7170amr1944225e9.28.1782818197518; 
 Tue, 30 Jun 2026 04:16:37 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ccc7d7sm64473555e9.2.2026.06.30.04.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:16:36 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
In-Reply-To: <20260630110806.23204-1-amit.barzilai22@gmail.com>
References: <87echococs.fsf@ocarina.mail-host-address-is-not-set>
 <20260630110806.23204-1-amit.barzilai22@gmail.com>
Date: Tue, 30 Jun 2026 13:16:35 +0200
Message-ID: <87bjcscm7g.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DKYiAutqWOjsPXYfrRXBogF4r0owlqK8IadfkxumfMg_1782818198
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

> Javier Martinez Canillas <javierm@redhat.com> writes:
>> Up to you. As said, I don't know were we draw the line so I will let you decide
>> if you want a v2 with the tags.
>
> I don't believe the usage was enough to warrant the tag, since the LLM only reviewed changes I'd
> already written and reasoned out myself - let's keep v1 as is.
>

Works for me. As metioned, I'll try to review your patches this week.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

