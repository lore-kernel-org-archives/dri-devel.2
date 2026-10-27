Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB92606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gdmXKYbb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A63510F331;
	Tue, 27 Oct 2026 09:32:12 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF79010EDAC
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 00:15:47 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5e948e56af3so1580934e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060146; x=1793664946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwQ+6JoAKufPGf0cTjRHYZdyECle7CFEoH5DFWVwgnY=;
 b=gdmXKYbbXnmGgET9W/Cu8yGsfRoH7N6v6eT0HXKnJHS8NyGDw3JXUUNDF2oo67jR8E
 Z9HV2H204ZvpDHUeMXwe/+fATtja70NFqaUOhdu5uZPXDkIhOPkQe+oghcwh7oc73QJZ
 l28815csBXltFOoIe8qGpf8tNIxXqrEbg7Ewe+LLeBya9tCAQKHIYn8AIDTk/XGLMqo6
 yz0sJESk/CWLJ6PeTmOf4hGBUwgXBF5Pb+IYIB00oJgE3S1JyW9hBwVdKmDH6kSGqWgq
 F0aoATtKAUNwL4OvuQZg7Jpn+psfG0Ny1EFM9UtDSSNO0PCBZn0r0VidgQ27ITmLTRcx
 pv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060146; x=1793664946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwQ+6JoAKufPGf0cTjRHYZdyECle7CFEoH5DFWVwgnY=;
 b=AYJNeUTCd7UjWY6+K/GTgl5mWMpeFvbxC9xVMkxz7iz897x2sPifXDv47Vnf/oyRLc
 03ghar4j7z5grwGm0ewh7kUp8XPStTFz1Zv/wYj6xT/nLjB1EOgMwXlS9NXiasMlmcS9
 2bNlqRQ93Hoa5yT/I21nOPEyD9Eumk+e9ZRumAw6wQqyoq19QEcDDXQfFMkq3VhgVo6y
 jMe910IrqDgAdd9RSPDYgMz0AmYCOsfpCTE2LScdgJN4U3ngRv8YeXbEe8rIb6jfxuWp
 SqdnPq8+7zuA8odzGhndm808fe60gzfW0MFUXU/77HXUQIgvYqmzrk1XnTnHdcr9VyUM
 K1bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL+3q0Ye9ciPL++cp+KiqT1q7HBR3owRp804rzSw8JwNCmtsrvx73Wfb8S3taNvxXYNHl/uk2dUkU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6HSKi/YTb4MkOojvLSOmCdydN8RPoYWTO/hyKJd3iKyGAKiiJ
 YT+8XAEU2ZekBgisoBPbY1mN0FQjjxupvwFnswlRsllgyjtb0ZgF23KW
X-Gm-Gg: AYBFou3QDwsqhcIGLqBUd9FwKwKFV9tBCJ6/nnrj0w8l37jJ8F9KuwtE7kBDyFLDot2
 0MOzPAmfK4lNcp+qrWoD8zi53ItWZ2vL2XpnSNh9PF8sfVpdwCTEM4PTY8Kl8oaVazXbXgvK+Dn
 rFgvzudjY1qmst65LoFDvTUSIOdHBeemluxYlAXSFy8tLZPXMj2KUKv6nVRaTQ4b7VAnVl+lcc9
 E6NFXMQhK2+ICNqpZH1V9gxLyuNotuuxUEq7I223aff0Lw1+mrTeGb9uMIs73wvZHEGacAWEyc9
 wotJYrkvz7RViBwIjOzQ9iNy7g2PLev7ZLppepAwOT7wuVeeE69PzFUObDtjUGgbJiiTqLeYaqe
 jtYRY2HsSnYW+l8qqOHcEdK2J22S1rfteWlf8niWfNEK+ACMOtlCPN/uV4UPgNlQumbh6rv1jXg
 4MPRmS6HB6sxFQ3Sq0+jv5hSGdMcNxH3gzVqReTrgHLoVHivebZDFnjJfhSG0wYOAr6wVV7dKt1
 b1INFq5YSr4Fkie/YzNXYyrfIUPtx5XQIpWgW9DmIKUtHDKfDUXlfHp4RGLDK8JH4HBrjuM4HVK
 ZRGyTdLSbELG82s=
X-Received: by 2002:a05:6122:c443:b0:5ec:3e18:b06a with SMTP id
 71dfb90a1353d-5ec3e195f2amr793847e0c.0.1793060146333; 
 Mon, 26 Oct 2026 17:15:46 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec232758d4sm10068856e0c.1.2026.10.26.17.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:15:45 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
Date: Mon, 26 Oct 2026 21:15:03 -0300
Message-ID: <20261027001506.27266-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Timur, Christian,

Thanks for the input, Timur.

To be clear, I'm not opposed to a backport. Fixing VCE1 for people stuck
on the radeon driver with an LTS kernel is exactly the case that made me
look into this in the first place. But my goal is only to help, and as I
said before, I do not want to push a change you don't want.

Christian, if you'd rather keep this out of stable, I'll drop the
"Cc: stable" tag in v3 and leave the decision to you. If there is a
specific concern behind it (risk of regressions on other SI/Trinity
parts, say), I'd be glad to hear it. I can also try to address it, for
example with more testing, so that a backport can be reconsidered later.

On that note, the SI part was tested on real hardware together with
patch 2, but the Trinity/Richland part only mirrors the existing CIK and
SI handling and has not been tested on hardware. If anyone has a
Trinity or Richland machine and can run a VCE encode with the series
applied, a Tested-by would help for both the review and any backport
discussion.

Either way, I'll respin v3 with whatever you both prefer.

Thanks,
Matheus
