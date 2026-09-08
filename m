Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E8BC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B94C10E148;
	Tue,  8 Sep 2026 17:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQyQ02Pn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2HP3UNz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827BC10E148
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:45:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdZeP2194376
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 17:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 St/Sk9a+p3XhMP4xZTJv7PZaeP9BSabCb1wIv9/ECMc=; b=KQyQ02PniihoxDBs
 jD6xRVY48ta1jVKYV37M6PENab+d3OFQzhmYB8ggOx3AheWtPtwxvMxuZGyUx2AW
 +0yTx8vrVTRosXuvFoRDox/D035EF2U1Fy+brNFBS97hSKBNutSkrndVuECh6VPk
 5uZkGL+YzE2m2RX4aRDUr23a1e++hm4gIl0zOn0uaEKcZ9gvxtkQT8yQ0x/gwleO
 5SdkM/fr5MkIdiOBdo/0cuFqjTXDRl7jWl5uWce09Z386PM8R+hJQTClIi2PnAfK
 BywdULIPdzu1rg/N8g3bSRn7FrHbP37iIi1x1oSEcOBGWPX/OMil6gupwTMPJemO
 6UxFnA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjkshs4y1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 17:45:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so7615224a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788889529; x=1789494329;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=St/Sk9a+p3XhMP4xZTJv7PZaeP9BSabCb1wIv9/ECMc=;
 b=i2HP3UNzhoAUzve2MvlucujfCWYrzVSEpAIy3TSua7T0lJWbSPHlqKim1mcrEdrw57
 k63jHwuDE4yfDw20CozbWT112o3RrXjJHStdmKdS3q5kjzoXPFtEvTHz3ZXAoHCnbAbt
 wY2G7cXgzPNv+gX/fipHMlmrAwViBewGdNqf4qJqzve70hO5ZSJY8oEzfQLOZEGMRR3e
 DjzWt+eTzah76F/PZ8hjvQdGd7JePjnRGli5OdHtwsWPKJ3UNHsPANwxcRCepXslD/nR
 PjOFWHEjJnAGh9/ihAlMjls1gW64TSwMB5DVzvlaonl0GxfeShw77PNwtwNWXaCnuvnJ
 cbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788889529; x=1789494329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=St/Sk9a+p3XhMP4xZTJv7PZaeP9BSabCb1wIv9/ECMc=;
 b=JhF+mvfkDkAEowwYRTJtmFIcn9VNTUlSbLPrTjodHTPgMtFD5cK7f+zuaKq/0W0IjA
 1kOiugsfbP1lK9wmW0gTqVvlBiewXeGhxKX/XCvXTs/oeNIiavdDnEQy9Ro2yBSwGBG6
 PXozAK0gly3G5FdZWNiclf8OjADAbhTAhKNDA58vHSwheDjrSNMRhnlHCu9koHdlbl5B
 PlknkSr2TApWX9CAlwhrJZpGw1lVLfgR9cLqf17pzf/wA18Gyrj28g53Ih0ocOf4TrW8
 5M1N1ch7dPRHMgMppueLGpuAk/TEG8B2mvZiKOJdxWDFVygkoEk5bpileaL4glNYddhJ
 Cp/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSZ+xVF1dxX4ZYZlgLLtrWu5NQs2k7QrLRYYtwLK1DAjOK5b7gp/WE9tLVa3SrgPd9jOVuIXimohQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUfNh9uCQQoQ2JP/uBaY71sttaCMV/rW2m9YXQb8mjM9Q/mJMu
 QuSzo6HeTfHJXywQJ7iODSTOUM7LFVBxe0F+j35KT/Qs6lI3wdZ9KOGfNuNn6MUTnU1vmMUulTv
 3EPe8db3ZiQQY5WrMy3iry82ttNMi834HdXPUoZUQ0Bb4voi4kGtmOhwsihESezOburFRByUHZp
 bp1KA=
X-Gm-Gg: AYBFou2qq1C5nUnRpd917R3OR2h5JISCcxGSAr+vTGzb+rKI6hAsDJyfiOeNVuCgppP
 yi4eusB/zxipfIJlIAt9VaJHbfAi8P00HD8120IZSsiByTSzp+jrpYD9qTsAwhInt4eX0dnf4Ui
 1aLehQPnp9RIROWTYkye6Qc55N9erQa7i+NuVZsTZF67sYRniYzmjb+KWNiXb5oTzcuA7264UWL
 1QesCTxwKbHy7SKLPDpEjtx/3o8GCCMF6hxll+s/CDb/lmx6nGtgieEPjhsFHQ1n5pK0uQDkn/e
 CadWbJ/UyguXszSz4CXLA3MDCVt3amMHOGLGnbJwwcGoPeRsHHzE0kdM0N67u3kKn5dWSyoWA8h
 LBTTV4WSV/1rr1XOJh4j+AaPGpA==
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39b2624c32bmr10550904a91.21.1788889529133; 
 Tue, 08 Sep 2026 10:45:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39b2624c32bmr10550852a91.21.1788889528598; 
 Tue, 08 Sep 2026 10:45:28 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33517b57ac8sm26286483eec.28.2026.09.08.10.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:45:28 -0700 (PDT)
Date: Tue, 8 Sep 2026 23:15:22 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
Subject: Re: [PATCH v12 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aqBJsv3Sz5NUci3H@hu-mdsor-hyd.qualcomm.com>
References: <20260903-lt9611c-v7-v12-0-9414d2b3bd6d@oss.qualcomm.com>
 <20260903-lt9611c-v7-v12-2-9414d2b3bd6d@oss.qualcomm.com>
 <20260902194019.89CA71F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902194019.89CA71F00A3D@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE5MiBTYWx0ZWRfX+TReDVNDODZd
 SLSfqdeKdoGh6f84rfjxdpkHFNn1ngrARBkRwVZ1jZ9h7BiIx1gLnTmhszvvpqDxGeSa3ESrBkt
 s0VcI4cn88t5efgPCv8EBRVDnhe8PAE=
X-Proofpoint-ORIG-GUID: 9ORTmEi5Oske9_P2vNgBVuxanejyNnn3
X-Authority-Analysis: v=2.4 cv=TammcxQh c=1 sm=1 tr=0 ts=6aa049be cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=BfgJfMvSuRSZfvNRZ-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: 9ORTmEi5Oske9_P2vNgBVuxanejyNnn3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE5MiBTYWx0ZWRfX/CIH2A5MoqgY
 t/mFVox7ErInTgbQQToGs2zR22n/uPjm4BnmRhSisvlKTIZM2ROmT7pQtfnW5j25vle4DSnVx1N
 Je5aBpnG/1IT68QKigD2s+T04xzv5Sc3WZxpQyzskxCmY6MKuiia0y/zszaI6cnFKWAGOkbuB6H
 zobYVWiJDByneUdlIWLdMvYLKwzmm70t2fFyN20if7oQuQKmZ09tBe4dzY+iS06EWasS+gTQrDu
 J1F50swfpBm9tDZGjh12gbmfxLYOAe0yIKc3cO1K4o6KmkHWv9qc5R6Qvmv9a0gCmlFo3lZIb1/
 m0QAscedS//98JQtABPKzzpL93IHxmTrVY7JBYwUzfAEw5wcdq0O4VwC3pVcE78ytz2a2SPF6Zw
 HhGL9XuLYSxqnly5Jgic5CwugrBhopWRHQa7CU6fE3dAHC4PkwUZbMfsZKTr5FBgSjNrDYNQSTa
 QNAlCaDiNWQQ9P9Vy+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080192
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

On Wed, Sep 02, 2026 at 07:40:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Double-free of device nodes `dsi0_node` and `dsi1_node` on error path due to mixing manual `of_node_put()` with `__free(device_node)`.
> - [High] Regmap page cache becomes desynchronized after hardware resets, causing subsequent I2C operations to access the wrong registers.
> - [Medium] Mixing `__free()` scope-based cleanup with `goto`-based error handling.
> - [Medium] Bitwise operations in the IRQ handler corrupt the interrupt clear register if multiple interrupts are pending.
> - [Low] I2C device ID array is not declared const and uses positional initializers.
> --
> 
> commit 79126746072fd218bc214fab821198cac4bc10bd
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit adds a new DRM bridge driver for the Lontium LT9611C(EX/UXD)
> MIPI DSI to HDMI bridge chip. It supports configuring the hardware, handling
> interrupts, and triggering firmware upgrades over I2C.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..ef1e9726fdd3c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > +static void lt9611c_reset(struct lt9611c *lt9611c)
> > +{
> > +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +	usleep_range(10000, 12000);
> > +
> > +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +	msleep(400);
> > +}
> 
> [Severity: High]
> Does resetting the hardware here desynchronize the regmap page cache?
> 
> The physical reset via GPIO clears the chip's internal page register back
> to 0x00, but regmap's cached page selector isn't explicitly cleared. If the
> last I2C operation was on a different page (like 0xe0), subsequent writes
> might skip the page selector write because regmap thinks it is already set,
> causing those operations to mistakenly target page 0x00 instead.
Not an issue — the regmap config uses no cache type (REGCACHE_NONE by default). Regmap always performs a real hardware read
of the selector register before deciding whether to update it, so it correctly detects the page reset to 0x00 after GPIO
reset.

> 
> [ ... ]
> > +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> > +{
> [ ... ]
> > +	/* Clear interrupt: hardware requires two writes with delay */
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> > +	usleep_range(10000, 12000);
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> 
> [Severity: Medium]
> Will this corrupt the clear register if multiple interrupts are pending?
> 
> By writing irq_status & (~BIT(0)) back to the hardware clear register, if
> there are other interrupts pending in irq_status (for example, bit 1 is set),
> this will mistakenly write a 1 to those other bits during the final clear 
> step for bit 0.
We only support hpd interrupt.
> 
> [ ... ]
> > +static int lt9611c_parse_dt(struct device *dev,
> > +			    struct lt9611c *lt9611c,
> > +			    struct device_node **dsi0_node,
> > +			    struct device_node **dsi1_node)
> > +{
> [ ... ]
> > +err_put_dsi1:
> > +	of_node_put(*dsi1_node);
> > +	of_node_put(*dsi0_node);
> > +	return ret;
> > +}
> [ ... ]
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> [ ... ]
> > +	struct device_node *dsi0_node __free(device_node) = NULL;
> > +	struct device_node *dsi1_node __free(device_node) = NULL;
> [ ... ]
> > +	ret = lt9611c_parse_dt(dev, lt9611c, &dsi0_node, &dsi1_node);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> 
> [Severity: High]
> Can this cause a double-free of the device nodes?
> 
> The pointers dsi0_node and dsi1_node are declared with __free(device_node).
> If lt9611c_parse_dt() fails, it manually calls of_node_put() on both nodes
> but does not set the caller's pointers to NULL. When lt9611c_probe() returns
> an error here, its scope ends and the automatic cleanup will call of_node_put()
> again on the same pointers, leading to a reference count underflow.
Will fix it in v13.
> 
> [ ... ]
> > +	/* Attach primary DSI */
> > +	dsi = lt9611c_attach_dsi(lt9611c, dsi0_node);
> > +	if (IS_ERR(dsi)) {
> > +		ret = PTR_ERR(dsi);
> > +		goto err_remove_bridge;
> > +	}
> 
> [Severity: Medium]
> Does this mix scope-based cleanup with goto-based error handling?
> 
> The function declares variables with __free(device_node) at the top but uses
> goto err_remove_bridge and goto err_disable_regulators for cleanup here and
> below. The kernel cleanup subsystem prohibits mixing goto and __free() in the
> same function to avoid confusing ownership semantics and resource leaks.
Will fix it by removing __free(device_node) and using explicit of_node_put in all exit paths.
> 
> [ ... ]
> > +static struct i2c_device_id lt9611c_id[] = {
> > +	{ "lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> > +	{ "lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> > +	{ "lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
> > +	{ /* sentinel */ }
> > +};
> 
> [Severity: Low]
> Is this missing a const qualifier and named initializers?
> 
> The I2C subsystem dictates that initialized arrays of type struct i2c_device_id
> must be declared const and use named initializers instead of positional ones.
Added const qualifier and named initializers .name / .driver_data.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260903-lt9611c-v7-v12-0-9414d2b3bd6d@oss.qualcomm.com?part=2
