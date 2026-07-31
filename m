Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08663C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455B510E1EE;
	Fri, 31 Jul 2026 16:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEHHv9el";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0139110E1EE
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:11:27 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c166ec26696so17429666b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785514286; x=1786119086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNXKFZWI3u+GyO4UBU10scwv+ImHf9jHPS32+l+/nu8=;
 b=MEHHv9elli7M1qbamC+O1lxb5UfiRwsoayaBEC8Om2apEkve/U+SXktHt3tm5bcowA
 ETAPrqRvWX0uPoVd2R7B2Nrdyd1KE0WxTxHsQ9h2bszI23Nn1By0+XHoELZx8K2XEDdq
 zNwWjom0IXK7pU0CF7pV0pTSmZRi52a9+WX9Z9XXjEGqjJozb4ktnuepEVDp0IXJ7Qx+
 CeGS3fMCnOpVMk0HApWpqfq75JE6CQpAeHH3d5A8+R29DQtV9lZ6WbOCOImVl3Nx9hMt
 g7juPE1mr38hssuOiVXFaHiyx483ccPv9ehmkDkbzY2BGvnZp0dXUFhM1Q6uNtOxvd4P
 myMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514286; x=1786119086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wNXKFZWI3u+GyO4UBU10scwv+ImHf9jHPS32+l+/nu8=;
 b=Q6lj4qbDfnMr+CoESbHeAZobvuMtbIXJxl0j+N1+FGfOrcjgvEHsWnoIXFFIrQecif
 FOAljJ4kPcaNah98GaYASkbdZyUSXvPEnGCkNYdkXHNlUE9aknDqx9DH/I9Qarg6y591
 roSg+RsrArF73UaHBiQNzO/sDyJea4Vp26W9s8B3M+WHLRFOx12oFgauoZmgVg5HTRGj
 OffQctV3DjURd0160VxJdXEtFXXwJLb3r99vx2zbwb/VceNXrSPg3HJZyaBDKO7fl7k+
 N7e7Zog6OPPw/hzwzBrcTQM0ubQ5pXmaKTYVLUcEmzuN4jgJ/fJV65R20cd+/B32tyK8
 iJqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5dHteElFdRVnn6eOXTTdPbmWhMst1ptaGxu8O5kKYYqtXZG57TtMSiv6dmFkSqTFSC78Trvjvf9k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsdOrN/tUMvje3F3iMKg8AGGc7gTG4bxyy370J6CSs5IhW1CAg
 sO2rRz0q95WU2FHcCux9Y1gVFPu8KVz2w10gM1Ee9F2Ep+S4D8bYtFD3
X-Gm-Gg: AR+sD10DxV1oc2NKqdNj+vAol0y165KM2giWcGYfuna+R0LPjvdQ7UoR01dI+EuO7BP
 oIiLYYZ+gnnU7cjRYJ0BvV71lwbNB+4KVFWzZ5Q1BDXkVhLcXO14NJf69JN1Tq3deMSSCQTU8ok
 uc1O9NscVz7O8KX5Po8XNAG8zqadps/dEqGp2UzEQFeN0H+Z6QDNhc3Fk1/l+mjaslTmRNrae0n
 U1ghIiZkbv64oCmbSRD2Sm0bxgm0C0q8Srxb7yNZiBDva0y3tgGhPQXAmfmYQZNCaS1QyuSlCAe
 C6C3Xx3muOao8kNNC8XP9dkfQu9fq6qmNvKD6QPvM/Hm+Unq8F/HFEgwPS4o5/z9Pbef/OHJEYj
 h0K2dXLqI2F+0F+dcnnNUOyCM4g3mLJSb23hGD4YFzmxAcX4bXnNMHXzeRzmqadxJMVDf+74URo
 md+ODEH3o6h3NFTuFQe4s7gKdap0cducNWpyn8CeXI9h1hO1uUJEHgab/wa9LwMmA8Z8HmmRyNW
 fJjHUgDICYVRSK7qxPbMt1pLsJJWX1KiIj6NIqFmtrD0lixq9kJH4WSa8mmRxe9UHH0s07zXNhH
 4nA=
X-Received: by 2002:a17:907:9616:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c1fe8257a96mr18955666b.4.1785514285948; 
 Fri, 31 Jul 2026 09:11:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B8B002291A327B8340D99.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:8b00:2291:a327:b834:d99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a1abfsm5826173f8f.37.2026.07.31.09.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:11:25 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Oded Gabbay <ogabbay@kernel.org>, Alexey Charkov <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [RFC PATCH v3 4/6] accel/rocket: add RK3576 NPU (RKNN) support
Date: Fri, 31 Jul 2026 18:10:26 +0200
Message-ID: <20260731161026.22112-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731043507.1832277-5-gahing@gahingwoo.com>
References: <20260731043507.1832277-5-gahing@gahingwoo.com>
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

Hi Jiaxing,

You mentioned you cannot exercise RK3588, so I ran this one on mine.

Tested on RK3588 (Orange Pi 5 Plus, all three rknn cores). Applied on a
v7.0-based Rockchip tree rather than next-20260730, so it went in with
small offsets in rocket_job.c, but the RK3588 paths it touches are
identical there.

What I checked:

- all three cores probe and report their version, runtime PM suspends
  and resumes them across a 60 s inference run;
- a MobileNetV1 run through the Teflon TFLite delegate is bit-identical
  to the stock driver - five output tensors hashed every iteration,
  4260 iterations, no mismatch;
- throughput measured back to back against the unpatched module in the
  same session: 70.99 vs 71.18 inf/s, i.e. no change. (Both are above
  my usual ~68 baseline because the firmware happened to be serving
  the 200 MHz request from a different clock path that session - it is
  unrelated to your patch, which is why I measured the stock module
  again straight afterwards rather than reporting the first number.)

Tested-by: Igor Paunovic <royalnet026@gmail.com>

I also went through the RK3588 side of the soc_data conversion, since
that is the part your board cannot tell you about. All seven soc->
users keep RK3588 on its old values: num_clks 4 and num_resets 2 match
the previous ARRAY_SIZE() results, and multi_power_domain and
poll_completion are both false, so both new branches are skipped. Worth
noting for anyone reading the diff quickly: growing clks[4] to clks[6]
is exactly why num_clks had to become explicit - leaving ARRAY_SIZE()
there would have made RK3588 ask for six clocks and fail probe. The
conversion looks right to me.

I am not commenting on the RK3576-specific parts - no hardware here for
that - and I have not tested 2/6 and 3/6, since those are built in and
would need a kernel rebuild.

Thanks,
Igor
