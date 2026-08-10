Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EDFC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914BD10E790;
	Mon, 10 Aug 2026 09:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bAEDhDV0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226DB10E792
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:55:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EB3FD600AB;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982E0C2BCF6;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786355742;
 bh=2WMyjEaVRWK9jzyFpbiOhg17MMA4q2ioAFM/71Fd02w=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=bAEDhDV0o+EJhp8ewhRMzIjXhcZfhRTFPbhUeBRq3xnCVM2dwuevPGYiif3eL/d5N
 xo+iShOm2mxtN+h+IfJr4R8LrDV1BuKi7oFJiaGQv38kcyV0x1wy5RGTS/6t/Fk7W2
 YFpnJQ1nlYXj2loC3EKS4arw4Ix8fr56VRJG3jNC1RUNigQU6tynwDGH8Y8VCGbDMA
 1vYqS+Urn+/KT+kRqTcZxsy+AURA322NmYpmtGQ9WAuQir6wlMx+WNiz1w1N0uCFju
 3TOHcPmedKhhoIDQizgLDDHwo6VDhdT3XLiKaYHlBdjWraovFSHMN/C2nTYyhUCpi6
 V0sbwpIgcE0Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 70CBCC5AD7B;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/2] Pixel 3 display fixes
Date: Mon, 10 Aug 2026 11:55:36 +0200
Message-Id: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhSEyquvIdh0ZapjCGFtEBQw
 t1tce/yJe+/v0GkwBThVmwQaOHIg08gTwXYTvsnIbeJQQpZiauo0fGKpp+pZ084ak89aieNsnW
 lnGwhDcdAyTqij+bHcTYvslMuZaPjOA3hfbwuZfb+HiwlCiTlLroyZEqn77zydLYfaPZ9/wLcj
 S7cxAAAAA==
X-Change-ID: 20260809-fix-blueline-panel-af2b7c967f2d
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=2WMyjEaVRWK9jzyFpbiOhg17MMA4q2ioAFM/71Fd02w=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqeaAcrio9jDiP0gaEDmcuCh6XUgMthbgEL81Ki
 3rJH0m1NtSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCanmgHAAKCRBgAj/E00kg
 con2D/99ET7GvwS5+RNu56YgtPQ7tQKhvdLgx3uBSYOjlcI4zTJJjBXxUpKfp38icet2FoR4FbV
 tUjjnR5n/zkpEvnqNghH4VRwmzlgKfvnQPOc2PdPVh01kswsnqgTLGafVnN5FaC/29nL+sD1ctE
 FmQ8m5aH7P/BglugOiprm/XZcPg+e48mZpgct47ZyNVfyDIvuZJhRuflGAJRf5DLJFmEuZrGqxy
 Awj4VkfdGW6xtJGFXnN5w8RrYdQFdgj68sKYxZVTJyElIAaZfx59nnCRhITBYWkKo4ZD0Vm04XS
 IYFQl2yTaTxXa8TmCeNp5jOK9jrJaTT6D9RiSvwy0M1RqUgzMGjlqBUMqzUmO6lyZBWKrhmCUOB
 Ne42n5/mWQLbiWHxZMkuzDSxcF+HgeJ5ni3PKnxNsi+dvVhHExrhcmJOZPjBXSq64OMVOK0wNK7
 a/cjMhnnE09oTEDgWHzXP6yiBuyuPytTDYasSKZ6ac8dnJzg+i7Q0y7wfXztXIjhdkFY2/R/wfC
 iU+J4vf+C23na3J0SF1EFydgGAGua80ju2JkDKX6sb2wuxw95rwTUjd9thdUewqUM309Jt6KkFN
 6ZI7zHa3aCV9LdCq+deroLLyzvnZRe8twoI57pBjLJQMFWFquXjgGklJLOV//NwxEZc7nlN9DjD
 ttNeuuR78/n+hmw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Fix panel not recovering after unprepare and backlight intensity.

I extensively reproduced the vendor bootloader sequence, but after the
boot isn't possible to do the full initialization of the display (at
least on Pixel 3, and panel can't be found anywhere else).

The downstream, due to having attached touchscreen reusing same
supplies, never turns the panel off. Let's do the same.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Unintended change 255 -> 256 for default brigtness. Drop it.
- Added R-bs.
- Link to v1: https://patch.msgid.link/20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz

---
David Heidelberg (2):
      drm/panel: lg-sw43408: do not assert reset across unprepare
      drm/panel: lg-sw43408: use the full DCS brightness range

 drivers/gpu/drm/panel/panel-lg-sw43408.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260809-fix-blueline-panel-af2b7c967f2d

Best regards,
--  
David Heidelberg <david@ixit.cz>


