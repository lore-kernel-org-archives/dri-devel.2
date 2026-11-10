Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FA606A337
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=L59nblC9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BD910E1B0;
	Tue, 10 Nov 2026 00:03:56 +0000 (UTC)
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F2F10E1B0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:03:50 +0000 (UTC)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-8b29b83fdf1so608314b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 16:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794269030; x=1794873830;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qje5ZRB8SldFm8mq0Yjsuios3RJj4d/jiM5HJdOzZuA=;
 b=LxH5upLHLbFnp54omRCtMCf/Z/IixbW2PYgUshZ0D9B6Gjn9rTQRljfzJb6rkamaLh
 09EAjCYqplZI8DWj8t+eT8bE+2G2WVqXix5gLJ8ffgreQE+u5UwEQyBeMaf8AU5q4SdM
 7Ftq2/DlfBEva83GyntKiwP1NS/k4r3L4sH4q7pCtXIfi+ZB3yhciA1QWGF/6+NFyiuG
 rcR0WjQGMMZd2mHlFtIVG/NFUGwFiBZV4hx4G8KUbzsGQMdd5PNRtU1T6JJJZPt8dIfB
 9mx2gJeS47anGI0MYjZzGlBlFG05rHNsmOmPxX1GOEm6oddirakJOMjdtPyMSWli9+JW
 4W9A==
X-Gm-Message-State: APuU4Z9UUFHsLcCzX3wowsbP3UGw7dvNqGO3kk9gAqPftb2ftEpeuwpE
 5SXEG6iEvu18c2RpRNIgxrt7xP7jT5TFWAsIoi+SnWD8EXt8xCn4gQ1eexVUqejuwYKd2H0X9iA
 xsa60t4yvW/2k+yVT8yAB1gfM3La7ltNuzVX/83XCB/dtp6cP0UFpgcTU27z3nzlo4QVjfmerfG
 gypnq2tFk8HrO/6t+yM0wpQjmDHKW/ncHfizz89wv0/5n+nsB/Olx8V7hD+LJXyv7XK3cfcEoFq
 3iEZLeNIQpCLUFosS6KPIY9Vj6t
X-Gm-Gg: AYBFou2H3cMoMUKonrg1H3JZwMMjyhrO499R9UKhiO7YMTBK4hP5WmrJQKGARxlEGeg
 uAkoQI81rWHZIBXKSRsC6OwQAxER+40HAF/XWKqbNLG50OBF/FZMxkkp/UaTGdbyHI4RIFKjhhm
 EH1o9VfSjC0rYPPiQi99mUdTuA5GzCX4kV3ZohVGG+j3k7rAW52MXlTM7j3seBDo7q+oDzBov+A
 uShsXF/cDtlhjpVOedSIadiO4MpzVCaXxv1pCi97U0CIkPkwC6gtF+LWDM/lZSs5IA+FJMSNbKq
 5RnYr//pRlfsgxZexYSGIEpPYy1PGXIq5UM6Rb/ps1FXet9aCh6DjJzIk3iTM/JFFCeNlsOkd5m
 2o3Z34/8qGGWCVxU+a7ZNoW56xZQcQZNe4pk2nLKIuQ4VYkKy2QvjV1wO2sWG2xZPHUA4cbnqva
 oC6s73OH1vRx0PUrq/8+vgYxTNwoueMKS1XnTY4oEs
X-Received: by 2002:a05:6a20:5482:b0:3e2:1922:c13b with SMTP id
 adf61e73a8af0-3f1904720cbmr696145637.60.1794269029683; 
 Mon, 09 Nov 2026 16:03:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-8baaaa5aad5sm12857b3a.9.2026.11.09.16.03.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Nov 2026 16:03:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso230443685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794269028; x=1794873828;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qje5ZRB8SldFm8mq0Yjsuios3RJj4d/jiM5HJdOzZuA=;
 b=L59nblC9mVhjI3MrM7eALAtAtlx/aTE0tuan6CkPmsYanWmwPx0FGlxnTZTDUwPtbQ
 U+c11tO825eXgZIaRK3xIyE346BgkSZ90M6M999300OQGXLh8imNJ+m64ogK5CWgEMM3
 5Pz/bM3MU/hfW/esaG5x8ngAdWDGAYTZFOGAQ=
X-Received: by 2002:a05:620a:6602:b0:93f:4f87:4f5e with SMTP id
 af79cd13be357-9479f4296cdmr164147785a.72.1794269028279; 
 Mon, 09 Nov 2026 16:03:48 -0800 (PST)
X-Received: by 2002:a05:620a:6602:b0:93f:4f87:4f5e with SMTP id
 af79cd13be357-9479f4296cdmr164144085a.72.1794269027731; 
 Mon, 09 Nov 2026 16:03:47 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e61c150sm96207685a.2.2026.11.09.16.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 16:03:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 16:05:06 -0800
Message-Id: <DMR3BCBSPSMW.3EDXC4S26IC8F@broadcom.com>
Cc: <dri-devel@lists.freedesktop.org>,
 <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-3-zack.rusin@broadcom.com>
 <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
 <CABQX2QMfQ2TS9Jg4=RewpYStMFOOn1YL1XV4caVnc_dgduWRFQ@mail.gmail.com>
In-Reply-To: <CABQX2QMfQ2TS9Jg4=RewpYStMFOOn1YL1XV4caVnc_dgduWRFQ@mail.gmail.com>
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

Makes sense.

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

