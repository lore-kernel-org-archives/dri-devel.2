Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC95C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484A10E23C;
	Wed, 16 Sep 2026 13:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLQbz6pK";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D20110E23C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:28:54 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fbb11aea4so456675e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789565333; x=1790170133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
 b=TLQbz6pKC4xaALWeLHtfgkK5f9UZYLv7jeOxvHAvdmeNK6v4lncEpm2kyrmaxf3ZNm
 iZ+qLYeap5494WWomAW71lDvsHTd7t5RkrsdcMEFOo3pHfnI33gXFcMWB0yzdTO44NLG
 ArPw2NO4QqO2IleyZKTweEU8FG4y2Y2jPKeRPvyptotPMWi6lykQZIkMGcZ5v3bLk6nm
 S5fsLivGWI06SdW/oUUKX7pVbR79IM36o/BHnKf8Ek+g2iUakqAw+EBfENfQ5QtZx7b/
 YHckhkr3F+63z/U+7ysFa8yyRZgxTx0iaLknwTjIE/smKrRn/sI41JrZm2RYcjkXzyoR
 Qkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565333; x=1790170133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
 b=DX3AgIK4/bxw0zh3CGQTZE55VPxRwy/fmYzZIDkD72OG9xe0aG0ZURcAcKbfSaeACx
 5qwYGKrVkHzBiQRLnIKqspvtBwuVi9Lmp2tcyYgTJ5IVuvB4moak5QvzuyGUAJI6rO8b
 A17kVZ2aIOEn1a+WTvI0AEL4coYn9zm1jlSU6kD7K9EOZTFEq0bGE9FB2GOmbl2owSwd
 fdBDn26wr9pWB6p/5Hpkx62dI4FxKzK0zLPPVP/J0DBAwAIsHD0953vKv0ugPX0vGriZ
 a7Hv1cQOXRYrNMGRn5XIiKbjsVQC88LO+5nLs4/bDogalWcK/9Yw0Fo2l4tJ6h526gwE
 MStg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsWxYAr2uknit15PPT+XZVLkC6TIIIjeMELk62+AbE5KBlsIo55dSsw3InHOK5/tz7W6SYNdVLbhM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kSF77194ENP3LbQJ+H53chfZrZSZ33iK9Kt9G5PTaUgKHEI8NS
 AzSq0i50Jzq6RTKTTcGrAT+SHwxAnBjM79EW74N5DGgJltZvNqHHsFam
X-Gm-Gg: AYBFou0E5BN37fOGdrbmzKUMplAUDBL6umaQiO2qK8jPjszytN4W8ShahXRgFoGBx1R
 BxypCm5wa7stFPZe+7WvFfpIsUPOBn5wWOhj0uIn6txPWuUfe308gH41IVk7ciB+yerlniMu3lC
 bSHa7FsyEvVaVeozaUz2Mrh+dtMBHUlD9poUTzaD15Fvj/ogvdjLxYtMq1tXL2MZx/97cBpRFe4
 AuaiSKn62RsTzziUYhIvjP+3qimw+gUUM7I1+XhIaYXnpdnp/wuNF7IKjUrYBK9cbs6s10A0FVz
 VgZ3eHIzbcWWmV07JmhBU3UpoHeTLrJ7bzZUT1biCewvUTKBRCOG73Bg8AgiZ/KPa89QXsXWXt4
 bXyNGYPtZGDYYu+Se3ASSppWTgKZtlMW+ZiiDFf1ecBO0MOcyJrX7NnrK7sfLdb13Pen9fVXeBh
 SO51idZhMUvaCSKUlNC0hC2uK/elxudSPKzbim3rLPTDCn4W4VhI/iaF+a4ISJhEwJglBtIasCK
 LtbR6DxzaV5VZFOG8Ko4RkYaUI9rXxSi5+DLDjESvMUdXzVfetlMx0SR+Cu8KVIV6Wj0OSOhQfJ
 Dw8=
X-Received: by 2002:a05:600c:4e89:b0:49e:745d:5768 with SMTP id
 5b1f17b1804b1-49eac4112e9mr27160505e9.0.1789565332521; 
 Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E02001A623C292D45A2B3.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:200:1a62:3c29:2d45:a2b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847da0cdsm594135e9.2.2026.09.16.06.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Oded Gabbay <ogabbay@kernel.org>, Elaine Zhang <zhangqing@rock-chips.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Wed, 16 Sep 2026 15:28:24 +0200
Message-ID: <20260916132824.13527-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915104328.45901-4-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-4-gahing@gahingwoo.com>
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

Thanks for flagging the job_lock change in the cover. I re-ran the
same protocol today on v13 as posted, 2+3 and 2+3+4, three runs each,
same board, base and config as on 12 September (JOB_TIMEOUT_MS=2,
PROVE_LOCKING, DEBUG_ATOMIC_SLEEP): 73 induced resets with nothing
from the driver beyond the timeout message itself, no MMU faults, no
lockdep report or warning, and lockdep still armed at the end on both
kernels. Of the 126 inferences scored, 118 matched the CPU reference
within 1 on all 48 channels, and 8 missed on all 48 with the channels
the scorer prints reading 0x80; in the two runs traced with the
kprobe, those 5 results sit exactly where the 5 -ECANCELED completions
do.

The limits are those of my 12 September mail (all resets on core 0,
one client), plus one more: the model is a single 1x1 convolution,
which Mesa submits as a one-task job (one completion interrupt per
good inference), so hw_submit() never ran from the IRQ thread, which
the race you describe needs. So this shows the lock adds no lockdep
report or hang on this path, not that it closes the race. On that
basis the tag stands for the v13 form of 3/14, with the same comment:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

If 4/14 changes shape in v14, I will re-run that arm. The scripts and
the tallies were prepared with an LLM assistant; every number above
was counted from the raw files of each run (scorer output, kernel and
serial logs, kprobe trace), not from the scripts' summaries.

Regards,
Igor
