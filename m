Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27EACA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC8110EFF0;
	Tue, 29 Sep 2026 18:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i5vRyVdY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D85A10EFF0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:04:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BD2E6022C;
 Tue, 29 Sep 2026 18:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121351F000FF;
 Tue, 29 Sep 2026 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790705052;
 bh=yN1shHx0QPd+3m3KQ0A2Ymyz4ztFozvuSjWUzrq4cgs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i5vRyVdYXPog+jDmsrtmuYl21K0tIkvLBQO1N+D+lXwR3kRLR7Uw/V0kLw2gm3rY/
 rj4vzPYnvn3a2H6ArBMkMUgJ/8AeJ532AkRDCDoP2N9BrVX/chNzEx407M+Oidyguk
 4QOiJI2Q+b6FJxjK4/5A7Oh5bMQXToBhJQykRfLetxfmiGH9tAeRYuEKPDTf+2Lylh
 aiYHzAQ0NFxWoyx5XtDCwTXnkvzFSZZ9yJeaBLFhJEaN0tohU21SA5punbxEZKsAy6
 g1qs/wtFivYuqubnUKmLKyeljJ/Z81JNaRkGBvDyIIbU9W1mtQuOrmRbZ/16Q5REK8
 /7ekeJIta/XCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Add support for AIE2 revision 9
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929175428.925657-1-lizhi.hou@amd.com>
References: <20260929175428.925657-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 18:04:11 +0000
Message-Id: <20260929180412.121351F000FF@smtp.kernel.org>
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
- [Medium] amdxdna: missing sysfs string mapping for AIE2_DEV_REVISION_GRGH
--

commit b3b57d80604172a34fe04c44b6e2dfb08e2fd5da
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Add support for AIE2 revision 9

This commit adds AIE2_DEV_REVISION_GRGH to the list of supported AIE2
revisions so aie2_get_dev_revision() can recognize AIE2 revision 9 hardware.

> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdn=
a/aie2_msg_priv.h
> index fd65a4236d491..8ed2b5701dcc2 100644
> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
> @@ -530,6 +530,7 @@ enum aie2_dev_revision {
>  	AIE2_DEV_REVISION_GPT1,
>  	AIE2_DEV_REVISION_GPT2,
>  	AIE2_DEV_REVISION_GPT3,
> +	AIE2_DEV_REVISION_GRGH,

[Severity: Medium]
Does AIE2_DEV_REVISION_GRGH also need to be added to the npu4_rev_vbnv_tbl
mapping array?

drivers/accel/amdxdna/npu4_regs.c:npu4_rev_vbnv_tbl[] {
	...
	{ AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
	{ AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
	{ 0 }
};

If it is omitted, when the sysfs 'vbnv' node is accessed for GRGH devices,
amdxdna_update_vbnv() fails to find a matching entry. This causes the driver
to fall back to a generic default string ('RyzenAI-npu4'), exposing an
inaccurate or missing specific board name to userspace.

>  	AIE2_DEV_REVISION_UNKN,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929175428.9256=
57-1-lizhi.hou@amd.com?part=3D1
