Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D6606A88B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2ZhIgH0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC04F10F6E5;
	Tue, 17 Nov 2026 13:01:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCD010F6E5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E6044089C;
 Tue, 17 Nov 2026 13:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B801B1F000C5;
 Tue, 17 Nov 2026 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794920488;
 bh=K4+bxeKbm2S5mQ8+ZMcHTmJBc6M9HajCXVC658PLSV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G2ZhIgH0o7rjre2pkg2OVrAai147FuGhQNi4/Yiisy5DAnPoOZ8LffCDsHPjO9DmS
 7NkZw5YxR7NOX095ov50Majcu9jMTeJs0L1ECxLQ/wHjaL+m+NplAUdJh7+VvHEjGx
 IcrStSGqVP15xPugZhKmq50NQX6C5ZIrpRdzTQo5Y85CgsuMplQfHVbZnKgb2RNBIj
 44t3VsvcV5Gvoq/1TNKNdEwo5bcl8hzeFIUaPEsNvnyDBAyV6vqx1QS7Xh4cTtozEq
 ycOINiFVzBGS2RUusvdV6NndPOJoBY+X2tAQwM8o8gAN8WnQLgUeh6HPK3GMsd/zAi
 ikFRRi4dl+7uw==
Message-ID: <sashiko-outbox-218826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/11] Input: touchscreen: add Silicon Works SW42902
 support
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-8-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-8-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:01:27 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] Input: sw42902: username handle in Signed-off-by trailer and
  MAINTAINERS
- [Medium] Input: sw42902: IRQ disable imbalance on sw42902_resume()
  error path
- [Low] Input: sw42902: use named initializer in struct i2c_device_id
  table
- [Low] Input: sw42902: follow Input error variable naming and return
  style
- [Low] Input: sw42902: partial MT events queued before palm cancel in
  sw42902_irq()
- [Low] Input: sw42902: redundant dev_err_probe() after
  devm_request_threaded_irq()
--

commit 7d934418330ef369d907f6e1ac22a2b5372028a3
Author: rofikkerneldev <rofikcoga@gmail.com>

> Input: touchscreen: add Silicon Works SW42902 support
>
> Add basic multitouch support for the SW42902 controller. Implement the
> GPIO power and reset sequence and use the firmware already present in
> controller flash; no firmware update is performed.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Signed-off-by trailer, Author header, and MAINTAINERS entry for this
driver use an account handle (rofikkerneldev) instead of a real human
name, which does not meet the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.

> diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscr=
een/sw42902.c
> new file mode 100644
> index 0000000000000..7b39a97053c63
> --- /dev/null
> +++ b/drivers/input/touchscreen/sw42902.c

[ ... ]

> +	for (i =3D 0; i < count; i++) {
> +		const u8 *contact =3D ts->report + 36 + 12 * i;
> +		u32 a =3D get_unaligned_le32(contact);
> +		u32 b =3D get_unaligned_le32(contact + 4);
> +		u32 c =3D get_unaligned_le32(contact + 8);
> +		unsigned int id =3D a & 0x1f;
> +		unsigned int event =3D (a >> 16) & 3;
> +
> +		if (id =3D=3D 15) {
> +			sw42902_release_contacts(ts);
> +			return IRQ_HANDLED;
> +		}
> +		if (id >=3D SW42902_MAX_CONTACTS || (event !=3D 1 && event !=3D 2))
> +			continue;
> +
> +		input_mt_slot(input, id);
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
> +		touchscreen_report_pos(input, &ts->prop, a >> 18, b & 0x3fff, true);
> +		input_report_abs(input, ABS_MT_PRESSURE, (b >> 14) & 0xff);
> +		input_report_abs(input, ABS_MT_TOUCH_MAJOR, (c >> 4) & 0x3fff);
> +		input_report_abs(input, ABS_MT_TOUCH_MINOR, c >> 18);
> +	}

[Severity: Low]
Can sw42902_irq() queue partial multitouch events before cancelling the
frame on a palm report?

If a report has active finger contacts at earlier indices followed by a
palm entry (id =3D=3D 15), the loop already queues slot activation and
position events into input->vals[] for those earlier contacts before
calling sw42902_release_contacts(), flushing transient touch updates and
slot releases in the same SYN_REPORT frame.

[ ... ]

> +static int sw42902_start(struct sw42902 *ts)
> +{
> +	u8 version[4];
> +	int ret;
> +
> +	ret =3D sw42902_read(ts, SW42902_VERSION, version, sizeof(version));
> +	if (ret)
> +		return ret;
> +	if (version[2] !=3D 10 || (version[3] & 0xf) !=3D 4) {
> +		dev_err(&ts->client->dev, "unexpected chip/protocol: %u/%u\n",
> +			version[2], version[3] & 0xf);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D sw42902_write(ts, SW42902_SERIAL_SPI_EN, 0);
> +	if (ret)
> +		return ret;
> +	ret =3D sw42902_write(ts, SW42902_DEVICE_CTL, 1);
> +	if (ret)
> +		return ret;
> +	ret =3D sw42902_write(ts, SW42902_INTERRUPT_CTL, 1);
> +	if (ret)
> +		return ret;
> +	ret =3D sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
> +	if (ret)
> +		return ret;
> +	msleep(30);
> +	return sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_U3);
> +}

[Severity: Low]
This isn't a bug, but in the Input subsystem variables that only hold 0 or
a negative error code should be named error or err rather than ret (here
and in sw42902_irq(), sw42902_probe(), and sw42902_resume()).  Also,
since sw42902_start() has multiple failure points, the final
sw42902_write() call should check error and explicitly return 0 on
success.

> +static int sw42902_probe(struct i2c_client *client)
> +{

[ ... ]

> +	ret =3D devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					dev_name(dev), ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "interrupt request failed\n");

[Severity: Low]
This isn't a bug, but devm_request_threaded_irq() already calls
dev_err_probe() via devm_request_result() on failure, so wrapping its
return value in dev_err_probe() logs a duplicate error message and
overwrites the deferred probe reason.

[ ... ]

> +static int sw42902_suspend(struct device *dev)
> +{
> +	struct sw42902 *ts =3D i2c_get_clientdata(to_i2c_client(dev));
> +
> +	disable_irq(ts->client->irq);
> +	sw42902_release_contacts(ts);
> +	sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
> +	sw42902_power_off(ts);
> +	return 0;
> +}
> +
> +static int sw42902_resume(struct device *dev)
> +{
> +	struct sw42902 *ts =3D i2c_get_clientdata(to_i2c_client(dev));
> +	int ret;
> +
> +	sw42902_power_on(ts);
> +	ret =3D sw42902_start(ts);
> +	if (ret) {
> +		sw42902_power_off(ts);
> +		return ret;
> +	}
> +	enable_irq(ts->client->irq);
> +	return 0;
> +}

[Severity: Medium]
What happens on the next suspend if sw42902_start() fails during
sw42902_resume()?

When sw42902_start() fails, sw42902_resume() powers off the controller and
returns without calling enable_irq(ts->client->irq).  Because the PM core
clears dev->power.is_suspended before invoking the resume callback, the
next system suspend still calls sw42902_suspend(), which writes to the
powered-off chip over I2C and calls disable_irq(ts->client->irq) a second
time, leaving the IRQ disabled even if a later resume succeeds.

[ ... ]

> +static const struct i2c_device_id sw42902_ids[] =3D {
> +	{ "sw42902" },
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but per I2C subsystem conventions new struct
i2c_device_id entries should use named initializers ({ .name =3D "sw42902" =
}).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D7
