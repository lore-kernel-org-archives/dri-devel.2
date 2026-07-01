Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743DBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D6210EECE;
	Wed,  1 Jul 2026 10:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jchXpjzF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6B510EECE
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:47:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A62242B1D;
 Wed,  1 Jul 2026 10:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FBE1F00A3A;
 Wed,  1 Jul 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782902865;
 bh=RxHAg4NelItD8ixRFtXu7Q+DIETNNBl9/yLGzMWzv5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jchXpjzFTiNFtVZiieH7yNzNDJfK0QOECq3cdPJ40KOt9KYt4Cbf+0Bh5pqS213tL
 LFBRZ55Z7HxDsJlPdAYSvyf6NgoxyC4d12frCLA+okPSyCDs/qEt5d8xLNQGe6mxCr
 rdwOFGpmBmFJRvelJcNtDwOF0oNhmloRAPcmooEp2SVLXEmquHDf1s7j1O0X+72jw6
 pHYpV6q8P28GGuhfbmKe8My6PxWKmAei2fIqS9d8ggPvo0diCOiXTIqXq/Dy0y05B6
 2j3mjVd/XRws+KN6gses1/e2YFDFM3KGeCxmN+URLre1VOiiQbwTt1Xsdf3GwmAs3Y
 BVSRCMKBZ/tTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] bus: mhi: Centralize Sahara firmware image table
 selection at probe time
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-3-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-3-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:47:44 +0000
Message-Id: <20260701104744.D3FBE1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `read_data_work` during device removal lea=
ds to a Use-After-Free.
- [High] Lack of synchronization between concurrent device command processi=
ng and data streaming leads to Use-After-Free and TX buffer corruption.
--

commit 812426ed0db5b6e824926f5d8eecb24c749a578e
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Centralize Sahara firmware image table selection at probe time

This commit refactors the Sahara driver to select firmware image tables usi=
ng
a controller provided mapping table at probe time. It centralizes device
specific conditionals that were previously scattered across the driver. This
prepares the driver for extending support to new devices.

[ ... ]

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 858dc5bc39c1a..e339c67e236af 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -179,48 +179,7 @@ struct sahara_context {
>  	u32				read_data_length;
>  	bool				is_mem_dump_mode;
>  	bool				non_streaming;
[ ... ]
> +	const char			*fw_folder;
>  };

[Severity: High]
This is a pre-existing issue, but can the device removal path cause a
use-after-free here?

In drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove(),
the teardown cancels other work items:

    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    cancel_work_sync(&context->cmd_work);

However, it seems cancel_work_sync(&context->read_data_work) is omitted.
If a device in streaming mode is actively transferring firmware data via
read_data_work, and the driver is unbound, devres will free the device-mana=
ged
context structure.=20

Will the pending or sleeping sahara_read_data_processing() work item then
continue to run and access the freed context and its firmware buffer?

[Severity: High]
This is a pre-existing issue, but is there a lack of synchronization between
concurrent device command processing and data streaming that could corrupt
the TX buffer?

If read_data_work is running to stream a firmware image, and a faulty or
compromised device sends an out-of-band message (like END_OF_IMAGE_CMD) on
the downlink channel, fw_work will run concurrently with read_data_work.

fw_work calls sahara_end_of_image(), which frees context->firmware and writ=
es a
response to context->tx[0]:

    sahara_release_image(context);
    ...
    context->tx[0]->cmd =3D cpu_to_le32(SAHARA_DONE_CMD);

Concurrently, read_data_helper() executed from read_data_work accesses the
freed firmware and writes to the same TX buffer:

    memcpy(context->tx[buf_index],
           &context->firmware->data[context->read_data_offset],
           pkt_data_len);

Does this sequence result in a use-after-free and packet corruption before
queuing it to MHI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D3
