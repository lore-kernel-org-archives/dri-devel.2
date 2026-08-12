Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B16C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEA710F24D;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p4O3CiaQ";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760BF10E3F9
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:37:59 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39c7ef2b1e2so6500561fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786534678; x=1787139478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LeOecHaUfHefnAFIhbafWVLtAYJ8GXSjd2T8fSVMv8s=;
 b=p4O3CiaQS8fA/TEgQWIX5kLLyu8ZnPH1DGCZQIAYZaR+k0QuyAWyMUEHiSXH2Z4//L
 U0d8ZO0kNGHuXuvo39sOid2sW4qm7cwVdANTCBCmU1vY15cmESVgakunQf/9EV9IO4Xk
 4im0AoPxOTNyenOIFx1zN2GsEETcE5FtfN+rYAPFo+iaeTZ7oawifoliNtuxeCEgCR3s
 DsLN62EWHCBcey5Y4VvOZ6FzwPTQaQOFuc8SkgQCkwGN4rLrpOQB9edNPnnKkrNUg/Im
 kaqFV9V/YbsjAbF4FmjkDtSfuzRscQ/Pmy2kqS/lHZHlQX4DONx4aY8QfAQ2zTA5UK7R
 picg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786534678; x=1787139478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LeOecHaUfHefnAFIhbafWVLtAYJ8GXSjd2T8fSVMv8s=;
 b=bZXW+mmj9SOPZDkiUyzW82t8UA+u/N4EPPc883nDvDBvC74wStTWKfEzXCv9b8m5jO
 VB5ny9CUVVDVGeR+zk033uvn7BJRKuq3jqyS4Jc3FeYXAesyqgidOHZTa1c/VhB7pqon
 j8mqTH7wQhFmgyf41EXZl++zX3GYBo9SH/DDlhAqZd0Cmv/Qi2szZjHJ6nFTxjkuRjnS
 14W56L5OmBj0SM/rdXXJhxNApyWempNljc8bOaSmYcJZ9g9deJwkCMfaP8YdCA/wFDA2
 Q5R+ne/mfE4bquoIRGC09UqWFgzLbh2zdqBlAG5zh9hp00e0POp4yXFCFDsr78XjrTo9
 Eu/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDZRX3FGApkElS9IP5rpGQzA+7s/OlgZ4x47oD4/NFwM5voPNpIu3TGDdkP2dQDKVrjBHHFcZrRbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKL3mfhwhBbtcGkgKqQ8UCc2PgMSZ9q9xeKGkH6rLVcJQCPZ2Q
 r3Lei1T0Nm/RQySFzBP1aNJ3lBNMDih/wnRqN/GxEMa0a2bl84L5s5Uqz4E8f6nNWQmprQ==
X-Gm-Gg: AR+sD13ouMrwmmsl+w0ZJX57X32+y42UyHNxVGnCMCbYBSXljQyqUKrlbJX1afDbjQL
 5+BQbRlWZv8+QJFRDMgTaScJ49/ibq6ceaxENW4SPdCzdz8OqVacZtEcHYtaTf7PBZALC7MC82i
 0G3KRZAechdVprdgpnf4pA5k0I7TQlHBYxG12Ge2R6C7lVUEAoZbFvkNyHH2lwqDUOaGrYWJOIw
 KAtrIqdMbDYVK6mEbN6JJpmrOgWWk29KZrjzhkAEzqrOGSxfYdWPUn3eNS2VDUTpCfeNxpX9stv
 OsBBnIoH6zObYNOVtjRiH0Kl+4AaR27gyykv9QAbTA79k92K3vJwYMAuhx99OLrfLRrkV0i7Czo
 eeFo4VD6slqkMbYkscoeScxGRUejsebzIXw1XuNDIjkbfWr2DPNXoBdvfYeLmdNETKPfo4YPeex
 TkS9ihJR0qNg2DAXD7RyudEW+P5iF6hI8MMLTeMRdv66mbgUUYmk/ioDMAwFlifm4zpb8Zsss/o
 0EXyQQ=
X-Received: by 2002:a2e:a9a5:0:b0:39c:7200:b9b9 with SMTP id
 38308e7fff4ca-3a10d53515emr4862991fa.13.1786534677463; 
 Wed, 12 Aug 2026 04:37:57 -0700 (PDT)
Received: from localhost ([176.210.177.198]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1082d11b9sm3881101fa.33.2026.08.12.04.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 04:37:57 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: aliceryhl@google.com, ttabi@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH 2/2] Documentation: nova: remove completed GSP log buffer task
Date: Wed, 12 Aug 2026 18:37:52 +0700
Message-ID: <20260812113752.532537-3-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812113752.532537-1-vladazaharova2018@gmail.com>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Exposing the GSP-RM log buffers through debugfs is implemented, and with
CONFIG_NOVA_CORE_KEEP_GSP_LOGS they now also survive a failed probe,
which was the part of the task that was still missing.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d5130b2b08fb..cae0578d32f1 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -141,18 +141,6 @@ Implement support for instmem (bar2) used to store page tables.
 GPU System Processor (GSP)
 ==========================
 
-Export GSP log buffers
-----------------------
-
-Recent patches from Timur Tabi [1] added support to expose GSP-RM log buffers
-(even after failure to probe the driver) through debugfs.
-
-This is also an interesting feature for nova-core, especially in the early days.
-
-| Link: https://lore.kernel.org/nouveau/20241030202952.694055-2-ttabi@nvidia.com/ [1]
-| Reference: Debugfs abstractions
-| Complexity: Intermediate
-
 GSP firmware abstraction
 ------------------------
 
-- 
2.55.0

