Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF44606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=B2T89JNY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4CE10E90A;
	Thu,  5 Nov 2026 02:38:53 +0000 (UTC)
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com
 [209.85.160.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF4D10E90A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:38:47 +0000 (UTC)
Received: by mail-qt1-f228.google.com with SMTP id
 d75a77b69052e-53665358476so14355661cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846326; x=1794451126;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nfAo8gKwyjLZUCgQEZBMJt0Gv/Zr7/LHlFcOJKb/c4E=;
 b=Mv4XdMT90RChc4K949HxQ6cda5oX9EnfbPz2Uw11v69g337rfPL5oTW/ad7A4BMiwj
 2NsVvpxtROcXAW37y19ihey2+qjiUkfrSwzgvbDq2CcuH3qOcQXpHGvAjVFs8IZBhVTQ
 3SqiWWD3DzULuL0zg0WK7jXuSIpqUKsig5oD2xgek9BLY2XNbeFJcCkBTEtRrQRfYYIL
 EoISNT8H2nDB4FA0HlNV9fHHI5XgUCg1Ngf6yZ1RO8ObIdfRJo+MZuIAPcM5ijJUqrWS
 nOlBNVCuTNLki23kMh3IAVshPL0XUkn3/ap50ZYJZfFO+1KKwI0ESe/W4cDR/m0NKDdm
 auGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRMmLhqJIofxQc8as4bxE/obHbachMBSeqPCSMgArE5pOUThH4qMKfh9z+0k5tB6bR+5K+iHNnssM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pb23lJY6j+zFkmy+aDF42SuoDRjPx+9yT0FmRpxU95ZF0vt6A
 51XY/w+swoe2KVKnUycss6iWrBOE7tWKX3HJy6wsJSCkIjHyj2QLhSxPHKu1Hq/6pdyp9J5ojlP
 /T5X0GIrS1V9+N5o8E/H+li4ra5qXhkxRsmKkbmbrHVfL0bHtstqCWlC0YXr9oa09t765uwuEML
 ZK11oaT66JwsFbjLA/wos0Bd27drvhg7M68vaQh9PmrjwhYS+GuvWanIvkfstb6nBipKvfSOMLm
 dLHd7AiGidyT7mljQ+4Y4FmB/zu
X-Gm-Gg: AYBFou0Kbw4arTvwB/FT1pVtl70jMXxwcU+rwHKC/QcG8VKS2xYRp3j+oUpqV2ipsRv
 WigZtqIc5r7jO8W9rLCD5z7GJkfNhWQaZP2qrKbbMDDjotD6uAvL9D/E5PKhNZyEq/b76h1LzcY
 ZnqPspScxKAhhlZyCtOiY6evuxMcYvx3H3DEEbSj1CdacZi43U9KMnSfIBqM+GHhxbm7khisUze
 sqj5xpDmfJ55PsISn5ENNVfJ/JPU3n0aqit50af/sXurxTK8y77s98zRm3hKUUgaEZ82Pshff4E
 ZWg1GOlwb+s0eXjmYseuc8oYhIpJqGLhZ7HmqGNXJIeMbVKbJuMxoPgKfK7fAihBcZ97lflc7uU
 oApFdRVbUhe19GIe1YzQ2nPfja0y0PwH595U2UmkbyJn/c/35fa+E87iGBmhtJpn3ejKzE8xF5I
 E1S5v1WoYI1DiLOZeTIEhxySwdqgY8y5YPdWfZtHCC
X-Received: by 2002:a05:620a:2b44:b0:93b:cb6d:6d73 with SMTP id
 af79cd13be357-94421668073mr3074311485a.32.1793846326483; 
 Wed, 04 Nov 2026 18:38:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-945d478e7c2sm50416385a.10.2026.11.04.18.38.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:38:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so882457eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846325; x=1794451125;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nfAo8gKwyjLZUCgQEZBMJt0Gv/Zr7/LHlFcOJKb/c4E=;
 b=B2T89JNYhqU/TM+m9Ue2DOIIzhpbxV68p5wcmH4H/0J3nn0LWgV9Clg2bDS22nPYrp
 xLAF2zsZsVgqugRDd0Uy36nKjC4O0Z0PemxuDDaVnVSsP8EWJNgdXB816CJL1ls3DJwp
 zPOyF/gTRMNlqhTvzBqUDhH2epDzN3dXnjMiI=
X-Forwarded-Encrypted: i=1;
 AKwUvBzzV9FZj+KPje2PbnxlVmr7aAtZ1Ve+pPMlGZ5fCen+nYhM8NnCzgBEC3EgTqptwbU85rHSTrKH4SM=@lists.freedesktop.org
X-Received: by 2002:a05:701b:4515:20b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1ac5b5ee671mr26473763c88.27.1793846325039; 
 Wed, 04 Nov 2026 18:38:45 -0800 (PST)
X-Received: by 2002:a05:701b:4515:20b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1ac5b5ee671mr26473730c88.27.1793846324249; 
 Wed, 04 Nov 2026 18:38:44 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c1c272sm11813857c88.8.2026.11.04.18.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:38:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:04 -0800
Message-Id: <DMMXH9KG5DJ6.UTFIEPC9BAQO@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6/6] drm/vmwgfx: reserve cursor MOBs before unpinning them
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-7-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-7-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

