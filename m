Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAE606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLefc02O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B892110E373;
	Thu, 26 Nov 2026 13:27:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B7910E126;
 Thu, 26 Nov 2026 13:27:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E488561200;
 Thu, 26 Nov 2026 13:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF281F000C4;
 Thu, 26 Nov 2026 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795699642;
 bh=Ohrms76jeGK6AtQd2ZLMSb0Str+I2sSxoQRU8jPpcpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MLefc02OLa+DvTQPhJ89IDECTYWEA38cpLvaLOnEiv+R28f74IyU3QMLuQ9Qs/uP3
 7tRofNe2jFTgeOXRmw6QH4eRhAPe2moukAeOtG3leaOcIxrttOv/3KpDX0q7AZLEIS
 hrGWTGNIpqsVqv0E5+94ZnM+q+0T+xrLGRTBmKhrkdpg2b3Oef1eJ5d/W6bD/GaPDy
 /LrTILq/8yPcDQ1IFCnpZ0NxoAGQ400e3ZYjt49PypYSq0k4QAt9jzKsG7+ES0Diso
 u+UkkImRtLHnOJ1aX+xAxh5kgJVusxDjiMm02YsdJlNSpxcsy5LLvohtsofXrYwRJN
 357MZ9MBEcvNQ==
Message-ID: <sashiko-outbox-235597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/xe/gt: Log LMTT init failure and block VF
 operations
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261126131441.1734445-1-yaolu@kylinos.cn>
References: <20261119095003.reakox5n3mhp5utx@intel.com>
 <20261126131441.1734445-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:27:21 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/xe/pf: NULL deref in xe_lmtt_page_size() via unguarded
  debugfs paths
--

commit 2b2063f5a4b0e6ca91307ed198eee693dd8674d9
Author: Lu Yao <yaolu@kylinos.cn>

drm/xe/gt: Log LMTT init failure and block VF operations

This commit logs an error when xe_lmtt_init() fails during GT initialization
while keeping the PF alive, and adds a readiness check in
xe_sriov_pf_wait_ready() to reject subsequent VF operations when the LMTT
is uninitialized.

Link: https://lore.kernel.org/dri-devel/20261119095003.reakox5n3mhp5utx@int=
el.com/

> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c b/drivers/gpu/drm/xe/xe_sri=
ov_pf.c
> index 33bd754d138fa..2122964610a0f 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_pf.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
[ ... ]
> @@ -143,6 +145,18 @@ int xe_sriov_pf_init_late(struct xe_device *xe)
>  	return 0;
>  }
> =20
> +static int pf_check_lmtt(struct xe_device *xe)
> +{
> +	struct xe_tile *tile;
> +	unsigned int id;
> +
> +	for_each_tile(tile, xe, id)
> +		if (!xe_lmtt_is_ready(&tile->sriov.pf.lmtt))
> +			return -ENODEV;
> +
> +	return 0;
> +}
> +
>  /**
>   * xe_sriov_pf_wait_ready() - Wait until PF is ready to operate.
>   * @xe: the &xe_device to test
> @@ -160,6 +174,10 @@ int xe_sriov_pf_wait_ready(struct xe_device *xe)
>  	if (xe_device_wedged(xe))
>  		return -ECANCELED;
> =20
> +	err =3D pf_check_lmtt(xe);
> +	if (err)
> +		return err;

[Severity: Medium]
Can PF-side VF debugfs handlers still reach the uninitialized LMTT and
dereference a NULL lmtt->ops pointer when xe_lmtt_init() fails?

When xe_lmtt_init() fails, it clears lmtt->ops and leaves lmtt->pd NULL,
while gt_init_lmtt() lets probe complete and register SR-IOV debugfs files.
Not all PF-side VF debugfs entry points call xe_sriov_pf_wait_ready().  For
example, writing a KLV blob containing GUC_KLV_VF_CFG_LMEM_SIZE_KEY to
config_blob runs config_blob_write() -> xe_gt_sriov_pf_config_restore() ->
pf_restore_vf_config_klv() -> pf_provision_vf_lmem() ->
pf_get_lmem_alignment() -> xe_lmtt_page_size(), which hits
lmtt_assert(lmtt, lmtt->ops) and dereferences lmtt->ops in
lmtt_page_size().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126131441.1734=
445-1-yaolu@kylinos.cn?part=3D1
