Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06408FE51EE
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE8D10F458;
	Fri, 24 Apr 2026 09:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f3nvIfeu";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C6A10F458
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:20:17 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso103979955e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022416; x=1777627216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gOHHzHpR+tUYq1PV1E2y8jxvE0jwtx0gBXAvhrnysC8=;
 b=f3nvIfeuajUm2V+ZDeu7/p4JDvX7NIDaliv8E1KqvZ2nBJ9HJD5DAzhqsaw4Wp8Xce
 jxBBmfoA1q1Iipdva3zk5I759+5RLQxYf/cf3/16L+bVqayHnD6gpA21ZNfKc8kmkbbk
 v7sJb1WVDMnEXwd5x3NOVoG2lJBdazX2idnikGs0I8B7/U2VbLD0DmajsJ/TcV8Sc1Ir
 aXJ1CxU/EaF4LVFcKOCDaxs+i5qHJf9hbXBaUVANao2A4o/p0qjmFn7X2DSDs2/0QAYm
 AOkahV27M48VqvLIyy/pyHN8hFKQqBai4f0pGXPu/okDgO+5Ba6Vdmghn8wfXfUVXw0v
 OEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022416; x=1777627216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOHHzHpR+tUYq1PV1E2y8jxvE0jwtx0gBXAvhrnysC8=;
 b=QK/tR1hs3i77vMn0Jb7xBT/7rsgIdHuHy4B3j2v/KpWoFpmT0pIBA2mjrQ6Sctwfkk
 dAyi4HxhjjekeWsvv6SOqutSOUXkkAmPnNdGHDbgUfztPG7r5QgnLyoPvUAs2wAmhOtb
 Vm9KaEuCwOk0oyXpZqYOuj3XwiuWkSFrBFcgesoCO7/q/b6Y0sPVbEHlXyGCfNs/y6KX
 Vl82zCFaNGblHCLsicNQHKk35cllGf9qYFoqoinhloHs12dp2taKbZ8XMG0VbJSNPcIg
 R9XmnaLl2NnjVWb5r8OamKF7bwOwAkRzIlk27ZxiFX2Q/jsug2887t5i4VPX4DXosWLM
 jAjw==
X-Gm-Message-State: AOJu0YzvqtPQ/KJAbgI4HjAlWpTfV6U28wpxCKqOqvMFgTl7Bc/6cX2X
 bMsVFjTwMZL1TLJGaS/u2Nf+wWwq+tSPu8JEoaiIIpMBVT36ZSdAFKEI
X-Gm-Gg: AeBDies27U5SunbtnSo/2mGEXZXJox1qvnmB1cCOLtSwobRmaB6dJL+q7rr4FSwrzDn
 cEaDqRdSdMrvKkw9zySVbBiosn4Sv/np2UGgrncEqaIQD7a6U6aiLWSlvDGjY3bzFon11gsdARS
 FcnkBzayhQGQHA4sgsQShA+vevdsyqoCH8QDTJ3bcawRZBVx/yDbALZVbBCBJi4fG39jo92mQKF
 v7VSNW/ZZu8GkDv+zx8tpLs2RzyKrTN6ezpn/Yhp85bbEKatJLil7LRZarrmnj4OiSMTdj0gHoD
 9lNlMnuyhTLY1B0pSJEI8YWhdw49JZRqdw+zrkivWkjYzJnuEBH/BihKe1nzc5sfrLFCxEc8pjv
 GGvAnjdBKndsYVQrVIzVX44INYQJuMXYEw7hJVyy4cbbYpcZpF2IFRKn8/aBg2EISiq9Qa50aZQ
 X8oHnIrRnNW4/xA/BY0H76l2fDKngIwQKxt6sRDhAVW/ZOreM=
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-488fb78e7c5mr424576075e9.28.1777022415481; 
 Fri, 24 Apr 2026 02:20:15 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f2:7300:95ce:4290:489c:f518])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm660955235e9.1.2026.04.24.02.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:20:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org
Subject: Finishing drm_exec cleanup
Date: Fri, 24 Apr 2026 11:15:08 +0200
Message-ID: <20260424092012.5694-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

Hi Zack,

VMWGFX is the only DRM driver who is still using the old ttm_execbuf
framework and while going over my TODO branches I've found that I never
upstreamed the patches to clean that up and fully move over to drm_exec.

It should be a trivial 1 to 1 replacement now, but I can only compile
test it.

There can be more cleanup on top of this, for example as far as I can
see vmw_resource_check_buffer() actually doesn't need a ticket. But this
isn't the topic of this patch set.

Please let me know what you think since that would allow remove quite a
bunch of otherwise unmaintained code.

Thanks,
Christian.

