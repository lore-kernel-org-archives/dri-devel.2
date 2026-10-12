Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314D7CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A0910E64E;
	Mon, 12 Oct 2026 18:29:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F251B10E64E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:29:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0989760142;
 Mon, 12 Oct 2026 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2231F0089B;
 Mon, 12 Oct 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829776;
 bh=DxzCS2kuA9KwkFH4lF5cg9IWThFGTeYfFT7ggM2KoKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rtmfc7oCsXzqL8EaQF3Tb1W6hbEgz3UGAmcbxULwbAE3vrgh2UszoUTfMi45Ie6vi
 XgRtTTXY+KMijigbX3m8LauY2uWyICirlR676ADvN2ZUhPEY4lYuj5YvaJXc77VXB6
 s0ZyjDigDIoG47wyMh+fxtIKk8U3S8CBZtepKY+6DUrt3dO0TIhDDzZ6iU+tIOTaw7
 hbyfLAK3YIqUaoMqtTiI3a0j0mS7MaVFKzb4r06NHBg+tOwK37l+2n9dM3vRf7oAYh
 qNVAdnUyx/SDixgvmVF0BzYOe1Xr2k8jIgK5xhNN0wwEqWFcMMzwsJAfuMXb/i/y1p
 x6OOkD8OLDY+Q==
Message-ID: <sashiko-outbox-168539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] bus: mhi: Centralize Sahara firmware image table
 selection at probe time
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-3-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-3-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:29:36 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] workqueue: missing cancel_work_sync for read_data_work causes use-=
after-free
- [High] mhi: teardown race in sahara_mhi_remove allows requeuing canceled =
work
- [High] mhi: data race on read_data_offset allows out-of-bounds firmware m=
emory read
- [Low] qaic: redundant strcmp in qaic_mhi_register_controller() for sahara=
_fw
--

commit 6aa29eb13055431d194b1b8244436f789375e69f
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>
bus: mhi: Centralize Sahara firmware image table selection at probe time

This patch refactors the Sahara firmware image table selection into a singl=
e,
explicit probe time mechanism using a controller provided firmware mapping
table. This centralizes device specific decisions and simplifies the Sahara
probe logic.

> diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi=
_controller.c
> index 40e6d262ef217..dd320739c07ad 100644
> --- a/drivers/accel/qaic/mhi_controller.c
> +++ b/drivers/accel/qaic/mhi_controller.c

[ ... ]

> @@ -871,6 +927,11 @@ struct mhi_controller *qaic_mhi_register_controller(=
struct pci_dev *pci_dev, voi
>  		mhi_cntrl->name =3D "AIC100";
>  	}
> =20
> +	if (mhi_cntrl->name && !strcmp(mhi_cntrl->name, "AIC100"))
> +		mhi_cntrl->sahara_fw =3D &aic100_sahara_fw;
> +	else if (mhi_cntrl->name && !strcmp(mhi_cntrl->name, "AIC200"))
> +		mhi_cntrl->sahara_fw =3D &aic200_sahara_fw;
> +

[Severity: Low]
This isn't a bug, but since mhi_cntrl->name was just assigned as a literal
string ("AIC100" or "AIC200") right above this, is it necessary to use
strcmp() to check it again? Could the sahara_fw assignment be done directly
in the same if/else block that sets the name?

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index dc64beae06ada..74bf57f02873e 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c

[ ... ]

> @@ -808,14 +768,14 @@ static int sahara_mhi_probe(struct mhi_device *mhi_=
dev, const struct mhi_device_
> -	if (!strcmp(mhi_dev->mhi_cntrl->name, "AIC200")) {
> -		context->image_table =3D aic200_image_table;
> -		context->table_size =3D ARRAY_SIZE(aic200_image_table);
> -	} else {
> -		context->image_table =3D aic100_image_table;
> -		context->table_size =3D ARRAY_SIZE(aic100_image_table);
> -		context->non_streaming =3D true;
> -	}
> +	sahara_fw =3D mhi_dev->mhi_cntrl->sahara_fw;
> +	if (!sahara_fw || !sahara_fw->image_table || !sahara_fw->table_size)
> +		return -ENODEV;
> +
> +	context->image_table =3D sahara_fw->image_table;
> +	context->table_size =3D sahara_fw->table_size;
> +	context->non_streaming =3D sahara_fw->non_streaming;
> +	context->fw_folder =3D sahara_fw->fw_folder;

[Severity: High]
Since this configures devices for streaming mode which relies on
read_data_work being scheduled, could the teardown path leave this work
running? Looking at sahara_mhi_remove(), it cancels fw_work and dump_work
but skips read_data_work:

sahara_mhi_remove() {
    ...
    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    vfree(context->mem_dump);
    ...
}

If the device is unbound while read_data_work is pending or executing, will
the work execute after the devm-allocated context is freed by devres,
leading to a use-after-free when sahara_read_data_processing() runs?

[Severity: High]
Also in sahara_mhi_remove(), is there a race with the MHI channels that
could requeue canceled work?

sahara_mhi_remove() {
    ...
    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    ...
    mhi_unprepare_from_transfer(mhi_dev);
}

Since cancel_work_sync() happens before mhi_unprepare_from_transfer()
stops the channels, if an MHI packet arrives during or immediately after
the cancellations, won't sahara_mhi_dl_xfer_cb() blindly call
schedule_work(&context->fw_work) again? This newly queued work would then
execute on the freed context memory after remove() completes.

[Severity: High]
Does streaming mode have a data race on read_data_offset and
read_data_length? In sahara_read_data(), these fields are updated without
locks:

sahara_read_data() {
    ...
    context->read_data_offset =3D data_offset;
    context->read_data_length =3D data_len;
}

Back in sahara_processing(), the driver re-queues the single context->rx
buffer, allowing the device to send another command. If a malicious device
sends a second command while a large streaming transfer is ongoing, fw_work
will update these fields while read_data_work is actively running on another
CPU.

Can read_data_helper() then read a mixed state (like the large length from
the first command and a huge offset from the second command) causing an
out-of-bounds read from kernel memory via memcpy()?

read_data_helper() {
    ...
    pkt_data_len =3D min(context->read_data_length, SAHARA_PACKET_MAX_SIZE);
    memcpy(context->tx[buf_index],
           &context->firmware->data[context->read_data_offset],
           pkt_data_len);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D3
