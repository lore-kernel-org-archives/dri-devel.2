Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8F606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YPvWO/O0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE2E10E371;
	Mon, 23 Nov 2026 14:13:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FD110EE6F;
 Mon, 23 Nov 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795443223; x=1826979223;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=2GKxq/k7YbhUivVWtk1SlOzSltUQBVUp9OxcC58Qnqk=;
 b=YPvWO/O0dijMe5MZAqU9IGgdhwYNIfNaiyhtALMTbT0DQ/kbpobLyABb
 K24knRVgO/U+EVfJBS0nCgexh4GwKOV2TA6PF11YGcYlpvg7A9+n/hqKZ
 djdhPnephQCfOI9V90SE1Db4qN6WglvpfyIWwFK7QSz40HdW/hhnH0w0E
 /gyNrUNuD8S1cjsU6GqsXp6bHXWywb/083trTfvIyrucT5XLUzSwuEO/L
 SqpZAPQcdlHQb2LxF7hj22jonfDm4yzkq6t0jm+G+H3Kmp3B9wEyT99g3
 ry7d4QkOBw1U+7pqbCDwAtzg2TGh0INWft7llty6uO6TCJU4cpyzmwiCY w==;
X-CSE-ConnectionGUID: KcPj6jVIRU6qoKrr4+WODQ==
X-CSE-MsgGUID: ED6r8sl7Szm5/monQEFFyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4153264"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4153264"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 06:13:27 -0800
X-CSE-ConnectionGUID: GcPwZDlHRoi/fkGddv/FLw==
X-CSE-MsgGUID: aisibYTER/uKYY8we2hrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11636423"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 06:13:25 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Khaled Almahallawy <khaled.almahallawy@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Khaled Almahallawy <khaled.almahallawy@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Uma
 Shankar <uma.shankar@intel.com>, Jonathan Cavitt
 <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v3] drm/display: Increase DP_RECEIVER_CAP_SIZE from 15
 to 16 bytes
In-Reply-To: <20261105034658.18959-1-khaled.almahallawy@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261105034658.18959-1-khaled.almahallawy@intel.com>
Date: Mon, 23 Nov 2026 16:13:23 +0200
Message-ID: <6a0f46f19e49edcaaa9466114638d4495097721e@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026, Khaled Almahallawy <khaled.almahallawy@intel.com> wrot=
e:
> Several Link Layer tests (4.2.2.1-2, 4.2.2.7-8) fail because DPTX doesn't
> read DPCD ADAPTER_CAP addresses (0x000F and 0x220F).
>
> 4.2.2.1 test states [1]:
> "Fail1: Source DUT failed to read the DPCD Receiver Capability field
> (DPCD:00000h:0000Fh) through AUX_CH before link training."
>
> 4.2.2.2 test states [1]:
> "Fail2: Source DUT failed to read the DPCD Extended Receiver Capability
> field (DPCD:02200h:0220Fh) through AUX_CH before link training."
>
> Additionally, the spec [2] states:
> "The Source device shall respond to Hot Plug event/Hot Re-plug event by
> first reading DPCD Link/Sink Device Status registers at DPCD 00200h
> through 00205h =E2=80=93or=E2=80=93 DPCD 02002h through 0200Fh. If the li=
nk is unstable
> or lost, the Source device then reads the DPCD Receiver Capabilities
> registers at DPCD 00000h through 0000Fh to determine the appropriate
> information needed to train the link. The Source device shall then
> initiate link training."
>
> Increasing DP_RECEIVER_CAP_SIZE by 1 byte ensures passing the test
> conditions for these link layer tests.
>
> [1]: DisplayPort v2.1 Link Layer Compliance Test Specification
> sections 4.2.2.1 & 4.2.2.2
> [2]: DisplayPort Standard v2.1 - Sec 5.1.4 Source Device Behavior
> upon HPD Pulse Detection
>
> v3: Rebase, drop deprecated test 4.2.2.9 from the commit message
> v2: Rebase
>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: Khaled Almahallawy <khaled.almahallawy@intel.com>

Pushed to drm-misc-next, thanks for the patch.

I understand this change impacts quite a few drivers across the
subsystem, but the patch has been on the list several times across a
long period of time, and there has been no input from anyone.

BR,
Jani.

> ---
>  include/drm/display/drm_dp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index e63c7f075f54..a2a7338552e1 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1715,7 +1715,7 @@ enum drm_dp_phy {
>  #define DP_LINK_STATUS_SIZE	   6
>=20=20
>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
> -#define DP_RECEIVER_CAP_SIZE		0xf
> +#define DP_RECEIVER_CAP_SIZE		0x10
>  #define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 th=
rough 0x6F */
>  #define DP_DSC_BRANCH_CAP_SIZE		3
>  #define EDP_PSR_RECEIVER_CAP_SIZE	2

--=20
Jani Nikula, Intel
