Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A2CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88F310E1F0;
	Fri,  9 Oct 2026 23:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kegmyvYr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CDC10E1F0
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:08:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F9E9434DC;
 Fri,  9 Oct 2026 23:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29821F000FF;
 Fri,  9 Oct 2026 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587301;
 bh=hBTKZD3HeJyVodX7qLY7GjxRbIgnBjqwBP7cw9HdNmU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kegmyvYryuZVJPmg9DH1YuXLioAq3L/WPhGo4VFJ5ZYutYapE6N+pB+i9mGspPsxf
 /nTN46ac0z+qDOs+vfMEEw2S2/FxySSfBlYBVmvsiG+zUqM5bzqQaCUHLg2fdEfuSR
 +dH1hOQt99edZXtBEYlEybGH2Wd6jSTlkm57v5Mb8R2ieyYEevnUI/KR+SwQyNFgQ1
 wIskTAb+8yrlHnheIojcwjKXjludOgwchjUDM6RfTGhskh0ei+6pk7XUy+ifymdr49
 QdetDJYRYUquLSO0s7/SIBhft4YzeXsoh5UgVvpEUhZxVtX6bbhQNE6SQYXVi6wrUv
 lky0rCF0PPlGA==
Message-ID: <sashiko-outbox-166174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 04/19] accel/amdxdna: Support firmware 6.0
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-5-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:08:21 +0000
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
- [Medium] accel/amdxdna: missing capability check for REALTIME priority al=
lows DoS
--

commit 33aba925e30324fed055cc90f6f20b1a9826f931
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Support firmware 6.0

This commit supports firmware interface version 6.0 by updating the host qu=
eue
layout, opcode definitions, and context creation/destruction request struct=
ures.
It also parses priority band and PASID for hardware context creation.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 8157f2a6fd10a..5eb918e1d58c7 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -110,6 +111,22 @@ static int aie4_msg_destroy_context(struct amdxdna_d=
ev_hdl *ndev, u32 hw_context
>  	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>  }
> =20
> +static u8 aie4_parse_priority_to_dev(u32 priority)
> +{
> +	switch (priority) {
> +	case AMDXDNA_QOS_LOW_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_IDLE;
> +	case AMDXDNA_QOS_NORMAL_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
> +	case AMDXDNA_QOS_HIGH_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_FOCUS;
> +	case AMDXDNA_QOS_REALTIME_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME;

[Severity: Medium]
Could this allow an unprivileged user to monopolize the NPU?

In aie4_parse_priority_to_dev() in drivers/accel/amdxdna/aie4_ctx.c, when a
user calls the AMDXDNA_CREATE_HWCTX ioctl and passes
AMDXDNA_QOS_REALTIME_PRIORITY in qos.priority, this maps directly to
AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME during context creation and is sent to
the firmware.

Since there doesn't appear to be a capability check (such as verifying if t=
he
caller possesses CAP_SYS_NICE or similar privileges), could any local user
with access to the DRM node create an NPU hardware context with REALTIME
priority and starve other workloads, causing a denial of service?

> +	default:
> +		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D4
