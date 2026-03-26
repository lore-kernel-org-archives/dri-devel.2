Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E0F10AB80A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E886B10EC01;
	Thu, 26 Mar 2026 18:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f6sNWf4n";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD4110EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:02 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so971238fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551361; x=1775156161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkvDWdY7OmvSXSpjnEXWJTz2q+ynFgJjHoQA2h5Gn4E=;
 b=f6sNWf4nDUQIKef+ex8VL4Cihv0ZtbNl98WZhd5bg5JWD2e0bybN0NSAIzH0JxO3Rw
 YjGyIoJYrp6dc8zMNsvMo4IoWCreyEyJLcF/pG/SboNpr/Dyuhy7Pxmp57RwZ/NQ0797
 /bIB6f7RV4KupxX9Si2zq5PzNbKkt+z5lZ+mqKOtv6lrOMXnVEJf6d2ac/+yAMUXqcoi
 sAEsXwS90Uy0yRyZBXD+nQEkYUJZbVWaTTH6QXxjQdK4PnDn5nVokv0jeitEkZhVYYyw
 8GXV8C9LW9Kb8x9glPnhUicW51XlR4rS376ws8aZiipU33/RaDQnmlyXv3C3uFUNwaZB
 1vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551361; x=1775156161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkvDWdY7OmvSXSpjnEXWJTz2q+ynFgJjHoQA2h5Gn4E=;
 b=i+9zgZHOSGTJ0il9BsxFnrgvrFc63/9R0BxnC/cYtR62sb7UGbgsY317P1QvOl0QsG
 LDldFF46eEatg50pfkND2Aog3tsc/yUc7/xpKVkanec5WXFf52HCjk6lallmyvHvb1+a
 zUR/5GJYAKgbyiZeAp8ErboxcJlewz3e/0Cr0kL9KsAOIR3yUXv/v+T5mRwHd56B4uqb
 O6dxTFgeSPbCiQ/ctGSdjLoRAHm9r3k0yf+92+OlCnoSpSYvq/HQyVg0BVcIUBwpQaGD
 nz6IUUFO1iRB+vQt1NB8guIGiuhe/lNvJPRGaRCCooXtJ5ngFi1LvTCl6MHgglb0FEGR
 MAAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxTb9ao6HQlj51xsieW1hxWT9jPucbuVQ568seIfNm3889HNDXml9SGQw/Lo6kbP1vhL+CER3vef8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFgJ4dczln+HOebNzrzpQdbdpp7omTAm0tHMrjX/Gudf9HTB5Y
 vaPUFeMs6GyHJgponrsE5k95fkHyB4ApWZfwoCMV0SV+3RXWKJQ+sIlr
X-Gm-Gg: ATEYQzxWoKO4fBZRDua8dRskkNbJSH2hXrDV2l4hhUoAVN6FdE0BFIC2xTFuYvogIX0
 ac6/7vhfnRkmbriwXf0ArJHCy+SFav7HCeDuM1TBq5b44K+AU405R8rppvHkkx2eM4GRGxEanSb
 Ts/a6nPToQG4xIsUa5tCYZ7GWwDbij6oILdINmK5cKRZE/oueJIxQJKgOCUVJhbzw2fP2BcIT/S
 Vct26V54qZIkQoSOp1pQrNIjdWY94I7isKPskUJPhhQ3Lwtv0LArihXLktezFKjuead1KlWv7Sv
 odhEOnwT1t/R/rz9qFwPFGRW1ThII3cRU4g19Ym0TgRv6t4Ah8WVYp7IPTQ11VMfz4ni5z5SoQq
 RsdqGNufUpFurC+4ix815NwyJUC3Hcejjh5h9wfYI2ciNfg21VcsssKnPczY/VNhp0Sa8IrXpqn
 QvXeTH1cL7zv3BND1XCGeEZne3RH75EAvnuEuVsAqW3z6cFAbf
X-Received: by 2002:a05:6870:b14b:b0:417:56da:593c with SMTP id
 586e51a60fabf-41ca715dbeamr4692008fac.45.1774551361348; 
 Thu, 26 Mar 2026 11:56:01 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 59/69] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Thu, 26 Mar 2026 12:54:03 -0600
Message-ID: <20260326185413.1205870-60-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

The udl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/udl/udl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 08a0e9480d70..58fea20a1e81 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -21,6 +21,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
-- 
2.53.0

