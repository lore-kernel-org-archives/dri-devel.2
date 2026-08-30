Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E1FC61DE1
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 14:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F8410E1CA;
	Sun, 30 Aug 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OL3/X4BM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0C1d5H7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA48610E1CA
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 14:39:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67UDeTMt1774824
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 14:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WC5F4dXivYg2N0cCOBx9PDBe42XsfplP7Q7huvCggSU=; b=OL3/X4BMYoNRG0Hv
 TAUfmdZi7A1nAJjkeuo+XDjO6mGA6tSlyOjOyz4LKZINAdXoN5ysYmjF1s5sDmla
 Ywx+JWAdF1VJ4If2ihh0WBK6XLBgWfqFVGfPcsKELcYStJwAodBGc/6CB4BIi34T
 vXAO+SgHuMOJnJW/GYNxHpdY0NiM5dGyhhAukx+B67cG/zaHUmyYp6EjwDKth5U2
 r7UTd5cuakjezkVPL4MVoWL2uQxnbchvvWi4TZJS7wBAw3HTE2l7P/rURwcpLBVo
 htSNQxsXUo43Orxd5emJ/d44rVUgu2fchmc+Pmn/xEHGcCgCElHGpbIFnG7Cma5v
 VGfduw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhmu4ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 14:39:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso2171919a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788100786; x=1788705586;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WC5F4dXivYg2N0cCOBx9PDBe42XsfplP7Q7huvCggSU=;
 b=Y0C1d5H7WoUfzI8a7upCoO+kvKhWoK0lfSygOGv0Qf3uZPtIV+uU7uGD3RhUrW6KZN
 8IRY3EzM9VlFMcp7bovyLfDJHcPno+B/tVZxjNYMoE3tZ3JjAv7BeWTM/1gZsaTa5Pcy
 wI6KKIIHKb/NKaRjO57E6xCinmQwr/5Nzds7EUGI6+YoYCDRH/o1PwIqZOgY1vRigHWh
 ebyiOJVDKZASXpN9X5lkVHetI0Upp3Cfer3Kq46QJxdvZJwwxjVz64JvyCzqZBZP623f
 b9x33y8ZomZXJ1+BeLGokv6XEAR37Fpko4JBnr74oAhfr4RP3Jr7zIDEFFba9G9O8loT
 ikmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788100786; x=1788705586;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WC5F4dXivYg2N0cCOBx9PDBe42XsfplP7Q7huvCggSU=;
 b=VUnuqjaqCWxTD7A5+Gct65i8TTJmo5J04o0VHbMxjvRk9xk9s4muttltNq2V99YD9n
 hCB9UjZqcoRdzVBRbpLwkL/1U92bru7C/r9GLMSXUkMvl1BOaJ+CGJrAtujh0ralEkYz
 snKseJNSlymRP3So7YvhyAge8qfbX8bSF8gg9M6Us/pi54tz07iSFETiI6b8Qs1nGBfb
 aOBlXWGH2uSTLEOlLBzg46Sq9xsPG0XiCTwuBmvCU1PAiqbX237kteh4NzxB9sJ8NI/R
 C9tXH6sLKTsOy7f8zTesYbNulMIit6nzp3wmejzoVah534NSmc1r9pGaM9O3hCxSD3Q8
 KezQ==
X-Gm-Message-State: AFuF++ll61qN4weWMPPlQD+sn6vxJfvuHdHixqP8pZdYvSX0IIhIuetE
 Zx4UaZQbrSTlnG4NPby1cM/s7oUKl3Ogqt/OTNMPlU6ojJBxMWKsaRiMZOHCwAIaIE11DD/TpRu
 5lw7wbxcvTXiX4xBDIINvi6MuRkuwbEmGHOMMPmiJnFrmxn07L3i0jyCe1wQim64xlPNzzTA=
X-Gm-Gg: AR+sD10BXwPHnTj1zvWUdHqIoOFzWLpJQos7qOkDiQMtc9bMQfKmN4dbAJyNBHVNKQ4
 MF+cBufFHVjz0kXixizc2SonkIAQmfCtVDgO8OQLjrIlJxTyO1ZXokxcrZm103UE1sO62Sak1uJ
 GHzg/NBC8LY8UxxcQk4PnemwIxvSGzexV8y7iWrSLf43vW5LQLDNQhMAT+MWUlqUlIBlSceu0L4
 JOqN2z5uPulrViWChebpQVbh4nw9dqyo0WVNggnsXzOpeoCp0ZTUQjPXUi303In+9uqulDLlLOV
 lNRCcjujuIeqHb1nLGZKCMDZRi9TBJLIcJ0a5SWZcEwi/szTtCOKjUbVvpkY1tLejnVH86HILLy
 283b4F9cXJbEw6YjkJP5lfs3FEw==
X-Received: by 2002:a05:6a20:a11f:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3d269a4d3ecmr31267374637.17.1788100786299; 
 Sun, 30 Aug 2026 07:39:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11f:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3d269a4d3ecmr31267343637.17.1788100785854; 
 Sun, 30 Aug 2026 07:39:45 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f80a0a5sm25389218eec.11.2026.08.30.07.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 07:39:45 -0700 (PDT)
Date: Sun, 30 Aug 2026 20:09:39 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <apRAq9iW+Q8RJdq8@hu-mdsor-hyd.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
 <20260824142125.B655A1F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824142125.B655A1F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDEyNiBTYWx0ZWRfX04oIAiDWRksY
 MJ7GGOiLgwSRqm+uTcAm0pIL1EFmUH+rmUTUQnuh5VpPVfwugMPxmuxDV4uU55OojIjzA/lJbyW
 +9H49euqBy37N5vBQ8+RuoVwKIlloNW5AoZwNEWIgJAqBZJlMl+dSu8l6V+9WTl5xGYwUjGjQeZ
 m0RhZ8TfDjcHI7NLitXlDD/qqvGqzz81m6CU+zKt0NOMfBdRWCZLxk/KKM2Iw17unWbdTw5617W
 ID9OizfKTBaUGSNGKpg7UW05+qHKgvtgbwud1ILIk4R7EQWCLZRq1PetNpPguDgs0ydyQNv8KCN
 Ncq6W1KW41+SyjC1WTwI9YSywyGJ56V8n6yieTgwyTZPSrQpOK6fM3OmpngTNnwJ/C2lRYOZTJ1
 DbrKRI7c/ELagm/YZquVwAPtRKM8GBPbsUNjSAw7aWIEd8wsARz7ZGe1xl+mmLeSaej/30gX1kR
 y+fz4K4g+Vwi8/Mnurw==
X-Proofpoint-ORIG-GUID: sjjI6dZQ0U-lu0dkvH8k57sDfRGLLo3I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDEyNiBTYWx0ZWRfX0eo+i5scpYh+
 OAi7xccnC9OZkliS/5oOO5gqyRvp6uLMJWIovBaa66o0EuEvUjHJEojPHKCdFloK7v9HwQ17oTq
 QK+/Yt5Vl3AoZ1nzQ9Bou1x5rnLdJYQ=
X-Proofpoint-GUID: sjjI6dZQ0U-lu0dkvH8k57sDfRGLLo3I
X-Authority-Analysis: v=2.4 cv=bpl8wkai c=1 sm=1 tr=0 ts=6a9440b2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=zF36ZKa9zYMQSWNkURUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608300126
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

On Mon, Aug 24, 2026 at 02:21:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Incorrect HPD read response length causes HDMI to never be detected.
> - [High] Sysfs attributes are accessible before drvdata is initialized, causing a NULL pointer dereference.
> - [Medium] Incorrect interrupt clear sequence leaves other active interrupts stuck high.
> - [Medium] Global CRC table is initialized concurrently in probe(), creating a data race.
> --
> 
> --- Patch [2]: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver ---
> commit 1a2f947d19c88c8a2effc903f8f83ec6e9fd330b
> Author: Sunyun Yang <syyang@lontium.com>
> Subject: drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit introduces a new DRM bridge driver for the Lontium LT9611C 
> series chips. It provides conversion from MIPI DSI and I2S signals to 
> HDMI output, and includes firmware upgrade capability and sysfs integration.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > index 0000000000000..148da2bf5648e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1283 @@
> 
> [ ... ]
> 
> > +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> > +{
> > +	struct lt9611c *lt9611c = dev_id;
> > +	struct device *dev = lt9611c->dev;
> > +	int ret;
> > +	unsigned int irq_status;
> > +
> > +	guard(mutex)(&lt9611c->mcu_lock);
> > +
> > +	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read irq status: %d\n", ret);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (!(irq_status & BIT(0)))
> > +		return IRQ_NONE;
> > +
> > +	/*Clear interrupt: hardware requires two writes with delay*/
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> > +	usleep_range(10000, 12000);
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> 
> [Severity: Medium]
> Could this sequence leave other active interrupts stuck in the clear state?
> 
> If irq_status contains other active interrupts (for example, bit 1 is set),
> the second write will write a 1 to those bits. Since there is no subsequent
> write of 0 to clear them, this appears to leave them permanently asserted.
Right now our driver only supports hpd interrupt.
> 
> > +
> > +	schedule_work(&lt9611c->work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void lt9611c_hpd_work(struct work_struct *work)
> > +{
> > +	struct lt9611c *lt9611c = container_of(work, struct lt9611c, work);
> > +	struct device *dev = lt9611c->dev;
> > +	static const u8 hpd_data[] = { 0x00 };
> > +	struct lt9611c_cmd cmd = {
> > +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> > +		.data = hpd_data,
> > +		.data_len = 1,
> > +	};
> > +	u8 hpd_status;
> > +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> 
> [Severity: High]
> Will this ever read the actual HPD status payload?
> 
> As demonstrated by lt9611c_get_edid_block(), the LT9611C chip's read protocol
> echoes the subcommand index byte (Y0) as the first byte of the response.
> Because data_len is set to 1, the driver will only read this echo byte (0x00)
> instead of the actual HPD status in the second byte, causing hpd_status to
> always evaluate to false.
> 
> This same pattern also appears in lt9611c_bridge_detect().
Will be fixed in v12.
> 
> [ ... ]
> 
> > +static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
> 
> [Severity: High]
> Can this result in a NULL pointer dereference?
> 
> Since the sysfs files are registered via lt9611c_driver.driver.dev_groups,
> the driver core creates these groups before calling the probe() function.
> However, i2c_set_clientdata() is only called at the very end of probe().
> 
> If a user accesses this sysfs file during the initialization window,
> dev_get_drvdata() will return NULL, which is immediately dereferenced here.
Will be fixed in v12.
> 
> > +}
> > +
> > +static DEVICE_ATTR_RW(firmware);
> 
> [ ... ]
> 
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c;
> > +	struct device *dev = &client->dev;
> > +	bool fw_updated = false;
> > +	int ret;
> > +
> > +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> 
> [Severity: Medium]
> Is it safe to unconditionally initialize the global lt9611c_crc8_table here?
> 
> If multiple LT9611C devices probe concurrently on different CPUs, this
> will result in multiple threads writing to the same global array
> simultaneously without synchronization.
Will be fixed in v12.
> 
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com?part=2
