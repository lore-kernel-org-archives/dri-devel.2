Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4879CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E09610E5D9;
	Mon, 12 Oct 2026 16:22:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB27910E5D9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:22:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4019440849;
 Mon, 12 Oct 2026 16:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479261F0089B;
 Mon, 12 Oct 2026 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791822149;
 bh=WvdDyBJ3nYyvMWerAF6QbtnudCx/aF32Hxs83dpFCxg=;
 h=Date:From:To:Cc:Subject;
 b=krhvFx99aubfcfbdQTsJt+V1mXqMinmMU+X3Jh/aC8zA3/05C0uv1/oxZZT7u6lpG
 gH3taO43+PCOzwZ3SeySxQh80JybVcnx8gJvo3+Vl1rUiJI4hsWMm9hupH4k3dgHn9
 8K4MggekyUNUarY0trEa6/3BEwr/ppWFxnYJF2E1FAbpZwLcqchKku+betqhSkqkyw
 2vmfQIsGaWjT0xdtpszLaaLvqMlg/+lnNMNdB+RVgdLXBhp4a9QGA1xtBWa0u4eqHb
 9/vN9eORrjH48nBI5xL+p704veJnfiMdYbcU95BLDGjMwHtk90kDe56882RiXArDtU
 MFTlyzNP5uZiA==
Date: Mon, 12 Oct 2026 17:22:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: linux-next: manual merge of the drm tree with the qcom tree
Message-ID: <as0JQLlvuodleN98@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NJUZr1DeX2pRx7Hv"
Content-Disposition: inline
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


--NJUZr1DeX2pRx7Hv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/soc/qcom/qcom-geni-se.c

between commit:

  803f9950a6c6e ("soc: qcom: geni-se: provide PROG_RAM_DEPTH for I2C HUB Se=
rial Engines")

=66rom the qcom tree and commit:

  d1750c530e9b9 ("soc: qcom: geni-se: Fix fw_end computed before round-up; =
propagate size to caller")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/soc/qcom/qcom-geni-se.c
index 074087c592cc3,6ac2bdc16984c..0000000000000
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@@ -42,7 -42,7 +42,7 @@@ EXPORT_TRACEPOINT_SYMBOL_GPL(geni_se_re
   *
   * GENI based QUP is a highly-flexible and programmable module for suppor=
ting
   * a wide range of serial interfaces like UART, SPI, I2C, I3C, etc. A sin=
gle
 - * QUP module can provide upto 8 serial interfaces, using its internal
 + * QUP module can provide up to 8 serial interfaces, using its internal
   * serial engines. The actual configuration is determined by the target
   * platform configuration. The protocol supported by each interface is
   * determined by the firmware loaded to the serial engine. Each SE consis=
ts
@@@ -101,26 -101,22 +101,26 @@@
   * @base:		Base address of this instance of QUP wrapper core
   * @clks:		Handle to the primary & optional secondary AHB clocks
   * @num_clks:		Count of clocks
 + * @prog_ram_depth:	Available CFG RAM depth for instance without SE_HW_PA=
RAM_2
   */
  struct geni_wrapper {
  	struct device *dev;
  	void __iomem *base;
  	struct clk_bulk_data clks[MAX_CLKS];
  	unsigned int num_clks;
 +	unsigned int prog_ram_depth;
  };
 =20
  /**
   * struct geni_se_desc - Data structure to represent the QUP Wrapper reso=
urces
   * @clks:		Name of the primary & optional secondary AHB clocks
   * @num_clks:		Count of clock names
 + * @prog_ram_depth:	Available CFG RAM depth for instance without SE_HW_PA=
RAM_2
   */
  struct geni_se_desc {
  	unsigned int num_clks;
  	const char * const *clks;
 +	unsigned int prog_ram_depth;
  };
 =20
  static const char * const icc_path_names[] =3D {"qup-core", "qup-config",
@@@ -924,7 -920,7 +924,7 @@@ void geni_se_rx_dma_unprep(struct geni_
  }
  EXPORT_SYMBOL_GPL(geni_se_rx_dma_unprep);
 =20
 -int geni_icc_get(struct geni_se *se, const char *icc_ddr)
 +int geni_icc_get(struct geni_se *se)
  {
  	struct geni_icc_path *icc_paths =3D se->icc_paths;
 =20
@@@ -1221,7 -1217,7 +1221,7 @@@ int geni_se_resources_init(struct geni_
 =20
  	se->has_opp =3D (ret =3D=3D 0);
 =20
 -	ret =3D geni_icc_get(se, "qup-memory");
 +	ret =3D geni_icc_get(se);
  	if (ret)
  		return ret;
 =20
@@@ -1248,7 -1244,6 +1248,7 @@@ static const struct se_fw_hdr *geni_fin
  						     enum geni_se_protocol_type protocol,
  						     u32 *fw_size_out)
  {
 +	struct geni_wrapper *wrapper =3D se->wrapper;
  	struct device *dev =3D se->dev;
  	const struct elf32_hdr *ehdr;
  	const struct elf32_phdr *phdrs;
@@@ -1313,11 -1308,8 +1313,11 @@@
  		cfg_val_end =3D le16_to_cpu(sefw->cfg_val_offset) +
  			      le16_to_cpu(sefw->cfg_size_in_items) * sizeof(u32);
 =20
 -		prog_ram_depth =3D FIELD_GET(PROG_RAM_DEPTH_MSK,
 -					   readl_relaxed(se->base + SE_HW_PARAM_2));
 +		if (wrapper->prog_ram_depth)
 +			prog_ram_depth =3D wrapper->prog_ram_depth;
 +		else
 +			prog_ram_depth =3D FIELD_GET(PROG_RAM_DEPTH_MSK,
 +					readl_relaxed(se->base + SE_HW_PARAM_2));
  		if (fw_size >=3D prog_ram_depth) {
  			dev_err(dev, "Firmware size (%u) exceeds RAM size (%u)\n",
  				fw_size, prog_ram_depth);
@@@ -1628,7 -1620,6 +1628,7 @@@ static int geni_se_probe(struct platfor
  		return PTR_ERR(wrapper->base);
 =20
  	desc =3D device_get_match_data(&pdev->dev);
 +	wrapper->prog_ram_depth =3D desc->prog_ram_depth;
 =20
  	if (!has_acpi_companion(&pdev->dev) && desc->num_clks) {
  		int i;
@@@ -1681,7 -1672,6 +1681,7 @@@ static const char * const i2c_master_hu
  static const struct geni_se_desc i2c_master_hub_desc =3D {
  	.clks =3D i2c_master_hub_clks,
  	.num_clks =3D ARRAY_SIZE(i2c_master_hub_clks),
 +	.prog_ram_depth =3D 1020,
  };
 =20
  static const struct of_device_id geni_se_dt_match[] =3D {

--NJUZr1DeX2pRx7Hv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrNCT8ACgkQJNaLcl1U
h9D4Igf+JCJYhSGkBBuHIPTErRr7NEzrQ+I7sdwvMaP4D+w0KKavHOlA/StjL6SI
eAejIhH5LJg4WxQqJ6eNEeoKtamN0ryS+TgU/GBCmE0gpw40xxAa5w5yS+F4xp92
6ynftmOL+nicHbHvSK0Lww4in0ex6T0HiZzxbwIAlGksmOqp/a1m2hUQrewacM3T
jgIt67uudYMT5DHGHlHFDL+RNZQ0t5d3PUCPgwUnb2o0dGJqYC8FbJw7/eHj0XIP
AKXMqFqVPFZZCOVYj1LaVD4h3KAq2kv1Ave/iDXTXHR4wBcZTL68AONFpt8uxmjl
QJZG62rB5UZIIyVxiVRcJzpWj60RxA==
=PCEH
-----END PGP SIGNATURE-----

--NJUZr1DeX2pRx7Hv--
