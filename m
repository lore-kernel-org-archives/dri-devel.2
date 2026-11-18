Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10766606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASrpcuCE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3E110ECED;
	Wed, 18 Nov 2026 22:35:46 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3D910ECED
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:35:39 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-93f3c616c84so135005285a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795041338; cv=none;
 d=google.com; s=arc-20260327;
 b=alAOTuJhY2I0WbkT7ohL2Mr9ig6D2b/XCcB3EFfHgKJm2xgzjmWbXsz/sJlmvnp5Tu
 8vrV4VzaX8JLXI+4WviKNViyQtqgPpX4+ZNu4jPoCRl+M7r7Eczq0evDpu3Ll9BTZVXI
 Pel1C73DL5+zDPNMOYkpPoIRm1Q3liKh5qSI8WrU7pAau+FCYWZhnnL/mxRce2erINbA
 PJ9kAHT56lyaM4Dwv19de3ASPRa1sRgrC3LoEXoZD7KQttISMNuJmOLZGNGIJ8/nXgu/
 bAqAp3IMfzsR+xY4LZKrcprZA/Xs5sra9PyqE+en3enjVBvlnQ7C+MMtVLyNE/D9WElz
 N9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=023EV3UmscqrU+3CKH4pWC/ZjtyGVf4mSMvlqbUYUjk=;
 fh=P+rs1+mAQpdo5uNkvvevGuYU+t3vCnOSVvPNFO/pbrA=;
 b=ENkun06KziTKymde4zygLmurEbjiA+iCoGX06xXq6Rj+4vVLwmQsYqymremqZMEK7i
 C5xC7pkVUntijpdpsVbCrCbiXJva5GxyPhNr8xDp1RYs5OzDTeYCm0NHtWPE2Nz4BIhf
 n2oOr11TxVkWxcvbBqjIpqR78klWr4pHCZC5ab4qAhMJzngIXJy+ujA4xk/3KWo6cRSR
 fjBc1LydkdWAGj3mU18aCKGq4UlM3NHoiPpWJ8YgVKfsoS94URfZQL6/oaiA+9/HwN6a
 62syhuIGzt6s9WcfIRF9YJbyd+L+M0RRAVtMTMbvFaGIyySZ2G4wwQ1gD9K+w1T/DOFn
 wv/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795041338; x=1795646138; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=023EV3UmscqrU+3CKH4pWC/ZjtyGVf4mSMvlqbUYUjk=;
 b=ASrpcuCEgO1oa2vIT2fGDkRU62Kh3JvuKBos+WwNTH+1Hvbh60DVOE7/okgN1X2ts8
 wfj9LkZExDZ3X+7PCkR/ljAE3nv7OCSzZ+VOJrxSYjVSuS/eO8gmapQOB02SsbNGygaC
 Y8mafBX6Kt5pGde6/wb/VtW7nYpLIfg5dZvwHQvG4iMAWQB8pWuOua30RrQhF6fE9ict
 xq0H0ooAxJsPKBnftE3RrrwO+fyvXQsA/aBMEeB9HiK1czABIXLzaQuTtPaA0WmBhc/B
 FWEwW0Vd8CxrGW8/waW0gLD+3j8nWZxN+To88EGXq6ZY4/UmIqalT1B4DVQMCJHwpd+4
 m2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795041338; x=1795646138;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=023EV3UmscqrU+3CKH4pWC/ZjtyGVf4mSMvlqbUYUjk=;
 b=QI2GtA8tFWh2W1lhPzJbDXem4sTLOns6DMPOIVOaZboDyL0AbrBDLw3C9epL23v1gt
 MiSMUndn5L93pWD+C+206v00vbowNB2Rdm3DAHrQFbn339qv4ub1JyLuL5LzX8S2a77d
 Rc5W6Aghrw5m5c/VvSa+CoOJ4Wyh5nd9VST7LrePTkCCITxi9pJnwWb1/7e8tuqdnpZR
 YhaL+joJrRHb1kU1wjejGAItAxIPyR5qTymG8RMGpcPVvSZYbE/OgXh9DoKJYJQfkfNP
 cEiGHxl7H9nolX33w+sNtk4oQeRUpKAhoOICdxmG47Yg1xVP63laXU+A6eRGq3z2I9gV
 mMyg==
X-Forwarded-Encrypted: i=1;
 AL+hErEscYGgl8SN2IukVM2KbNG9XjxsJOJmS7MEb22+uDpaQwXRRmitcTWE4r8TZu58hybrwjREOZbZuvg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Xllg2zNDQ4K5TOGUwbQqSdW1jyasRWnJCgAxRaq1z0TwnfGn7
 v33tq2B9+Lzu3cMOApAnmpQNAvFFdPETo/ZDtevNGEr7lqVfGURRtfOL3KtqR57ut9b+8j992gF
 v+4B2FiKOIReVp1s6fjR19OnLqXjmrTI=
X-Gm-Gg: AYBFou3Shq/rb2mlitTTomRbOtuYNmQQPZ2RoKqJkB2/vHMQaYxq1QN0PdZiGe0te98
 k1QdJIrCsdgVhljGT+q3phJuK+N9faJ3dnoJF+n5a3GDlXW9ECdHooVmkQlItozVHYtP3FePsXG
 AG4gPtK9btRnBrhys+Qx4BrHdJ0F/ciGI6YWuKijz0Ez+XcNDXMctTYfOJdGehG2xfoiRHlDSM3
 nE2tMmoZdkUb9jlUrfjK/ybwcKwHLcWRo9uA3/6znHdkJvED7UYfqJgPKyt5+8kQIzYp37Kj9Z6
 TbZ18H0JEYJ3e8irEyC6yb76bLWub9wmIwkiNKNVuvrupqoxd6+3+t8YnIPcUsbU7Ec5hI/bYma
 aCKR10E512Rq9yAAUgUAjMPUiWuvVr6pDbFuGk6lGfsrwlrg9M1R/tG5QGfBFBgmw1/D8nYAw0Y
 PvjKmsDpTTh8UKHv8b5ahTCw==
X-Received: by 2002:a05:620a:8388:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-949996075d7mr688897285a.70.1795041338269; Wed, 18 Nov 2026
 14:35:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 19 Nov 2026 08:35:26 +1000
X-Gm-Features: AclHuK9S7MBiqC4XDYhBqJgsIJRtApfI62TZ3NiNQFPjGFLLLvtd6Ud3s9pP4tA
Message-ID: <CAPM=9twShVfc2XGzi2EcSKAxuCE1TN2Unf_Dv_ey0z8nH+BxBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/nouveau: fix instmem io_mapping faults and
 slowdowns
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Mary Guillemard <mary@mary.zone>, nouveau@lists.freedesktop.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to drm-misc-fixes with stable cc.

Dave.

On Wed, 18 Nov 2026 at 07:44, Mohamed Ahmed
<mohamedahmedegypt2001@gmail.com> wrote:
>
> After the instmem io_mapping commit, some people noticed that some VK CTS
> tests became much, much slower, while others started running into apps
> MMU faulting. This was because of two issues that combine together.
>
> A synchronous VM_BIND waits for its job with an interruptible wait and
> ignores the result. On a signal, the ioctl returns 0 before the page
> tables are written. Userspace can then use the new mappings, and the
> channel takes an MMU fault. This was an old pre-existing bug.
>
> On the GSP path, the BAR code keeps an ioremap() of the first page of
> BAR2 to flush BAR2 writes with a read while flushFBZero is not mapped.
> The instmem io_mapping covers all of BAR2 and overlaps it. However, PAT
> gives the new mapping the type of the older mapping it overlaps,
> uncached-minus, so instmem was now uncached without write-combining and
> bind jobs became much slower. This is what caused the slowdowns, and the
> slowdowns in turn made it easier to hit the pre-existing VM_BIND bug.
>
> Patch 1 fixes the faults. A synchronous VM_BIND now waits uninterruptibly
> for its job.
>
> Patch 2 takes the flush pointer from the io_mapping which allows us to
> skip the ioremap entirely. Nothing maps BAR2 before instmem does, so the
> io_mapping is write-combined again.
>
> Patch 3 sizes the io_mapping to the part of BAR2 that the driver uses.
> This is technically not required, but this matches OpenRM and makes more
> sense. It also guarantees that a similar issue can't happen again if
> something changes in the upper half.
>
> Mohamed Ahmed (3):
>   drm/nouveau: do not return early from a synchronous VM_BIND
>   drm/nouveau/bar: take the GSP-RM flush pointer from the BAR2
>     io_mapping
>   drm/nouveau/instmem: map only the part of BAR2 that is used
>
>  drivers/gpu/drm/nouveau/nouveau_sched.c       |  6 +++-
>  .../gpu/drm/nouveau/nvkm/subdev/bar/gf100.c   |  6 ++++
>  .../gpu/drm/nouveau/nvkm/subdev/bar/priv.h    |  1 +
>  .../drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c | 32 ++++++++++++++-----
>  .../drm/nouveau/nvkm/subdev/instmem/nv50.c    | 19 ++++++++---
>  .../drm/nouveau/nvkm/subdev/instmem/priv.h    |  3 ++
>  6 files changed, 53 insertions(+), 14 deletions(-)
>
> --
> 2.56.1
>
