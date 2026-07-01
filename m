Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4AFC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC0E10E12D;
	Wed,  1 Jul 2026 10:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EeXzFbop";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B55D10E12D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3199440C52;
 Wed,  1 Jul 2026 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E927D1F000E9;
 Wed,  1 Jul 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903080;
 bh=+0Rk2xjOlHfPf8RkWULG5IReAEtYLGkkCSfukqTke/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EeXzFbopYVo08o010FMmJnAVn8UzFgxr2s0hUOJGwe6OzQtj+s9aPT696Y4ihvBhN
 3HnTsDxrfh35/l8DwPieD/PbKQvTOEUlZzzkcOyFRTfIk1sBU72D4n0wmIdIxBSvCR
 NrUrG7+Z4JtVsRgXnNoRFb2BghnPFIWemRmq4K/XppKAPmb0H3UwH9vGN81bCMHPdZ
 z19btTjyYQSoIApF6EZv1GtrBKzvUXf2UbXkm6ZQZCV124G9riy8C4yZawLadEoJU/
 ndc6PV9jT7ik9hhvU4Z7pzgGw54rY03E5q7ZpEkO8Z4FImw1G7LT7SMROn+KcN5URP
 tKo3KtLNnTGOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] bus: mhi: Capture DDR training data via command
 mode
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-6-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-6-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:51:19 +0000
Message-Id: <20260701105119.E927D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [High] The MHI downlink completion callback acquires a mutex and makes a =
GFP_KERNEL allocation while in a tasklet context.
- [High] The driver limits the number of queued RX buffers for the training=
 payload but never requeues them, stalling the protocol and creating an inc=
omplete MHI chain.
- [High] Sequential MHI commands concurrently overwrite the shared `context=
->tx[0]` buffer before the asynchronous MHI DMA can process them.
- [High] Attaching devres to the parent controller device without explicitl=
y cleaning it up during module unload leads to a use-after-free kernel pani=
c.
- [High] A data race on `context->training_nbuf` causes the DL callback to =
miss training buffers, dropping data and re-processing stale control packet=
s.
- [High] Inadequate state tracking risks misinterpreting raw command list d=
ata as a protocol packet.
- [High] Concurrent devres allocation can lead to multiple training data st=
ructures and memory leaks.
- [Medium] The validation check for negative response length is tautologica=
lly false due to an unsigned integer comparison.
- [Medium] A zero-length training data response causes the driver state mac=
hine to hang permanently.
- [Medium] The sysfs node exposes uninitialized or zero-padded data to user=
space during an active MHI transfer.

Pre-existing issues:
- [High] The driver cancels workqueues before stopping the MHI channel, cre=
ating a race condition that leads to a use-after-free.
--

commit 3f86759313db40d3845a0cb024dac27dcf18f52b
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
> index b5ca6353540dc..07bc743aa061d 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
[ ... ]
> @@ -181,6 +206,24 @@ struct sahara_context {
>  	bool				is_mem_dump_mode;
>  	bool				non_streaming;
>  	const char			*fw_folder;
> +	bool				is_cmd_mode;
> +	bool				receiving_training_data;
> +	size_t				training_size;
> +	size_t				training_rcvd;
> +	u32				training_nbuf;
> +	char				*cmd_buff[SAHARA_NUM_CMD_BUF];
> +};
> +
> +/*
> + * Controller-scoped training data store (per MHI controller device).
> + * Stored as devres resource on mhi_dev->mhi_cntrl->mhi_dev->dev.
> + */
> +struct sahara_cntrl_training_data {
> +	struct mutex lock;	/* Protects data, size, copied and receiving */
> +	void *data;
> +	size_t size;
> +	size_t copied;
> +	bool receiving;
>  };

[Severity: Medium]
Does the sysfs node expose uninitialized or zero-padded data to userspace
during an active MHI transfer?

The sysfs read function ddr_training_data_read() serves up to ct->size
bytes of ct->data. Because ct->size is set to the full expected response
length before the data is actually received, and the read function does
not check if the transfer is complete (e.g., via ct->receiving) or limit the
copy to ct->copied, a userspace process reading concurrently could receive
uninitialized memory.

>  static bool is_streaming(struct sahara_context *context)
[ ... ]
> +static struct sahara_cntrl_training_data *sahara_cntrl_training_get(stru=
ct device *dev)
> +{
> +	struct sahara_cntrl_training_data *ct;
> +
> +	ct =3D devres_find(dev, sahara_cntrl_training_release,
> +			 sahara_cntrl_training_match, NULL);
> +	if (ct)
> +		return ct;
> +
> +	ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KER=
NEL);

[Severity: High]
Can concurrent calls to this function lead to multiple training data
structures and memory leaks?

Because devres_find() and devres_alloc() are used in a check-and-add pattern
without locking, if this is called concurrently from the sysfs read callback
and the MHI DL callback, both threads could see a NULL result, allocate
their own structures, and add them. Would this result in multiple entries in
the devres list and inconsistent states?

> +	if (!ct)
> +		return NULL;
> +
> +	mutex_init(&ct->lock);
> +	ct->data =3D NULL;
> +	ct->size =3D 0;
> +	ct->copied =3D 0;
> +	ct->receiving =3D false;
> +
> +	devres_add(dev, ct);
> +	return ct;
> +}
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

[Severity: Medium]
Is this negative response length check tautologically false?

Since le32_to_cpu() returns an unsigned 32-bit integer, this condition
always evaluates to false. Could a malicious or malfunctioning device
send a massive length, causing a large kzalloc() attempt to fail?

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
> +		return;
> +	}

[Severity: High]
Will these sequential commands overwrite the shared buffer before transmiss=
ion?

sahara_command_execute_data() populates context->tx[0] and queues it via
mhi_queue_buf() which schedules an asynchronous DMA transfer. Immediately
afterward, sahara_command_execute() overwrites the exact same context->tx[0]
buffer. Does this corrupt the outgoing protocol messages and queue the same
virtual address into the MHI ring twice?

[Severity: High]
Is there a risk of misinterpreting raw command list data as a protocol pack=
et?

For SAHARA_EXEC_CMD_GET_COMMAND_ID_LIST, the device streams the command list
raw data into context->rx. Since receiving_training_data is only set for ID
9 later in this function, does sahara_command_processing() process the raw
command list data as protocol packets?

> +
> +	if (client_cmd !=3D SAHARA_EXEC_CMD_GET_TRAINING_DATA)
> +		return;
[ ... ]
> +	context->training_size =3D resp_len;
> +	context->training_rcvd =3D 0;
> +	context->receiving_training_data =3D true;
> +
> +	remaining =3D resp_len;
> +	for (i =3D 0; i < SAHARA_NUM_CMD_BUF && remaining; i++) {

[Severity: Medium]
Does a zero-length response cause the driver state machine to hang?

If resp_len is 0, the queuing loop is skipped entirely because remaining
is 0. With receiving_training_data set to true, context->rx won't be
re-queued in sahara_command_processing(). Does this mean no buffers are
queued in hardware, preventing the driver from ever receiving an event to
exit command mode?

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

[Severity: High]
Could a data race on context->training_nbuf cause the DL callback to miss
training buffers?

This loop queues cmd_buff receive buffers, but context->training_nbuf is
updated only after the loop completes. If the device responds quickly,
the DL callback for the first buffer might fire concurrently. Since
training_nbuf would still be 0, the callback's loop would skip matching
the training buffer and incorrectly fall through to the control packet
path.

[ ... ]
> @@ -885,6 +1140,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi=
_dev)
> =20
>  	cancel_work_sync(&context->fw_work);
>  	cancel_work_sync(&context->dump_work);
> +	cancel_work_sync(&context->cmd_work);
>  	vfree(context->mem_dump);
>  	sahara_release_image(context);
>  	mhi_unprepare_from_transfer(mhi_dev);

[Severity: High]
This is a pre-existing issue, but does the inverted cleanup order here
create a race condition leading to a use-after-free?

The driver synchronously cancels all works before calling
mhi_unprepare_from_transfer(mhi_dev). Because the MHI channel is still
active, an incoming DL completion can trigger the DL callback and
reschedule a work item after the cancellation. When module removal
completes, context is freed, and the scheduled work will access freed memor=
y.

[Severity: High]
Does the module removal function exit without unregistering the persistent
devres structures from the controller?

The driver allocates a devres struct sahara_cntrl_training_data on the
MHI controller device to outlive the Sahara channel. However, the release
callbacks are defined in the sahara module. If sahara_mhi_remove() does
not remove these controller-bound resources, will the kernel attempt to
execute the devres callbacks located in freed module memory when the
controller is later destroyed?

> @@ -901,15 +1157,71 @@ static void sahara_mhi_ul_xfer_cb(struct mhi_devic=
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

[Severity: High]
Does this callback acquire a sleeping lock and perform blocking memory
allocation while in an atomic context?

sahara_mhi_dl_xfer_cb() is executed by the MHI core in an atomic context
(typically a tasklet). However, it calls sahara_cntrl_training_get(dev)
which allocates memory with GFP_KERNEL, and directly calls mutex_lock(&ct->=
lock)
below. Will this trigger a 'BUG: scheduling while atomic' kernel panic duri=
ng
normal training data reception?

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

[Severity: High]
If the response requires more buffers than initially queued, does the
transfer stall permanently?

In sahara_command_execute_resp(), the driver queues up to SAHARA_NUM_CMD_BUF
buffers. If the response size exceeds the total capacity, the loop finishes
with the last buffer incorrectly flagged with MHI_CHAIN. When those buffers
complete, this callback accumulates training_rcvd but fails to requeue
additional buffers. Will training_rcvd never reach training_size, leaving
the MHI channel hung waiting for the chain to complete?

> +					mutex_lock(&ct->lock);
> +					ct->receiving =3D false;
> +					mutex_unlock(&ct->lock);
> +
> +					context->receiving_training_data =3D false;
> +					context->is_cmd_mode =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D6
