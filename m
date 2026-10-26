Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B574606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+RxFM7/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCE810E138;
	Mon, 26 Oct 2026 10:24:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B745110E1CC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:24:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D751B60A53;
 Mon, 26 Oct 2026 10:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF781F01825;
 Mon, 26 Oct 2026 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793010267;
 bh=fFrqcUXqY0vLdbx38h53LjA++EYTfuWPMW99sIDZ9i4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=e+RxFM7/BhCa8BXgx4GDchiQ09AwNsWTswoK8kQMYc3eNeCCF2K/26xtmZ93/aHrg
 ZFP44nSbCqnpgx7lg1JFrT6szhAvGBjMLik9v3jBYn1tRZQp44wib/GGJTtFQ1kukq
 DAL5GbUg5ad2BPc6XCSANoUXczeNe3iLi5BnRF0TB0S9/AtBk2uhWoTf/VHaO3HYri
 MtjK2KdVVpqBJTM7ygXjYqbJcGq+6z2SqshH1On3QF7kq1ZGk/il1tVFyqRPwPL0Mk
 6Uheso2XkG3/r+eG21njovjenbWB2FiT5HgTkdRMHZkGGFGK1jSkh9ExZb2BtPyUJ5
 a7fQ8V8fiE7Hg==
Message-ID: <sashiko-outbox-184934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Read preemption buffer size from boot params
To: "Andrzej Kacprowski" <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261026093020.228233-1-andrzej.kacprowski@linux.intel.com>
References: <20261026093020.228233-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:24:27 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel/ivpu: ivpu_preemption_config_parse() rejects zero secondar=
y buffer size
--

commit e2bae997f3bdfe346d64fb0ce52874d7284d8b32
Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

accel/ivpu: Read preemption buffer size from boot params

This commit updates the ivpu driver to read the preemption buffer size from
the firmware boot parameters after cold boot during device initialization,
falling back to the sizes in the firmware image header if not reported. It
also updates the image header parsing logic to use
preemption_buffer_2_max_size even when it is zero if
preemption_buffer_1_max_size is set, and updates the firmware boot API head=
er
to version 3.39.1.

> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 96f5be23a8673..6607a5da19340 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
[ ... ]
> @@ -160,35 +165,31 @@ ivpu_fw_sched_mode_select(struct ivpu_device *vdev)
>  static void
>  ivpu_preemption_config_parse(struct ivpu_device *vdev, const struct vpu_=
firmware_header *fw_hdr)
>  {
> -	struct ivpu_fw_info *fw =3D vdev->fw;
>  	u32 primary_preempt_buf_size, secondary_preempt_buf_size;
> =20
> -	if (fw_hdr->preemption_buffer_1_max_size)
> +	if (fw_hdr->preemption_buffer_1_max_size) {
>  		primary_preempt_buf_size =3D fw_hdr->preemption_buffer_1_max_size;
> -	else
> -		primary_preempt_buf_size =3D fw_hdr->preemption_buffer_1_size;
> -
> -	if (fw_hdr->preemption_buffer_2_max_size)
>  		secondary_preempt_buf_size =3D fw_hdr->preemption_buffer_2_max_size;
> -	else
> +	} else {
> +		primary_preempt_buf_size =3D fw_hdr->preemption_buffer_1_size;
>  		secondary_preempt_buf_size =3D fw_hdr->preemption_buffer_2_size;
> -
> -	ivpu_dbg(vdev, FW_BOOT, "Preemption buffer size, primary: %u, secondary=
: %u\n",
> -		 primary_preempt_buf_size, secondary_preempt_buf_size);
> +	}
> =20
>  	if (primary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE ||
>  	    secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE) {
> -		ivpu_warn(vdev, "Preemption buffers size too small\n");
> +		ivpu_warn(vdev, "Preemption buffers size too small, primary %u, second=
ary %u\n",
> +			  primary_preempt_buf_size, secondary_preempt_buf_size);
>  		return;
>  	}

[Severity: Medium]
When fw_hdr->preemption_buffer_1_max_size is non-zero and
fw_hdr->preemption_buffer_2_max_size is 0, won't the
secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE check in
ivpu_preemption_config_parse() in drivers/accel/ivpu/ivpu_fw.c always trigg=
er
a warning and return early?

The commit message notes that when preemption_buffer_1_max_size is set in t=
he
image header, preemption_buffer_2_max_size should be used even if it is zer=
o,
and ivpu_preemption_buffers_create() in drivers/accel/ivpu/ivpu_job.c is
updated to handle vdev->fw->secondary_preempt_buf_size =3D=3D 0.

However, during ivpu_dev_init() -> ivpu_fw_init() -> ivpu_fw_parse() ->
ivpu_preemption_config_parse(), if secondary_preempt_buf_size is 0, checking
secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE (where
FW_PREEMPT_BUF_MIN_SIZE is SZ_4K) evaluates to true and returns before
reaching:

	vdev->fw->primary_preempt_buf_size =3D ALIGN(primary_preempt_buf_size, PAG=
E_SIZE);
	vdev->fw->secondary_preempt_buf_size =3D ALIGN(secondary_preempt_buf_size,=
 PAGE_SIZE);

For firmware that relies on the image header sizes
(boot_params->preemption_buffer_size =3D=3D 0) with
preemption_buffer_1_max_size > 0 and preemption_buffer_2_max_size =3D=3D 0,
vdev->fw->primary_preempt_buf_size remains 0, ivpu_fw_postboot_init() warns
that hardware scheduling has no preemption buffer, and
ivpu_preemption_buffers_create() skips allocating the primary preemption
buffer.

In addition, on newer firmware where the deprecated image header preemption
buffer fields are zeroed in favor of boot_params->preemption_buffer_size,
won't ivpu_preemption_config_parse() also emit a false-positive warning on
every probe before the boot params are read in ivpu_fw_postboot_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026093020.2282=
33-1-andrzej.kacprowski@linux.intel.com?part=3D1
