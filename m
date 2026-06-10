Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8982CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 02:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04AF10E418;
	Wed, 10 Jun 2026 02:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cfik+0nw";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86EC10E418
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 02:10:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso6276016a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781057408; x=1781662208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzcM/BsSmQHmhGhlf6vveW8ZgrRqVlXrTeTt+urqMw8=;
 b=Cfik+0nwE3uPoKlBxaroXlQCySE+4aJZyu2vrk1uGNbrwjZ+dyWg5fozHvEOXYAVXv
 fHqHLC5NOhB8z824DYyUWmMBTshiu/LQEvilTzPc+IJVvrlLw+lgvmEMP8sHd1fFvrQu
 xLHnZD8pY1PHpznDCbrV+NdoyGeo0QtiYJQVomhPkCfwlnSLfl0IIToMZOPaBQ3LwWjl
 81/vacPYsDEaLzu6umCo/d+i00OsI0J7iTTXRikFw0bcJNsI78OUpm+tAoKXtrp4YeFO
 zasfJCU4hoVuY96HwZOqQYi9VfSlloXIWONGM0nRPvjb5e8GshI8yYlwVzqHxQ5WSgWO
 Cz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781057408; x=1781662208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AzcM/BsSmQHmhGhlf6vveW8ZgrRqVlXrTeTt+urqMw8=;
 b=rXf9xdvCYScPdETmLb0Gev5cKj2qvew8/0xaiuQnjRvw5y1nAAJanjL8J5gfPMo18Z
 iVBgS+XUCdvAtlJ5Oxy/CjsLS1fY+0zghfFJBYj8fr7e774gTz0+00eTe20UutXqROmn
 ndJ0BalPI4D6MoO4YKGU5vxRJSXZ5lF1pLDTVdiR6GvL2ACp/gt+s3DcCzgWFmv+1Rs/
 QXcrOFZIqEsCkqske7pKmaSg9JMD/72lk2KocOXSKqRdjAw8GEgx3LsDTybrnoDXqmQu
 yTUfyNzhuOGry4Z7u8HcyX3MElafSbmMbE4pqD8Q7ZqD7ZhKQDo1L13/+F694ovapot6
 jokA==
X-Gm-Message-State: AOJu0YxKfm2icuLnWoyiF3AX9S2TcNiTxvjcGOzWpVNX+LQceY3NAN4K
 q5JPQtflrNctwaiEKZ9WA2gardq77Gk58tQpQ9pokldg5DvhfOQOxO/D
X-Gm-Gg: Acq92OFeJyt2PTfGxN/TJekbaqRIZAQlYXC1VWH8WIhLi6p1pmVDkxnYMHLk2dcCjkE
 BPyHe9Lty8I/XjlAE1HVUgE5H3hwLTfvKKHviywKjqzOvOesAUnlxI+Gkc8e50UFL1CADbsN7Bl
 yJP3Ans7ChyCmWdRCHWrPPeOzpPmBhID6GO+CLg50p2PQL1lPKjQqO4tPTKgJF4eli/6SV2nh4a
 J+RGkVGFh3e5xNEcnSHYB9tPZCu/AYj6286FZVWAIAZGnLFxBWeC3k5WLAVzxzvRm2vFIh4zYDi
 JAlNidLqmQha5R31kYti8SZAb6j6Ha5sRoQdjt/xoDDISstmEfjDI/tRST0h81rokCXInpwvbwf
 yi7suMGXF5YdKRwt/y4PZmIMr5MXFMAzXAkVlGBuYQJpyK9t/ij9uHTgTmLZuSPqv5cQpkh4obU
 V1ZMDR/QJ9gGellH1WrsrX1A10MeU33fOdLJcRG2KNE7dNHyxJgjFGBNzfOrSuakpbL6dlkCr0t
 59J2U6g2uJicMjv6E5QQPMyWECq7DRs5wzRplptCTWZ+g==
X-Received: by 2002:a17:90b:57ef:b0:366:52fe:e749 with SMTP id
 98e67ed59e1d1-370ee82fe8dmr24233876a91.5.1781057408350; 
 Tue, 09 Jun 2026 19:10:08 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376245bb9f0sm831289a91.9.2026.06.09.19.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 19:10:07 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org, onlywig@gmail.com,
 zaq14760@gmail.com
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Wed, 10 Jun 2026 10:10:03 +0800
Message-Id: <20260610021003.2112300-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
References: <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
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

Hi,

A gentle ping for this driver patch.

The DT binding patch has already received Conor's Acked-by, and I would
appreciate any further comments on the driver patch.

Thanks,
LiangCheng
