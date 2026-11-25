Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69E606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKwcdpSQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D3F112133;
	Thu, 26 Nov 2026 08:11:10 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8303910FDD8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:20:27 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-38190551625so11948496eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795627227; x=1796232027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qz7iwpD+T7mmeMKXzktrMNh0w5s186HdlphGIpLEmgY=;
 b=EKwcdpSQZEtn8aMfwAa4cn5LxPELv/ZteRE1zxRB2z6Rdalo8VHA5EKwMnBHZPsMxI
 o8I414JBQzs4wuNr3oiVCRmPFqrXvgfbZ5yErb2kx3aEgosx/ReVhfjhwImehameVymC
 EAOsO6+tWzJQd4HITnuDk+SNvqHv0z2GSmMEfSQ8pMGCHPHmeBgFgmirykne+MgjzLdP
 wD/mC4ZDgYXMTDRqx6aibthufdLCOXaQlN4ePvLLjS6ShcU1uNAhw3QYKYQiLFO3RDDy
 o136FiDWwKob1JVo/e+DOzyFqDwSofSgrIcsYS1hdLVrWz43eaJrwuq3rjuZEPyQbxiY
 FX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795627227; x=1796232027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qz7iwpD+T7mmeMKXzktrMNh0w5s186HdlphGIpLEmgY=;
 b=pSOAz87MaYynHMXuIvnlUX5xfgn8qB+fP48xL4mvvFVx1W88TS+60vvFWeSqpMfxKk
 4kzsdTI2XeziuO8xojgKVfxN/DD+c0sLSvE2ESjgu8/mM3nVk3SVeKVOpFR/lXPoQKLw
 x/5DAQRR/wm9hLZICdbJQE10a6Dap3ln6mg9XRrIGG4hfPi/v46xZHiQiiLrmIAc+sR3
 rAm+3y80tDitArQ9TGdQHyReoLAv0YYOBjGNhhOhb+HxFk21JvflgoCxXZB9Bp0WtI+O
 5JbgVKXQr2PiBh7OKXHf/UdHOHDWVR6XOPjvZ9uTCMOkeYuoMgoNc5Me84YwBYWxwM0a
 K1bg==
X-Gm-Message-State: APuU4Z8ODlmxO/pZ6ugMvajAmBSYckZ7/gUZ7otwPa+oIjvbYjdbZhc6
 W6AUo0DCZRUdvCOeGeHrTLVl54N6wtDs4iKAFnP+/bmWDbJFzo/v+W/F
X-Gm-Gg: AZFdTZc9FtqMFp24axUYKmeZtFwnE92ZjuQHW1WTGZnCpOXu77m4LaGvkTIqZXGpC13
 wx4nOiStHnAhqnDMfxcSfLeOA2heFEgLSVrzzPgNvGwJwhAFnBJr4sF7oRrQIjo491eZ7dpETYp
 F5gh7ZaeoYK3Zrs/zt4PMaOaGqTAcRf2nv+NHxMw8ScROq4wxIDjvhveh9pzZ6Kf5TFYchcC1L+
 6xVxLn/c6NYPZhArcmEmvyQX8U4dMqeASkGFWC2gxcFvlyPwP2eE/cKfRyCEZNvDEsG361oiMEO
 G6GFI7YgNjSIHLusqa6dp9G37roMlbJmUIWm2ywghNSg8s82rkuSsoGqziEx/IzywcesAVBJMEx
 fQEnP3v1CrGjbPSpDlNNl2yU5Aif9ZaZgkc6IPzBqZNm3ZgKVQb+DifSQC7HuA2NRd5atQbVEGV
 IlmULhb9H80CImkMVCcQd8cjAYic4EPrnqeZYHcrQE+fvhg+HnWgO130UzPG450rlh+lJSK5+b5
 rS7giH8805SxFPtd9cMnETWp69/SeO2JFFq2+sBUX1KxFyD40x+r586/+iGaeOl7f6jh5gYc8BZ
 PUO+OovJYxWeIkOmbNp0
X-Received: by 2002:a05:693c:42da:b0:386:95e7:8497 with SMTP id
 5a478bee46e88-38695e790e1mr15040048eec.28.1795627226405; 
 Wed, 25 Nov 2026 09:20:26 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567daaf70sm57637757eec.28.2026.11.25.09.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:20:25 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] gpu: host1x: Document the get, put, mmap and munmap operations
Date: Wed, 25 Nov 2026 17:20:22 +0000
Message-ID: <20261125172022.2344949-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct host1x_bo_ops documents its pin and unpin operations but not the
four that take a reference on a bo and map it into the kernel address
space, so kernel-doc reports each of them as undescribed:

  include/linux/host1x.h:159 struct member 'get' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'put' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'mmap' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'munmap' not described in 'host1x_bo_ops'

Describe them from what the implementations do: get takes a reference and
returns the bo, put drops the reference, mmap maps the bo into the kernel
address space and returns the address, munmap unmaps the address that mmap
returned.

kernel-doc on the file prints eight warnings before the change and none
after it.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
kernel-doc on the file with and without the change.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 include/linux/host1x.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e7ba601b2afb..411a1c84eb61 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -146,8 +146,12 @@ static inline struct host1x_bo_mapping *to_host1x_bo_mapping(struct kref *ref)
 /**
  * struct host1x_bo_ops - operations implemented by a host1x_bo provider
  *
+ * @get: take a reference on the bo and return it.
+ * @put: drop a reference on the bo.
  * @pin: create a DMA mapping. Implementation must not touch the bo's refcount.
  * @unpin: destroy a DMA mapping. Implementation must not touch the bo's refcount.
+ * @mmap: map the bo into the kernel address space and return the address.
+ * @munmap: unmap the address @mmap returned.
  */
 struct host1x_bo_ops {
 	struct host1x_bo *(*get)(struct host1x_bo *bo);

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

