Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A6606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGXFShHZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4FF10E393;
	Fri,  6 Nov 2026 02:59:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CB010E08F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 02:59:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AFB042D73;
 Fri,  6 Nov 2026 02:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5315C1F008A2;
 Fri,  6 Nov 2026 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793933974;
 bh=p9cBrDuHzswV3MkUITLsBx2st/GWNJZQb4zthNNs++s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hGXFShHZHa1KGpctaqZa5MH/Z4f/NUkYSqkEqqM0fmyJYFmgYL731Ldppaz6xNo3j
 4XYaB9XXqv/QUMdhbrZhcqQVRThjtw9759FdVcrFFGwuKoLi4Q2ZS8P9jrbjGORlhp
 M7306vQgt5p+KprV3r3pD4Dm2b3mvdIzp5ju2rXcUPJQdBFeEqNFfb2vbMvBzuhWHj
 GuLsBkdkqIZ9E3MeOEUE5Ahel6p3Tnz7mQL0rMw5qmKvPdqI4s4mbBfNH+Wc0xgmtR
 xvTWszTHjn5P9AYC8S/XnhiHrK37jxNewqkKMWWhn5o9c71Lrq50AgeyaDxQ4L7atn
 vPWRNlBeYclRg==
Message-ID: <sashiko-outbox-200619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] drm/fl2000: Add ITE IT66121 HDMI transmitter
 support
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-fl2000-upstream-v1-2-bb163ecb2309@gmail.com>
References: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
 <20261105-fl2000-upstream-v1-2-bb163ecb2309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:59:33 +0000
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] drm/fl2000: broken I2C probing and return values in it66121_i2c_pr=
obe()
- [High] drm/fl2000: UAF and resource leak from usb_dev devres in fl2000_pr=
obe()
- [High] drm/fl2000: unsafe teardown ordering and UAF race in it66121_destr=
oy()
- [Medium] drm/fl2000: duplicate IT66121 bridge driver in it66121_create()
- [Medium] drm/fl2000: EDID extension block corruption in it66121_do_get_ed=
id_block()
- [Medium] drm/fl2000: broken IRQ clear, mask, and error handling in it6612=
1_intr_work()
- [Medium] drm/fl2000: stale regmap and EDID cache in it66121_bridge_attach=
() on rebind
- [Medium] drm/fl2000: unlocked IT66121_SW_RST RMW race in it66121_abort_dd=
c_ops()
- [Low] drm/fl2000: out-of-mask value in it66121_configure_afe() register w=
rite
- [Low] drm/fl2000: uninitialized status logged in it66121_wait_ddc_ready()
--

commit 1d8fe736e9a996195ce28bd6f054bf21a532ce7c
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add ITE IT66121 HDMI transmitter support

This commit adds support for the ITE IT66121 HDMI transmitter on the FL2000
I2C bus and exposes it as a DRM bridge component with hotplug detection and
EDID reading (via both the IT66121 DDC FIFO and a direct FL2000 I2C fallbac=
k).

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drv.c b/drivers/gpu/drm/fl2000=
/fl2000_drv.c
> index ea089d3c1d09c..107eba92c18d3 100644
> --- a/drivers/gpu/drm/fl2000/fl2000_drv.c
> +++ b/drivers/gpu/drm/fl2000/fl2000_drv.c

[ ... ]

> @@ -52,6 +54,44 @@ static struct fl2000_devs *fl2000_get_devices(struct u=
sb_device *usb_dev)
>  	return devs;
>  }
> =20
> +static void fl2000_bridge_release(struct device *dev, void *res)
> +{
> +	struct i2c_client **client =3D res;
> +
> +	dev_dbg(dev, "Destroying IT66121 bridge\n");
> +	it66121_destroy(*client);
> +}
> +
> +/*
> + * Create the IT66121 bridge and tie its destruction to the usb_device
> + * lifetime: it must survive component master del/add cycles (USB resets=
) and
> + * die only when the USB device is actually gone. The devres is released
> + * before the I2C adapter devres (LIFO), so the client is destroyed whil=
e its
> + * adapter still exists.
> + */
> +static int fl2000_bridge_create(struct usb_device *usb_dev, struct fl200=
0_devs *devs)
> +{
> +	struct i2c_client *client;
> +	struct i2c_client **holder;
> +
> +	holder =3D devres_alloc(fl2000_bridge_release, sizeof(*holder), GFP_KER=
NEL);
> +	if (!holder)
> +		return -ENOMEM;
> +
> +	client =3D it66121_create(devs->adapter);
> +	if (IS_ERR(client)) {
> +		dev_err(&usb_dev->dev, "Cannot create HDMI bridge (%pe)\n", client);
> +		devres_free(holder);
> +		return -ENODEV;
> +	}
> +
> +	*holder =3D client;
> +	devres_add(&usb_dev->dev, holder);
> +	devs->bridge_client =3D client;
> +
> +	return 0;
> +}

[ ... ]

> @@ -96,6 +150,12 @@ static void fl2000_disconnect(struct usb_interface *i=
nterface)
>  	if (!devs)
>  		return;
> =20
> +	/*
> +	 * The IT66121 bridge is intentionally NOT destroyed here: disconnect
> +	 * also runs for the transient unbind/rebind cycles of
> +	 * usb_reset_device(), where the usb_device survives. Its destruction is
> +	 * a devres of the usb_device, see fl2000_bridge_create().
> +	 */

[Severity: High]
Can attaching fl2000_bridge_release to &usb_dev->dev in
fl2000_bridge_create() cause a use-after-free on driver unbind or module
unload, or leak resources when probing an interface fails?

fl2000_driver is a struct usb_driver that binds to struct usb_interface
(&interface->dev), while the parent struct usb_device (&usb_dev->dev) is
bound to usb_generic_driver in usbcore.

When fl2000_driver is unbound via sysfs or unloaded via rmmod fl2000 while
the USB device stays plugged in (or if fl2000_probe() fails on an
interface), usb_unbind_interface() only releases devres on &interface->dev.
Because &usb_dev->dev remains bound to usb_generic_driver,
devres_release_all(&usb_dev->dev) does not run until physical USB unplug, a=
nd
fl2000_disconnect() intentionally skips tearing down devs->bridge_client and
devs (allocated on &usb_dev->dev in fl2000_get_devices()).

If the fl2000 module is unloaded while the USB dongle is connected:
- priv->bridge remains in the global DRM bridge_list with bridge.funcs
  pointing to unmapped it66121_bridge_funcs
- priv->client->dev remains in the global component_list with ops pointing
  to unmapped it66121_component_ops
- priv->work_queue stays active running it66121_intr_work() in unmapped
  module text
- &usb_dev->dev retains devres release callbacks (such as
  fl2000_bridge_release) pointing into freed module memory when the USB
  device is later unplugged.

Should the lifecycle of devs->bridge_client and devs instead be reference-
counted across the bound USB interfaces and torn down when active_if drops =
to
0 outside of a reset (for example using pre_reset and post_reset callbacks)?

> diff --git a/drivers/gpu/drm/fl2000/fl2000_it66121.c b/drivers/gpu/drm/fl=
2000/fl2000_it66121.c
> new file mode 100644
> index 0000000000000..208f92823954a
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_it66121.c
> @@ -0,0 +1,1030 @@

[ ... ]

> +static int it66121_configure_afe(struct it66121_priv *priv, int clock_kh=
z)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(priv->regmap, IT66121_AFE_DRV_CONTROL, IT66121_AFE=
_RST);
> +	if (ret)
> +		return ret;
> +
> +	/* Values from the vendor reference driver, the bits are undocumented */
> +	if (clock_khz > 80000) {
> +		ret =3D regmap_write_bits(priv->regmap, IT66121_AFE_XP_CONTROL, 0x90, =
0x80);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_write_bits(priv->regmap, IT66121_AFE_IP_CONTROL_1, 0x89=
, 0x80);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_write_bits(priv->regmap, IT66121_AFE_IP_CONTROL_3, 0x10=
, 0x80);
> +		if (ret)
> +			return ret;

[Severity: Low]
In it66121_configure_afe(), when clock_khz > 80000, regmap_write_bits() is
called on IT66121_AFE_IP_CONTROL_3 with mask 0x10 and value 0x80.

Since regmap_update_bits_base() computes (orig & ~mask) | (val & mask), and
(0x80 & 0x10) is 0, bit 7 (0x80) is masked out and only bit 4 (0x10) is
cleared. Was the value meant to be 0x00 to clear bit 4 (matching
drivers/gpu/drm/bridge/ite-it66121.c), or was bit 7 meant to be included in
the mask?

[ ... ]

> +static int it66121_wait_ddc_ready(struct it66121_priv *priv)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	/*
> +	 * Wait for completion only. On this hardware the FL2000 I2C master and
> +	 * the IT66121 DDC master share the physical bus, so 'wait bus' and
> +	 * 'arbitration lose' flags are live/latched transients of the engine
> +	 * retrying on a contended bus, not terminal errors - the only reliable
> +	 * terminal signal is TX_DONE (or the timeout).
> +	 */
> +	ret =3D regmap_read_poll_timeout(priv->regmap, IT66121_DDC_STATUS, val,
> +				       val & DDC_STATUS_TX_DONE, EDID_SLEEP, EDID_TIMEOUT);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "DDC not done (%d), status 0x%02X\n", ret,=
 val);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
In it66121_wait_ddc_ready(), if the first regmap_read() inside
regmap_read_poll_timeout() fails with a negative error code (for example due
to a USB or I2C transfer error), regmap_read_poll_timeout() returns
immediately without writing to val.

Won't dev_err() then read and print the uninitialized stack variable val?

[ ... ]

> +static int it66121_abort_ddc_ops(struct it66121_priv *priv)
> +{
> +	int ret;
> +	unsigned int swreset, cpdesire;
> +
> +	/*
> +	 * The HDCP engine shares the DDC master and holds the bus after chip
> +	 * reset (DDC status reports 'wait bus' + 'arbitration lose', 0x1A).
> +	 * Follow the ITE reference sequence, as the ite-it66121 driver does:
> +	 * clear HDCP CP_DESIRE, reset the HDCP engine and re-select the host as
> +	 * DDC master before issuing the abort command.
> +	 */
> +	ret =3D regmap_read(priv->regmap, IT66121_SW_RST, &swreset);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(priv->regmap, IT66121_HDCP_CONTROL, &cpdesire);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, IT66121_HDCP_CONTROL,
> +			   cpdesire & ~IT66121_HDCP_CP_DESIRE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, IT66121_SW_RST, swreset | IT66121_SW=
_HDCP_RST);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Can it66121_abort_ddc_ops() race with it66121_set_mode() when modifying
IT66121_SW_RST?

In it66121_get_edid_block() -> it66121_do_get_edid_block() ->
it66121_abort_ddc_ops(), IT66121_SW_RST is read into swreset, two USB I2C
transfers are performed on IT66121_HDCP_CONTROL, and then
swreset | IT66121_SW_HDCP_RST is written back under priv->ddc_lock.

Meanwhile, it66121_bridge_atomic_enable() -> it66121_set_mode() runs in the
atomic commit tail without holding priv->ddc_lock, setting and clearing
IT66121_SW_REF_RST_HDMITX | IT66121_SW_HDMI_VID_RST in IT66121_SW_RST:

    regmap_write_bits(priv->regmap, IT66121_SW_RST,
                      IT66121_SW_REF_RST_HDMITX | IT66121_SW_HDMI_VID_RST,
                      IT66121_SW_REF_RST_HDMITX | IT66121_SW_HDMI_VID_RST);
    ...
    regmap_write_bits(priv->regmap, IT66121_SW_RST,
                      IT66121_SW_REF_RST_HDMITX | IT66121_SW_HDMI_VID_RST, =
0);

If it66121_abort_ddc_ops() reads swreset while the HDMI reset bits are set
and writes swreset | IT66121_SW_HDCP_RST back after it66121_set_mode() clea=
rs
them, won't the transmitter remain stuck in reset? Using regmap_write_bits()
for IT66121_SW_HDCP_RST (and IT66121_HDCP_CP_DESIRE) would keep each update
atomic under the regmap lock.

[ ... ]

> +static void it66121_intr_work(struct work_struct *work_item)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct delayed_work *dwork =3D to_delayed_work(work_item);
> +	struct it66121_priv *priv =3D container_of(dwork, struct it66121_priv, =
work);
> +	/* Do not use bridge.dev here: it is NULL while the bridge is detached =
*/
> +	struct device *dev =3D &priv->client->dev;
> +
> +	ret =3D regmap_field_read(priv->irq_pending, &val);
> +	if (ret) {
> +		dev_err(dev, "Cannot read interrupt status (%d)\n", ret);
> +		return;
> +	}
> +
> +	if (val) {
> +		ret =3D regmap_read(priv->regmap, IT66121_INT_STATUS_1, &val);
> +		if (ret) {
> +			dev_err(dev, "Cannot read IT66121_INT_STATUS_1 (%d)\n", ret);
> +			return;
> +		}
> +
> +		regmap_field_write(priv->clr_irq, 1);
> +	}
> +
> +	queue_delayed_work(priv->work_queue, &priv->work, msecs_to_jiffies(IRQ_=
POLL_INTRVL));
> +}

[Severity: Medium]
There seem to be three issues with the interrupt polling in
it66121_intr_work() and it66121_start_interrupts():

1. regmap_field_write(priv->clr_irq, 1) calls regmap_field_update_bits_base=
()
   with force =3D false. If bit 0 of IT66121_SYS_STATUS (0x0E) already read=
s as
   1, regmap skips the bus write and the interrupt is not cleared. Should
   this use regmap_field_force_write(priv->clr_irq, 1)?

2. it66121_start_interrupts() only unmasks IT66121_MASK_DDC in
   IT66121_INT_MASK_1, leaving HPD (IT66121_INT_STATUS_1_HPD) masked, and
   it66121_intr_work() reads IT66121_INT_STATUS_1 without writing to
   IT66121_INT_CLEAR_1 to clear latched interrupt sources.

3. If either regmap_field_read() or regmap_read() fails once due to a
   transient USB or I2C transfer error, it66121_intr_work() returns before
   queue_delayed_work(), permanently stopping the polling work until a
   system suspend/resume cycle.

> +/*
> + * EDID read through the IT66121 DDC master (EDID FIFO command), for boa=
rds
> + * where the monitor's DDC lines are wired to the IT66121.
> + */
> +static int it66121_do_get_edid_block(struct it66121_priv *priv, u8 *buf,=
 unsigned int block,
> +				     size_t len)
> +{
> +	int ret;
> +	size_t remain =3D len;
> +	unsigned int val;
> +	unsigned int segment =3D block >> 1;
> +	unsigned int offset =3D (block & 1) ? 128 : 0;
> +	static const u8 header[EDID_LOSS_LEN] =3D { 0x00, 0xFF, 0xFF };
> +
> +	/* Abort any ongoing DDC operation */
> +	ret =3D it66121_abort_ddc_ops(priv);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Statically fill first 3 bytes (due to EDID reading HW bug they are
> +	 * lost, but they are constant in any valid EDID header).
> +	 */
> +	while (offset < EDID_LOSS_LEN && remain > 0) {
> +		*(buf++) =3D header[offset];
> +		remain--;
> +		offset++;
> +	}
> +
> +	while (remain > 0) {
> +		/* Add bytes that will be lost during EDID read */
> +		size_t size =3D remain + EDID_LOSS_LEN;
> +
> +		/* ... and check size fits FIFO */
> +		size =3D min_t(size_t, size, EDID_FIFO_SIZE);
> +
> +		ret =3D it66121_clear_ddc_fifo(priv);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(priv->regmap, IT66121_DDC_ADDRESS, EDID_DDC_ADDR);
> +		if (ret)
> +			return ret;
> +
> +		/* Account 3 bytes that will be lost */
> +		ret =3D regmap_write(priv->regmap, IT66121_DDC_OFFSET, offset - EDID_L=
OSS_LEN);

[Severity: Medium]
Does it66121_do_get_edid_block() corrupt even-numbered EDID extension blocks
and misalign FIFO reads?

First, for any even-numbered extension block (such as block 2, where
segment =3D 1 and offset =3D 0), the loop:

    while (offset < EDID_LOSS_LEN && remain > 0) {
        *(buf++) =3D header[offset];
        remain--;
        offset++;
    }

checks only offset < EDID_LOSS_LEN without checking block =3D=3D 0, overwri=
ting
the first 3 bytes of the extension block (the extension tag, revision, and
DTD offset) with the base EDID block 0 header bytes { 0x00, 0xFF, 0xFF }.

Second, IT66121_DDC_STATUS (0x16) and IT66121_DDC_RD_FIFO (0x17) lie in the
same 4-byte aligned dword (0x14..0x17). Because fl2000_i2c_xfer() executes
every 1-byte register read as a 4-byte aligned dword read via
fl2000_i2c_read_dword(), each poll of IT66121_DDC_STATUS in
it66121_wait_ddc_ready() also reads IT66121_DDC_RD_FIFO (0x17) and pops a
byte from the DDC FIFO whenever data is available. With EDID_SLEEP set to
5000 us, the number of polls in it66121_wait_ddc_ready() is not guaranteed
to equal the hardcoded EDID_LOSS_LEN (3), shifting the remaining bytes read
from IT66121_DDC_RD_FIFO.

[ ... ]

> +static int it66121_bridge_attach(struct drm_bridge *bridge, struct drm_e=
ncoder *encoder,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct it66121_priv *priv =3D container_of(bridge, struct it66121_priv,=
 bridge);
> +
> +	/* The connector is the display driver's (drm_bridge_connector_init()) =
*/
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +		drm_err(bridge->dev, "The IT66121 bridge does not create a connector\n=
");
> +		return -EINVAL;
> +	}
> +
> +	if (!bridge->encoder) {
> +		drm_err(bridge->dev, "Parent encoder object not found\n");
> +		return -ENODEV;
> +	}
> +
> +	it66121_init_chip(priv);
> +
> +	it66121_start_interrupts(priv);
> +
> +	drm_dbg_kms(bridge->dev, "Bridge attached\n");
> +
> +	return 0;
> +}

[ ... ]

> +void it66121_resume(struct drm_bridge *bridge)
> +{
> +	struct it66121_priv *priv =3D container_of(bridge, struct it66121_priv,=
 bridge);
> +
> +	regcache_drop_region(priv->regmap, 0, it66121_regmap_config.max_registe=
r);
> +	it66121_init_chip(priv);
> +	it66121_start_interrupts(priv);
> +
> +	/* Another monitor may have been plugged in meanwhile */
> +	WRITE_ONCE(priv->edid_stale, true);
> +}

[Severity: Medium]
Since the IT66121 bridge persists across usb_reset_device() and USB interfa=
ce
unbind/rebind cycles, should it66121_bridge_attach() also drop the regmap
cache and mark priv->edid_stale =3D true like it66121_resume() does?

When the bridge is re-attached on rebind (and after it66121_init_chip()
issues IT66121_SW_REF_RST_HDMITX), priv->regmap still holds cached register
values in REGCACHE_MAPLE from before the reset (including the bank selector
register IT66121_SYS_CONTROL and non-volatile Bank 0/1 registers), which can
cause regmap_write_bits() and bank selection to skip necessary hardware
writes. In addition, priv->edid_stale is not set to true on re-attach.

[ ... ]

> +static int it66121_i2c_probe(struct i2c_adapter *adapter, unsigned short=
 address)
> +{
> +	int ret;
> +	u8 id_regs[] =3D { IT66121_VENDOR_ID_1, IT66121_VENDOR_ID_2, IT66121_DE=
VICE_ID_1,
> +			 IT66121_DEVICE_ID_2 };
> +	u8 id[ARRAY_SIZE(id_regs)];
> +	u16 vendor, device;
> +
> +	dev_dbg(&adapter->dev, "Detecting IT66121 at address 0x%X on %s\n", add=
ress,
> +		adapter->name);
> +
> +	/* We rely on full I2C protocol + 1 byte SMBUS read for detection */
> +	ret =3D i2c_check_functionality(adapter, I2C_FUNC_I2C | I2C_FUNC_SMBUS_=
READ_BYTE);
> +	if (!ret) {
> +		dev_dbg(&adapter->dev, "Adapter does not support I2C functions properl=
y\n");
> +		return -ENODEV;
> +	}
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(id_regs); i++) {
> +		struct i2c_msg msgs[] =3D {
> +			{ .addr =3D address, .flags =3D 0, .len =3D 1, .buf =3D &id_regs[i] },
> +			{ .addr =3D address, .flags =3D I2C_M_RD, .len =3D 1, .buf =3D &id[i]=
 }
> +		};
> +
> +		ret =3D i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
> +		if (ret < 0) {
> +			dev_err(&adapter->dev, "I2C transfer failed (%d)\n", ret);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	vendor =3D get_unaligned_le16(&id[0]);
> +	device =3D get_unaligned_le16(&id[2]);
> +	if (vendor !=3D VENDOR_ID || (device & ~REVISION_MASK) !=3D DEVICE_ID) {
> +		dev_dbg(&adapter->dev, "IT66121 not found (0x%X-0x%X)\n", vendor, devi=
ce);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(&adapter->dev, "IT66121 found, revision %d\n",
> +		(device & REVISION_MASK) >> REVISION_SHIFT);
> +
> +	return 0;
> +}

[Severity: High]
Aren't the return values and functionality check in it66121_i2c_probe()
inverted for i2c_new_scanned_device()?

In drivers/i2c/i2c-core-base.c, i2c_new_scanned_device() checks:

    if (probe(adap, addr_list[i]))
        break;

so the custom probe callback must return 1 (non-zero) when a device is found
and 0 when it is not found. Instead, it66121_i2c_probe() returns -ENODEV
(non-zero) on error or ID mismatch and 0 on a valid match.

Furthermore, it66121_i2c_probe() checks for I2C_FUNC_SMBUS_READ_BYTE even
though the loop below uses raw i2c_transfer() messages. In
drivers/gpu/drm/fl2000/fl2000_i2c.c, fl2000_i2c_func() only advertises:

    return I2C_FUNC_I2C | I2C_FUNC_NOSTART;

Because I2C_FUNC_SMBUS_READ_BYTE is not set, i2c_check_functionality() alwa=
ys
returns 0, causing it66121_i2c_probe() to immediately return -ENODEV without
performing any I2C transfers on the bus. i2c_new_scanned_device() treats th=
at
non-zero -ENODEV return value as a positive match at the first address
(0x98 >> 1 =3D 0x4c), unconditionally instantiating the IT66121 client even=
 on
FL2000 boards without an IT66121 and never scanning the second address
(0x9A >> 1 =3D 0x4d).

> +static struct i2c_client *it66121_i2c_init(struct i2c_adapter *adapter)
> +{
> +	/*
> +	 * Not "it66121": that name would make the ite-it66121 driver, if built,
> +	 * try to bind this client and release our devres when its probe fails.
> +	 */
> +	struct i2c_board_info board_info =3D { I2C_BOARD_INFO("fl2000-it66121",=
 0) };
> +
> +	/* According to datasheet IT66121 addresses are 0x98 or 0x9A including =
cmd */
> +	const unsigned short it66121_addr[] =3D { (0x98 >> 1), (0x9A >> 1), I2C=
_CLIENT_END };
> +
> +	return i2c_new_scanned_device(adapter, &board_info, it66121_addr, it661=
21_i2c_probe);
> +}

[Severity: Medium]
This isn't a runtime bug in itself, but the kernel already has an in-tree D=
RM
bridge driver for the ITE IT66121 in drivers/gpu/drm/bridge/ite-it66121.c.
Could drivers/gpu/drm/bridge/ite-it66121.c be extended to support non-OF
instantiation and a custom DDC fallback rather than duplicating the IT66121
driver in drivers/gpu/drm/fl2000/fl2000_it66121.c?

> +void it66121_destroy(struct i2c_client *client)
> +{
> +	struct drm_bridge *bridge;
> +	struct it66121_priv *priv;
> +
> +	if (!client)
> +		return;
> +
> +	bridge =3D dev_get_drvdata(&client->dev);
> +	priv =3D container_of(bridge, struct it66121_priv, bridge);
> +
> +	cancel_delayed_work_sync(&priv->work);
> +
> +	destroy_workqueue(priv->work_queue);
> +
> +	component_del(&priv->client->dev, &it66121_component_ops);
> +
> +	drm_edid_free(priv->drm_edid);
> +	priv->drm_edid =3D NULL;
> +
> +	drm_bridge_remove(&priv->bridge);
> +
> +	/*
> +	 * Drops the devm reference to the bridge; priv is freed together with
> +	 * the bridge once DRM releases the remaining references.
> +	 */
> +	i2c_unregister_device(priv->client);
> +}
> +
> +struct i2c_client *it66121_create(struct i2c_adapter *adapter)
> +{

[ ... ]

> +	priv->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> +	priv->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
> +
> +	drm_bridge_add(&priv->bridge);
> +
> +	/* Setup work queue for interrupt processing work */
> +	priv->work_queue =3D alloc_ordered_workqueue("it66121_work", 0);
> +	if (!priv->work_queue) {
> +		drm_bridge_remove(&priv->bridge);
> +		i2c_unregister_device(client);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Store bridge pointer at I2C client device for further binding */
> +	dev_set_drvdata(&priv->client->dev, &priv->bridge);
> +
> +	/* Bind component of I2C client to master I2C adapter */
> +	ret =3D component_add(&priv->client->dev, &it66121_component_ops);
> +	if (ret) {
> +		dev_err(&client->dev, "Cannot register IT66121 component (%d)\n", ret);
> +		destroy_workqueue(priv->work_queue);
> +		drm_bridge_remove(&priv->bridge);
> +		i2c_unregister_device(client);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return client;
> +}

[Severity: High]
Can the teardown ordering in it66121_destroy() and the error path in
it66121_create() trigger a use-after-free?

1. In it66121_destroy(), cancel_delayed_work_sync(&priv->work) and
   destroy_workqueue(priv->work_queue) are called before
   component_del(&priv->client->dev, &it66121_component_ops) and
   drm_bridge_remove(&priv->bridge). Until component_del() finishes, a
   concurrent attach or it66121_resume() call can still invoke
   it66121_start_interrupts() and queue work onto the destroyed
   priv->work_queue.

2. In it66121_create(), drm_bridge_add(&priv->bridge) is called before
   priv->work_queue is allocated, and if component_add() fails after
   it66121_bind() -> drm_bridge_attach() -> it66121_start_interrupts() has
   already queued priv->work during master bring-up, the error path calls
   destroy_workqueue(priv->work_queue) without first calling
   cancel_delayed_work_sync(&priv->work).

3. If userspace holds an open DRM fd across USB unplug, the DRM device and
   encoder can outlive it66121_destroy() until the final drm_dev_put().
   However, it66121_destroy() frees priv->drm_edid without locking against
   it66121_bridge_edid_read(), and i2c_unregister_device(priv->client)
   releases all devm resources on &client->dev (priv->regmap, priv->hpd,
   priv->irq_pending, priv->clr_irq) and frees priv->client without calling
   drm_bridge_unplug() or guarding bridge callbacks with drm_bridge_enter().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-fl2000-ups=
tream-v1-0-bb163ecb2309@gmail.com?part=3D2
