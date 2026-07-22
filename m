Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9143AC44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC3F10ECC9;
	Wed, 22 Jul 2026 08:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmYkzLwh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7asbcTV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F5B10ECC9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:11:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M6fudv200496
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qAr2kUDa+GpQfnYcDYmn09sn
 Xn1dpK4pQGPi/x9NwsQ=; b=RmYkzLwhTob2X+kalvG1ilBVaeR5ZY3xKI7bnI8A
 nbu3g+ELacZAbRu8aazY6bgYLxXlFMy2m7sfRwlBIQgJhgmY8ColQ3sJy95kvEB7
 Spds13/1jU8MIECv8LaCaJtsr+2EiYOZpK0sO5W/0PEPmmlCDhlW0NMHzOm4DsGi
 d+tM+CTHflecCe8tmVm+A+YILn8/g7uHCy9/WjfS+ZKJ5ZIRDlZBfpapEJQsI5DL
 82lwAu39FLPa+XqX/lyiXSBjaEiwRW6upWmXDe2d6pWRJRg51iQrLctKqxPxwXTI
 NiJN4cdc5ocTJkif6dV3xNWiSBJFabzNPv8yRK3S6eCUcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt0c62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:11:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso25288191cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784707891; x=1785312691;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qAr2kUDa+GpQfnYcDYmn09snXn1dpK4pQGPi/x9NwsQ=;
 b=f7asbcTV7uKSjcuhkcv3w+s4TyWnnl8Iu6rM5CR09QzE5wMTWIHiN+6qoGKqQmCQ6h
 AKavJ6k5YemZ1qRr0JPlYDyyWdOns4wCQlDX37591qL2JLS7saU5SpOxUiG7iZgw5YXn
 D3Mp+Q7zr4BLGdWpr67VDESA1e792GSu9QQWrX7gVrMNXg0g2wXfarMcGyDMcsA4vZz8
 ME5y2U2yjp4E4QKkgLYwvxwldUy8Yb3EaDpY3Qwlw2rCTJFqhMxc1JpqjEinQkkcSt6I
 kipSojLjMXPhFovf5WIYtDyBlLPIq7AVKa+s5xYKVVNoFFzPw6s1McMBjtUziA2P+C6X
 gqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784707891; x=1785312691;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qAr2kUDa+GpQfnYcDYmn09snXn1dpK4pQGPi/x9NwsQ=;
 b=SaHZZQhbVhemqS/XGSceCVguRpT2nlUJaj1rexbxhDnNBuTB8do+qru2EsPlniakSL
 z2BwKHEpFYTK5UtORszzHIXYqpSD2VJIBUAjSRW/LEIWjwlsarvljR1D88X91y8rv89X
 TGM3Lwo2WwJN3q7CZQ8MZk7VQOtHtPyHZ0Ivy4F8nSHyWmAJtnO167mzDdmVMJ28i8JP
 y6Hn7A8avfSFADyHpzlZOpnAutUdlC/HiU50jsaDlFWjH2t4ZCX9V5hs5g2jbIrbJVdf
 nRL9FkI5VD+nfDiZkh76UDO5GcHEBGgNl0F6tJClkGIndw8PncBazNAPi/mi9pr3U7Ch
 t+SA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxPSZpwEGoFQP8cTyMfL6BbxzTX2eqhwyDKksy2i2VvmkO+vPJQsfd88z76o0OhA/rq3lr274WhFA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNnBRvO+5mhpkZcBH80X823aPLLnhgguNkBoh4fgiXxxoMxHz9
 xIb1Qlq9ABVHt2iWHvOnIIiUfUWSkqXFidX1WGQVS/sOvMpR5W5j0RCqK8QJIlu2JQFJGQGO+Fy
 lX+NFWarxzH4mVldjYO/nFiQcE+i3l/GDFZP3mMHfLCA6XF2jcQc3JRmP+5voWpZK7m5q2Qc=
X-Gm-Gg: AR+sD10B8Oc8TJGLOKOOW9603svDrDtX6wawHbbeUYJjZ5BVZgoR9nxmC5wuUPcsN3c
 EdJZJ72CuSY6ZWnyK4T6tcVmp7/ZbAOkIAlCE+1u0DVovqe/jH7vHqbJwallb2V3PZD6PbimBqN
 Uzv/AlT68j+UmgK5+LoINCCO5cm/5TDOHsDmHwEL98tajMdpiv98mCl6ELCSwrVMUb40tn4LGGl
 KHu6utAp8XA4ZBGtcIWsTH8N3PuFs5BPMvJ6hjtrmPPfALgzADW6VjRhODxjUsAWJM7raxf/Oo9
 zaFcgsc62jJ7FZMPQUBgA3AYP7UMX5xJPR+y5ksU5BsYMrTUCjSqPUp2bCz8nsLk4Uh28DLHHQn
 v9cc5YgUKFuzZsQcL9oHmriyTwI8Dqffocpu7Z5BjyKqNbFOjSrUOv7Rp2faCZvX6BVoXUH9IeP
 VSw3G3fN1j95sHGw==
X-Received: by 2002:a05:622a:2995:b0:51b:f25c:2896 with SMTP id
 d75a77b69052e-5213bb211eemr188470611cf.11.1784707891244; 
 Wed, 22 Jul 2026 01:11:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2995:b0:51b:f25c:2896 with SMTP id
 d75a77b69052e-5213bb211eemr188470131cf.11.1784707890521; 
 Wed, 22 Jul 2026 01:11:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c00bsm333905e87.3.2026.07.22.01.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 01:11:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:11:27 +0300
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
Subject: Re: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <4t3bar2svwex4wojumql2t66ivtj6bsxnt7pgmygnc7og4zquh@fs7wdd4k4cjp>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: b1H4bFeeURxUfFvJHUhUBwUQzvgUBwPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3NSBTYWx0ZWRfX5a9LyOSwyqu9
 VZmJCKwsgw4+qjskeuELKwGNxOqUzggEQsqbthlC+FvXTM4I8xwma3ZI9m4pgGmZj9jis0bLfL6
 RZyzgMinr4Aw05VImZXTPh/hxZkoRnEZKQ7Kzmk2gb0DNuPqPnS6Jv8H1M1V7R0AXpfFik5zAGG
 P24tu/ef/b5LGx39IRQMhlV7sgbtGCOVdHyfVtbW3mlo7V1F6oya97slsTYyU9cZRG7Lw8K3SBP
 nom0DCAKxPrZcBDw5R8YH1npxExcXqKhU7zvCw5HmMPo0ejVOCWSPzUxV1ykrSbWBy6KsAy3YIG
 L3bkqR6Pns+au8qtVLbjlygoLcd+zo0zwDVpMOmRsLTqfw3SAcBzC9L4F6D09/UqER1Rr+6pkbH
 LMLfyzegW6+SN8U8leH8AstbcyImB8gHPsv6NJtKJSrDIhzxUhEc9qM/qECFg2sFQ8hKni6SvDc
 Ww569fCyd1aPUvz9Tpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3NSBTYWx0ZWRfX1Rcqw8NiV46u
 bAS9q/4PjyU96Ti902L+6SRZAKZUByCqcOwN8LkslOenFcHjFUYt0RsSBIcbs36V/BsLyN0OjsR
 B10MZdLLtaz4aeO9P/fbb59zHL8x7sY=
X-Proofpoint-GUID: b1H4bFeeURxUfFvJHUhUBwUQzvgUBwPZ
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a607b34 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=Ln6MAHz3YeKBKpVQRlsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220075
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

On Thu, Jul 16, 2026 at 05:01:10PM +0530, mohit.dsor@oss.qualcomm.com wrote:
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
>  MAINTAINERS                              |    7 +
>  drivers/gpu/drm/bridge/Kconfig           |   18 +
>  drivers/gpu/drm/bridge/Makefile          |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1293 ++++++++++++++++++++++++++++++
>  4 files changed, 1319 insertions(+)
> 

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
> +	memset(buffer, 0xff, total_size);
> +	memcpy(buffer, fw->data, fw->size);

memcpy(buffer, fw->data, fw->size);
memset(buffer + fw->size, 0xff, total_size - fw->size);

> +
> +	fw_crc = crc8(lt9611c_crc8_table, buffer, total_size, 0);
> +	kfree(buffer);
> +
> +	dev_dbg(dev, "firmware crc: 0x%02x\n", fw_crc);
> +	dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", fw->size);

Merge them into two messages and maybe upgrade to dev_info().

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
> +/*read only*/

obvious

> +static const struct lt9611c *bridge_to_lt9611c_const(const struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, const struct lt9611c, bridge);

container_of_const() ?

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
> +	u8 cmd[5] = {0x52, 0x48, 0x31, 0x3a, 0x00};
> +	u8 data[5];
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
> +	msleep(100);

Why?

> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd), data, ARRAY_SIZE(data));
> +	if (ret) {
> +		dev_err(dev, "failed to read HPD status\n");
> +	} else {
> +		lt9611c->hdmi_connected = (data[4] == 0x02);
> +		dev_dbg(dev, "HDMI %s\n", lt9611c->hdmi_connected ? "connected" : "disconnected");
> +	}
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
> +
> +static enum drm_connector_status
> +lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	bool connected = false;
> +	u8 cmd[5] = {0x52, 0x48, 0x31, 0x3a, 0x00};
> +	u8 data[5];
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd), data, ARRAY_SIZE(data));
> +	if (ret) {
> +		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
> +		connected = lt9611c->hdmi_connected;

connected = connector_status_unknown;

> +	} else {
> +		connected = (data[4] == 0x02);
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
> +	u8 cmd[5] = {0x52, 0x48, 0x33, 0x3a, 0x00};
> +	u8 packet[37];

I assume it's 5 + 32. (and the 32 is repeated several times below).
#define 32. Also, it seems 5 is another magic size here, #define it too.

> +	int ret, i, offset = 0;
> +
> +	if (len != 128)
> +		return -EINVAL;
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	for (i = 0; i < 4; i++) {
> +		cmd[4] = block * 4 + i;
> +		ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
> +					      packet, ARRAY_SIZE(packet));
> +		if (ret) {
> +			dev_err(dev, "Failed to read EDID block %u packet %d\n",
> +				block, i);
> +			return ret;
> +		}
> +		memcpy(buf + offset, &packet[5], 32);
> +		offset += 32;
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
> +	u8 *cmd;
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	cmd = kmalloc(5 + len, GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cmd[0] = 0x57;
> +	cmd[1] = 0x48;
> +	cmd[2] = 0x35;
> +	cmd[3] = 0x3a;
> +	cmd[4] = 0x01;/*write avi*/
> +	memcpy(cmd + 5, buffer, len);

So, 5-byte cmd, optional argument, 5-byte answer, optional addtional
data. Can we make that a part of the lt9611c_read_write_flow()? Mandate
the 5-byte in/out buffers, add optional in/out args.

> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, 5 + len,
> +				      data, ARRAY_SIZE(data));
> +	kfree(cmd);
> +
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "write avi infoframe failed!\n");
> +		return ret;
> +	}

Drop extra messages, write_infoframe() already has drm_dbg_kms() here.

> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 cmd[5] = {0x57, 0x48, 0x42, 0x3a, 0x01};
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
> +				      data, ARRAY_SIZE(data));
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
> +	u8 cmd[5 + LT9611C_INFOFRAME_MAX_SIZE];
> +	u8 data[5];
> +	int ret;
> +
> +	cmd[0] = 0x57;
> +	cmd[1] = 0x48;
> +	cmd[2] = 0x35;
> +	cmd[3] = 0x3a;
> +	cmd[4] = 0x04;/*write vsif*/
> +	memcpy(cmd + 5, buffer, len);
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, 5 + len,
> +				      data, ARRAY_SIZE(data));
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "write hdmi infoframe failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 cmd[5] = {0x57, 0x48, 0x42, 0x3a, 0x04}; /*clear vsif*/
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
> +				      data, ARRAY_SIZE(data));
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
> +	u8 *cmd;
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	cmd = kmalloc(5 + len, GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cmd[0] = 0x57;
> +	cmd[1] = 0x48;
> +	cmd[2] = 0x35;
> +	cmd[3] = 0x3a;
> +	cmd[4] = 0x02;/*write audio*/
> +	memcpy(cmd + 5, buffer, len);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, 5 + len,
> +				      data, ARRAY_SIZE(data));
> +
> +	kfree(cmd);
> +
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "write audio infoframe failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	u8 cmd[5] = {0x57, 0x48, 0x42, 0x3a, 0x02};
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
> +				      data, ARRAY_SIZE(data));
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
> +	u8 audio_cmd[6] = {0x57, 0x48, 0x36, 0x3a};
> +	u8 data[5];
> +	int ret;
> +
> +	if (hparms->sample_width == 32)
> +		return -EINVAL;
> +
> +	switch (fmt->fmt) {
> +	case HDMI_I2S:
> +		audio_cmd[4] = 0x01;
> +		break;
> +	case HDMI_SPDIF:
> +		audio_cmd[4] = 0x02;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	audio_cmd[5] = hparms->channels;
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, audio_cmd, sizeof(audio_cmd),
> +				      data, sizeof(data));
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
> +	u8 cmd[5] = {0x52, 0x48, 0x31, 0x3a, 0x00};
> +	u8 data[5];
> +	int ret;
> +
> +	mutex_lock(&lt9611c->ocm_lock);
> +	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
> +				      data, ARRAY_SIZE(data));
> +	if (!ret)
> +		lt9611c->hdmi_connected = (data[4] == 0x02);
> +	mutex_unlock(&lt9611c->ocm_lock);
> +
> +	schedule_work(&lt9611c->work);
> +}
> +
> +static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
> +				      struct drm_connector *connector)
> +{
> +	return 0;
> +}
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
> +	int ret;
> +
> +	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
> +	if (!lt9611c->dsi0_node)
> +		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
> +
> +	lt9611c->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
> +
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);

of_drm_get_bridge_by_endpoint()  ?

> +	if (ret) {
> +		of_node_put(lt9611c->dsi1_node);
> +		of_node_put(lt9611c->dsi0_node);
> +		return ret;
> +	}
> +	drm_bridge_get(lt9611c->bridge.next_bridge);

Extra leaking reference, drop it.

> +	return 0;
> +}
> +
> +static int lt9611c_gpio_init(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +
> +	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(lt9611c->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c->reset_gpio),
> +				"failed to acquire reset gpio\n");
> +
> +	return 0;

Inline

> +}
> +
> +static int lt9611c_read_version(struct lt9611c *lt9611c)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(lt9611c->regmap, 0xe080, buf, ARRAY_SIZE(buf));
> +	if (ret)
> +		return ret;
> +
> +	return (buf[0] << 8) | buf[1];
> +}
> +
> +static int lt9611c_read_chipid(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	u8 chipid[2];
> +	int ret;
> +
> +	ret = regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(lt9611c->regmap, 0xe100, chipid, 2);
> +	if (ret)
> +		return ret;
> +
> +	if (chipid[0] != 0x23 || chipid[1] != 0x06) {
> +		dev_err(dev, "ChipID: 0x%02x 0x%02x\n", chipid[0], chipid[1]);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t lt9611c_firmware_store(struct device *dev, struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> +	int ret;
> +
> +	lt9611c_lock(lt9611c);
> +
> +	ret = lt9611c_firmware_upgrade(lt9611c);
> +	if (ret < 0)
> +		dev_err(dev, "upgrade failure\n");
> +
> +	lt9611c_unlock(lt9611c);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static ssize_t lt9611c_firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
> +}
> +
> +static DEVICE_ATTR_RW(lt9611c_firmware);
> +
> +static struct attribute *lt9611c_attrs[] = {
> +	&dev_attr_lt9611c_firmware.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group lt9611c_attr_group = {
> +	.attrs = lt9611c_attrs,
> +};
> +
> +static const struct attribute_group *lt9611c_attr_groups[] = {
> +	&lt9611c_attr_group,
> +	NULL,
> +};
> +
> +static int lt9611c_probe(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c;
> +	struct device *dev = &client->dev;
> +	bool fw_updated = false;
> +	int ret;
> +
> +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
> +
> +	lt9611c = devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &lt9611c_bridge_funcs);
> +	if (IS_ERR(lt9611c))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c), "drm bridge alloc failed.\n");
> +
> +	lt9611c->dev = dev;
> +	lt9611c->client = client;
> +	lt9611c->chip_type = (uintptr_t)i2c_get_match_data(client);
> +
> +	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init mutex\n");
> +
> +	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
> +	if (IS_ERR(lt9611c->regmap))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
> +
> +	ret = lt9611c_parse_dt(dev, lt9611c);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> +
> +	ret = lt9611c_gpio_init(lt9611c);
> +	if (ret < 0)
> +		goto err_of_put;
> +
> +	ret = lt9611c_regulator_init(lt9611c);
> +	if (ret < 0)
> +		goto err_of_put;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	if (ret)
> +		goto err_of_put;
> +
> +	lt9611c_reset(lt9611c);
> +
> +	lt9611c_lock(lt9611c);
> +
> +	ret = lt9611c_read_chipid(lt9611c);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read chip id.\n");
> +		lt9611c_unlock(lt9611c);
> +		goto err_disable_regulators;
> +	}
> +
> +retry:
> +	lt9611c->fw_version = lt9611c_read_version(lt9611c);
> +	if (lt9611c->fw_version < 0) {
> +		dev_err(dev, "failed to read fw version\n");
> +		ret = -EOPNOTSUPP;
> +		lt9611c_unlock(lt9611c);
> +		goto err_disable_regulators;
> +
> +	} else if (lt9611c->fw_version == 0) {
> +		if (!fw_updated) {
> +			fw_updated = true;
> +			ret = lt9611c_firmware_upgrade(lt9611c);
> +			if (ret < 0) {
> +				lt9611c_unlock(lt9611c);
> +				goto err_disable_regulators;
> +			}
> +
> +			goto retry;
> +
> +		} else {
> +			dev_err(dev, "fw version 0x%04x, update failed\n", lt9611c->fw_version);
> +			ret = -EOPNOTSUPP;
> +			lt9611c_unlock(lt9611c);
> +			goto err_disable_regulators;
> +		}
> +	}
> +
> +	lt9611c_unlock(lt9611c);
> +	dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
> +
> +	INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					lt9611c_irq_thread_handler,
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT |
> +					IRQF_NO_AUTOEN,
> +					"lt9611c", lt9611c);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto err_disable_regulators;
> +	}
> +
> +	lt9611c->bridge.of_node = client->dev.of_node;
> +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> +			DRM_BRIDGE_OP_EDID |
> +			DRM_BRIDGE_OP_HPD |
> +			DRM_BRIDGE_OP_HDMI |
> +			DRM_BRIDGE_OP_HDMI_AUDIO;
> +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> +
> +	lt9611c->bridge.vendor = "Lontium";
> +	lt9611c->bridge.product = "LT9611C";
> +
> +	lt9611c->bridge.hdmi_audio_dev = dev;
> +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> +	lt9611c->bridge.hdmi_audio_dai_port = 2;
> +
> +	devm_drm_bridge_add(dev, &lt9611c->bridge);
> +
> +	/* Attach primary DSI */
> +	lt9611c->dsi0 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> +	if (IS_ERR(lt9611c->dsi0)) {
> +		ret = PTR_ERR(lt9611c->dsi0);
> +		goto err_remove_bridge;
> +	}
> +
> +	/* Attach secondary DSI, if specified */
> +	if (lt9611c->dsi1_node) {
> +		lt9611c->dsi1 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi1_node);
> +		if (IS_ERR(lt9611c->dsi1)) {
> +			ret = PTR_ERR(lt9611c->dsi1);
> +			goto err_remove_bridge;
> +		}
> +	}
> +
> +	lt9611c->hdmi_connected = false;
> +	i2c_set_clientdata(client, lt9611c);
> +	enable_irq(client->irq);
> +
> +	lt9611c_reset(lt9611c);
> +	return 0;
> +
> +err_remove_bridge:
> +	cancel_work_sync(&lt9611c->work);
> +
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +
> +err_of_put:
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +
> +	return ret;
> +}
> +
> +static void lt9611c_remove(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c = i2c_get_clientdata(client);
> +

Missing disable_irq(). Otherwise the IRQ might schedule a job even after
a call to cancel_work_sync().

> +	cancel_work_sync(&lt9611c->work);
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +}
> +
> +static int lt9611c_bridge_suspend(struct device *dev)
> +{
> +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(lt9611c->dev, "suspend\n");
> +	disable_irq(lt9611c->client->irq);

cancel_work_sync(&lt9611c->work);

> +
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	if (ret)
> +		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
> +
> +	return ret;
> +}
> +
> +static int lt9611c_bridge_resume(struct device *dev)
> +{
> +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	if (ret) {
> +		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> +		return ret;
> +	}
> +	enable_irq(lt9611c->client->irq);
> +	lt9611c_reset(lt9611c);

Will the chip report HPD events here if the display was plugged while it
is powered off? If not, schedule the work here to reread the HPD status.

> +	dev_dbg(lt9611c->dev, "resume\n");
> +
> +	return ret;
> +}
> +
> 

-- 
With best wishes
Dmitry
