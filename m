Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47697CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBF710E765;
	Tue, 13 Oct 2026 08:59:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FA110E765
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:59:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F32F40A87;
 Tue, 13 Oct 2026 08:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5671F0089A;
 Tue, 13 Oct 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791881983;
 bh=H4RD/Kt/bJAv0FaAOhjrFmYP8G1bRLuVKo2Pv6PMjjo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dRtz3fKlCmnJ+z+O5JjC0Rx8NMgwLZCEliv1XtqVAXMdpYxlgdkiYmtMp1Ccq3iG9
 BHWa+1xo4wDOloATDt/UmSRSbuBKp1P2o2ASX8hs0Xr+voCdBKSdD0VJDQ80XzyNGg
 +z1gpOJTtM8E4CoHWZ+7ouUBN0ob9L4GBwAspucqIg+9b+wZa5LkFmlq9KR/GOhSI6
 a0WwZskl6PYHNXBr07hkIb0X38xPhI4qgCfTXvTGlfvPO7/lNLbGiNbM6gooL7aU+g
 3V22gVX970rlduE5/B+lN+FUvgpUHan5Ck1BcxdFsBM1lCn7zNHL1+Dw8YZoZXc2ZM
 zw6nTTCgavMZw==
Message-ID: <sashiko-outbox-169291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/7] bus: mhi: Capture DDR training data via command
 mode
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-6-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-6-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:59:42 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] mhi: Sleeping in atomic context due to mutex_lock() in MHI transfe=
r callback
- [High] mhi: Data corruption due to concurrent modification of shared TX b=
uffer
- [High] mhi: TOCTOU race condition dropping valid RX completions
- [High] bus: mhi: sleeping in atomic context during DL transfer callback
- [High] bus: mhi: TX buffer reuse race and raw payload misinterpretation i=
n Sahara
- [High] mhi: UAF / crash due to parent devres callback on module unload
- [Medium] mhi: Permanent channel hang due to un-requeued RX buffers for la=
rge transfers
- [Medium] mhi: Dead code in bounds validation due to unsigned comparison
- [Medium] mhi: Permanent channel hang due to unhandled zero-length response
--

commit 80f9d9bf2b27a92703cf2016cc04d3f992e75657
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Capture DDR training data via command mode

During early boot, devices may perform DDR training and produce training
data that can be reused on subsequent boots to reduce initialization
time. The Sahara protocol provides a command mode flow to transfer this
training data to the host, but the driver currently does not handle
command mode and drops the training payload.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 62b9c72e82680..aa684355b7a31 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c

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
Does allocating devres memory with GFP_KERNEL here cause a sleeping in atom=
ic
context bug?

This function is called from sahara_mhi_dl_xfer_cb(), which is executed from
the MHI event tasklet under a spinlock, creating an atomic context.

[Severity: High]
Can attaching this devres to the parent MHI controller device cause a
use-after-free on module unload?

Since the sahara module does not detach this devres on removal to persist t=
he
data, when the parent controller device is later unbound, devres_release_al=
l()
will call the sahara_cntrl_training_release pointer which resides in the
unloaded module's unmapped memory.

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
Is this bounds validation effective?

Since le32_to_cpu() returns an unsigned u32, checking if it is < 0 is
tautologically false and bypasses the validation.

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
Can this concurrent reuse of the TX buffer cause data corruption or protocol
failure?

The driver queues context->tx[0] via sahara_command_execute_data() and
immediately overwrites the same buffer in sahara_command_execute() without
waiting for the MHI UL completion.

Additionally, pipelining these commands causes the ID list raw payload to
stream back to the host while receiving_training_data is false. Will
sahara_command_processing() then incorrectly interpret this raw data as a
Sahara command header?

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
> +
> +	context->training_size =3D resp_len;
> +	context->training_rcvd =3D 0;
> +	context->receiving_training_data =3D true;
> +
> +	remaining =3D resp_len;
> +	for (i =3D 0; i < SAHARA_NUM_CMD_BUF && remaining; i++) {

[Severity: Medium]
If the device reports a response_length of 0, will this loop execute zero
times, queueing no RX buffers and hanging the channel since no completions
will arrive to trigger the state machine?

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
Does updating context->training_nbuf after queuing the buffers create a race
condition?

Since MHI queue operations are asynchronous, a completion could arrive
on another CPU and run sahara_mhi_dl_xfer_cb() before the loop finishes. If
training_nbuf is still 0, the callback might silently drop the valid
completion and stall the state machine.

[ ... ]

> @@ -899,15 +1155,71 @@ static void sahara_mhi_ul_xfer_cb(struct mhi_devic=
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
Does acquiring a sleeping mutex here cause a scheduling while atomic bug?

The MHI downlink transfer callback is invoked from a tasklet context
(mhi_ev_task) holding a spinlock, which creates an atomic execution context.

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

[Severity: Medium]
If the payload reported by the device is larger than the initially queued
buffer capacity, does returning here starve the MHI channel?

Since additional RX buffers are not queued via mhi_queue_buf() for the
remaining data, the Sahara state machine could permanently hang waiting for
data that cannot arrive.

> +			}
> +		}
> +		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D6
