Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF07C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC1210EA1E;
	Thu, 17 Sep 2026 07:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJ/BQ/NP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F423810E63E;
 Thu, 17 Sep 2026 07:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7596560214;
 Thu, 17 Sep 2026 07:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE641F000FF;
 Thu, 17 Sep 2026 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630701;
 bh=lnGfQY8Xs9RlDryJ4M//TkXaa4QDVImLaZ10YCdrY24=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJ/BQ/NPjIN3JrZNSBQNeAXhOVHuGeS/zWAUQhzsBnuVwcdROF6VVwWse6Xm01o2g
 jORPyqw7zuuAp8fXKgSQshuljxIeWAWvqJOR17i2G11QI37Xbd2U9lMBPzcG43vfN5
 pbelXZJRUFn9LbeKKfx9oguP0W793yU9FaVPAiC8q/CH/mA3SSh96gg+xHbH9vp/w9
 oApXLh++FYigm521Wklu8i3z6N0pY33Zj5TA91QsKxbzMnAmUPcZozM24JSPk3YBti
 QtAnYatGygl45jOhPwAyjpzFCfGsKMn/xjYunHSn9u5WzO/sDGeXu67x/kF61m21Ru
 KBtWI0Tcyegyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/28] devlink: Refactor strlcat() to seq_buf in
 __devlink_compat_running_version()
To: "Bill Wendling" <morbo@google.com>
Cc: "Anna Schumaker" <anna@kernel.org>, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, "Chuck
 Lever" <cel@kernel.org>, linux-scsi@vger.kernel.org, media-ci@linuxtv.org,
 robh@kernel.org, linux-input@vger.kernel.org, intel-xe@lists.freedesktop.org,
 conor+dt@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20260915081910.4142719-9-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-9-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:38:20 +0000
Message-Id: <20260917073820.7DE641F000FF@smtp.kernel.org>
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
- [Medium] devlink: data truncation in ethtool fw_version due to seq_buf_in=
it()
--

commit 211bb0968eb0ca01b66de46e1d8900c3f0f30b64
Author: Bill Wendling <morbo@google.com>

devlink: Refactor strlcat() to seq_buf in __devlink_compat_running_version()

This commit replaces the deprecated strlcat() API in
__devlink_compat_running_version() with struct seq_buf and seq_buf_printf()
to append running firmware version strings.

Link: https://github.com/KSPP/linux/issues/370 [1]

> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> index 55959b0ff5ab4..987b071345c41 100644
> --- a/net/devlink/dev.c
> +++ b/net/devlink/dev.c
[ ... ]
> @@ -1202,6 +1204,9 @@ static void __devlink_compat_running_version(struct=
 devlink *devlink,
>  	if (err)
>  		goto free_msg;
> =20
> +	seq_buf_init(&s, buf, len);
> +	s.len =3D strnlen(buf, len);

[Severity: Medium]
Does this code inadvertently erase the existing contents of buf?

Looking at seq_buf_init(), it internally calls seq_buf_clear() which
unconditionally sets the first byte of the buffer to a NUL character. As a
result, the subsequent strnlen(buf, len) call will always evaluate to 0.

Since __devlink_compat_running_version() is meant to append devlink info to
the buffer, wouldn't erasing it here lose the driver's native fw_version
string that was previously populated by the driver's get_drvinfo() callback?

This could cause userspace applications calling ETHTOOL_GDRVINFO to receive
only the devlink info instead of the expected concatenated native and devli=
nk
version string.

>  	nla_for_each_attr_type(nlattr, DEVLINK_ATTR_INFO_VERSION_RUNNING,
>  			       (void *)msg->data, msg->len, rem) {
>  		const struct nlattr *kv;
> @@ -1209,8 +1214,7 @@ static void __devlink_compat_running_version(struct=
 devlink *devlink,
> =20
>  		nla_for_each_nested_type(kv, DEVLINK_ATTR_INFO_VERSION_VALUE,
>  					 nlattr, rem_kv) {
> -			strlcat(buf, nla_data(kv), len);
> -			strlcat(buf, " ", len);
> +			seq_buf_printf(&s, "%s ", (const char *)nla_data(kv));
>  		}
>  	}
>  free_msg:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915081910.4142=
719-1-morbo@google.com?part=3D8
