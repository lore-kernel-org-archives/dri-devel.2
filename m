Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04250C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D738010F38E;
	Fri, 18 Sep 2026 13:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U19kmtsy";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A0310E0E9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:16:25 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so408191f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789737384; x=1790342184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZS4CiCQN/3yr16/M/PFmnufnsKta51fgde7Cv0nVKI=;
 b=U19kmtsy2LSHJaiahSILScgioNwcu5MKEX116C4oMziqjs5eJB816DmhxnEX6tTPAd
 RM+uo+bT8PO1/Y/zkgDcOPxPKM2+WkzNKumMr0MJS/nklNqRdLKgWuhXf7/CY7K/DKXi
 M74wCpvCiNqfwpqxrWDHwjAqsxYPkyN6O2yFIqKRrBurd+6rYm46P4gniMZLAq2vfmvW
 53JQtudlL+gs8B7gx0owSdriXHGUpF0MyriLiFwi2vT/jPJEwp4Tqr3KIO/SE/zJKzfb
 qe4hOy4TnqpkOCH8ZZvBEnd3HroL7ASp1uO8fopNP5WANqmhQTYIxJ5nNpcZ7753oQbT
 ZJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737384; x=1790342184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FZS4CiCQN/3yr16/M/PFmnufnsKta51fgde7Cv0nVKI=;
 b=EjgnXiHkmpXNSAemYJ7v7WirbcU4mDMuXGGQiXXqBhSXlZMAzAYoLK3eK9qjrKbt74
 xF4MzdmikT8qhmM2h5mIUYNJi400zeMR0fx/lg02fknQgF+jt04hQJZhAYHOH/kLPh9l
 t8n3woIQUC79Y8EQ7Alf8fQWqqdee2Tg4JpU98hYNbNG1YZg3+gbnWE0v5LJ2ljPBt8i
 1nl0mnUu4NtvvdcMjF3bq+uJyxyo7jOL79oL7qgqpoGCpLl3P31ljhtz60Va4EstyS3Q
 QZaslf36qucuBzC75+xduw3N+/3s2H1Hcj39OSU+npN/7F8I/LdYj+4UpnXOSRN0Lod5
 +CiQ==
X-Gm-Message-State: AFuF++nUV65dOa54swMoOmm3TEZiVTNDZKEBqFm1LoYeNDlFL/smsUHm
 Z/y6rNqxpI8+szs7ng3GOoNXVccCv6spEGfWeDBxTfzneIjKlTLuVmZa
X-Gm-Gg: AYBFou1VxutGYKzlKCxN7ivkNA9QUhTJpc4PEqdJZICtnEWDL0dUwz3w+mL0qqOI+6q
 M1fwyWKky3NGmsFNg4wf7v4swfu91EEJn2Yk1q3butoLQ1DCAymc+x10KRlkD0tkFleI3FEOWXR
 txf1ZUgLM2umWYTtwQxfp9ZpJcGGf4T5TB0t1eXVXitbGnN56mL8L0l8oTzyCDDrYM3D5XXPpbH
 iTqB+huxAvsKm38jLAQKoPM9I9a1P6j0ZOMyXMv8cAwmkEOXymgF32I+SK+0keeLJXecXlofvFy
 NA4Uc3PHS7BRnEi+w4tc2bbFIND1pSFWvF8UpMXK+vGX0S2uEfo3fTarObOU1jBC7sQCcFJMsxx
 E650Gu7E+Zv82VAcK5cEjFDMUfxImzdaR+w9cYpSotChPnpQXgz56H5bKmsXW3rP4jBUjglCNKz
 O5oqHu0tmGodlnlUCz0AILojvO2WEGD9ePsgVT8jElW6Hzxb3VcWOUOuYvIsJ70ICxRmiuZy+Um
 ybtdn+mtuE=
X-Received: by 2002:a05:6000:70f:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-4871e215a94mr3116370f8f.5.1789737383660; 
 Fri, 18 Sep 2026 06:16:23 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.209.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4487572f8f.34.2026.09.18.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:16:23 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v3 1/4] drm/nouveau/clk: fix list cursor use after loop in
 nvkm_clk_ustate_update
Date: Fri, 18 Sep 2026 15:16:17 +0200
Message-ID: <20260918131620.405133-2-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131620.405133-1-postadelmaga@gmail.com>
References: <20260918131620.405133-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dan Carpenter <dan.carpenter@oracle.com>

If list_for_each_entry() exits without hitting a break then "pstate" is
not a valid pstate pointer.  Introduce a "found" variable instead.

The check is reachable from userspace: nvkm_clk_ustate_update() takes the
pstate id straight from the 'pstate' debugfs file, so requesting an id
that is not in clk->states - or any id at all when the perf tables are
broken and the list is empty - makes the pstate->pstate != req test
dereference the list head cast to a struct nvkm_pstate, which is an
out-of-bounds read.

Fixes: 7c8565220697 ("drm/nouveau/clk: implement power state and engine clock control in core")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
[Francesco: rebased on drm-misc-next, expanded the commit message]
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
This is Dan's 2022 patch, reposted with his authorship restored as asked
in the review of v2.  The diff is byte for byte what he sent; the commit
message keeps his original two sentences and adds a paragraph on how the
check is reached from userspace.
Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/

 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 572e63846..5da82db71 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -473,6 +473,7 @@ static int
 nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 {
 	struct nvkm_pstate *pstate;
+	bool found = false;
 	int i = 0;
 
 	if (!clk->allow_reclock)
@@ -480,12 +481,14 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 
 	if (req != -1 && req != -2) {
 		list_for_each_entry(pstate, &clk->states, head) {
-			if (pstate->pstate == req)
+			if (pstate->pstate == req) {
+				found = true;
 				break;
+			}
 			i++;
 		}
 
-		if (pstate->pstate != req)
+		if (!found)
 			return -EINVAL;
 		req = i;
 	}
-- 
2.55.0

