Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCCCC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2316B10EA5C;
	Thu, 17 Sep 2026 07:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="co2D2s0V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC0410E636;
 Thu, 17 Sep 2026 07:38:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9A5060200;
 Thu, 17 Sep 2026 07:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE101F000FF;
 Thu, 17 Sep 2026 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630698;
 bh=c2UNVKSr/QVtorhfnlk/txjQ3lgu4CnqY8mjFGVFZJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=co2D2s0VMLdvRZQWzBUdZ2Eb6IrjffcwzxfcU4CNGK3YBVMbH1e0tKXT+3gyOOEca
 jSEhsRB0OP21rtmNnjMPKhlPextvymOcIreUePuKPUNZ8MB52RnceZ5fKYj94z5yuK
 65uK4rXHF8rLelZnrcrRwwamT9IhlEBdvp2Udm0bUzATjh4RXTwjUY2aeg1u9NH3wJ
 EOIk7IthgaaZu5YsBnpc0ZlDOlnu8dLugpUYxmzILYmhXMvDka9sjy19DE1aX2gsNf
 o/+zJ0Vm7ZF71ixu7YmIVvxMYchpXEQnMLLYD3eKbuBsiR1YMSNnaLmT8CTBO0wKgi
 51aIjec5Rlymw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/28] scsi: bfa: Use snprintf() in
 bfa_fcs_fabric_nsymb_init()
To: "Bill Wendling" <morbo@google.com>
Cc: linux-scsi@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>, intel-xe@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260915081910.4142719-5-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-5-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:38:17 +0000
Message-Id: <20260917073817.CCE101F000FF@smtp.kernel.org>
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
- [Low] scsi: bfa: missing char* cast for host_machine_name causes -Wformat=
 warning
--

commit e9ab2501ca8e083742e7d8a4f33a0d89bbb70aad
Author: Bill Wendling <morbo@google.com>

scsi: bfa: Use snprintf() in bfa_fcs_fabric_nsymb_init()

This commit replaces chained strscpy() and strlcat() calls with a single
snprintf() call when constructing the node symbolic name.

Link: https://github.com/KSPP/linux/issues/370 [1]

> diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
> index 9b57312f43f50..7a4e0e8c7182d 100644
> --- a/drivers/scsi/bfa/bfa_fcs.c
> +++ b/drivers/scsi/bfa/bfa_fcs.c
[ ... ]
> @@ -821,30 +821,13 @@ bfa_fcs_fabric_nsymb_init(struct bfa_fcs_fabric_s *=
fabric)
[ ... ]
> -	/* null terminate */
> -	port_cfg->node_sym_name.symname[BFA_SYMNAME_MAXLEN - 1] =3D 0;
> +	/* Model name/number, Driver Version, Host machine name */
> +	snprintf(port_cfg->node_sym_name.symname, BFA_SYMNAME_MAXLEN,
> +		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
> +		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
> +		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR,
> +		 model, (char *)driver_info->version,
> +		 driver_info->host_machine_name);

[Severity: Low]
Does this missing cast create a -Wformat compiler warning?

Looking at bfa_fcs_fabric_nsymb_init(), host_machine_name is passed to the
%s format specifier without an explicit (char *) cast, while version on the
preceding line includes one.

Does this cause a type mismatch warning since host_machine_name is an
unsigned char array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915081910.4142=
719-1-morbo@google.com?part=3D4
