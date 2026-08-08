Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D95C5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC3410E656;
	Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MgoGDKMU";
	dkim-atps=neutral
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1549410E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:07:24 +0000 (UTC)
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-39292c67dc6so149786a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786194443; x=1786799243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=izR+Nrw48bEezTRpqIz/ECOoUps8WA+iQCICJD/Q9lE=;
 b=MgoGDKMU4IyHeLuQkVVHVcQZleLfvFYkoHzO7U/qDLzRZPABBmX5kXdALRXDCcFl7Z
 pPS6xtb5VIetJPJoIK/GDPUviRP18rN2lz44x+U027seJbfNm1eqUyEUpiiYN+ilqpJf
 2zuryjBJ999oCujLl3dCDW8JOl7eymHb6X7PUuXoeL/zze2bXyzhbOhZ8urDOQs4BWE+
 Bn9qPYxFs0WXBeJXzP7a/uQP53Vv/pE5hTWJgGrDQ5b5+Zmt8XUuYMAdzeSFl+pjTJTc
 DUBsrArKGXAkYONWseJaB5oI2Hu+/ye/CvhRUS0csxfMX865526oE7I2c7CU/Gl5vJ1B
 h6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786194443; x=1786799243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=izR+Nrw48bEezTRpqIz/ECOoUps8WA+iQCICJD/Q9lE=;
 b=lKYs+GjZcpamn/bGuoIGt+JMumj1liut9RIbfyeBsvu5r0ugUpEzcRozlhUPcyiGim
 huSac6zbjVu35SVro3GUdl5i6L7K/pLhLcgyG0K8c1eYQLiCpJEKlkkHlBqEvMuZOR+k
 pvL/ZHB+vdp97Z+fJT/RrZS3uIJBwzekejD2XwtjJhw/GndWYTGJACl04WeGtrQ6rXwl
 mUvUN3PessxlRiVvwrz5Xbn8g6l240jiRg8KgmWlKIVdZLjh+MmKDjgbKd1/m4TsfOFc
 tyhr4hplYgxFzPx8JBk3ZvijcR/FHi5gPmZjAvnMsbTgFxXRpiwATnL3MJ+yGkkNh9JM
 HuTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo6qC6OwYinSAG7NuRi2ucvth0nf47wvmeU9aF05He6u+2Fd6d+GX4oAhi2O0ZPyyspBzmkE3XoLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVnMjjDRBev7TdWevLDWXBYNCN9f/igu/YCuWLfQcCGgOSvfdR
 6oGtAuI3TuD5hmKE8dRqayt1msdcnYLSs0PPRf1ffjguP6xIcXRDA6FA
X-Gm-Gg: AR+sD12lRYKlbAzycxFWsvbNP0k7Yg46LRYZw/I0IirUp2+jbORLRxhGphA6e2qoeGM
 wet0ZuwxECb4bxedz9bjrWBgaFJANzZCGFZZDgVMfU3s+t4cOcH061GOYQTLeDEF8UXciLGHEBD
 uXJErDD1vQeX2VpGZr8LHX97NorlpcdAXXwTLp1lwDJ9CBO2LO+rAQoLJ+lJuVu8OuQCnha+CA0
 G6BZPLs7P8fJoY7txRyWHmV7js1mKpgrAxod2irPR0ttR5RtaGLx9MiITeLDizcgrRLX3NNCG7W
 HP6X1Q5x6Wk+MWi717jR/lHWJKH7yo2+NoUQsOdh2xDvvNzuzoLFwB0B/p1FFzb4KGYLJgTdYnJ
 /VuJf9wAyrgzMK8FmH50vLXtNd4gssmXN43Aeqbf+w8ptJurCA/qIMSiq3bM14mADkNPkLtt5DK
 Q5ALV0qbl0RWZGjT13pPf5gs8ujBM8MQtBWxMugOY=
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-3903bb0ab77mr26378580a91.0.1786194443454; 
 Sat, 08 Aug 2026 06:07:23 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm6117441a91.2.2026.08.08.06.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:07:22 -0700 (PDT)
Date: Sat, 08 Aug 2026 21:07:20 +0800
Message-ID: <c8634d5b486e8d9eaa1a46aedb853438.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 08/17] drm/spacemit: add Saturn DPU core types,
 cmdlist and display MMU
In-Reply-To: <3d4204dbd1c73d50193144d1944d8237c625f6e3.camel@pengutronix.de>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-8-6de34d80e86c@gmail.com>
 <3d4204dbd1c73d50193144d1944d8237c625f6e3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Mon, 27 Jul 2026 09:35:35 +0200, Philipp Zabel wrote:
> On Sa, 2026-07-25 at 00:51 -0400, Cody Kang via B4 Relay wrote:
> > From: Cody Kang <codykang.hk@gmail.com>
> >
> > Register programming of the Saturn DPU is batched: the driver builds
> > per-module register lists in memory and the hardware command-list
> > engine replays them at frame boundaries, while scanout buffers are
> > mapped through the DPU's private address translation unit (DMMU)
> > rather than scanned out by physical address.
> >
> > Add the shared driver types, the MMIO field accessors, the trace
> > events, the command-list builder and the DMMU table code. Some DPU
> > configuration registers are write-only, so a read-modify-write would
> > corrupt neighbouring fields; byte- and halfword-aligned fields are
> > therefore written at their native width instead.
> >
> > Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> > ---
> >  drivers/gpu/drm/spacemit/dpu/dpu_saturn.h   |  35 +++
> >  drivers/gpu/drm/spacemit/dpu/dpu_trace.h    | 350 ++++++++++++++++++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_cmdlist.c | 304 ++++++++++++++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_cmdlist.h | 146 ++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_crtc.h    | 259 ++++++++++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_dmmu.c    | 103 ++++++++
> >  drivers/gpu/drm/spacemit/spacemit_dmmu.h    |  40 ++++
> >  drivers/gpu/drm/spacemit/spacemit_dpu_reg.h | 108 +++++++++
> >  drivers/gpu/drm/spacemit/spacemit_drm.h     |  68 ++++++
> >  9 files changed, 1413 insertions(+)
> >
> [...]
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_cmdlist.h b/drivers/gpu/drm/spacemit/spacemit_cmdlist.h
> > new file mode 100644
> > index 000000000000..d5acdbeb3b0e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_cmdlist.h
> > @@ -0,0 +1,146 @@
> [...]
> > +struct spacemit_crtc {
> > +	struct device *dev;
> > +	struct drm_crtc crtc;
> > +	const struct dpu_core_ops *core;
> > +	struct dpu_mmu_tbl mmu_tbl;
> > +	int dev_id;
> > +	int irq_online;
> > +	struct timer_list cfg_rdy_timer;
> > +
> > +	bool is_1st_f;
> > +	bool first_modeset;
> > +	struct dpu_clk_context clk_ctx;
> > +	u32 aclk;
> > +	u32 out_format;
> > +
> > +	struct reset_control *mclk_reset;
> > +	struct reset_control *lcd_reset;
> > +	struct reset_control *esc_reset;
> > +	struct reset_control *aclk_reset;
> > +	struct reset_control *dsc_reset;
>
> Why are these duplicated from spacemit_drm_private?
> dpu_pm_suspend/resume() in patch 10 have access to priv.

You are right, they are plain 1:1 copies. Will drop the five
pointers from struct spacemit_crtc in v2; the reset sequencing in
spacemit_crtc.c and the suspend/resume paths will take them from
spacemit_drm_private instead.

Thanks for the review.

Cody
