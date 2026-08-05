Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5AFC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DB710EE37;
	Wed,  5 Aug 2026 18:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="fvnA+TH6";
	dkim-atps=neutral
X-Greylist: delayed 419 seconds by postgrey-1.36 at gabe;
 Wed, 05 Aug 2026 18:56:03 UTC
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE5910EE37
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 18:56:03 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1785955410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asjh1e4/12M1U47u0ygycydMMvDwaXnVjTSsGZZSUqA=;
 b=fvnA+TH6tPFnMy8EEtLfbmcwGCHaFIKnEjq/xXwB96nA0KfwmreSMXYBKBSESKTENGftEt
 t1eIchoAtsGfwfsYbDF1wKSrjhwkAY4qUA7zR8o+o+MLzPjD/+b30w+KXoyP24Bkym/Aot
 BbFhURaY1InqkfMQZgIVNHjMfVnZbamW8oRvMPzV1Ca/0KyXlhjdEA3wlcuje0xpfV1s9v
 G1MeObiamJcQpJgQZHwF8mf+0mHWQVe1qOA9kp9MEuJi4bjnlP+tPqW7vuRp2GDfBXGuFE
 AEUV2KleJIy+UemZQ6RD47XLE98bkjq0kjVz4KdSOB1naqIXR4E0m8+UFA4vZA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 20:43:27 +0200
Message-Id: <DKH8CRTZT2XA.1WJNZORRS4109@cknow-tech.com>
Cc: "Oded Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 "Jiaxing Hu" <gahing@gahingwoo.com>, "Heiko Stuebner" <heiko@sntech.de>
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Igor Paunovic" <royalnet026@gmail.com>, "Tomeu Vizoso"
 <tomeu@tomeuvizoso.net>
References: <20260729130743.128876-1-royalnet026@gmail.com>
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

Hi Igor,

On Wed Jul 29, 2026 at 3:07 PM CEST, Igor Paunovic wrote:
> rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
> setting the .id members. The rocket_core array is allocated with
> devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
> .rdev, .dev and .index, so all four clk_bulk_data entries are requested
> with a NULL con_id (unlike core->resets, whose ids are set a few lines
> above).
>
> clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
> of_parse_clkspec() only consults "clock-names" when a name was passed,
> so the index stays 0 for all four entries. Every entry therefore ends up
> holding a handle to the *first* clock of the DT "clocks" property, i.e.
> ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
> four different clocks.
>
> The consequence is that rocket_device_runtime_resume() prepares and
> enables the AXI clock four times, while hclk, pclk and - most
> importantly - the NPU compute clock ("npu", SCMI_CLK_NPU on RK3588) are
> never prepared or enabled by this driver at all. The NPU still works
> only because the Rockchip power-domain driver sets GENPD_FLAG_PM_CLK and
> its attach_dev() callback walks the device node with of_clk_get() and
> adds every clock to the pm_clk list, so genpd happens to keep the
> remaining clocks running. The bug is therefore latent today, but it
> means the driver holds no reference to the clock that actually feeds the
> NPU, which stands in the way of any future frequency scaling
> (OPP/devfreq) work.
>
> Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
> /sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
> handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other
> two cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
> "fdab0000.npu" consumer at all - their only consumers are the
> "npu@fdab0000" handles created by the power-domain driver via
> of_clk_get().

I have confirmed both the 'old' situation and the 'new' one on both my
NanoPC-T6 LTS and NanoPC-T6 Plus (both RK3588), so feel free to add

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Nan=
oPC-T6 Plus


Cheers,
  Diederik

>
> Set the ids explicitly, in the order mandated by the binding
> (Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
> aclk, hclk, npu, pclk. After the change the driver holds one handle per
> distinct clock and clk_bulk_prepare_enable() covers all four.
>
> Note that this is a user-visible tightening for out-of-tree DTs: the
> old NULL-id requests resolved by index and succeeded no matter what
> "clock-names" contained, while the named requests fail probe with
> -ENOENT when one of the four names is missing. That is the right
> outcome for in-tree users - the binding requires exactly these four
> clock-names and rk3588-base.dtsi carries them on all three cores - but
> a DT that relied on the permissive lookup goes from silently running on
> the wrong clock handles to not probing at all, so record the change
> here where git log will find it.
>
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
> v2:
>  - document that resolving by name is a behaviour change for DTs that
>    do not carry all four clock-names (Jiaxing Hu)
>  - collect Jiaxing's Reviewed-by
> v1: https://lore.kernel.org/linux-rockchip/20260729092939.118779-1-royaln=
et026@gmail.com/
>
> The same four id assignments are board-tested on RK3576 (ROCK 4D) as
> part of Jiaxing's RK3576 enablement series (v2 6/8), so the change has
> been exercised on two SoCs between us.
>
> Verified on RK3588 (Orange Pi 5 Plus): after the change clk_summary
> shows one consumer handle per clock instead of four handles on aclk, the
> NPU still powers up and down cleanly through runtime PM, and a
> MobileNetV1 inference run via the Teflon TFLite delegate produces
> bit-identical output tensors to the unpatched driver.
>
>  drivers/accel/rocket/rocket_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9..5dd260b 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
>
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
>  	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

