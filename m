Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8FDCA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667CC10F16E;
	Wed, 30 Sep 2026 03:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bCslFerg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730DE10F16E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:56:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31D1240ABB;
 Wed, 30 Sep 2026 03:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84041F000FF;
 Wed, 30 Sep 2026 03:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740564;
 bh=pPAByAKgEnjW4rqDpmyFPOXmky3w2FCNKAmoTmnHRWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bCslFergEUUI85Ux61X4WNvXz90w/R5ZzrUCm7q4jPQL8PIohU1/n6pkET85K1ZOF
 prYzDVOH97gAoxkIBeA0kQRYOMGbHG81scbOEvLbAtOiSBIxIeeIPSSjstmvWOtJPt
 tnolEXeqX87TH+P/vtuWTHxvLojpU5yGyl+FRY77EhchtA+Yz05Bakj9V2Z2pTNY+0
 ZAAVin2Unumlp3AALUG4o61PgjFg/+aQSAwV6o9MI9tisr349H1Ggm1ZTdOvlIckaJ
 hivOGhmYqYWDyioW9pHgA+q1luefxvTWpHjQSSR5Rcne3kk7V//igTv4Yc1ptp25jL
 D2hgzHWSbPmTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 07/20] accel/amdxdna: Add get and set power_mode for
 AIE4
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-8-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-8-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:56:03 +0000
Message-Id: <20260930035603.E84041F000FF@smtp.kernel.org>
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
- [Medium] amdxdna: partition leak in aie4_vf_hw_start() error path
--

commit bc6bbbe04622b7e463790d57007bb4c50fb33683
Author: David Zhang <yidong.zhang@amd.com>

    accel/amdxdna: Add get and set power_mode for AIE4

This commit adds power mode support for AIE4 devices via DRM_AMDXDNA_GET_IN=
FO
and DRM_AMDXDNA_SET_STATE. It implements aie4_set_power_mode() and restores
the cached user power mode override whenever the hardware starts.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index aea3edd51b4f5..d11bdbf168816 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
[ ... ]
> @@ -346,6 +373,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *=
ndev)
>  	if (ret)
>  		goto mailbox_fini;
> =20
> +	ret =3D aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +

[Severity: Medium]
Does this error path leak the firmware hardware partition?

If aie4_restore_power_mode() fails here, we jump directly to the mailbox_fi=
ni
label. This bypasses aie4_partition_fini(), leaving the partition that was
successfully initialized just prior to this call permanently leaked.

>  	return 0;
> =20
>  mailbox_fini:
>  	aie4_mailbox_fini(ndev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D7
