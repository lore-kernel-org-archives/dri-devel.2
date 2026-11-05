Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FE606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEK4LZOH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FA6112C1F;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A3011249F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:26:35 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-55651e7de9bso1029652b6e.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888795; cv=none;
 d=google.com; s=arc-20260327;
 b=rQ/XhN0YpziWKA4IMuJMTmuE9iFIv2jXeH29qx1bFCrt/7mQc3XtbND/C1LZVy2MP1
 xaPzpv08lYUBUn5nB5If/p2huvCC7sPRNOTABtuXCMoutOewFfCxtgY949DVEZCgSVLa
 MXfC6SfriSRGml4QxPc3UXfXpDNHFL1qCh1YrKDbyZgTuph1Eg6TsrzJ25i5iPJ8pC+a
 FRQM1gR3xaXnhB1gxVZfSyB8d2rZNAcAjlSwXwTxy6RGykiWMw5WSts9QjWWY1zJWGl+
 pWFxdh/hDkF6H1voR9Fbof6MpxmiCUzelJF/WgYsYfeeu5J9aRFwczwwsFgGOdAX37xM
 o7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=xUchQ5Xm1iZNw7GbdiPnDVwqy30Ug/2vGTaSDMO7KX8=;
 fh=Iau+EWBB6sxoEbWA1ubK3DpfAU7RSEEXRLYOe1z5qNQ=;
 b=eaV0VEL02MX6A0WQlSb/bk3A9ibSmJeHyYSVIhicFhurjXeGzhrzIfpUlMGVYj0Qon
 Gcbh8ZF/vX9G2p1WnNqjOv7PVxxysZl0opqyqv1VyZf6HPFm83wVLvS5FqA8K858Mhns
 1xEkeCWWoXVO3yKjlpKudr5Z2pNZGT2gXlAp0xpi/CU8nzmYSt6KZeaVtkxqNk4urq/e
 geJsFpBRT4ypd5PcI7SIljqDyoHrhr2lSy8AcwlnZKaW4oxeBE61v/MqDjxoehCjGsMH
 xwl9dVlwDkS7A05fVDWaIPK0riXH7ccUofvbXnAsrSq3/nime4Im2M2+uM1FOZ8Tq9WB
 hXjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793888795; x=1794493595; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xUchQ5Xm1iZNw7GbdiPnDVwqy30Ug/2vGTaSDMO7KX8=;
 b=vEK4LZOHwSa/uKgMyoHQot1YxAESOnhAi8D5qft+TOgQ9l9Eh+rJbIcF1Yi88g8xO+
 3tEK9BpkxKLdXy/a5lBiR2cAJ0FQ0NAc4MHtMZZP7hm3Ys5gYdeCxUSAZgQ5nv3i5TuV
 5Gflo21HEETTBPrkha+/WNaF1DrI0VdeuRO/fJMJTUhNS1kPcE89RCJ+trsNMvNnBynB
 1jgtt9NZCe4uUmMr5cdchO8tRY10wzcKDybAnWCuw5/JRj7+3XRjoK66032VAWA9jqdk
 ABahI8dBefbHgbKbjRJtWaiJ9jN3KdOHqo/5huiSX/B7St+jSv5Naeeo2dAlbuan6oCx
 xMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888795; x=1794493595;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUchQ5Xm1iZNw7GbdiPnDVwqy30Ug/2vGTaSDMO7KX8=;
 b=AoaGx2iA8nBZCawlOsuif5+gI4VR55LjkgF5XFgPZ5i3tcw2IgGMtwXE4LSBY4mzWC
 YXptrqGaoUdG1n+JV2dQih45kIhq6oI03XBUJYPIx8XCPPc1Ff4Ckj2rcZdgBbU3myNP
 V1ERHJiskX6LRW1TAa083H6YnRbpv8OPLrhfHj7ut5OudKmA88EpyqjzsXrVAK/+78AG
 snmX7XMxVvwJTsSl+9Uxhy8fKyipzO/Zlzn9VnjEWKaLy5wnu/mQ+2JZQmEzvYAH6sFk
 V3RGAkyIghltSgqU02IJDNqYgL4RZoKM9LgOW1u99DhlMmKpNyHaMuPfn/rNVQIAHGur
 wJWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQAxgmWrEvhm2DyhtEuYQ598NlO54LR4V6CIx5gIUicym7jbHb6XsEBbh7bz6E39ZpoiMZx7VW0C0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8v6xw+ufU2UEq4/sqfEfjeosxLhN0+5kzs/MIbBh/aqudhMMrv
 NPp1URc+az4GaF3SSv7fR5iyeTLnLV3BjSbOnLK5I1nhhHAohZ899Ls3cFA0esNQuuEnsmp8Hsf
 1NAk7xEldWPuZCUP9gPFUBuohIP9zqB0uDtRgS1s=
X-Gm-Gg: AYBFou0J/haGvYMRRKiifA8zmnucx2PNrc3SpnvxP/MfwxD0sWC+GghlSo5gUOYd0jh
 6NyNZHZPimxCgCBmaSQGYQ+4OJ4M7YTeVhMdxZu9rzO6tLbeGiPqDqxR29XZR5to534IC6C4q4O
 b/qIl75ZP6nA9bCzhCyOA+k517w5QpHR5NoCgDEBtD6YkphUR7q1Vpp/zO1VcigKNqZvRejTMKg
 isrO+lWPhLIRCaDjQAxu14Zx3Q5gzKV6MsLsz07zT1S98Je7BwrIrK56bW8F8oaeY0mUpgCDVZh
 TVVu2lfvLu9Gn+GuCDCj0gbk3B+ib3RmpG4gELG/uzDLBw5DpnsM4pBYTlbBtJCN2AID7FjPKCP
 KMvN2mPK7fQnXBQ3+vkcKvmrYacKE9IVpbT2lpa6hfvpdlw2NQfVIMS/cxRRyYps+MztqNj0=
X-Received: by 2002:a05:6808:6505:b0:4f3:68d6:f0dd with SMTP id
 5614622812f47-5640de6b8e7mr14101342b6e.38.1793888794825; Thu, 05 Nov 2026
 06:26:34 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 5 Nov 2026 06:26:34 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 5 Nov 2026 06:26:34 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
In-Reply-To: <e70e62f1-08bc-42cd-9cf8-62ce54cc8be6@amd.com>
References: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
 <e70e62f1-08bc-42cd-9cf8-62ce54cc8be6@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 06:26:34 -0800
X-Gm-Features: AclHuK9A_X6NUn00AQrkewf_ZnXh0w0bvv5O92l_7rClcd8nF6ebhUWqPH1wjAo
Message-ID: <CADZg-m1y481=uwjDX2Ue7SSmtJDt=vOP8goaJ8C0ccbqBctzfg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/sw_sync: Avoid taking references to released
 fences
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDg8aSw4LCtm5pZw==?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, syzkaller-bugs@googlegroups.com, 
 syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review.

I have sent v4 with a code comment explaining that the timeline lock
serializes with timeline_fence_release(), keeping the sync point allocated
while dma_fence_get_rcu() examines its reference count. The zero-reference
case now leaves list and rb-tree removal to timeline_fence_release(), and
the Fixes tag has been dropped.

Regards,
Kirtikumar
