Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED7C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBF110EA03;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tGq9kGzg";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022E710E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:10:47 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so303718a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789200646; x=1789805446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qekC0MqEXMTW5BJCD+Nqo9MkepvtatwwVDmZuLTl4rg=;
 b=tGq9kGzgeIes4bCLtNW6Om0861Ag5Y141DF5KOlInnGvyYiYmS9oc6Fdq7FPO4UQfC
 7uMRkL/tfDNj5+qiEvIQD/LmpJS2lYqSdnqWlEETDKBdWvu74exgQveVyLd9xi8KaHa/
 EXYSXQcrDPhOdmp+qBa8fJ0plMitxTBvDSUQzSs1T6JygopDTqvMHVlKz8pZ4hcHn+MN
 IECCNBY5PN27ifynLQIa/W8zk74S92FHl5362dqsJ6vQWHiVpv1don/7fhQlDsO9hupM
 +w4+vEuw3uQV4prufyYVKQaIHXV54ENmKPn/svR49QYr+u3dTNNLoZz4qrLv//3s3i2G
 /03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200646; x=1789805446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qekC0MqEXMTW5BJCD+Nqo9MkepvtatwwVDmZuLTl4rg=;
 b=ZpicvVCFamgcPAMhmyqkzRf/EEJ9gRLQRbPlEH3pUs0RFgoW2U8+goHsC91KEcjWbZ
 PueDVvy1MX7CJnpb+vY7sLYQ3ngD+Nvid9cpvbDjCEWL4OpaUFNbU13Up0oYkhge+d9T
 xA0i3PuuqhDY+L7mB4AW6cSwVIl5+exZcXyNrZDjva+VAQEB60I9ImNjv39OpRyFTZae
 q8OI/pmNiakroFaL1azNVvokx3oLyE7/03r7GjUJNfO3gluymQvoQAjUtGAFnWHyCjPq
 OM8JWiWQmOi59lYRAuD9b8Hezm4V4719yiLtYd7sgIGbjnRaXaUR/PTJATsh57oWyTkI
 r8yg==
X-Gm-Message-State: AFuF++m141E5SkTm1BaB1gfp+sK0EvqbSxTMr3zwgin/wbiurX6p+i8J
 QVONv9DNVImcKPaiFXYjC7d3mDmg/79HAfs3YaJPRb5kRSBoflq5pQiv
X-Gm-Gg: AYBFou11nb4E3V5OgD6cwYvZbRC+wztlmsE41zTtlu+2FitfT4U2wJwMeBrf631RWbE
 aD21xheEp6pD7vchz9Jm0nkTuzi2+Jyd3LcQPyrWRCXHb/sk6HpsBXwyIsReQ5wHF2bFVGNIZ78
 gERHOcsF39Li7h/ATayJx631rFTAtVMtyHOw+8pLueXALZ0XJJp7VP8uwSRjJI7g2o4Tj26H3o9
 aOf0blcTLP9RtZlzx/0m9fXvIXnLsR/3TbY1VToT8P/zKjgx2y4PehUDLUYcKus121IXbTmdTDC
 s3yh7VrjRlh///GJJN0EiqBsxw6jxpyrZJnx9gZIcksvOv7jswtly9Mutl5/HivZmJSXexlJno6
 loz+vuoSaHNDmL0pt1DrSXLmhnDRrEGhE9JTopQCyUGi9Id3ncLl3nHYgwPjAboF+11xcpJ2wvZ
 Re+DCaVbtISMbBpSGLCAJ46qNTLdE6chpOjzhB//+oh8/W3ShdxcWkq6zULax7+t04TfFewROcF
 ME2Fw0ITBoLxds7xuEB/4udhFY1wD0zfOyxcpxUt96aEmjdGObtdhYVhxyo+lKKdJuE69d4k2Vs
 qFd6898Vu/7f88f+gYFTpUFaoR8SnNTJWhguho405WBr
X-Received: by 2002:a17:90b:57c6:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39dbbeb57a5mr3434433a91.7.1789200646524; 
 Sat, 12 Sep 2026 01:10:46 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db7ae6d25sm982474a91.1.2026.09.12.01.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 01:10:46 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 3/4] accel/amdxdna: release the chained command BO when vmap
 fails
Date: Sat, 12 Sep 2026 20:10:11 +1200
Message-ID: <20260912081012.2274075-4-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912081012.2274075-1-0xiviel@gmail.com>
References: <20260912081012.2274075-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

When amdxdna_cmd_set_error() follows a command chain it takes a
reference on the BO named by the chain:

	abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
	if (!abo)
		return -EINVAL;
	cmd = amdxdna_gem_vmap(abo);
	if (!cmd)
		return -ENOMEM;

and drops it at the end of the function under "if (cc)". The -ENOMEM
path returns before reaching that, so the reference taken by
amdxdna_gem_get_obj() is leaked and the GEM object is never freed.

amdxdna_gem_vmap() fails only if drm_gem_vmap() fails, which needs
memory pressure or an exporter that refuses the mapping, so this is a
small leak on a rare path rather than something a caller can drive at
will. It is still a leak, and the chain BO handle comes from a command
buffer user space can write.

Drop the reference before returning.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index c24bf1c..7a61e83 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -170,8 +170,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 		if (!abo)
 			return -EINVAL;
 		cmd = amdxdna_gem_vmap(abo);
-		if (!cmd)
+		if (!cmd) {
+			amdxdna_gem_put_obj(abo);
 			return -ENOMEM;
+		}
 	}
 
 	if (abo->mem.size < sizeof(*cmd)) {
-- 
2.53.0

