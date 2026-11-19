Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPJXm6Ap
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E9010E6D8;
	Thu, 19 Nov 2026 16:27:55 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72CA10EA54
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:24:20 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1b3acec6677so3496175c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795105460; x=1795710260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=veD1Lv1Qc2uM/q6Ciz9j8weM3Qao0zuakaCteeqyqzk=;
 b=hPJXm6ApW+Yi+XOLypRQ/LTEvTLQgwy8+lObXdr5M9M8qlA6UyfshcyBkc6Ys03jim
 4yzQU+alATWv8PRsWDPoZjk+jBVC/z8WD14xOLIunYswhtWtnDVMBAs0ufh3fIo9dC5s
 b57q6H267Ojqu/G4/x2FXyOqzTZbHi1G1SZngvWYI5wzVl53uH5V/UFjGPon9tGcIk+d
 dNOm1H6bMYoC7nPMiYRfBaQHp49T/njGL5Adrnpcd0sTjtMFjPlMH/8msQSHFo4nnppp
 BsBeW2ntf93Gq0ablXTb89K1z+YzqbSPRqgh0QaOXnK97tpbgIq+Lu+kUYM5ddbRn5RN
 N99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105460; x=1795710260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=veD1Lv1Qc2uM/q6Ciz9j8weM3Qao0zuakaCteeqyqzk=;
 b=dEbeK0WKOZSbNovaGDeR1yP2RcRExI29MoCBeZ+YSRKqKMazbE+jCtMDSIxB+BlK8Y
 zQ3frVNyRmy9tklQfUtEeYZ9IMtdb9R0Ze6ORDu4xD5Rdhk/CjyBlM0gfRVCi/plQ8nb
 GtKedROA6hxNwtnVNM61ydEHHEPCvkjI5gTonJYcmLIIu/lzoTO1AZT5Hpr3dJikG4UE
 UQJmIjcwDXutQA75FXdNQaCwIFgqZ1AP4kt++C1gmxY2iIBPFRxEqL0OruZOIifb+02H
 k3a2paIlO8jUqVU8aRewyz+vaC70APBCpdT3lQ82NLFOOgvcNwWwPLBhUpzCXqVXNywp
 7QJw==
X-Forwarded-Encrypted: i=1;
 AL+hErGewpJSt7zuy2dlWsdFn4zCaie/ZmlbmJF1VcKrhujg6ytfp3jjU9i1RDVWwOwngpU0ZXv5u5RCQJs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LPgsGr1MMdUmxu5CvrJHfkOIDExt1/T2oJOCl4RD00T4NHkyN
 z/hOwvLLCt61YC3tUEZjBBa9VaU73t4prJDCU5KITrGR7dmI4inKuy2Q
X-Gm-Gg: AYBFou0STR9Kjc7kbtpEGuJVggRhpsfTD7VC298LzIHqWoHL9UhNYzahJMNg0A+kfon
 T3k54shGXLWNaxBo/4IkDaxcwB6DuFE8G8QYqFUqHy39OKSElGYlOqXaeMnF+5B8qzD7i+LU6ce
 /R5xS1JXOx+vPcee6Jgi3JS8qBasw+MlE8fhW9JI113O1uR7DK1g18kAIj0bEc9QNLW9e1kKcsY
 PomVGxgaGX5T6nYrpRe6d3hOsxLIjNPSlrpcIfQ9tLVNhU9uUpuXNsiMtPJyrcIc1r/+UXYbXCC
 Klp7mc1WlnC9HSn2bgcMcOfGSdayhRiGTzAq7Kg8qm9BCBopnoKwTGBamUpkxXXqIiUScGAbo5n
 TCK4E21rQVzgo3sHcOjX+dDO0GM/ebcvBS9tBEXsARg7pWjAHsb98mt1ezqHq2zwLAVgFVvWTuT
 ix9JVzH20TZOUkUaZ7VJsbC1H/TjFWDJptD7E1z8LGEA35D0D9hZXY/3HlfWtOxTjBJEWIx0bh/
 ruwY7fiL+C4XNo3OIzM2gkaT8/9j/Neb09U4oc7L/opT69vDLtb7Q0Dp5HtD98uoCeXoSRSbgWI
 ids6krDp/R/ZBkhTRa7f5SuUg9a1j50CEU8XH5n/Z7w3
X-Received: by 2002:a05:701a:ca09:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-1b5568cf673mr130993c88.18.1795105459828; 
 Thu, 19 Nov 2026 08:24:19 -0800 (PST)
Received: from evo.www.tendawifi.com ([103.98.7.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm302840c88.8.2026.11.19.08.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:24:19 -0800 (PST)
From: Archit More <architmore303@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Akash Sukhavasi <akash.sukhavasi@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Archit More <architmore303@gmail.com>
Subject: [PATCH 0/3] drm/panel: Use lowercase hex literals in three panel
 drivers
Date: Thu, 19 Nov 2026 21:53:50 +0530
Message-Id: <20261119162353.12962-1-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 16:27:44 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert hexadecimal literals in the initialization sequences of
newvision-nv3051d, kingdisplay-kd097d04, and leadtek-ltk500hd1829 to
lowercase, as suggested by Douglas Anderson.

Archit More (3):
  drm/panel: newvision-nv3051d: Use lowercase hex literals
  drm/panel: kingdisplay-kd097d04: Use lowercase hex literals
  drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals

 .../drm/panel/panel-kingdisplay-kd097d04.c    | 242 +++++-----
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 426 +++++++++---------
 .../gpu/drm/panel/panel-newvision-nv3051d.c   | 286 ++++++------
 3 files changed, 477 insertions(+), 477 deletions(-)

-- 
2.34.1

