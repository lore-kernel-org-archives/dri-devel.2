Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF50CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8EF10E69D;
	Tue, 26 May 2026 14:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QVjQ9Nwo";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158F010E69C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:18:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso20112005e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779805085; x=1780409885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
 b=QVjQ9Nwo4PKWRW8DuQ+TfWzfGp9QXLJDyQc0tpzOoF1/e44Grg3JTtKZOzt7oBon3J
 bEhGki0niSswqLFOPvJbigANJyx5GWl1kGu2O2B3vpmPtoWf2Kvazu4yEipnP9Wv36ey
 Of7cu9rPyjRuAtFpRiTWxxBsCp69kf1zeGlhySpoHcFB3EuFAm5PxZwD/7Suhi66lTQ9
 fHmLltf+f0WkbcNhXvJUlEPAv6KKwfj7u4F9qr8gxtqvtZLfzsHpaUL1GdYmIZAUjFQO
 oUWl5A0tSNMni9Tyqw7UIJc4+qkwU2BdIdeROGgVReql5/7mXaNLk2dBTRYVarHStdpz
 NdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805085; x=1780409885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
 b=js2j8QJnApaISBBTjjqzeODSXcdCqBn4VljAZ6POfGQLAMUs6F18MAGhOV4CU6xAL1
 BkhZ0aXNOeB/8j5GahXInVOB5guc7x/+GW9jkwAP/DHg9Hfe8u6Kv6t689h2zKkocARN
 +UW7FdIcW7h+Zmnuw9MMF0/vnozqare8Uzk2uQ1Ym0I1VRvtSqAY9uC61SjpfbjzWrTD
 C7ePy6/1tDvEl3VFb+EKkDYKbIBdMUAK7WKUBN8sg0kPwfHUto8SbjbEB3l0ES2Fa1Ml
 WyIQPTSBQ652Cs6j7+6mtVa9pvwNGS2T66Xnrr0XRQnrw0S559Gh16GGqowI+CBtiS0h
 dl4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eM+rL1cmQAwB7VdkY3zO/3AwpHkM38LNYPrTPOngZEaARs9pQPk+RBlFwMar+z/Ei5C5YdExMN7Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5pXtCp6sjXPKZhz5IicbO6iGhouqsvgoUwEjAlMoOoavuVhV3
 dTPw2GUzG4siA0ChlIinzOQB+n6y9m1A2W1fLPCEbSVZQod4b8iY0v60ZvOkuMArI9E=
X-Gm-Gg: Acq92OGaah4pAvjXE/jIYu1jzqTXtb3sY9cqc/OnweMqWX0luAL13yNBOa/bhgTB8zx
 WjX1ZHJmh/kI2aTo91gj4o8WHOxpHsTbcpbkJ8wBns/KWJOfm/7QmqtUDOCfojkyG9awr64Jlry
 ePz8/iySg+n4AMIx/uCSuv68SA1zA+0n1VfhB6IlbVGOzAunLBAQrXwJApLShLeHZ+N+3/8NvKE
 Q4nmzQNFVlZI5yu6XhXTE0Rgm0Lo4LfQH2ahIN+oYBdUewqLrock2F122QCb0+l6hm2s4fcQsdN
 hco7SPH6yKfu0zYH0gadQ5zrp+aEh7BTDUuaDf/h8zotwP7Q8ZmPSP+EYsA0iM9WQ4PetGhux2+
 Sz7bjZLH5FH9OWrq3bPYkfaY/1zhOBze8EF8nI75FbpDqspP5XzSEIlXUxUjyRlf4+fH2G0g/sB
 dyxpDAWuq3g7b5ByuaSJxrwPYpo/0VAeYy0S9EcMd2lSMmxtAXl5pgIBsC2ukvpnkQUDxD8c+v+
 JSCQncEXlH1ZaePy6ricRki2g==
X-Received: by 2002:a05:600c:4592:b0:490:6237:5213 with SMTP id
 5b1f17b1804b1-4906237537cmr145220735e9.23.1779805085104; 
 Tue, 26 May 2026 07:18:05 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4904561a160sm379625175e9.9.2026.05.26.07.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:18:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>,
 Andi Shyti <andi.shyti@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
Date: Tue, 26 May 2026 16:17:32 +0200
Message-ID: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauEMCO+XO5wBiq0WLDW9CPIg9uJbXOSVo41d
 x54C4q2mLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrhAAKCRCPgPtYfRL+
 TjnnB/9l+SDbdriw4+P0R0QawXzQR6RNcTSEDOsG0Za0QxbkFa85XMb5sLwAO0owuw/Rowx6ky+
 QMdsAXUgR3vwvQLdxYJlkEl/VA/XHq/xJJAuw+YZlvI7KLvHFN3YqbmJgo+fHO56QX05JkYBvJ2
 Jk9WKvtvJ58lFHkr+5etBSYF3AixiJ+YBuoVcvjao9lM8EjUJ8SyDU/sXtdjUltWSXQmsKSN5Wa
 cffVeDubVIqpPQNOIDt4M8130VMFMoHEz1nySiOBmpolGD4C9tykhh7r5xGVttivy5+fc/p6kFl
 64ZyNUXuXtZrf+NrGcA7ZEOvBZuObVE5B7q9XxMf4MX80c3s
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Technically it is fine (on all current Linux architectures) to store a
pointer in an unsigned long variable. However this needs explicit
casting which is an easy source for type mismatches.

By replacing the plain unsigned long .driver_data in struct
zorro_device_id by an anonymous union, most of the casting can be
dropped. There is still some implicit casting involved (between a void *
and a driver specific pointer type), but that's better than the approach
to store a pointer in an unsigned long variable as this doesn't lose the
information that the data being pointed to is const.

All users of struct zorro_device_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3b0c9a251a2e..2673a1bd82c4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -640,7 +640,11 @@ struct mdio_device_id {
 
 struct zorro_device_id {
 	__u32 id;			/* Device ID or ZORRO_WILDCARD */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {
+		/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 #define ZORRO_WILDCARD			(0xffffffff)	/* not official */
-- 
2.47.3

