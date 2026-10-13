Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECFECC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310B610E794;
	Tue, 13 Oct 2026 09:01:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18E810E794
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:00:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6644360261;
 Tue, 13 Oct 2026 09:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DE11F000FF;
 Tue, 13 Oct 2026 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791882057;
 bh=FHcuoMSfHcm4LqrtGUfi8rzHWYbpG6QhuiGhf8wb6Uo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RaI1yE7IesLCD0TTfthRWsupnfHu9usQzv0V2IHIQOmg+A6yCYkqlezzmOq9Jbv+L
 UQgul/mvwnpZoEFdRlkQ2Aeh17rQ7FubQrwz2ppf+drVBI3H5CF+5PAUyGWjDaQjg8
 ME2D/EEKYTupKlFNe1ItdGiFLm3vutK3MigY52kLuX7eWzqx5vSZbQDCC4iSCRUhlh
 roYLUpNxwCPjBg9cSsE/rG8zxwJbtjEuPqV1T/4N5prVILour6WP/MaQ6E45bsCxt7
 srM55V5z1tZeODfQR3P+HWjZhbSi3ckWnoKDhdvqqwVWGVpOax1wN5PmYjOWLZEUfF
 S/EdRxFKTDXYA==
Message-ID: <sashiko-outbox-169295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/7] bus: mhi: Load DDR training data using device
 serial number
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-5-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-5-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:00:56 +0000
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
- [High] mhi/sahara: UAF due to missing cancel_work_sync(read_data_work)
--

commit db3ce9303033a085ebf1250fe283d48253b7c50d
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Load DDR training data using device serial number

Extend the firmware loading logic for the DDR training image to first
attempt loading a per-device image dervied from the device serial number.
If the serial-specific image is not present, fall back to the existing
default image, preserving current behavior. This allows reuse of previously
generated DDR training data when available.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index a4b3ef197b303..62b9c72e82680 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -58,6 +58,7 @@
>  #define SAHARA_RESET_LENGTH		0x8
>  #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>  #define SAHARA_MEM_READ64_LENGTH	0x18
> +#define SAHARA_DDR_TRAINING_IMG_ID	34
> =20
>  struct sahara_packet {
>  	__le32 cmd;
[ ... ]

[Severity: High]
Does driver teardown miss cancelling the read_data_work?

Looking at sahara_mhi_remove():

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
    ...
	cancel_work_sync(&context->fw_work);
	cancel_work_sync(&context->dump_work);
	vfree(context->mem_dump);
    ...
}

If the MHI device is unbound or hot-unplugged while a Sahara READ_DATA
streaming operation is active, read_data_work can be scheduled or already
running.

Since sahara_mhi_remove() omits cancelling read_data_work, when remove()
returns, the devres framework will automatically free the context structure
allocated via devm_kzalloc().

Can the uncancelled read_data_work then dereference the freed context
structure and cause a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D5
