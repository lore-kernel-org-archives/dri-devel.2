Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C432C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2877010E58E;
	Mon, 13 Jul 2026 08:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W3QndzcW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0067410E58E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:53:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FB43600AA;
 Mon, 13 Jul 2026 08:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF33D1F000E9;
 Mon, 13 Jul 2026 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783932786;
 bh=IEa1MC7QdTpeH+2xZXu8yEjRvTeCQSzy8AnMMPT17dw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W3QndzcWxg+AGWIcnE07AfX9oHJ3ppV1gciMozcAroMcoZMn0TBN8dQELMBD+X4Ti
 LT5uIsFFPmMNpKQZvx39wdDzCrk5IAgPrB6LhtMrOe8sfqNR2kVXmamqyh9ne2xB8s
 CVMyGedTyh78K8SaYSfDus6zrAnaYJV+6exNJ5lGEksfUc9y+szGWESZIpEYKw4y3C
 3j1LA2FPoWjjp2yNKgWVqzVjBgsUCk6SYlep0xkmfBqmEVPCL3De07XKuCpRFcpbLN
 otxNhGJsK/uTubOqbykTaz3wHBNV0Mw59hz6TYkB8NAlpjegQJmNwto/JRarthEzFT
 6LlJBWrbklYZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713083939.251872-8-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
 <20260713083939.251872-8-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:53:06 +0000
Message-Id: <20260713085306.AF33D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch introduces a new UAPI recovery method `DRM_WEDGE_RECOV=
ERY_COLD_RESET` (`cold-reset`) but fails to document it in the DRM UAPI doc=
umentation.

Pre-existing issues:
- [High] The `event_string` buffer used for the `WEDGED=3D` uevent is fixed=
 at 32 bytes (`WEDGE_STR_LEN`), which is too small to hold multiple recover=
y methods, leading to silent string truncation and malformed UAPI strings.
--

--- Patch [2]: [PATCH v10 2/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recov=
ery method ---
commit 683268e37f79f71da69dfdeafdea583f1453ed24
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
scenarios requiring device power cycle.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..94abe7a811a52 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -537,6 +537,8 @@ static const char *drm_get_wedge_recovery(unsigned in=
t opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";

[Severity: High]
This is a pre-existing issue, but does adding a new recovery method increase
the risk of truncating the UAPI event string?

Looking at drm_dev_wedged_event(), the event_string buffer is fixed to 32
bytes (WEDGE_STR_LEN). If a driver sets multiple recovery methods (like reb=
ind,
bus-reset, and cold-reset), their concatenated length plus "WEDGED=3D" could
easily exceed this limit:

drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event() {
    ...
		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s,",=
 recovery);
	}

	if (recovery)
		/* Get rid of trailing comma */
		event_string[len - 1] =3D '\0';
    ...
}

When the buffer truncates, won't the trailing comma removal overwrite the l=
ast
valid character of the truncated string and result in malformed UAPI strings
being sent to userspace (e.g., "WEDGED=3Drebind,bus-reset,cold-r")?

[Severity: Medium]
Should this new recovery method also be documented in the UAPI documentatio=
n?

The current Recovery section table in Documentation/gpu/drm-uapi.rst lists =
all
other UAPI recovery methods and their expectations:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
    Recovery method Consumer expectations
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
    none            optional telemetry collection
    rebind          unbind + bind driver
    bus-reset       unbind + bus reset/re-enumeration + bind
    vendor-specific vendor specific recovery method
    unknown         consumer policy
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Could "cold-reset" be added here so userspace consumers have official
documentation for implementing their recovery rules?

>  	default:
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083939.2518=
72-6-mallesh.koujalagi@intel.com?part=3D2
