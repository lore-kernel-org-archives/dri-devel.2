Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D17C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659E210E5D4;
	Tue, 15 Sep 2026 11:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnSJ95et";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cJRH8GXd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FEC10E5D4
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:22:01 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9gvXO2584528
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xulq/000/ULLchJIOg/N1wH/ItWptfBKc1m2CXViGcY=; b=CnSJ95etg13x7wJZ
 X57qFMZAtjLfNbLRotEQKqUUXnXWDLevJUW4el1TB/2Ia/dW0DFg5MR+V5uO7BUD
 3nN2CrP52hnvHWSz6alG8LV3gLO64CwCyuP3oGIcbMHBKGrVsKm7QrBBVJ6k3p4W
 eK5mAoWss3S3hKlHKDwHiQ59Y79hqfinK3IsQxdb5IMcIYDcaWR++lDgFhkNYOaH
 zYSQzL4uDsXXMu0fvpNMAJeReFxQq7J2t6f30ZL7ZK57YjQt8Kt/Nh5cPVwcqz0E
 ATh5AqeXwKKX6mN0MJi+bEJdRCbhxYyPvVzUDd3aS5C6XTvUSSzUl9nea/1tm3vk
 R3YzOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpx4s9rd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:22:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso8837648a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789471320; x=1790076120;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xulq/000/ULLchJIOg/N1wH/ItWptfBKc1m2CXViGcY=;
 b=cJRH8GXdnU6JBEMVnIfarS9igR5MP/mmPjf/ZiGhSRVelo2KTK+x7IRVIxkohzzvbF
 7UiB6uMcxv4Y/h652GlRiFFavOeEMdmuChUAjTh7LEG3FSLL52pxSnVhi7BPAkD9CG8L
 1L6q50yq+fE1whsDhPN/VjaISb1rmmQLRadwyyPEv2KkfwA0834JxRTPilKNAE9Vnd7R
 7wVT2L6UR5YbYgDxBg7ZpP5TX9FiB9fSat0F0JQ4nLNJljpWDzDo6gjDEre1Lmhc/JT0
 +5Y+nx7jjU1gGRes4yR2h0JwSFzLaaoM6f5RR86j13i+B6O4nj+8M1BOP2z+UD7X2aVE
 Yuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789471320; x=1790076120;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xulq/000/ULLchJIOg/N1wH/ItWptfBKc1m2CXViGcY=;
 b=cJ+QQ5FlHrb32UDYQEtRIg1BJTNXiQqrT7sP7PiagXNvFwBzSB9rPQJxVF20FF2cEA
 ccsdm80wXKSXLRXQVcmfCempTSlFsHbJebLQXH8U9ud7xUt0U5kWlw2nLcDRmHyUjg2i
 PxCOASwOtPMVLDmFuRzsPWH3ZP7Ld+0XFVmV3AYhCrA7Y0i1ommiYnTcmH5EYWKlvibn
 1XneNq/C9mWrGkGSJAVOm1z6Vb+qiXihd0vGDJ4pUm2ksFzYq6DoiXugy4Usiypy+yur
 bJvj7AygniPg9wzFqR5exNMQsA/CNUUm1ONaH96/FBOEQh7x72vVYSdSapbam/DgRja5
 WRgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbD+H4EagNCmeS5o3xpb8zto/Zu2F3knBKxS9dzpAlJhiexgz+CgA+C+mD0e0L2+vQI3kb2M5QNhQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQQN5BHWZN3owZg3klD8WOApNjades8Ksy5w6GrJnsL24980QX
 vHMbv3c8QFjL64VtZ2/lfiOzbggracbrkXHYEjkYhAWcuFUo0kKzu6nh0/OsqCWlJwl4pO0UuXl
 DbbfZY2HpbUH0hAd+zvKx0RKwvOPMWXrRs66hNxAAaGH77t+HnGOxtEIUNY52TQVOxa2bkBg=
X-Gm-Gg: AYBFou3p+n2D7RuLIP7botpN2tOKO4IqOdCF+xV9labi9NPug8kX52jzhGs4f9cCz6y
 vC+HpY/8se5vtqkaJus9k9mFup+xwQhm6o7o5j4KfOvYk60Z25glPS6kyycP4RqvNafdoXYqJBN
 9pTl088rOIKSSZVuCI/lxmsf0sN5IeOfJh3CnVbvnB/iTQHXni5o/YeZ55ISJ2YvSZapP0sjyvY
 7IbzV8I+sgvZRupEUUHiZqkj3MC9XTK/5O861T0c31UPijtznOzvh7sQWYQUN1rU7dVBDIzPT+x
 sxyykJMoJ3aORVfvCwfIbklQrpwNEy4wdOppsZuZgDeN4K/qh3zhgr/16YeY5i3/SbUWJtUIIIz
 VuVV7mI+4/PzLC3sR2w1KVwn3eQ==
X-Received: by 2002:a17:90b:1c83:b0:39e:27e:21b3 with SMTP id
 98e67ed59e1d1-39e027e229fmr5444522a91.9.1789471320114; 
 Tue, 15 Sep 2026 04:22:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1c83:b0:39e:27e:21b3 with SMTP id
 98e67ed59e1d1-39e027e229fmr5444461a91.9.1789471319539; 
 Tue, 15 Sep 2026 04:21:59 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf31c1sm34002659eec.1.2026.09.15.04.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:21:59 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:51:53 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v14 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aqkqUY4BfXo2HuGT@hu-mdsor-hyd.qualcomm.com>
References: <20260913-lt9611c-v7-v14-0-534b43a07662@oss.qualcomm.com>
 <20260913-lt9611c-v7-v14-2-534b43a07662@oss.qualcomm.com>
 <20260912215110.11BDF1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912215110.11BDF1F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE2NCBTYWx0ZWRfXy0g/kPavavWb
 YuvXufnTH6Y/x9FAzZcjA6ReM0lpS8oxbLAD/Haueb20R9QtojmjHhtMb9KGKlhGILUsEO+BGsI
 c+DNOBY2t7G4InbgLbyfC4K3lPYHS94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE2NCBTYWx0ZWRfXwvzdGa7fKmWa
 +mBDlcFiK6P+3Y6AaAFM7OhR3WlbtI1U1BM6qIlw/mvYjfxtgdAN3FlycoZVb2i1HtS7BrYxt0q
 SqshVONJxZgr7s96t85TfUlkXQBuEhy7nk42hncHLSweNVwYaEjxS/wtcEmm0/WTYzzNrO352DR
 wBWILTsU8N424BJlKKzzgfSKoMoZk//REpd/AI0Xsrr2AeByvyF/getgZsQEvSkAuD04j+33LGq
 9KPM5xMRb5MV4xHLZppM6rZ76VC9nurhauTpZ1roEZ7rrm/5rGWmU84UWuRMQA6ReGKydS3G6pY
 /MizYvpo0o+p9ceC+4CX25FNgTMKm2uhatUsr+P5j1/lTGgwajaMxiCbFvXu7QSKAxoqsXbE0uK
 E4uegZfXIEoi2psZR+U+XKoHk8WetfFPDgjaS6b+A9mAxm6oT9r0ixNMaVrI2hDkf1FPtBndPge
 NYwvJv63gKW4SkZXpRA==
X-Authority-Analysis: v=2.4 cv=HsDjiETS c=1 sm=1 tr=0 ts=6aa92a58 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=36FZGce6BDuSa-RBUaEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: f_Hk-_nbWDGb6YXaOgk7--VQSn8j-VP0
X-Proofpoint-ORIG-GUID: f_Hk-_nbWDGb6YXaOgk7--VQSn8j-VP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150164
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

On Sat, Sep 12, 2026 at 09:51:09PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] The driver fails to invoke the DRM HDMI state helper to flush infoframes to the hardware during a modeset.
> - [High] Missing polling for flash page program completion before writing the next page.
> - [High] Hardware reset causes silent desynchronization of the regmap page selector cache, leading to corrupt I2C accesses.
> - [High] Incorrect interrupt clear sequence inadvertently asserts clear signals for other pending interrupts.
> - [Medium] The bridge driver completely omits an `atomic_disable` (or `disable`) callback, preventing the hardware from being powered down during DPMS off.
> - [Low] Data race when accessing `lt9611c->fw_version` concurrently.
> --
> 
> commit 00cae86a0097b37f64f26f28bf0a922224a6461d
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit introduces a DRM bridge driver for the Lontium LT9611C(EX/UXD)
> MIPI DSI to HDMI converter chips. The driver supports single or dual MIPI DSI
> inputs, I2S/SPDIF audio, and handles HDMI infoframes alongside I2C-based
> firmware flashing and power management.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..fbd6209287998
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > +static int lt9611c_write_data(struct lt9611c *lt9611c, const struct firmware *fw, size_t addr)
> > +{
> [ ... ]
> > +		for (unsigned int i = 0; i < LT_PAGE_SIZE; i++) {
> > +			size_t index = num * LT_PAGE_SIZE + i;
> > +			u8 value = (index < size) ? data[index] : 0xff;
> > +			int ret;
> > +
> > +			ret = regmap_write(lt9611c->regmap, 0xe059, value);
> > +			if (ret < 0) {
> > +				dev_err(dev, "write error at page %u, index %u\n", num, i);
> > +				return ret;
> > +			}
> > +		}
> > +
> > +		lt9611c_wren(lt9611c);
> > +		lt9611c_sram_to_flash(lt9611c, addr);
> > +
> > +		addr += LT_PAGE_SIZE;
> > +	}
> > +
> > +	lt9611c_wrdi(lt9611c);
> 
> [Severity: High]
> Does this sequence overwrite the SRAM buffer over I2C while the internal SPI
> flash controller is still programming the previous page? It appears there is no
> delay or polling for the flash program command to complete before looping back
> to write the next page's data to SRAM, which might silently corrupt the flashed
> firmware.
Will be fixed in next version.
> 
> [ ... ]
> > +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> > +{
> [ ... ]
> > +	ret = lt9611c_write_data(lt9611c, fw, 0);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to write firmware data\n");
> > +		goto out_unlock;
> > +	}
> > +
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
> Could the hard reset immediately following the CRC flash write command abort the
> final write while it is still in-flight? Polling for completion before resetting
> might be necessary here as well.
Will be fixed in next version.
> 
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
> Will the physical reset clear the chip's internal page register back to 0
> without updating the regmap cache? Regmap's internal cache of the page
> selector could become desynchronized, causing subsequent register accesses to
> skip setting the page if it matches the cached value, but occurring on the
> wrong hardware page. This would affect accesses in probe, firmware_upgrade,
> and bridge_resume.
The driver uses REGCACHE_NONE (no cache_type set in regmap_config). With this mode, _regmap_update_bits always performs a real I2C read of the selector register before writing it — there is no cached page state that can become stale. After GPIO reset the chip reverts the page register to 0x00, and regmap reads that back on the next access, correctly detecting the change and re-issuing the page selector write as needed.
> 
> [ ... ]
> > +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> > +{
> [ ... ]
> > +	if (!(irq_status & BIT(0)))
> > +		return IRQ_NONE;
> > +
> > +	/* Clear interrupt: hardware requires two writes with delay */
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> > +	usleep_range(10000, 12000);
> > +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> 
> [Severity: High]
> Is the second regmap_write unintentionally asserting clear signals for other
> pending interrupts? If other interrupts are pending (for example, BIT(1) is set
> in irq_status), irq_status & (~BIT(0)) will write a 1 to those bits in the
> clear register. This might permanently assert their clear signals without ever
> deasserting them.
Only one HPD interrupt is there.
> 
> [ ... ]
> > +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> > +					 struct drm_atomic_commit *state)
> > +{
> [ ... ]
> > +	mode = &crtc_state->adjusted_mode;
> > +
> > +	lt9611c_video_setup(lt9611c, mode);
> > +}
> 
> [Severity: High]
> Should this enable path invoke drm_atomic_helper_connector_hdmi_update_infoframes
> to flush the infoframes to the hardware? Without this call, it seems the
> registered infoframe callbacks are never triggered, preventing AVI and other
> infoframes from being transmitted during a modeset.
Will be fixed in next version.
> 
> [ ... ]
> > +static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
> > +	.attach = lt9611c_bridge_attach,
> > +	.detect = lt9611c_bridge_detect,
> > +	.edid_read = lt9611c_bridge_edid_read,
> > +	.atomic_enable = lt9611c_bridge_atomic_enable,
> > +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> > +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> > +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> 
> [Severity: Medium]
> Is the omission of an atomic_disable (or disable) callback intentional? It
> appears this leaves the bridge permanently active and internal PHYs powered
> even when the display pipeline is blanked or during DPMS off.
The chip does support power management via the existing suspend/resume
callbacks which disable the regulators and assert reset.
> 
> [ ... ]
> > +static ssize_t firmware_store(struct device *dev, struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> [ ... ]
> > +	lt9611c_lock(lt9611c);
> > +	lt9611c->fw_version = lt9611c_read_version(lt9611c);
> > +	lt9611c_unlock(lt9611c);
> [ ... ]
> > +	return len;
> > +}
> > +
> > +static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
> > +}
> 
> [Severity: Low]
> Could this result in a data race on lt9611c->fw_version? The variable is written
> under lt9611c_lock in firmware_store(), but it is read here in firmware_show()
> without any locking.
Will be fixed in next version.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913-lt9611c-v7-v14-0-534b43a07662@oss.qualcomm.com?part=2
