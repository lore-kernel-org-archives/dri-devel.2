Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98961C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D51310E7DA;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AonkEpf4";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0575D10E4C4
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:28:30 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495590dde14so31492455e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785166108; x=1785770908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgMfUYC7ZpwL2pGUZegRGSOZuFsMOmvyJZY8xkpkpds=;
 b=AonkEpf4Et3f0mMfZzeiTpAZXzo6RjHmT9CCeHx7/pwqHg+TlBEKzRHLKR/g0/nAFs
 yYakLwLOKWWMYPmbOxfx4DJKMc6WmLHk8N81P+2nyMl08xBk6VSnVcpt7yuIE9V31pEk
 L4W5235j9aDUfgw4cQHX+KXpe+s3jeMPqdc5Wu8NR4xiP7VvkJPc2b970hhuTG2FVpBw
 quFzevEwiVXxBtswuSuHtG9swOFaWm+yzdUti82hD+qGENr2sl7MnlDZnX1cCGfnTFdm
 6/zaA9hloY359HwN1nuAE0EY8rNLCcxi7yPHxYLLU37oEQ+W4MerNjNM2Rx2vHBhRmab
 9xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785166108; x=1785770908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgMfUYC7ZpwL2pGUZegRGSOZuFsMOmvyJZY8xkpkpds=;
 b=nbJw63RcLwV9ZSZlOCvxMVeV25W8DqR8vysKSf/QXL5ML0+WPTADc1bKpUViNBVFiL
 dE6pWOI3aZKD5A7T/ww9u4pXz0qZL8DNZjj7cxhiSb1Gcqf2MWhAyUHspZXJ3kGKQ5T2
 mCk646bzdXObua72HKBD8ywrM7gaqtnb8rf5QKpVgXGiCc5EioRZ9ViXkIn753ONMeJ/
 oyC9Ap9gfthoT+eudBofQBLWw2TEYHYenVV6NBconWBJA3b94uuevBw3FHOqq+mSrS+x
 a/pBl/JWGeEzfQCXi33SGMDdU13a8y7rzrR8As74iXmcX/6z6EWZgYE544VWTvdw7tuQ
 zP3g==
X-Gm-Message-State: AOJu0YwJFJ5nqee6t1qBYzA/mR5+QBCSBy8DE2eNPW0C6MZYMqy0WDHM
 DxcrokfwDu9nCZXOJjBEHeyM11O1fCYOra2n1MwDVrQblXjqOIeYqCBr
X-Gm-Gg: AR+sD125cE//UsDUZw8HDZx/XC2OnNp0DSPkZzqy5chh4UJPRjxl4oSORSYT4Ckxq0B
 cE343vROFr9crW4e70Dk/5FX+qC3DMafCUCDgUrJDx3MWRhw/R47zElJrPd/Qgx28NcRWz3Y0qy
 ZJa4AWnAv+t51A+s+T+RilNGzssOafId+uezjOUj3uaDyg0+p/mxj/ZRuqQDbZoI61QkLQizy1C
 0UuTgI3P7fb9k7JvGM7FB5LH6dABLeS2ik026VfEdQa2oG4mSz5u7ZYa0se8bDNQb5CGbSshOmC
 yXGvKiLymhh/pKxU22mBNSmgr5oJlPoxkh/KycdxnvaTyCQthMIIOxwVtpEqhE2AInDd+Uo3JI8
 G6lSo3ewWzaYcRc0TrGiNK4MAKd5TElsqJGDFcPQXgll5xHJFqX0L7OpSfoMXMtMC4wERxKsEf7
 djbDLwm8M=
X-Received: by 2002:a05:600c:3488:b0:495:7a23:1eee with SMTP id
 5b1f17b1804b1-496c3a0cc27mr15603325e9.12.1785166108275; 
 Mon, 27 Jul 2026 08:28:28 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm214838735e9.1.2026.07.27.08.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:28:27 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 2/2] drm/nouveau/clk: only update clk->pstate after hardware
 programming succeeds
Date: Mon, 27 Jul 2026 17:28:21 +0200
Message-ID: <20260727152821.128432-3-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

nvkm_pstate_prog() wrote clk->pstate = pstatei before attempting the RAM
and core clock reprogramming. If either step failed, the software state
tracker had already committed to the new pstate even though the hardware
transition never completed, and a later re-request for that same state
could be skipped (pstate != clk->pstate would be false), leaving the
hardware stuck out of sync with what the driver believes it's running.

Move the assignment to after nvkm_cstate_prog() returns, and only commit
it on success.

Found by Sashiko AI review (https://sashiko.dev) while reviewing
"[PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor after the
loop" (20260712123616.1180830-1-postadelmaga@gmail.com) as a
pre-existing issue.

Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 nvkm/subdev/clk/base.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/nvkm/subdev/clk/base.c b/nvkm/subdev/clk/base.c
index 737bec8..91c51d4 100644
--- a/nvkm/subdev/clk/base.c
+++ b/nvkm/subdev/clk/base.c
@@ -285,7 +285,6 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 		return -EINVAL;
 
 	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
-	clk->pstate = pstatei;
 
 	nvkm_pcie_set_link(pci, pstate->pcie_speed, pstate->pcie_width);
 
@@ -302,7 +301,11 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 			return ret;
 	}
 
-	return nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
+	ret = nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
+	if (ret == 0)
+		clk->pstate = pstatei;
+
+	return ret;
 }
 
 static void
-- 
2.55.0

