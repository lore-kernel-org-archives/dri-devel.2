Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E4C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEDD10E282;
	Mon,  3 Aug 2026 07:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cF/vnyln";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DD910E282
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785742225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
 b=cF/vnylncGIpNYJxY3ON+CNd/5ZRO/lmuQMPt3EWaE6fQCRSlK/FTwTccsSxlyyf3+jKFP
 qsKFQYav2s+U//T1o5UbN0oJDhgtZhYI0tPeR2xRSCuuRu2bsd/xe8/opD0VCEKEPPbV8+
 +hjg6a3gmHGQzuoxTPva3MVrdB9CjOY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-YT-PNsyPOl2kheepTVsJaQ-1; Mon, 03 Aug 2026 03:30:24 -0400
X-MC-Unique: YT-PNsyPOl2kheepTVsJaQ-1
X-Mimecast-MFC-AGG-ID: YT-PNsyPOl2kheepTVsJaQ_1785742224
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-907a1e04111so39842096d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 00:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785742223; x=1786347023;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
 b=gRfEgfHBt2S0GEBtRkzoWOS4iNLQIuGnCZKd/rL5o2ifaJ3Lw75njcouYSw0ll6SG0
 tdk6QtEjY73oinFjV8GknrBjxffdW8KXFTHp0Y/vAh2In1JvgJtFq/vb26COmz/1/iWb
 lmcjoqytvjT7gC1Ov9c/W5FVHVy5H0wpiXEKgt/cjK62mFWT3WHD8nlQOV1oRQQNXEhZ
 HuGUifeJvnJTxoJpFMn3WKRCj7AxWmn+xvGBMV3gX4vS6AZHHWfaatD3l6xySh5FTAaQ
 Dddv1WhdlIgZQ3NCn6CTH8m016nT7k9bfIrZnIxdJLuEnUw/VVMa09aaQ3hFUFRfl90h
 dGJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbmnYFoxlhiiuv5un9zpe88Rr+UX6dEUt+mv4zf1HIf7uIRmA9oYej6IZOR0n4aJxxF3ZuB9+ck4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk4H2mYgrpBqSeIk2EXDjmhH97/zkJTVs2EuOgSQrOInOqTOm5
 4maEoZBupAavFLXQwENARb4PkI0Fa7BHnkOncbSpKNu5D6ybXWAI55vLuodRziZisyR9rvl3tIs
 FgwGO2abUeGQxqfUxw8Vpt0xMB271E3UrAEv57TQdyqt4UPvmtvhPeNtXe8mmayGjhxc27MOsot
 W827wxTvF79RRWysRme8mVvAKroYxOTkM/RBPGbGDMFssn
X-Gm-Gg: AR+sD13GsJtTTEk3EwXryT5UBuUeuM6voSg6V9KKqESYfI8N+yvLnorom86q6fd8JzA
 xLo3tA+mW5P3uvyHhNheAKheB9uvPMYt8qs0g/dHKX37tMt/Ubgk7k60GnQRpCr9V4gOFjmBj7l
 KzzDonpPMJdW0Ldg0rnd2mQk4aJr+/+CRFM6HieRzs
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id
 6a1803df08f44-9084a8905acmr175819806d6.25.1785742223348; 
 Mon, 03 Aug 2026 00:30:23 -0700 (PDT)
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id
 6a1803df08f44-9084a8905acmr175818926d6.25.1785742222720; Mon, 03 Aug 2026
 00:30:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Aug 2026 02:30:22 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Aug 2026 02:30:22 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
MIME-Version: 1.0
Date: Mon, 3 Aug 2026 02:30:22 -0500
X-Gm-Features: AUfX_mxqss-rUQV3mA_uJr2b_Y5VtnMHlbVczKQGwfQn5ZXTxPjmLx2yGIYEeRg
Message-ID: <CAAiTLFV-n3hdY3dUGSeEwfmAAgLE+tXBqZH2=eAU7EHiYorD+g@mail.gmail.com>
Subject: Re: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be
 followed by .pfn_mkwrite() for write faults
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6zkI5Ek9ndxj3pUayt_AWSenlc-1JKA7jdnETlHWGSQ_1785742224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Warning - DRM parts (i.e. most of the patches) untested; I have Cc'd
> the reporter to help with testing these patches.

Tested alongside with the mm fix [1], and it fixes the virtio-gpu
mapping issue [2] for both the absent PTE case and the pre-faulted
read-only PTE case.

Tested-by: Sergio Lopez <slp@redhat.com>

Thanks, Paolo.

[1] https://lore.kernel.org/kvm/CABgObfbkqYNsPQnKxK1_4adXF_tSdtScPU5-Xrg-sXyeWfMVfQ@mail.gmail.com/T/#t
[2] https://lore.kernel.org/kvm/299bddc0-fafc-48b3-a9c6-ec171136a46a@redhat.com/T/#t

