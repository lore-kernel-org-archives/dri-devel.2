Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F0606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDHAWkDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA31D10F419;
	Mon,  9 Nov 2026 17:00:20 +0000 (UTC)
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925FB10F444
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:00:14 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2ed3c66713cso3539965ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794243614; x=1794848414; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wxnu2gHDTAVcZYWFHFKD1h1xosiRimMJGhZuilr5Ql8=;
 b=zDHAWkDai/BmFVDxwfGJi1H+jG1q/TRMbLjglyFEzjj7viDclNOPSnBB4Yxfx1vZ2r
 rAv8oSeIgPaheFHhSnCbBIoUW6FGtNht5tbY/QFaxexuuFabd7yezvdfKmWhBaEDb/uu
 hdmaa28liT4oY2dl38UjW1l2hCTY1yeronFVs2z6rqQwoIfbQRZYAIm7wlYG8NCKRgNR
 h+Aso1c3AweXMZoob8kHLPnWJRcy/WhBWhTuR0ALFAFP1euaJys6j+kYkWgqPIvtC0dj
 RNEi56tRoztdLwTHBQihngUiiGHukNz3edK5EVAUtm8Yb9Y9RM1V/bFcNKfjDM4DeaRI
 Akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243614; x=1794848414;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxnu2gHDTAVcZYWFHFKD1h1xosiRimMJGhZuilr5Ql8=;
 b=lRFwWOo7bhP1Ti6zOIpQ097NEec5Eux+ThE/vK9JEgNX1KIAfOTYHOw/FwYAi0J/zp
 uWEjhS/lzP7RLa4XiQUbAYaL24+UVRPZ+D+r31vAQATjqsGT59uEi1sJc9AL+infob+r
 45QZUoy/39+g6E0Az1ifptxzywnPpmbHaubLuZcfy1zAJ8I9Y+XnH6Kcatg5dXedb2at
 zE9ZQ5h07PesLOLd3jcsdRmeh4i/6tyUtOCTIvxsatZGo6uQMy+04aQ5j6MdLQ7YvBFp
 hRjATVamY0M25qRNyJAX+EFaWnoZ0EVlduIasvpuablLU/5hoFXRY1/hktuklDeGT1uO
 mWDg==
X-Forwarded-Encrypted: i=1;
 AL+hErFkODPR38Bb/3NMqoDgUgCVazoRRd9MaYqOK9iz9qbwonyZxrYCSOrZdaf5FPH+pbQEfa5XrMh9PAk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9iBGu1yurrOXA2HCV8n7ctD6/leh7UmvJ7MKzkDwvhXg9K5DcX
 jLIhDVKjno4R8pfeniryyj4eSsVMaEw/UKkhzl5J+m1B0Oz4hioo3laz
X-Gm-Gg: AYBFou2t4kE4mUHNG8CHkYQNDz4pjjfqdKK1B5n1YX6U2sQDUp9B1jvKkmdAaVHI1Ue
 z5cwNMnCSROJgwPJ7yQEArBw1qxJJFKLZahflPtMH169nLu0gZCKDsBDdfpJTdKsOm46bOzyFrl
 m+uYbZ+XgCKIAEFC5fWDaxSQXmTfn+KjIIDyp/clkDsyM1OLx7h50U9Lr6iZsfEdSlg9i1G5vpH
 dpyak0M2eWBKTnx7ZJ5aSWsIPZOwzFPVviVQihe8Agzs0o5k2w9bnfpW+3kJABfMi1B7kkrGtyC
 Q5IIOGPCvsNwXnVDp2YF8gJWIez4YxRexcyUPkLBpbXRUT2B85ztxf5pfsS6+PWRgqBQSWxaBHZ
 KNpbK3loWG2jyzA8etdrcjhHNv3SyC9j6nhWpOW6BynPPoWPyu/Zhrpv9QGX4KFIpg5q5GaNWU4
 xLiMOcVG8lQvrrj8jS5dzyHpJ9crvqtnHufiMxx9FT2WnH7w4g3MBdiAcgH2YfJo/9jj6chZgfA
 eGDTty9dpDktjA1zorz4dEKnsTqde2mwcZwlNbyNJ+mPD34I+0qYmoZaJkG3eYRwuVQPArExEoV
 rbwy/MZ7GulNde9sZdA4iLPMEV22fam+p+pLjNrjxzkDINuko7JY83+53Vq360SYilmw2wl0aQY
 3kfHLr/J8U+GU7BC8e6A9LA+8gVGi5ddX
X-Received: by 2002:a17:902:e5cf:b0:2ed:3db6:2eb0 with SMTP id
 d9443c01a7336-2ed83784f45mr49805195ad.48.1794243613903; 
 Mon, 09 Nov 2026 09:00:13 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d7bb58sm325405ad.33.2026.11.09.08.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:00:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 10/22] drm/amdgpu: implement SVM initialization and
 lifecycle
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 03:59:27 +1100
Message-Id: <179424356769.208802.11801490347938606155.b4-reply@b4>
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <20261021025915.2433837-11-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-11-ray.huang@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ray,

On Wed, 21 Oct 2026 10:58:49 +0800 Huang Rui wrote:

> +	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
> +	    new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
> +		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PREFETCH;

I'm not sure about excluding SYSMEM here... The proposed libhsakmt
adaptation maps a CPU prefetch target to SYSMEM. If the pages are in
VRAM and the update fully covers an existing mapped SVM range, nothing
gets mapped or migrated eagerly. The GPU PTEs can be zapped, but the
pages stay in VRAM even though SET_ATTR can return success.

Is SYSMEM prefetch meant to move pages back to RAM, or only to set the
attribute for a later CPU fault?

Thanks,
Aveline Noir
