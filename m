Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1ECCA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B8710E02B;
	Mon, 12 Oct 2026 18:27:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F4710E641
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:27:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7793943081;
 Mon, 12 Oct 2026 18:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD641F0089B;
 Mon, 12 Oct 2026 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829625;
 bh=+2qTH+V27a6wcdI4Lc4cQO1AYg6Yf1kR/4MIpr/C38c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MnW31yfxWN0lj0r0sZBc7pJhojStbgsUfQXMcd4Cq6RWTgAaFeonE1IkTdY0upTE1
 pWfvAZCS3r8L8S7CAiE33QdS9OeyOH8HceEiD4K6T3UaljDML/14cWwHBQX529R549
 Djaxu5uSgZ8DgCYgiLda7WLIpVMclKUyKXw46PtbMfPv5PQwvz7/DIQHJm3ctBqrAd
 K7SsBuRv7y10Kuk5ukt+7GFM9IAGvpobbFve9xLy8ybQ+2nZCBqIhS4fJ6y1ZAVaf2
 3zbY+QVxqazI4sMGKzF65Hi4jW+YGBKl8J+dt3/lAnUaewPgKVOadSknGR2m7sIka7
 Y8WQeCegmNEpg==
Message-ID: <sashiko-outbox-168538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] bus: mhi: Capture DDR training data via command
 mode
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-6-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-6-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:27:04 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] mhi: sleep in atomic context via mutex_lock in dl_xfer_cb
- [High] mhi: module unload panic via leaked controller devres
- [High] mhi: DMA buffer corruption from concurrent tx[0] reuse
- [High] mhi: UAF due to incorrect teardown order in sahara_mhi_remove
- [Medium] mhi: unbounded memory allocation due to unsigned tautology
- [Medium] mhi: transfer stall for large or zero DDR training payloads
- [Medium] mhi: TOCTOU race leading to dropped training packets
- [Medium] mhi: protocol desynchronization if training buffer allocation fa=
ils
--

commit 1abdc448b94ff31d485a817b37e870ca14bbbfd6
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

    bus: mhi: Capture DDR training data via command mode
   =20
    During early boot, devices may perform DDR training and produce training
    data that can be reused on subsequent boots to reduce initialization
    time. The Sahara protocol provides a command mode flow to transfer this
    training data to the host, but the driver currently does not handle
    command mode and drops the training payload.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index afb72910fd67b..e7a6289b11a72 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c

[ ... ]

> @@ -335,6 +426,153 @@ static void sahara_hello(struct sahara_context *con=
text)
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

[Severity: Medium]
Since le32_to_cpu() returns a 32-bit unsigned integer, is the < 0 check
mathematically impossible? This would allow a malfunctioning device to prov=
ide
an exceptionally large response_length that bypasses the check and causes a
massive allocation in kzalloc().

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
Does calling sahara_command_execute_data() followed immediately by
sahara_command_execute() queue the same context->tx[0] buffer twice?

Since DMA buffers are submitted by reference, modifying context->tx[0] befo=
re
the hardware has consumed the first packet could cause data corruption.

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
If kzalloc() fails, we return and switch back to IMAGE_TX_PENDING without
setting context->receiving_training_data =3D true.

However, sahara_command_execute_data() was already sent earlier, instructing
the device to transmit the payload. If the device starts streaming data, wo=
n't
fw_work misinterpret the raw payload as Sahara protocol messages?

> +
> +	context->training_size =3D resp_len;
> +	context->training_rcvd =3D 0;
> +	context->receiving_training_data =3D true;
> +
> +	remaining =3D resp_len;
> +	for (i =3D 0; i < SAHARA_NUM_CMD_BUF && remaining; i++) {
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
> +}

[Severity: Medium]
Is there a race condition where mhi_queue_buf() allows the hardware to start
processing buffers immediately, before context->training_nbuf is updated?

If a buffer completes quickly on another CPU, sahara_mhi_dl_xfer_cb() might
check "i < context->training_nbuf" while training_nbuf is still 0, failing =
to
recognize the buffer as training data.

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
Does cancelling the workqueues before calling mhi_unprepare_from_transfer()
leave a window where incoming completions can re-arm the workqueue?

sahara_mhi_dl_xfer_cb() could run in this window and=20
schedule_work(&context->cmd_work). When remove finishes, context is freed,=
=20
which could result in a Use-After-Free when the workqueue executes.

[Severity: High]
Does this function also need to clean up the devres allocated in
sahara_cntrl_training_get()?

The devres is attached to the parent MHI controller. If the Sahara driver
module is unloaded without explicitly detaching it, the release callback
pointer will become stale. When the MHI controller is subsequently removed,
the devres core will invoke the unmapped callback, causing a panic.

[ ... ]

> @@ -900,15 +1156,71 @@ static void sahara_mhi_ul_xfer_cb(struct mhi_devic=
e *mhi_dev, struct mhi_result
>  static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi=
_result *mhi_result)
>  {
>  	struct sahara_context *context =3D dev_get_drvdata(&mhi_dev->dev);
> +	struct sahara_cntrl_training_data *ct;
> +	struct device *dev;
> +	size_t copy;
> +	int ret;
> +	u32 i;
> +
> +	if (mhi_result->transaction_status)
> +		return;
> +
> +	/*
> +	 * Raw training payload completions arrive for cmd_buff[] buffers.
> +	 * Do not schedule cmd_work for those.
> +	 */
> +	if (context->is_cmd_mode && context->receiving_training_data &&
> +	    mhi_result->buf_addr !=3D context->rx) {
> +		dev =3D &context->mhi_dev->mhi_cntrl->mhi_dev->dev;
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

[Severity: High]
sahara_mhi_dl_xfer_cb() is an MHI transfer completion callback which execut=
es
in atomic context (softirq). Will acquiring a sleepable mutex here trigger a
'scheduling while atomic' BUG?

> +				copy =3D min_t(size_t, mhi_result->bytes_xferd,
> +					     ct->size - ct->copied);
> +				memcpy((u8 *)ct->data + ct->copied,
> +				       mhi_result->buf_addr, copy);
> +				ct->copied +=3D copy;
> +				mutex_unlock(&ct->lock);
> +
> +				context->training_rcvd +=3D copy;
> +
> +				if (context->training_rcvd >=3D context->training_size) {
> +					mutex_lock(&ct->lock);
> +					ct->receiving =3D false;
> +					mutex_unlock(&ct->lock);
> +
> +					context->receiving_training_data =3D false;
> +					context->is_cmd_mode =3D false;
> +
> +					sahara_switch_mode_to_img_tx(context);
> +					ret =3D mhi_queue_buf(context->mhi_dev,
> +							    DMA_FROM_DEVICE,
> +							    context->rx,
> +							    SAHARA_PACKET_MAX_SIZE,
> +							    MHI_EOT);
> +					if (ret)
> +						dev_err(&context->mhi_dev->dev,
> +							"Unable to requeue rx buf %d\n", ret);
> +				}
> +				return;
> +			}
> +		}
> +		return;
>  	}

[Severity: Medium]
If the device payload is larger than the capacity of the initially queued
SAHARA_NUM_CMD_BUF buffers, the remainder is not queued. Since the buffer is
not requeued here after its contents are copied, won't the transfer stall
permanently waiting for more buffers?

Similarly, if the response_length is 0, zero buffers are queued in
sahara_command_execute_resp(). Will this also stall the state machine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D6
