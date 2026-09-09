Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0CEC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E287910F293;
	Wed,  9 Sep 2026 21:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eih6Wnpf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DV/RNyOo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0237B10F293
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 21:08:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIads2852001
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 21:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YGOr4z5VunluLH+EaYmR0ft7HmeTL6gHe7rOeRnzPdo=; b=eih6WnpftW1EBKUp
 qK7itorA1cR70xsG9XtVw2PjjHK5A2U4vI35blPhAkjzU05eyRA6F5gLFH6rp5CF
 ymspiD7eWBam+a6kT4ITEqDR5rAmFeksHkm9hyCbWRIISyuM/JB6WePnFBrlpLJk
 k78vhXyqSzlchxACbeOQGihAmNx+8P6aE3IK3YMATxUXhyUw9xsP8vzn+Ct0dfZ+
 y1iiV6iSDAaASz2ET4EKXb993+DQDI+fkCm2gxdWuMa4c7aI5id6TwLTUPQousea
 cCfOHy818OW2dpopojWztY084RysbEUDLPY5SoNwH3lpChfWH2UVdAqSepaaqEVY
 Odocfw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd0k44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 21:08:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so4243840a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988093; x=1789592893;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YGOr4z5VunluLH+EaYmR0ft7HmeTL6gHe7rOeRnzPdo=;
 b=DV/RNyOox79Hy6xNrppYj9NL8Bydg27tO1CEwc8RXUZvIgQwt4t2AxzshDYDZ0o5ty
 IDBc5siRTlttgq1FxjF4DF83dXQL6U4cpy29hcTvXVRWBVNf18Kqg1D5Rxx2yaQB69W0
 EJGQUrlBP/zWxi1oQ2pkk98Ey9JjJHsU9D/1m2fIoJpnXqL+7cf/w3ppVU9oYg20u+a2
 KqVj3MYc/95a57kicriAqOj0Q+7maJ83P8NaOloeKOc1/oFQK3cAuWmA0Y4FuJx2gprE
 /dTc3McVUMaB4MtNnjhqxWzOja7C23x7wcLFNbQE4N0mmaPGbgW0iSnn1gn8XY8Pw58p
 Dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988093; x=1789592893;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YGOr4z5VunluLH+EaYmR0ft7HmeTL6gHe7rOeRnzPdo=;
 b=ibkCWsyuumNmExazVlI9w7yP3jq65e4IVxbn/CTAYp9aKVgW4+/etvkcHViq2gG2Gk
 OsRQ8uD72B9vxfjOMXlQJF48zHPqqXgx3E4tGq8XwJrzUhgpv2ehJs6xl4iRDMUWTWUA
 SRY9pcCiWQd/yZ40fkUWjiVYIF0Dxch5o6kB+MixHDSpvFpi/4e7pJXzM3QXNdIA245b
 iMbBMXxWX4rhntIAP6sZYDNnppZbA1Henvw6NohU8Z+sb6iE0bXRGbacF/wbbw4aswtY
 4/GgJVypNVty8Hnoyn7x8mwbpK2ORpv3rn1+Q2emAeTiidB+w9WPTwG5sM5JjIg6Hsy7
 dSYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXPh92v6wuvdGB1MlxRanCJg3eNrvdd4nz/RytRS0H99hYwZ3R5dylLvwdnvO4jcFYvgdkxGkt55g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mI2pUeR9kraeAJsXE6KUD0ngvChsw9XZwpDRX7/A34G+xK445o
 jn2PflDY1zZ3kVyryC6ZBBLyqFLxHo7HLbGsnSzu4vCUnCxXF2dSG9qcnbeNyhTeQNrKcJySuUI
 /ISE+mrYfr3G1BnvJXTmFN7FXB+DMEPrXEBb8yzyAhCj6e4/q66ZE07l6Nw1ev8NqtHoiIP5xPX
 zam2Q=
X-Gm-Gg: AYBFou31zactjLN0NgH8WXd28sWGmrRu5w1zkrHOiFDZuXLKygpRkm1Ignqr49VgPdh
 xWNB/DUx7C3vUE3eEDqpFNC0u7u0MH3BaJMHtPBdvoDAZLo6T6I8DejcnjWfRY4v1DEQhAa0Vcc
 ngCKY+++bIQBw1hhEmJDbXN8oqBfk/K3OF9Viz/AY2q6HdjMJ2NgmyZ1ftWE6jC5TJ0/nhtsw4/
 z2X/JsdozBbPjTI2a7t5Vd4qhpWrS8ELhiemk9mJLClHdC5/uT9+Bc0HKm7QOai4d53vfJsaZMD
 dFXTIZlvpf8O9vbVRyp3OTo9eTRXu0i9OzUm2zWBc4RMUv4vw4IkBHo2PfdMOXGuZ9qMMQmhKv2
 9UVyFhGPIPizluUCHyzUpeNZ6nw==
X-Received: by 2002:a17:90b:2e8c:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39d7097de14mr4541003a91.4.1788988092655; 
 Wed, 09 Sep 2026 14:08:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8c:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39d7097de14mr4540945a91.4.1788988092185; 
 Wed, 09 Sep 2026 14:08:12 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm62231705c88.2.2026.09.09.14.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:08:11 -0700 (PDT)
Date: Thu, 10 Sep 2026 02:38:06 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
Subject: Re: [PATCH v13 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aqHKtvuWZCQTDnux@hu-mdsor-hyd.qualcomm.com>
References: <20260909-lt9611c-v7-v13-0-aec234483725@oss.qualcomm.com>
 <20260909-lt9611c-v7-v13-2-aec234483725@oss.qualcomm.com>
 <20260909095358.41EBC1F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909095358.41EBC1F00A3D@smtp.kernel.org>
X-Proofpoint-GUID: -Hoedm8bPbrsukBlfymSo2UtowwgtktL
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa1cabd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=DJsLk9TwWp4BRhIVdl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: -Hoedm8bPbrsukBlfymSo2UtowwgtktL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzNiBTYWx0ZWRfX9CkCPHpW1ZXP
 keJPNV4MyJ8OehVkJq+BocR6ZHjbTT69wlzsGLTpo7ikOjkxA0bxYA8awMl8SudXZ63hYBbgDkJ
 orvGu5nwcs+7EVGyFgSyV/CTEwWaCyo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzNiBTYWx0ZWRfXzDIO1gywczED
 fR7kVSXK3fCGrt9c0mSplmg2CK9zogb+V52xssibJd3Tu2gXYCWMbLImMVa3N8Rq8s96KjlMryH
 PAg3FV26WIqWPm+SWajh23NM6T0ZhVt+t3/hbRZChxBsutv+cFfILO8tiy6953GeZ8Bkksz6XFe
 VltXo8Wp3OqOb7nZAdb0qC7dqkhjty8D8RcNkjBs1t+/RIVxTBJEkKuI0gMMQjMPhuC7vzBUkQB
 VCWnBgPMzxD4GAVP46QsYUS0ZrIbYXramqCpXbcbdw2TB+K1J4alTm3UlIxKI/vy0hMtKpQCUMP
 Y1mvOOSmVD7IomMhB/l7jdac7ET9y3yXCimsHbdunks4utseoqh5BEzzysgxX+swquaXz0pY18W
 R70nf2xGk2qHdhishaWtEbg7JSFcl4GTQJ1b5BZhiZFjpz3nrOJj/GUuXOIv15ZqgOeYbYSjf1c
 ReWE9IWppKLRGOIVHJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090236
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

On Wed, Sep 09, 2026 at 09:53:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Hardware reset causes regmap's page selector cache to become desynchronized, leading to register accesses on the wrong page.
Same as the earlier lt9611c_reset question — win_page is a local variable recomputed from the target register address on
every access, not stored persistently in the regmap struct. With REGCACHE_NONE, _regmap_update_bits always performs a real
hardware read of the selector register before writing it. After GPIO reset the chip reverts to page 0x00, regmap reads that
back and re-issues the page selector write before accessing 0xe021. No desynchronization is possible.

> - [Medium] Memory leak of device tree node references on probe error paths.
This can be fixed with small change in v14 with any other comment if
there.
> --
> 
> commit 8472ac6fb646e6b178a64a965210c4a862f133a2
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit introduces a new DRM bridge driver for the Lontium 
> LT9611C(EX/UXD) DSI to HDMI chip. It handles chip initialization, EDID 
> reading, firmware upgrading, and audio infoframe setup.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> [ ... ]
> > +	ret = lt9611c_parse_dt(dev, lt9611c, &dsi0_node, &dsi1_node);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> > +
> > +	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(lt9611c->reset_gpio)) {
> > +		ret = PTR_ERR(lt9611c->reset_gpio);
> > +		return ret;
> > +	}
> 
> [Severity: Medium]
> Does this error path leak the device tree node references? The call to
> lt9611c_parse_dt() acquires remote endpoint nodes for dsi0_node and
> dsi1_node, but returning directly here skips dropping those references with
> of_node_put(). Should this jump to an error cleanup label instead?
> 
> > +
> > +	ret = lt9611c_regulator_init(lt9611c);
> > +	if (ret < 0)
> > +		return ret;
> 
> [Severity: Medium]
> Similarly, could this return statement leak the same device tree node
> references from lt9611c_parse_dt() if regulator initialization fails?
> 
> [ ... ]
> > +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> > +{
> [ ... ]
> > +	ret = lt9611c_write_crc(lt9611c, fw_crc, FW_SIZE - 1);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to write firmware crc\n");
> > +		goto out_unlock;
> > +	}
> > +
> > +	lt9611c_reset(lt9611c);
> > +	ret = lt9611c_upgrade_result(lt9611c, fw_crc);
> 
> [Severity: High]
> Can this cause regmap's page selector cache to become desynchronized?
> 
> The lt9611c_firmware_upgrade() function writes to page 0xe0 earlier, then
> lt9611c_reset() toggles the reset GPIO. This reverts the chip's internal
> page register to its default (0x00), but the regmap core's internal state
> caches the window as still being at 0xe0.
> 
> When lt9611c_upgrade_result() immediately attempts to read from 0xe021,
> will regmap skip writing the page selector and accidentally read from
> page 0x00 instead, causing the upgrade verification to fail?
> 
> [ ... ]
> > +static int lt9611c_bridge_resume(struct device *dev)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	if (ret) {
> > +		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> > +		return ret;
> > +	}
> > +	lt9611c_reset(lt9611c);
> > +	enable_irq(lt9611c->client->irq);
> > +
> > +	return ret;
> > +}
> 
> [Severity: High]
> Does this reset during resume also desynchronize the regmap cache for any
> subsequent display setup or HPD detect reads?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909-lt9611c-v7-v13-0-aec234483725@oss.qualcomm.com?part=2
