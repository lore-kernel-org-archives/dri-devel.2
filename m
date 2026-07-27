Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C6FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F55010E7D3;
	Tue, 28 Jul 2026 07:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sF4tPvLB";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E804010E453
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:05:57 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47640541585so1779504f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785164756; x=1785769556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xR8fBXhyULcS9rw8dxfF/pU3nQ4nEDbAUP33X1bCS3I=;
 b=sF4tPvLBPXPfTAf3vowz7uoAWly/kZIDmJxIDjTlPy8ZmG7Q80lDLnqrJr5FEbSkyQ
 UsJmTsThI8AXdZjIGcU8JmIbL/Zv/5VJZDZrEKhxYXT/YEwhpRZf0lXkfVqDzKcySyYU
 dhlmQSOLGdOxMXNnx2UUP1WTL3/+wefYaa4hT28fG/G37u16SwxEe/CMODI+wHCTF8aF
 usAKQpHtTb+vvsAwsRbY2yyDGeFg9Ehcg6MhqKfbQsDpN2r6CUA5RNtb2SYTdX1wD9RP
 nl9Hak4EZMWJal14Bb5eX2dFQc4CVaJVauHsZf6HgH7bNLKVkfvEA9JXVi9ekiyjZKKA
 NBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785164756; x=1785769556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR8fBXhyULcS9rw8dxfF/pU3nQ4nEDbAUP33X1bCS3I=;
 b=H7Qmk1hQYkk7ZX/VwCZLB5R3Mi6QAabzCzjOJ/9/4Vw6EQn5xo5rUSWMmhNVYj6SKZ
 XUenaFmEw/o+CC/HlLZgJHmmLxLMo3S0DbxeHParKUS2F818IeREi7eagYdRIjJrnsZ2
 c+/LtKj5SwwTa1vMAiLevmNp+ziJzqpgt0QCAspelpIDQcydOb/Dv6i2B8s1N0eXAflv
 uyq6zeC3eTCErBNIHr0B89y6HCU0a6TBbigz1CfvgRD5YOQE1rqLjt8QEdNbM8pOF9Gh
 N4UtMyXb3ahVuP8qxEHlq+QQ/3Hh7TzCM5HbObf3BwHAboUSJkVLcnuBRlfcQNnCHztp
 kbpw==
X-Gm-Message-State: AOJu0Yw2DxVmElGDgob58BFFQLRpIuFjY/zxfYneNttkxeBR9yDCaH1t
 JhdqqHKU0BEsMFGfCfXolbGBjlZP/g1A+uBpnNW4WV5Fnlse8IZ9/kmP7Hox3aOD
X-Gm-Gg: AR+sD10rqn/i3R+7Q+hO+Vb3hOp9jmLqcLNHLYkjRSt0ShQ57OVnOXdAlLrwZq5oxkf
 KGl4TOEHZIcDnqF73BhG2MMXpgqvtA6IwZQIfYf0OUwKqq6/4xaFZc8chZthnBctV98GOLNmZCn
 0F2qdY3QC2DIP3qx6fws+Gb4vYX91rM9mPboh9uM1xLvydqIYfOhloClCDbk4Uk2v4qzBK/ip+L
 Z/NaMLPdapb4/V7UCNNV1tK658LmwV11i4sbIpzqxQengpcef+MvEjsvNTj8osaxmqqSvdehLRx
 PZwDLJVjZn6fkI4y+tA7zhRJ6ZyfoGxopSOLaV13Yi/9yARGLACW3R1mHzemoT9ySd+c9SpeIc/
 J6csuMoRu7MipRrHC3kMjAhrQzNcJiCP6fLIMRxCGzzP6ldPj8MO+N2D3FdQqHS+HabI24H6GP0
 gy2Dzwodg=
X-Received: by 2002:a5d:5e87:0:b0:47d:ea8a:d224 with SMTP id
 ffacd0b85a97d-47f9fe96330mr11316857f8f.23.1785164754717; 
 Mon, 27 Jul 2026 08:05:54 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm54242960f8f.7.2026.07.27.08.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:05:52 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 0/2] drm/nouveau/clk: fix RAM error handling and pstate desync
 in nvkm_pstate_prog
Date: Mon, 27 Jul 2026 17:05:44 +0200
Message-ID: <20260727150546.121357-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Follow-up to "[PATCH v2 0/4] drm/nouveau: fix list cursor use after loop
in the clk pstate paths" (20260712123616.1180830-1-postadelmaga@gmail.com).
Sashiko AI review flagged three pre-existing issues while reviewing patch
2/4 of that series; the third (clk->func->prog()'s error being clobbered
by nvkm_volt_set_id() in nvkm_cstate_prog()) is already fixed by patch 4/4
of that series. These two patches address the other two:

  1. nvkm_pstate_prog() drops the RAM reclock error and falls through to
     core clock programming anyway.
  2. nvkm_pstate_prog() commits clk->pstate to the new state before the
     hardware transition has actually succeeded.

Francesco Magazzu (2):
  drm/nouveau/clk: don't ignore RAM clock programming errors in
    nvkm_pstate_prog
  drm/nouveau/clk: only update clk->pstate after hardware programming
    succeeds

 nvkm/subdev/clk/base.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

