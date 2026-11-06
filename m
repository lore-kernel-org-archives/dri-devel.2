Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353C606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6pEHWik
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC87210E033;
	Fri,  6 Nov 2026 02:57:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B1810E033
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 02:57:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E463F60202;
 Fri,  6 Nov 2026 02:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827C61F0089F;
 Fri,  6 Nov 2026 02:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793933832;
 bh=ULTDaHMl0jSjWBw9wMf7qiezo6fJ1mALcgcMGKs0l/Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F6pEHWikQ+HzOayAPkoiKVJ8ADC4u3VXMSJd+zagmzKENnzeFxmLYy79Oj/WJRXDV
 Og/3ySrKMhryEDBVEtOXt2UUg6l+mzGv1RKOJU7e6+Qyz5qlcEiNNNoXlvDju84Cd3
 78KApLIzctm2B+v+KjMjJ0JgWNMHl8vMqNTrFmETAdmrJwXyO9LJSfHS0VcYmmaos7
 /J/PeY5RdZFi6Hn7R0y8RABkeuR45pQDPY4CdAwhAjPmJihtIZiQXp4QpeXhDpwt+M
 VZd1F2yeGb4wYeNhXPpY8iJlYhvmAY166kBfnGOUE7gMff8B3oHgXqGNpMVt3FLNf+
 GQZ57ZnYZhg4A==
Message-ID: <sashiko-outbox-200618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/4] drm/fl2000: Add USB driver with register and
 I2C access
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-fl2000-upstream-v1-1-bb163ecb2309@gmail.com>
References: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
 <20261105-fl2000-upstream-v1-1-bb163ecb2309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:57:12 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/fl2000: UAF and leaks attaching devres to usb_dev in fl2000_ge=
t_devices()
- [High] drm/fl2000: unvalidated message length and flags in fl2000_i2c_xfe=
r()
- [Medium] drm/fl2000: destructive second read of status reg in fl2000_read=
_status()
- [Medium] drm/fl2000: unlocked FL2000_VGA_I2C_SC_REG update in fl2000_usb_=
magic()
--

commit 65acb73d91d8bb3b60de43aba3fc31aba51bb815
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add USB driver with register and I2C access

This patch adds the USB driver for the Fresco Logic FL2000DX display
controller, binding its three USB interfaces, setting up a regmap over
vendor control transfers, and registering an I2C adapter for the chip's
I2C engine.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drv.c b/drivers/gpu/drm/fl2000=
/fl2000_drv.c
> new file mode 100644
> index 0000000000000..ea089d3c1d09c
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_drv.c
> @@ -0,0 +1,150 @@

[ ... ]

> +/* Devices that are independent of interfaces, created for the lifetime =
of the USB device */
> +struct fl2000_devs {
> +	struct regmap *regmap;
> +	struct i2c_adapter *adapter;
> +	int active_if;
> +};
> +
> +static struct fl2000_devs *fl2000_get_devices(struct usb_device *usb_dev)
> +{
> +	struct fl2000_devs *devs;
> +
> +	devs =3D devm_kzalloc(&usb_dev->dev, sizeof(*devs), GFP_KERNEL);
> +	if (!devs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	devs->regmap =3D fl2000_regmap_init(usb_dev);
> +	if (IS_ERR(devs->regmap)) {
> +		dev_err(&usb_dev->dev, "Cannot initialize regmap (%pe)\n", devs->regma=
p);
> +		return ERR_CAST(devs->regmap);
> +	}
> +
> +	devs->adapter =3D fl2000_i2c_init(usb_dev);
> +	if (IS_ERR(devs->adapter)) {
> +		dev_err(&usb_dev->dev, "Cannot initialize I2C adapter (%pe)\n", devs->=
adapter);
> +		return ERR_CAST(devs->adapter);
> +	}
> +
> +	dev_set_drvdata(&usb_dev->dev, devs);
> +
> +	return devs;
> +}

[ ... ]

> +static void fl2000_disconnect(struct usb_interface *interface)
> +{
> +	u8 iface_num =3D interface->cur_altsetting->desc.bInterfaceNumber;
> +	struct usb_device *usb_dev =3D interface_to_usbdev(interface);
> +	struct fl2000_devs *devs =3D dev_get_drvdata(&usb_dev->dev);
> +
> +	if (!devs)
> +		return;
> +
> +	switch (iface_num) {
> +	case FL2000_USBIF_AVCONTROL:
> +	case FL2000_USBIF_STREAMING:
> +	case FL2000_USBIF_INTERRUPT:
> +		devs->active_if &=3D ~BIT(iface_num);
> +		break;

[Severity: High]
What cleans up devs, devs->regmap, devs->adapter, and usb_dev->dev
driver_data when the driver is unbound or unloaded while the USB device
remains plugged in?

fl2000_driver binds to struct usb_interface devices (&interface->dev), while
the parent struct usb_device (&usb_dev->dev) stays bound to
usb_generic_driver for the entire physical connection. However,
fl2000_get_devices(), fl2000_regmap_init(), and fl2000_i2c_init() attach all
devm allocations and registrations to &usb_dev->dev:

  fl2000_probe()
    fl2000_get_devices()
      devm_kzalloc(&usb_dev->dev, ...)
      fl2000_regmap_init()
        devm_regmap_init(&usb_dev->dev, ...)
      fl2000_i2c_init()
        devm_kzalloc(&usb_dev->dev, ...)
        devm_i2c_add_adapter(&usb_dev->dev, adapter)
      dev_set_drvdata(&usb_dev->dev, devs)

When fl2000_driver is unbound from the interfaces (for example via rmmod
fl2000 or sysfs unbind), device_unbind_cleanup() only releases devres on
&interface->dev, not on &usb_dev->dev, and fl2000_disconnect() only clears
BIT(iface_num) in devs->active_if.

After module unload, the I2C adapter and regmap remain registered with
callbacks and structures (such as fl2000_i2c_algorithm, fl2000_i2c_quirks,
fl2000_regmap_config, fl2000_reg_read, and fl2000_reg_write) pointing into
freed module memory, and dev_get_drvdata(&usb_dev->dev) retains the stale
pointer. Won't any subsequent I2C transfer, regmap debugfs access, module
reload, or USB unplug trigger a use-after-free?

Also, if fl2000_i2c_init() fails in fl2000_get_devices() (or if
fl2000_probe() fails on an unexpected interface), really_probe() only cleans
up &interface->dev, leaking the devm allocations attached to &usb_dev->dev
on each interface probe attempt. Should the shared state be refcounted acro=
ss
the bound interfaces and explicitly torn down when the last interface
disconnects (or on probe failure)?

> diff --git a/drivers/gpu/drm/fl2000/fl2000_i2c.c b/drivers/gpu/drm/fl2000=
/fl2000_i2c.c
> new file mode 100644
> index 0000000000000..eadbe0f679eb4
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_i2c.c
> @@ -0,0 +1,182 @@

[ ... ]

> +static int fl2000_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *=
msgs, int num)
> +{
> +	int ret;
> +	bool read;
> +	u16 addr;
> +	u8 idx;
> +	u8 offset;
> +	u32 data;
> +
> +	addr =3D msgs[0].addr;
> +	offset =3D msgs[0].buf[0] & I2C_XFER_ADDR_MASK;
> +	idx =3D msgs[0].buf[0] - offset;
> +
> +	/*
> +	 * We expect the following:
> +	 * - 2 messages, each 1 byte, first write then read
> +	 * - 1 message, 2 bytes, write
> +	 */
> +	if (num =3D=3D 2) {
> +		read =3D true;
> +	} else if (num =3D=3D 1) {
> +		if (msgs[0].len =3D=3D 2 && !(msgs[0].flags & I2C_M_RD))
> +			read =3D false;
> +		else
> +			return -EOPNOTSUPP;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * The FL2000 I2C engine only transfers aligned dwords, so the offset i=
s aligned down to a
> +	 * 4-byte boundary and the requested byte is picked out of (or merged i=
nto) the dword.
> +	 */
> +	if (read) {
> +		ret =3D fl2000_i2c_read_dword(adapter->algo_data, addr, offset, &data);
> +		if (ret)
> +			return ret;
> +
> +		msgs[1].buf[0] =3D data >> (idx * 8);

[ ... ]

> +static u32 fl2000_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_NOSTART;
> +}
> +
> +static const struct i2c_algorithm fl2000_i2c_algorithm =3D {
> +	.xfer =3D fl2000_i2c_xfer,
> +	.functionality =3D fl2000_i2c_func,
> +};
> +
> +static const struct i2c_adapter_quirks fl2000_i2c_quirks =3D {
> +	/* Combined transfers only: an address write, then data, on the same ad=
dress */
> +	.flags =3D I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADD=
R,
> +	.max_num_msgs =3D I2C_CMESSAGES_NUM,
> +	.max_write_len =3D 2 * I2C_REG_DATA_SIZE,
> +	.max_read_len =3D I2C_REG_DATA_SIZE,
> +	.max_comb_1st_msg_len =3D I2C_REG_ADDR_SIZE,
> +	.max_comb_2nd_msg_len =3D I2C_REG_DATA_SIZE,
> +};

[Severity: High]
Can fl2000_i2c_xfer() dereference a NULL or ZERO_SIZE_PTR buffer on
zero-length messages, or misclassify a 2-message write as a read?

At the start of fl2000_i2c_xfer(), msgs[0].buf[0] is read before checking
msgs[0].len. Because fl2000_i2c_quirks.flags does not set
I2C_AQ_NO_ZERO_LEN, i2c_check_for_quirks() allows messages with len =3D=3D 0
(for example, SMBus quick transfers from i2cdetect where msgs[0].buf is
NULL, or zero-length I2C_RDWR ioctls where msgs[i].buf is ZERO_SIZE_PTR),
which will fault on msgs[0].buf[0] or msgs[1].buf[0].

In addition, when num =3D=3D 2, fl2000_i2c_xfer() sets read =3D true without
checking that msgs[1].flags & I2C_M_RD is set or that both messages have
len =3D=3D 1. Meanwhile, fl2000_i2c_func() advertises I2C_FUNC_NOSTART and
fl2000_i2c_quirks.flags omits I2C_AQ_COMB_READ_SECOND (i.e.
I2C_AQ_COMB_WRITE_THEN_READ). If a caller issues a 2-message write (such as
regmap_i2c_gather_write() using I2C_M_NOSTART, or via i2c-dev), won't
fl2000_i2c_xfer() perform a hardware read instead of a write and overwrite
the caller's write buffer msgs[1].buf[0]?

> diff --git a/drivers/gpu/drm/fl2000/fl2000_registers.c b/drivers/gpu/drm/=
fl2000/fl2000_registers.c
> new file mode 100644
> index 0000000000000..231814471d20a
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_registers.c
> @@ -0,0 +1,320 @@

[ ... ]

> +int fl2000_usb_magic(struct usb_device *usb_dev)
> +{
> +	struct regmap *regmap =3D dev_get_regmap(&usb_dev->dev, NULL);
> +	u32 val;
> +
> +	val =3D FL2000_VGA_I2C_SC_MONITOR_DETECT | FL2000_VGA_I2C_SC_EDID_DETEC=
T;
> +	regmap_write_bits(regmap, FL2000_VGA_I2C_SC_REG, val, val);

[Severity: Medium]
Can updating FL2000_VGA_I2C_SC_REG in fl2000_usb_magic() race with an active
I2C transfer or trigger an unintended I2C transaction?

In fl2000_i2c_dword(), writing FL2000_VGA_I2C_SC_REG with bit 31
(FL2000_VGA_I2C_SC_DONE) cleared to 0 initiates an I2C transfer using the
address, command, and offset in bits 15:0, and callers serialize the
multi-step sequence (including polling across 200us sleeps in
regmap_read_poll_timeout()) with i2c_lock_bus().

Here in fl2000_usb_magic(), regmap_write_bits() performs a read-modify-write
on the volatile FL2000_VGA_I2C_SC_REG without holding i2c_lock_bus() and
without setting FL2000_VGA_I2C_SC_DONE in the value written back. If an I2C
transfer is in progress when fl2000_usb_magic() runs, or if
FL2000_VGA_I2C_SC_DONE reads back as 0 after reset, won't
regmap_write_bits() write FL2000_VGA_I2C_SC_DONE =3D 0 back to
FL2000_VGA_I2C_SC_REG and corrupt or re-trigger an I2C transaction?

[ ... ]

> +/*
> + * Read the status register. Its event bits clear on read, so whoever re=
ads it owns the events it
> + * returns: callers must not drop them.
> + */
> +int fl2000_read_status(struct usb_device *usb_dev, u32 *status)
> +{
> +	struct regmap *regmap =3D dev_get_regmap(&usb_dev->dev, NULL);
> +	unsigned int val;
> +	u32 mask;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, FL2000_VGA_STATUS_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* LBUF issues are recoverable */
> +	mask =3D val & (FL2000_VGA_STATUS_LBUF_OVERFLOW | FL2000_VGA_STATUS_LBU=
F_UNDERFLOW);
> +	if (mask)
> +		regmap_write_bits(regmap, FL2000_VGA_STATUS_REG, mask, val);

[Severity: Medium]
Does calling regmap_write_bits() on FL2000_VGA_STATUS_REG in
fl2000_read_status() perform a second hardware read that silently drops
pending event bits?

FL2000_VGA_STATUS_REG has seven read-self-clearing event bits (such as
FL2000_VGA_STATUS_HDMI_EVENT, FL2000_VGA_STATUS_MONITOR_EVENT, and
FL2000_VGA_STATUS_EDID_EVENT) and is marked volatile in
FL2000_REG_VOLATILE().

When FL2000_VGA_STATUS_LBUF_OVERFLOW or FL2000_VGA_STATUS_LBUF_UNDERFLOW is
set in val, fl2000_read_status() calls regmap_write_bits() on
FL2000_VGA_STATUS_REG. Because the register is volatile (and precious_reg
only prevents debugfs reads, not _regmap_update_bits()), regmap_write_bits()
issues a second _regmap_read() of FL2000_VGA_STATUS_REG before writing it
back. Any self-clearing event bits that assert between the initial
regmap_read() and the internal read in regmap_write_bits() will be cleared
by that second read and discarded instead of being returned in *status.
Should this use regmap_write() with val directly instead of
regmap_write_bits()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-fl2000-ups=
tream-v1-0-bb163ecb2309@gmail.com?part=3D1
