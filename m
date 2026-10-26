Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6C606A329
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iiaq+sjY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06C510F34D;
	Tue, 27 Oct 2026 09:35:23 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD4610E29A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:03:31 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5eabf7d5bbeso2937949e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793019810; x=1793624610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDATahJ/W2YtLTpfCyaxOC0Boq6szEi97OuferqWXIQ=;
 b=Iiaq+sjYQaEV+a7AZVbDPLYeI80x6vGCS8vfNdZiHvI5xkhWZgWGrrRVBWvOlp+0zL
 NOgosqJt9GrnJD+/lL0VA+1t3Qsyhy3k1IhwXBJzzzizt5wH1v1HXh+1Ndb01GiFDDbz
 iZi2mEgcbXnBENuDw3Hc/jYu0qui1HTh7flI48KGYcY8p1f13aH2kUvRIU/dbdG6C98M
 jupZVLbkeIuxsRY02ix4Puj49kYXxCL6nWwC/g+Ntu/hzL3/dotyoMtEzo4Yr2yGxsLS
 mpVxlmyS3QxJ9hdJoCLkiYRQ3tTQoW/DI7HXG+oqRXF8BnSTYTI8y8Q88RIHjaUWQAcy
 xjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019810; x=1793624610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDATahJ/W2YtLTpfCyaxOC0Boq6szEi97OuferqWXIQ=;
 b=GYSmaM4bXvVPYuBbVEOVFRTbZI0Wz9/mrX9BBuCck3B1hPnwSHwg9aEBvL+qafEGQC
 Geqy1VydiLDls1fjLTeKl69nqBWk3sJSSUMqSgx03EmItiBRCYMs1H5EXEi8i3dWs6PO
 EepNrzJG+NnQoDQf9xmVc8am+Ljkdtpd3DkGEgcLKUPCe+rseW+4EoQnmzBNS6S2XIVV
 FWwtRMpxvTp3ltJiAjEiR8CXCvcljK6CjPX1P/GdmEqJQ/5KUB6MT8seqHFMNOIroA//
 vnzEmmoo/vUYCurU+2G7M/DKLNNYl5ekjLPF2mvRNQ6VxAAuGy3PQ4yPF0Cljr7qAAbA
 TcvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzytZq4i89SItxFa9NElSzTLx1IiI1Jad0c2zdNi7vT2OLSLfNSU+L6VuAGsiQnNjQkxWy0h6yuKwQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsK7nAJFmyggtPGw+g9X8Ejv2QwT7bhxL4oSrX3wdECGZiQbyz
 ccCOoyrHp5+DJcpJqTM4/XdXzrx6iWvpoSIAKqfOxvnD+fVE2yXDLTszv9MxjGBY
X-Gm-Gg: AYBFou2LDjZHI1Zx6KgwuVcwyrWopE2v9atQv5FBjaWDFJSo8v3RKmZkDCPlylSU/ll
 ZIs/Uz+7ri2ukVGLQ5t+ntD+wmblFw40aq3xAD29IJbhOAr06FpBIzk0VOE+W5jYGcNfVHTegsq
 yRw02WW/YPVFRYHwgCiNEROOQ4+NPcYme/+zkFlDybWCOL2TrJgbPdCLSrdRetKFF0rA12NgstD
 ZI0gZbOPvPKj2pk2F3f36BRguD4DQaNMZnSLSSXOlnVoQb0w1zUz5k3WHarnwc3N79krMqWj8TX
 /H9EwC2H0hkWSLD9CPHbynxtSfSfxdS9weNGc139O1xBrubYPq3ogEeAc2VGpvm4Nbu44LIsozp
 +Wvm7BfI62l99l3z4/CrtSFVy86W66QNL7LnJzJ6xczgG2oSrAnCBTjOyK5yVRdaCpAZpEWX+BW
 ykfUz+seQzA+5bamK6bT5oiyuWTsxccd4q9WdjQzmVtdPZe5XKZFn0jf64Si1Rr1qFIBx10LQyQ
 fLVhK8cGiacX1LYHp9hKSYXFrgKL11q6p44GyM623671ReRXmEJkKTdVdUPvO3g5L1fEA==
X-Received: by 2002:a05:6122:e183:b0:5ea:c90d:d1b2 with SMTP id
 71dfb90a1353d-5ec232abc41mr2269965e0c.13.1793019804885; 
 Mon, 26 Oct 2026 06:03:24 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec233f5148sm8289108e0c.6.2026.10.26.06.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:03:24 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
Date: Mon, 26 Oct 2026 10:02:51 -0300
Message-ID: <20261026130254.201871-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
References: <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
> Cc: stable@vger.kernel.org
> Please drop that, we really don't want this to be backported.

Understood, no backport.

Alex, you already applied v2.  Could you drop the "Cc: stable" line
from both patches when you add the tags, or would you rather have a
v3 from me?

Christian, do you also want the Fixes: tag gone?  I kept it because it
points at where the problem comes from, but if I remember the stable
rules correctly, commits with a Fixes: tag can still be picked up for
backporting without a Cc: stable, so it may matter if the goal is to
keep this out of the stable trees.

Thanks,
Matheus
