Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D4BCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2B910EB43;
	Tue, 12 May 2026 14:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UWQn5fVo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562CA10EB1E
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:19:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F23940132;
 Tue, 12 May 2026 14:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A58AC2BCFD;
 Tue, 12 May 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778595569;
 bh=PNZ/3cndYwK5qYRqVndM22pticPFw2T6YxzS/qmSwlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UWQn5fVoxLB/KAH4EURrhpqBaLzBb5p8rV6dSUVS9VPOwdklqeVM9M7jVOo70vURZ
 Gc3iF7tqhIHwZ112zXGqvbhvu2H9TXMCpWcdZG7P/i2icIFaCUyO4xtWpKeFokBoNI
 n7OKlJ8EXUC6TZw6mZH7NDeK3vW6FWEvqmRmJTnux7Tux6bKkgwss0u1fyFQZ6Ps9s
 5HUity/IMzbvd5Og20saJ5uICn2otZgE4I7BtbWrOm8A2NoJkfr5BiNhv5LgjnrgoR
 2VLQtfebQXDldsEorU4QtYQgrDOoBbesmelRs4LLsxoB88f1efPKX3WawZLuRaGlnA
 1hEJofu32VB0w==
Date: Tue, 12 May 2026 19:49:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v5 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
Message-ID: <x732txb6wf2giiv22xw66sqrnkjluaua5kbsmjugv4rbvpjqrw@ro2wbv2olzbd>
References: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
 <20260416-sahara_protocol_new_v2-v5-7-6aebf005e4ba@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416-sahara_protocol_new_v2-v5-7-6aebf005e4ba@oss.qualcomm.com>
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

On Thu, Apr 16, 2026 at 07:39:48PM +0530, Kishore Batta wrote:
> DDR training data captured during Sahara command mode needs to be
> accessible to userspace so it can be persisted and reused on subsequent
> boots. Currently, the training data is stored internally in the driver
> but has no external visibility once the Sahara channel is torn down.
> 
> Expose the captured DDR training data via a read-only binary sysfs
> attribute on the MHI controller device:
> 
> /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data
> 
> The sysfs read callback serves data directly from controller scoped storage
> and protects access with the controller training data lock. The attribute
> lifetime is tied to the controller device via devres, allowing the data to
> remain readable after Sahara channel teardown and ensuring automatic
> cleanup when controller device is removed.
> 
> Userspace flow:
> 1. For each controller device, userspace reads the ddr_training_data sysfs
>    attribute.
> 2. If the read returns non-zero data, userspace persists it using a
>    serial specific filename (for example, mdmddr_0x<serial_no>.mbn).
> 3. On subsequent boots, the Sahara driver attempts to load this serial
>    specific DDR training image before falling back to the default
>    training image, restoring DDR calibration data and avoiding retraining.
> 
> Add ABI documentation for the DDR training data sysfs attribute exposed by
> Sahara MHI driver.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>  .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 ++++++
>  drivers/bus/mhi/host/clients/sahara/sahara.c       | 69 ++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> new file mode 100644
> index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> @@ -0,0 +1,19 @@
> +What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
> +
> +Date:                   March 2026
> +
> +Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
> +
> +Description:            Contains the DDR training data for the Qualcomm device
> +                        connected. MHI driver populates different controller
> +                        nodes for each device. The DDR training data is exposed
> +                        to userspace to read and save the training data file to
> +                        the filesystem. In the subsequent boot up of the device,
> +                        the training data is restored from host to device
> +                        optimizing the boot up time of the device.
> +
> +Usage:                  Example for reading DDR training data:
> +                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
> +
> +Permissions:            The file permissions are set to 0444 allowing read
> +                        access.
> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> index 07bc743aa061dd2fa85638067d494562152474e3..fef5dc1d8884133397d204f23361584fd1d9b075 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -273,6 +273,73 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
>  	return ct;
>  }
>  
> +static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
> +				      const struct bin_attribute *attr, char *buf,
> +				      loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sahara_cntrl_training_data *ct;
> +	size_t available;
> +
> +	ct = sahara_cntrl_training_get(dev);
> +	if (!ct)
> +		return -ENODEV;
> +
> +	mutex_lock(&ct->lock);
> +
> +	/* No data yet or offset past end */
> +	if (!ct->data || offset >= ct->size) {
> +		mutex_unlock(&ct->lock);
> +		return 0;
> +	}
> +
> +	available = ct->size - offset;
> +	count = min(count, available);
> +	memcpy(buf, (u8 *)ct->data + offset, count);
> +
> +	mutex_unlock(&ct->lock);
> +
> +	return count;
> +}
> +
> +static const struct bin_attribute ddr_training_data_attr = {
> +	.attr = {
> +		.name = "ddr_training_data",
> +		.mode = 0444,
> +	},
> +	.read = ddr_training_data_read,
> +};

You can simplify the attribute creation with BIN_ATTR_RO().

> +
> +static void sahara_sysfs_devres_release(struct device *dev, void *res)
> +{
> +	device_remove_bin_file(dev, &ddr_training_data_attr);
> +}
> +
> +static void sahara_sysfs_create(struct mhi_device *mhi_dev)
> +{
> +	struct device *dev = &mhi_dev->mhi_cntrl->mhi_dev->dev;
> +	void *cookie;
> +	int ret;
> +
> +	if (devres_find(dev, sahara_sysfs_devres_release, NULL, NULL))
> +		return;

So you are expecting this helper to be called mutiple times without teardown?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
