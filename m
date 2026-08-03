Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D19C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9814C10E7D5;
	Mon,  3 Aug 2026 21:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4cA4ocZ";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4CA10E095
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 21:50:34 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso30241195e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785793833; x=1786398633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eTvs94omlnn6KRMYaf/xTULVGskgqo6uDr6699pyZW4=;
 b=d4cA4ocZNTvVseGeAiQCkVUFvgPihVSgA2+HkStgzzAxsVYx/DtU5jeBrdDGHDHLF5
 QOU7TREKscKdR3Zj3DmSnK9SzBruopAbnQWSbazMDNQmvBrlxQE11hbZOYq2wR74VILk
 s/67jwsXjjqw+Z7458WseixRgTVjIR2yXRC7mTCylD909BwtYfMnSBLy1JwUhpQ0R/OS
 exewZ8/KpNl0Lgce24oW0QvFUlgMYcaMafuRvs0jEnKdUpcBTcu9BRgT27fCNmd+WXLP
 Vkx4pN2rsJRyCYCHfsIEbvbm8qxrQyi67jqRBDeWnjCbnyrxbaH3mCGvh/6KIcJfXhnk
 utOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785793833; x=1786398633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eTvs94omlnn6KRMYaf/xTULVGskgqo6uDr6699pyZW4=;
 b=McgNcYbVTvXxyhcXbT1gnhoVbvNJw1NoD/bu2beWZQ8PUnOaquHljhbXDRqe2FFHhp
 IlMaa6B/neNI4qYmsHspt5/hjjsq19wSJsib0UNBtC40RNv4YZixhStK/2aFWLsXT0jQ
 htCL5jcbdrerKgd/gWclU8hR1vKH8+ae5vEJYwBTGdjKBwpLfkpMZN5vSpAEen60uFXw
 xqbF4mzz3uWUhhurFhl6anB+p5GyAXYs/OYfiW/O80p6qT7o6q3vvT2zd7MMysAEF+VG
 6yviyXWzYUtz+yWqlZFB3TF5GJea+Jo6gHhMYjPyrGTOxwuPVRgfSgPS2N4vWV2YcR8G
 11fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzjxG0+wJMO9hfkIFohBDXTfH5tlI4KZGrL8MhTnlfwDipHTa6XVru8fAt15dT3bp0fqU6sasRSw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz10XESHzRPGyP7bIIDjQs5gGnIcbymGR3rIyGZZK39x+uE+U31
 QFmWVnEJMpCc6qNVK/lp9ZHv60YXePM8NWROQ1XrN1ZHRs4mbz2LRLNM
X-Gm-Gg: AR+sD13Rfod9+QYqa4jHd3+tiWf1/YikNa5mCehL7a488DPL4MRLNnTy5oy4nQtpv2i
 C8mUiqDj6oWQIMtM2EjkS0txzbgXtNN5IqgEhOjQ7IbGMErsFpDRGjhDZN8gNVXE0mHXNfkKTi1
 As1cDc5/DXKrByQQaDLInivrUd4T9FfURHZSTBAYEoqnIIo4d4g2e5HSw+bNSL4IcyOH0pKufuZ
 x4SAFQnlLav24qYgUdVWDcpsnHxTcam0YZAbkP/OSc7L2wRzLSgscFtQXPbrROCoX+Cl3G/YrN6
 4FShMrAJGGQ6Zt7h+1SsuNdD4NlEHbyVRY0dvD0VaIpqQLU6wePa6pVTPfDwSoCsElo+6cCvcpQ
 aJET6a7j/Ey3LzhXKckvxslQBMaWn8Eial399BET5Q/6QsEE5ZWTMXMNEEgUF7RmQMgQstnfChW
 fYKl/9R2EoR1F9zMVHtsTPiv3Nn82qtZkUpEn/wNM03tEQCE5Mi1xGQWX92INZI0aw2w/dxnNJ4
 drwSne34HYyN5Ty+qlmaOS0YxsqzRon3A5qKKrn5KM=
X-Received: by 2002:a05:600c:34d1:b0:495:7561:a9ed with SMTP id
 5b1f17b1804b1-4980c679d9dmr297266215e9.17.1785793833068; 
 Mon, 03 Aug 2026 14:50:33 -0700 (PDT)
Received: from fedora ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fdf392sm44274645e9.11.2026.08.03.14.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 14:50:32 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/nouveau/iccsense: fix memory leak in nvkm_iccsense_oneinit
Date: Tue,  4 Aug 2026 02:50:22 +0500
Message-ID: <20260803215022.172201-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
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

nvbios_iccsense_parse() allocates stbl.rail via kmalloc_objs() to hold
the per-entry power-rail table parsed out of the vbios ICCSENSE table
(drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c). The only
consumer of that table, nvkm_iccsense_oneinit(), copies the fields it
needs into freshly allocated struct nvkm_iccsense_rail nodes but never
frees stbl.rail itself, on either the normal return path or the
-ENOMEM error path taken when a rail node allocation fails.

nvkm_iccsense_dtor() only walks and frees iccsense->rails (the copied
nodes) and iccsense->sensors -- it has no reference to the transient
stbl.rail array, so that allocation is unrecoverably leaked every time
oneinit() runs.

Observed with kmemleak on a KASAN build:

  unreferenced object 0xffff888104cbe480 (size 96)
  comm "(udev-worker)" pid 526
  backtrace:
    nvbios_iccsense_parse+0x217/0x740 [nouveau]
    nvkm_iccsense_oneinit+0x140/0xdd0

Free stbl.rail once we're done consuming it, via a common exit path
that also covers the -ENOMEM case.

Note: ret is reset to 0 immediately before the loop rather than at
declaration time, since it is already in use a few lines earlier for
the unrelated nvbios_power_budget_header()/nvbios_power_budget_entry()
return codes. Returning it unreset from the done: label would leak
that unrelated (and commonly non-zero, e.g. on boards without a power
budget table) status code out of oneinit() on the success path.

Fixes: b71c0892631a ("drm/nouveau/iccsense: implement for ina209, ina219 and ina3221")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 3ccdbbe2fad0..6bfe4913dcb6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -239,6 +239,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 		return 0;
 
 	iccsense->data_valid = true;
+	ret = 0;
 	for (i = 0; i < stbl.nr_entry; ++i) {
 		struct pwr_rail_t *pwr_rail = &stbl.rail[i];
 		struct nvkm_iccsense_sensor *sensor;
@@ -280,8 +281,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			}
 
 			rail = kmalloc_obj(*rail);
-			if (!rail)
-				return -ENOMEM;
+			if (!rail) {
+				ret = -ENOMEM;
+				goto done;
+			}
 
 			rail->read = read;
 			rail->sensor = sensor;
@@ -291,7 +294,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
-	return 0;
+
+done:
+	kfree(stbl.rail);
+	return ret;
 }
 
 static int
-- 
2.55.0

