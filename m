Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0217C5AC80
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C135110F5AF;
	Fri,  7 Aug 2026 19:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IkVSDife";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hh39978A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC6910E315
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 19:48:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677ImOK92118696
 for <dri-devel@lists.freedesktop.org>; Fri, 7 Aug 2026 19:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gp5yEkcIuvYje/Gtl+2S+AYczcvYVVni2PBd63AOC6k=; b=IkVSDifeHlAJCpap
 LIbqzXp6D4s4WFgmBROn2Bckq+zyAH7SrBmb8N+R4a8e4XWrlnWNNyrjHo/2r1cZ
 nW7WvQfRpYhlt2oC7UQRd+/IZWFjxy+gqOFXu5xNf0JmUYnIxAbKZ71DYNoi7Wbp
 GY9HWm0YWQrmSdQJw6+u7SGP7XOTzA+XZPao5v0QFyO4xRtFcMQ/2NSANko4Iy3t
 pksCnXNJTBr/yvLmnjfrjo0vKDszGyc3dtticXG2OQ1HJ4GddqbSCH7U4bEWdlHC
 P+o0iMBeLq3Rn49ReKwKsWQn3qodYreU/2XnvCqSrB7arxLk2TF8hQkbpnFnxEjQ
 VSFmbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk21gsnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 19:48:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso4566013a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786132083; x=1786736883;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gp5yEkcIuvYje/Gtl+2S+AYczcvYVVni2PBd63AOC6k=;
 b=hh39978ADP4BW0hmpnxq+QBsfAGoOdHGXep4Hax3WymRokTk/w4Qo4d1up54XgvDGd
 v4QQEqCPOLXI6YUnHcU9g60uDruMOQhfXOp7BlIWER6V5AZ67YCsTj3JVqLGNIAuFxAs
 LDTtmoYawtKsu464QmXHKMutlJBDrPVMnVPZECxZsW7Rcsa0ZQ87cPkudZcFcXCBYBaS
 vvn+aegLXpN3StnRgzDCtRhybiyPQEB/9tERjuFwjj9gEJUnHN0hDMcxHi9Nzc3RFeLC
 wLIvoK3Tzm/HRypAJrV0iGYg2MnWlYh73HvNzLeH663LqnuNrnubgPPOOc6O9hOvTb8V
 XkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786132083; x=1786736883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gp5yEkcIuvYje/Gtl+2S+AYczcvYVVni2PBd63AOC6k=;
 b=OyMr4VIis7sMUKPvigWbpESUZ8TWvrm8WPEX80G27vJZjRyANLd4sH6RisdqGJF5Ks
 pDgZVd3gv3o+R/XTHCZlmpJdwFNg9X7SSKG7ZFv9lLYrfwodtGM89Pzp1VgZxv/NuMLY
 /T0PrBWzWRBg7Nqn7XqSdsTFtHveNWW6/Nm9D2C3/MJazO/3ok6kPppyvmsTmBsIjwbQ
 MABjho+FVy8VTET0VF4XJ4Gx9di+NS+NLYJmxZz1VSuqZbwq3ebDmgvyFrYJ5f20+EMw
 dm8R8tz8J2rHEWIa16z7emT+lfkobXF7x5/iwQPxJmAEA4Yxm6JM8akmVFH9dqBg9LMk
 c8uQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzjnWDNsv4E4piBWBtOcPmD5RwZcSYiLRBfv+bV6r8AeI/agCo/LT55XZ93qo3AHLJKJv60jS8Y6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDr8U2+54c8CRx2nSt7pmn897fKRSrfgh2MZHNV+/eYRGwbsc3
 EbzOFCb6dAlFs3FIl43Yx/BZ54iMetBXsaFhLNTqYMdmQU3k8sqEV8dQqXWIixsU+GsAgGepgAH
 eTBO9Lvcpj1XWwK9boNdD2SXj79yUXYltTDU4+BejTKEax8T1kFUv1WkP6xTnhj+PxhT/gN4=
X-Gm-Gg: AR+sD10V14tuYCMa016vkr+e5T8R/bVSRwEBop05yctd0MHLVqmd6UFCAN+GhNjx/UG
 WAHoLiydJA/ntih1cOzEvZSFEhXfIcoyjU5YU0+pNbG6dLcc2Rtkn6//gvjqjmFpxDuFKw8p6/o
 KmTH6j3s1yBJreE1AdNAw+VEH6EqWBCEYQbaepbpw3cIieGabTydIFx3Y7Uej0b70twrsSyp/MO
 j7dXuGaz5SWqQ+ExLMsXBiY1MnT9xVErtWq47yoCyek4SZuyaai9UmtNtO/iUoExTRAeOOffDLa
 UHNG2pPpegK+7h7IMufjhIExADo8Gv9+KiAg6cY18fJ9QGjaGuX7rDzM6s/wp+ImTNhNK2J3z9I
 o+oq4FmZAKi75AErnQ3dAlLnOTg==
X-Received: by 2002:a17:90b:4ace:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-3928246545amr2090937a91.20.1786132082611; 
 Fri, 07 Aug 2026 12:48:02 -0700 (PDT)
X-Received: by 2002:a17:90b:4ace:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-3928246545amr2090882a91.20.1786132081982; 
 Fri, 07 Aug 2026 12:48:01 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a706fsm10454089eec.8.2026.08.07.12.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:48:01 -0700 (PDT)
Date: Sat, 8 Aug 2026 01:17:56 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v9 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <anY2bFDCvN+J9Wgq@hu-mdsor-hyd.qualcomm.com>
References: <20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com>
 <20260804-lt9611c-v7-v9-2-3423a76856d3@oss.qualcomm.com>
 <20260804125938.DCD6A1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804125938.DCD6A1F000E9@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: I7n17bmtsplf13UnPb8T1AABNvhyUv8X
X-Proofpoint-GUID: I7n17bmtsplf13UnPb8T1AABNvhyUv8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE1NCBTYWx0ZWRfX9a/ekkowSPIY
 qv1Cb1dcoDMBw3/L+UaMe6/oll/NHJdMAkPOet0+FP3dkJW2+RckJtw8nah4BZK1cpix+0MNDrW
 de2EJxpkQaAiVGTrTJQgOal7jAXuDB7cP7ss8/SisbKq5GeGnU6k8Z36DbbqZmBYqyU6uX+c/aU
 e/zcLfqLCQc9TVjMAdv90Md1YzOUoYigPcnIsYwHaSO0N34DVDRzCkSjbgA9mJys/H7v2lGtM+O
 41y5FzLIaM/aAzmyNDWu76FSTinRBsMh4bDUXH7Z64b/mJt3K5devZRGVwGU6BY2xmf4wvUuhye
 aS8qQSF2nTLGdaBmh9WjPLj6bcSQOe5d09Z9n0ROYHKJ793tQEBczJhrXbYmW8MZc7Ar0S1qx0H
 CB2gnZZY4XmXsjiZCFCHnxJn8koDsalvnEYQZQ/xk2XYnsrkFz2k8u8uDpIUmbcAJOfIBPI82b3
 IVVFnO+DPv4wXhb5w0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE1NCBTYWx0ZWRfXyKWpZvjw+nIM
 pG0bwWj+g9vqefxwJhIJGtaChkYt15JBWBPTjT3JIzAjcGW6195Z1AM2F/Q9eG9rJBaumugebNf
 zE6/juA4SI34JnOLt8AIFpKL0AXaZYs=
X-Authority-Analysis: v=2.4 cv=YJevDxGx c=1 sm=1 tr=0 ts=6a763673 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=Gew5hmu5R9XjSDW7IewA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070154
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

On Tue, Aug 04, 2026 at 12:59:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> - [High] Missing `disable_irq()` before `cancel_work_sync()` in `lt9611c_remove()` causes a use-after-free when `devm` frees the device context.
> - [High] Bridge is left registered and accessible to DRM core while its power regulators are disabled during module unload.
> - [High] Unconditional dereference of `cdata` returned by `i2c_get_match_data()` without checking for NULL.
> - [Medium] Incorrect interrupt clearing sequence in `lt9611c_irq_thread_handler()` can permanently suppress other pending interrupts.
> - [Medium] The return value of `devm_drm_bridge_add()` is ignored, which can lead to silent probe failures.
> - [Medium] Firmware upgrade via sysfs silently resets the bridge hardware, breaking active DRM display state.
> - [Medium] The IRQ handler incorrectly returns `IRQ_HANDLED` when the interrupt was not generated by this device.
> - [Medium] The return value of `read_poll_timeout` is ignored during flash block erase, which can lead to firmware corruption.
> --
> 
> --- Patch [2]: [PATCH v9 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver ---
> commit 6e88557e672677022a4675c645ef3cbef1ee7ce0
> Author: Sunyun Yang <syyang@lontium.com>
> Subject: drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit introduces a DRM bridge driver for the Lontium LT9611C,
> LT9611EX, and LT9611UXD DSI-to-HDMI chips. It handles configuration over I2C,
> video timing setup, audio infoframe handling, and firmware upgrades.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..f5af2856ce00b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > +static void lt9611c_block_erase(struct lt9611c *lt9611c)
> > +{
> > +	unsigned int block_num;
> > +	unsigned int flash_status = 0;
> > +	u32 flash_addr = 0;
> > +
> > +	for (block_num = 0; block_num < 2; block_num++) {
> > +		flash_addr = block_num * 0x008000;
> > +		lt9611c_erase_op(lt9611c, flash_addr);
> > +		msleep(100);
> > +		read_poll_timeout(read_flash_reg_status, flash_status,
> > +				  !(flash_status & 0x01),
> > +				  50 * USEC_PER_MSEC, 2500 * USEC_PER_MSEC,
> > +				  false, lt9611c);
> 
> [Severity: Medium]
> Is it safe to ignore the return value of read_poll_timeout() here?
Added the check here.
> 
> If the hardware fails to erase the flash within the timeout, the driver
> will proceed to lt9611c_write_data() anyway. This would cause it to write
> new firmware data over un-erased or partially erased flash pages,
> potentially corrupting the device firmware permanently.
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
> [Severity: Medium]
> Could this reset break the active DRM display state?
> 
> When userspace writes to the firmware sysfs attribute, this function
> resets the bridge chip without notifying the DRM subsystem. This wipes all
> video timings and configurations, meaning an active display pipeline will
> go blank and become desynchronized from the DRM state.
No, it is needed. Added warn lof for this.
> 
> [ ... ]
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
> > +		return IRQ_HANDLED;
> 
> [Severity: Medium]
> Should this early return use IRQ_NONE instead?
Yes, fixed this in v10.
> 
> Returning IRQ_HANDLED when the interrupt does not belong to this device
> defeats the kernel's spurious interrupt detection mechanism. If the IRQ
> line becomes noisy or stuck, the kernel will falsely assume this driver
> handled it and will not disable the line, potentially causing an interrupt
> storm that freezes the system.
> 
> > +
> > +	/*Clear interrupt: hardware requires two writes with delay*/
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> > +	usleep_range(10000, 12000);
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> 
> [Severity: Medium]
> Could this interrupt clearing sequence accidentally suppress other pending
> interrupts?
As shared earlier only 1 interrupt is there.
> 
> If multiple interrupts were pending (for example, bit 1 is also set in
> irq_status), the second write outputs a 1 for those other bits because of
> the bitwise inversion logic. If the hardware clears interrupts via a
> pulse mechanism, those other bits are left stuck at 1 and are never written
> back to 0. This would break the clearing mechanism for any interrupt
> other than the primary bit.
> 
> [ ... ]
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
> > +	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
> > +
> > +	lt9611c->chip_type = cdata->chip_type;
> 
> [Severity: High]
> Can cdata be NULL here?
Yes check is added in v10.
> 
> When the device is instantiated via the sysfs bind attribute or new_device
> without a valid match table entry (e.g., matching by driver name fallback),
> i2c_get_match_data() will return NULL. Dereferencing cdata immediately
> would result in a NULL pointer dereference and a kernel panic.
> 
> [ ... ]
> > +	devm_drm_bridge_add(dev, &lt9611c->bridge);
> > +
> > +	enable_irq(client->irq);
> > +
> > +	return 0;
> 
> [Severity: Medium]
> Is there a missing error check for devm_drm_bridge_add()?
Added the check.
> 
> Since devm_drm_bridge_add() can return an error code like -ENOMEM,
> ignoring it allows the driver to probe successfully without registering the
> bridge. This leaves a dysfunctional driver bound to the device, silently
> consuming resources.
> 
> [ ... ]
> > +static void lt9611c_remove(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c = i2c_get_clientdata(client);
> > +
> > +	cancel_work_sync(&lt9611c->work);
> 
> [Severity: High]
> Could this lead to a use-after-free since the IRQ is not disabled before
> cancelling the work?
Fixed this in v10.
> 
> The IRQ was requested with devm_request_threaded_irq, meaning it remains
> active until devres cleanup, which happens after lt9611c_remove() returns.
> An interrupt firing right after cancel_work_sync() completes will invoke
> the threaded handler, which calls schedule_work(&lt9611c->work). When
> devres frees the lt9611c structure, the newly queued work isn't cancelled,
> causing the workqueue to eventually execute lt9611c_hpd_work on freed memory.
> 
> > +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> 
> [Severity: High]
> Does this prematurely power down the chip while the bridge is still active?
Fixed this in v10.
> 
> Because the bridge was registered with devm_drm_bridge_add(), the DRM core
> will only unregister it during devres teardown, which runs after this
> remove function completes. By manually disabling the regulators here, there
> is a window where the bridge is globally visible and can receive DRM calls
> (such as a detect call from userspace polling), but the hardware is powered
> off. This can cause I2C timeouts or bus lockups during module unload.
> 
> > +	of_node_put(lt9611c->dsi1_node);
> > +	of_node_put(lt9611c->dsi0_node);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com?part=2
