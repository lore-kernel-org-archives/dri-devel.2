Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D258DC5CFDB
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 17:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7197610E2D3;
	Sat, 15 Aug 2026 17:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQPDg5/2";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A2510E1EE
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 17:31:05 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7f3f52143cdso524856a34.2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786815064; x=1787419864; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=caUxSmF4mOwDWDjpizi0YmdYhbjdvZBNYyy5yHj52EM=;
 b=DQPDg5/2Qfe7uYcjzOCsiyUY7BV4I6uEl+0eu+b5FCicFeyWGq7MSvTNXLMXlYVonG
 VIwv1oi1hKx6Pg5bFXkiRGsiF5UB7pYL1alAFFAoy85Wkw28Dx2S9PrDUI6Jj7QdOG+5
 aAKJNof16sUD8JPr1IHK+af+PWDih+c8o0vXLimGc0p8HBFF7zriP/g04h4ZwuAJdJ/s
 hxn6m9E0Q/lIfefJsJRh8ywJk5cF2t6I8xWAod0Jhhs0zm9Pg93o+4CDgf1Ha4p6A226
 1sXu1683ceytDaWjUyNUSy95dMdmRYKFXb5eyBFcj4iRP4ybUIATI2XDTx6ASxkBY1pM
 MxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786815064; x=1787419864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=caUxSmF4mOwDWDjpizi0YmdYhbjdvZBNYyy5yHj52EM=;
 b=LX/vIWy7KqmDj/jb96pcFd3Tm+0FSF6CSJVe6Pin8kH4G9Il5muFbtpQX62AIp3Xxv
 hqmJGl/W0Wl2Ff4/1i8V5zBU4zEphsbP1u1ysWExKMHs9IO773ceY2WqwUJX47taulwX
 65D5Lpq7S+/3xF7VLZIJG2j0uZs2vhWngVuuWFiO40kZzwxCTPtlgT9H3jauw5Eq6vsM
 YY9Qd7iKxknKRfbOlkjQyYN5kYVpqdkxjDqH1fm1krexM1ClDoJsDUhtWEjd8mVhWIgV
 1UaO9atlA97HB+sQA0qqkH7zSB6kWi+3kVnU1fVEa3ygVphEnukTsi3ytnV0To9p/OXu
 N+Fw==
X-Gm-Message-State: AOJu0Yz/apdPUTTD0QiImpe1IMJFYHKNN9FOIIGWWRpfBv/WnTM3uXax
 jdiUsf4sPRU0pEaUiPyyG4ajp1Vhi9/P/c71XGFNZoh0I27wf1uCk3qp
X-Gm-Gg: AR+sD12N/JbShdga/Pk+u0Bbvy3aLU1zR5CnQZxA0tHq3XtD0gzl+M7BHxgw74Jlvc/
 jdLMeyIyvECC5nNkD8QAJ5xm3kO1H4b2h0MrfMwI/hPgB4JO6Cp2linCnDAsD/BfIVF/TrXGGUP
 Vl/W10i4VhH5kyxiRKnkFbCre7UOAUvxQAvz4k5BX5vL/j7Wi6H/USg18zO1t2nlgGpkvYm6R3S
 AOO4F3R60IvNUKllcGQJtvoIMDMcoc1E35EeUFacDBgFZ4v91iJ5Adk5NQSKk1LhP2DypOUU0y+
 2+Bmd5eEbfuN1But73j/55BcVNfaqSv/LwKPqa6hrayG4whUFy8uWkFs2yTgBNJ5esGDgt8B5sy
 DAX57AClS+mg2pkl0W/bUtGJ6XSramrNZ7CXo0ANmnw/B0K6/ABZjoXN1MIm30riPPKw/+X+DLu
 sBeQH8BpImshKkCDTnED5NEg4Xoi9fwg4HQD6jst7SL5SaKQhLbM0L9/GvycjqHkFPSg9OyKIEC
 tYRtwFdNPBz2rkqzJLJ2uVTWmXg6kb8WqUqiNMvtx8NqtQFJvo3/+pTu28vX9f3siiAlB9FGOjy
 Ue82jZv0cgAA2lVLBkk=
X-Received: by 2002:a05:6830:4488:b0:7e9:e709:44f6 with SMTP id
 46e09a7af769-7f3de679c0dmr12685842a34.12.1786815064517; 
 Sat, 15 Aug 2026 10:31:04 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7f3e86686c4sm4029328a34.23.2026.08.15.10.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 10:31:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 15 Aug 2026 11:30:53 -0600
Subject: [PATCH 2/2] drm/nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-null-fixes-v1-2-0df9dda951fb@gmail.com>
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
In-Reply-To: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786815060; l=2253;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=AYZ9MDfYP+/3hzlU1wrveigPwRkF/U6OUgZWgjhl2yY=;
 b=kzw5BbvnfnMPlkNH1/kbY9HreJCu8O+yyr+c0l0w1aWyb5VnBnAVDh3CzuzCH/TM8DT1w3wLy
 7MHLUYfUez3CfHaoo5Zh8B8H8aU8XTsCV6QG5iNm++64EqxGhbst2cF
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

When graphics engine firmware fails to load or initialization aborts
early, nvxx_gr(drm) returns NULL. Calling DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO
causes nouveau_abi16_ioctl_get_zcull_info() to dereference gr at offset
0xf0 without checking for NULL, triggering a kernel page fault.

Validate that gr is non-NULL before inspecting gr->has_zcull_info.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Aug 14 09:21:52 frodo kernel: BUG: kernel NULL pointer dereference, address: 00000000000000f0
Aug 14 09:21:52 frodo kernel: #PF: error_code(0x0000) - not-present page
Aug 14 09:21:52 frodo kernel: Oops: Oops: 0000 [#1] SMP NOPTI
Aug 14 09:21:52 frodo kernel: RIP: 0010:nouveau_abi16_ioctl_get_zcull_info+0x17/0xa0 [nouveau]
Aug 14 09:21:52 frodo kernel: Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 40 48 8b 00 48 8b 80 70 02 00 00 <80> b8 f0 00 00 00 00 74 72 8b 90 c0 00 00 00 89 16 8b 90 c4 00 00
Aug 14 09:21:52 frodo kernel: Call Trace:
Aug 14 09:21:52 frodo kernel:  <TASK>
Aug 14 09:21:52 frodo kernel:  drm_ioctl_kernel+0xae/0x100
Aug 14 09:21:52 frodo kernel:  drm_ioctl+0x2e0/0x560
Aug 14 09:21:52 frodo kernel:  ? __pfx_nouveau_abi16_ioctl_get_zcull_info+0x10/0x10 [nouveau]
Aug 14 09:21:52 frodo kernel:  nouveau_drm_ioctl+0x58/0xc0 [nouveau]
Aug 14 09:21:52 frodo kernel:  __x64_sys_ioctl+0xb9/0x100
Aug 14 09:21:52 frodo kernel:  do_syscall_64+0xe2/0x560
Aug 14 09:21:52 frodo kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Aug 14 09:21:52 frodo kernel:  </TASK>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index c9270c5b0fac..f1026a716ff7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -357,7 +357,7 @@ nouveau_abi16_ioctl_get_zcull_info(ABI16_IOCTL_ARGS)
 	struct nvkm_gr *gr = nvxx_gr(drm);
 	struct drm_nouveau_get_zcull_info *out = data;
 
-	if (gr->has_zcull_info) {
+	if (gr && gr->has_zcull_info) {
 		const struct nvkm_gr_zcull_info *i = &gr->zcull_info;
 
 		out->width_align_pixels = i->width_align_pixels;

-- 
2.55.0

