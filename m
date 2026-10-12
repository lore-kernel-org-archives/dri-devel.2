Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B8CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B48710F2DE;
	Mon, 12 Oct 2026 18:30:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E3D10F2DE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:29:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0620660142;
 Mon, 12 Oct 2026 18:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EA11F0089B;
 Mon, 12 Oct 2026 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829797;
 bh=ucEhbJ6FV5Bf5zwNX4ZJzoY4Z9qIxGvJ9dKG7GT7R38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M+/fDLtngl52RQL1HVMD2gn3fTCYbGrZf/i5KHzzHA1XHOqcHXNOxGuKrNj2GlfaF
 jPcOI4HE5S3u6Bqw7zlhUiWj8f1vO87aIIIjnp1NLEpp+ncH0lcyZDvsRvr97lgrGO
 Oom8jdYISVbPafUncsiGgbj+W98W6Y7EybXG8qZxRxQ0MjRmEw/Z5QfW0SNQHYqP8k
 l1SpVajIDwlHIC7UXg5eLzeHKe2tkGMlFxtGrd/F0rXFNbk6BNgwJHhRJsXW/pPsXa
 s9FN3qYme6OvsMQA4RLyu5XMWvYnbgY2x5fuUfENrB630ArT/ZGb3Dc2vvISZDT1jP
 2ja9GMpxeZ1MA==
Message-ID: <sashiko-outbox-168540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-4-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-4-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:29:57 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mhi: sahara: concurrent workqueues corrupt shared tx[0] DMA buffer
--

commit f8c1fedf3c26d1f3f5b6996e23406ceb42b03572
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Add QDU100 Sahara variant and firmware fallback

This commit extends the Sahara driver to recognize QDU100 devices on the
SAHARA MHI channel and associates it with the QDU100 firmware folder. It al=
so
adds a firmware lookup fallback to allow images to be provisioned by the
platform if they do not have an explicit entry in the device's firmware tab=
le.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 74bf57f02873e..4baa47d0b94e3 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c

[ ... ]

> @@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device =
*mhi_dev, struct mhi_result
> =20
>  static const struct mhi_device_id sahara_mhi_match_table[] =3D {
>  	{ .chan =3D "QAIC_SAHARA", },
> +	{ .chan =3D "SAHARA", },

[Severity: High]
Does this code have a data race leading to DMA ring corruption?

During a streaming transfer, read_data_work repeatedly uses context->tx[0]
to stream firmware data:

drivers/bus/mhi/host/clients/sahara/sahara.c:read_data_helper() {
    ...
	memcpy(context->tx[buf_index],
	       &context->firmware->data[context->read_data_offset],
	       pkt_data_len);
    ...
}

If the endpoint concurrently sends an asynchronous command like HELLO,
END_OF_IMAGE, or CMD_READY, fw_work is scheduled and will overwrite tx[0]:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_hello() {
    ...
	context->tx[0]->cmd =3D cpu_to_le32(SAHARA_HELLO_RESP_CMD);
	context->tx[0]->length =3D cpu_to_le32(SAHARA_HELLO_LENGTH);
    ...
}

Since read_data_work and fw_work could modify and queue the same TX buffer
at the same time, is it possible for tx[0] to be overwritten and enqueued
while it is already mapped and active for read_data_work?

An untrusted or misbehaving MHI endpoint could trigger this by sending an
unexpected packet during streaming.

>  	{},
>  };
> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
> =20
>  static struct mhi_driver sahara_mhi_driver =3D {
>  	.id_table =3D sahara_mhi_match_table,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D4
