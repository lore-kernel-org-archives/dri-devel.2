Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA707CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 13:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E260710E144;
	Sun, 11 Oct 2026 13:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VyLKuHt8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB8610E144
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 13:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A314041372;
 Sun, 11 Oct 2026 13:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602871F0089B;
 Sun, 11 Oct 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791726958;
 bh=X0arZWV6nvgrHP+oFDFIEdlb8b1UvPR/r0gBWNocAls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VyLKuHt8PdEnFdfGxjzhsefeYzqSQyaZCUeOWpk0ILIU9vQblllldgQMYd6rbr+43
 LmJ7mGjPLi+LJNLLbLdyAbqhDmjhrTIIfhOHDvgpOrU6DqZCknaDporT17jDFwgxM6
 +ZtgXDDRPOGoMJVzVFxPLQLfH51y0VtgiANpW630ZrrL5efDw3usUezYcw8/6PoLlv
 305ttt4iFmVmHmzlif8ER+SfNR2DMRlDW1Ef6O+vNuwC2NMJWJB5qh2zmYZeRchYUW
 bhSIy7NLrH3aLpdkfDSZYLmRJDQsKJqzBSB9ncqiURJHa9Q1gn69h69QP55UGHD6bF
 Jd1i6WHNYGQRQ==
Date: Sun, 11 Oct 2026 19:25:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v6 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
Message-ID: <asuUcGWZOpfrhFHn@debian>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
 <rwjiriaurj2ajowddjjerrr5wsu4ios6lpm6adglvlzsrxf4x3@tw2wbobghgca>
 <4e3cbe78-7a32-42e8-90be-db5158907cad@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3cbe78-7a32-42e8-90be-db5158907cad@oss.qualcomm.com>
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

On Thu, Oct 08, 2026 at 11:41:59AM +0530, Kishore Batta wrote:
> 
> On 7/22/2026 5:52 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 01, 2026 at 04:07:41PM +0530, Kishore Batta wrote:
> > > DDR training data captured during Sahara command mode needs to be
> > > accessible to userspace so it can be persisted and reused on subsequent
> > > boots. Currently, the training data is stored internally in the driver
> > > but has no external visibility once the Sahara channel is torn down.
> > > 
> > > Expose the captured DDR training data via a read-only binary sysfs
> > > attribute on the MHI controller device:
> > > 
> > > /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data
> > > 
> > > The sysfs read callback serves data directly from controller scoped storage
> > > and protects access with the controller training data lock. The attribute
> > > lifetime is tied to the controller device via devres, allowing the data to
> > > remain readable after Sahara channel teardown and ensuring automatic
> > > cleanup when controller device is removed.
> > > 
> > > Userspace flow:
> > > 1. For each controller device, userspace reads the ddr_training_data sysfs
> > >     attribute.
> > > 2. If the read returns non-zero data, userspace persists it using a
> > >     serial specific filename (for example, mdmddr_0x<serial_no>.mbn).
> > > 3. On subsequent boots, the Sahara driver attempts to load this serial
> > >     specific DDR training image before falling back to the default
> > >     training image, restoring DDR calibration data and avoiding retraining.
> > > 
> > > Add ABI documentation for the DDR training data sysfs attribute exposed by
> > > Sahara MHI driver.
> > > 
> > > Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> > > ---
> > >   .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 +++++++
> > >   drivers/bus/mhi/host/clients/sahara/sahara.c       | 62 ++++++++++++++++++++++
> > >   2 files changed, 81 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> > > @@ -0,0 +1,19 @@
> > > +What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
> > > +
> > > +Date:                   March 2026
> > > +
> > > +Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
> > > +
> > > +Description:            Contains the DDR training data for the Qualcomm device
> > > +                        connected. MHI driver populates different controller
> > > +                        nodes for each device. The DDR training data is exposed
> > > +                        to userspace to read and save the training data file to
> > > +                        the filesystem. In the subsequent boot up of the device,
> > > +                        the training data is restored from host to device
> > > +                        optimizing the boot up time of the device.
> > > +
> > > +Usage:                  Example for reading DDR training data:
> > > +                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
> > > +
> > > +Permissions:            The file permissions are set to 0444 allowing read
> > > +                        access.
> > > diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > index 07bc743aa061dd2fa85638067d494562152474e3..72ac751c302a98448b5756c9feb438647bd0ce4b 100644
> > > --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > @@ -273,6 +273,66 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
> > >   	return ct;
> > >   }
> > > +static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
> > > +				      const struct bin_attribute *attr, char *buf,
> > > +				      loff_t offset, size_t count)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct sahara_cntrl_training_data *ct;
> > > +	size_t available;
> > > +
> > > +	ct = sahara_cntrl_training_get(dev);
> > > +	if (!ct)
> > > +		return -ENODEV;
> > > +
> > > +	mutex_lock(&ct->lock);
> > > +
> > > +	/* No data yet or offset past end */
> > > +	if (!ct->data || offset >= ct->size) {
> > > +		mutex_unlock(&ct->lock);
> > > +		return 0;
> > > +	}
> > > +
> > > +	available = ct->size - offset;
> > > +	count = min(count, available);
> > > +	memcpy(buf, (u8 *)ct->data + offset, count);
> > > +
> > > +	mutex_unlock(&ct->lock);
> > > +
> > > +	return count;
> > > +}
> > > +static BIN_ATTR_RO(ddr_training_data, 0);
> > > +
> > > +static void sahara_sysfs_devres_release(struct device *dev, void *res)
> > > +{
> > > +	device_remove_bin_file(dev, &bin_attr_ddr_training_data);
> > > +}
> > > +
> > > +static void sahara_sysfs_create(struct mhi_device *mhi_dev)
> > > +{
> > > +	struct device *dev = &mhi_dev->mhi_cntrl->mhi_dev->dev;
> > > +	void *cookie;
> > > +	int ret;
> > > +
> > > +	if (devres_find(dev, sahara_sysfs_devres_release, NULL, NULL))
> > > +		return;
> > > +
> > I think I asked this question before, but didn't follow up. This attribute
> > should be tied to the SAHARA channel, not the controller. There is no reason for
> > it to be available when the channel is gone.
> > 
> > - Mani
> 
> Sure. Let me clarify. In this flow, the sahara channel is used during boot
> and is torn down after the image transfer sequence completes. If the sysfs
> attribute is tied to the Sahara channel, its removal can occur before
> userspace has an opportunity to read and save the training data. This is why
> the attribute is intentionally tied to the MHI controller device. The
> controller remains available after the Sahara channel is removed, allowing
> userspace to read: /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data. This
> attribute remains empty until valid training data is captured and is removed
> only when the controller device itself is released. Thus, its controller
> lifetime is required to preserve the captured data across sahara channel
> teardown.
> 

Ok, fine then.

- Mani

