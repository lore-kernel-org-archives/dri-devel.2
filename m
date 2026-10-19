Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62712606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2rSN9yR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6D110F321;
	Tue, 20 Oct 2026 07:36:57 +0000 (UTC)
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CC710E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:02:30 +0000 (UTC)
Received: by mail-dl2-f9.google.com with SMTP id
 a92af1059eb24-1397ad3d891so436842c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792400549; x=1793005349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
 b=H2rSN9yRZu/G64S2gycwGsjepaqBIu8fEonD4QrNaL85y9KOK0SA4MptxeFl+ONllw
 ZU5QQMNmewuwA8ENWovukKtXQnoW5aJ5NUzlmIxzwR4PtAwKiI/V2MOUDJ5HdTPx/H/D
 XcpvzaXUkcit5F0Z0oaEW8bG8z2qa/HlFt8aYiM/BGSnsL0t78K0rK8rwJ657dVJkzx/
 oTvrFQ7FCkMD9lc7Fw0qmFBuSCNJiNtucvPbuBnz0WpTLJ/uuXsInnl5yyMmqsT7z70L
 fqTUc19mU9OGhaM9JMLQ/Bri27T+rlRN8Yo3xRu4E+lq0EGp9pxVyiJoSXDwe7b0bl2u
 g44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400549; x=1793005349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
 b=B3QDHgHUN5a6shT6AKgdK+kkKd84c5yDEMdYmkdvTVnfmI06e4YQYLGiIjzznuUwRt
 qHM8GRX5Bsc1lgEH7XE062GJgR+yZcu2Kvya5RSzpMAK8t9LkpEsj/e3U45rWDiEBGH+
 fMCBlwwM0cMTQbH6TkZodoeDksDbAA5+QGLmaeuL7yH3gzmyLcqFbMGTpec5hS4n0sj3
 HtMcdcMfJsy2dUAtD2iwpbNXBIf/U2msVLvZkN3DPWO++rPj5BWO+2L7MmJWXppwiAef
 BEPORaDlyNcd6cvqH3Wz2zxdoEgZMPgC/UUNKoYqIb1yaZVOLqfLxbKl2B+f3rqQkUDm
 /YOA==
X-Gm-Message-State: AFq9FYLoE9wYL/kVt9TEE0aa9FawSznqKWV8xwTvH18D2m4Wqqxsr80n
 zlQzDT3//jQ4h5C5y7R0LYu3H8LThCFEG8lGaSU9ZKRMoM2CxonzFJBS
X-Gm-Gg: AYBFou0OvI/9horeLK+U8icT4AKZCxULFpU5wytLSpaBXuDt+typIiP2MlMyc8LqG7A
 31k52uRyHoAdZhHStcu/IMT6C2/DUayvMz/dQm2WWB5WER8K1189yHZUvWdwy4BhnlSJG18TDjg
 YtLcw1iPsqzDuSRl1gqmZnsfiWU9RkOM1z7CUC5CzPm6kpdWOP1c6eSBFj1RPiTOnkf35MfRxZd
 ti+iqO0b8IjOrffMHhQon1F9oLC8EGFdd6BJnnr5xv8FWInwuwpAnSVjOMGcLv93qpsSH8A9jFU
 OxHjcAWO6rXbUoS7KXt+eSNHW4uPyFqOIk351tkel2cG9RWvMxhbnGSDQj+QmWWVknuYzycCAoi
 8cQZNFFGpUnuCU6/xYLbp4D+3WXk7imrlH5Erjn5W9hN/mY6tQus/08bGlPqbRoj19KKDolQvRg
 bF/3EtnUTUylerz37XIKPR8p3U5hxPMbZR2UdiZMfMdBS55Dk+yrwMhUY01wK47jMAZOP6NCMWZ
 1bcrnXacBxnKpuVVnWy/Evs67HW1QTprow=
X-Received: by 2002:a05:7022:eb44:10b0:14e:d0ba:7569 with SMTP id
 a92af1059eb24-1850c502379mr10698378c88.6.1792400549264; 
 Mon, 19 Oct 2026 02:02:29 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:02:28 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v4 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:02:06 +0800
Message-ID: <20261019090206.1094958-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

