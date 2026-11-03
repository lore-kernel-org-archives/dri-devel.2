Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44CE606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DErWXgH6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE9510E41A;
	Tue,  3 Nov 2026 07:49:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3C610E41A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:49:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E5D3605CE;
 Tue,  3 Nov 2026 07:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D321F00A02;
 Tue,  3 Nov 2026 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692146;
 bh=X9eTFYS+ZOWgMbuyEJt7JkAFyFy2pdM/+DeTij1TCEM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DErWXgH6TiS4/lT7+45Xmb3oMs6Kn/GsJw5BKqpXj9kxszWwxp5nQj6VZDBM+Si0D
 V/+xSKsgiCKEVkd4yHyNpPMVRqDwLGOPB9GUOxW6w91TsqZV3+enXOcG3BFL0/Tnzg
 purPxS6hyWkeM7y7ZwshuKtEEJeG6eYfjSVn205xNs3U9YkhGmO/ubnD/dX7Qaq8Od
 8mfdOo78lvwmC106P1EcfAveTOZeqM7jccIc336vV05nFWnTBFCYy5ccPn7xiiUAVO
 9dMKBRr0psYSP5kk5yyug4JEXk0edwbjd5GTA7P87zR9cNo9yRVIVM7tN57RYmdBw/
 rCgGjCE9GPXCw==
Message-ID: <sashiko-outbox-194743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 07/13] media: uapi: cec.h: add
 CEC_CAP_HAS_EDID_PRESENT/CEC_LOG_ADDRS_FL_EDID_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <b168e5e844ef01f26cbf5aaba92761823df83ff1.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <b168e5e844ef01f26cbf5aaba92761823df83ff1.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:49:05 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] media: uapi: cec.h: unimplemented EDID capability and flag strip=
ped in core
- [Low] media: uapi: cec.h: missing docs cause broken Sphinx xrefs for EDID=
 macros
--

commit c0670843ed6bd1cba28d00e51e6a79ac904407a7
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: uapi: cec.h: add CEC_CAP_HAS_EDID_PRESENT/CEC_LOG_ADDRS_FL_EDID_PRES=
ENT

This commit adds the CEC_CAP_HAS_EDID_PRESENT capability and the
CEC_LOG_ADDRS_FL_EDID_PRESENT logical address flag to the CEC UAPI header
to indicate if an EDID is present.

> diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
> index fdfc97a6e4ec0..8f7c7a4cb505e 100644
> --- a/include/uapi/linux/cec.h
> +++ b/include/uapi/linux/cec.h
> @@ -325,27 +325,27 @@ static inline int cec_is_unconfigured(__u16 log_add=
r_mask)
>  #define CEC_MODE_FOLLOWER_MSK		0xf0
> =20
>  /* Userspace has to configure the physical address */
> -#define CEC_CAP_PHYS_ADDR	(1 << 0)
> +#define CEC_CAP_PHYS_ADDR		(1 << 0)
>  /* Userspace has to configure the logical addresses */
> -#define CEC_CAP_LOG_ADDRS	(1 << 1)
> +#define CEC_CAP_LOG_ADDRS		(1 << 1)
>  /* Userspace can transmit messages (and thus become follower as well) */
> -#define CEC_CAP_TRANSMIT	(1 << 2)
> -/*
> - * Passthrough all messages instead of processing them.
> - */
> -#define CEC_CAP_PASSTHROUGH	(1 << 3)
> +#define CEC_CAP_TRANSMIT		(1 << 2)
> +/* Passthrough all messages instead of processing them. */
> +#define CEC_CAP_PASSTHROUGH		(1 << 3)
>  /* Supports remote control */
> -#define CEC_CAP_RC		(1 << 4)
> +#define CEC_CAP_RC			(1 << 4)
>  /* Hardware can monitor all messages, not just directed and broadcast. */
> -#define CEC_CAP_MONITOR_ALL	(1 << 5)
> +#define CEC_CAP_MONITOR_ALL		(1 << 5)
>  /* Hardware can use CEC only if the HDMI HPD pin is high. */
> -#define CEC_CAP_NEEDS_HPD	(1 << 6)
> +#define CEC_CAP_NEEDS_HPD		(1 << 6)
>  /* Hardware can monitor CEC pin transitions */
> -#define CEC_CAP_MONITOR_PIN	(1 << 7)
> +#define CEC_CAP_MONITOR_PIN		(1 << 7)
>  /* CEC_ADAP_G_CONNECTOR_INFO is available */
> -#define CEC_CAP_CONNECTOR_INFO	(1 << 8)
> +#define CEC_CAP_CONNECTOR_INFO		(1 << 8)
>  /* CEC_MSG_FL_REPLY_VENDOR_ID is available */
> -#define CEC_CAP_REPLY_VENDOR_ID	(1 << 9)
> +#define CEC_CAP_REPLY_VENDOR_ID		(1 << 9)
> +/* CEC_LOG_ADDRS_FL_EDID_PRESENT is available */
> +#define CEC_CAP_HAS_EDID_PRESENT	(1 << 10)

[Severity: Low]
Does adding CEC_CAP_HAS_EDID_PRESENT and CEC_LOG_ADDRS_FL_EDID_PRESENT
without corresponding documentation entries introduce broken Sphinx
cross-reference warnings during make htmldocs?

Documentation/userspace-api/media/cec/cec-header.rst includes
include/uapi/linux/cec.h using the kernel-include directive:

.. kernel-include:: include/uapi/linux/cec.h
    :generate-cross-refs:
    :exception-file: cec.h.rst.exceptions
    :toc:
    :warn-broken:

ParseDataStructs.parse_file() in
tools/lib/python/kdoc/parse_data_structs.py generates :ref:
cross-references for every #define macro in include/uapi/linux/cec.h
unless the symbol is listed in
Documentation/userspace-api/media/cec/cec.h.rst.exceptions.

Because CEC_CAP_HAS_EDID_PRESENT and CEC_LOG_ADDRS_FL_EDID_PRESENT are not
documented in Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
and Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst,
check_missing_refs() in Documentation/sphinx/kernel_include.py reports
unresolved references for std:ref:cec-cap-has-edid-present and
std:ref:cec-log-addrs-fl-edid-present.

>  /**
>   * struct cec_caps - CEC capabilities structure.
> @@ -405,6 +405,8 @@ struct cec_log_addrs {
>  #define CEC_LOG_ADDRS_FL_CDC_ONLY		(1 << 2)
>  /* Configuration failed */
>  #define CEC_LOG_ADDRS_FL_CONFIG_FAILED		(1 << 3)
> +/* EDID is present */
> +#define CEC_LOG_ADDRS_FL_EDID_PRESENT		(1 << 4)

[Severity: Medium]
How are CEC_CAP_HAS_EDID_PRESENT and CEC_LOG_ADDRS_FL_EDID_PRESENT
intended to be used when neither is referenced in the kernel and
cec_adap_s_log_addrs() strips the flag?

When userspace calls ioctl(fd, CEC_ADAP_S_LOG_ADDRS, &log_addrs),
drivers/media/cec/core/cec-api.c:cec_adap_s_log_addrs() masks out
CEC_LOG_ADDRS_FL_EDID_PRESENT before calling __cec_s_log_addrs():

	log_addrs.flags &=3D CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK |
			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
			   CEC_LOG_ADDRS_FL_CDC_ONLY;

In addition, __cec_s_log_addrs() in drivers/media/cec/core/cec-adap.c
overwrites adap->log_addrs =3D *log_addrs without setting or preserving
CEC_LOG_ADDRS_FL_EDID_PRESENT, and no core or driver code sets
CEC_CAP_HAS_EDID_PRESENT in adap->capabilities.

Should the in-kernel implementation in drivers/media/cec/ accompany these
UAPI definitions so that the flag is not silently cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b168e5e844ef01f26cb=
f5aaba92761823df83ff1.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
