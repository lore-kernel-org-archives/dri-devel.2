Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E063BC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA72610F517;
	Fri, 11 Sep 2026 07:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wt7Hn04P";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810CF10E29D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:25:17 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso61587a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789068317; x=1789673117; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JKd/99dRVgae4lnvw25sHFjT8rZubkhn6aAi9iQrCsM=;
 b=Wt7Hn04PxVGHwQ7r5dCvxAmsT8gzAcG82vGAN0fAIhKC4w3zgBHWvOwvVcBFEgXgfv
 WkZnY5iHpUqPkJDbFtsTqKXZt+FmAZT/ZDdmTK1SIOMobLeYcukj8ImFNQrNnn3WKQUL
 al/PeAKhma42ZMgtNqXmTnr5s5nIJusaYun44Xjqv/1GdLPUIBM4EvQehcO0u+5ztWv5
 aat59e3MOr1PrLBUPympiZbQLEZMa9Vvq4RM6F/DqreIXODL4VddS1C+EXGUaItI+laT
 YM+w2HoXxUr7VhSijqoEpNn2gmrjbJRKJXvourUWXESSIwMjKhJDBXomgm/+bycxNljI
 yiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068317; x=1789673117;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JKd/99dRVgae4lnvw25sHFjT8rZubkhn6aAi9iQrCsM=;
 b=RtdyPxoX2jBcPCyPPTdEKJXlFxf5uNt2PFlmYy7q/A7PuM5iKXnG1nhzemsDq/fcy+
 bB5KDAbjimwAfin9EVyJ+gl5ns5flM7tMjCDr8pBi2pfjLH6dI3UpJW8QHEnvvSW24zN
 c2mKzvd2wu2mqE7wx7XkxlWTfmrq5EQ9DCeAQoVN4UV/Jeg8+5Ztz8KStceUkHFVgRR8
 FOzkZ63JctUAyW6FR6DfPK9/FmjWXTYMtRYQZ7cRE1KU73eIkjPlyX3vC5Vc8jhczYO8
 7Vgj07pBM7r6gB7KfbCxKfGSpvACzYELbq8Z3rvcwVFDMHmbguKvdQCfFL4qAL3R9AAZ
 RDyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJErQQ/r07/mFxYVpwbrGE/RhA3iL4kF+r87N3cHmhCVhxWAU5yLSHMTAxuIf/4Ht4FKt674jwghY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laOtU3HkxU2vvIg5y30kIDc/wrlOy+ub8YiGfI9V4qwPZ8R0Ra
 8bUxUbDD+4Tsy3vCj7Ahc4l4JdNfChO05GMrp5q/M+feqELgavw3LlFQ
X-Gm-Gg: AYBFou1Z6gv0fNya8ek7tjt50D45SKSp/L0rntnXeVNcreXsTZkSbD/RkFjgmDmlhSN
 661JXA7/VSumSf2MzvS7IG7qLQPeNaak3a9bGmurBCUldXWg7r+rJavrglUTPY0G5HSdqTL6LDr
 TsCiqUcFL+7s/yVxjEc5nSnKBXFBIcjHd0AHd0BMlHjOTFhwc7g8Abl0O0WzOiV01Hj3QTNoWYg
 HVfkBS43sJ5iBI3ErROxKUGGvBKSnq4GWNj2Dj9RwsU6OWByreMrMywVe07AEHTXhfXXGo3EUGl
 QnTm4ZJ1I7U+Bf/O5vD9gvGQb5v2BwwI02ShtmntZFMU+DcbiW+1kEV8yahzBNVjG8aO+nfHnAT
 AAfEKxWufN6O8tvXiwMApzKRDkRjeOOwkUFgj74ziQJAm+9et05OOGM4HQkb92ISceX9qoNVC+C
 Dn5bJ5ouV2kWGVyR8ArIb4r2S5xUU0dmrWGepDgXegio9a+pSYkG6XD4TKFeRdql1kWXNW45l13
 qz4
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-39d9c1db130mr315234a91.13.1789068316984; 
 Thu, 10 Sep 2026 12:25:16 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4efc398sm225661eec.19.2026.09.10.12.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:25:16 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org, dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 pimyn@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
Date: Thu, 10 Sep 2026 19:25:11 -0000
Message-ID: <178906831180.136984.3208749717777263252@gmail.com>
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260825105427.686619-1-roshaen09@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

No physical PL111 hardware here; I tested under QEMU vexpress with
panic_on_warn, which is also how the syzkaller instance hits this.

On current master (7.3-rc2) the unpatched driver registers and
immediately warns: "[PLANE:35:plane-0] pixel format with alpha exposed
but blend mode not setup", which kills the boot with panic_on_warn.
With v3 below, the same boot registers pl111 with no warnings at all.
One note: 860e748bddcc is not in v7.2, so the splat only shows up on
master/7.3 and later.

v3 also removes the alpha formats from the board-specific tables in
pl111_versatile.c that the sashiko review caught v2 missing.
