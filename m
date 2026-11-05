Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EA606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=reznichenko.net header.i=@reznichenko.net header.a=rsa-sha256 header.s=google header.b=NUan+zSE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B35610E17C;
	Thu,  5 Nov 2026 03:49:23 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F2ED10E17C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:49:17 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cdac6d19ddaso670172a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 19:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1793850557; x=1794455357;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FTQt/DKzExkg2Hajv9Ngnf1BFMIHptWE7Rva4W1+tQA=;
 b=NUan+zSEfI5vcyoWV2Q3gLup5DNEBCNHRethh+AKBSIktxYdaoCTdtSP/YwIxxY8Kf
 i3V2IfixAc3OjCec84/I/nPFK4TdBYLf6cMZHo+vv7mIc1eDPf69Ng20Z382ZT6FzfkC
 8mD40RZ6SoNp4yWIhFgEJ6i89dhMeKx5R+X/9D0pfpfx+s/gcVt8WfrYPhIZLNvHl3H1
 +iK3W1dKmORhqnPaL2St4N/6DU1W+kbRpLlUZC2E0JCwKGAyCGvzhqRon/p1QQ3IFLto
 OarsMa0BtMUhsDFgA8RQP1LlBZvMYp/kcV9EwxJhF6n7wJW/z0BBGnoCY4MW6ehjr3VX
 LwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793850557; x=1794455357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FTQt/DKzExkg2Hajv9Ngnf1BFMIHptWE7Rva4W1+tQA=;
 b=e0l8gJKgps3b8K83jPwkfAGALKbAGKCNVDyuL4bKNWDdJv9BhajjFvtwgkL+If933Z
 jlWfuAX/iT6QJAJmdXzCXdWvLX8nnVJUZohMNkWze4rsCBIeAJfSNuJQIU95na4AOiBV
 QGgaahtLLSgNOFcejyA6nwu5Mu8Owz9WxkvC9AztCIXmOU7xOKgTQmzuVF6YdBB1kNK5
 U2x1OUOPyLRVA9kOzt/skKXd5CiVYNiPZisN+GUlL0T22tGcICExUv4d6SBDxsBitult
 F3i6TQa57Km4GwZMd4+Qto9p0+NVtDGpew6AIGOPWb/4X2b4QjxZIUiApTubP/qN3Sp/
 AZxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByTjtid831Jiz24SlMTuOtc/FomSwDIsWpNE/2MhiHu5D/NI33snGwu1mS/kVQveERGL6CnMAheRcU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HgBpwg4maUXtHi5BM5HxKIqFWeZkuG2BYYSlFS7ALE9UyifGb
 7h8NQZ1Bb0j4WU3+ypKj4w0Yrrxpd6SNvW5mSjYFOZXl2KFn8QjZfp1Zbcmb56+Bigo=
X-Gm-Gg: AYBFou2KAk4/pSPlF110Ku2BeY2Hcw4KDwdzgeKsusWIg9WSNbePkgLciixzX250Xun
 Q25u71CoB2VkPdOkOSOAZKl8AcDVUe36h9SNG2sVZwhlkDak7ecoEfFYQiEL4ZPBxL0QUUqH14O
 u2G/XBvE1nE9aoERNNrvokJPIMO9mnzRkg7WAt9+ONtpCsEPo9ZZ/KklSvl3Q0KNdv8EsFsMMB9
 /sfxd9hyOtL0CtPPOCkdFU72s1JcYCG+Uw7D0rq/DBhkOyx+7mfyJG1ogqSvsga7LA/nr+FNj0A
 t3T1yxZ81XqTTDbJcZPcPSmk+4nFaWpTN94z5mE5kZB+uN5Tbd5xOGP5pZkvR90wHd8YYTbTHHP
 jfXhVY029wMues9BuFanU8vSuQvv7k/lfSp+0ezUvR5DjR6nkhQfQtDGfob2WGJXo70YB1aZXYF
 y+MBwog93gRXVM3D15bhEC/TUZ4477XBWIoJq5QOOrz/ZXtSO2nDYn/7EVP3i65/5M+LO68yQhx
 NNPZyIdZDZCmTJ4b/46tmVvJa67v1Rk+huRP32JLTvy60BqoaIaKH9QskMYzde9Nx7y05oPbXwi
 AGJOo01VSivXYoLM7cjxOxIjQW/VS/V3HqOOHAcPsg==
X-Received: by 2002:a17:90b:540b:b0:3ad:eb15:aed9 with SMTP id
 98e67ed59e1d1-3ae8957cffdmr14128129a91.9.1793850556806; 
 Wed, 04 Nov 2026 19:49:16 -0800 (PST)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b094ce9f65sm3564391a91.1.2026.11.04.19.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 19:49:16 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: romain.tisserand@gmail.com
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, igor@reznichenko.net,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 2/4] dt-bindings: display: panel: ilitek,
 ili9488: make the port optional
Date: Wed,  4 Nov 2026 19:49:13 -0800
Message-ID: <20261105034913.25463-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103110524.2812831-3-romain.tisserand@gmail.com>
References: <20261103110524.2812831-3-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
