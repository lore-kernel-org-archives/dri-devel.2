Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0376C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9E710E07B;
	Wed, 19 Aug 2026 05:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DFt63tLT";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F02110E07B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:53:52 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4994d41ceb9so677545e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787118830; x=1787723630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=drx7lxhpvX/m1kQ32psHACDf5vz1LZ8ZaWYCSVJWSkU=;
 b=DFt63tLTd9uq4KJPLzlgboTqEahburvo900E0shRKinFChxdq42Y97npFdxhav1h1O
 +7GWNMHaVxex35IAksppEAD7qpx3OK9NoD93SuU2FsD8N1Ji+XTH4cILTaDvtCC1+5lf
 uLNDgweUcImrkz3arbTDEHtl+fo/ZSQ80uotzs1jeRZ+/IS7WWRfw8Hdv+wNpWHmsnyU
 GJ1susW12DD8ESwrcs8+wk9VmSWx9tHZ9+TQcul4n5FVVCSsoaG3vjMXNAmp3FfHoM/b
 ouputR0X6blhhyNlj7y0DP9bcDuoHI0dt6WVII3Y+tV1fjQRmdJ26Kt3g6M7XwW9H4/z
 LmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787118830; x=1787723630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=drx7lxhpvX/m1kQ32psHACDf5vz1LZ8ZaWYCSVJWSkU=;
 b=VwV3ajcc94PaJzj4VIiakDY4NHVkXBBfk5rxN2mGJ5HIFG549wiXg03M6xuRDtta90
 Si7cbkliYbJvIGdUmiVY9sVF6bpyKf7YJhPbqO4jEly4hYBK+rem4ZFF8regWKCtjpy1
 S8mOJbp0c1tXTEIDjpDsNBf7Zgp6Ek+fZifgjg7mcm/eVk5ezq4VklNJh5HjFEG74pYT
 IUa244ZXoKTZUZJy5fAkJqSC7paY4zwenqUPSKgdUf/Z2IT70EF6Z5DRvXwmk34c/TYs
 aU4I6V4v2ahA82dn+B0z86qQILLJJ88qunZFy2zzYCA+4nJjPwhkU34WHxC10i9qeBlm
 Katg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJFGYzX9M1HdyBrFbM6k63mesREE2GGDiW+0yGUmPHtANRtWUMxpvsK1yzSmxQe3yteLnK2ac0ptM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkbsV+nSw263tQdjL6XSBkGYGbvOuKZdk3LM/TOPCm1MesvXoJ
 wKLX5FUWy9GcSFC9rZZcpcGsm+hc/HOVamENOEKUWNLHfJgUbGoRaUhs
X-Gm-Gg: AR+sD12eDBaasq2sdqkoCc6eBT2YrSMzm5nq0g/Z5YwkmgEcFo1k0YIX4vrL+JJtK+q
 bifSZ3gSZTNyEQtQoYFFJTg33TslHF9CP0nWuTFUefDQIGWR5cJz2q6ZJ6YQH1P4bKHWHbG3cvw
 N2koctjxnF8BT2Hc+Oupv/J1PrQ34rlnloKETRdYTqnlpXXgrB6Vi7xenrUlwgLACFoVu6e+rS/
 1hc7Yq29JEIwvvsbZ5zCGUuXPwfwyY9rUxUnfD4j24vdwY0AzBNN07LUTYP2XoEMVgBByNtqShF
 2LwP27UjJzr+JjuSRhXy+mq0pymv8iG6kPeES1vEU9C92eDDx5KepcKeDFirdJ7qnt6dXs6/Sir
 huai3LYI4n2m9z0aTzuZCH0XYu5XHiHlwjH8tgcwzEaN2hSSyDReSy2boMldlGnuNHQQz1+Xa4F
 wDUXunTU4hmytjZ1tLExy4xUFTqCPvl3LCuUPEIaA4skdt67xajpdUV1i+ChOfU+uE6z22Bc1AE
 RS97plORQJDcgb07VZ83iVnS9UJ+IXiawicO+SFR7PVFlt0dGq12HXnHG36VsUpP1eG4w==
X-Received: by 2002:a05:600c:3f12:b0:499:8411:9e8d with SMTP id
 5b1f17b1804b1-499aa0de240mr16981515e9.0.1787118830280; 
 Tue, 18 Aug 2026 22:53:50 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9296004F3635366E4473DE.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:4f36:3536:6e44:73de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17e241sm28172945e9.12.2026.08.18.22.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 22:53:49 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Wed, 19 Aug 2026 07:52:23 +0200
Message-ID: <20260819055324.33669-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Jonas,

On 8/18/2026 2:30 PM, Jonas Karlman wrote:
> Looking closer at my old commits, it was the PCLK_GPU_ROOT that was
> needed for e.g. RK3576 and RK3528. This clock is not described in RK3588
> clock tree so it never gets disabled by Linux clock framework.
>
> I suspect similarly one of the NPU root clocks is what drives the NPU
> PVTPLL and thus always must be kept enabled when PVTPLL mode is used.

Thank you - the PCLK_GPU_ROOT observation was the missing piece. I went
through the firmware my board actually runs and can now name the clock
for the NPU case.

First a correction to what I told Nicolas earlier: my BL31 is not the
vendor blob. The boot banner reports v2.12.0-9-gd5c68fd92, which is the
edk2-rk3588 project's TF-A branch: upstream v2.12.0 plus nine feature
commits (SCMI voltage domain, eMMC clock, TRNG, ...). The only one of
those touching rk3588_clk.c adds an eMMC clock; the NPU set_rate/PVTPLL
path is unmodified mainline v2.12. So Nicolas and I are effectively
running the same clock code, and the firmware-difference caveat from my
earlier mail mostly evaporates.

What clk_npu_set_rate() in plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c
does:

- The rate table gives every OPP from 300 MHz up a ring length > 0, so
  they all take the PVTPLL path; 200 MHz has length 0 and takes the
  normal GPLL divider path. The 200 MHz suspend rate we both converged
  on is therefore safe by construction on this SoC.

- For a PVTPLL rate the firmware programs ring_sel/length/calibration
  (cal cnt = 24, T = 1 us, i.e. a 24 MHz reference) into NPU GRF at
  0xfd5a2000 (NPU_PVTPLL_CON0..2), and only then flips the mux in CRU
  CLKSEL_CON(74) to the PVTPLL path.

The Linux side is where the NPU differs from your GPU case: the NPU
root clocks are fully described in clk-rk3588.c. pclk_npu_root is a
gateable composite (CLKGATE_CON(29) bit 4) and NPU GRF hangs off it
(pclk_npu_grf, CLK_IGNORE_UNUSED). In the mainline DT only core 0
(fdab0000) requests PCLK_NPU_ROOT as its "pclk"; cores 1/2 only hold
their aclk/hclk. So whenever core 0 is runtime-suspended, pclk_npu_root
has no user left and gets gated.

An SCMI set_rate to a PVTPLL rate issued in that state programs a GRF
whose bus clock is off, while the mux write still lands because the CRU
is always clocked - leaving clk_npu_dsu0 parked on a ring that was
never configured. That matches the empirical failure in my RFC exactly:
the sysfs min_freq write while suspended, followed by the power-domain
power-on ack timeout. (I have not put a scope on the APB bus, so "the
GRF write cannot land" is inferred from the failure signature plus the
gate state, not observed directly.)

For the series this reinforces the hold-all guard: resuming all cores -
core 0 in particular - around every rate change keeps pclk_npu_root
enabled for the duration of the SCMI call, closing the window for the
sysfs, governor and cooling paths alike. Your .config_clks() +
pm_runtime_suspended() check covers the OPP-initiated paths; I will
reference it and your branch in the cover letter.

One open point where your GPU experience may help: besides the GRF
programming interface, do you know whether the ring/monitor logic also
depends on hclk_npu_root, or is the 24 MHz calibration reference
(xin24m, always on) the only other input? If you never had to find out,
I will determine it empirically by holding only pclk and cycling rates.

Regards,
Igor
