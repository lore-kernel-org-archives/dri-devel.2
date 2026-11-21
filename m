Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D53606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rk9DGLtZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C42810E5FF;
	Sun, 22 Nov 2026 17:13:43 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B1910E008
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 03:02:54 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-38587f3de36so1820187eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795230173; x=1795834973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Guzi9+/70idztYEfgK/lQL3nqGfBTC47et0quiLCDzQ=;
 b=rk9DGLtZHBMcnfKJGS/kFnWyV4bYn4nTV1+DrQ1BpjPyQ2jVXikKflaEkV6onVJVcI
 HDmqTZ/KLeFmt6jC3GjWI7isAKRGRIicPAqbpVxDE60632Trnh09m0FtI35ysEI4a7Un
 VP3Ns2xh+59K0O3ySwGPkHohWc2FsU5UoVEpjcwTFEuu6RRJCnfCntQIrQjO3/mPWa7m
 DCRvxAWCrnUbGmT7hA0lhjFDpnozXD+YM7UEX5/D96tbpyPzeotrkE1gv1bD3Le4Tw6S
 ifweeOcxnPDJuOOEGYrv64MWacopGSiDWZK2s1bMcn9CNxLh6h3e/Vv3RXCqZ2+at4fI
 58GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795230173; x=1795834973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Guzi9+/70idztYEfgK/lQL3nqGfBTC47et0quiLCDzQ=;
 b=MdW6b6lP1lp3rack6NzbLixMVu0oakSvBG/FmxDEkcneA8Icw2OoIHXlyVjK2IkAR7
 cjNcNqP6xlKXwBJVVM+PQmcKUtbtk3Dhf8MgoeWCH6i68GOhXydI9fjPosiR7t+pC2p7
 G9mzFycrh1dmdWxZ2eoE+CmE7gIO71IPwfHpfyyyYpOetQsD9iq+Km8+WSL/SUArCBDc
 sqhLUZu0mqxg4own5hE9g6aPtSSIniscGaHlVyUgOTdVSPMvNR/pbUf4x2+plRQbtCyG
 NACuK3UycJtgEU6y6DwM4AN7cUuYMR5J6V+FxzxNn8e0yeQsBazBDBVin+3H9f6XgS61
 bKNA==
X-Forwarded-Encrypted: i=1;
 AL+hErHHpLq+aY8Y5lJxKqzotV4zqoaTcfUH6GvBI7E875G/CyglzXIuNlBCrPWoJxWCOYuKaCcdjhqzmeY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96zWXx7KbO2KBLGaUm+F5gapjnGYSeVteLy6R2ijCbB3mpR7HT
 PoxBVGkZhxC5TDMxG3EjreI/fLuYYmCU0IB85Svnewa/Eo1mzB95++nX
X-Gm-Gg: AZFdTZfwXUCM9Bx6Lg+SSC/xMWCEdPLnctTJ4Q4Dtr71EtuKS7c+uHswDrcCWgyTuGx
 +W3KiXsGFUnZf87oM3gKOmStfCvGHMDEWalJ3WgLOaOSoQcCkSebpRi0kXZi32PwjPDnk+GSiFM
 qqSZ7BVImlh9ndD6lJ/Zjg0mZOWLi/JtWCt0U5wLbbGj40/clGceYvKAmILSO+3dtSFjjA+tPLM
 kTfLY4J+z0NxOt0d2Ux/4wu2JwCh8QszS3O1/AK6CI49YbE4lVXkYeUXR1FfMdpUbz52gHnMwlt
 IViIKnsQZmM6MDQE0AVZ+8YbIPvNzkQzIPDT7qotrDRg5itRn7tix0lBLp+NVaQFODU3tNqmR03
 54aB4ufMT4XIfaF1Xp1aq1Fijiut1Kr+k5d7JZZsUYqwkzCXJlx5Qk1wgMM7vCjDzwM0Bq6oPyj
 rXScU/oL3qipbY3N1K8ZXefZi32NLurCc1ezescCQhainn9Q1SdU5CU2wXbwT6E2ltFaFZ/RTUv
 pjBGqykGiE3T/EJ6SaxueDBiEUG3Joy3mEuyCv9FGTVIc5h8nvL+6Q+OkEION9mgj6xXd6kaXi+
 u+DaEGHHx/cGtiNrK1J7
X-Received: by 2002:a05:7301:1806:b0:381:4b4b:f96c with SMTP id
 5a478bee46e88-38570450b07mr5162511eec.34.1795230173484; 
 Fri, 20 Nov 2026 19:02:53 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm11651970eec.0.2026.11.20.19.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 19:02:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Candice Li <candice.li@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Document parse_psp_v1_bin_descriptor
Date: Sat, 21 Nov 2026 03:02:50 +0000
Message-ID: <20261121030250.1674303-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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

The kernel-doc comment of parse_psp_v1_bin_descriptor says what the
function does but names neither of its two parameters and does not
describe its return value, so kernel-doc reports:

  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'desc' not described in 'parse_psp_v1_bin_descriptor'
  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'hdr' not described in 'parse_psp_v1_bin_descriptor'

Describe both parameters and the return value.  kernel-doc prints each of
these warnings twice, so the file goes from four warning lines to none, and
from six to none with -Wall.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
kernel-doc on the file with and without the change.

Fixes: 581ada8f9bf3 ("drm/amdgpu: factor PSP v1.0 firmware bin descriptor parsing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608210800.S15sl61g-lkp@intel.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 82a2684dbd2e..3fd93cb1e634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4435,6 +4435,9 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 /**
  * parse_psp_v1_bin_descriptor - Populate struct psp_bin_desc from a
  * v1.0 PSP firmware header (standalone images such as ASD or TOC).
+ * @desc: the descriptor to populate
+ * @hdr: the firmware header to read
+ * Return: 0 on success, -EINVAL if either argument is NULL.
  */
 static int parse_psp_v1_bin_descriptor(struct psp_bin_desc *desc,
 					const struct psp_firmware_header_v1_0 *hdr)

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

