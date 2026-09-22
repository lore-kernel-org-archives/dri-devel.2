Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAB1C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EFF10E794;
	Tue, 22 Sep 2026 22:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cxIQn71f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1621010E794
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 22:46:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8DF843AF6;
 Tue, 22 Sep 2026 22:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7231F000FF;
 Tue, 22 Sep 2026 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790117164;
 bh=N91YSurPD95F0cDICwqHe+oD8s0WNoERenfrok1sZcQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cxIQn71fBfI2NMnpJJkJs0uX1jucBNVMqpJvmnvx5f8oHwCzjT02QJ7nk+wjagFg4
 HsDpxy47lN3w5hoJ9wlkCF8+1plh2O3GU6d5LOksuWSJvg1Kqt3F5cMVqYyr4Zhg3C
 AoWpqSb4rNCMgFcjmsitRRwy6whVZoOCM6GgdYcf5NG6UlXXPSDmRcu0epzVaDIW7o
 3v3GvFIzKAAIdyncjrAqroHGbuIyJxRf1DcBgWeWnVpkHBxE8hFEeE6DrYj3p3zlfe
 5pejmTp8zVyfe648oDvq2W2iP6nvcI7OKjk9OvULdkR4ZgrNsnQCApssVqpen+GY+7
 NI/mi77RzV6Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: Don't fail probe when the SDSP memory
 assign fails
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
References: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 22:46:04 +0000
Message-Id: <20260922224604.9C7231F000FF@smtp.kernel.org>
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
- [High] misc: fastrpc: overly broad error suppression for qcom_scm_assign_=
mem
--

commit 14fb4cbe62a25ea5813ad10df366839d89bc56bf
Author: David Heidelberg <david@ixit.cz>

misc: fastrpc: Don't fail probe when the SDSP memory assign fails

This commit modifies the SDSP domain initialization in fastrpc_rpmsg_probe()
to warn rather than fail when qcom_scm_assign_mem() returns an error. The
intent is to prevent an endless probe failure loop when a subsystem restart
triggers a secondary memory assignment attempt.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..41943a3d496af 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2595,7 +2595,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
>  				    data->vmperms, data->vmcount);
>  			if (err)
> -				goto err_free_data;
> +				dev_warn(rdev,
> +					 "assign memory to SDSP failed: %d\n",
> +					 err);

[Severity: High]
Does unconditionally bypassing this error risk breaking DSP execution under
different failure conditions?

If a legitimate failure occurs in qcom_scm_assign_mem() (such as -ENOMEM
during SCM communication, rather than an -EINVAL from a redundant
assignment), the memory region remains unassigned to the DSP. When the DSP
subsequently attempts to access that memory, wouldn't it trigger a fatal
SMMU fault and crash the remote processor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-fastrpc-fa=
il-slow-v1-1-f3f6fabba6e3@ixit.cz?part=3D1
