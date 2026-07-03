Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E6C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102E910F7E2;
	Fri,  3 Jul 2026 12:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XKg3NE+s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF99710E5D6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6E4741A66
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F01F00ADF;
 Fri,  3 Jul 2026 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080169;
 bh=asUIZDCImopbEA17USCN5Bp2Yjq3+sttD5kvlQ4J9SE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XKg3NE+sU+7b/8f4ynImM3c4ubTzunUsFHAvNKKAJKRzViz8JHn7rqKi/9ZukRJZH
 VDuDZrZQ0gw5m9vpphp6bIbn47W9wBEMwMZ19TKpEGnXWKPgSFaf+pHxfcjuDgQODN
 jwPZSG7uZkWRREZnlTOJZiEwsRNo06YfKgZxirPWgBgzs9grjcARHRc6pSNGFgwdIr
 +8/M6vey8d948rcry9ibh9umdmZE8T4GMKPouo5MkZ1DrZD0fxhbKAojrRaiGzijhg
 oIKuvYDsKc9PYRfTIYLPGKjpMYDLAfP9WhZApR6CiZbN7spY+Dk88X3yZW/XJRuXXh
 Kn4nu8GhtfFHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:49 +0000
Message-Id: <20260703120249.6C3F01F00ADF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Lockless double-read of global ops_ptr causes TOCTOU NULL pointer =
dereference.

Pre-existing issues:
- [High] Repeated calls to devm_memremap() cause memory/vmap leaks during f=
irmware recovery.
- [High] Missing qcom_pas_shutdown() on error paths leaves remote processor=
 running.
--

commit e338489a518c55193a64126b6633cfb19d87e0ba
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

wifi: ath12k: Switch to generic PAS TZ APIs

This commit switches the ath12k client driver over to generic PAS TZ APIs
to support multiple TZ implementation backends.

> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless=
/ath/ath12k/ahb.c
> index 30733a244454e..69e21214e6290 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
[ ... ]
> @@ -420,7 +420,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> =20
>  	if (ab_ahb->scm_auth_enabled) {
>  		/* Authenticate FW image using peripheral ID */
> -		ret =3D qcom_scm_pas_auth_and_reset(pasid);
> +		ret =3D qcom_pas_auth_and_reset(pasid);

[Severity: High]
This is a pre-existing issue, but does ath12k_ahb_power_up() leak memory
during firmware recovery?

Earlier in this function, devm_memremap() is used:

    mem_region =3D devm_memremap(dev, mem_phys, mem_size, MEMREMAP_WC);

When the ath12k device undergoes a firmware crash recovery or reset,
ath12k_core_reset() calls ath12k_hif_power_up(), which calls
ath12k_ahb_power_up(). Because devm_memremap() allocates device-managed mem=
ory,
and the device itself is not destroyed or unbound during a reset, the memory
mapping is permanently leaked into the device's resource list.

[Severity: High]
Does calling this new API introduce a TOCTOU NULL pointer dereference?

Looking at qcom_pas_auth_and_reset() in drivers/firmware/qcom/qcom_pas.c:

int qcom_pas_auth_and_reset(u32 pas_id)
{
	if (!ops_ptr)
		return -ENODEV;

	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
}

If a concurrent module unload of the PAS backend occurs, ops_ptr could be s=
et
to NULL between the check and the dereference. Even with READ_ONCE(), the l=
ack
of module reference counting allows the backend to be unloaded while its
functions are executing. The same issue exists in qcom_pas_shutdown().

>  		if (ret) {
>  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>  			goto err_fw2;

[Severity: High]
This is a pre-existing issue, but does this error path leave the remote
processor running?

If qcom_pas_auth_and_reset() succeeds, but a subsequent step like updating
the SMEM state or waiting for completion fails, the code jumps to err_fw2 a=
nd
returns an error without shutting down the PAS. This can lead to memory
corruption if the driver unloads and the remote processor continues to DMA
into freed kernel memory.

[ ... ]
> @@ -485,10 +485,10 @@ static void ath12k_ahb_power_down(struct ath12k_bas=
e *ab, bool is_suspend)
>  		pasid =3D (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret =3D qcom_scm_pas_shutdown(pasid);
> +		ret =3D qcom_pas_shutdown(pasid);

[Severity: High]
This is also a pre-existing issue, but does ath12k_ahb_power_down() skip
shutting down the PAS on timeout?

If the wait for userpd_stopped times out earlier in this function:

    if (!time_left) {
        ath12k_err(ab, "UserPD stop wait timed out\n");
        return;
    }

The function returns early without invoking qcom_pas_shutdown(), which can
also leave the remote processor running.

>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "PAS shutdown failed for userPD%d: %d\n",
> +				   ab_ahb->userpd_id, ret);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D12
