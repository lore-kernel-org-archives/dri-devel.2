Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CA606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFVohxNy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8B510E134;
	Fri, 13 Nov 2026 00:19:05 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE71D10E134
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:18:58 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so833834eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794529138; x=1795133938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fPaLK6QLsjM9GhI4n26+oRseR6mkB/Pf0pWe+JhwF8o=;
 b=IFVohxNyPAeBa/eRSa6j3cd4O2xtlEcmtnTlu+FhKnos8o9Cvv7QEbs4ApsKIabMUj
 8SsCgldEpLF4wdtOr6aaNcvuuQe+7erDS678ZMnorouhfAcVq1NDsCDVRj2WEOs7++Ce
 ws5O4gq1hryR9F5p0mhhuAlUVWw6AtQ3VH/WZzdW/6KmBJP1TZRs4+LvL4oFsOL/EYZG
 fT20V+7pGKYKk4mbO8gSsFlGb6v68dM0g9p8Lx8XyvOoFWeWOuj3gwBOUoM1Xud7GWNn
 54tMKwBAml9qH7HpyP74hBoCN741UWDJwmZlIbwsEMebE+1Y80/46Mb0Uyqu5a4HOITi
 0/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794529138; x=1795133938;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fPaLK6QLsjM9GhI4n26+oRseR6mkB/Pf0pWe+JhwF8o=;
 b=hanH/YVnuY7VXFgtJw06R/qEVQVWvcIkF5K2AMxG8c+4+Ysk4AilVSC2wRWRphBadN
 cMd6Li1SWLYN8HQHyWUdqP8UOwQtPloNyRydBXa/peENs+2VgYQxzFpHXLQQ/uWlv2Ft
 YPUYj5emVieYlp39FpWSPEhpn1kWhdp04H0bgz3BD8wgTvO+GYKmu+hJWwatn0p8zrec
 +nq/zKQ8LjAj8Gm0clSjoB2f/SmWnil6tvMjf/7tpTR82kZgodcziLiqNO25JGiDTAPP
 EauoHWcagGkTMEPukK79D9mkOLBqPnxgA7b3aH+Jdqudra8qm0OcC6+eYa7yI/HgbvMY
 CyzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH2/aS3hd0xpt5Ihd8bDggo/Ha7L+O5i2fChELvbK8413B6j5rrbyIEvycv3XydnUbSzkeYJO31jBk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8eyUVi3ah+tBYDfcrQ2eINIlwyafEGVaZrit5n4Oc8ElPHrAWt
 KANHZ73XxksoR0E7yAdpP0OaRkQw1bgxDjhul89kP+XO80Aqoj2d8V1X
X-Gm-Gg: AYBFou2jC/Bkt9bE94XnETBLdbEdSLnEBM5u5WQ5jNHjVb/ws0goCf6NdOuMSE1RZsM
 yc+MklnfrMLmwDXE9UTnoL8O2E/Kim/ZuE7GXXIoJabKqtBMlKJ41DpZ3IVuCCMYg8u0Diw+U0J
 niPHFqnREa4A9ekarn6KyxZdCCXDjcXbcBieVTCou+kOK4JK0s5py2DO98U3MDqCzJEW7IRoK0n
 +m2MQOPa3HiRa0nMcHe2xz6Z0sNNUNkl8t8iKyPaOg+97JvCrRmQsByhf2oOHJydrc3kZze6zNm
 N5Hmt+j+I/r5GfZcDeX8WZf2e3P5V/V7U2C6uzlQdzKUVYgg4bslq/fyCP7gBBBMMV4u7RhO/DW
 xE59kzrmeajDQOz/fgNT/xNQZ1ECy/u5cMpiK+c8hayoOfDp1CExD3Tgw344Zi6bnFLB1a1dDhd
 aUiok45o09wvQnbtxmYSPRfMcjzVdGWpg0m8iNbvHpF+8mO8dxny+elPayqxyVnYMqHht8ypYdz
 WHTmLRQZvUDhgFiJ8MOE/ph/D8GT2rvr6PKVQWopawvx+IyYIyi2BnMoyBSxHFuCWOB6/RPzujy
 rVYpuzmYhGdcNWO6XV7dmtBey5RBnUCTM02yKs9664TGozCH2wekDmtPiYV4NqmKyFQPyp8jr/C
 1QM7yJQnoUH3IGlsihDRzmVMOqYJk
X-Received: by 2002:a05:693c:83c3:20b0:377:678:231b with SMTP id
 5a478bee46e88-37966a591dfmr776107eec.25.1794529137923; 
 Thu, 12 Nov 2026 16:18:57 -0800 (PST)
Received: from ?IPV6:2600:8800:1aa1:b100:fdba:2418:657a:1a53?
 ([2600:8800:1aa1:b100:fdba:2418:657a:1a53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad6casm1675676eec.26.2026.11.12.16.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 16:18:57 -0800 (PST)
Message-ID: <f3707b72-07f2-41ae-aefa-c46ef84de3e3@gmail.com>
Date: Thu, 12 Nov 2026 17:18:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/vkms: support more formats and fix RGB565
 regression
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
Content-Language: en-US
From: Sidharth Saha <ssaha2000@gmail.com>
In-Reply-To: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matheus,

Following up on my earlier report: I've now written KUnit tests for
the conversions in this series - argb_u16_to_RGB565(),
argb_u16_to_BGR565(), the RGB565/BGR565 read paths, and both the read
and write paths for RGB332 and BGR233 - against hand-computed values:
zero, max, single channels, the midpoint, values either side of each
rounding step, distinct per-channel values, and a read/write round
trip.

All pass with the series applied. Without it, the RGB565 writeback
midpoint and rounding-step cases fail (truncated instead of rounded),
and the RGB565/BGR565 read tests give identical results with and
without the series, so the helper conversion in 3/5 doesn't change
behavior.

For the series:

Tested-by: Sidharth Saha ssaha2000@gmail.com

I'm happy to send the tests as a follow-up series once this lands, or
you're welcome to fold them into a v2.

Thanks,
Sidharth

On 9/27/2026 5:52 PM, Matheus Alves de Almeida wrote:
> Hi,
> 
> This series adds support for RGB332, BGR233 and BGR565 writeback. This
> is done with new helpers added to make conversion easier. It also fixes
> a regression in the RGB565 write conversion.

