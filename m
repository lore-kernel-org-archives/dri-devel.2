Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B88C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 11:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C58E10E2A4;
	Sat, 18 Jul 2026 11:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5rg2hS2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bOCj3UXt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA7F10E2A4
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:12:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IAIT3i419225
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FD0Wo5+4J/Xmv4o5hazcqi5D
 qDevELu6VcRHIJMG2h8=; b=p5rg2hS2eYLrpc23QEJYPR3wjY4XuQPgFDReEwxK
 RWSn+b7LemauwLCzBylaCHuEBkw4oqIx+Lgv2jBUGdh0FzNkR4c+i2cXd0XbVkGk
 pjcQIIK/VlubVlEVlIvQKmP+nhqfarXifc1Yi1MtFoBXQYqIU9Yn6cyWwgMm3eyv
 6VyzNcoD/ZX0p96trbiFsAEYsTfEFpfnHD9C5vtmaF2ypvq4bc2sg7xaEVdngc1B
 ykpNOj5YewuhQhOJMSRh8MdZDk20AxvzQ31V2aVPiocv2uWesAXMM0bDkT1X4Oz0
 S2qZHMm/FToJ3KFwANCQ/lxZWGPeLOL8doaThIauXGIIOg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc0mej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:12:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so6713455b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784373176; x=1784977976;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FD0Wo5+4J/Xmv4o5hazcqi5DqDevELu6VcRHIJMG2h8=;
 b=bOCj3UXthUCneH6DsMnwg0ASvSYDVnKEwhOVooJllmkqjtNetUzUXI0flfICfK+CBX
 W130RLBFHj37atqSV8s/YnloNxFStnO8fUyWXRkNjKRv1Doyq9ltmRojON+zcM+U2Hfl
 NaeZA+XccJvKdsYUt3IHvogMtmTFycyoctBN1TRWC9ytpACriLMCieUpMLSsDsC75Bb8
 NTzpMXkPusddMoxj9bhRRWp/dLqS1MP4n3ycAq1apGA2h6IMtju6nmr4OosAWLHh/U92
 dgIBZaWEzZGKvBsxllVDfLHzOiAurosjYcahMuCYTZwXeNaSwSWvxn90suC098QFZS8u
 XEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784373176; x=1784977976;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FD0Wo5+4J/Xmv4o5hazcqi5DqDevELu6VcRHIJMG2h8=;
 b=oYUjut/0APPbZ3ExLXMACKz6ei30htYpV1lQbEbRxFgA+Z4yL6kqAcyGs0wT6THDMk
 rai5gS8qUjMJYMXZdZOtAOV0xgHyNyCp4WfhjuZbkMHSeep1bfUfbvZXXon+xmft4TsY
 kah3hGRQQudeIw6wbhjqz6AIiWCvygv+xk8efxL4ujt0V2qK8idjAD6J6LGqPF2ht66o
 q4essWzH3AZuzEgn7qiHLqUNvtxDK9voRZLkN/ZIMIp7hJS4sf6CSW5QBhRmtcJSAFE0
 Lms/hD28FQ+6snm+Cd0xsxFpcCAvXoDf4rYVulUW891oc4tkiWyC18nGqUO5e8gAXex2
 LNPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RquVxqtArFg436ROPkvUWBZeMSS8ZvPQmQhO4IY1UxUSEXOV1GXjtMQ37DpYtAjsk81Jl3zSdUH2Fs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/EZgIofr/t1tkWI5/aU9OjwUzSMpACGYXeoG/HnsRLk7yxsth
 mAd5gT8sItdfhsHB9k3urmTkBWA9Y79IQ02G7CjqDhzhF0WjNUgd6dM+yBWbOzhvnufHxuA4C7H
 1fnUI3GAEtPRteQ725HhGTHTsyCbRz6XdPB+Xf7tjpoQ3LMImrtWJkvezHmJy3nDKsfhF+Jw=
X-Gm-Gg: AfdE7cmQWLBdFp1mS5Gnq+wgXkuogJR4mKN8iBCcnoLXmzVrqtiaBctlxSOthG2s2D9
 eOtAqZgGvs9D5Sv54yu82By0/86e912pstTf6WOjmLPgjEQ7nakPCeAvgw8Pxk5u4yjmRkXHv7i
 N/mtWmkPuH8PttuMZZsgIoS5/r5IeSNCASaq0DcpPi6Hok8De6ot1UjEubboKU43SW/v1lSPHOI
 UjQGCfRLZV8kQ0IIJhdJbE25IwTds6rD6JlmPEk2+mQVvH7kA+xOWFRINhdmI/Wq+K/XOogjKpx
 lrxMMfbESU0d6eOXpNnkXL+SMCmT3NSNgm/8x8PdPcUdEep4AAcsg1rKPYau5BR+th/zhicHbuI
 khbNASuXc96Lr4cXkQtyO+V5Flw==
X-Received: by 2002:a05:6a21:7008:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3c3ad7a439fmr7408658637.22.1784373176037; 
 Sat, 18 Jul 2026 04:12:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:7008:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3c3ad7a439fmr7408612637.22.1784373175539; 
 Sat, 18 Jul 2026 04:12:55 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429cf22b3sm17173016eec.0.2026.07.18.04.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 04:12:54 -0700 (PDT)
Date: Sat, 18 Jul 2026 16:42:44 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>, y@hu-mdsor-hyd.qualcomm.com
Subject: Re: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <altfrJgx2IjO1g33@hu-mdsor-hyd.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
 <85505d92-ebe3-4ffd-84e1-8fe26994e053@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85505d92-ebe3-4ffd-84e1-8fe26994e053@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDExMyBTYWx0ZWRfX7IZ/QTKUOfDK
 Nf/LBNUfnuPeVW7ZaeYgBjbcBGYid5xftup8rEZH8Vnc32jUMppJcNfjb1FZhIFQqcbjFZOTPC3
 tFQXF1rWXzMRGhiRd+IOpQUjxDQxnPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDExMyBTYWx0ZWRfXzPis9bmq19Ur
 R20Hd+gjy0oZ1MzLAXU/O3izf9yTnNqvSYpLseCq4CxBkg98FVeWe9OfNsB+LabIFdkO2WM2eLY
 MPmoJWKBP93hDxaDcKOuER6kGgA1L0BzDm1L4Q7GJyPpZgF3Y4uY3X88VdUXNXe3vmKxylmkDvL
 C4S0zlQP91FeldkI5bU5YOtX8jh+7ZJ5SfXPq7uGJwAVelpzXEWXJHL2ZF+Zs5hJvP3axKIwzXs
 bilo95dLkWXE+Wh6fNXkSSqqwmcQ5kdetRt4F6EAnikXm1amUiNUSzpsqdYaQX0V+OKGGva2Y2T
 NLV2PPDB7aGgzTRTEmYa/StQqe53qVsMolos/975a9xJRjPKk0u1h94xLtOghBbALziSvS8drfu
 k/R7yma7B1FztmLNy29p1oRuQPegLw7mSoOVz8vKIPIVk5R/lTeM3cwZzcuejRjm4UXCDHcLmWk
 FCusVATFeG/Q4OHlFZw==
X-Proofpoint-ORIG-GUID: fcvde5s3qqEMqC-drNfHqHbzmCYCWn0N
X-Proofpoint-GUID: fcvde5s3qqEMqC-drNfHqHbzmCYCWn0N
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5b5fb9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8
 a=LoA8nqqQfEkaJn3k8OYA:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180113
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

On Thu, Jul 16, 2026 at 02:56:02PM +0200, Krzysztof Kozlowski wrote:
> On 16/07/2026 13:31, mohit.dsor@oss.qualcomm.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> > 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > 
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > ---
> >  MAINTAINERS                              |    7 +
> >  drivers/gpu/drm/bridge/Kconfig           |   18 +
> >  drivers/gpu/drm/bridge/Makefile          |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1293 ++++++++++++++++++++++++++++++
> >  4 files changed, 1319 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6dea93a41962..30be2eaf2bec 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15184,6 +15184,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
> >  F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
> >  
> > +LONTIUM LT9611C MIPI DSI TO HDMI BRIDGE
> > +M:	Sunyun Yang <syyang@lontium.com>
> > +M:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > +F:	drivers/gpu/drm/bridge/lontium-lt9611c.c
> > +
> >  LOONGARCH
> >  M:	Huacai Chen <chenhuacai@kernel.org>
> >  R:	WANG Xuerui <kernel@xen0n.name>
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 4a57d49b4c6d..b8959b8e2ad0 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >  	  HDMI signals
> >  	  Please say Y if you have such hardware.
> >  
> > +config DRM_LONTIUM_LT9611C
> > +	tristate "Lontium LT9611C DSI/HDMI bridge"
> > +	select SND_SOC_HDMI_CODEC if SND_SOC
> > +	depends on OF
> > +	select CRC8
> > +	select FW_LOADER
> > +	select DRM_PANEL_BRIDGE
> > +	select DRM_KMS_HELPER
> > +	select DRM_MIPI_DSI
> > +	select DRM_DISPLAY_HELPER
> > +	select DRM_DISPLAY_HDMI_STATE_HELPER
> > +	select REGMAP_I2C
> > +	help
> > +	  Driver for Lontium DSI to HDMI bridge
> > +	  chip driver that converts dual DSI and I2S to
> > +	  HDMI signals
> > +	  Please say Y if you have such hardware.
> 
> Please wrap the code to appropriate limits.
I checked the others in Kconfigs they appear to be similar,
still i will try to fix it.
> 
> ...
> 
> > +
> > +static void lt9611c_reset(struct lt9611c *lt9611c)
> > +{
> > +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +	usleep_range(10000, 12000);
> > +
> > +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +	msleep(400);
> > +
> > +	dev_dbg(lt9611c->dev, "lt9611c reset");
> 
> Same comment as before.
will remove all debug comments.
> 
> > +}
> > +
> 
> > +static int lt9611c_upgrade_result(struct lt9611c *lt9611c, u8 fw_crc)
> > +{
> > +	struct device *dev = lt9611c->dev;
> > +	unsigned int crc_result;
> > +
> > +	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> > +	regmap_read(lt9611c->regmap, 0xe021, &crc_result);
> > +
> > +	if (crc_result != fw_crc) {
> > +		dev_err(dev, "lt9611c fw upgrade failed, expected crc=0x%02x, read crc=0x%02x\n",
> > +			fw_crc, crc_result);
> > +		return -1;
> > +	}
> > +
> > +	dev_dbg(dev, "lt9611c firmware upgrade success, crc=0x%02x\n", crc_result);
> > +	return 0;
> > +}
> 
> ...
> 
> > +
> > +static ssize_t lt9611c_firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
> > +}
> > +
> > +static DEVICE_ATTR_RW(lt9611c_firmware);
> 
> Where is this ABI documented?
Will have its ABI documentation.
> 
> > +
> > +static struct attribute *lt9611c_attrs[] = {
> > +	&dev_attr_lt9611c_firmware.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group lt9611c_attr_group = {
> > +	.attrs = lt9611c_attrs,
> > +};
> > +
> > +static const struct attribute_group *lt9611c_attr_groups[] = {
> > +	&lt9611c_attr_group,
> > +	NULL,
> > +};
> > +
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c;
> > +	struct device *dev = &client->dev;
> > +	bool fw_updated = false;
> > +	int ret;
> > +
> > +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
> > +
> > +	lt9611c = devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &lt9611c_bridge_funcs);
> > +	if (IS_ERR(lt9611c))
> > +		return dev_err_probe(dev, PTR_ERR(lt9611c), "drm bridge alloc failed.\n");
> > +
> > +	lt9611c->dev = dev;
> > +	lt9611c->client = client;
> > +	lt9611c->chip_type = (uintptr_t)i2c_get_match_data(client);
> 
> uintptr_t is not for kernel, use unsigned long.
I will fix this.
> 
> 
> > +
> > +	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to init mutex\n");
> > +
> > +	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
> > +	if (IS_ERR(lt9611c->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
> > +
> > +	ret = lt9611c_parse_dt(dev, lt9611c);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> > +
> > +	ret = lt9611c_gpio_init(lt9611c);
> > +	if (ret < 0)
> > +		goto err_of_put;
> > +
> > +	ret = lt9611c_regulator_init(lt9611c);
> > +	if (ret < 0)
> > +		goto err_of_put;
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	if (ret)
> > +		goto err_of_put;
> > +
> > +	lt9611c_reset(lt9611c);
> > +
> > +	lt9611c_lock(lt9611c);
> > +
> > +	ret = lt9611c_read_chipid(lt9611c);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to read chip id.\n");
> > +		lt9611c_unlock(lt9611c);
> > +		goto err_disable_regulators;
> > +	}
> > +
> > +retry:
> > +	lt9611c->fw_version = lt9611c_read_version(lt9611c);
> > +	if (lt9611c->fw_version < 0) {
> > +		dev_err(dev, "failed to read fw version\n");
> > +		ret = -EOPNOTSUPP;
> > +		lt9611c_unlock(lt9611c);
> > +		goto err_disable_regulators;
> > +
> > +	} else if (lt9611c->fw_version == 0) {
> > +		if (!fw_updated) {
> > +			fw_updated = true;
> > +			ret = lt9611c_firmware_upgrade(lt9611c);
> > +			if (ret < 0) {
> > +				lt9611c_unlock(lt9611c);
> > +				goto err_disable_regulators;
> > +			}
> > +
> > +			goto retry;
> > +
> > +		} else {
> > +			dev_err(dev, "fw version 0x%04x, update failed\n", lt9611c->fw_version);
> > +			ret = -EOPNOTSUPP;
> > +			lt9611c_unlock(lt9611c);
> > +			goto err_disable_regulators;
> > +		}
> > +	}
> > +
> > +	lt9611c_unlock(lt9611c);
> > +	dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
> > +
> > +	INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
> > +
> > +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > +					lt9611c_irq_thread_handler,
> > +					IRQF_TRIGGER_FALLING |
> > +					IRQF_ONESHOT |
> > +					IRQF_NO_AUTOEN,
> > +					"lt9611c", lt9611c);
> > +	if (ret) {
> > +		dev_err(dev, "failed to request irq\n");
> > +		goto err_disable_regulators;
> > +	}
> > +
> > +	lt9611c->bridge.of_node = client->dev.of_node;
> > +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > +			DRM_BRIDGE_OP_EDID |
> > +			DRM_BRIDGE_OP_HPD |
> > +			DRM_BRIDGE_OP_HDMI |
> > +			DRM_BRIDGE_OP_HDMI_AUDIO;
> > +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> > +
> > +	lt9611c->bridge.vendor = "Lontium";
> > +	lt9611c->bridge.product = "LT9611C";
> > +
> > +	lt9611c->bridge.hdmi_audio_dev = dev;
> > +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> > +	lt9611c->bridge.hdmi_audio_dai_port = 2;
> > +
> > +	devm_drm_bridge_add(dev, &lt9611c->bridge);
> > +
> > +	/* Attach primary DSI */
> > +	lt9611c->dsi0 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> > +	if (IS_ERR(lt9611c->dsi0)) {
> > +		ret = PTR_ERR(lt9611c->dsi0);
> > +		goto err_remove_bridge;
> > +	}
> > +
> > +	/* Attach secondary DSI, if specified */
> > +	if (lt9611c->dsi1_node) {
> > +		lt9611c->dsi1 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi1_node);
> > +		if (IS_ERR(lt9611c->dsi1)) {
> > +			ret = PTR_ERR(lt9611c->dsi1);
> > +			goto err_remove_bridge;
> > +		}
> > +	}
> > +
> > +	lt9611c->hdmi_connected = false;
> > +	i2c_set_clientdata(client, lt9611c);
> > +	enable_irq(client->irq);
> > +
> > +	lt9611c_reset(lt9611c);
> > +	return 0;
> > +
> > +err_remove_bridge:
> > +	cancel_work_sync(&lt9611c->work);
> > +
> > +err_disable_regulators:
> > +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +
> > +err_of_put:
> > +	of_node_put(lt9611c->dsi1_node);
> > +	of_node_put(lt9611c->dsi0_node);
> > +
> > +	return ret;
> > +}
> > +
> > +static void lt9611c_remove(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c = i2c_get_clientdata(client);
> > +
> > +	cancel_work_sync(&lt9611c->work);
> > +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	of_node_put(lt9611c->dsi1_node);
> > +	of_node_put(lt9611c->dsi0_node);
> > +}
> > +
> > +static int lt9611c_bridge_suspend(struct device *dev)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	dev_dbg(lt9611c->dev, "suspend\n");
> 
> Same comments.
Will remove these debug prints.
> 
> 
> This does not look like useful printk message. Drivers should be silent
> on success:
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79
> 
> Best regards,
> Krzysztof
