Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D1606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdZhwXuX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9891C10E198;
	Tue,  3 Nov 2026 07:48:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023FF10E198
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:48:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F2F14125A;
 Tue,  3 Nov 2026 07:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A101F0093A;
 Tue,  3 Nov 2026 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692083;
 bh=TzqscQ8IDu+orc/LnT3MM4JW9Fnf/G93CRX8BQ+juoY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gdZhwXuXuvD6+1dpLeYyS4tUB/nqGjZmboXqwcI0wnHCBiSNZ3FNK4yqk5IaJhekP
 uX0ofOXo6hEXjWt19EEeBGOl0zMKa2jx09jrHW8Dk7ninpLFRweKWpg3gnr3IjgtRr
 pD8qUmblPDOPayi56UJWp8h9L5CCirL6bJMmInDC+DpUCCyFpRnxRgNAuymq350+Pp
 jKbw4z5R6rj90lluemHwdAn1SlHZEbwzcQhOw0RAFBonqGvfbFYzIuIwkaerLG6dab
 HeR6RBhbHLr8/kkvev3ugEEpmJY7lXfGt9ivfiFl+0AGrgvc4x7+NajW9vk1o7j5Om
 JkdS/ntY8/tPA==
Message-ID: <sashiko-outbox-194738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 08/13] Documentation: media: document EDID_PRESENT cap
 and flag.
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <15ac30e0ab50507dec1dffd0e189887b8b9f5b09.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <15ac30e0ab50507dec1dffd0e189887b8b9f5b09.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:48:02 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] media: cec: docs reference undefined EDID_PRESENT uAPI macros
--

commit f17e523f5d883fb22430ec312846ab21144fc8d7
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

Documentation: media: document EDID_PRESENT cap and flag.

This commit adds documentation for the CEC_CAP_HAS_EDID_PRESENT capability
and the CEC_LOG_ADDRS_FL_EDID_PRESENT flag to the CEC uAPI documentation.

> diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rs=
t b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> index 1d5248979a6da..abd62ac64541b 100644
> --- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> +++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> @@ -143,6 +143,15 @@ returns the information to the application. The ioct=
l never fails.
>        - 0x00000200
>        - If this capability is set, then
>          :ref:`CEC_MSG_FL_REPLY_VENDOR_ID <cec-msg-flags>` can be used.
> +    * .. _`CEC-CAP-HAS-EDID-PRESENT`:
> +
> +      - ``CEC_CAP_HAS_EDID_PRESENT``
> +      - 0x00000400
> +      - If this capability is set, then
> +        :ref:`CEC_LOG_ADDRS_FL_EDID_PRESENT <cec-log-addrs-flags>` is va=
lid.
> +	This makes it possible to tell apart the case where the Physical Address
> +	is f.f.f.f because no EDID is present, and the case where it is f.f.f.f
> +	because the EDID does not provide a valid Physical Address.
> =20
>  Return Value
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-add=
rs.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> index 8397bf5737988..2088793b1506c 100644
> --- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> +++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> @@ -192,6 +192,15 @@ logical address types are already defined will retur=
n with error ``EBUSY``.
>        - If this flag is set, then the CEC device failed to claim a free =
logical
>          address and is in the unconfigured state. This can never happen =
if
>  	``CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK`` was set as well.
> +    * .. _`CEC-LOG-ADDRS-FL-EDID-PRESENT`:
> +
> +      - ``CEC_LOG_ADDRS_FL_EDID_PRESENT``
> +      - 16
> +      - If this flag is set, then an EDID is present. This helps tell ap=
art the
> +        case where the Physical Address is f.f.f.f because no EDID is pr=
esent,
> +	and the case where it is f.f.f.f because the EDID does not provide a
> +	valid Physical Address. This flag can only be used if
> +	``CEC_CAP_HAS_EDID_PRESENT`` is set in the adapter capabilities.

[Severity: Medium]
Are the corresponding uAPI definitions and kernel implementation for
CEC_CAP_HAS_EDID_PRESENT and CEC_LOG_ADDRS_FL_EDID_PRESENT missing from the
tree?

In include/uapi/linux/cec.h, the capability definitions currently stop at
CEC_CAP_REPLY_VENDOR_ID:

    /* CEC_ADAP_G_CONNECTOR_INFO is available */
    #define CEC_CAP_CONNECTOR_INFO	(1 << 8)
    /* CEC_MSG_FL_REPLY_VENDOR_ID is available */
    #define CEC_CAP_REPLY_VENDOR_ID	(1 << 9)

And the struct cec_log_addrs flag definitions stop at
CEC_LOG_ADDRS_FL_CONFIG_FAILED:

    /* CDC-Only device: supports only CDC messages */
    #define CEC_LOG_ADDRS_FL_CDC_ONLY		(1 << 2)
    /* Configuration failed */
    #define CEC_LOG_ADDRS_FL_CONFIG_FAILED		(1 << 3)

Neither symbol appears to be defined in include/uapi/linux/cec.h or handled
anywhere in drivers/media/cec/ (where cec-api.c still masks log_addrs.flags
to CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK | CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTH=
RU
| CEC_LOG_ADDRS_FL_CDC_ONLY). Because
Documentation/userspace-api/media/cec/cec-header.rst also parses
include/uapi/linux/cec.h to generate cross-references, the generated header
documentation is out of sync with these ioctl pages.

Also, in Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst,
should the description clarify whether CEC_LOG_ADDRS_FL_EDID_PRESENT is a
read-only flag set by the driver or accepted by CEC_ADAP_S_LOG_ADDRS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/15ac30e0ab50507dec1=
dffd0e189887b8b9f5b09.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
