Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23545C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5963A10EEDA;
	Wed,  1 Jul 2026 10:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8nGF1z4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F8210EEDA
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:57:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6132160138;
 Wed,  1 Jul 2026 10:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7D21F000E9;
 Wed,  1 Jul 2026 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903424;
 bh=uMs7ZrKUBHMIdvgQb5xByxM3HmzwaX/i4GCT7VuDIm0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R8nGF1z4+WMn3om4kbchg2UB5vc90NouE6v8DDOzoII8bRCk/3s5j7yAxNEE7QB3O
 VZoSbVU0iXaJyt6UGs+xyGEhQ2m4K8pRbLJkd59dgFIcxdRvFHJ3Via4XuNOpHxt0L
 0O5tqTnqq1ElpJMFr7jRfSZvMQAkcOqGYYaYCd18m4Eh4Jrkgoo7snUq6o4SMoeEPB
 j9OaqpXetC5Az96erjhpVbXYC0BWOxF/njz7iwHBaG8jQTG6edrR4vuYXWv5uwiwS0
 LbVoB+RnNyJ7KKMl1j0xNC+0JRXKoAuy3P7E1ZUiaxSx2DZJhP4RBMrWPAY0vRGqVF
 Z222GJbrAcZ5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] bus: mhi: Load DDR training data using device
 serial number
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:57:03 +0000
Message-Id: <20260701105703.ED7D21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] On 32-bit systems, `dump_length` is truncated during `vzalloc`=
, leading to a massive heap buffer overflow when parsing memory dumps.
- [High] Lack of synchronization between `fw_work` and `read_data_work` all=
ows a malicious or misbehaving device to trigger a Use-After-Free of firmwa=
re data.
- [High] Missing `cancel_work_sync` for `read_data_work` during driver remo=
val leads to a Use-After-Free.
--

commit 089e41c25a9507e0cb3ce33fb65d0e86f16f5c04
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Load DDR training data using device serial number

This commit extends the firmware loading logic to first attempt loading a=20
per-device DDR training image derived from the device's serial number. It
falls back to the default image if the per-device one is missing.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -226,6 +227,27 @@ static int sahara_find_image(struct sahara_context *=
context, u32 image_id)
>  		return 0;
>  	}
> =20
> +	/* DDR training special case: Try per-serial number file first */
> +	if (image_id =3D=3D SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
> +		u32 serial_num =3D context->mhi_dev->mhi_cntrl->serial_number;
> +
> +		fw_path =3D kasprintf(GFP_KERNEL,
> +				    "qcom/%s/mdmddr_0x%x.mbn",
> +				    context->fw_folder, serial_num);
[ ... ]

While reviewing this driver, I noticed a few pre-existing issues in the same
file that might need attention.

[Severity: High]
This is a pre-existing issue, but is there a lack of synchronization between
fw_work and read_data_work that could allow a use-after-free of the firmware
data?

If a compromised device sends an end of image packet while streaming data,
fw_work executes sahara_end_of_image() and calls sahara_release_image(),
which frees the firmware:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_release_image() {
    ...
    release_firmware(context->firmware);
    ...
}

Concurrently, read_data_work streams data using read_data_helper(), which
copies from the freed context->firmware->data:

drivers/bus/mhi/host/clients/sahara/sahara.c:read_data_helper() {
    ...
    memcpy(context->tx[buf_index],
           &context->firmware->data[context->read_data_offset],
           pkt_data_len);
    ...
}

Could this lead to memory corruption if a malicious device sends out-of-ord=
er
protocol packets?


[Severity: High]
This is a pre-existing issue, but does sahara_mhi_remove() fail to cancel
read_data_work before the context is freed?

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
    ...
    sahara_release_image(context);
    mhi_unprepare_from_transfer(mhi_dev);
    ...
}

Since read_data_work is not canceled with cancel_work_sync(), can it contin=
ue
to execute concurrently after the device is removed?

The context structure is allocated with devm_kzalloc and will be freed when
the remove function returns, potentially resulting in a use-after-free if t=
he
driver is unbound or the device is removed while streaming data.


[Severity: Critical]
This is a pre-existing issue, but on 32-bit systems, does this code truncate
dump_length during allocation?

In sahara_parse_dump_table(), dump_length is a 64-bit value representing the
total size of memory dumps:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_parse_dump_table() {
    ...
    context->mem_dump_sz =3D dump_length;
    context->mem_dump =3D vzalloc(dump_length);
    ...
}

Because vzalloc() takes a 32-bit unsigned long on 32-bit systems, a length
greater than 4GB will be silently truncated.

However, the driver then proceeds to stream the full 64-bit length of data
from the device, copying it into the under-allocated buffer:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_parse_dump_image() {
    ...
    memcpy(context->mem_dump_freespace, context->rx, context->rx_size);
    ...
}

Could a compromised MHI peripheral providing a crafted dump table trigger a
heap buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D5
