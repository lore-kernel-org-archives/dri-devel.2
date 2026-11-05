Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93614606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8h/4HAI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13B11121A5;
	Thu,  5 Nov 2026 07:34:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3421C1121AA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:34:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E00B40349;
 Thu,  5 Nov 2026 07:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD71F000C1;
 Thu,  5 Nov 2026 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864077;
 bh=xIS9lfPJHIVnFPYKML9yw7L7r/0JqSs3RFgcHivuyKg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h8h/4HAIlzRhXLMTpAxxF8vqv6gwPF9s7q4iHqGdIvj+qy82azTorBQSsbK29TnDe
 MSf+m0D4AK3ox0r/aJqjI4l5tYAdAIaI51LUtbccII2J05UwY5Ut2NcSPLZA/q8ogF
 U6T0bi8OKaM8GP8FXK4XMwZPHxHmOtzveQZMDosSa2cDnRjgnwQoFr2AAmM5lU4DXw
 GtrUWPEMnxr8GwDNuaqhQGv6xhkLJL8Anu43M8xQef0eNPP/pHv2SlpI4XiW+8IZuT
 p2F8ga/POggzKIxTgdmXCzfW/suM10zAFwgVaKCYkPRlZh1xNWosYRlFg/3aCaQAak
 WTkmupSNAo3BA==
Message-ID: <sashiko-outbox-198681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 08/13] Documentation: media: document HPD_PRESENT cap
 and flag.
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <e98308c0db382c09ce698b34ca54f798ab0e3557.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <e98308c0db382c09ce698b34ca54f798ab0e3557.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:34:36 +0000
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
- [Medium] media: cec: docs: CEC_CAP_HAS_HPD_PRESENT and flag missing from =
uAPI header
- [Low] media: cec: docs: malformed rST indentation in CEC_LOG_ADDRS_FL_HPD=
_PRESENT
--

commit 53c76b7e379d8741e299203dcf5382f4b9c83f39
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

Documentation: media: document HPD_PRESENT cap and flag.

This commit documents the CEC_CAP_HAS_HPD_PRESENT capability and the
CEC_LOG_ADDRS_FL_HPD_PRESENT logical address flag in the CEC userspace API
documentation.

> diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rs=
t b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> index 1d5248979a6da..bf734cbee0dda 100644
> --- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> +++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
> @@ -143,6 +143,16 @@ returns the information to the application. The ioct=
l never fails.
>        - 0x00000200
>        - If this capability is set, then
>          :ref:`CEC_MSG_FL_REPLY_VENDOR_ID <cec-msg-flags>` can be used.
> +    * .. _`CEC-CAP-HAS-HPD-PRESENT`:
> +
> +      - ``CEC_CAP_HAS_HPD_PRESENT``
> +      - 0x00000400
> +      - If this capability is set, then
> +        :ref:`CEC_LOG_ADDRS_FL_HPD_PRESENT <cec-log-addrs-flags>` is val=
id.
> +	This makes it possible to tell apart the case where the Physical Address
> +	is f.f.f.f because no HPD (Hotplug Detect) is present, and the case
> +	where it is f.f.f.f because the EDID does not provide a valid Physical
> +	Address.

[Severity: Medium]
Are CEC_CAP_HAS_HPD_PRESENT and CEC_LOG_ADDRS_FL_HPD_PRESENT missing from
include/uapi/linux/cec.h?

In include/uapi/linux/cec.h, the capability definitions currently end at
CEC_CAP_REPLY_VENDOR_ID:

    /* CEC_MSG_FL_REPLY_VENDOR_ID is available */
    #define CEC_CAP_REPLY_VENDOR_ID	(1 << 9)

and the logical address flags end at CEC_LOG_ADDRS_FL_CONFIG_FAILED:

    /* Configuration failed */
    #define CEC_LOG_ADDRS_FL_CONFIG_FAILED		(1 << 3)

Neither constant appears to be defined in include/uapi/linux/cec.h or used =
in
drivers/media/cec/, so userspace applications consulting this documentation
cannot compile with these flags.

> diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-add=
rs.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> index 8397bf5737988..e37898750ab5d 100644
> --- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> +++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
> @@ -192,6 +192,16 @@ logical address types are already defined will retur=
n with error ``EBUSY``.
>        - If this flag is set, then the CEC device failed to claim a free =
logical
>          address and is in the unconfigured state. This can never happen =
if
>  	``CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK`` was set as well.
> +    * .. _`CEC-LOG-ADDRS-FL-HPD-PRESENT`:
> +
> +      - ``CEC_LOG_ADDRS_FL_HPD_PRESENT``
> +      - 16
> +      - If this flag is set, then the HPD (Hotplug Detect) is present. T=
his
> +	 helps tell apart the case where the Physical Address is f.f.f.f
> +	 because no HPD is present, and the case where it is f.f.f.f because the
> +	 EDID does not provide a valid Physical Address. This flag can only be
> +	 used if ``CEC_CAP_HAS_HPD_PRESENT`` is set in the adapter
> +	 capabilities.

[Severity: Low]
Will Sphinx misparse the CEC_LOG_ADDRS_FL_HPD_PRESENT description as a
definition list when building htmldocs?

The first line of the bullet item starts at column 8 (six spaces, a hyphen,
and a space), whereas the continuation lines are indented with a tab plus an
extra space, placing them at column 9. In reStructuredText, indenting
continuation lines relative to the first line without a blank line causes
the first line to be rendered as a bold definition term and the remaining
lines as an indented definition block instead of a single paragraph.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e98308c0db382c09ce6=
98b34ca54f798ab0e3557.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
