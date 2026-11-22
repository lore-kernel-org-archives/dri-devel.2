Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA042606AD83
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hNLd8UuV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J/MnDCzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B2110E62D;
	Sun, 22 Nov 2026 19:37:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BA210E62D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:37:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AMGV1Fb3476805
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AR3wxTpCn4fPZMsTPtQgVxEZ/XZfuPty0wu9tEDhxSE=; b=hNLd8UuVn1GZNd+C
 yju+czmzGQHj7zTJaJ8M483pjlEGDtb22xI+KPlArcIu4G4Lxjd1+onlsYHMfxyg
 SFTy08ZgMYIOcxKB4UJmONtlOyi8Z3iHY5xa0l66kSZsehuDBpY/iBiOpBFXyLLY
 tWOKdfZkaamoR/3e0iGg7Zm4EdoJ1QAWQgknGv7R3+O31sx0mnEg7VFOu8pxxs9f
 os8H5We8MKwMaTx7WJVMsdmgjz/gcbA+u19cU9iJz2f6qiArlCqraBrpwsicwL1y
 rt/1lKGOMgN17FroC6B4z5kcyde9VFNZd9Q9LBTNwWcT31u6ciKAIqaIOtTrka3O
 CQsL3A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j342gm0fa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:37:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b25d977b91so2838308c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795376226; x=1795981026;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AR3wxTpCn4fPZMsTPtQgVxEZ/XZfuPty0wu9tEDhxSE=;
 b=J/MnDCzJMz9QohewF1R6mWiJl7nBuSF6/zU5QXh/YDHXSeXA+dDI/Tv/707Y5eVjf9
 HmnrhidFXvN+E7NwRY00moi1CypIvoQpbE3LhAqMWF9G+LWF4kvxRhynmmyl0DGEhUEZ
 5NBTnnENPvuQIl+VKoU6bz8/xzVyJ2EEjNoYUw87veSy5FOarTE7pFyIxpP72aOeCleX
 AJbsDqcwaa4VnG9A9TtJoaCfdPcPwigJulFleut08UBqRL5mi5FjIpKnGqVAmeirBJPP
 e1nn040+1bRge1wc/mTTvaelFpllXd4tCouJkW5Us+Rhq4/zKcdvMnIwVjYDV6vELUgQ
 mn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795376226; x=1795981026;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AR3wxTpCn4fPZMsTPtQgVxEZ/XZfuPty0wu9tEDhxSE=;
 b=g75o+FqG0cDtXByPQkADRQ6lkr4YwbSZE6+UADkPexyqjp8GR0yNkMlXLyEqmpBAO1
 6ccP5gvvs7G/iQnOfvvLKKQi1c8DmqqotgeSzk0wK9c/PorhgMZKmcynH3gx+iFAUr5D
 7M8Wh+WeUo7l8PfLNoDak0E/u90lhTxKITwZQG5pI0lMcZp0I8LKpHhv+HAY1IwU3R9U
 BIPz1kQQOz+hL4tBom/1ONyZ8qsHEV3qk0tKNSgqFzUPj7Y+6RU/ogufbR0zJL45Q9pR
 V+CBgLe/3HIjQ7mFoQR7ZF5IJ8QJzfL0lQvqevxH7uqfP75s9bDHclI2OhkNIF/7c6oH
 DDZA==
X-Gm-Message-State: APuU4Z/6DAEmDCNsHHH3qx+5ncXfEgjxo542D/wnJg6lunYhKMp2k2/M
 6mVLWhHPToOvx9IlF0qn96dM1d+7BCK/mEinjAzttEUquNQZc/pBtaUI7AY3NUYrh1a91MFFVwM
 wSYVZDOW1HZE5b+ACgM7s6gLnvZ2lLwaRPjFXLwfIUAiviS9F28XErOPRoB/q/tYmrduUPHI=
X-Gm-Gg: AZFdTZcCxHmed2dLgyTe1mvW+xgJc5qXtvv2JqqHaed69oYjKLHWD0WEPwFWtoIn5YC
 CtLChw2VvID8m8XlnWpRBuh1Osxja3dl783ROTTFi2ulVmpxATM07/ss5WxqX4Phl1jL8L2TyZ/
 TWbrJAdn1Y9wg2IEY6g8Y6iSspvyHjGWjaewKEnXJ0EVgq6jKuu6qhVB5D9jqjEabw1p6wT7Kn2
 N9FFHDs1kP2C0iv1ye9N8ORMAFucefg8YxoFMLn9zY9a2q9MxfRWS1WBlZaZEzduVrZPhtlLRbG
 4ER0SQBtXBX8gYRywJNQ96Qi0LDNkjpAV9u2L4YE0rIaUBON6HDP92W0EMar0iN/6OsJFjcTZLs
 TwY+tbGsbaJdl2z5rESo4MYbNYwzabZjCovSl8fUvjt1b288HmzHKqLQFUDOUrEf6BeYIxRuF75
 0=
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id
 a92af1059eb24-1b5568b9e59mr12369991c88.24.1795376226111; 
 Sun, 22 Nov 2026 11:37:06 -0800 (PST)
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id
 a92af1059eb24-1b5568b9e59mr12369954c88.24.1795376225433; 
 Sun, 22 Nov 2026 11:37:05 -0800 (PST)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm36391893c88.9.2026.11.22.11.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 11:37:05 -0800 (PST)
Date: Mon, 23 Nov 2026 01:07:00 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v18 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <awNEXKZ4PcBlFZ6t@hu-mdsor-hyd.qualcomm.com>
References: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
 <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
 <sashiko-outbox-179959@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-179959@kernel.org>
X-Authority-Analysis: v=2.4 cv=H+5OUOYi c=1 sm=1 tr=0 ts=6b034463 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=IY4m9wzs8ccATqxbe_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: Z3B9-MuUtYQSLYLtbmykiMQtteBDBtNA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA3OCBTYWx0ZWRfXzTJ0zcRLSeXs
 T3LtA83v3IvWv760J/9La6r0n+1cD91tZuUTkDtcbe8bggnwzEXnZpY0JlRb3x2LDxTwV51JBGF
 DtdDi2ly6pBx8kTADVE1khaEiRtWet0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA3OCBTYWx0ZWRfXxab2gfeNQeg6
 lp6rlW730QYscRzxZTGDMamMt3E5RNOPpofjnxtRRgJOuFhnBbJF8prjBdG0FdUVQbPPV4eRmHv
 sRP0iKAB3BZ5JRDNh/IM/0egWG+ASu3Yux2I5hfCupwrckwI29ydT8D+TeTEtMpIx71nO1Uf2uY
 0LKU1IBIXydmJcrSfNW7GF/ArHojocj3GBrEwNvQtpsKJqnATDWYdu7UyN5wBR3PnCmMXd7E06b
 CVWfGlkTpLMj+zpmBYY+vgLWFxCZsLGfDYbclLmhBHkYZlxxLklbQnUaAX8Z0O9gucveIWoe4e8
 7+6hpLFpm2A/gg47lGU4BxGZR6SowFV3tsIZmKekglEFwEAWBNOq8RTlHrZxFyJ4gN1z5xhJk/2
 fkRI0HmNhhT6arh2s71aNjFOETLgfDBsFJcnkG2pPHOY37cYYW8rFySAdg2bBIpKNWn+KzJLHvs
 3odryL7nYZoiuxYJZ8A==
X-Proofpoint-GUID: Z3B9-MuUtYQSLYLtbmykiMQtteBDBtNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_04,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220078
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 08:23:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Medium] drm/bridge: lt9611c: negative errno stored in fw_version corrupts firmware_show()
> - [Medium] drm/bridge: lt9611c: unlocked reset and power control in PM callbacks
> - [Low] drm/bridge: lt9611c: unused function warnings when CONFIG_PM_SLEEP=n
> - [Low] drm/bridge: lt9611c: missing MODULE_DEVICE_TABLE() for lt9611c_id
> - [Low] drm/bridge: lt9611c: unlocked reset of hdmi_connected after bridge attach
> --
> 
> commit 990744b0d700fbd77a4343ac0bdea653a817a6ce
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit adds a DRM bridge driver for the Lontium LT9611C, LT9611EX, and
> LT9611UXD MIPI DSI to HDMI bridge chips. It supports EDID reading, HPD
> detection, HDMI audio over I2S, dual-DSI mode, and firmware upgrades via
> sysfs.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..8fc86c0732122
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1361 @@
> 
> [ ... ]
> 
> > +static ssize_t firmware_store(struct device *dev, struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (!lt9611c)
> > +		return -ENODEV;
> > +
> > +	dev_warn(dev, "starting firmware upgrade — display will be disrupted\n");
> > +
> > +	ret = lt9611c_firmware_upgrade(lt9611c);
> > +	if (ret < 0) {
> > +		dev_err(dev, "upgrade failure\n");
> > +		return ret;
> > +	}
> > +
> > +	lt9611c_lock(lt9611c);
> > +	WRITE_ONCE(lt9611c->fw_version, lt9611c_read_version(lt9611c));
> > +	lt9611c_unlock(lt9611c);
> > +
> > +	if (READ_ONCE(lt9611c->fw_version) < 0)
> > +		dev_warn(dev, "upgrade succeeded but failed to read new fw version\n");
> > +	else
> > +		dev_info(dev, "firmware upgrade succeeded, version: 0x%04x\n",
> > +			 READ_ONCE(lt9611c->fw_version));
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +
> > +	if (!lt9611c)
> > +		return -ENODEV;
> > +
> > +	return sysfs_emit(buf, "0x%04x\n", READ_ONCE(lt9611c->fw_version));
> > +}
> 
> [Severity: Medium]
> In drivers/gpu/drm/bridge/lontium-lt9611c.c, what happens in firmware_show()
> if reading the version fails after a firmware upgrade in firmware_store()?
> 
> When regmap_write() or regmap_bulk_read() fails inside lt9611c_read_version(),
> it returns a negative errno that firmware_store() writes directly into
> lt9611c->fw_version via WRITE_ONCE().
> 
> Subsequent reads of the sysfs firmware attribute will then format that
> negative errno with "0x%04x" in firmware_show(), emitting a sign-extended
> 32-bit hex error code (such as 0xfffffffb) to userspace instead of a 16-bit
> firmware version or an error return.
> 
> Should firmware_store() only update lt9611c->fw_version when
> lt9611c_read_version() succeeds, or should firmware_show() check for a
> negative lt9611c->fw_version before formatting it?
Will be fixed in next version
> 
> [ ... ]
> 
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> 
> [ ... ]
> 
> > +	drm_bridge_add(&lt9611c->bridge);
> > +
> > +	/* Attach primary DSI */
> > +	dsi = lt9611c_attach_dsi(lt9611c, dsi0_node);
> > +	if (IS_ERR(dsi)) {
> > +		ret = PTR_ERR(dsi);
> > +		goto err_remove_bridge;
> > +	}
> > +
> > +	/* Attach secondary DSI, if specified */
> > +	if (dsi1_node) {
> > +		dsi = lt9611c_attach_dsi(lt9611c, dsi1_node);
> > +		if (IS_ERR(dsi)) {
> > +			ret = PTR_ERR(dsi);
> > +			goto err_remove_bridge;
> > +		}
> > +	}
> > +
> > +	lt9611c->hdmi_connected = false;
> > +	enable_irq(client->irq);
> 
> [Severity: Low]
> In lt9611c_probe() in drivers/gpu/drm/bridge/lontium-lt9611c.c, can setting
> lt9611c->hdmi_connected = false here race with lt9611c_bridge_detect()?
> 
> Once drm_bridge_add() and lt9611c_attach_dsi() have been called, the DSI host
> can bind the DRM device and run initial connector detection, which invokes
> lt9611c_bridge_detect() and updates lt9611c->hdmi_connected under
> lt9611c->mcu_lock:
Will be fixed in next version
> 
> 	guard(mutex)(&lt9611c->mcu_lock);
> 
> 	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> 	if (ret)
> 		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
> 	else
> 		connected = (hpd_status == 0x02);
> 
> 	lt9611c->hdmi_connected = connected;
> 
> Writing lt9611c->hdmi_connected = false in lt9611c_probe() without holding
> lt9611c->mcu_lock after the bridge is attached can clobber the detected state
> (and lt9611c is already zero-initialized by devm_drm_bridge_alloc()). Could
> this assignment be dropped or moved before drm_bridge_add()?
> 
> [ ... ]
Will be fixed in next version
> 
> > +static int lt9611c_bridge_suspend(struct device *dev)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	disable_irq(lt9611c->client->irq);
> > +	cancel_work_sync(&lt9611c->work);
> > +
> > +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +
> > +	ret = regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	if (ret) {
> > +		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
> > +		gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +		msleep(400);
> > +		enable_irq(lt9611c->client->irq);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
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
> [Severity: Medium]
> In drivers/gpu/drm/bridge/lontium-lt9611c.c, should lt9611c_bridge_suspend()
> and lt9611c_bridge_resume() hold lt9611c->mcu_lock while asserting reset_gpio,
> toggling the regulators, and running lt9611c_reset()?
> 
> During system suspend and resume, disable_irq() and cancel_work_sync() only
> stop the HPD interrupt and lt9611c->work. Because fw_devlink relaxes
> bidirectional OF-graph links and there is no PM device link ordering this I2C
> client against the DRM master device or audio codec, bridge callbacks such as
> lt9611c_bridge_detect(), lt9611c_bridge_edid_read(),
> lt9611c_bridge_atomic_enable(), or lt9611c_hdmi_audio_prepare() can run
> concurrently.
> 
> Those callbacks serialize hardware access with lt9611c->mcu_lock, whereas
> lt9611c_bridge_suspend() and lt9611c_bridge_resume() assert reset_gpio,
> disable/enable the vcc and vdd supplies, and run the 400ms reset sequence
> without acquiring lt9611c->mcu_lock, which could reset or power down the chip
> mid-transaction in lt9611c_read_write_flow().
Will be fixed in next version
> 
> > +
> > +static const struct dev_pm_ops lt9611c_bridge_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(lt9611c_bridge_suspend,
> > +				lt9611c_bridge_resume)
> > +};
> > +
> > +static const struct i2c_device_id lt9611c_id[] = {
> > +	{ .name = "lt9611c",   .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> > +	{ .name = "lt9611ex",  .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> > +	{ .name = "lt9611uxd", .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
> > +	{ /* sentinel */ }
> > +};
> 
> [Severity: Low]
> In drivers/gpu/drm/bridge/lontium-lt9611c.c, is MODULE_DEVICE_TABLE(i2c,
> lt9611c_id) missing after lt9611c_id?
> 
> Without MODULE_DEVICE_TABLE(i2c, lt9611c_id), building the driver as a module
> (CONFIG_DRM_LONTIUM_LT9611C=m) omits the i2c:lt9611c, i2c:lt9611ex, and
> i2c:lt9611uxd modalias entries from modules.alias, preventing automatic module
> loading when devices are instantiated via I2C device IDs.
Will be fixed in next version
> 
> > +
> > +static const struct of_device_id lt9611c_match_table[] = {
> > +	{ .compatible = "lontium,lt9611c",   .data = &lt9611c_chip_data[CHIP_LT9611C]   },
> > +	{ .compatible = "lontium,lt9611ex",  .data = &lt9611c_chip_data[CHIP_LT9611EX]  },
> > +	{ .compatible = "lontium,lt9611uxd", .data = &lt9611c_chip_data[CHIP_LT9611UXD] },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, lt9611c_match_table);
> > +
> > +static struct i2c_driver lt9611c_driver = {
> > +	.driver = {
> > +		.name = "lt9611c",
> > +		.of_match_table = lt9611c_match_table,
> > +		.pm = &lt9611c_bridge_pm_ops,
> > +		.dev_groups = lt9611c_attr_groups,
> > +	},
> 
> [Severity: Low]
> In drivers/gpu/drm/bridge/lontium-lt9611c.c, will building with
> CONFIG_PM_SLEEP=n trigger unused-function warnings for
> lt9611c_bridge_suspend() and lt9611c_bridge_resume()?
> 
> SET_SYSTEM_SLEEP_PM_OPS() expands to nothing when CONFIG_PM_SLEEP is disabled,
> leaving both static functions unreferenced without __maybe_unused annotations.
> 
> Could this use DEFINE_SIMPLE_DEV_PM_OPS(lt9611c_bridge_pm_ops,
> lt9611c_bridge_suspend, lt9611c_bridge_resume) (or SYSTEM_SLEEP_PM_OPS())
> along with pm_sleep_ptr(&lt9611c_bridge_pm_ops) on .pm so the compiler can
> dead-code eliminate the callbacks and dev_pm_ops structure when
> CONFIG_PM_SLEEP=n?
Will be fixed in next version
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com?part=2
