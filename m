Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E6FD35144
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF5C10EC60;
	Wed,  1 Apr 2026 07:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnEazit3";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D6610EC60
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:14:50 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso1819361f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775027689; x=1775632489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1Zg9qefULvMA0VEY6YtWmjW/Qd6isiaJ36QEzyOFMw=;
 b=CnEazit3bQic2kmIdFHYeC1ATkmGO0ki/EuqfpHql4OrHfjIsZNAfnkAoHuzaUqtOH
 n4laUcmE5QKIpoAN8DQUiV45SZnd+AjuoS0aGqv847/G9CEOe8cx6t5aaRgN+qhmhxFd
 G1Nmnze2XSeU0r0w9DccgjlGmvH6SlpSoHx3h3rLoxqEr4FCEn2y9WZRMdJxGFpc1W24
 0Q/DxMC+hycEE9njin2BBbay8kN44G5ey6zWkpope9aIk5rRnD77VS9LG09mOpRIMMzV
 hop4EbOI42sgp6WEwEsKn+Pcly1cSHKlBHx3QWYvMlKxhDMgU848ASeje9fujPsoXq2o
 v/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775027689; x=1775632489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1Zg9qefULvMA0VEY6YtWmjW/Qd6isiaJ36QEzyOFMw=;
 b=aMB2UqXifL4jNzTwtxux930w/TqqndHaAOcOw+FayGiaEtI5tBOucv5/xkiR9WWz8A
 AIzkBOYyaPgq2EH909kOcNBHypj9reSm39AJvkdyl47Vhl5bDn6FOaWJc0Ir8SO9h4jE
 FqsWwiXYVbZKnDU+OvMS7aR7S+5Uoi8gfQihQEpL5SxuG17qE/rVv9GOn7aGTFNYzKd+
 zvBwmF6xDf1cGje5J+KBoIIS9i/swDCwaCqBnNA1rhPlUNzfxbKGNOvTGJpUbqTYCMfx
 U1YSQbZ6SusskRY+VHxFuGGelavh4/hei2svwGtYKPPYeNbBKKi+C9IdO5RcN01TZZzU
 JMDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQnh6WDQhdm3XoK0TVkXeAG5/q7UBrv26TtS2eRtxrzUXHsR6Ye62nZYm8KFAcKCfhY1geokpA5JA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2iAidFvCOCwk7hYnlRuUTVdzxvLP/2F2z6fKP6FLMohDTgCmw
 +WMQ28qeYG4ZKigGlxUcMKBY5cUSiW3Q+TqpDDvlY9yxURmUNfnDZ4fDhIEBe48v
X-Gm-Gg: ATEYQzwa5EiUixmPSJmAB/xN57S0OLuzebY0DNM6VATgATPj+Eh9UvQUf2oIl3txJXZ
 UJcDFVZEEto9XakZZ8UMzFwPQZc5KDqWEie67MT0RxDBDk7+tM9iAEHYni6bC3E/Y6uY2da8QLA
 8DrgYtOrPjh4UX86KWP0D34wKKBQjrRhFkiKa8dnB3pFJn/RKyotVSVOzE/Y49i3XZcs5U5bSFy
 WBe2rgxYn5ZGptUnvT2tqwIwaem1SmJeeIvJig6hIMbmjLXkodQhh7JK8VroFBh0wT0hAf+YZbc
 rp19e6qmaitqG4YSjkAz9vNfgKZy2i9JRVi4CVHUfMN06BQQ5GCE9kxtdUZzo9TmW9uns6xPR+l
 svFATNgFc5Rxh2sO+kCZXYIsb1eWczOSmUkr1YSwKZIiRwjx/NH3adkujQn8Ch7Kmk+trJoxYoe
 Q16bRNN74nf/6oo1RLCEWoUJtw4Sv9NePUvf29lnI8QcrHfFWbLWeW+km2TXc=
X-Received: by 2002:a5d:64c5:0:b0:43b:95ec:992c with SMTP id
 ffacd0b85a97d-43d150b87c3mr4337989f8f.23.1775027688724; 
 Wed, 01 Apr 2026 00:14:48 -0700 (PDT)
Received: from ionutnechita-arz2022.localdomain
 ([2a02:2f0e:ca00:8f00:8f20:93ba:1e9a:9f08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e2f6sm34598225f8f.18.2026.04.01.00.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:14:48 -0700 (PDT)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: ivlipski@amd.com
Cc: IVAN.LIPSKI@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, ionut_n2001@yahoo.com, simona@ffwll.ch,
 siqueira@igalia.com, sunlightlinux@gmail.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/display: Wire up dcn10_dio_construct() for all
 pre-DCN401 generations
Date: Wed,  1 Apr 2026 10:14:46 +0300
Message-ID: <20260401071446.91826-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com>
References: <22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com>
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

From: Ionut Nechita <ionut_n2001@yahoo.com>

Thank you, Ivan, for picking up this patch and for the review.

If any issues come up during the promotion cycle testing, I'll be
around to address them.

Best regards,
Ionut
