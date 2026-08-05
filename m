Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7D3C55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF42310EFE5;
	Wed,  5 Aug 2026 21:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="M7vi0+Hs";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A31810EFE5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785964518; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jn220RgGLh7QMVmQMjiT8dV/5PhMax3IfUciBQjWp/ImsZKAEZC+/NfvXshbVSKwD2cxpfq7A/yQyU7DuhTfq7eSeP8irAjdsMGqlhGM9InMQzbAEiieayPHVaTR5ehiiLKeDhXikzjyIGWq3k6Y/TQQ+7+H1LY2DKHC5/LB8y0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785964518;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+kuukwyGmVsdiICPczWNawr/QJJDBzrSYoQUtDRRpQI=; 
 b=WiAEnNGe6LukMgRqnQtKDRA0Tsu0y26OpqH5OxSULje7K2t88Ct2V+L2OzDQ3dk5rPFKbdOyzKodpY0MI/BPPqHcWtQy85Kfl9GLqg3Fc2TYoxBN0sqSzFJM4tm42YMoWyMroKiQH0NKx5ODn00L9rEG19r/gsBJLLQyUVEC/F0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785964518; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=+kuukwyGmVsdiICPczWNawr/QJJDBzrSYoQUtDRRpQI=;
 b=M7vi0+Hs6zuj6a1X7dhPoFDiUBoB5jn7aCyEDB66lUbUZEWkvL9NsBg4sr91LAnK
 P3sc4XhCJqn2gIYDWknjmtogH5DsmaxpX3Q0YmohthLf1B5NTvSb7p19tsKzn3kdCeF
 vTjtfdFfZoV7g8R61D73Sw6BtX8ceN4ssQ5P42R8=
Received: by mx.zohomail.com with SMTPS id 1785964516685259.9295211317848;
 Wed, 5 Aug 2026 14:15:16 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 49E1818082F; Wed, 05 Aug 2026 23:15:13 +0200 (CEST)
Date: Wed, 5 Aug 2026 23:15:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 
 Jiaxing Hu <gahing@gahingwoo.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Message-ID: <anOnZJVTGFErYvii@venus>
References: <20260729130743.128876-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yq2ul7gd7jb7edtb"
Content-Disposition: inline
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.956.17
X-ZohoMailClient: External
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


--yq2ul7gd7jb7edtb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
MIME-Version: 1.0

Hi,

On Wed, Jul 29, 2026 at 03:07:43PM +0200, Igor Paunovic wrote:
> rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
> setting the .id members. The rocket_core array is allocated with
> devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
> .rdev, .dev and .index, so all four clk_bulk_data entries are requested
> with a NULL con_id (unlike core->resets, whose ids are set a few lines
> above).
>=20
> clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
> of_parse_clkspec() only consults "clock-names" when a name was passed,
> so the index stays 0 for all four entries. Every entry therefore ends up
> holding a handle to the *first* clock of the DT "clocks" property, i.e.
> ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
> four different clocks.
>=20
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
>=20
> Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
> /sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
> handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other
> two cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
> "fdab0000.npu" consumer at all - their only consumers are the
> "npu@fdab0000" handles created by the power-domain driver via
> of_clk_get().
>=20
> Set the ids explicitly, in the order mandated by the binding
> (Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
> aclk, hclk, npu, pclk. After the change the driver holds one handle per
> distinct clock and clk_bulk_prepare_enable() covers all four.
>=20
> Note that this is a user-visible tightening for out-of-tree DTs: the
> old NULL-id requests resolved by index and succeeded no matter what
> "clock-names" contained, while the named requests fail probe with
> -ENOENT when one of the four names is missing. That is the right
> outcome for in-tree users - the binding requires exactly these four
> clock-names and rk3588-base.dtsi carries them on all three cores - but
> a DT that relied on the permissive lookup goes from silently running on
> the wrong clock handles to not probing at all, so record the change
> here where git log will find it.
>=20
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> v2:
>  - document that resolving by name is a behaviour change for DTs that
>    do not carry all four clock-names (Jiaxing Hu)
>  - collect Jiaxing's Reviewed-by
> v1: https://lore.kernel.org/linux-rockchip/20260729092939.118779-1-royaln=
et026@gmail.com/
>=20
> The same four id assignments are board-tested on RK3576 (ROCK 4D) as
> part of Jiaxing's RK3576 enablement series (v2 6/8), so the change has
> been exercised on two SoCs between us.
>=20
> Verified on RK3588 (Orange Pi 5 Plus): after the change clk_summary
> shows one consumer handle per clock instead of four handles on aclk, the
> NPU still powers up and down cleanly through runtime PM, and a
> MobileNetV1 inference run via the Teflon TFLite delegate produces
> bit-identical output tensors to the unpatched driver.
>=20
>  drivers/accel/rocket/rocket_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9..5dd260b 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
>=20
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
>  	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);

--yq2ul7gd7jb7edtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpzp90ACgkQ2O7X88g7
+pqV3A/+NVvLDD8/YW0TXzDBH/kzuNQGMGV9ag1uGrEdQMooHP+Ghwi8wChXDscQ
RM1WYByQfetg+igHca5av5NxSRZ/FL/2RPNQfiNJDVLghPPlOHvHTn4JVi9TKzbf
maofXNDPCph2DIG2pFFSgQ+n4c5/wXx1/rrHIa2PD7wFVSU/JURprAV8sBcnCVaD
lfBimICZDON35qnvj4UXbfTga62exuIlkrjOgOjlM4ylrkoPN79UNSHqT8oMnGZz
CurTaGP28JgpwG6SOmDY277EZ+Ivur+DiVpSlkJ3nVhNgpDHSh8UVXK443K9sPSp
tbb5t+Hkxnb45ClC8j7DQnLtF1wMgOLVtYjUh7FzypCARqLjtW7aFws9zYWGqgLJ
ugoBhskJ0DOEOoU0hpVLBiLPWwzWQbfScp0H/qpHlU+hHsRU95XUW36eBKwpAHIM
h4JJaVEFXYA4gnnC7fO74rUH1aQbU555TIhtJ7enf8vVr1b0MHNrN+sgeKkJy4Q0
QW0lKWWt0YIL+ipxreHUhxE3Yo0aiEU+KrudMl5Jgo+dLMhpbeMlhNF7ptK32qHG
/J0ITJTd3wlLLf+d4ESyKp17cjsFmR6cIgtmYLq7XXbKACbq2ZsKOLbShqQxcbn5
Pgef5NPU+/Cg8CtUUNNI9j2/GvRd+F43wmsddJFDTfypLQTgHV8=
=0QwP
-----END PGP SIGNATURE-----

--yq2ul7gd7jb7edtb--
