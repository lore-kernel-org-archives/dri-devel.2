Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2955BC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A2F10EC51;
	Wed, 29 Jul 2026 13:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuvQdUpF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4oHHnwb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8014210EC43
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:51:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TD82O52086941
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DE2JR7xmZ4gfmqIwBCA6tR5V
 xSrUtmuIMA4ENvIAfDA=; b=fuvQdUpFfdVLHtXkCZSqoNsY71XJO7xvmK+WfBTl
 80infWDoqAZ4tpIQU4ZxgQOnc0gPswc6oLp8vm6eT2iaiDITa0zt24kWKE8frjeT
 YSLkk/Tj+pyc7xfj3JVKqFn13rPlojQmhu5sHFin9XIISdn15RKLiRhIIhQDy9c3
 9qBqA5aMXlrsBStDm/yJBLGhRJK1r9MuR7VWmC5+OYZGPsm9KXCeQMeDlzzzouQK
 wHddsdBK4bORlSematksBm10vc8McqKuweCGanXEsC+OhQPsedehmBUvvMDlV1pv
 LFQr9RZX5cpuzxGi7R/I8s65JZgQVMQsiomTX/LTZPjg8g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhe98csv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:51:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-522de3c645dso18934151cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785333096; x=1785937896;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DE2JR7xmZ4gfmqIwBCA6tR5VxSrUtmuIMA4ENvIAfDA=;
 b=N4oHHnwbMsFqq0aTqS0X8fCi98IPJvaGMi7Wtwop8b37aBuKha7UNRVMQ7rRxMf9gB
 HDNVj+Nz7Vryk00SGZ7A8Eyjqv1iJMOY+zR50eE7+W8ts0+7w+6cGru7NXoxElpVTWQV
 rjDaYI8ZV8eC9EeO7JDbGlslsIl79BUFlNmbpQuhlFtGaEik0R8LLW5TO0gTqzihFiGV
 QbD3kX3yetLK6bfW4hiCX7Tp1w9iSKFJS5tfEnDiHOE07T40Poiow+NtSsAKFFD3FSvJ
 tO6LsHForMIzdETBtQS1VNwCdN3hVjHCTa6gIV8h2nlPvstvSu8RazuWQeyh4pnpaQqP
 qLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333096; x=1785937896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DE2JR7xmZ4gfmqIwBCA6tR5VxSrUtmuIMA4ENvIAfDA=;
 b=hJuCYZqHTtDezrdraQAmm/A0lJad+FEBsflwQdbxiM9S+uQjTgOn18QlioJ9mvoDLx
 yYUNE7Q2RU+2g6GysXPrHdTDnrEptz6ZqSnbItmFyqCN4hBtlKucZo8gx0M/OqQriiqB
 sPFLeXKFnWNWVWiirERyR+SulMboCv3xBjUM9r8akdSGxQ4P7tbGNh6CCyBMk1g6uGok
 PQy/YBSKIIrlbBhHO80H7nkOTIiIzyJcBLIkRHDCSM47FWLWOQnR36irt2lvP1K0TJ1e
 g4+j2wACpG0KJjRHCm5PqY56aMOGaucJlhIuww+DPd7X7s5jsgRNP+12Gq6kZOWpSJGb
 q7xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAKHylj9tX93FXlmSbSx97DTOqUe0HS/jn6kDA0p1/I5uzVYRzccAGMvUIbg/4B8ZV207tVb4v6TM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNhEW1U2J2MTpE/8no5f35yrqQpBCTroaJDQ+BzNHUiZbQ53G0
 EfGOueECKxkyWK5MLOPeq4zpqwOJ6FIMR1Jtin2y1ZE8dMs2tvVyq2HKiPMOxL6BqJb3VSZtvgl
 uOLp6xBjX4jwsp6Eryhb2ue68x7c5a69QAR43esP79ePZmakMtGwbsg5SVyNhR2wyPLW7BEU=
X-Gm-Gg: AR+sD12p3BM0Cz7pxg6xpQZZNWxt/Pd0Nw75DZgHOIL77zg6FE6N9sN7xbjqOMlws4Q
 CcW5HKqEr5bq5d3m7gim+2fRHiutKFDlBafJdaVgRN7zWMbCUG3qF5gKa8bzZaLb9T/3WAT50CN
 FVfaJJoWmzj+r0AEmz3Q+apkv/RlAt8DBml8MywnOGSMnQgVPK0H57q8fr/v0FjdnGtiN1l8Jo+
 JniSgKy4PPl2Z7QCHNdL/UF/qdaWvup8IuSO3PB+/yaDIkk90bLo/pDsAmSLj0u5ipyzNyo2G34
 ne5tVQQ6fbNv94UOLmOEjV49icS5sAcjc/X4ibnUlFXPqaq6MEgeghW4aFX5prvC3VjWXb1ch9t
 mf5HrapipdYSCV+6/Ix/dB66sZXuJhlcrSOd5XGoGNdUQpL3QoFnRmUzeVo/WV3JufxXbhtplC+
 q/y5c6x2OHHfBRpg==
X-Received: by 2002:a05:622a:2d4:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-529d6f91cd1mr61536021cf.14.1785333093227; 
 Wed, 29 Jul 2026 06:51:33 -0700 (PDT)
X-Received: by 2002:a05:622a:2d4:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-529d6f91cd1mr61535101cf.14.1785333091985; 
 Wed, 29 Jul 2026 06:51:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2d76972bcsm411540e87.13.2026.07.29.06.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 06:51:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:51:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: mohit.dsor@oss.qualcomm.com
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
 Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <r36vjnld2b3luf4ogzdkdnj4fmq3anlkvhuunfr3fshrl22kd4@wv5vkz5f2hio>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX4ut2pMFS4jg9
 UYFru3Tjkhd62xqXw0YPpyeczrsDxZ1W4ZbzbjYhDCk/FoAg0bit/ePdD86X4K71yAcO8a9Em5u
 WWIzk+XzdUZaGSFVjEqjinz1U+PYNQEcTlaQ83DbumG+qEy/DtWEUG5HF5+6F4TsiHOQGrwT7Fi
 2xwMtgXrJyLdfvP9OM8JSRrZ3IQ+DYQXSSDFiLqnx6EeR7w6vtn2XnT2sdgR+JNkMKIm7vzV44K
 s7nsV7GFf4mL3y4DkugAC848+yJ4myLJi7H09NyQRzIFH0NH4MnKARbsqzWq7Rv6bSxqaEkVZJJ
 Wyypkeh44nxsJDlHt0+eUl71sY1KiWOEfEw6FYlnNtMWzjf+XkvPkuqMXbJg5a0//nU+9wvciVe
 XF9wIek6x6JvKek4PgfudjO1rd2FFUhd7N4g8giHTqcKK8y8As4E5Bk6xTqg0E5yqUTIT9Dwiy1
 SSdLIwic5AODtojRBNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX6MP63OQ/l+hz
 vg8Iamy9mlteT6qvSA1Np32+6+ejyR43QZDCjUK/zn/mqw5U/rq+mAhXXGgDv/NIWQjRjSM/N8Y
 B/8JBnu+jPVZyQrNnuhTktZAQ/i5aFE=
X-Proofpoint-ORIG-GUID: cSFJ-RejqaDKzFVCFV_kc_w1a36-qfH_
X-Proofpoint-GUID: cSFJ-RejqaDKzFVCFV_kc_w1a36-qfH_
X-Authority-Analysis: v=2.4 cv=EsriaycA c=1 sm=1 tr=0 ts=6a6a0568 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=dI23vUkywumJS1iDiBUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290114
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

On Tue, Jul 28, 2026 at 04:39:19PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> ---
>  .../ABI/testing/sysfs-driver-lontium-lt9611c       |   11 +
>  drivers/gpu/drm/bridge/Kconfig                     |   17 +
>  drivers/gpu/drm/bridge/Makefile                    |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1344 ++++++++++++++++++++
>  4 files changed, 1373 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c b/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c
> new file mode 100644
> index 000000000000..440e102a8bd8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/i2c/drivers/lt9611c/.../lt9611c_firmware

Let's unify this a bit. Rename it to be just 'firmware' and define it as
a generic attribute for all Lontium bridges. I will follow up with a
change to LT9611UXC driver.

> +Date:		July 2026
> +KernelVersion:	7.3
> +Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> +Description:
> +		Read: Returns the current firmware version loaded on the
> +		LT9611C(EX/UXD) chip in hex format (e.g. "0x0105").
> +
> +		Write: Triggers a firmware upgrade of the LT9611C(EX/UXD)
> +		chip using the firmware file Lontium/lt9611c_fw.bin loaded
> +		via the firmware loader.



> +
> +struct lt9611c {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct drm_bridge bridge;
> +	struct regmap *regmap;
> +	/* Protects all accesses to registers by stopping the on-chip MCU */

The mutex doesn't stop the MCU.

> +	struct mutex ocm_lock;
> +	struct work_struct work;
> +	struct device_node *dsi0_node;
> +	struct device_node *dsi1_node;
> +	struct mipi_dsi_device *dsi0;
> +	struct mipi_dsi_device *dsi1;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[2];
> +	int fw_version;
> +	/* Chip variant: C/EX/UXD */
> +	enum lt9611_chip_type chip_type;
> +	 /* HDMI cable connection status */
> +	bool hdmi_connected;
> +};
> +
> +static int lt9611c_read_write_flow(struct lt9611c *lt9611c,
> +				   const struct lt9611c_cmd *cmd,
> +				   struct lt9611c_rsp *rsp)
> +{
> +	int ret;
> +	unsigned int i;
> +	unsigned int temp;
> +	unsigned int max_params = 0xe0dd - 0xe0b0 + 1;
> +
> +	regmap_write(lt9611c->regmap, 0xe0de, 0x01);
> +
> +	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
> +				       temp == 0x01, 1000, 200 * 1000);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	regmap_write(lt9611c->regmap, 0xe0b0 + 0, cmd->hdr.func);
> +	regmap_write(lt9611c->regmap, 0xe0b0 + 1, cmd->hdr.type);
> +	regmap_write(lt9611c->regmap, 0xe0b0 + 2, cmd->hdr.seq);
> +	regmap_write(lt9611c->regmap, 0xe0b0 + 3, cmd->hdr.sep);

Can this use a bulk write?

> +
> +	for (i = 0; cmd->data && i < cmd->data_len &&
> +	     (LT9611C_CMD_HDR_SIZE + i) < max_params; i++)
> +		regmap_write(lt9611c->regmap,
> +			     0xe0b0 + LT9611C_CMD_HDR_SIZE + i, cmd->data[i]);
> +
> +	regmap_write(lt9611c->regmap, 0xe0de, 0x02);
> +
> +	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
> +				       temp == 0x02, 1000, 200 * 1000);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	ret = regmap_bulk_read(lt9611c->regmap, 0xe085,
> +			       &rsp->hdr, LT9611C_CMD_HDR_SIZE);
> +	if (ret)
> +		return ret;
> +
> +
> +	if (rsp->data && rsp->data_len)
> +		ret = regmap_bulk_read(lt9611c->regmap,
> +				       0xe085 + LT9611C_CMD_HDR_SIZE,
> +				       rsp->data, rsp->data_len);
> +
> +	return ret;
> +}
> +
> +static void lt9611c_config_parameters(struct lt9611c *lt9611c)
> +{
> +	const struct reg_sequence seq_write_paras[] = {
> +		REG_SEQ0(0xe0ee, 0x01),
> +		REG_SEQ0(0xe103, 0x3f), /*fifo rst*/
> +		REG_SEQ0(0xe103, 0xff),
> +		REG_SEQ0(0xe05e, 0xc1),
> +		REG_SEQ0(0xe058, 0x00),
> +		REG_SEQ0(0xe059, 0x50),
> +		REG_SEQ0(0xe05a, 0x10),
> +		REG_SEQ0(0xe05a, 0x00),
> +		REG_SEQ0(0xe058, 0x21),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write_paras, ARRAY_SIZE(seq_write_paras));
> +}
> +
> +static void lt9611c_wren(struct lt9611c *lt9611c)
> +{
> +	regmap_write(lt9611c->regmap, 0xe05a, 0x04);
> +	regmap_write(lt9611c->regmap, 0xe05a, 0x00);
> +}
> +
> +static void lt9611c_wrdi(struct lt9611c *lt9611c)
> +{
> +	regmap_write(lt9611c->regmap, 0xe05a, 0x08);
> +	regmap_write(lt9611c->regmap, 0xe05a, 0x00);
> +}
> +
> +static void lt9611c_erase_op(struct lt9611c *lt9611c, u32 addr)
> +{
> +	const struct reg_sequence seq_write[] = {
> +		REG_SEQ0(0xe0ee, 0x01),
> +		REG_SEQ0(0xe05a, 0x04),
> +		REG_SEQ0(0xe05a, 0x00),
> +		REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
> +		REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
> +		REG_SEQ0(0xe05d, addr & 0xff),
> +		REG_SEQ0(0xe05a, 0x01),
> +		REG_SEQ0(0xe05a, 0x00),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
> +}
> +
> +static void read_flash_reg_status(struct lt9611c *lt9611c, unsigned int *status)
> +{
> +	const struct reg_sequence seq_write[] = {
> +		REG_SEQ0(0xe103, 0x3f),
> +		REG_SEQ0(0xe103, 0xff),
> +		REG_SEQ0(0xe05e, 0x40),
> +		REG_SEQ0(0xe056, 0x05),
> +		REG_SEQ0(0xe055, 0x25),
> +		REG_SEQ0(0xe055, 0x01),
> +		REG_SEQ0(0xe058, 0x21),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
> +
> +	regmap_read(lt9611c->regmap, 0xe05f, status);
> +}
> +
> +static void lt9611c_crc_to_sram(struct lt9611c *lt9611c)
> +{
> +	const struct reg_sequence seq_write[] = {
> +		REG_SEQ0(0xe051, 0x00),
> +		REG_SEQ0(0xe055, 0xc0),
> +		REG_SEQ0(0xe055, 0x80),
> +		REG_SEQ0(0xe05e, 0xc0),
> +		REG_SEQ0(0xe058, 0x21),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
> +}
> +
> +static void lt9611c_data_to_sram(struct lt9611c *lt9611c)
> +{
> +	const struct reg_sequence seq_write[] = {
> +		REG_SEQ0(0xe051, 0xff),
> +		REG_SEQ0(0xe055, 0x80),
> +		REG_SEQ0(0xe05e, 0xc0),
> +		REG_SEQ0(0xe058, 0x21),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
> +}
> +
> +static void lt9611c_sram_to_flash(struct lt9611c *lt9611c, size_t addr)
> +{
> +	const struct reg_sequence seq_write[] = {
> +		REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
> +		REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
> +		REG_SEQ0(0xe05d, addr & 0xff),
> +		REG_SEQ0(0xe05a, 0x30),
> +		REG_SEQ0(0xe05a, 0x00),
> +	};
> +
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
> +}
> +
> +static void lt9611c_block_erase(struct lt9611c *lt9611c)
> +{
> +	int i;
> +	unsigned int block_num;
> +	unsigned int flash_status = 0;
> +	u32 flash_addr = 0;
> +
> +	for (block_num = 0; block_num < 2; block_num++) {
> +		flash_addr = (block_num * 0x008000);

Drop extra brackets.

> +		lt9611c_erase_op(lt9611c, flash_addr);
> +		msleep(100);
> +		i = 0;
> +		while (1) {
> +			read_flash_reg_status(lt9611c, &flash_status);
> +			if ((flash_status & 0x01) == 0)
> +				break;
> +
> +			if (i > 50)
> +				break;
> +
> +			i++;
> +			msleep(50);

Use existing polling macros.

> +		}
> +	}
> +}
> +
> +static int lt9611c_write_data(struct lt9611c *lt9611c, const struct firmware *fw, size_t addr)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	unsigned int page = 0, num = 0, i = 0;
> +	size_t size, index;
> +	const u8 *data;
> +	u8 value;
> +
> +	data = fw->data;
> +	size = fw->size;
> +	page = (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;

DIV_ROUND_UP

> +	if (page * LT_PAGE_SIZE > FW_SIZE) {
> +		dev_err(dev, "firmware size out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "%u pages, total size %zu byte\n", page, size);
> +
> +	for (num = 0; num < page; num++) {
> +		lt9611c_data_to_sram(lt9611c);
> +
> +		for (i = 0; i < LT_PAGE_SIZE; i++) {
> +			index = num * LT_PAGE_SIZE + i;
> +			value = (index < size) ? data[index] : 0xff;
> +
> +			ret = regmap_write(lt9611c->regmap, 0xe059, value);

Again, is it possible to use bulk functions instead of writing it byte
per byte?

> +			if (ret < 0) {
> +				dev_err(dev, "write error at page %u, index %u\n", num, i);
> +				return ret;
> +			}
> +		}
> +
> +		lt9611c_wren(lt9611c);
> +		lt9611c_sram_to_flash(lt9611c, addr);
> +
> +		addr += LT_PAGE_SIZE;
> +	}
> +
> +	lt9611c_wrdi(lt9611c);
> +
> +	return 0;
> +}
> +
> +static int lt9611c_write_crc(struct lt9611c *lt9611c, u8 fw_crc, size_t addr)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	lt9611c_crc_to_sram(lt9611c);
> +	ret = regmap_write(lt9611c->regmap, 0xe059, fw_crc);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write crc\n");
> +		return ret;
> +	}
> +
> +	lt9611c_wren(lt9611c);
> +	lt9611c_sram_to_flash(lt9611c, addr);
> +	lt9611c_wrdi(lt9611c);
> +
> +	dev_dbg(dev, "crc 0x%02x written to flash at addr 0x%zx\n", fw_crc, addr);
> +
> +	return 0;
> +}
> +
> +static void lt9611c_reset(struct lt9611c *lt9611c)
> +{
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +	usleep_range(10000, 12000);
> +
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> +	msleep(400);
> +}
> +
> +static int lt9611c_upgrade_result(struct lt9611c *lt9611c, u8 fw_crc)
> +{
> +	struct device *dev = lt9611c->dev;
> +	unsigned int crc_result;
> +
> +	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +	regmap_read(lt9611c->regmap, 0xe021, &crc_result);
> +
> +	if (crc_result != fw_crc) {
> +		dev_err(dev, "lt9611c fw upgrade failed, expected crc=0x%02x, read crc=0x%02x\n",
> +			fw_crc, crc_result);
> +		return -1;
> +	}
> +
> +	dev_dbg(dev, "lt9611c firmware upgrade success, crc=0x%02x\n", crc_result);
> +	return 0;
> +}
> +
> +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	const struct firmware *fw;
> +	u8 *buffer;
> +	size_t total_size = FW_SIZE - 1;
> +	u8 fw_crc;
> +	int ret;
> +
> +	/* 1. load firmware */
> +	ret = request_firmware(&fw, FW_FILE, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);
> +
> +	/* 2. check size */
> +	if (fw->size > total_size) {
> +		dev_err(dev, "firmware too large (%zu > %zu)\n", fw->size, total_size);
> +		ret = -EINVAL;
> +		goto out_release_fw;
> +	}
> +	dev_dbg(dev, "firmware size: %zu bytes\n", fw->size);
> +
> +	/* 3. calculate crc8 */
> +	buffer = kzalloc(total_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out_release_fw;
> +	}
> +
> +	memcpy(buffer, fw->data, fw->size);
> +	memset(buffer + fw->size, 0xff, total_size - fw->size);
> +
> +	fw_crc = crc8(lt9611c_crc8_table, buffer, total_size, 0);
> +	kfree(buffer);
> +
> +	dev_info(dev, "starting firmware upgrade, size: %zu bytes, crc: 0x%02x\n",
> +		 fw->size, fw_crc);
> +
> +	/* 4. firmware upgrade */
> +	lt9611c_config_parameters(lt9611c);
> +	lt9611c_block_erase(lt9611c);
> +
> +	ret = lt9611c_write_data(lt9611c, fw, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write firmware data\n");
> +		goto out_release_fw;
> +	}
> +
> +	ret = lt9611c_write_crc(lt9611c, fw_crc, FW_SIZE - 1);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write firmware crc\n");
> +		goto out_release_fw;
> +	}
> +
> +	/* 5. check upgrade of result */
> +	lt9611c_reset(lt9611c);
> +	ret = lt9611c_upgrade_result(lt9611c, fw_crc);
> +
> +out_release_fw:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
> +static struct lt9611c *bridge_to_lt9611c(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct lt9611c, bridge);
> +}
> +
> +static const struct lt9611c *bridge_to_lt9611c_const(const struct drm_bridge *bridge)
> +{
> +	return container_of_const(bridge, struct lt9611c, bridge);
> +}
> +
> +static void lt9611c_lock(struct lt9611c *lt9611c)
> +{
> +	mutex_lock(&lt9611c->ocm_lock);
> +	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +}
> +
> +static void lt9611c_unlock(struct lt9611c *lt9611c)
> +{
> +	regmap_write(lt9611c->regmap, 0xe0ee, 0x00);
> +	mutex_unlock(&lt9611c->ocm_lock);
> +}
> +
> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
> +	struct lt9611c *lt9611c = dev_id;
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	unsigned int irq_status;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read irq status: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(irq_status & BIT(0)))
> +		return IRQ_HANDLED;
> +
> +	/*Clear interrupt: hardware requires two writes with delay*/
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> +	usleep_range(10000, 12000);
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> +
> +	schedule_work(&lt9611c->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void lt9611c_hpd_work(struct work_struct *work)
> +{
> +	struct lt9611c *lt9611c = container_of(work, struct lt9611c, work);
> +	struct device *dev = lt9611c->dev;
> +	static const u8 hpd_data[] = { 0x00 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> +		.data = hpd_data,
> +		.data_len = 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> +	bool connected;
> +	int ret;
> +
> +	/* Added delay as need time to reflect hpd after interrupt*/
> +	msleep(200);
> +
> +	mutex_lock(&lt9611c->ocm_lock);
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret) {
> +		dev_err(dev, "failed to read HPD status\n");
> +	} else {
> +		lt9611c->hdmi_connected = (hpd_status == 0x02);
> +	}
> +	connected = lt9611c->hdmi_connected;
> +	mutex_unlock(&lt9611c->ocm_lock);
> +
> +	drm_bridge_hpd_notify(&lt9611c->bridge,
> +			      connected ? connector_status_connected :
> +			      connector_status_disconnected);
> +}
> +
> +static int lt9611c_regulator_init(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	lt9611c->supplies[0].supply = "vcc";
> +	lt9611c->supplies[1].supply = "vdd";
> +
> +	ret = devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
> +
> +	return ret;
> +}
> +
> +static struct mipi_dsi_device *lt9611c_attach_dsi(struct lt9611c *lt9611c,
> +						  struct device_node *dsi_node)
> +{
> +	const struct mipi_dsi_device_info info = { "lt9611c", 0, NULL };
> +	struct mipi_dsi_device *dsi;
> +	struct mipi_dsi_host *host;
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	host = of_find_mipi_dsi_host_by_node(dsi_node);
> +	if (!host)
> +		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
> +
> +	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> +	if (IS_ERR(dsi))
> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(dsi), "failed to create dsi device\n"));
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			 MIPI_DSI_MODE_VIDEO_HSE;
> +
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0)
> +		return ERR_PTR(dev_err_probe(dev, ret, "failed to attach dsi to host\n"));
> +
> +	return dsi;
> +}
> +
> +static int lt9611c_bridge_attach(struct drm_bridge *bridge,
> +				 struct drm_encoder *encoder,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +
> +	return drm_bridge_attach(encoder, lt9611c->bridge.next_bridge, bridge, flags);
> +}
> +
> +static enum drm_mode_status
> +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> +				  const struct drm_display_mode *mode,
> +				  unsigned long long tmds_rate)
> +{
> +	const struct lt9611c *lt9611c = bridge_to_lt9611c_const(bridge);
> +
> +	if (lt9611c->chip_type == CHIP_LT9611UXD) {
> +		if (tmds_rate > 600000000)

Extract max TMDS rate to match data. Compare to the value from the match
data here.

> +			return MODE_CLOCK_HIGH;
> +
> +	} else {
> +		if (tmds_rate > 340000000)
> +			return MODE_CLOCK_HIGH;
> +	}
> +
> +	if (tmds_rate < 25000000)
> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}
> +
> +static void lt9611c_video_setup(struct lt9611c *lt9611c,
> +				const struct drm_display_mode *mode)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	u32 h_total, hactive, hsync_len, hfront_porch, hback_porch;
> +	u32 v_total, vactive, vsync_len, vfront_porch, vback_porch;
> +	u8 timing_data[22];
> +	struct lt9611c_rsp rsp = {};
> +	u8 framerate;
> +	u8 vic = 0x00;
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
> +		.data = timing_data,
> +		.data_len = ARRAY_SIZE(timing_data),
> +	};
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +	h_total = mode->htotal;
> +	hactive = mode->hdisplay;
> +	hsync_len = mode->hsync_end - mode->hsync_start;
> +	hfront_porch = mode->hsync_start - mode->hdisplay;
> +	hback_porch = mode->htotal - mode->hsync_end;
> +
> +	v_total = mode->vtotal;
> +	vactive = mode->vdisplay;
> +	vsync_len = mode->vsync_end - mode->vsync_start;
> +	vfront_porch = mode->vsync_start - mode->vdisplay;
> +	vback_porch = mode->vtotal - mode->vsync_end;
> +	framerate = drm_mode_vrefresh(mode);
> +	vic = drm_match_cea_mode(mode);
> +
> +	dev_dbg(dev, "hactive=%d, vactive=%d\n", hactive, vactive);
> +	dev_dbg(dev, "framerate=%d\n", framerate);
> +	dev_dbg(dev, "vic = 0x%02x\n", vic);
> +
> +	timing_data[0] = (h_total >> 8) & 0xff;
> +	timing_data[1] = h_total & 0xff;

<linux/unaligned.h> ?

> +	timing_data[2] = (hactive >> 8) & 0xff;
> +	timing_data[3] = hactive & 0xff;
> +	timing_data[4] = (hfront_porch >> 8) & 0xff;
> +	timing_data[5] = hfront_porch & 0xff;
> +	timing_data[6] = (hsync_len >> 8) & 0xff;
> +	timing_data[7] = hsync_len & 0xff;
> +	timing_data[8] = (hback_porch >> 8) & 0xff;
> +	timing_data[9] = hback_porch & 0xff;
> +	timing_data[10] = (v_total >> 8) & 0xff;
> +	timing_data[11] = v_total & 0xff;
> +	timing_data[12] = (vactive >> 8) & 0xff;
> +	timing_data[13] = vactive & 0xFF;
> +	timing_data[14] = (vfront_porch >> 8) & 0xff;
> +	timing_data[15] = vfront_porch & 0xff;
> +	timing_data[16] = (vsync_len >> 8) & 0xff;
> +	timing_data[17] = vsync_len & 0xff;
> +	timing_data[18] = (vback_porch >> 8) & 0xff;
> +	timing_data[19] = vback_porch & 0xff;
> +	timing_data[20] = framerate;
> +	timing_data[21] = vic;
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret)
> +		dev_err(dev, "video set failed\n");
> +}
> +
> +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_display_mode *mode;
> +
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	if (WARN_ON(!connector))
> +		return;
> +
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	if (WARN_ON(!conn_state))
> +		return;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return;
> +
> +	mode = &crtc_state->adjusted_mode;
> +
> +	lt9611c_video_setup(lt9611c, mode);
> +}
> +
> +static enum drm_connector_status
> +lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	bool connected = false;
> +	static const u8 hpd_data[] = { 0x00 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> +		.data = hpd_data,
> +		.data_len = 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret) {
> +		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
> +	} else {
> +		connected = (hpd_status == 0x02);
> +	}
> +
> +	lt9611c->hdmi_connected = connected;
> +
> +	return connected ? connector_status_connected :
> +				connector_status_disconnected;
> +}
> +
> +static int lt9611c_get_edid_block(void *data, u8 *buf,
> +				  unsigned int block, size_t len)
> +{
> +	struct lt9611c *lt9611c = data;
> +	struct device *dev = lt9611c->dev;
> +	u8 edid_raw[LT9611C_CMD_Y0_SIZE + LT9611C_EDID_BUF_SIZE];
> +	u8 y0;
> +	int ret, i, offset = 0;
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x33, LT9611C_CMD_SEP },
> +	};
> +	struct lt9611c_rsp rsp = {
> +		.data = edid_raw,
> +		.data_len = LT9611C_CMD_Y0_SIZE + LT9611C_EDID_BUF_SIZE,
> +	};
> +
> +	if (len != 128)
> +		return -EINVAL;
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	for (i = 0; i < 4; i++) {
> +		y0 = block * 4 + i;
> +		cmd.data = &y0;
> +		cmd.data_len = 1;
> +		ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +		if (ret) {
> +			dev_err(dev, "Failed to read EDID block %u packet %d\n",
> +				block, i);
> +			return ret;
> +		}
> +		memcpy(buf + offset, &edid_raw[LT9611C_CMD_Y0_SIZE], LT9611C_EDID_BUF_SIZE);
> +		offset += LT9611C_EDID_BUF_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct drm_edid *lt9611c_bridge_edid_read(struct drm_bridge *bridge,
> +						       struct drm_connector *connector)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +
> +	return drm_edid_read_custom(connector, lt9611c_get_edid_block, lt9611c);
> +}
> +
> +static int lt9611c_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
> +					    const u8 *buffer, size_t len)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
> +	struct lt9611c_rsp rsp = {};
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
> +	};
> +
> +	if (WARN_ON(len > LT9611C_INFOFRAME_MAX_SIZE))
> +		return -EINVAL;
> +
> +	extra[0] = 0x01; /* write avi */
> +	memcpy(&extra[1], buffer, len);
> +	cmd.data = extra;
> +	cmd.data_len = 1 + len;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +}
> +
> +static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	static const u8 clear_data[] = { 0x01 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
> +				   .data = clear_data, .data_len = 1 };
> +	struct lt9611c_rsp rsp = {};
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "clear avi infoframe failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
> +					     const u8 *buffer, size_t len)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
> +	struct lt9611c_rsp rsp = {};
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
> +	};
> +
> +	if (WARN_ON(len > LT9611C_INFOFRAME_MAX_SIZE))
> +		return -EINVAL;
> +
> +	extra[0] = 0x04; /* write vsif */
> +	memcpy(&extra[1], buffer, len);
> +	cmd.data = extra;
> +	cmd.data_len = 1 + len;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);

All the infoframe functions look (almost) exactly the same. Is it worth
extracting the common code?

> +}
> +
> +static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	static const u8 clear_data[] = { 0x04 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
> +				   .data = clear_data, .data_len = 1 };
> +	struct lt9611c_rsp rsp = {};
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "clear hdmi infoframe failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
> +					      const u8 *buffer, size_t len)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
> +	struct lt9611c_rsp rsp = {};
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
> +	};
> +
> +	extra[0] = 0x02; /* write audio */
> +	memcpy(&extra[1], buffer, len);
> +	cmd.data = extra;
> +	cmd.data_len = 1 + len;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +}
> +
> +static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	static const u8 clear_data[] = { 0x02 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
> +				   .data = clear_data, .data_len = 1 };
> +	struct lt9611c_rsp rsp = {};
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "clear audio infoframe failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> +				      struct drm_connector *connector,
> +				      struct hdmi_codec_daifmt *fmt,
> +				      struct hdmi_codec_params *hparms)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 audio_extra[2];
> +	struct lt9611c_rsp rsp = {};
> +	int ret;
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x36, LT9611C_CMD_SEP },
> +				   .data = audio_extra,
> +				   .data_len = ARRAY_SIZE(audio_extra) };
> +
> +	if (hparms->sample_width == 32)
> +		return -EINVAL;
> +
> +	switch (fmt->fmt) {
> +	case HDMI_I2S:
> +		audio_extra[0] = 0x01;
> +		break;
> +	case HDMI_SPDIF:
> +		audio_extra[0] = 0x02;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	audio_extra[1] = hparms->channels;
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "set audio info failed!\n");
> +		return ret;
> +	}
> +
> +	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector,
> +									&hparms->cea);
> +}
> +
> +static void lt9611c_hdmi_audio_shutdown(struct drm_bridge *bridge,
> +					struct drm_connector *connector)
> +{
> +	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> +}
> +
> +static void lt9611c_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	static const u8 hpd_data[] = { 0x00 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> +		.data = hpd_data,
> +		.data_len = 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> +	int ret;
> +
> +	mutex_lock(&lt9611c->ocm_lock);

scoped_guard()

> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (!ret)
> +		lt9611c->hdmi_connected = (hpd_status == 0x02);
> +	mutex_unlock(&lt9611c->ocm_lock);

How does hpd_enable work? Will it report HPD events even if the bridge
is suspended? WHere is hpd_disable() callback?

> +
> +	schedule_work(&lt9611c->work);
> +}
> +
> +static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
> +				      struct drm_connector *connector)
> +{
> +	return 0;
> +}

Misplaced and unnecessary.

> +
> +static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
> +	.attach = lt9611c_bridge_attach,
> +	.detect = lt9611c_bridge_detect,
> +	.edid_read = lt9611c_bridge_edid_read,
> +	.atomic_enable = lt9611c_bridge_atomic_enable,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.hpd_enable = lt9611c_bridge_hpd_enable,
> +
> +	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
> +	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
> +	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
> +	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
> +	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
> +	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
> +	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
> +
> +	.hdmi_audio_startup = lt9611c_hdmi_audio_startup,
> +	.hdmi_audio_prepare = lt9611c_hdmi_audio_prepare,
> +	.hdmi_audio_shutdown = lt9611c_hdmi_audio_shutdown,
> +};
> +
> +static int lt9611c_parse_dt(struct device *dev,
> +			    struct lt9611c *lt9611c)
> +{
> +	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
> +	if (!lt9611c->dsi0_node)
> +		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
> +
> +	lt9611c->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
> +
> +	if (lt9611c->dsi1_node && lt9611c->chip_type == CHIP_LT9611C) {
> +		of_node_put(lt9611c->dsi1_node);
> +		of_node_put(lt9611c->dsi0_node);
> +		return dev_err_probe(dev, -EINVAL,
> +				     "LT9611C does not support dual DSI\n");
> +	}
> +
> +	lt9611c->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
> +	if (IS_ERR(lt9611c->bridge.next_bridge)) {
> +		of_node_put(lt9611c->dsi1_node);
> +		of_node_put(lt9611c->dsi0_node);
> +		return PTR_ERR(lt9611c->bridge.next_bridge);

I'd rather see a normal goto-based error path.

> +	}
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry
