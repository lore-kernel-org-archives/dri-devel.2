Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DD4CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D0110E76B;
	Thu,  8 Oct 2026 06:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ldX2+2bQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC7E10E76B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:35:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB18542A17;
 Thu,  8 Oct 2026 06:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA56A1F000FF;
 Thu,  8 Oct 2026 06:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791441308;
 bh=Rzc3WlafHwq87WzQTC5xy894EMLhpqhzIed7bk8ZVpo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ldX2+2bQhY/nnVZcJJzseq6+6UHrvcdFA6KXRw7DxHwOtRjqODnczMjt1OGzp7nKg
 5X5AEM6cFaJUb8COs7ig1EtH/fAhENfhda2jVQ8h6RUOnv7+/7UVpQCJ6z0kTpnoub
 /DRY1D8zxn04KMc36osxLb1p0ReUI6fOqRu5YqDL/dsXGbBMpSbPNHHemeBmj7oK7e
 AcVSZ2Y2emKhJyNZVMK1R/b27k+B9CdLWBFO+JLDE7ykvd9UMpxJfBwXg4pinQBtX2
 kftTgVZ5rRCgreDcLbKdRZoKSPOkdaHsG9qT3Shc2R19C58DldoMSCTOwjluwoh3Wd
 PeeGHTe6glTAg==
Message-ID: <sashiko-outbox-163698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] bus: mhi: Capture DDR training data via command
 mode
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-6-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <20261008-sahara_protocol_new_v2-v7-6-90d278bd7414@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:35:08 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] bus: mhi: sahara: sleep in atomic context in MHI DL callback
- [High] bus: mhi: sahara: DMA buffer tx[0] overwritten by back-to-back com=
mands
- [High] bus: mhi: sahara: data race on training_nbuf causes dropped traini=
ng data
- [High] bus: mhi: sahara: RX buffer starvation for payloads exceeding SAHA=
RA_NUM_CMD_BUF
- [High] bus: mhi: sahara: Use-After-Free on driver unbind due to workqueue=
 scheduling
- [Medium] bus: mhi: sahara: kzalloc failure leaves device state desynchron=
ized
- [Low] bus: mhi: sahara: unsigned comparison < 0 is always false
--

commit fb7f9d4895e33988ece817a3e664348b3c8347cb
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Capture DDR training data via command mode

During early boot, devices may perform DDR training and produce training
data that can be reused on subsequent boots to reduce initialization
time. The Sahara protocol provides a command mode flow to transfer this
training data to the host, but the driver currently does not handle
command mode and drops the training payload.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 4606950555721..11f65cbfa66b8 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
[ ... ]
> @@ -335,6 +426,153 @@ static void sahara_hello(struct sahara_context *con=
text)
[ ... ]
> +static void sahara_command_execute(struct sahara_context *context, u32 c=
lient_command)
> +{
> +	int ret;
> +
> +	context->tx[0]->cmd =3D cpu_to_le32(SAHARA_EXECUTE_CMD);
> +	context->tx[0]->length =3D cpu_to_le32(SAHARA_COMMAND_EXECUTE_LENGTH);
> +	context->tx[0]->command_execute.client_command =3D cpu_to_le32(client_c=
ommand);
> +
> +	ret =3D mhi_queue_buf(context->mhi_dev, DMA_TO_DEVICE, context->tx[0],
> +			    SAHARA_COMMAND_EXECUTE_LENGTH, MHI_EOT);
[ ... ]
> +static void sahara_command_execute_data(struct sahara_context *context, =
u32 client_command)
> +{
> +	int ret;
> +
> +	context->tx[0]->cmd =3D cpu_to_le32(SAHARA_EXECUTE_DATA_CMD);
> +	context->tx[0]->length =3D cpu_to_le32(SAHARA_COMMAND_EXEC_DATA_LENGTH);
> +	context->tx[0]->command_exec_data.client_command =3D cpu_to_le32(client=
_command);
> +
> +	ret =3D mhi_queue_buf(context->mhi_dev, DMA_TO_DEVICE, context->tx[0],
> +			    SAHARA_COMMAND_EXEC_DATA_LENGTH, MHI_EOT);
[ ... ]
> +static void sahara_command_execute_resp(struct sahara_context *context)
> +{
> +	struct device *dev =3D &context->mhi_dev->mhi_cntrl->mhi_dev->dev;
> +	struct sahara_cntrl_training_data *ct;
> +	u32 client_cmd, resp_len;
> +	int ret;
> +	u64 remaining;
> +	u32 i;
> +
> +	if (le32_to_cpu(context->rx->length) !=3D SAHARA_COMMAND_EXEC_RESP_LENG=
TH ||
> +	    le32_to_cpu(context->rx->command_execute_resp.response_length) < 0)=
 {

[Severity: Low]
Since le32_to_cpu() returns an unsigned 32-bit integer, will this check
for < 0 ever evaluate to true, or is it dead code?

> +		dev_err(&context->mhi_dev->dev,
> +			"Malformed command execute resp packet - length %d\n",
> +			le32_to_cpu(context->rx->length));
> +		return;
> +	}
> +
> +	client_cmd =3D le32_to_cpu(context->rx->command_execute_resp.client_com=
mand);
> +	resp_len =3D le32_to_cpu(context->rx->command_execute_resp.response_len=
gth);
> +
> +	sahara_command_execute_data(context, client_cmd);
> +
> +	if (client_cmd =3D=3D SAHARA_EXEC_CMD_GET_COMMAND_ID_LIST) {
> +		sahara_command_execute(context, SAHARA_EXEC_CMD_GET_TRAINING_DATA);

[Severity: High]
Can the second command locklessly overwrite the shared tx[0] buffer while
the first DMA transfer from sahara_command_execute_data() is still in
flight?

> +		return;
> +	}
> +
> +	if (client_cmd !=3D SAHARA_EXEC_CMD_GET_TRAINING_DATA)
> +		return;
> +
> +	ct =3D sahara_cntrl_training_get(dev);
> +	if (!ct) {
> +		context->is_cmd_mode =3D false;
> +		sahara_switch_mode_to_img_tx(context);
> +		return;
> +	}
> +
> +	mutex_lock(&ct->lock);
> +	kfree(ct->data);
> +	ct->data =3D kzalloc(resp_len, GFP_KERNEL);
> +	ct->size =3D resp_len;
> +	ct->copied =3D 0;
> +	ct->receiving =3D true;
> +	mutex_unlock(&ct->lock);
> +
> +	if (!ct->data) {
> +		context->is_cmd_mode =3D false;
> +		sahara_switch_mode_to_img_tx(context);
> +		return;
> +	}

[Severity: Medium]
If this allocation fails, does returning early leave the device
transmitting raw training data (triggered earlier by
sahara_command_execute_data) that will later be misinterpreted as regular
commands?

> +
> +	context->training_size =3D resp_len;
> +	context->training_rcvd =3D 0;
> +	context->receiving_training_data =3D true;
> +
> +	remaining =3D resp_len;
> +	for (i =3D 0; i < SAHARA_NUM_CMD_BUF && remaining; i++) {

[Severity: High]
If the requested response length exceeds SAHARA_NUM_CMD_BUF, will the MHI
channel exhaust its RX buffers and stall since the DL callback does not
dynamically requeue more buffers to consume the remaining data?

> +		size_t pkt =3D min_t(size_t, remaining, SAHARA_PACKET_MAX_SIZE);
> +
> +		ret =3D mhi_queue_buf(context->mhi_dev, DMA_FROM_DEVICE,
> +				    context->cmd_buff[i], pkt,
> +				    (remaining <=3D pkt) ? MHI_EOT : MHI_CHAIN);
> +		if (ret)
> +			break;
> +
> +		remaining -=3D pkt;
> +	}
> +
> +	context->training_nbuf =3D i;

[Severity: High]
Since mhi_queue_buf() gives the hardware access to the buffer, could a
concurrent interrupt fire before training_nbuf is updated? If so, would
the callback see a stale value and drop the training data?

> +}
[ ... ]
> @@ -884,6 +1139,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi=
_dev)
> =20
>  	cancel_work_sync(&context->fw_work);
>  	cancel_work_sync(&context->dump_work);
> +	cancel_work_sync(&context->cmd_work);
>  	vfree(context->mem_dump);
>  	sahara_release_image(context);
>  	mhi_unprepare_from_transfer(mhi_dev);

[Severity: High]
If an incoming packet triggers the completion callback between cancelling
the work and shutting down the channel (via mhi_unprepare_from_transfer),
could the callback reschedule the work item which would later dereference
the freed context pointer?

>  }
> =20
> @@ -900,15 +1156,71 @@ static void sahara_mhi_ul_xfer_cb(struct mhi_devic=
e *mhi_dev, struct mhi_result
>  static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi=
_result *mhi_result)
>  {
>  	struct sahara_context *context =3D dev_get_drvdata(&mhi_dev->dev);
> +	struct sahara_cntrl_training_data *ct;
[ ... ]
> +		ct =3D sahara_cntrl_training_get(dev);
> +		if (!ct)
> +			return;
> =20
> -	if (!mhi_result->transaction_status) {
> -		context->rx_size =3D mhi_result->bytes_xferd;
> -		if (context->is_mem_dump_mode)
> -			schedule_work(&context->dump_work);
> -		else
> -			schedule_work(&context->fw_work);
> +		for (i =3D 0; i < context->training_nbuf; i++) {
> +			if (mhi_result->buf_addr =3D=3D context->cmd_buff[i]) {
> +				mutex_lock(&ct->lock);

[Severity: Critical]
Is it safe to acquire this sleeping mutex in the atomic softirq context of
the MHI DL callback?

Additionally, sahara_cntrl_training_get() allocates memory with
GFP_KERNEL:

ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KERNEL);

Could this trigger a 'scheduling while atomic' panic upon receiving data?

> +				copy =3D min_t(size_t, mhi_result->bytes_xferd,
> +					     ct->size - ct->copied);
> +				memcpy((u8 *)ct->data + ct->copied,
> +				       mhi_result->buf_addr, copy);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-sahara_pro=
tocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com?part=3D6
