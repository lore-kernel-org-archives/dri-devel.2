Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD99606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOYkq54x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74CE10E673;
	Mon,  9 Nov 2026 05:55:03 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DD110E125
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:54:57 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-67be5d0e9cbso236852d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203696; x=1794808496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=winAjnnFK7Y5+8H4/MeMt4X+xjrCb4zSn0V/ZG3VdXA=;
 b=DOYkq54xeV6lZZ7w8LXvyyhmmNR9KYN/ONnYiwSoqluMYzUqoQ5jeiGBEd5TLjSmIC
 gq+kFGJ6j8P1qs51q5yOgN4oBKSFknu9sdBHnPcEuwE4SuOuaRm6/RlkWZsqrPW50/3k
 9aMCNWyoWHNuDhrUHkIBc08gpu9wrLfHYm1ea7YdKHSedYjUQn8079xi8maD/yJsbal7
 Z2ooDlkNZrnTVgewn7aS7WW9VEROmaKITJ9Q9gtoJAvsCeJhvQ3usZ+x2VUydo3rkbEB
 LmEQL+imdj5JYHLn8fNOnyN+k0uSsvUtriVPtFeh4+Ipv5+1zGODLop00uctVwoSI0eW
 xItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203696; x=1794808496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=winAjnnFK7Y5+8H4/MeMt4X+xjrCb4zSn0V/ZG3VdXA=;
 b=yZhxDB7ebDiH6MyjINZrLiSBGHYI8eRFkrE26Lyn+xGWBd2elWREcYwzadxKwudjdE
 1EZq8TVyHw1ItIdWkFLwLbrAd2tw3+yWxmZbjeJKWUvfequ4VhGsDKOg6+Ueu278APFU
 6kHaCL8IIquBC9zUDGIMvZ5XBH6PXaY3D5rC8MlT34YazlP94YAe8aEouO9N6hxxJSMb
 yqPn85lIOfLGuI7Ad7O2VDKK5l1QXgN007/6To63awOM4X1QOOtHQG37VPEtesrjYpn3
 Mgzxo4J2fzJfX63qS9+/o1EheJVTVYnh/FT3wpCVUEWVXYMYYcrV5JCAP4nqg5EMdFeC
 ZWWA==
X-Gm-Message-State: APuU4Z9J+iaTkf7H+yS8O2qKnlcy1syvaMIKV7epOzzrvBhn4yjF6Tzy
 w799IGEeYFGjvzrNKlpd6u1ZKupWj6Xtyjo5sckPPst1USF9FwjHOm/FZSCXUhC3
X-Gm-Gg: AYBFou1G5LRf6dYAlnBuCHufh1xaBXkAazTu+aznYvGfqY//r1d25HHlwIak7ZXlCqn
 vE4fXBr4SclfcIh0Q4DjyQrhxdd+ngYoCti5N3E8cw2iYttWjVCOrHPLMhqiYmpFk74Wsizjk4w
 H3Yncg24jAwrPAubojzlVMlJ90/C2ryE2hCt2oTc83ArizU5qzsQj9gJWW5ECs6wGLXRNZhKVTV
 HuYxOLx+A1GbP6DdPq8t3777ZxZtcSHeuqex8/mcKTQS2aKCkBPQBLQlHaTXi6h/LfvAigvKi/f
 D2/kPxCxlvyw7Obq6qEMoBIx6oPf5eUhFDuTlU2E507Yx7RO7ypCZ93LulK7nhbMnTk0pI+KJX/
 lvZMU/YkeadecyRef/ngasgF4s9FmYeSncxrwv+xVopEUZ4aiwY3N/ZnP5sB6zw9S2NfN8ZjUab
 0F6Nnze7l1ntGFp9WNTh/najJPEdHYxYj99Hq0JONt5RW7Y8gcrfuAwzh6h/SvKJWeNzRcHVxHq
 fx88Kq+dEpwt3XWA62BQFqdCM4Ufpbe1ft/gkkhjFVTIgISylu5zZFx7pM3K6fFdj2c+BBAyGcG
 p35S+AKx6DKVqvpnqIuXt80S4cP8vLRwGtfywRTnUqOEqW4uOGUiQfJLzcuCCBTnlxM=
X-Received: by 2002:a05:690e:4085:b0:677:a7ac:5624 with SMTP id
 956f58d0204a3-67c3d97b7f3mr1477356d50.44.1794203695931; 
 Sun, 08 Nov 2026 21:54:55 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:54:55 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH 0/6] drm/gma500: prepare GEM and MMU for 3D rendering and
 hybrid 2D
Date: Mon,  9 Nov 2026 02:54:44 -0300
Message-ID: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

These six patches prepare the existing gma500 GEM/MMU code for future
SGX535 3D and hybrid CPU/GPU 2D. They target Linux 7.4-rc2
(7475ea8b58616b33c04afb976cf0fbaad9dd63fb), enable neither acceleration path
and add no rendering ABI or command submission.

Display GTT and SGX page tables keep their existing, separate roles. The
series fixes sizing, unpin underflow and page-table cache-flush lifetime,
makes MMU insertion transactional and propagates setup/pin failures.
Review of the rollback and ownership assumptions would be appreciated.

Offline validation ran in Debian AArch64 userspace under PRoot: i386 LLVM19
W=1 full kernel link with HIGHMEM4G, plus native/UBSan CPU tests. All nine
MMU KUnit cases passed in a separate i386 QEMU TCG guest. Checkpatch reports
zero errors and one MAINTAINERS advisory on the already-covered test file.
Physical Mini12 testing has NOT been performed; display, suspend/removal
and SGX cache visibility remain unqualified. Historical GPU results do
not qualify this series.

Patch list:
  1. Use the common dumb-buffer size helper.
  2. Prevent GEM unpin underflow.
  3. Fix SGX page-table cache-flush mapping lifetime.
  4. Make MMU insertion checked and transactional.
  5. Propagate MMU setup and GEM pin failures.
  6. Add software-only MMU KUnit coverage.

Thanks,
Gabriel Gama
