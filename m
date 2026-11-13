Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvLwmUzr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F80810E054;
	Fri, 13 Nov 2026 02:08:20 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C40010E6AF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:08:14 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b7bfefba55so873755a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794535693; cv=none;
 d=google.com; s=arc-20260327;
 b=PGhMjoKKoCXJWU/BPBNcWzUY3Nkl7GXx4g8xJ+4LB4tvcOaJkflLagjJc0BpUOQru9
 GG7NR02loyp+gaTMMM54rkzhBB+jtXDwaPiNL5c97f0sDNGJWNiccYhn00Vd8vJSV+tC
 y6xaJzqAhY2Lk0Ybjq1eJTFLIc8JTA6QgKNeqELWHgW0/WPSELW9ipMU+GB+haOJ+4sj
 WYEju805vql5AscbcmULuwKHIjxKiCBo96MwhJDO4rklmScssJocRc+V/mJ6mv8FrDVO
 v0SP7jsHiMs3aEy1+72PqGQ9yWU9Fg9u2theCtKOTihzsFK4Js6zQ7/8XwmiHo0KcdBY
 fuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aNvdaJwzrU7dKbL8hglaP0KiPMauObfmKP0USfT2P2w=;
 fh=iCiyZUXmDqUB/jMCp+gEzq/0tbFXElrDPwqYkOLmzro=;
 b=LBrGkUYQPV+HCH8eCvJUejivjqVffMsKsyA1M0hY74YoEvRhyeoN9ZIeEVexNlnBwC
 LVsg0tz1UU2eqFB07cwblkkS9FXQHqYwnMvoKnvPBX9PimmnQGz9RqR/rBi9GURi2IB+
 HjzKvnm/i6/QoU72gAv/C0pt+aVya59xXOPxC5TKK/sFWTZPNZZjaLCUJ+VZ7H2CvxTN
 D/LiQ+sdUdkMvomhB2iVgL+vmQvIchevoXXcJCWa65jtIXthpQ+slNS6snXoLmMRZi+w
 hHb6dZ7z5EzJ1fa6M+wnbvFUae9qTGTsz1dO7xsADssSq39wp26z96gd24oB89IMGqCd
 fW0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794535693; x=1795140493; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aNvdaJwzrU7dKbL8hglaP0KiPMauObfmKP0USfT2P2w=;
 b=uvLwmUzr66hlv6tdneLSLeu7Ur5DOCgKvx8DOW79YYIjpU9/82+P2G2gEVnAdRHQVM
 Nv36QVvyjI3tYooRF3NYYWSWwkMn+mCVss53Kq2osgU+6PJw8KF+GMCSEtrw9oC6/XIz
 rvebgaTW/27/ZM2W9R58MNNZ2v9P89YYTZuptOU+Hh5jfUuVqm50qqR1bATz9DmXfHv/
 r3E8nNy/ylQWMOmOFaKRgvL0BDAkimXB7ykyBvuXvTfyC07dDgc9zEQBOxJwEyY9IqEi
 ygaC3N7Ani5bRsRdR3VIBY3nQ4R4gLJYf2K6GXGxf4z9rF4gd2nD6rjnF4jQZTl2dIu/
 MkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794535693; x=1795140493;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aNvdaJwzrU7dKbL8hglaP0KiPMauObfmKP0USfT2P2w=;
 b=cDFb2jXyZwWc6C9+Rv6NjAbGFP4cBKeFFTWU9UfJihgcSHLGKacgWCSfZrwLaiTwmU
 GWLUfR0YkikP/mZCjdA8lRXSuq1JRL7cYbpSf5r/QqxqWZnHhE28qVTc09ddtHnZqZ1Q
 +A3u5qG6dholuZnKGelXmZERznoRxiVocitV2KVXRYjJSLTFv9Ib8xTQe69F2m7dEae5
 nQCL/6/I+ZXuHzkY56BGwkHN7doA9DgDXPXCFySLHo1gkiUZlqouJyYqrGqtM/Cribv7
 FPoe4wBVIbdgM+5gazN1O/WIStrJ1lNgCKUz8ENVJfs87YzosrmPMTJbS/Ui2OP09lyY
 mCBQ==
X-Gm-Message-State: APuU4Z/Sz5U8ng0GHQlJ4T8ztHm4jGRFnJHBZ9wyTIDHMCXkpIQWR+S1
 Ola2sR06WYCaaiV7ebKv8+n2lqoyzKVLu9B6TdUhK3uwx2bgT4Yv8cxPhUU5mbJw72paOAtT2JB
 G6xsIfoL5fssBZkz9P97WrT2N3vScLK4=
X-Gm-Gg: AYBFou1d/hn6Bi6kXvA6GIQ3uztOBMKP0tyH+DF3aDiK+kHfH7F0KgRDE/yyNg+Hmlm
 RMNLAgvKAKpasOoV6aNX/fZiVGa2eb9Q8+mRZ/YVQkP6ZyA8Qic9XT6bkzYqeZT6Ai4jJu/rxNH
 QwkfAhYXS8iMMM3yMscb4lkb5D9dJ3GDDUdvzsLWkKMgqntoaclLDg9cPMjHDmzV9QqElYnGK9O
 jlFEzRTcJU3b+ydY5ELK7UUOfUKithB/TUSYQ2RoBvsAU8qSwzZnIPVSffG0/Y7nBHxNUszmHUn
 +xhWGeeY155fdWBe60cEJY3K7G1hstVz9iPVkbKfMLCVR8wz62EsV4gDfAgCrdncXbvnuF7MoM/
 R5MgPJmtWZhp0OyrcTZMbcCaiDpVBgM+HvnYgK7338RsmBdglQDGSUrCB1rSBlTSHWI96M8o=
X-Received: by 2002:a05:6402:1f82:b0:6b4:21f6:ff48 with SMTP id
 4fb4d7f45d1cf-6b7c08adce2mr1021917a12.3.1794535692714; Thu, 12 Nov 2026
 18:08:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-2-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-2-c69b84bac011@telaak.dev>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Thu, 12 Nov 2026 23:08:01 -0300
X-Gm-Features: AclHuK_17nK0vdrM7hFH-08XQ5C2OxqtJhKel7UqIVpBLviQdlvTl_RWXYPiYVU
Message-ID: <CAFGNeagBWpdG7a9A-c6WRiPsd4oPXcWai9o=xnkZDyY+axcniw@mail.gmail.com>
Subject: Re: [PATCH RFC 02/13] drm/gma500: Publish the Cedarview SGX as an
 auxiliary device
To: Joseph Telaak <joseph@telaak.dev>
Cc: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Joseph, I noticed that gma_sgx_set_irq_handler() updates sgx_data
before publishing the new handler pointer.
During unregister, could an in-flight IRQ still be using the previous
handler while sgx_data is being changed?
Would it make sense to clear the handler first, call
synchronize_irq(), and only then clear sgx_data?

Otherwise, the auxiliary-device approach looks interesting, especially
for keeping the display and render responsibilities separate

ty,
gabriel
